Return-Path: <linux-btrfs+bounces-17915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD45BE67A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 07:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C85294F9834
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 05:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757730EF90;
	Fri, 17 Oct 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ApJev+/k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFF30E849;
	Fri, 17 Oct 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680217; cv=none; b=ICAGpcl78PR401nGBv26ioOwcVc1lPQWnApNbPk8kUMcjrcgjsGczOloI0Rx5ubZyrKk/BLwaN1SCgjdq4Ie9SnB4jYWeyIvFMiT9LL04CLSLTDTVF7spbUVc/zsT0dGGsxAXn33TN5nZ1RxQxitOeb5OAvSr5G2uabbZAyAilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680217; c=relaxed/simple;
	bh=K5T4P0UDbzgZVIvGEnr55Kscac/atpeISKmUwOuTnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuX34uw2yU6BLYSmRpKIfIx8FoPFf/K7MLnLcOrfmTRUuSpt1ndGz7a5TZWMbRbZ7qd46oOAYzoo/UzgI2eDd07NMn45lgN4IyFNEzXbeXX3qm2Qq7nfVvoH7FGnRAR4iuP6ty4dBKXNLpNsDA8o73nhbpJqzGhzPHS0xsfGPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ApJev+/k; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760680216; x=1792216216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K5T4P0UDbzgZVIvGEnr55Kscac/atpeISKmUwOuTnlU=;
  b=ApJev+/kRHm7T6nZ+ExuhoUSqmN2vJSaGze3920tQuFtX2Ch0X8IqtcA
   3mmv3GC6zMyQ2zei62CD0nC4wyVSBwzYuTdL4ICxNrXBbm9vXiS5LKjOb
   5Ir87yAQTBBQDegztaGBkbu98vafP03PPAOQVwQ+EuJ1vvZUf91R8Oz5X
   zUQIgtJ7tmu2tt3kJigM1EGf600LBE7XAo/RrLcGYGLu8AYEcVmeLGVZP
   rnY6lmRWIj3RuCPxhT4B7D7lB1ywOhWHTdzDh5SzkHEAm4Jers+gO+Ife
   Z3BmRCRTxQU9LYwVAFWImqSjHRGOykq3VkEbYcyCzZDgvwlcD98His28G
   g==;
X-CSE-ConnectionGUID: zR+YgSYMSzKhNQyTDeBHXQ==
X-CSE-MsgGUID: C5nAGqL9SgSFrMKgAswAzg==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134338855"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 13:50:15 +0800
IronPort-SDR: 68f1d916_XFR0ICCp2cXxTXx5npILiQpuZRcrIqYNIkRoLIi+VFRi8Gw
 aJHtXSDM4x0M79DEUgSuqLyNfH3OU3R1zF6wM4w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 22:50:14 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.41])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 22:50:11 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 0/3] fstests: basic smoke test on zoned loop device
Date: Fri, 17 Oct 2025 07:50:05 +0200
Message-ID: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
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

Changes to v5:
- _fail in case zloop device creation fails
- Collect Reviewed-bys on 3/3

Changes to v4:
- Find next free id in _create_zloop
- Add _destroy_zloop
- Fix typo in _create_zloop documentation
- Redirect mkfs error to seqres.full

Changes to v3:
- Don't mkdir zloop_base in test but in _create_zloop
- Add Christoph's Reviewed-by in 1/3

Changes to v2:
- Add Carlos' Reviewed-bys
- Add a _find_last_zloop() helper

Johannes Thumshirn (3):
  common/zoned: add _require_zloop
  common/zoned: add helpers for creation and teardown of zloop devices
  generic: basic smoke for filesystems on zoned block devices

 common/zoned          | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772     | 43 ++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 3 files changed, 106 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

-- 
2.51.0


