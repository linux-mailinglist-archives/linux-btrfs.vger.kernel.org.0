Return-Path: <linux-btrfs+bounces-18159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A121EBFB280
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B081A01CCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14B314B82;
	Wed, 22 Oct 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XVZOgTB0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854A26CE2D;
	Wed, 22 Oct 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125241; cv=none; b=JwAABPFf/sSjONxmi3JMDJWx9dR7dbG571Qm8gslrgCk/sk0X7vwLp7KAAMawKDkcdG8sOz/ZppHM3jHUy/gyPaoNZZu5w5blzLGyaI9PSuqYn6sn6M7bSC14P48kV/E550ulTWxZpSqmIZXzkUAOiVoQknAp/otOfFUkXDdAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125241; c=relaxed/simple;
	bh=u7dma+hjo2EjrNuKxoKuabYGpUo7lXaXLVOqB0X08+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQu4Vno/HsNtqtn2Aoc4WgVihzolyfdilmOgbFQAjhrU/nz46bDc+qgfpVK9+jTeety7gFr1a/5yQLWyMqPtWz0fvng+hJyfKe/HRUDb+Pm19qo5uvbmVveKjdDEpnd0qbEM1f9tszLx5+KheTc21BPzWgXSE16coYCouG0ocSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XVZOgTB0; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761125240; x=1792661240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u7dma+hjo2EjrNuKxoKuabYGpUo7lXaXLVOqB0X08+c=;
  b=XVZOgTB0ePrQU0M4aQNmKy4h1KOQizUW+/xwtXddUXUgYxNhq9jrdoIx
   vdecA/2plGBHZBYbZVaTW9J7FwQ2X9jRnNvdq+YYNatTvKHNO3tuwjjEm
   tt7sSE6vZA1w8ICiDzinSsRyP9B0yUPj/BIrR5nkQybEpG6t3cB0XYclS
   MsnC+H0EmLmNkTbCwuep7Yok+2s5SSak0pTrpog57Q3zxretE9TxpkKGO
   /lb21MhkW36p1j8ZSKYvcUb7st2PzFi4QaKLnSr9/X15R6Ke9Olns6PPc
   9K63hCIu7BiDd73W0TY+G4IJHXFKF2pw0UpyWeKJ9/krQU3/I3YSoSlgI
   Q==;
X-CSE-ConnectionGUID: cF+hYDkKQMegbY1Tuwlxjg==
X-CSE-MsgGUID: fkJx2TjwRe6a+azdxDlV6A==
X-IronPort-AV: E=Sophos;i="6.19,246,1754928000"; 
   d="scan'208";a="133356597"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 17:27:12 +0800
IronPort-SDR: 68f8a370_v88tUaS7GL0zZJ01T7SQDIJE5uhqkVL2N11MLyMAokcRCbq
 RkjvT4/ghvfc+8dr3zru1VgEe7Gn3BUxgSRnuKQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:27:13 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 02:27:09 -0700
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
Subject: [PATCH v7 0/3] fstests: basic smoke test on zoned loop device
Date: Wed, 22 Oct 2025 11:27:04 +0200
Message-ID: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
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

Changes to v6:
- Make 'id' local in _find_next_zloop
- Add _require_block_device in generic/772

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


