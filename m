Return-Path: <linux-btrfs+bounces-9434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C37F9C4592
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 20:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6BC1F221F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E41AAE3A;
	Mon, 11 Nov 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ajVCwE40"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDE1AB539
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351997; cv=none; b=fFAUX3nbilHQjIqn22bX2dH+1tSeiwOkgI7CRdHEWgfvsMqQCAnljMcpRFJAEFTTt+JBHlrajNj7+pGaby6ZLLKvRvt7vByY4j6hFOKnjyDVruGeyDV+mczuzXzDP75x6H6yxX5eF6tGXi3XT73gyvArHMEgvsQr2+4kU9qkOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351997; c=relaxed/simple;
	bh=O0LxaXvsTxA2mly+DTCcUT1Kd9UAn5H+1ERJxB10BvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VsRjoDnoyGO1+Q7p1BTcSf8WKP9Uy9je0o+C//2HV82a3ZCXmcjWuKiVNm5vKy1XItE0D2vQW/9hhGIPYfFdZipE1tmFCuKtWz3cSKIpwqp9945CpnZNUrYN6WQuZCwMQvKUhVSrhVsx6o4iU2II8r0VOB92sha7ARAsoXEP/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=ajVCwE40; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABH6qqZ027452
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 11:06:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=nr+zNcDjHQh8UWooacXGEIL
	Pvm0Wb9wYnKoIOh/74Ho=; b=ajVCwE40B6kEX7h7iPAduU38ePhiZ8o4h9TRTTO
	ulfXVryp2nDMvgFLQHkME6B7W9MbpAWOvmbI8PzaP91GRLzUHs5r8zs2/JlPodw+
	ITYCpcERb1qyiW6jVFjGCzQMsMRoBH0cz0Kw5qPRjrX9Wb4OMBJwqNuon2WMx+HJ
	QkQk=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42unf3183e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 11:06:34 -0800 (PST)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 11 Nov 2024 19:06:33 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 733EC8901285; Mon, 11 Nov 2024 19:06:20 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] btrfs: use kmemdup in btrfs_uring_encoded_read
Date: Mon, 11 Nov 2024 19:06:06 +0000
Message-ID: <20241111190619.164853-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: 5UsxlqRSOdo1-dacIWaTrGdAmDT6mCle
X-Proofpoint-GUID: 5UsxlqRSOdo1-dacIWaTrGdAmDT6mCle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Use kmemdup in btrfs_uring_encoded_read rather than kmalloc followed by
memcpy.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411050846.GI8oh5IK-lkp@i=
ntel.com/
---
 fs/btrfs/ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9ff1aea7910c..fb1a21533825 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4983,15 +4983,14 @@ static int btrfs_uring_encoded_read(struct io_uri=
ng_cmd *cmd, unsigned int issue
 		 * undo this.
 		 */
 		if (!iov) {
-			iov =3D kmalloc(sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
+			iov =3D kmemdup(iovstack, sizeof(struct iovec) * args.iovcnt,
+				      GFP_NOFS);
 			if (!iov) {
 				unlock_extent(io_tree, start, lockend, &cached_state);
 				btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 				ret =3D -ENOMEM;
 				goto out_acct;
 			}
-
-			memcpy(iov, iovstack, sizeof(struct iovec) * args.iovcnt);
 		}
=20
 		count =3D min_t(u64, iov_iter_count(&iter), disk_io_size);
--=20
2.45.2


