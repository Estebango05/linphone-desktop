/*
 * Copyright (c) 2010-2020 Belledonne Communications SARL.
 *
 * This file is part of linphone-desktop
 * (see https://www.linphone.org).
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ConferenceInfoProxy.hpp"
#include "ConferenceInfoCore.hpp"
#include "ConferenceInfoGui.hpp"
#include "ConferenceInfoList.hpp"

DEFINE_ABSTRACT_OBJECT(ConferenceInfoProxy)

ConferenceInfoProxy::ConferenceInfoProxy(QObject *parent) : SortFilterProxy(parent) {
	mList = ConferenceInfoList::create();
	setSourceModel(mList.get());
	connect(this, &ConferenceInfoProxy::searchTextChanged, [this] {
		invalidate();
		updateCurrentDateIndex();
	});
	connect(this, &ConferenceInfoProxy::lUpdate, mList.get(), &ConferenceInfoList::lUpdate);
	connect(mList.get(), &ConferenceInfoList::haveCurrentDateChanged, [this] {
		invalidate();
		updateCurrentDateIndex();
	});
	connect(mList.get(), &ConferenceInfoList::haveCurrentDateChanged, this,
	        &ConferenceInfoProxy::haveCurrentDateChanged);
	connect(mList.get(), &ConferenceInfoList::currentDateIndexChanged, this,
	        &ConferenceInfoProxy::updateCurrentDateIndex);
}

ConferenceInfoProxy::~ConferenceInfoProxy() {
	setSourceModel(nullptr);
}

QString ConferenceInfoProxy::getSearchText() const {
	return mSearchText;
}

void ConferenceInfoProxy::setSearchText(const QString &search) {
	mSearchText = search;
	emit searchTextChanged();
}

bool ConferenceInfoProxy::haveCurrentDate() const {
	return mList->haveCurrentDate();
}

int ConferenceInfoProxy::getCurrentDateIndex() const {
	return mCurrentDateIndex;
}

void ConferenceInfoProxy::updateCurrentDateIndex() {
	int newIndex = mapFromSource(sourceModel()->index(mList->getCurrentDateIndex(), 0)).row();
	if (mCurrentDateIndex != newIndex) {
		mCurrentDateIndex = newIndex;
		emit currentDateIndexChanged();
	}
}

bool ConferenceInfoProxy::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const {
	auto ciCore = qobject_cast<ConferenceInfoList *>(sourceModel())->template getAt<ConferenceInfoCore>(sourceRow);
	if (ciCore) {
		if (!ciCore->getSubject().contains(mSearchText)) return false;
		QDateTime currentDateTime = QDateTime::currentDateTimeUtc();
		if (mFilterType == 0) {
			return true;
		} else if (mFilterType == 1) {
			auto res = ciCore->getEndDateTimeUtc() >= currentDateTime;
			return res;
		} else return mFilterType == -1;
	} else {
		return !mList->haveCurrentDate();
	}
	return false;
}
