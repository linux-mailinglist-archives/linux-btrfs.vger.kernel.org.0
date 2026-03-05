Return-Path: <linux-btrfs+bounces-22245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NO9Au1VqWng5gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22245-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 11:07:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A726520F666
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 11:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34BF4301A9D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1637CD2E;
	Thu,  5 Mar 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qjqM5PY7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82EA37CD52
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705219; cv=none; b=q/uF0N6wpbd3NwclcC78KkUHMmKSZwP4paAAHFHe8+8Ut01b0UhzjTZSTqSv8+LYMChCOupzE2UfAGWyCmhS0hUH9RYCgJ2z86QpPoOmaP8rpmrSY4/ncYwzM2wC3sOud+NLtm0TuNSUXQY+RyTltBCeR/FeE7anABSl/B8hlo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705219; c=relaxed/simple;
	bh=phgYFZ7KuX1vkinmiVk/DklMKu3bsDZJstFTFfGiFmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aV3RC5lpdVICuNQN33kFiqzInee1Lcu/utqAbdwcIwBF5ElJN7+04V5RgSKlwejjpGXjYvEORNxEspSIvIUYL16Jwg6GqTB2RAkwTdBGpbjGT8RN1bXWg5nfKyi9GbGbpN1J9huEaooQxk63wkIbV8BCjs+CSBzf5n9wjBnGqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qjqM5PY7; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772705217; x=1804241217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=phgYFZ7KuX1vkinmiVk/DklMKu3bsDZJstFTFfGiFmk=;
  b=qjqM5PY7xvhDc5IpLy3R/qxwa+knKWaApgb1Q58dqavuM77TTokWwjZ2
   D8D3D/tIEffv65Z8nBZYlZq6paKhmH+TavNb+NhZgZG4pmvZy9lrwdbJH
   1BsU/8We+Kywe1WV+sbDwLAaAUPsi95S7v6Cvnhhe0yfuIx1KSaO/B6Aw
   F9FsOP8rhrgssOsNjmmVOft+wL7/2bshU2MX9VcOMtb08IoRoo+gAgy5F
   mIFApQiQFDRBh48Y1r/iQ/IYFbtsX/JFhXl2jNI0hxwOj+zxLim7Xgzie
   uMe7rF79NeNjDqgTcUDgBVbmYtlMtp68O3l780dY4t6el12lHO7e6ffnj
   Q==;
X-CSE-ConnectionGUID: qW5SFPxyR6mHsil8k0KPeg==
X-CSE-MsgGUID: 9m1UTf8xSqiE9pZI2fL+7Q==
X-IronPort-AV: E=Sophos;i="6.23,102,1770566400"; 
   d="scan'208";a="138339192"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2026 18:06:50 +0800
IronPort-SDR: 69a955b9_ZDVJSxrhTWeSHtClXITnVqEbKL9F5fAapQ6OFp3nu1F/GJf
 mXQOU103cgPVW7EyTK8kUKrT62dRQp37fGMeQsg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 02:06:50 -0800
WDCIronportException: Internal
Received: from wdap-bnfcsfsyyt.ad.shared (HELO neo.wdc.com) ([10.224.28.182])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Mar 2026 02:06:48 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Boris Burkov <boris@bur.io>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/3] btrfs: zoned: fix hang with generic/551
Date: Thu,  5 Mar 2026 11:06:41 +0100
Message-ID: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A726520F666
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22245-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Running fstests generic/551 multiple times in a row reproduces a hang with
zoned btrfs.

This hang can be caused by long reclaim sweeps und system preassure and
then flushing the block-group reclaim work. Mitigate this issue in two
steps:

* First create a syncronously executable version of
  btrfs_reclaim_bgs_work() in patch 2/3

* Change this synchronous version to accept a limit parameter, so we don't
  run it off for too long and then call btrfs_reclaim_block_groups() with
  a limit of 5 block-groups (this limit was arbitrarily chosen), this is
  done in patch 3/3.

* Patch 1/3 is a small refactor of btrfs_reclaim_bgs_work() extracting the
  reclaim of a single block-group into its own function, to make it a bit
  more readable.

Changes to v1:
- Fix spelling error in 3/3
- Only increase recalaim counter if reclaim succeeded
- Applied Damien's R-b
Link to v1:
https://lore.kernel.org/linux-btrfs/20260302143942.115619-1-johannes.thumshirn@wdc.com/

Johannes Thumshirn (3):
  btrfs: move reclaiming of a single block group into its own function
  btrfs: create btrfs_reclaim_block_groups()
  btrfs: zoned: limit number of zones reclaimed in flush_space

 fs/btrfs/block-group.c | 273 ++++++++++++++++++++++-------------------
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/space-info.c  |   3 +-
 3 files changed, 149 insertions(+), 128 deletions(-)

-- 
2.53.0


