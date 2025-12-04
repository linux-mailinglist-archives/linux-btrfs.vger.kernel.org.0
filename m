Return-Path: <linux-btrfs+bounces-19519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF1CA3A4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 13:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701DE305B922
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9933C1A8;
	Thu,  4 Dec 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qcfu5/h6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC672E8B8A
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852225; cv=none; b=HTa9LdOzsp5yaEdjswfXyesBDYdJI3mBM1JoQI59unDwh6p0OHZUXKN1DWgBwYTGuN3+lEGrgwtb3k838r+vQ+cUxGs7oVeQOvRux3XP8BD4FWDROOmkb93+6ecC8YZOamsDTAtpbW2jvoShGUwdxntZb22FXNnVeZUu/R7ZVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852225; c=relaxed/simple;
	bh=OonSdBpUkQIOcvttVB8yVSRfibcSi8+UnqllSgkkO+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rd8cRlrRNd0mAEG4eF06Uq7bDK1+n6JEWoiS2b3glwxRFh81DYO20EvKCfOSOvq6VB3UOzhAq2z6sJlNol7VUSJOkGE6AOWpqQiqjhPlVwCYo3Yl8bvNz0VHnwpNjvsm1xgVgJfcHLMaylpbOgTeY0ZYnAOj66p7KYcAyderqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qcfu5/h6; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764852223; x=1796388223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OonSdBpUkQIOcvttVB8yVSRfibcSi8+UnqllSgkkO+A=;
  b=qcfu5/h6K2z2CVBk6rjsT9psOt8tx5AXoDrMQnEjgHoQRQ2j2NymRC68
   +FUt1YbPzQQfb9EdM8QAj2Cpj25P/VX9q0Lb1T2yIVgHfC9/ei9wOwudo
   MdRXtiIx1cbbnMGmbMT/6VwmLzwC4Cpfph4dzZXxN3xiXisKShloR6k/S
   QIe+jLRjyHHKSVHDt1foTNYDavBEz2nm//f1X38k7X0OnImKYzVkwHuBi
   eS71Br5KXhwHsCQewBqo+mNjfC7lGYNW7DBPMoY1KemvyYQdqEchVpgLb
   SacDaJQHoOKAdQQ4W/xjEuA9PmWupvn23tlbELG31PClubveHSL+EiOxp
   g==;
X-CSE-ConnectionGUID: rwNc0sBFR8y2H9lmrdbrCA==
X-CSE-MsgGUID: oH+ZPaQqRGOvXKMLwF0ukw==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="137266126"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2025 20:42:34 +0800
IronPort-SDR: 693181ba_1xf1j/uIWUCInMQcf7LQEAl1k4ywMLPygPSEKtqXCuL5g/x
 BtPLtBkJ9MjG5Sefrbq7BrmAtd2Aq5otwkvL1Ig==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 04:42:35 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2025 04:42:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/5] btrfs: zoned: don't zone append to conventional zone
Date: Thu,  4 Dec 2025 13:42:22 +0100
Message-ID: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When in a zoned mirrored RAID setup a block-group is backed by a
conventional and a sequential write required zone, btrfs will write the
data using REQ_OP_ZONE_APPEND. As this is illegal an ASSERT() in
btrfs_submit_dev_bio() will catch it beforehand.

Fix it by only setting REQ_OP_ZONE_APPEND btrfs_submit_dev_bio() if the
actual zone is a sequential write required zone.

To avoid multiple block-group lookups, cache the ability to use zone
append in btrfs_bio.

Afterwards convert the sprinkled booleans in btrfs_bio into a 'flags'
member and set them accordingly. This is deliberately done after the fix
to ease potential backporting.

Changes to v2:
- Rename to can_use_append
- Add patches to move booleans into new flags member

Johannes Thumshirn (5):
  btrfs: zoned: don't zone append to conventional zone
  btrfs: move btrfs_bio::csum_search_commit_root into flags
  btrfs: move btrfs_bio::is_scrub into flags
  btrfs: move btrfs_bio::async_csum into flags
  btrfs: move btrfs_bio::can_use_append into flags

 fs/btrfs/bio.c         | 32 ++++++++++++++++++--------------
 fs/btrfs/bio.h         | 24 +++++++++++++-----------
 fs/btrfs/compression.c |  4 +++-
 fs/btrfs/extent_io.c   |  7 ++++---
 fs/btrfs/file-item.c   |  8 ++++----
 fs/btrfs/scrub.c       |  2 +-
 6 files changed, 43 insertions(+), 34 deletions(-)

-- 
2.52.0


