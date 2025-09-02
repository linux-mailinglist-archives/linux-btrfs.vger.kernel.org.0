Return-Path: <linux-btrfs+bounces-16572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A37B3F3C8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 06:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D5E1A85108
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 04:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9620FAAB;
	Tue,  2 Sep 2025 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o+I9L+kW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D1AD5A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787412; cv=none; b=XG5hDmrR8HXxd1/i2Ieo1+QXbz8kTnkFklHUan3s+7L1Q0TN8kfc38pnV5d7tHrqaWo8r7i78aLJaivtam7vA8oA5j9JvdYA9nluz+lD7L/KFLqJda0h6Nhcfi+Dr20Kf91dousoJyIrHb6l6N63HrJNaK8kKbtX8d8Kp1F+UEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787412; c=relaxed/simple;
	bh=touCn7JFI+KX/0WSd8OT4A56yju/1mbfSMuQtDMp2PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHm/klxgKbV1bj8ctoVj22ck4/shrKmhfUhk8mWs48N6VCt33i+XwCPlSwVDK0QNx7kZtK5fQEuyfsdjvM+GZEUJ4Odqa+3rxBAZx5e3CB30vbrNTIBM1+EgGPzyE7iPmJ1vtRiKrN72uiC06AFfybWKHD5QDoPcOBfhhPse7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o+I9L+kW; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756787411; x=1788323411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=touCn7JFI+KX/0WSd8OT4A56yju/1mbfSMuQtDMp2PY=;
  b=o+I9L+kWh+lMGtNVVgAyZlX3AIebiuSwsK81zr2Nj1BxiC+Y0kRt4lr0
   svsFqCpWF7HJn1R5tMiHNdxTjSB+NmvIJBc+FMb8yxyHv3uLpmZbYRV3Z
   PoQ9HJjj/bfbgZ/IN6ASZ2hycBmtKAqCi7h8sh7snlZ+s88TxPD0gh2QP
   u3Sxv3dmymvv/KCyct0mSb9nr/UuxAQvx2lFRwoH2lj5giJzgyEODw0+V
   VYLjbRIV92ubowA3+hfjRYQGGuLnu/KyMhNyO7lPRTwurb2BpBcDL4g3S
   hV2Iqnd5qVPNYORrPCFVI0kdP6ZR8KYlhpbjmk3dPVs9CtZ+n6FWT5uwl
   g==;
X-CSE-ConnectionGUID: 8vJygN+nT/+ewUadJWTx1g==
X-CSE-MsgGUID: oK6A0ajuThCvdMdv7AOBYw==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="106426372"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 12:30:10 +0800
IronPort-SDR: 68b672d2_zsu3NOU0o95w7APZxHcWXUcJfRnxdLIQOElukwNfTXenwra
 VheuHDHUrVrHEu3DJ/rN1OzlhTb2mOmkzvbu6Ig==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 21:30:10 -0700
WDCIronportException: Internal
Received: from wdap-uxdzwi0ixx.ad.shared (HELO naota-xeon) ([10.224.163.20])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2025 21:30:10 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] btrfs-progs: tests: add new mkfs test for zoned device
Date: Tue,  2 Sep 2025 13:29:17 +0900
Message-ID: <20250902042920.4039355-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new mkfs test for zoned device. The test is based on
mkfs-tests/001-basic-profiles, but uses nullb devices instead of loop
devices, to set a zoned profile.

Two preparation patches are necessaly for the test case. The first one
fixes the error handling of _find_free_index(). And, the second one adds
wait_for_nullbdevs and cond_wait_for_nullbdevs like the loop device's
counterpart.

Naohiro Aota (3):
  btrfs-progs: tests: check nullb index for the error case
  btrfs-progs: tests: add {,cond_}wait_for_nullbdevs
  btrfs-progs: tests: add new mkfs test for zoned device

 tests/common                                | 14 +++
 tests/mkfs-tests/039-zoned-profiles/test.sh | 98 +++++++++++++++++++++
 tests/nullb                                 |  3 +
 3 files changed, 115 insertions(+)
 create mode 100755 tests/mkfs-tests/039-zoned-profiles/test.sh

--
2.51.0


