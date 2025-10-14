Return-Path: <linux-btrfs+bounces-17767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD411BD840D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 10:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279AC4055EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08128C864;
	Tue, 14 Oct 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X8G3GmS5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC651B4156;
	Tue, 14 Oct 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431599; cv=none; b=OEdSFSwUD4WNMO+4BCRUIaUUh5cGQMfGbwv8ycpOISec0E09dGEOWbeCyYrW+nergI9K2bVpurVLaUhuagwVWo2FX2luGXcAbnYVedAxESFWfMITzPDRJ9HhpJv2HesCuYCFRzKpv2IeqrxloqEZD495wdleweV7UyHu46RC/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431599; c=relaxed/simple;
	bh=XbFD7eihhqvlbCCr/QjSXGm095ZcFYLdmYv0mEax7oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICSmvY2fmtawwlsoImkMECfTvezZX+fU05EiYeE6LQOI3spNsPgEKSda3rcGEG2r8ucv5RgKg7Dk/pJzX4H16qY34czFaK21BMtSwI6ixOMIRwEFegNgZFBLqU2RG4hlir6hLwsPSo+J7Y0lYbtgO6LXSdbU0XSTj7OLkCfeEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X8G3GmS5; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760431598; x=1791967598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XbFD7eihhqvlbCCr/QjSXGm095ZcFYLdmYv0mEax7oc=;
  b=X8G3GmS5K15fnePMgG4JU52T82dgfwC2GltVI9UJUnPtSBvc8Sj0BnIa
   uJ4cNSOIz6P1FEjNvphPUs9Y/Hvmw6ppUrrA42puZXnYDMvng8st28dDQ
   U81YdIHiTa+Qju8TBnZaFWjXOTcdQJdeHxOKJXq1xw6MFbHQyzav8s+kr
   N+gowMw/rcZ/WXE+TSDsQrKYIZsAW+SGQvZ97B37KLqIJNkubCOORclp7
   hx1VFnUawjjKQ9zyJSzil50kJJlHuflxuXwynBe1qPbNAI4gTeA0dSWpP
   l3J1vHuHDz6sem6ouoidc0ikHz39Rb/qHhGaFMyjX5rnUKKFqOlC5ziBY
   A==;
X-CSE-ConnectionGUID: B1i6iEEZRayVY0aB3zfwkg==
X-CSE-MsgGUID: 8Yj7uRw+QEu9oOzVlK6lrA==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="130180107"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 16:46:31 +0800
IronPort-SDR: 68ee0de7_+xxAIORo/p+iegFkSfUV48ZIiijbbPzJj3APcDnl1aT8Sf2
 pOvqLtJmCBi5ftB4DPYXf6X8UU1Dlvn4cFNiPbQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2025 01:46:31 -0700
WDCIronportException: Internal
Received: from wdap-pnj1f24hc3.ad.shared (HELO neo.fritz.box) ([10.224.28.28])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Oct 2025 01:46:29 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/3] fstests: basic smoke test on zoned loop device
Date: Tue, 14 Oct 2025 10:46:22 +0200
Message-ID: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a very basic smoke test on a zoned loopback device to check that noone is
accidentially breaking support for zoned block devices in filesystems that
support these.

Currently this includes btrfs, f2fs and xfs.

Changes to v3:
- Don't mkdir zloop_base in test but in _create_zloop
- Add Christoph's Reviewed-by in 1/3

Changes to v2:
- Add Carlos' Reviewed-bys
- Add a _find_last_zloop() helper

Johannes Thumshirn (3):
  common/zoned: add _require_zloop
  common/zoned: add _create_zloop
  generic: basic smoke for filesystems on zoned block devices

 common/zoned          | 43 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/772     | 46 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 3 files changed, 91 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

--
2.51.0


