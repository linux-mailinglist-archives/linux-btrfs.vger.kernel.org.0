Return-Path: <linux-btrfs+bounces-17130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DBEB97859
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 22:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BC216C5DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3F2FD1B1;
	Tue, 23 Sep 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ldxgUygj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dewvRW53"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE9171C9
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660553; cv=none; b=qPxE3a8nPZYCjsCwSMeTiDFd/sUt+qUGPSAWqveRLdAZbOGK6dUiUbtFFoGEnec0Wv0PLsTdbBrWIl8bcmEDaOKt2c0eNIoYl4U7aOO9rs2N/lezKK1BAFn669/2sI5HIHn3CI9vMAgulLV5+GmjQ9cwloEwqx0IE8UaUVb+MIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660553; c=relaxed/simple;
	bh=grbaXNnKHiVkNSTn1jXCX/J6vTD3MVval/MwlvYDmUI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K5lnAhKf30cg9ncViajop53SRd3sKwz2zOd7ZyAg70Usxc3Jld0ot1ECeKcrFqQxf53rr0fjJpUj4/QbjkoXsi39Wn1xlOiPtiZfvasF43d2m/YR+ZjMn89GG2/4hPGpTeJQrVjgm2RDVGsp31cJaJBEaYpZZXJOwH/nPRIYQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ldxgUygj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dewvRW53; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4825D7A0349;
	Tue, 23 Sep 2025 16:49:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 16:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1758660550; x=1758746950; bh=xHDALwg/FlnO89hH7NvGm
	pAML0dkiMriIyDfvuvCx2Q=; b=ldxgUygjl49CJOXBGtUBsmcjRQk7jTeTcUF0B
	h+zsmf2xnyx/fBVoYhZGKk3TgsBstjBBuWUOnd1zHwf3/Bx63acDkDjI1oGeRu6d
	+cBOzLL34dPQ41gumKwdoTsavlupPLRCMIV5gpFdpODc3LI1eBlPwVHuwwVmOHBL
	hOdAa4ymx8J2VSWquvfMkKPvRgpsA9N0jTX20bgJjmCpA4llj/HSOdPzM+y7HgpO
	u+nA+miumcguJAFYH1DaVqVkcurNJJPQG788GO8ohCAHaI//WN9UAhLfDo7pLs1z
	1MUdFxbgXrmgQk31O3a1+o63QJ+23gbPnFj3aXSB30OpYwMHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758660550; x=1758746950; bh=xHDALwg/FlnO89hH7NvGmpAML0dkiMriIyD
	fvuvCx2Q=; b=dewvRW53W2hHpl11czuhapn4ae1HrfHbLim8nVxJBhgLs6YvCqo
	gf9uuV7H1LZ34++4VEUI2qa47005VTAwKLixWmCt/MBqs0Wn/AxdTVIiVAB9AFWH
	+dR3GGZvtw1BVGBAxHKH/9pBs6DOMvYweUzqtIWrGVaUDpqoooBxcw/+35h90bgX
	Zk8dqhNKinYP69GVDJi2qAZFTfddxcJiIaCrXj0kI/iqxWaQw4V4uslYX5aZKu6N
	N6xc4cg5RPnWA4HtsM8ax4ua90USBKvyOmKigBN/vxUqYKw+6gdXRgortTmjPqcy
	PAPzYvDL1YX+I3pQ2GV/eYEobwYcDuvTr8g==
X-ME-Sender: <xms:xQfTaAOZCnuWucZk-G2z9sPcTh1zmwNQpFQNsub-V7LEhHwmh8nhjA>
    <xme:xQfTaM93U2r2v1ueXyfA5rkSeykvQD6BmQRD6iOLXxPvEWZ-aKyNQNmEWkSBOJqbG
    R6FdmbymLVI0ZHPoKQkAAaVHbmlV1ZI2JX0TcjkZf03-o9L8lml91xk>
X-ME-Received: <xmr:xQfTaE7zSmwiuN_ZaY4W09ruE45d14WRpySOc0H0iDtF4WyjPhXuOtMIGiprYmiOgHuKrtZ0l2vX2JzWXXj43lDghqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:xQfTaD31Q4o-Hw1J0jMxXyIRUk_e6KpzW4g0eZT7nkuE6pZDc9b_YQ>
    <xmx:xQfTaLC2RtEe276yQ7zuJZX5qecbWhBf4autdWIkTuGSzgBUQx_Ujw>
    <xmx:xQfTaF3UFUtbeLWLB0M3sEhrtJxtGvd7pqS6tVluiiVEY-2--PuEFw>
    <xmx:xQfTaFusZ9wGNLGSiWWTkWMyEe3GL0bMHcjlIOkg1u82xe5PxU0KMA>
    <xmx:xgfTaPwW7hwPWNaFuxxubbf4KE5dufh-QtXV0AMp5zeTcX_Pro9aFVba>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 16:49:09 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: handle ENOMEM from alloc_bitmap()
Date: Tue, 23 Sep 2025 13:49:04 -0700
Message-ID: <0380625eee35a412417a8780e74255830486f2d6.1758660529.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_convert_free_space_to_bitmaps() and
btrfs_convert_free_space_to_extents() both allocate a bitmap struct
with:

        bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
        bitmap = alloc_bitmap(bitmap_size);
        if (!bitmap) {
                ret = -ENOMEM;
                btrfs_abort_transaction(trans);
                return ret;
        }

This conversion is done based on a heuristic and the check triggers each
time we call update_free_space_extent_count() on a block group (each
time we add/remove an extent or modify a bitmap). Furthermore, nothing
relies on maintaining some invariant of bitmap density, it's just an
optimization for space usage. Therefore, it is safe to simply ignore
any memory allocation errors that occur, rather than aborting the
transaction and leaving the fs read only.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/free-space-tree.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index eba7f22ae49c..18008e288acd 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -218,11 +218,8 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 
 	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
 	bitmap = alloc_bitmap(bitmap_size);
-	if (!bitmap) {
-		ret = -ENOMEM;
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
+	if (!bitmap)
+		return 0;
 
 	start = block_group->start;
 	end = block_group->start + block_group->length;
@@ -361,11 +358,8 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 
 	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
 	bitmap = alloc_bitmap(bitmap_size);
-	if (!bitmap) {
-		ret = -ENOMEM;
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
+	if (!bitmap)
+		return 0;
 
 	start = block_group->start;
 	end = block_group->start + block_group->length;
-- 
2.50.1


