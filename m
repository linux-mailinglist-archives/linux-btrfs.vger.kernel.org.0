Return-Path: <linux-btrfs+bounces-21716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLnjCR6zlGlbGgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21716-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:27:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CEC14F1D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54D7E3008CB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63068372B51;
	Tue, 17 Feb 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvTguNo/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5652372B2D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352850; cv=none; b=nj5tfsx4IHf7OZmYMEUwtGP2/V8Ap/nTgGdUPg08n75tDMM8na7d5xVJla3WqGXmZbkcBDDmDEixOPEoqbExLCbemGsPfhSZbuosDsD3QTtTrPrNJYXG/y2rxZslWybyZ4BQTTvx7MvCwZO9V8XgO6GmShTYoG6FvFklojymuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352850; c=relaxed/simple;
	bh=7gyVcx/FSfNUIeKRKKHjGavKZU5cdNaKTrxxWfeRcKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiHAhkH4u1ugY7E1nm0iuOzM/1StCWVqU5rZ2i6GFUg2p8t7DpMeFZuQ3Gx3Nn5p8l9sk+3WsLDDNy5OW9WkOfamwWmzDOmnLbgUyZ/0okeD4i8tls0bP9XGw+T83MHsq9KeEbDVgG6jNea40TzkOcto/uerL0dU3kNs5i6B2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvTguNo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D2C19421
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352850;
	bh=7gyVcx/FSfNUIeKRKKHjGavKZU5cdNaKTrxxWfeRcKs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lvTguNo/IcN2lzrAAdWXMV3+c5nbV85Q4uepx84LUFjGtVuXwWw9Trn1CoOU8CiTk
	 DA/ahNKzvLZL4cfoRCyLcC9LQf8CprxA/ef9s5Z9RGLV4eN1oLcg86OmcNgX++GX2m
	 rkZf2/gl3h7tSosZDXM2iSedyYa1KkBSJFE99KRWMTn2o2ZjMIQ6kQGtqB/FOHRXQv
	 RMMgtKIscUj+UnjpHajv273+s3tQWoKKrWzsXhZckQEy9F9NcF8MNN1g01K1K3blIq
	 RSqd340sY0H3k0FjG0ti8LZl+XTWaNYFLyUpLtF8OxGZ3P9G4ni7WlzugIjzdya7+l
	 q2bLtiGCVGdnQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix zero size inode with non-zero size after log replay
Date: Tue, 17 Feb 2026 18:27:25 +0000
Message-ID: <1c66bd7efe749cd3b421fc3dff5ef646dda8c7aa.1771350720.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1771350720.git.fdmanana@suse.com>
References: <cover.1771350720.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21716-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87CEC14F1D6
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

When logging that an inode exists, as part of logging a new name or
logging new dir entries for a directory, we always set the generation of
the logged inode item to 0. This is to signal during log replay (in
overwrite_item()), that we should not set the i_size since we only logged
that an inode exists, so the i_size of the inode in the subvolume tree
must be preserved (as when we log new names or that an inode exists, we
don't log extents).

This works fine except when we have already logged an inode in full mode
or it's the first time we are logging an inode created in a past
transaction, that inode has a new i_size of 0 and then we log a new name
for the inode (due to a new hardlink or a rename), in which case we log
an i_size of 0 for the inode and a generation of 0, which causes the log
replay code to not update the inode's i_size to 0 (in overwrite_item()).

An example scenario:

  mkdir /mnt/dir
  xfs_io -f -c "pwrite 0 64K" /mnt/dir/foo

  sync

  xfs_io -c "truncate 0" -c "fsync" /mnt/dir/foo

  ln /mnt/dir/foo /mnt/dir/bar

  xfs_io -c "fsync" /mnt/dir

  <power fail>

After log replay the file remains with a size of 64K. This is because when
we first log the inode, when we fsync file foo, we log its current i_size
of 0, and then when we create a hard link we log again the inode in exists
mode (LOG_INODE_EXISTS) but we set a generation of 0 for the inode item we
add to the log tree, so during log replay overwrite_item() sees that the
generation is 0 and i_size is 0 so we skip updating the inode's i_size
from 64K to 0.

Fix this by making sure at fill_inode_item() we always log the real
generation of the inode if it was logged in the current transaction with
the i_size we logged before. Also if an inode created in a previous
transaction is logged in exists mode only, make sure we log the i_size
stored in the inode item located from the commit root, so that if we log
multiple times that the inode exists we get the correct i_size.

A test case for fstests will follow soon.

Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/af8c15fa-4e41-4bb2-885c-0bc4e97532a6@gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 98 ++++++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 603ac3794b9c..504b2cb84857 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4616,21 +4616,32 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 			    struct inode *inode, bool log_inode_only,
 			    u64 logged_isize)
 {
+	u64 gen = BTRFS_I(inode)->generation;
 	u64 flags;
 
 	if (log_inode_only) {
-		/* set the generation to zero so the recover code
-		 * can tell the difference between an logging
-		 * just to say 'this inode exists' and a logging
-		 * to say 'update this inode with these values'
+		/*
+		 * Set the generation to zero so the recover code can tell the
+		 * difference between a logging just to say 'this inode exists'
+		 * and a logging to say 'update this inode with these values'.
+		 * But only if the inode was not already logged before.
+		 * We access ->logged_trans directly since it was already set
+		 * up in the call chain by btrfs_log_inode(), and data_race()
+		 * to avoid false alerts from KCSAN and since it was set already
+		 * and one can set it to 0 since that only happens on eviction
+		 * and we are holding a ref on the inode.
 		 */
-		btrfs_set_inode_generation(leaf, item, 0);
+		ASSERT(data_race(BTRFS_I(inode)->logged_trans) > 0);
+		if (data_race(BTRFS_I(inode)->logged_trans) < trans->transid)
+			gen = 0;
+
 		btrfs_set_inode_size(leaf, item, logged_isize);
 	} else {
-		btrfs_set_inode_generation(leaf, item, BTRFS_I(inode)->generation);
 		btrfs_set_inode_size(leaf, item, inode->i_size);
 	}
 
+	btrfs_set_inode_generation(leaf, item, gen);
+
 	btrfs_set_inode_uid(leaf, item, i_uid_read(inode));
 	btrfs_set_inode_gid(leaf, item, i_gid_read(inode));
 	btrfs_set_inode_mode(leaf, item, inode->i_mode);
@@ -5448,42 +5459,63 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static int logged_inode_size(struct btrfs_root *log, struct btrfs_inode *inode,
-			     struct btrfs_path *path, u64 *size_ret)
+static int get_inode_size_to_log(struct btrfs_trans_handle *trans,
+				 struct btrfs_inode *inode,
+				 struct btrfs_path *path, u64 *size_ret)
 {
 	struct btrfs_key key;
+	struct btrfs_inode_item *item;
 	int ret;
 
 	key.objectid = btrfs_ino(inode);
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, log, &key, path, 0, 0);
-	if (ret < 0) {
-		return ret;
-	} else if (ret > 0) {
-		*size_ret = 0;
-	} else {
-		struct btrfs_inode_item *item;
+	/*
+	 * Our caller called inode_logged(), so logged_trans is up to date.
+	 * Use data_race() to silence any warning from KCSAN. Once logged_trans
+	 * is set, it can only be reset to 0 after inode eviction.
+	 */
+	if (data_race(inode->logged_trans) == trans->transid) {
+		ret = btrfs_search_slot(NULL, inode->root->log_root, &key, path, 0, 0);
+	} else if (inode->generation < trans->transid) {
+		path->search_commit_root = true;
+		path->skip_locking = true;
+		ret = btrfs_search_slot(NULL, inode->root, &key, path, 0, 0);
+		path->search_commit_root = false;
+		path->skip_locking = false;
 
-		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				      struct btrfs_inode_item);
-		*size_ret = btrfs_inode_size(path->nodes[0], item);
-		/*
-		 * If the in-memory inode's i_size is smaller then the inode
-		 * size stored in the btree, return the inode's i_size, so
-		 * that we get a correct inode size after replaying the log
-		 * when before a power failure we had a shrinking truncate
-		 * followed by addition of a new name (rename / new hard link).
-		 * Otherwise return the inode size from the btree, to avoid
-		 * data loss when replaying a log due to previously doing a
-		 * write that expands the inode's size and logging a new name
-		 * immediately after.
-		 */
-		if (*size_ret > inode->vfs_inode.i_size)
-			*size_ret = inode->vfs_inode.i_size;
+	} else {
+		*size_ret = 0;
+		return 0;
 	}
 
+	/*
+	 * If the inode was logged before or is from a past transaction, then
+	 * its inode item must exist in the log root or in the commit root.
+	 */
+	ASSERT(ret <= 0);
+	if (WARN_ON_ONCE(ret > 0))
+		ret = -ENOENT;
+
+	if (ret < 0)
+		return ret;
+
+	item = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			      struct btrfs_inode_item);
+	*size_ret = btrfs_inode_size(path->nodes[0], item);
+	/*
+	 * If the in-memory inode's i_size is smaller then the inode size stored
+	 * in the btree, return the inode's i_size, so that we get a correct
+	 * inode size after replaying the log when before a power failure we had
+	 * a shrinking truncate followed by addition of a new name (rename / new
+	 * hard link). Otherwise return the inode size from the btree, to avoid
+	 * data loss when replaying a log due to previously doing a write that
+	 * expands the inode's size and logging a new name immediately after.
+	 */
+	if (*size_ret > inode->vfs_inode.i_size)
+		*size_ret = inode->vfs_inode.i_size;
+
 	btrfs_release_path(path);
 	return 0;
 }
@@ -6990,7 +7022,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			ret = drop_inode_items(trans, log, path, inode,
 					       BTRFS_XATTR_ITEM_KEY);
 	} else {
-		if (inode_only == LOG_INODE_EXISTS && ctx->logged_before) {
+		if (inode_only == LOG_INODE_EXISTS) {
 			/*
 			 * Make sure the new inode item we write to the log has
 			 * the same isize as the current one (if it exists).
@@ -7004,7 +7036,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			 * (zeroes), as if an expanding truncate happened,
 			 * instead of getting a file of 4Kb only.
 			 */
-			ret = logged_inode_size(log, inode, path, &logged_isize);
+			ret = get_inode_size_to_log(trans, inode, path, &logged_isize);
 			if (ret)
 				goto out_unlock;
 		}
-- 
2.47.2


