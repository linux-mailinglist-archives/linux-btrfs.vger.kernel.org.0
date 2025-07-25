Return-Path: <linux-btrfs+bounces-15670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAADB11D12
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B8E540CE2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 11:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAA2D374E;
	Fri, 25 Jul 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OVRgHEDg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OVRgHEDg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C93217F33
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441432; cv=none; b=KWDlsGoOF8zIlR97HHwCYqcOzj/9DyverToOe1vuXWh4tx6k1UUmpLFfcOOpLnUUhdJAFeWzTTCsjnI7lN6heQvWGVmsy1jtvE12Qwvs9R3i/O5TytXosQf3Tkd9L9wefViJPO7kPll6y1nXH16AGBnHVnyZ3RHXdCLVyeyO0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441432; c=relaxed/simple;
	bh=gHNv0jTlrLyAjlHgm7bA7pebGyRa6O4wwC3nDS9rHe0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LUFEsCvc8xX9EASe4rFeyFbNczggje+3nH9vEwOMTHfrjxKjSmF5bnWo+45sQv0LD5wXHhhHAP7zguf9ZtbwacRCFbFwqGnXHK9rH3Os8c/9oYOiq8OPTOkPwbPZfmRnvnhd5nCQ1IezbWx8bBSvS7ENVoFPl6Yp7B7D8mzjY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OVRgHEDg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OVRgHEDg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A849F219C5
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753441427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aeRKQk/vfXDQdShtza54cExxqbOnNswXpeV3KhZ3ffI=;
	b=OVRgHEDgfzOZaZKnr8zB33b4I96qjAXKrle2Fggb+iaF4VRaQ5wui/WW8vUrqrDmFPGrD4
	TG/YOF2DLUnUcF4iYH77TGlRB1dO6bZ/NLIhx0U2qmjfzdQFTpVMy6eDhYRuccCBQWke0J
	Sg01AP4Kmy6EVfUKLzsuqByVre/SwXo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753441427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aeRKQk/vfXDQdShtza54cExxqbOnNswXpeV3KhZ3ffI=;
	b=OVRgHEDgfzOZaZKnr8zB33b4I96qjAXKrle2Fggb+iaF4VRaQ5wui/WW8vUrqrDmFPGrD4
	TG/YOF2DLUnUcF4iYH77TGlRB1dO6bZ/NLIhx0U2qmjfzdQFTpVMy6eDhYRuccCBQWke0J
	Sg01AP4Kmy6EVfUKLzsuqByVre/SwXo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6208134E8
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 11:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QYqfKZJkg2gMEQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 11:03:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: do not allow relocation of partially dropped subvolumes
Date: Fri, 25 Jul 2025 20:33:25 +0930
Message-ID: <bbc7c6af95f7628d4d0a517358e7e9c2e421ccc5.1753441296.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
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

Instead here we reject any half-dropped subvolume for reloc tree at the
earliest time, preventing confusion and extra time wasted on debugging
similar bugs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Update the subject to reflect the change better
- Fix a memory leak when the check is triggered
- Make the error message less confusing
  All thanks to Filipe.
---
 fs/btrfs/relocation.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 60dd3971c3ae..c33c591b23f2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -602,6 +602,25 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	if (btrfs_root_id(root) == objectid) {
 		u64 commit_root_gen;
 
+		/*
+		 * Relocation will wait for cleaner thread, and any half-dropped
+		 * subvolume will be fully cleaned up at mount time.
+		 * So here we shouldn't hit a subvolume with non-zero drop_progress.
+		 *
+		 * If this isn't the case, error out since it can make us attempt to
+		 * drop references for extents that were already dropped before.
+		 */
+		if (unlikely(btrfs_disk_key_objectid(&root->root_item.drop_progress))) {
+			struct btrfs_key cpu_key;
+
+			btrfs_disk_key_to_cpu(&cpu_key, &root->root_item.drop_progress);
+			btrfs_err(fs_info,
+	"can not relocate partially dropped subvolume %llu, drop progress key (%llu %u %llu)",
+				  objectid, cpu_key.objectid, cpu_key.type, cpu_key.offset);
+			ret = -EUCLEAN;
+			goto fail;
+		}
+
 		/* called by btrfs_init_reloc_root */
 		ret = btrfs_copy_root(trans, root, root->commit_root, &eb,
 				      BTRFS_TREE_RELOC_OBJECTID);
-- 
2.50.1


