Return-Path: <linux-btrfs+bounces-14485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB3ACF437
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FDC7AB8F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A12749E8;
	Thu,  5 Jun 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a+HS8ga0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B62E659
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140637; cv=none; b=llDuFgK7LcOVYVA38I51xSTGo+ked1igBFxwPfzayLXn1UI4bNHmJOMmdXyxDX3Z4XKGtWmPj6tlW9GGd/k0qSFLF8LQjtTcufzP2/XGjjbCM6lnPTbMVUO/00XD/BHil5Kg3fRbs/UeXsacnlKQMI5pW0DonRFRywYJSmQxUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140637; c=relaxed/simple;
	bh=30kyVnqj5m88qi/hv4Zh97gujMecwKwMOidFy+I5EoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej9f8YQDbrz9ZUf8W4YZGrqzHVPWWbkeK6vOSxUWAMnZ2fqxf1BqDQpOpd9TqnLm3mVuOB8lS3SPYvW6fn7qN+4Fv8IRCkaqHuXAdtTKje63Qq0afzsxkyhP2j7tsnw+LYdMTdVrPoAVoYdAlqOl9P/2uzAYBrSzYG4XmHXlK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=a+HS8ga0; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bS027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=T
	lFa1XtkRuOWXhPCJvlwSTzrcy/eC9xfsSIWKG4VIUA=; b=a+HS8ga0o9MlkCW/k
	ylFzhT70hjksyzCYslhrQBA77TzKq9fHNwoK9+yFBI4ba0wR0+KK9Eh7p7ASizku
	eO5FP00o7Qt0oWTfwEKCicxB2e75/Z60T/7anutG5+xK0JejifYMucctjQH2uYKD
	U0A8wwcClvyCQiXwNLMDd0l7/c=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:54 -0700 (PDT)
Received: from twshared0377.32.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:51 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 4868AFEC2E66; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 04/12] btrfs: remove remapped block groups from the free-space tree
Date: Thu, 5 Jun 2025 17:23:34 +0100
Message-ID: <20250605162345.2561026-5-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c49a cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=FOH2dFAWAAAA:8 a=Qc5qBXgPbixPto1ALjsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX0/ae1K+jMcQp y2cV5RIhISCF+emSSZASbS1AmWF8GclQpKRBeDtzhYKTuE7Yl6ubRaye5jCKqwSrb0psbs613g3 X3L/Q50yW7hu5m4v4cnPL/yRzsXRYBRULCq0eOc6/Zz/p3CvFuMqEHZgiWStlZ/7mHNCwTs3rWb
 JSIYYfnNcJFrfYbugijBpGgu81BebywA0cyWJMgqvHCuwzQngSDjEn6cn2NYK3rasXvhE8ITHOu 2Nn4G1Mp8zP8fRUIPU2CxpZXAayy1PeAnt1Kh6LDKwEGTqB3LL2eSPO60GGScE5lfpJ3XuqXVLe xzbKbnYqvyvWg8mZNX7IXEiM62WL5mpYxdfbZNEhZyO7tGrw6s5UWZdKUBMDIOmc9WQWpSj9Oxd
 +i99tDdmGMeJpVENwW+e/5OhGUlA8mmWbVatMtYPfFSRY8WuR8AT/eUdcZf8Sz/0esbPpipa
X-Proofpoint-GUID: Oc9h3IehkaHu3eaP2Lsa9arSV-k-zLHy
X-Proofpoint-ORIG-GUID: Oc9h3IehkaHu3eaP2Lsa9arSV-k-zLHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

No new allocations can be done from block groups that have the REMAPPED f=
lag
set, so there's no value in their having entries in the free-space tree.

Prevent a search through the free-space tree being scheduled for such a
block group, and prevent discard being run for a fully-remapped block
group.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 fs/btrfs/block-group.c | 21 ++++++++++++++++-----
 fs/btrfs/discard.c     |  9 +++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5b0cb04b2b93..9b3b5358f1ba 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -920,6 +920,13 @@ int btrfs_cache_block_group(struct btrfs_block_group=
 *cache, bool wait)
 	if (btrfs_is_zoned(fs_info))
 		return 0;
=20
+	/*
+	 * No allocations can be done from remapped block groups, so they have
+	 * no entries in the free-space tree.
+	 */
+	if (cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)
+		return 0;
+
 	caching_ctl =3D kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
@@ -1235,9 +1242,11 @@ int btrfs_remove_block_group(struct btrfs_trans_ha=
ndle *trans,
 	 * another task to attempt to create another block group with the same
 	 * item key (and failing with -EEXIST and a transaction abort).
 	 */
-	ret =3D remove_block_group_free_space(trans, block_group);
-	if (ret)
-		goto out;
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
+		ret =3D remove_block_group_free_space(trans, block_group);
+		if (ret)
+			goto out;
+	}
=20
 	ret =3D remove_block_group_item(trans, path, block_group);
 	if (ret < 0)
@@ -2457,10 +2466,12 @@ static int read_one_block_group(struct btrfs_fs_i=
nfo *info,
 	if (btrfs_chunk_writeable(info, cache->start)) {
 		if (cache->used =3D=3D 0) {
 			ASSERT(list_empty(&cache->bg_list));
-			if (btrfs_test_opt(info, DISCARD_ASYNC))
+			if (btrfs_test_opt(info, DISCARD_ASYNC) &&
+			    !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
 				btrfs_discard_queue_work(&info->discard_ctl, cache);
-			else
+			} else {
 				btrfs_mark_bg_unused(cache);
+			}
 		}
 	} else {
 		inc_block_group_ro(cache, 1);
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 89fe85778115..1015a4d37fb2 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -698,6 +698,15 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs=
_fs_info *fs_info)
 	/* We enabled async discard, so punt all to the queue */
 	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
 				 bg_list) {
+		/* Fully remapped BGs have nothing to discard */
+		spin_lock(&block_group->lock);
+		if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+		    !btrfs_is_block_group_used(block_group)) {
+			spin_unlock(&block_group->lock);
+			continue;
+		}
+		spin_unlock(&block_group->lock);
+
 		list_del_init(&block_group->bg_list);
 		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
 		/*
--=20
2.49.0


