Return-Path: <linux-btrfs+bounces-9071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 903509AB161
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D80B21A5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713BA1A0737;
	Tue, 22 Oct 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LVGMSqG8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4E7DA7C
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608652; cv=none; b=nQUGxz7eCTS8iBAS+0YeSeIIztLL+n67QD2hVoiI2A/sSAl0RqX9jVZT34k7WPGUiZMUUGiDNsGeoFanstMv3KcEpPtvN6s0xLqQbu1+qsh/cXylzr9AbvR22UcK393GyiSAssuN3bb6f93ZYBgHbe3nbs+TSsgd3IsRRUprtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608652; c=relaxed/simple;
	bh=ZQqI/idDGj2CcTB3dUSpIKbEX1BYlGP7SaJ9M8tuCHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+H1B/QPbrmJI82g35mVY9kotcQ6axEKUBnFz4p4E6fZw+zM7orUcOyYRDTwIn/qBZxke4U7S4CBh1Q1gUOOT08AO8YIO76vTvWdwT9xOPOYKbSyLzYBA+QipwKFWn4gt9mi51yxRc7OfiGevRLQusFVTjm2PCdmNd6jqBpQvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=LVGMSqG8; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MDnDJs014113
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 07:50:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=T
	XiqcxvRqPMP5YK4fmGwC9B8y6cWCpznsjSL1sQcVq0=; b=LVGMSqG898tmEsf3+
	tLj+mkUC70JSfigWrsKUJ+M8pHkz8m2LcJPtS7Q5SbX5RcziGTjh5BjYWC2scxuX
	4nyAfMATxlL0XESdgvqAC23E8NIIeACUHqXU7W2nE+OT5EhSvhj5hyglsV6NGyBw
	sq6cjdm0Shhe60Xiogp5wV2kOk=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ea7psg41-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 07:50:49 -0700 (PDT)
Received: from twshared17102.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 14:50:36 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id B90F97FDCDAE; Tue, 22 Oct 2024 15:50:32 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: <io-uring@vger.kernel.org>, Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 4/5] btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages
Date: Tue, 22 Oct 2024 15:50:19 +0100
Message-ID: <20241022145024.1046883-5-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022145024.1046883-1-maharmstone@fb.com>
References: <20241022145024.1046883-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: skdKsG9DGPbEJGzvsCzo64PskL7lQHth
X-Proofpoint-ORIG-GUID: skdKsG9DGPbEJGzvsCzo64PskL7lQHth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Change btrfs_encoded_read_regular_fill_pages so that the priv struct is
allocated rather than stored on the stack, in preparation for adding an
asynchronous mode to the function.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/inode.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0c0753f20d54..5aedb85696f4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9086,16 +9086,21 @@ int btrfs_encoded_read_regular_fill_pages(struct =
btrfs_inode *inode,
 					  struct page **pages)
 {
 	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
-	struct btrfs_encoded_read_private priv =3D {
-		.pending =3D ATOMIC_INIT(1),
-	};
+	struct btrfs_encoded_read_private *priv;
 	unsigned long i =3D 0;
 	struct btrfs_bio *bbio;
+	int ret;
=20
-	init_waitqueue_head(&priv.wait);
+	priv =3D kmalloc(sizeof(struct btrfs_encoded_read_private), GFP_NOFS);
+	if (!priv)
+		return -ENOMEM;
+
+	init_waitqueue_head(&priv->wait);
+	atomic_set(&priv->pending, 1);
+	priv->status =3D 0;
=20
 	bbio =3D btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
-			       btrfs_encoded_read_endio, &priv);
+			       btrfs_encoded_read_endio, priv);
 	bbio->bio.bi_iter.bi_sector =3D disk_bytenr >> SECTOR_SHIFT;
 	bbio->inode =3D inode;
=20
@@ -9103,11 +9108,11 @@ int btrfs_encoded_read_regular_fill_pages(struct =
btrfs_inode *inode,
 		size_t bytes =3D min_t(u64, disk_io_size, PAGE_SIZE);
=20
 		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
-			atomic_inc(&priv.pending);
+			atomic_inc(&priv->pending);
 			btrfs_submit_bbio(bbio, 0);
=20
 			bbio =3D btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
-					       btrfs_encoded_read_endio, &priv);
+					       btrfs_encoded_read_endio, priv);
 			bbio->bio.bi_iter.bi_sector =3D disk_bytenr >> SECTOR_SHIFT;
 			bbio->inode =3D inode;
 			continue;
@@ -9118,13 +9123,15 @@ int btrfs_encoded_read_regular_fill_pages(struct =
btrfs_inode *inode,
 		disk_io_size -=3D bytes;
 	} while (disk_io_size);
=20
-	atomic_inc(&priv.pending);
+	atomic_inc(&priv->pending);
 	btrfs_submit_bbio(bbio, 0);
=20
-	if (atomic_dec_return(&priv.pending))
-		io_wait_event(priv.wait, !atomic_read(&priv.pending));
+	if (atomic_dec_return(&priv->pending))
+		io_wait_event(priv->wait, !atomic_read(&priv->pending));
 	/* See btrfs_encoded_read_endio() for ordering. */
-	return blk_status_to_errno(READ_ONCE(priv.status));
+	ret =3D blk_status_to_errno(READ_ONCE(priv->status));
+	kfree(priv);
+	return ret;
 }
=20
 ssize_t btrfs_encoded_read_regular(struct kiocb *iocb, struct iov_iter *=
iter,
--=20
2.45.2


