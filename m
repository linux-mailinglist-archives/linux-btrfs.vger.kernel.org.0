Return-Path: <linux-btrfs+bounces-6593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE29376F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 13:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BCFB21FC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F21F823C3;
	Fri, 19 Jul 2024 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KGtS4i42"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0B8F45
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387104; cv=none; b=tS1Yt9oI0KqSv0eNKFhJsR0Dn72GMYSFo1ExZsB9y6IJknjaHUvtawYHoqFxULGAK8GBwj6Mx73wb/6u1hwV8j/nmA8Fv1wjSXjXAnTYPPnXCuaJ6isRvx7jqUt2rowqKQvYqwCk8BiihUk1ME6sQj7vVFGIYdTzFST8OKKVdVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387104; c=relaxed/simple;
	bh=PHvaiKEHMW3IM7b5W5aLLrPEk9+ZqetsSB+04Y3cBjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q13iI2kgoWsamelZkzmfdyk/0khwnZG5jxYgwE8QFVtAavB67K1Iwl8U9UzhREUGHlnYJNhUcpS3+kFwdAByawMhz+wkGe0pigvRw+7cTzJZlTINtVCv8d/Q1fc/BvNixvg552mxCSmPTkDsh+5c9IGa1fIfVulz8VqY0/AZvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=KGtS4i42; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46J2QoCv010976
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:05:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=y1Y+V8HT
	mpGRm/Eq4AdAzCCgY3ZbD2ZWhBBDBQchkSg=; b=KGtS4i42EgnQxPj/d5y+LkQr
	hzmXUTgnYQw0dldq6aP2nqFJEc2tXWJ07urFV6rytYA7nbeFHjiyVXXMNWY0QOTG
	wA2V6ztjTCRk+aDNI4b71ZsP9z1dhMechb/8ioG4PC5cDavB7pUcaGqhHIn9mBjq
	VeZ+9DW0kEZwpZWfaDw=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40f1pgqtyv-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:05:01 -0700 (PDT)
Received: from twshared25218.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 19 Jul 2024 11:05:00 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 978B6475B237; Fri, 19 Jul 2024 12:04:50 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs-progs: set transid in btrfs_insert_dir_item
Date: Fri, 19 Jul 2024 12:04:21 +0100
Message-ID: <20240719110447.3211103-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: 58r3XmV3gllIncJy6UONYVlD-nxywtv1
X-Proofpoint-ORIG-GUID: 58r3XmV3gllIncJy6UONYVlD-nxywtv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01

btrfs_insert_dir_item wasn't setting the transid field in
btrfs_dir_item. This field doesn't matter, so set it to 0 rather than
writing uninitialized memory to disk.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 kernel-shared/dir-item.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 4c62597b..78ad108c 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -173,6 +173,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *=
trans, struct btrfs_root
 	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
+	btrfs_set_dir_transid(leaf, dir_item, 0);
 	name_ptr =3D (unsigned long)(dir_item + 1);
=20
 	write_extent_buffer(leaf, name, name_ptr, name_len);
@@ -202,6 +203,7 @@ insert:
 	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
+	btrfs_set_dir_transid(leaf, dir_item, 0);
 	name_ptr =3D (unsigned long)(dir_item + 1);
 	write_extent_buffer(leaf, name, name_ptr, name_len);
 	btrfs_mark_buffer_dirty(leaf);
--=20
2.44.2


