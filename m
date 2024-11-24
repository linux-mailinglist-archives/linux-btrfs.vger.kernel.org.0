Return-Path: <linux-btrfs+bounces-9850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505309D6E3B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6AFB20C4B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CDC1AB517;
	Sun, 24 Nov 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaNZrzdE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630311AA7AB;
	Sun, 24 Nov 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451981; cv=none; b=W4eVN3+pW1KMGvJ8gfwI5yhLj+SIcluX0pj86bBhSKTUBtfA2UMREV7hjmewGBRL5t/nwi78v/gvGWkzBkgz89oU+HqRwyGnRzznPxt2jBX9LWnfGs3idQqRA9SEwAlmHe7M/zeE6hxTmHZtM0MSognoIzjDvZtNf97aXCmw6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451981; c=relaxed/simple;
	bh=fD4Gm0VBHaWWOVQgwWAlB3zvAoMr9UsEVB/+Zbl3fR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdtxIbzYjRbE5TAJOyomJndDQkR2DAEiRkUUihE29iYshWW/UCI/so/p9S13huwjoe/qct/usmpcWmw6m+J9T/sFP6tHzdIiRZS6mpoLqlKYxlt6LF3tGT9G90MH3ZHl55ndgNqfgvNIyeSw+tgjKi11Ri4P3ige7j7Ng7k5TyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaNZrzdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41389C4CED3;
	Sun, 24 Nov 2024 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451981;
	bh=fD4Gm0VBHaWWOVQgwWAlB3zvAoMr9UsEVB/+Zbl3fR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaNZrzdE9PUPvTmhD9lHuRIIFztlmYdnIrGnC4ai5GlpJIq7pKOzhXJiuQTIfloxU
	 BmI+DUkWk6WidpHWeFAS40KcPym1d5/oBl9YEtvHoEO+GuPd592yfFU4xp154Tr+of
	 DA60WwPv/CV0tV05xsBwIUYBMohZ2MqqRtcwkxxPGNJM83O8/4X2y3Tdc9taUsRbtv
	 0mBn2PLxbqpQUpLP5QT9WcJae/pYN6a0DNhodyJk3no0EMkpZZ5EzjrAS3jaSvWRdV
	 PfDiV1S1KAygNlSXw95YgxPUyMHggTpr2mFtoeqU2a6ANu/N7yUucA3YwmwUMr6vyM
	 XS29mQCF3yStA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 13/19] btrfs: reduce lock contention when eb cache miss for btree search
Date: Sun, 24 Nov 2024 07:38:48 -0500
Message-ID: <20241124123912.3335344-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Robbie Ko <robbieko@synology.com>

[ Upstream commit 99785998ed1cea142e20f4904ced26537a37bf74 ]

When crawling btree, if an eb cache miss occurs, we change to use the eb
read lock and release all previous locks (including the parent lock) to
reduce lock contention.

If an eb cache miss occurs in a leaf and needs to execute IO, before this
change we released locks only from level 2 and up and we read a leaf's
content from disk while holding a lock on its parent (level 1), causing
the unnecessary lock contention on the parent, after this change we
release locks from level 1 and up, but we lock level 0, and read leaf's
content from disk.

Because we have prepared the check parameters and the read lock of eb we
hold, we can ensure that no race will occur during the check and cause
unexpected errors.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 101 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0cc919d15b144..dd92acd66624f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1515,12 +1515,14 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	struct btrfs_tree_parent_check check = { 0 };
 	u64 blocknr;
 	u64 gen;
-	struct extent_buffer *tmp;
-	int ret;
+	struct extent_buffer *tmp = NULL;
+	int ret = 0;
 	int parent_level;
-	bool unlock_up;
+	int err;
+	bool read_tmp = false;
+	bool tmp_locked = false;
+	bool path_released = false;
 
-	unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
 	blocknr = btrfs_node_blockptr(*eb_ret, slot);
 	gen = btrfs_node_ptr_generation(*eb_ret, slot);
 	parent_level = btrfs_header_level(*eb_ret);
@@ -1551,68 +1553,105 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			 */
 			if (btrfs_verify_level_key(tmp,
 					parent_level - 1, &check.first_key, gen)) {
-				free_extent_buffer(tmp);
-				return -EUCLEAN;
+				ret = -EUCLEAN;
+				goto out;
 			}
 			*eb_ret = tmp;
-			return 0;
+			tmp = NULL;
+			ret = 0;
+			goto out;
 		}
 
 		if (p->nowait) {
-			free_extent_buffer(tmp);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto out;
 		}
 
-		if (unlock_up)
+		if (!p->skip_locking) {
 			btrfs_unlock_up_safe(p, level + 1);
-
-		/* now we're allowed to do a blocking uptodate check */
-		ret = btrfs_read_extent_buffer(tmp, &check);
-		if (ret) {
-			free_extent_buffer(tmp);
+			tmp_locked = true;
+			btrfs_tree_read_lock(tmp);
 			btrfs_release_path(p);
-			return ret;
+			ret = -EAGAIN;
+			path_released = true;
 		}
 
-		if (unlock_up)
-			ret = -EAGAIN;
+		/* Now we're allowed to do a blocking uptodate check. */
+		err = btrfs_read_extent_buffer(tmp, &check);
+		if (err) {
+			ret = err;
+			goto out;
+		}
 
+		if (ret == 0) {
+			ASSERT(!tmp_locked);
+			*eb_ret = tmp;
+			tmp = NULL;
+		}
 		goto out;
 	} else if (p->nowait) {
-		return -EAGAIN;
+		ret = -EAGAIN;
+		goto out;
 	}
 
-	if (unlock_up) {
+	if (!p->skip_locking) {
 		btrfs_unlock_up_safe(p, level + 1);
 		ret = -EAGAIN;
-	} else {
-		ret = 0;
 	}
 
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
 
-	tmp = read_tree_block(fs_info, blocknr, &check);
+	tmp = btrfs_find_create_tree_block(fs_info, blocknr, check.owner_root, check.level);
 	if (IS_ERR(tmp)) {
+		ret = PTR_ERR(tmp);
+		tmp = NULL;
+		goto out;
+	}
+	read_tmp = true;
+
+	if (!p->skip_locking) {
+		ASSERT(ret == -EAGAIN);
+		tmp_locked = true;
+		btrfs_tree_read_lock(tmp);
 		btrfs_release_path(p);
-		return PTR_ERR(tmp);
+		path_released = true;
+	}
+
+	/* Now we're allowed to do a blocking uptodate check. */
+	err = btrfs_read_extent_buffer(tmp, &check);
+	if (err) {
+		ret = err;
+		goto out;
 	}
+
 	/*
 	 * If the read above didn't mark this buffer up to date,
 	 * it will never end up being up to date.  Set ret to EIO now
 	 * and give up so that our caller doesn't loop forever
 	 * on our EAGAINs.
 	 */
-	if (!extent_buffer_uptodate(tmp))
+	if (!extent_buffer_uptodate(tmp)) {
 		ret = -EIO;
+		goto out;
+	}
 
-out:
 	if (ret == 0) {
+		ASSERT(!tmp_locked);
 		*eb_ret = tmp;
-	} else {
-		free_extent_buffer(tmp);
-		btrfs_release_path(p);
+		tmp = NULL;
+	}
+out:
+	if (tmp) {
+		if (tmp_locked)
+			btrfs_tree_read_unlock(tmp);
+		if (read_tmp && ret && ret != -EAGAIN)
+			free_extent_buffer_stale(tmp);
+		else
+			free_extent_buffer(tmp);
 	}
+	if (ret && !path_released)
+		btrfs_release_path(p);
 
 	return ret;
 }
@@ -2198,7 +2237,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
@@ -2325,7 +2364,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
-- 
2.43.0


