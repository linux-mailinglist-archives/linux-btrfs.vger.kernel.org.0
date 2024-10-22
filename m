Return-Path: <linux-btrfs+bounces-9068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91FC9AB15B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DF0285542
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754E41A0737;
	Tue, 22 Oct 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bDQbfcZZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6E7DA7C
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608643; cv=none; b=avvloX+ddaoulbyRIwtNDnz6ULGHY6EIRtkkh9bg66aKMW56dWEfiaHsg9XcavU5+QO9mxqK+Qy9cximyN4LKCV04QpORb0MVgy8yYYFfqAI77CLCNTVKajKyMWrNh4YEW4NiXVcRDVVRICTrLxlc9kbRUlSP/Zep6W48mCM3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608643; c=relaxed/simple;
	bh=87TBmgu+PMGIOZvrk+fDZikTiy3fhPgRa9D3VjaDTNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCeMvW0Z4uUcvdGV20huOlwEANqhbFa2lS8ZA5UAgHksucS0y44zrdcoxTdAaKv2VpohZFIqNp2xMsyEhq05+F4q1jULYq9zu/VGLEtyvsyPcYz2+crYaXcF4RcRKUN46DqCkfeujGnTFijPfyCQlQR3M/Tvzrn/0koXuZCCnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=bDQbfcZZ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MDn55l012750
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 07:50:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=G
	mZA9KDJveq2hQvMo9nOsPOr/lSBv0lDAATJFn4uOgE=; b=bDQbfcZZemBc/9WzW
	5Uc/8iq5NPtRg+DyyPamm1zBif0FA2079IsQLaJC2OnqzaYJ4ySYyqnZ3NJo8JKY
	6toizIEYM8iGituBa2G5KF/TCKPuU94tGHYeLTWTkaB8sAuAg4apcvcsGAN5z76r
	12YjkRhBw4Ux6kW6dABPvsqXY0=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ecjd8rw5-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 07:50:40 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 14:50:37 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 935FE7FDCDA8; Tue, 22 Oct 2024 15:50:32 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: <io-uring@vger.kernel.org>, Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 1/5] btrfs: remove pointless addition in btrfs_encoded_read
Date: Tue, 22 Oct 2024 15:50:16 +0100
Message-ID: <20241022145024.1046883-2-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: xp8iwgl8_amxLFBjzOgVYq95dP9kg36t
X-Proofpoint-GUID: xp8iwgl8_amxLFBjzOgVYq95dP9kg36t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

iocb->ki_pos isn't used after this function, so there's no point in
changing its value.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7c5ef2c5c7e8..94098a4c782d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9252,7 +9252,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
 		ret =3D btrfs_encoded_read_inline(iocb, iter, start, lockend,
 						&cached_state, extent_start,
 						count, encoded, &unlocked);
-		goto out;
+		goto out_em;
 	}
=20
 	/*
@@ -9318,9 +9318,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
 						 &unlocked);
 	}
=20
-out:
-	if (ret >=3D 0)
-		iocb->ki_pos +=3D encoded->len;
 out_em:
 	free_extent_map(em);
 out_unlock_extent:
--=20
2.45.2


