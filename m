Return-Path: <linux-btrfs+bounces-12049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD7A54897
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 11:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35123AB8DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063D92040BE;
	Thu,  6 Mar 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rJSRKQP1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B9204686
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258784; cv=none; b=m4kwuTBlb006zQfMUa7fZdsh78pzO0PGSFUlFfFKCPB7iYw4trAXf4z3+iWEFbA/hX9mQnX7gph78AngV+WEf4/qMF3mB4lXNzytdOJxCbAXHwgixGV6IVREyDSsCVsBok9szmeJyBxgNeFQI22kHEj6InYGOnwu5w19sKw/kzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258784; c=relaxed/simple;
	bh=gjn2Vrx6WFNJvM3rIx54eteIyYYErUNNx/fTzs75jt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HuHOa7JwsrFwyqDt+5MuerRhpCgTNOmnC6kOvY3Dik+FZH+xM5CJRkzowdlqQSqwVR5PYdS9iNAgyZXf+fTp0My/WorHDpBVZSL3MYi2L3gpLC1Kr1mSRJ1bOuupH+Y2TVVdM65Jh+psRMti7/3nofcdnAIorLgw3FAlBSLybvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=rJSRKQP1; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5264slSX006449
	for <linux-btrfs@vger.kernel.org>; Thu, 6 Mar 2025 02:59:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=f+cOCb1muiKaXO5bYrfnZLZ
	dwdFPTzHIX3lu0TqXoUM=; b=rJSRKQP1yri6ubdppFn7dFuqd1xPQ6Ow9o0n6tH
	nEvpAydB43bBPcvuoT1wZvQoF7QOjeNW0Vz4U1+zGabDcvlKRMygS1R5w8I6fmCh
	NoT0u5WV5c2B2eVXCyfFiL9B+BDQuEkhq5vclFGknxh53OGjdaZx7jwg/+HMKs2K
	nCu8=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 457535hy9b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 02:59:39 -0800 (PST)
Received: from twshared3076.40.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 10:59:19 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id D4C62C4C01E1; Thu,  6 Mar 2025 10:59:05 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Thu, 6 Mar 2025 10:58:46 +0000
Message-ID: <20250306105900.1961011-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: Uu_-sRFlwkNhjsCt37Ki8L1RUZNud6Qh
X-Proofpoint-ORIG-GUID: Uu_-sRFlwkNhjsCt37Ki8L1RUZNud6Qh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01

The inline function btrfs_is_testing() is hardcoded to return 0 if
CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set. Currently we're relying on
the compiler optimizing out the call to alloc_test_extent_buffer() in
btrfs_find_create_tree_block(), as it's not been defined (it's behind an
 #ifdef).

Add a stub version of alloc_test_extent_buffer() to avoid linker errors
on non-standard optimization levels. This problem was seen on GCC 14
with -O0.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/extent_io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fad42da1a6ba..03320f953817 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2984,10 +2984,10 @@ struct extent_buffer *find_extent_buffer(struct b=
trfs_fs_info *fs_info,
 	return eb;
 }
=20
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_=
info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists =3D NULL;
 	int ret;
=20
@@ -3023,8 +3023,14 @@ struct extent_buffer *alloc_test_extent_buffer(str=
uct btrfs_fs_info *fs_info,
 free_eb:
 	btrfs_release_extent_buffer(eb);
 	return exists;
-}
+#else
+	/*
+	 * stub to avoid linker error when compiled with optimizations
+	 * turned off
+	 */
+	return NULL;
 #endif
+}
=20
 static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs=
_info,
 						struct folio *folio)
--=20
2.45.3


