Return-Path: <linux-btrfs+bounces-15668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9DB11A23
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458B216EF23
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4862BFC73;
	Fri, 25 Jul 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q5lDMUUY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q5lDMUUY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D02C15A3
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432952; cv=none; b=lAi7HLK0uz9TrTlJ6yJz0YbCaKkYcS13hTfQZIrCagyYtPbP3IQ1GAcE3OFbe/070PUMPcqyjvNmpcZVDrj6BwYd4zzonT8HbWbkWZjkQc7mkiep7pXdUqbJU3rr6yiC/VEpymY4X3o8cON8x4YJw1d3JmxY49YI51H9DsuUz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432952; c=relaxed/simple;
	bh=cgCMukTHiCbpgpUKYn1fO2B6dC29ObD8lbw5Zaf61x0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m+MeCSvVOwL4jAVUUqJ1Zm7QDuRgxQ75oFghtGUWsqjO40JjmcBWDu5I4FEtD2avEKlfvs1sep+YPYUE913dPlDlp+HUauLvYco2izJFzQ12kUjJHYLyHzuzHwDbz5JOS0z/Pgc83a5baAsT29If7bVMzHTkxRX8THwFOzMv9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q5lDMUUY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q5lDMUUY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B47DD1F82F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753432948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f8RwtBDt+kOR/aZiWbSsfjXoPpH+2IoveaUqWvbpKT0=;
	b=Q5lDMUUYEx5yDE/V6eKc5gP084FMoJaNYHvCQ3/IVrCoUCCt1hnz1y/jUMpsXk62Y+I85u
	3SVqXYLnfNyOFtYuUKJE/vc7FvbXkhFFEJpI1junyIvdUwxWQOJ09q83lHeOJOOoFsUqjC
	nZE3UlGIAfQnMRrgZotsgVEeWMrH0m0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753432948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f8RwtBDt+kOR/aZiWbSsfjXoPpH+2IoveaUqWvbpKT0=;
	b=Q5lDMUUYEx5yDE/V6eKc5gP084FMoJaNYHvCQ3/IVrCoUCCt1hnz1y/jUMpsXk62Y+I85u
	3SVqXYLnfNyOFtYuUKJE/vc7FvbXkhFFEJpI1junyIvdUwxWQOJ09q83lHeOJOOoFsUqjC
	nZE3UlGIAfQnMRrgZotsgVEeWMrH0m0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDE39134E8
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 08:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zl4mK3NDg2i9YgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 08:42:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not call btrfs_copy_root() on half-dropped subvolume
Date: Fri, 25 Jul 2025 18:12:06 +0930
Message-ID: <8a7bb9f34f314ca33eff7ed726ab074aaf681521.1753432924.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[BUG]
There is an internal report that balance triggered transaction abort,
with the following call trace:

  item 85 key (594509824 169 0) itemoff 12599 itemsize 33
          extent refs 1 gen 197740 flags 2
          ref#0: tree block backref root 7
  item 86 key (594558976 169 0) itemoff 12566 itemsize 33
          extent refs 1 gen 197522 flags 2
          ref#0: tree block backref root 7
 ...
 BTRFS error (device loop0): extent item not found for insert, bytenr 594526208 num_bytes 16384 parent 449921024 root_objectid 934 owner 1 offset 0
 BTRFS error (device loop0): failed to run delayed ref for logical 594526208 num_bytes 16384 type 182 action 1 ref_mod 1: -117
 ------------[ cut here ]------------
 BTRFS: Transaction aborted (error -117)
 WARNING: CPU: 1 PID: 6963 at ../fs/btrfs/extent-tree.c:2168 btrfs_run_delayed_refs+0xfa/0x110 [btrfs]

And btrfs check doesn't report anything wrong related to the extent
tree.

[CAUSE]
The cause is a little complex, firstly the extent tree indeed doesn't
have the backref for 594526208.

The extent tree only have the following two backrefs around that bytenr
on-disk:

        item 65 key (594509824 METADATA_ITEM 0) itemoff 13880 itemsize 33
                refs 1 gen 197740 flags TREE_BLOCK
                tree block skinny level 0
                (176 0x7) tree block backref root CSUM_TREE
        item 66 key (594558976 METADATA_ITEM 0) itemoff 13847 itemsize 33
                refs 1 gen 197522 flags TREE_BLOCK
                tree block skinny level 0
                (176 0x7) tree block backref root CSUM_TREE

But the such missing backref item is not an corruption on disk, as the
offending delayed ref belongs to subvolume 934, and that subvolume is
being dropped:

        item 0 key (934 ROOT_ITEM 198229) itemoff 15844 itemsize 439
                generation 198229 root_dirid 256 bytenr 10741039104 byte_limit 0 bytes_used 345571328
                last_snapshot 198229 flags 0x1000000000001(RDONLY) refs 0
                drop_progress key (206324 EXTENT_DATA 2711650304) drop_level 2
                level 2 generation_v2 198229

And that offending tree block 594526208 is inside the dropped range of
that subvolume.
That explains why there is no backref item for that bytenr and why btrfs
check is not reporting anything wrong.

But this also shows another problem, as btrfs will do all the orphan
subvolume cleanup at a read-write mount.

So half-dropped subvolume should not exist after an RW mount, and
balance itself is also exclusive to subvolume cleanup, meaning we
shouldn't hit a subvolume half-dropped during relocation.

The root cause is, there is no orphan item for this subvolume.
In fact there are 5 subvolumes around 2021 that have the same problem.

It looks like the original report has some older kernels running, and
caused those zombie subvolumes.

Thankfully upstream commit 8d488a8c7ba2 ("btrfs: fix subvolume/snapshot
deletion not triggered on mount") has long fixed the bug.

[ENHANCEMENT]
For repairing such old fs, btrfs-progs will be enhanced.

Considering how delayed the problem will show up (at run delayed ref
time) and at that time we have to abort transaction already, it is too
late.

Instead here we reject any half-dropped subvolume for reloc tree, so
at least the fs can keep read-write operations until btrfs-progs is
utilized to add back the missing orphan items.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 60dd3971c3ae..a43d635d861b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -602,6 +602,23 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	if (btrfs_root_id(root) == objectid) {
 		u64 commit_root_gen;
 
+		/*
+		 * Relocation will wait for cleaner thread, and any half-dropped
+		 * subvolume will be fully cleaned up at mount time.
+		 * So here we shouldn't hit a subvolume with non-zero drop_progress.
+		 *
+		 * If this happened, it means the subvolume has experienced some bug
+		 * which didn't insert the correct orphan item for it.
+		 * Error out early, as btrfs_copy_root() can increase refs on already
+		 * dropped nodes/leaves and cause problems later at delayed ref runtime.
+		 */
+		if (unlikely(btrfs_disk_key_objectid(&root->root_item.drop_progress))) {
+			btrfs_err(fs_info,
+		"subvolume %llu is not properly cleaned up before relocation",
+				  objectid);
+			return ERR_PTR(-EUCLEAN);
+		}
+
 		/* called by btrfs_init_reloc_root */
 		ret = btrfs_copy_root(trans, root, root->commit_root, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
-- 
2.50.0


