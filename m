Return-Path: <linux-btrfs+bounces-12198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D8A5CB02
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 17:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6924116BE82
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4626039A;
	Tue, 11 Mar 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PL/7PmIH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D625B69D
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711185; cv=none; b=rJAPmI5mQEQdy6cKUoe40bP7HNK5jqQDUw+ypGscL9Bg6p81bULfN/S/L+/ilBBAyGDsdlAT17L49DMTSWiYOLslFxIDoejwoUWAPqzzQ2cJit2XMOQ88QlV0WHAIosVMiiUUERjsMN0wLeAmllAqu53PQzuvNJON25Xan1nqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711185; c=relaxed/simple;
	bh=KXb58SUDetRsbP10toTzsNEUBHmhdMigHyRW8ciymAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IGRfwFlyUMCuUpa1nQQRAqly3duiSdpddUW24Zk2odaMkxpPTpi1Fvc+ryL+TNQEse+MqW+5aIe0D9uUiWyN12u3IiI2GzLlS84J6+nDKb8pql4XH0i2a1C7HH2uJu2HrdAjZR8pNIKg/lcqVivPc6Yd/ovkQphjE89RQfg8Cvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=PL/7PmIH; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52BGQ9GH002202
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 09:39:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=Rl+WOQuXbDSEfjVX+bibgsP
	Oy5dOxOyGMK2ecKT92To=; b=PL/7PmIHQXQ9bWE6H1wiFFBtc06nu+HEJBCft8T
	hVMulipP6VqY9QedTaPR2A2IvArt6N65rq4r2fn7IyYkcN0tdvuPGwq7nWQSmOXl
	Dvj4YxkWqdyR6ChPdDM2zrTBk2b+8rjx7cG0bcvA4SJiOtFnjpdnIZKAZhJ8RVPl
	fS7I=
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45ab0pwbdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 09:39:41 -0700 (PDT)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 11 Mar 2025 16:39:38 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id EF48BC7EF246; Tue, 11 Mar 2025 16:39:35 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH] btrfs: don't clobber ret in btrfs_validate_super()
Date: Tue, 11 Mar 2025 16:39:25 +0000
Message-ID: <20250311163931.1021554-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: 5vT5l4cqYNgOzwDWsOz6sAXqcV0ZG4mo
X-Proofpoint-ORIG-GUID: 5vT5l4cqYNgOzwDWsOz6sAXqcV0ZG4mo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01

Commit 2a9bb78cfd36 introduces a call to validate_sys_chunk_array() in
btrfs_validate_super(), which clobbers the value of ret set earlier.
This has the effect of negating the validity checks done earlier, making
it so btrfs could potentially try to mount invalid filesystems.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Cc: Qu Wenruo <wqu@suse.com>
Fixes: 2a9bb78cfd36 ("btrfs: validate system chunk array at btrfs_validat=
e_super()")
---
 fs/btrfs/disk-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0afd3c0f2fab..4421c946a53c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2562,6 +2562,9 @@ int btrfs_validate_super(const struct btrfs_fs_info=
 *fs_info,
 		ret =3D -EINVAL;
 	}
=20
+	if (ret)
+		return ret;
+
 	ret =3D validate_sys_chunk_array(fs_info, sb);
=20
 	/*
--=20
2.45.3


