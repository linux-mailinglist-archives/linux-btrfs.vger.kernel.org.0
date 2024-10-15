Return-Path: <linux-btrfs+bounces-8930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EF699E60E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 13:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34392B22AE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656A91E7640;
	Tue, 15 Oct 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UtnlKiwM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E31D90CD
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992270; cv=none; b=DXPYCtXPfmRMfqbApr6Ks4CS1VzRmrgeeTHkYvKWLm1x94enBWXJZtdEJgNFYHhFAzhLM5tSllAq+VLOXGz43C98WKVtZcNtB3IRdiFcTpB8xcXxJ2YHFeehCJ4DEWJonVQICH9KR6U7Go/RQb09H1Rdu9mzAvSTt9r/6Pv5sLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992270; c=relaxed/simple;
	bh=NcBCWZW6v/fFVfHJNBffEW3Iz0IHzStm6xBE16wfRKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJqiSQkbIAF1UBBRX+nyTlVNs1RHa1G/ELr0+knRalAhml05n70Y6uBU+D0hQsqgBvrOjBvCGoevtCC2ua9TnwV5okqXYe7o/2e+u7hrQ2XA+E9LKlOmVvRMnfqoxaLvitpbDdDQLDXj9/WqjE2rsZrIP8u+442mH7Cq6Ti2PxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=UtnlKiwM; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6QHkP021101
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 04:37:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=Wd5EMyguFyzxFesO4xLNdyM
	mj63QCXLB5n5NON+OTb8=; b=UtnlKiwM7AMAz5falJynXZQCRCxVKuSzHcWa46+
	vDjqfr/ZZf5ElEIjGaxUB4oqe6xRsdZiIbFKlZSMOOY6kUgpySr5JfTTqGBLy2IV
	qKsFCYCqDMKSk871BXoeWh2wvk8mc9y9IrOwlyfeCnZdkXC9KVm17+ZW0PnLl7R/
	MZEE=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4291we7fsn-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 04:37:47 -0700 (PDT)
Received: from twshared16035.07.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 15 Oct 2024 11:37:39 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 2591E7C96B44; Tue, 15 Oct 2024 12:37:37 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: fix wrong sizeof in btrfs_do_encoded_write
Date: Tue, 15 Oct 2024 12:37:29 +0100
Message-ID: <20241015113736.1006573-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: nx9HJbKwFeU6BW3VayJYNyDRMyFC6YQj
X-Proofpoint-ORIG-GUID: nx9HJbKwFeU6BW3VayJYNyDRMyFC6YQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

btrfs_do_encoded_write was converted to use folios in 400b172b8cdc, but
we're still allocating based on sizeof(struct page *) rather than
sizeof(struct folio *).

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5618ca02934a..5bffc2c77718 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9495,7 +9495,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, =
struct iov_iter *from,
 	 */
 	disk_num_bytes =3D ALIGN(orig_count, fs_info->sectorsize);
 	nr_folios =3D DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
-	folios =3D kvcalloc(nr_folios, sizeof(struct page *), GFP_KERNEL_ACCOUN=
T);
+	folios =3D kvcalloc(nr_folios, sizeof(struct folio *), GFP_KERNEL_ACCOU=
NT);
 	if (!folios)
 		return -ENOMEM;
 	for (i =3D 0; i < nr_folios; i++) {
--=20
2.44.2


