Return-Path: <linux-btrfs+bounces-5848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A691093E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CB1C20CB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B981AED4A;
	Thu, 20 Jun 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CEsEn+Mb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3571ACE94
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895923; cv=none; b=AXQ0coRaiJOAIFSvdqQs7v346JtROPttoAPPFo9Vwrf77kzyo/BazLb/OJNk7faYctK9/P7TuLs5GPLRYJnwkFF4bXWkJZnBFfuL4PBIELpu03OBgrv3i+mNUQAR2ybP1NS0wPjjS1lQSEpZ3ZkRhQ/ZADkAVkr649WsHvOyNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895923; c=relaxed/simple;
	bh=RynoVHaHR3fhi+5EGp/ShOJVeujoS8ovOdDH2DNVym0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EP68I32HDHcMuCEbR+9Iw2mRaOHeTs8k+BpzhZBhJw0/plHYJREhSolwGLSAMwTmPYLthg0RBXBR1I49R17rK7RfY5qHs51hFZd3lmkQPqt/Bd6c469R5fSL3qRLfpSRI97xuEsPKnaxJ3Br+uPD4cYEBSGPwiI8XrCxIhh8OW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=CEsEn+Mb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 45KBNZSD018063
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 08:05:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=facebook;
 bh=wFHSlTqHV8oxfmQQDSLzrLOoxpZsIiUngD/NcLELQXU=;
 b=CEsEn+MbN8ItPSEfp6JRZHf9nk753zVvta+EKxtic9HJtFKSXk1pEwgS+mGiBIONRoXV
 /jN0FS/q+a+oBV1s/jBF2RoXViyVOtF2Zj+qx+71Vuq06SxDzsCpG4cSYK+/WgZpBZpi
 +G6SQkVZYrfftOXlzfbJbFGgJD4tlluwtu8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3yvkg9s930-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 08:05:20 -0700
Received: from twshared6102.02.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 20 Jun 2024 15:05:14 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 637A736708BA; Thu, 20 Jun 2024 16:05:11 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: Fix typo in error message
Date: Thu, 20 Jun 2024 16:04:51 +0100
Message-ID: <20240620150503.2330637-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZEOhgPkzpGk9434pdqMxzyEEh0M8ZJpT
X-Proofpoint-ORIG-GUID: ZEOhgPkzpGk9434pdqMxzyEEh0M8ZJpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d0882536b923..9b1ac0e2cdf3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2467,7 +2467,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_i=
nfo,
 	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
 	     !btrfs_fs_incompat(fs_info, NO_HOLES))) {
 		btrfs_err(fs_info,
-		"block-group-tree feature requires fres-space-tree and no-holes");
+		"block-group-tree feature requires free-space-tree and no-holes");
 		ret =3D -EINVAL;
 	}
=20
--=20
2.43.0


