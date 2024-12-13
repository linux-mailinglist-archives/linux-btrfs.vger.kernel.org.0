Return-Path: <linux-btrfs+bounces-10352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413629F0CAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 13:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F78166D11
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7411DF97D;
	Fri, 13 Dec 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TbEcGjai"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275A23C9
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094017; cv=none; b=hz/txDn5WOt5H1aEaT+W2KionIvdEH6MoevSOL8OG+/YJojT1cgcc5qBmD/o4Tbr8vFvc8ciIojxFe0MbJLQdNH/+sLF6LebHQeK0a3o7DY0nFrNspB7sUJlvdx0WPxBqWu6DPqH2AhTiL57k7njN7v2D/m/0LQJh92/LSVL/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094017; c=relaxed/simple;
	bh=FizzQNMfYJYpGIUlG3svTjPfChZDtuv2fwFtfpjrEso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6o5nnkgfWrpJg9z7ZgtNOpoS6S7fRUmqJsbILiieF+crx7iXez6mw8x9nT9kUrzJ2fDNhKgUArrVI3ECSi9YVcsN5JDg0cQ3qb2RU3tQ0oOxPVUPi/oH+wlzrDpaDrItkqElym33L9bWEfqU6z2HiPdueTleiuRdN1hZy3yjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=TbEcGjai; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD6jE5X009108
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 04:46:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=xJ8+6khN1QLGsUgMZlX3B6H
	pCPyrBbuHoERWnx2myIo=; b=TbEcGjaiGZxXcgervFHtybYKOROWW5zqLa4lLYQ
	HY4wXB+Nf2ofALBGiGlnnh0DGyl1Jgu4uNlLq0evbpoomRhJsGUuxWnNtfqPOFXA
	IFgnd9Wa/6TDmXYfL8DKHI/rGL6CONfIt0UKQx6UEk8ZBg6lZ4H3+Zbl3w0vnFtU
	NFUE=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43geyt9qcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 04:46:55 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Dec 2024 12:46:54 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 981F79847C19; Fri, 13 Dec 2024 12:46:37 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>,
        Pavel Begunkov
	<asml.silence@gmail.com>
Subject: [PATCH] btrfs: check if task has died in btrfs_uring_read_finished()
Date: Fri, 13 Dec 2024 12:46:15 +0000
Message-ID: <20241213124626.130075-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: YJ8duvbnRADCga5mKYqCJv8QPRq45Fp8
X-Proofpoint-ORIG-GUID: YJ8duvbnRADCga5mKYqCJv8QPRq45Fp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

If the task has died by the time we call btrfs_uring_read_finished(),
return -ECANCELED rather than trying to copy the pages back to
userspace.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
---
(This is quite possibly a resend. I intended this to be the sequel to
"[PATCH 1/2] io_uring/cmd: let cmds to know about dying task", but I
can't find it anywhere on the mailing lists now.)

 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 64cebc32fe76..6913967083fe 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4754,6 +4754,11 @@ static void btrfs_uring_read_finished(struct io_ur=
ing_cmd *cmd, unsigned int iss
 	/* The inode lock has already been acquired in btrfs_uring_read_extent.=
  */
 	btrfs_lockdep_inode_acquire(inode, i_rwsem);
=20
+	if (unlikely(issue_flags & IO_URING_F_TASK_DEAD)) {
+		ret =3D -ECANCELED;
+		goto out;
+	}
+
 	if (priv->err) {
 		ret =3D priv->err;
 		goto out;
--=20
2.45.2


