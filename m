Return-Path: <linux-btrfs+bounces-12385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 460ADA67882
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5919189E187
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108302101A1;
	Tue, 18 Mar 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="J/egp7Hp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5120F091
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313430; cv=none; b=kOHPKAt2Qg4tXWMlEsQ73y6eYvDel50++5pq4g5un7M3uf4BuSYhsLmGizPBX+sy3vLEYCyEBtB9yOpns38XXT5WFtC8o873i8ckJC9hYCo6CDzIh+AhU8Shnlx+ykVrSs+07LnRpnJLPyZ4kgHuh1jU2ANlKRKR90xd+6I4wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313430; c=relaxed/simple;
	bh=qE+oCHNXK3IYdZS80/ne+0xIKx4Qq3GX4ciXz0SCb7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BCDvpR95P6ByVkKfhLaDyIWMEkH64JRtCbTaxgVqnQT17bogSvV5dSGXLTgp6LvsuJYeC/DPLFKFo6/iU/dVpr96IsLBq7ld8w2RTFtCFW0n323g4dIRaDzh6+ORajWIb3mLddymuGIxJ26RCltjYG8WCas8Ji5scaP8Q41A0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=J/egp7Hp; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IFpQPd030530
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 08:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=TAqBdAwEjJgdR+gTZ+rwh0S
	2R7TIP88zKuB5rH+pkK4=; b=J/egp7HpDSBSow0mGyRkInK2LYymGIoFBX6D4QR
	MFz7jlqfMWD7JP3J5lH2pK33eZg//omjCkmpBdiUIHNoMZ7mx8O0KeJHHa2Y5W7g
	396Pe33xvdT7g+7K1AAn+YPPKTCjVc5T2jBAcKZh1bTZdPqhX9mQ8v61AVZrQLv5
	I7o0=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45f3pyv3rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 08:57:07 -0700 (PDT)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Mar 2025 15:57:06 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id CA628CC6245D; Tue, 18 Mar 2025 15:56:59 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: remove call to btrfs_delete_unused_bgs() in close_ctree()
Date: Tue, 18 Mar 2025 15:56:56 +0000
Message-ID: <20250318155659.160150-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: N5DfjhVHRFziZM9fXLQZkqHJdXk961tI
X-Proofpoint-GUID: N5DfjhVHRFziZM9fXLQZkqHJdXk961tI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01

btrfs_delete_unused_bgs() returns early if the filesystem is closing, so =
the
call in close_ctree() will always do nothing.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/disk-io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1a916716cefe..7c114d5d0f77 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4412,12 +4412,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_i=
nfo)
 	btrfs_discard_cleanup(fs_info);
=20
 	if (!sb_rdonly(fs_info->sb)) {
-		/*
-		 * The cleaner kthread is stopped, so do one final pass over
-		 * unused block groups.
-		 */
-		btrfs_delete_unused_bgs(fs_info);
-
 		/*
 		 * There might be existing delayed inode workers still running
 		 * and holding an empty delayed inode item. We must wait for
--=20
2.48.1


