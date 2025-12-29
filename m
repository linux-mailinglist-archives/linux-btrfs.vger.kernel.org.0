Return-Path: <linux-btrfs+bounces-20031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 944E9CE59CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Dec 2025 01:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B684E3006A77
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Dec 2025 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A2D1339A4;
	Mon, 29 Dec 2025 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O88LwbwU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NGcrFIgF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B03A1E85
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766967847; cv=none; b=m95hetiCXscCvC1Trtn2AYF+g97hVk+LL6XrBA+m2Xq3Ma8MxSpGhUkcJMjiMUmvWzzCUE+1tuXL1x8wKPD5BVMO9HEczL91di/fPWmWqnTZwsSM6OhYClJLJjh4BgKmxn13ZM8sCZIKayHdC/P/olQ3ghpEqCr/cOxXNBEaxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766967847; c=relaxed/simple;
	bh=JVTJVqdJrKpX+xvAmUQn7/xtPvqg063BFvAlqDg4y8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wnz4yD0twrrYtTod7x2RPHPVuIked+0PVujr9LZPc+CgVJHCTuNexbmaI87oA3AZ5jQ3E3XP2srlxmcz/dmWsolpJdwpbZo5NNNtd+1mnAIFvqQ0UN1g2nTxvTayUD8y4MCJxlTkgAIVOjq2w2TAwDl117bFrp3wtHVdFFNrruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O88LwbwU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NGcrFIgF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2DC333974;
	Mon, 29 Dec 2025 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766967836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L8FA7m8FHkkc1k7vJK3OM7irB8nMuSdkDGMbwmhTe4Y=;
	b=O88LwbwU9LT1Dn7ntEo00RQ1SyV4qGLNyhQAMEYXB56ziAa2ECrFm3SmXIORBkUEHRbfJm
	u6PGqdl0iMvfJi7A/2zRgD1OqKafhUYu+EZnkYytkW0e74Zfhi0Ery9gvLRxzt8FDzkFpF
	Gij83As6aRjkzwOvpc6Zl5ZZV9z5p2c=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766967834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L8FA7m8FHkkc1k7vJK3OM7irB8nMuSdkDGMbwmhTe4Y=;
	b=NGcrFIgF0w9ck3Tt2ajg6YJkcSdGDuKjBsh+spCqHtayHBxZ3StGrp6uTysO0s3LJ6dVgN
	dVacyj7JMs7bzEtSbm/Qr1UZZeAfpeSHyiCE+8pnyjwZigryAVVu0LV6ZiA8U24wu72vDN
	QFvu9Pgz99HoBHPGSEtIDlK4HlYYozc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD54B3EA63;
	Mon, 29 Dec 2025 00:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oe+yHhnKUWmKGwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 29 Dec 2025 00:23:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: mikkel+btrfs@mikkel.cc
Subject: [PATCH] btrfs: dump the leaf if we failed to locate an inode ref
Date: Mon, 29 Dec 2025 10:53:35 +1030
Message-ID: <c0c129ddce57c27eb0ce22af51767047c80a0f3b.1766967799.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[btrfs];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,mikkel.cc:email,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

There are already two reports (one public and one private) of bitflips
that corrupted the fs and caused transaction abort.

The public report has a very strong indication of the bitflip in the
INODE_REF key type. Thankfully btrfs-check is able to detect it.

But the private report didn't preserve the environment and re-formatted
instead, making it much harder to know exactly what bitflip is, but the
call trace is the same as the public report, thus I have a strong
feeling it's a similar situation.

The problem here is, the only error message we got is just "failed to
delete reference to", no tree dump to confirm the root cause.

This is partly due to the fact that btrfs_del_inode_ref() doesn't
provide a path for us to dump the leaf.

To improve the situation, do an inode extref search (which should not
hit) and dump the leaf.
This will not cover all corner cases, e.g. an inode with a lot of
hard links, and our target ref is inside the regular inode ref item.
But for most inodes with few hard links, this should be good enough.

I created an image with exactly the same bitflip in inode ref key, and
try to delete the inode, with this patch the dump leaf is enough to pin
down the root cause:

 BTRFS critical (device dm-3): failed to delete reference to inline_13, root 5 inode 270 parent 256
 BTRFS info (device dm-3): leaf 30572544 gen 11 total ptrs 16 free space 2574 owner 5
 BTRFS info (device dm-3): refs 2 lock_owner 0 current 2634
 	item 0 key (267 EXTENT_DATA 0) itemoff 14214 itemsize 2069
 		generation 9 type 0
 		inline extent data size 2048 ram_bytes 2048 compression 0
	[...]
 	item 7 key (270 INODE_ITEM 0) itemoff 9558 itemsize 160
 		inode generation 9 transid 9 size 2048 nbytes 2048
 		block group 0 mode 100600 links 1 uid 0 gid 0
 		rdev 0 sequence 1 flags 0x0
 	item 8 key (270 UNKNOWN.8 256) itemoff 9539 itemsize 19 <<<
 	item 9 key (270 EXTENT_DATA 0) itemoff 7470 itemsize 2069
 		generation 9 type 0
 		inline extent data size 2048 ram_bytes 2048 compression 0
	[...]
 ------------[ cut here ]------------
 BTRFS: Transaction aborted (error -2)
 WARNING: inode.c:4445 at __btrfs_unlink_inode+0x42c/0x460 [btrfs], CPU#4: rm/2634
 [...]
 ---[ end trace 0000000000000000 ]---
 BTRFS: error (device dm-3 state A) in __btrfs_unlink_inode:4445: errno=-2 No such entry
 BTRFS info (device dm-3 state EA): forced readonly

Reported-by: mikkel+btrfs@mikkel.cc
Link: https://lore.kernel.org/linux-btrfs/5d5e344e-96be-4436-9a58-d60ba14fdb4f@gmx.com/T/#me22cef92653e660e88a4c005b10f5201a8fd83ac
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa9ce054ab1f..370dfb13d6f3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -72,6 +72,7 @@
 #include "raid-stripe-tree.h"
 #include "fiemap.h"
 #include "delayed-inode.h"
+#include "print-tree.h"
 
 #define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
 #define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
@@ -4349,6 +4350,36 @@ static void update_time_after_link_or_unlink(struct btrfs_inode *dir)
 	inode_set_mtime_to_ts(&dir->vfs_inode, now);
 }
 
+static __cold void dump_tree_for_inode_ref(struct btrfs_root *root,
+					   const struct fscrypt_str *name,
+					   u64 ino, u64 dir_ino)
+{
+	BTRFS_PATH_AUTO_RELEASE(path);
+	struct btrfs_key key;
+	int ret;
+
+	/*
+	 * We're here because we failed to find the inode ref, meaning neither
+	 * a matching INODE_REF nor INODE_EXTREF is found.
+	 * So we can directly go searching INODE_EXTREF.
+	 */
+	key.objectid = ino;
+	key.type = BTRFS_INODE_EXTREF_KEY;
+	key.offset = btrfs_extref_hash(dir_ino, name->name, name->len);
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return;
+
+	/*
+	 * We're at the slot where INODE_EXTREF should be inserted.
+	 * For an inode with tons of hard links it may not cover what we want
+	 * (e.g. a regular INODE_REF item).
+	 * But it should be good enough for most inodes which have very few
+	 * hard links.
+	 */
+	btrfs_print_leaf(path.nodes[0]);
+}
+
 /*
  * unlink helper that gets used here in inode.c and in the tree logging
  * recovery code.  It remove a link in a directory with a given name, and
@@ -4410,6 +4441,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		btrfs_crit(fs_info,
 	   "failed to delete reference to %.*s, root %llu inode %llu parent %llu",
 			   name->len, name->name, btrfs_root_id(root), ino, dir_ino);
+		dump_tree_for_inode_ref(root, name, ino, dir_ino);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-- 
2.52.0


