Return-Path: <linux-btrfs+bounces-17677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF0EBD1EE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEF53C1B1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67492ED871;
	Mon, 13 Oct 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hym4LBML"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209472EBDE0;
	Mon, 13 Oct 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342896; cv=none; b=gLFXtpOW9CQ6s6oUKOXc0YsxbPWul6OFYd396OyoCj2S2RNLh2tCKAIi1sJQySR/HXFeXHDj3ZR3+45Yeq+zBfWdjNzZ/1Fq2eYltgN+tcL4EuYBKDUFJRTvZwaKv5A68s17tOny/C/6TLKWE88YfI2b3lRAXIUmgKAjqWUBBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342896; c=relaxed/simple;
	bh=0iIpRE76O8pDy+Un3JbjYRsQyn+glO04MaeIRMK7dPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jphK5apnklVR2vbOKSh2JlOQx7VdYNMJ8/N8mKAAXYYXg1B//kbM9guAvMRRgC2dOJyhGCX9CW3IwtNPylswd6MSBhSOZjv63aL1BM2PYZyprTgKhnG64fJwIO1qOUGJF00Vm4nRZtqiLXVcK215x2jTEbaESUsfqTwV/3OAqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hym4LBML; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760342892; x=1791878892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0iIpRE76O8pDy+Un3JbjYRsQyn+glO04MaeIRMK7dPQ=;
  b=hym4LBMLbgdJmYvGVPlZF8/LVEEXsUytkh+7dzr2h4ZAbAjX5+21yVEI
   HoICQGCDGwy7C34lFQTBd14sa7smrOt/j1vke0KkEiW6/LhbBOxyA5K6U
   ImQMljaxetKUszu0C9fzZLO4wtox4wejzUKK4OGaOKhwD1fOcyycoKnjU
   6Dru/fvdhcymPkypcCn7alvXPRWT0BeO0XZPZnXXAfFwwnmoB7jGuRMp0
   FrVT2i8XGwgKkdrcwkhUuMfoyyS9EfjwZml6I8QC3yp16T/d7vPzAdr9g
   w6XvQZGm958yx1davXIH0c4YkMjNsYrfb2K8qDFZiWQeBOYc5h+sQ+7dv
   w==;
X-CSE-ConnectionGUID: g3E71TjZSKmzVc1pn1P03w==
X-CSE-MsgGUID: fGTqCREdR5aYk6jl9osPcg==
X-IronPort-AV: E=Sophos;i="6.19,224,1754928000"; 
   d="scan'208";a="133101995"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 16:08:06 +0800
IronPort-SDR: 68ecb366_rLjq6Sk+O4zhsajwGCa+ShwUhEKV4h090mP30UxmEgEN4iH
 PDBlGSK8/LHzkHKWXcjjvW7YIwQVRPvk7tzdWWA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2025 01:08:06 -0700
WDCIronportException: Internal
Received: from chnhcln-775.ad.shared (HELO neo.fritz.box) ([10.224.28.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2025 01:08:03 -0700
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
Subject: [PATCH v3 0/3] fstests: basic smoke test on zoned loop device
Date: Mon, 13 Oct 2025 10:07:56 +0200
Message-ID: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
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


Changes to v2:
- Add Carlos' Reviewed-bys
- Add a _find_last_zloop() helper

Johannes Thumshirn (3):
  common/zoned: add _require_zloop
  common/zoned: add _create_zloop
  generic: basic smoke for filesystems on zoned block devices

 common/zoned          | 37 ++++++++++++++++++++++++++++++++
 tests/generic/772     | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 3 files changed, 88 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

-- 
2.51.0


