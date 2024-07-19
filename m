Return-Path: <linux-btrfs+bounces-6606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A3937A27
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ED51F22967
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF69143723;
	Fri, 19 Jul 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bffQjY2j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2B145A1B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404028; cv=none; b=IfqYzPmDPkUE/pbV/NcVYA5xFjNOSNar4FmFKKjZvB0GuXGVarm/sMjDjxRHr+N6aE8YKNRdgX6fZxxTxbuzyqNZJ8OfDO8hGyJh7qoYsmqOfkYyfPGehWlg+n5PfaeUqrJ4+/LmN/SYODlJRst6xgMwovo7/h7xOdc0lRnhR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404028; c=relaxed/simple;
	bh=go0XAremx1xkK/gtbr42WUxDxTrFJ/6lVQC72dmhRCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qPmqK/BScvZKPPd1hCeJ2noJWFlGr0VViUv6T51NiDat6mDBrD/wU+qgZFEn+pIzSBPBs+dETjWAMTeoEC2rIbrGfyC037r5Ahw+/q4csrGYxAQxisBEaFtfmIjzybWvrs3eT2HWU7jVwCnPdWCA/jV+BqIbXTY0TKPUyE+iNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=bffQjY2j; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JE7tB9011002
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:47:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=lkkAl/mp
	z1+S2/MdXh5xEE59KQ7blNLeW1QEyHzVA4o=; b=bffQjY2jJAGzZ1+474ZUWGog
	G5M2RQaba1jMaHJ0BGFH48wAXhRohin8tfnh8lD7jPk3KNLrv0L+mPjUhGRIG6QG
	Jj1rhjyCfDQLxKHXboJklwyvK9R6+QKRKo0PtCh7/M/KhgAI7B7Sp5AdvveJPeIm
	5NFNpB2Bf5ukHWsmSoU=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40f1pgsfqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:47:05 -0700 (PDT)
Received: from twshared16175.07.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 19 Jul 2024 15:47:04 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 31F8F4778D33; Fri, 19 Jul 2024 16:46:54 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs-progs: simplify mkfs_main cleanup
Date: Fri, 19 Jul 2024 16:46:43 +0100
Message-ID: <20240719154649.4127040-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: hi5FmqXLcZtzLX9PPTiBx5RLpUzO05V2
X-Proofpoint-ORIG-GUID: hi5FmqXLcZtzLX9PPTiBx5RLpUzO05V2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01

mkfs_main is a main-like function, meaning that return and exit are
equivalent. Deduplicate code by adding a new out2 label.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 mkfs/main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index a69aa24b..5705acb6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1915,6 +1915,8 @@ out:
 	}
=20
 	btrfs_close_all_devices();
+
+out2:
 	if (prepare_ctx) {
 		for (i =3D 0; i < device_count; i++)
 			close(prepare_ctx[i].fd);
@@ -1927,15 +1929,9 @@ out:
 	return !!ret;
=20
 error:
-	if (prepare_ctx) {
-		for (i =3D 0; i < device_count; i++)
-			close(prepare_ctx[i].fd);
-	}
-	free(t_prepare);
-	free(prepare_ctx);
-	free(label);
-	free(source_dir);
-	exit(1);
+	ret =3D 1;
+	goto out2;
+
 success:
 	exit(0);
 }
--=20
2.44.2


