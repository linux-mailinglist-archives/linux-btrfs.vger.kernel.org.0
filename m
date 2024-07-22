Return-Path: <linux-btrfs+bounces-6642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35142938FF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBC01F21ABC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC316D9C0;
	Mon, 22 Jul 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="U+Rak7ku"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F21D696
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655213; cv=none; b=nw2u1jvtiY0lbnr8d9Pj66/SMAttztvoLK+Oo1/cguLfHE2dSByLdBNmEYFVFuNNw6aKP8XS27tqtv8kvX1CB5YDbTlrsTdvuy2B3DK6MThBFf0L429DJwlOnFOLC37ZanFOo6H6p2MaeiWi+hr0ghRjhcqzkKxhdJ3GX5N5gRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655213; c=relaxed/simple;
	bh=i+lqykzIv1dWWkxVAZxsk7faSkh679bhngGcxCsI528=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jA46GGQvHJGoVVJ0URunlXTcFSTe+XO6QMKY/SjPCsbK3ovnMwjb6utChodFbSffAWbK2mhE8Ro4WIqWIKw/68JE+/e6KTbY1bgQBVDItQM7VuVk7N4twQHvKRk7SVYldh3+JJT20TFN6/X0eZuvBAO7bLpLdjt8iJw3B9/kWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=U+Rak7ku; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCNEoA004532
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 06:33:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=6R+Jy7Vx
	btJbG280aZuc+pqaNbyve16vvqxgFADwWMA=; b=U+Rak7ku4EbTr/D085beq5vU
	PrbgutwOAvRqwyBPtqvUlOHObPNAfqSuNKqYRdzC0+Zj1uWxyP6Gmv8GOSp5KD+F
	O7uBHHzBXn8Ey7hXmApne8Yeq7wwpdCmrtIID3Lqx9b7K9cZRg/l/+QL87uudLj3
	5XztVprFfZGt/ijbxSU=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40gcj0ygdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 06:33:31 -0700 (PDT)
Received: from twshared18401.02.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 13:33:29 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 7D0CC4936E0B; Mon, 22 Jul 2024 14:33:23 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v2] btrfs-progs: set transid in btrfs_insert_dir_item
Date: Mon, 22 Jul 2024 14:33:02 +0100
Message-ID: <20240722133320.835470-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: _-IbFI4xG7mVaIpcvxKirOj51iNHU6HA
X-Proofpoint-GUID: _-IbFI4xG7mVaIpcvxKirOj51iNHU6HA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_09,2024-07-22_01,2024-05-17_01

btrfs_insert_dir_item wasn't setting the transid field in
btrfs_dir_item. Set it to the current transaction ID rather than writing
uninitialized memory to disk.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 kernel-shared/dir-item.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 4c62597b..5e7d09e6 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -27,6 +27,7 @@
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
+#include "kernel-shared/transaction.h"
=20
 struct btrfs_trans_handle;
=20
@@ -173,6 +174,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *=
trans, struct btrfs_root
 	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
+	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
 	name_ptr =3D (unsigned long)(dir_item + 1);
=20
 	write_extent_buffer(leaf, name, name_ptr, name_len);
@@ -202,6 +204,7 @@ insert:
 	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
+	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
 	name_ptr =3D (unsigned long)(dir_item + 1);
 	write_extent_buffer(leaf, name, name_ptr, name_len);
 	btrfs_mark_buffer_dirty(leaf);
--=20
2.44.2


