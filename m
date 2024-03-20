Return-Path: <linux-btrfs+bounces-3462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF2880A41
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 04:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430F01C21356
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 03:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845561756E;
	Wed, 20 Mar 2024 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UlFUPj6J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FQ3JRZ7P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9714A96
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906915; cv=none; b=D5O0p98gXUP+jg2rpJPLR2W5bES3KFyI1J2h4+meW+Z56+QUjixNKBme/ACSPiDsNVXM6Lm+pBOJrOHhlQ/vcCDpxONjY5hp7iEw5wgMR4Aodsi4zGtZ3XyMTjl+vHAe25FLTj+7LAXVixA4QjW6js/gINFz9AsiniWaY5UwB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906915; c=relaxed/simple;
	bh=/akGlujXKJh05cNx5jR7ClMKgt51xKJpoEB0/Cxo0kk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw6svasEFOQDuZDrMf5gMSbr0z1bu4eGiWScsOMa5ait88LautfosB3J+k39NUjwoms9U4JuoWjRK6xHINq4nZ2JBWOWCAGT9na4b0PPKdxy29A1XbK7ROMVfm9w9D+8JFpWsWN5PtD+XcrreEljubj7jhqRkJW2eHhpiiawZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UlFUPj6J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FQ3JRZ7P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF64133B83
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bVrJglffab2fuephVy1GuaxkPma0EMHHUYgGWISzgY=;
	b=UlFUPj6Jn1Myrp25Rd+aDQ1ZKmNcGEGeoCLfzoKkx6OTGPSlwJCfBvU6mmIkxUCYPUh/b9
	mUCLCPHEyMB9HeM+zO2YKdJOZfFb8e4EyLuYzvLsLXN7nxTQNWlt1UwQOiZBriC35tCOg5
	mLT957njjjWndoTEhujrd1KZNvHuCkQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bVrJglffab2fuephVy1GuaxkPma0EMHHUYgGWISzgY=;
	b=FQ3JRZ7PDIbJhBuM9fuhgvk5cW5XQePqYkFJj7KiDN9XeGHwcZjUtt31ehdZr0/XZxVaEa
	ybjJ9isVT7ntM6/VboO8os75+egfp7qAEnCVOnG5sONL6VoQxgL+Zf2MdEbUnvzoXAqrTf
	E1pjkOXiT+6FmhQyXYrI1Oeluh2Peas=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07EE7136AE
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eCRCKx5e+mVlbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/7] btrfs: scrub: ensure we output at least one error message for unrepaired corruption
Date: Wed, 20 Mar 2024 14:24:56 +1030
Message-ID: <295591e961dc5b1f14b8ffcbccfa1e3530e2ba91.1710906371.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710906371.git.wqu@suse.com>
References: <cover.1710906371.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.49
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.18)[-0.877];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FQ3JRZ7P
X-Rspamd-Queue-Id: EF64133B83

For btrfs scrub error messages, I have hit a lot of support cases on
older kernels where no filename is outputted at all, with only error
messages like:

 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2823, gen 0
 BTRFS error (device dm-0): unable to fixup (regular) error at logical 1563504640 on dev /dev/mapper/sys-rootlv
 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2824, gen 0
 BTRFS error (device dm-0): unable to fixup (regular) error at logical 1579016192 on dev /dev/mapper/sys-rootlv
 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2825, gen 0

The "unable to fixup (regular) error" line shows we hit an unrepairable
error, then normally we would do data/metadata backref walk to grab the
correct info.

But we can hit cases like the inode is already orphan (unlinked from any
parent inode), or even the subvolume is orphan (unlinked and waiting to
be deleted).

In that case we're not sure what's the proper way to continue (Is it
some critical data/metadata? Would it prevent the system from booting?)

To improve the situation, this patch would:

- Ensure we at least output one message for each unrepairable error
  If by somehow we didn't output any error message for the error, we
  always fallback to the basic logical/physical error output, with its
  type (data or metadata).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 85f321e3e37c..0d2b042d75c2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -226,6 +226,7 @@ struct scrub_warning {
 	u64			physical;
 	u64			logical;
 	struct btrfs_device	*dev;
+	bool			message_printed;
 };
 
 static void release_scrub_stripe(struct scrub_stripe *stripe)
@@ -425,7 +426,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 * we deliberately ignore the bit ipath might have been too small to
 	 * hold all of the paths here
 	 */
-	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
+	for (i = 0; i < ipath->fspath->elem_cnt; ++i) {
 		btrfs_warn_in_rcu(fs_info,
 "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, path: %s",
 				  swarn->errstr, swarn->logical,
@@ -433,6 +434,8 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 				  swarn->physical,
 				  root, inum, offset,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
+		swarn->message_printed = true;
+	}
 
 	btrfs_put_root(local_root);
 	free_ipath(ipath);
@@ -445,7 +448,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 			  btrfs_dev_name(swarn->dev),
 			  swarn->physical,
 			  root, inum, offset, ret);
-
+	swarn->message_printed = true;
 	free_ipath(ipath);
 	return 0;
 }
@@ -471,6 +474,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	swarn.logical = logical;
 	swarn.errstr = errstr;
 	swarn.dev = NULL;
+	swarn.message_printed = false;
 
 	ret = extent_from_logical(fs_info, swarn.logical, path, &found_key,
 				  &flags);
@@ -492,12 +496,8 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 			ret = tree_backref_for_extent(&ptr, eb, &found_key, ei,
 						      item_size, &ref_root,
 						      &ref_level);
-			if (ret < 0) {
-				btrfs_warn(fs_info,
-				"failed to resolve tree backref for logical %llu: %d",
-						  swarn.logical, ret);
+			if (ret < 0)
 				break;
-			}
 			if (ret > 0)
 				break;
 			btrfs_warn_in_rcu(fs_info,
@@ -505,7 +505,13 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 				errstr, swarn.logical, btrfs_dev_name(dev),
 				swarn.physical, (ref_level ? "node" : "leaf"),
 				ref_level, ref_root);
+			swarn.message_printed = true;
 		}
+		if (!swarn.message_printed)
+			btrfs_warn_in_rcu(fs_info,
+			"%s at metadata, logical %llu on dev %s physical %llu",
+					  errstr, swarn.logical,
+					  btrfs_dev_name(dev), swarn.physical);
 		btrfs_release_path(path);
 	} else {
 		struct btrfs_backref_walk_ctx ctx = { 0 };
@@ -520,6 +526,11 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 		swarn.dev = dev;
 
 		iterate_extent_inodes(&ctx, true, scrub_print_warning_inode, &swarn);
+		if (!swarn.message_printed)
+			btrfs_warn_in_rcu(fs_info,
+	"%s at data, filename unresolved, logical %llu on dev %s physical %llu",
+					  errstr, swarn.logical,
+					  btrfs_dev_name(dev), swarn.physical);
 	}
 
 out:
-- 
2.44.0


