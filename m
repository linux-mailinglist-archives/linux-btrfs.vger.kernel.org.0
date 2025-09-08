Return-Path: <linux-btrfs+bounces-16716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65EB48929
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461703A766E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808152FB0B8;
	Mon,  8 Sep 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPPjomYI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766D2FB0A6
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325230; cv=none; b=MfkPa44/SUlWuXAaXIRqxyO7i2CV+B0Adm9lofhTvKL5C/7WKi5trL9JWc8Sh6viV3vLvHqAm11JvH4feDAYB+HyrDzZjg6lPBdxXhiwJaMfG1iawLtQ5oe6R2VsoYIUNoG5IO5y8eHwmX6MfYLJssMWzl7cWoHJ3V78x6hKYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325230; c=relaxed/simple;
	bh=Yf+7tdg6PyAzvJpid1TYysrW3etLRx+/F93GpVxtlpk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrs42HeYR7S8bqv4YH/eSOeAiynebJQAxJY5RSA06Kl3QLT/6dUarswcVCWM/spc/S+wwTX/OVzXwqjqWAen/9jRTq1oJolRBNHQ1XtP5d/TJZfZ2TXhHSfXnAyNvFsSsW1pfzSnEfeV2Nsax/splj0Wrip+IH4oEwOrtDhAHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPPjomYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADF1C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325230;
	bh=Yf+7tdg6PyAzvJpid1TYysrW3etLRx+/F93GpVxtlpk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iPPjomYITr6Cvl/h+obz76ADnT9PmFORdo0zxp2QFxjxQMm5SyC9d8FcZm0CU55qm
	 wZIIc0V2nxcjJ1lmnp5IhUAcs7ah3ezBaHlv65+oRxuMiKus2df1rUDo8iKKLlxxV7
	 aN8DqJ+rxay8W36AdXJXVPw75AMtg7JLE+gwTLpUCbrmqusU585pnKmmCp9H2jdvs8
	 sDyeBpo3gQzpLkw/5pTzBcYe7Kt0z17wLnB535tRxlc7+1ZXx06dohcn7ShO6FJDqD
	 PQZdgDJkjobI5KCY/wfewJfhb4x10PuZGRzTM6epqeZbn2BZ0SGfXVQ0Cjv6JV9YLs
	 3j2mbUQs3Q9KQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 21/33] btrfs: use the inode item boolean everywhere in overwrite_item()
Date: Mon,  8 Sep 2025 10:53:15 +0100
Message-ID: <b72b31ad082dd21987248e76e302b1824eeffd0b.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have this boolean 'inode_item' to tell if we are processing an inode
item key and we use it in a couple of places while in another two places
we open code by checking if the key type matches the inode item type.
Make this consistent and use the boolean everywhere. Also rename it from
'inode_item' to 'is_inode_item', which makes it more clear that it's a
boolean and not an instance of struct btrfs_inode_item, and make it const
too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 88e813bb28d8..d830c33be7c6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -424,7 +424,7 @@ static int overwrite_item(struct walk_control *wc,
 	unsigned long dst_ptr;
 	struct extent_buffer *dst_eb;
 	int dst_slot;
-	bool inode_item = key->type == BTRFS_INODE_ITEM_KEY;
+	const bool is_inode_item = (key->type == BTRFS_INODE_ITEM_KEY);
 
 	/*
 	 * This is only used during log replay, so the root is always from a
@@ -486,7 +486,7 @@ static int overwrite_item(struct walk_control *wc,
 		 * We need to load the old nbytes into the inode so when we
 		 * replay the extents we've logged we get the right nbytes.
 		 */
-		if (inode_item) {
+		if (is_inode_item) {
 			struct btrfs_inode_item *item;
 			u64 nbytes;
 			u32 mode;
@@ -507,7 +507,7 @@ static int overwrite_item(struct walk_control *wc,
 			if (S_ISDIR(mode))
 				btrfs_set_inode_size(eb, item, 0);
 		}
-	} else if (inode_item) {
+	} else if (is_inode_item) {
 		struct btrfs_inode_item *item;
 		u32 mode;
 
@@ -561,7 +561,7 @@ static int overwrite_item(struct walk_control *wc,
 	 * state of the tree found in the subvolume, and i_size is modified
 	 * as it goes
 	 */
-	if (key->type == BTRFS_INODE_ITEM_KEY && ret == -EEXIST) {
+	if (is_inode_item && ret == -EEXIST) {
 		struct btrfs_inode_item *src_item;
 		struct btrfs_inode_item *dst_item;
 
@@ -602,7 +602,7 @@ static int overwrite_item(struct walk_control *wc,
 	}
 
 	/* make sure the generation is filled in */
-	if (key->type == BTRFS_INODE_ITEM_KEY) {
+	if (is_inode_item) {
 		struct btrfs_inode_item *dst_item;
 
 		dst_item = (struct btrfs_inode_item *)dst_ptr;
-- 
2.47.2


