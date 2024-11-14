Return-Path: <linux-btrfs+bounces-9640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D69C8DD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E851F25282
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCC1487CD;
	Thu, 14 Nov 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M+FlT7AQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419713CA8D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597801; cv=none; b=kOEOi3cjqB1+k1MLzPpGWdJ50QxgOMX8MFFbceaemWJKY4spFAmk/TD2P+HZU5ZNAKgC0sasH1+XILZ0nqQ0kujgOu//ErlGm+HJJT3p1V/pwHfxiayJOo+UwBmcSpDH6XGprLhfbt4/W2N1aDrJBBooh6H5JW/gChAqN+bbCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597801; c=relaxed/simple;
	bh=vRi0Y628ucXMlToCe/fEwjECEtuZ3UI5cWCs/lrNwg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kl4dc+JtNGUg1tiMCQbgeCc5PVVah7GUVcA25ZHnvJzIYG1u9VQLuws8AjwG/GbNolhofsUF587P5tExp9fLdKgpS9Yf0I/C/egswoMrNZ4tbjlMtFIawTTJPHsr3z0QPccmz8PTNYj3Mlv1qUnGINtlRM2ldSh64xlZzq3S0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=M+FlT7AQ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AECt9Ga009225
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:23:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=LZbsTriFkbrNpWvabsYa0T8
	WIkedlKBZYKIaL378/Nw=; b=M+FlT7AQiJ9AW96/ARAJe+7tG4QM+MZr3a0S4Qq
	zCzYoyWBMuOJtdWtDF0X5BjCzjHWgE72IcJkGeClSGLDRwtnrk7ZmZPaLSPhV2fG
	MXsTIHcDnn8XaoIsMKcHgygIZZyd1h6Fpi4zYyWzrPSFiN2ZbGF7coVmWqm5HK8v
	9rN4=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42wbt2u9av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:23:18 -0800 (PST)
Received: from twshared12347.06.ash8.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 14 Nov 2024 15:23:17 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id BC41A8A4A72B; Thu, 14 Nov 2024 15:23:13 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: remove unused macros in ctree.h
Date: Thu, 14 Nov 2024 15:22:53 +0000
Message-ID: <20241114152312.2775224-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: FCEsaSg2b2PbSvxaTmGYsDrEnmMvbmx5
X-Proofpoint-ORIG-GUID: FCEsaSg2b2PbSvxaTmGYsDrEnmMvbmx5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The Private2 #ifdefs in ctree.h for pages are no longer used, as of
commit d71b53c3cb0a. Remove them, and update the comment to be about foli=
os.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/ctree.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 317a3712270f..60c205ac5278 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -744,14 +744,11 @@ const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __attribute_const__ btrfs_get_num_csums(void);
=20
 /*
- * We use page status Private2 to indicate there is an ordered extent wi=
th
+ * We use folio status private_2 to indicate there is an ordered extent =
with
  * unfinished IO.
  *
- * Rename the Private2 accessors to Ordered, to improve readability.
+ * Rename the private_2 accessors to ordered, to improve readability.
  */
-#define PageOrdered(page)		PagePrivate2(page)
-#define SetPageOrdered(page)		SetPagePrivate2(page)
-#define ClearPageOrdered(page)		ClearPagePrivate2(page)
 #define folio_test_ordered(folio)	folio_test_private_2(folio)
 #define folio_set_ordered(folio)	folio_set_private_2(folio)
 #define folio_clear_ordered(folio)	folio_clear_private_2(folio)
--=20
2.45.2


