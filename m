Return-Path: <linux-btrfs+bounces-14294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8CAC7B37
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 11:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAA34E1530
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975B26C39F;
	Thu, 29 May 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UqQxnaly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50026B08B
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511515; cv=none; b=KKx/UbX6VxgUeXuQBFT9RfTx4Z5t5mpyWIhp93HFKx2525BoRqcKjjDoEK9xM8Bvcz9Uico/sKSJM7DMNMnViJA+QWiGPOMJG0uobuW4MEnE0xTyP+sam32pBJdesJoxleB3mHUghLZzDPSAkzbUOoCb7ZwYm/JR4c2WiezxnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511515; c=relaxed/simple;
	bh=QuLRCzI+xepkYJA8CsII67ZyG8sZBpi/BCd/LiTaRJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3q4rSSF6SSbe3mPNMLqS92nvEzSLouIsAqGVnmDVWkDhnOB930BNCcKypR1f/neULgGK1dim1jljfhzcnfd4FNU5iwzLyq9Blj1kx4Rz+RRdg0A6RRwYY6XPrtcyB6k+fGVvb9hYFVVNtllvGc0YBc7BANDeZ3GOCE5pnvb0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=UqQxnaly; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T5q3Wn018501
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 02:38:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=o7pLipVuhjp56IUGlWjBrpg
	nK0FhrTzGnDMK9pW+EFs=; b=UqQxnalyL83RFHqgt9gn4D0qHqG8evUSNUlKjRa
	H6s7pA3oPOIBeQO1XrnTvYbN8uiT6stqSc8UP8fO0ucO+gBSrvPb2IQ/2VU8XsHL
	HMYBk1NxP6xnEOCVGNS+SX78acpKUggE2tRomi6pXtrZqyM2n+SGdeCS2wEYzncC
	C02w=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46xhf590tg-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 02:38:32 -0700 (PDT)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 29 May 2025 09:38:30 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 70CFAFA59372; Thu, 29 May 2025 10:38:23 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: update superblock's device bytes_used when dropping chunk
Date: Thu, 29 May 2025 10:37:44 +0100
Message-ID: <20250529093821.2818081-1-maharmstone@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA5MyBTYWx0ZWRfX0E+El2kgjd+a X/OPWsaKCrZITxsmN2GXwhRPYwm3Z3rMB7iTM4L6sfPgBmuQJC5fvdsY72PNHcKAJUkscLNclFk eCJ67e13OmhzcHX8zrzfoI3rOg3fHLuMHqYSBIP6muWgfcALdAZu1r1bMkB5tySgsSO6MSuK5Lj
 /24qXX6k8Wg2g7kBhe3qYNAVQ9EPAwpUQj8ueYQPWmKSZ8DplYdomdxZ/0eZQ+EyPvVWlXfGo7+ yvWUa47goxLfcGS5ARR0YHwWtv72qAGI/eGC/qijKj8OSOC/R6Ry8RaC2yK/FiSEBdZoOoFCyiQ G0u/3ImG9TK4thL+rtPgfjRKy0K+t7vgki5pZsprdThyif/eaR6fVyUSnAuWcIoeJ4s2+Dxpa56
 mG1W9tMzwc5oSdXg8fgpZJceYFq/FgFBNJzAKMoD5ExzA3Mr1+LtnFdVG9VWJEPpgvuxzO42
X-Authority-Analysis: v=2.4 cv=HuZ2G1TS c=1 sm=1 tr=0 ts=68382b18 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=FOH2dFAWAAAA:8 a=C-EYRJYFLGgEkVn7TJAA:9
X-Proofpoint-GUID: CtpNVSkCxxPAAPYPB_C4ajXEohbH5Rl5
X-Proofpoint-ORIG-GUID: CtpNVSkCxxPAAPYPB_C4ajXEohbH5Rl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_04,2025-05-29_01,2025-03-28_01

Each superblock contains a copy of the device item for that device. In a
transaction which drops a chunk but doesn't create any new ones, we were
correctly updating the device item in the chunk tree but not copying
over the new bytes_used value to the superblock.

This can be seen by doing the following:

 # cd
 # dd if=3D/dev/zero of=3Dtest bs=3D4096 count=3D2621440
 # mkfs.btrfs test
 # mount test /root/temp

 # cd /root/temp
 # for i in {00..10}; do dd if=3D/dev/zero of=3D$i bs=3D4096 count=3D3276=
8; done
 # sync
 # rm *
 # sync
 # btrfs balance start -dusage=3D0 .
 # sync

 # cd
 # umount /root/temp
 # btrfs check test

(For btrfs-check to detect this, you will also need my patch at
https://github.com/kdave/btrfs-progs/pull/991.)

Change btrfs_remove_dev_extents() so that it adds the devices to the
post_commit_list if they're not there already. This causes
btrfs_commit_device_sizes() to be called, which updates the bytes_used
value in the superblock.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/volumes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e59aa0b5c4f3..ee886dc08d15 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3272,6 +3272,12 @@ int btrfs_remove_dev_extents(struct btrfs_trans_ha=
ndle *trans,
 					device->bytes_used - dev_extent_len);
 			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
 			btrfs_clear_space_info_full(fs_info);
+
+			if (list_empty(&device->post_commit_list)) {
+				list_add_tail(&device->post_commit_list,
+					      &trans->transaction->dev_update_list);
+			}
+
 			mutex_unlock(&fs_info->chunk_mutex);
 		}
 	}
--=20
2.49.0


