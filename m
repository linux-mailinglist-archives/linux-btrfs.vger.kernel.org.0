Return-Path: <linux-btrfs+bounces-9260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63DD9B7A09
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 12:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E0F1C21828
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5719B5A3;
	Thu, 31 Oct 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VlWm8qs7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E019AA6B
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375557; cv=none; b=lRecB7ryqMQO+Lwr96L7bqeXCKgV7zNImn0VA0KCMk675F4Wn86vzf1dwJ2PHNVtOLNXWLrDx9xPZradOmIlDWWlvXUUqdX33ylj49tnG4GCBO5sPUHyu8DnPi6cZ/0k6tSBjitpnHFcDs4uvc2cA7qBwbpeRBYVZjuKB9OECQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375557; c=relaxed/simple;
	bh=3L3TzqXkOKhvUpd9zcnA6hJ5gPVD1OMQO+UNtbiFNqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8rzfqrM4y7KkuRWzu8wii1tCsBZWTNvG0PTGmT9ycX2hHp2m22mGNZ2LqS8eNhWSWrTlTLUJNyREv94Y0YzZoveki6sBkpn4V1jFM/RhjqCAdaP3itAiqY8xZGuu1U+OHxbp+KDzkiuQzTfJKDSfwAxsRtxoAmb8oO1sqfG9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=VlWm8qs7; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VAqVjH021404
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 04:52:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=KLi5JdpeMFdOUtMiVjaThfg
	G0piGx/6HwbyzY/3QV4c=; b=VlWm8qs7HebTwTp+7TUIFcaEW/K/zJKq1SXV0Kt
	zM7GjdDAvscEdZYRx7HmN0MeBbaB+b1yqH5x88Qtb/PNMgi+Vw7xa+ZAsd8k6uWs
	Exi0BwabJdj5q0TkrTppmAmRsiRDhnGgqdhqg5jOyivKB5a57PzclM2rItGinEMa
	cq6Q=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42m83j8drc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 04:52:34 -0700 (PDT)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 31 Oct 2024 11:52:32 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 607AD83EC599; Thu, 31 Oct 2024 11:52:19 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: avoid superfluous calls to free_extent_map() in btrfs_encoded_read()
Date: Thu, 31 Oct 2024 11:52:05 +0000
Message-ID: <20241031115210.1965033-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 12ZZM_48Zv30xrBaTfY_mDKUcOpzIZAu
X-Proofpoint-ORIG-GUID: 12ZZM_48Zv30xrBaTfY_mDKUcOpzIZAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

Change the control flow of btrfs_encoded_read() so that it doesn't call
free_extent_map() when we know that this has already been done.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Suggested-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40f278821144..fc21e8519efe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9324,7 +9324,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
 		ret =3D btrfs_encoded_read_inline(iocb, iter, start, lockend,
 						cached_state, extent_start,
 						count, encoded, &unlocked);
-		goto out_em;
+		goto out_unlock_extent;
 	}
=20
 	/*
@@ -9384,7 +9384,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
 			ret =3D -EFAULT;
 	} else {
 		ret =3D -EIOCBQUEUED;
-		goto out_em;
+		goto out_unlock_extent;
 	}
=20
 out_em:
--=20
2.45.2


