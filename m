Return-Path: <linux-btrfs+bounces-7454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8195D36E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D144B2688A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2B818FC85;
	Fri, 23 Aug 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pFV8S3pJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2A18A6DA
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430518; cv=none; b=Fx17AKMFvpoiX2OjUZKqHIyxX0RtFHqg/1dK+OQv5N3UNriN5w/FGseF/gEm87IyhIp5uk+Bnrr+tTTmWzaLohInn3Nd4k9usYQsJmSNekrt7n3hDl5AD+qQObzPxpOiOcdYNZrm1shHMu+qwYz233t5PVoPUzNpgKFGjIpxx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430518; c=relaxed/simple;
	bh=u2UHUH2QcovdKIqIhhb336KV/vDjixFXikqzrzJlMEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATl6OQKnpvXqeIYyF4m4OEVmuYRl1qSkVxkMVd6ZJA/0yJ3Z97BLYZR0YSqNL8ILya/d/dhOmj5NZjpTx6CbqGbtQu21gO546AbS4WaHNk3lH6dwrAGNG1F5/+gByAWpx8UKwcE91UAyspJcSOjSp3L9x1WzfZv9reFA/fdp+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=pFV8S3pJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NETb5U003019
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 09:28:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	facebook; bh=DAWFUTSH5DJZ93OM2LwGJe5MqjiJme9jvbPvblW0IpU=; b=pFV
	8S3pJJzLt3y/D0hQssbRGHUtwceazmXpSmdFJjqp8i+atGCsEWt4XkMRfAc2lBDE
	03nrZceoA/1017q2vjPUxxje7umKtPyD+0Pk0Sflm23NgtRy4+WuIO1S0b8plFcr
	LhkVcD1BQDPkHeW2sZA7i55ArLO/ayQQ2PRsmwNI=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 416v82gt3g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 09:28:35 -0700 (PDT)
Received: from twshared4354.35.frc1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 23 Aug 2024 16:28:19 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 4B1785CB7F7D; Fri, 23 Aug 2024 17:28:13 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <io-uring@vger.kernel.org>, <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 4/6] btrfs: add btrfs_prepare_encoded_read
Date: Fri, 23 Aug 2024 17:27:46 +0100
Message-ID: <20240823162810.1668399-5-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162810.1668399-1-maharmstone@fb.com>
References: <20240823162810.1668399-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PvIaoyfkdUe_2FCdaZmpB0rLizUSXbTy
X-Proofpoint-ORIG-GUID: PvIaoyfkdUe_2FCdaZmpB0rLizUSXbTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_13,2024-08-22_01,2024-05-17_01

Move the beginning of btrfs_ioctl_encoded_read, responsible for
initialization of priv and validation, into its own function.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/ioctl.c | 84 ++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3fa661322c26..d2658508e055 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4537,23 +4537,23 @@ static ssize_t btrfs_encoded_read_finish(struct b=
trfs_encoded_read_private *priv
 	return ret;
 }
=20
-static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp=
,
-				    bool compat)
+static ssize_t btrfs_prepare_encoded_read(struct btrfs_encoded_read_priv=
ate *priv,
+					  struct file *file, bool compat,
+					  void __user *argp)
 {
 	size_t copy_end_kernel =3D offsetofend(struct btrfs_ioctl_encoded_io_ar=
gs,
 					     flags);
 	size_t copy_end;
 	loff_t pos;
 	ssize_t ret;
-	struct btrfs_encoded_read_private priv =3D {
-		.pending =3D ATOMIC_INIT(1),
-		.file =3D file,
-	};
=20
-	if (!capable(CAP_SYS_ADMIN)) {
-		ret =3D -EPERM;
-		goto out;
-	}
+	memset(priv, 0, sizeof(*priv));
+
+	atomic_set(&priv->pending, 1);
+	priv->file =3D file;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
=20
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
@@ -4561,47 +4561,55 @@ static int btrfs_ioctl_encoded_read(struct file *=
file, void __user *argp,
=20
 		copy_end =3D offsetofend(struct btrfs_ioctl_encoded_io_args_32,
 				       flags);
-		if (copy_from_user(&args32, argp, copy_end)) {
-			ret =3D -EFAULT;
-			goto out;
-		}
-		priv.args.iov =3D compat_ptr(args32.iov);
-		priv.args.iovcnt =3D args32.iovcnt;
-		priv.args.offset =3D args32.offset;
-		priv.args.flags =3D args32.flags;
+		if (copy_from_user(&args32, argp, copy_end))
+			return -EFAULT;
+
+		priv->args.iov =3D compat_ptr(args32.iov);
+		priv->args.iovcnt =3D args32.iovcnt;
+		priv->args.offset =3D args32.offset;
+		priv->args.flags =3D args32.flags;
 #else
 		return -ENOTTY;
 #endif
 	} else {
 		copy_end =3D copy_end_kernel;
-		if (copy_from_user(&priv.args, argp, copy_end)) {
-			ret =3D -EFAULT;
-			goto out;
-		}
-	}
-	if (priv.args.flags !=3D 0) {
-		ret =3D -EINVAL;
-		goto out;
+		if (copy_from_user(&priv->args, argp, copy_end))
+			return -EFAULT;
 	}
=20
-	priv.iov =3D priv.iovstack;
-	ret =3D import_iovec(ITER_DEST, priv.args.iov, priv.args.iovcnt,
-			   ARRAY_SIZE(priv.iovstack), &priv.iov, &priv.iter);
+	if (priv->args.flags !=3D 0)
+		return -EINVAL;
+
+	priv->iov =3D priv->iovstack;
+	ret =3D import_iovec(ITER_DEST, priv->args.iov, priv->args.iovcnt,
+			   ARRAY_SIZE(priv->iovstack), &priv->iov, &priv->iter);
 	if (ret < 0) {
-		priv.iov =3D NULL;
-		goto out;
+		priv->iov =3D NULL;
+		return ret;
 	}
=20
-	if (iov_iter_count(&priv.iter) =3D=3D 0) {
-		ret =3D 0;
-		goto out;
-	}
-	pos =3D priv.args.offset;
-	ret =3D rw_verify_area(READ, file, &pos, priv.args.len);
+	pos =3D priv->args.offset;
+	ret =3D rw_verify_area(READ, priv->file, &pos, priv->args.len);
 	if (ret < 0)
+		return ret;
+
+	priv->copy_out =3D argp + copy_end;
+
+	return 0;
+}
+
+static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp=
,
+				    bool compat)
+{
+	ssize_t ret;
+	struct btrfs_encoded_read_private priv;
+
+	ret =3D btrfs_prepare_encoded_read(&priv, file, compat, argp);
+	if (ret)
 		goto out;
=20
-	priv.copy_out =3D argp + copy_end;
+	if (iov_iter_count(&priv.iter) =3D=3D 0)
+		goto out;
=20
 	ret =3D btrfs_encoded_read(&priv);
=20
--=20
2.44.2


