Return-Path: <linux-btrfs+bounces-12384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6BA6787F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CAF3AF896
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B39920F07A;
	Tue, 18 Mar 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="D8ZAD26Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AB204C2A
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313416; cv=none; b=LW6eg82gbCFfsSJeoN032IlRnxRSKBS8UcaM+kvBStZmFoDitwhPExkdqAToNpQzr1weR24PlkLGstRx5oh8iYdGHXQhfWFF6P641D1hqtOs2bvwFbfzsVDE2BzWZYrHEg1RoTL0pwtvQfP4hY07Oy0UrBmLkCsDsxb9vje2Kb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313416; c=relaxed/simple;
	bh=XsICVdvDbIbGmXCwaAaTOmRhw4cDBbmuJgVfxJLbr04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F1vLzS1vUq6bq4llfIYhrlT3BCE4OaUBjYVMbeI2sc8OeNGucUCUHU+CRXXWhgB2U0a0eGvhnKLOehJryjY6I2YDGIWx/s+GWEDbZqNdddDkJMw5O1NS28gU9gk9ec6hDNtqyuRxFqm2m2xKmfFV/NbXgFI/pHmp88dGy9RPi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=D8ZAD26Z; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52IFphsu005558
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 08:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=LYU6po1nbAeC21urfmO/nZW
	GWGcHKb+sy8NwA24fi3Y=; b=D8ZAD26ZQbuL+gR7G9GgWVyY0uzSZjgz2eHMDel
	+P5jbWOB+AOkuqyljzV7wApXgIPrIZWlj8KPkQqX8qqJgSVlumQbpT2uYLv2QOkI
	FYiZobn0vLxhoMdz7++8gYbB77pS/bQTmY+IlfVk+caDHPn484Bop3LbAhwQPMFn
	tP6E=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45faccgvje-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 08:56:53 -0700 (PDT)
Received: from twshared37834.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Mar 2025 15:56:51 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id D33FDCC62423; Tue, 18 Mar 2025 15:56:49 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: fix typo in space info explanation
Date: Tue, 18 Mar 2025 15:56:42 +0000
Message-ID: <20250318155648.159250-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: QWiulewlRllg6MaxCj7JpqPW4eQpRyRT
X-Proofpoint-ORIG-GUID: QWiulewlRllg6MaxCj7JpqPW4eQpRyRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01

There's an explanation of how space info works at the top of
fs/btrfs/space-info.c, which makes reference to a variable called
bytes_may_reserve.  There's nothing called that in the code, and wasn't
at time the comment was written; as far I can tell this is a typo, and
it should actually be bytes_may_use.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ff089e3e4103..77cc5d4a5a47 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -50,11 +50,11 @@
  *   num_bytes we want to reserve.
  *
  *   ->reserve
- *     space_info->bytes_may_reserve +=3D num_bytes
+ *     space_info->bytes_may_use +=3D num_bytes
  *
  *   ->extent allocation
  *     Call btrfs_add_reserved_bytes() which does
- *     space_info->bytes_may_reserve -=3D num_bytes
+ *     space_info->bytes_may_use -=3D num_bytes
  *     space_info->bytes_reserved +=3D extent_bytes
  *
  *   ->insert reference
--=20
2.48.1


