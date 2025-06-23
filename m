Return-Path: <linux-btrfs+bounces-14858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D04AE3D3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA3C167AC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96123A566;
	Mon, 23 Jun 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mzj++Gob";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mzj++Gob"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BA238C21
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675633; cv=none; b=YR/ZlgkdKiTmTkNvmdoOSlPZxkFMWlDSlsZWE9O/1F/TadRG1JjhgfOQphcXBMfwupSDPI+eTmEpkiaJWbn1FcueVN2nljeBnkaKr7fTWgg37QO7V19xl43QlKxjgeqcoDi14n2XMiDY5KfOo/ZkpH6X9SdFZPEq7DbF/a7l/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675633; c=relaxed/simple;
	bh=C94Th9dLITXI0kFYowMRRY7mJa7SzqIpSB+XOfUqTPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu7d3x+dKXoX22LrEAw6JYgehyuNeqKtAOAlWTAWZjGdQYRz/pzOG2A/++TC3YTk4awvNX+qYI0cO324K5gduV6Q0KLxukwsmEOMVxEijXCCdG4CoVJ1pIbhg3H10D/3w0cutvwAn2OxsUTHyIITuKn2dnDgTbgyTjCxwBqai80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mzj++Gob; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mzj++Gob; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51D2521174
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZqIvBkoUJkM1InBB85wtA0ohUcS9q+8maaGA8Sdx3A=;
	b=Mzj++GobXjfkHHifU5J8qaKO1fhnKoaubi2f5CFfl2TjJhWEVxq4vb0VERfmdmhUvs0TdE
	8ICwK++D5WHIJW5jOysUGggEgwDs6FX+TlY/IFmB0D9Ahy2S/CT1rw1ilhPUP7BtvwBoyc
	r5KRLg+qqHURaRMSPynpYL6SYRCQCE0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Mzj++Gob
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZqIvBkoUJkM1InBB85wtA0ohUcS9q+8maaGA8Sdx3A=;
	b=Mzj++GobXjfkHHifU5J8qaKO1fhnKoaubi2f5CFfl2TjJhWEVxq4vb0VERfmdmhUvs0TdE
	8ICwK++D5WHIJW5jOysUGggEgwDs6FX+TlY/IFmB0D9Ahy2S/CT1rw1ilhPUP7BtvwBoyc
	r5KRLg+qqHURaRMSPynpYL6SYRCQCE0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9087A13485
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HkVFaIwWWgeJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:46:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/8] btrfs: get rid of the re-entry of btrfs_get_tree()
Date: Mon, 23 Jun 2025 20:16:46 +0930
Message-ID: <9e075fdf15f6c918d9a07056fd6cd26d1b8904bb.1750674924.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750674924.git.wqu@suse.com>
References: <cover.1750674924.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 51D2521174
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Score: -3.01
X-Spam-Level: 

[EXISTING PROBLEM]
Currently btrfs mount is split into two parts:

- btrfs_get_tree_subvol()
  Which setups the very basic fs_info, and eventually call
  mount_subvol() to mount the target subvolume.

- btrfs_get_tree_super()
  This is the part doing super block allocation and if there is no
  existing super block, do the real open_ctree() to open the fs.

However currently we're doing this in a complex re-entry fashion:

vfs_get_tree()
|- btrfs_get_tree()
   |- btrfs_get_tree_subvol()
      |- vfs_get_tree()
      |  |- btrfs_get_tree()
      |     |- btrfs_get_tree_super()
      |- mount_subvol()

This is definitely not that easy to grasp.

[ENHANCEMENT]
The function vfs_get_tree() is only doing the following works:

- Call get_tree() call back
- Call super_wake()
- Call security_sb_set_mnt_opts()

In our case, super_wake() can be skipped, as after
btrfs_get_tree_subvol() finished, vfs_get_tree() will call super_wake()
on the super block we got anyway.

The same applies to security_sb_set_mnt_opts(), as long as we do not
free the security from our original fc in btrfs_get_tree_subvol(), the
first vfs_get_tree() call will handle the security correctly.

So here we only need to:

- Replace vfs_get_tree() call with btrfs_get_tree_super()

- Keep the existing fc->security for vfs_get_tree() to handle the
  security

This will remove the re-entry behavior and make thing much easier to
follow.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b9e08a59da4e..d977d2da985e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2046,15 +2046,7 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	 */
 	dup_fc->s_fs_info = fs_info;
 
-	/*
-	 * We'll do the security settings in our btrfs_get_tree_super() mount
-	 * loop, they were duplicated into dup_fc, we can drop the originals
-	 * here.
-	 */
-	security_free_mnt_opts(&fc->security);
-	fc->security = NULL;
-
-	ret = vfs_get_tree(dup_fc);
+	ret = btrfs_get_tree_super(dup_fc);
 	if (ret)
 		goto error;
 
@@ -2086,21 +2078,8 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 
 static int btrfs_get_tree(struct fs_context *fc)
 {
-	/*
-	 * Since we use mount_subtree to mount the default/specified subvol, we
-	 * have to do mounts in two steps.
-	 *
-	 * First pass through we call btrfs_get_tree_subvol(), this is just a
-	 * wrapper around fc_mount() to call back into here again, and this time
-	 * we'll call btrfs_get_tree_super().  This will do the open_ctree() and
-	 * everything to open the devices and file system.  Then we return back
-	 * with a fully constructed vfsmount in btrfs_get_tree_subvol(), and
-	 * from there we can do our mount_subvol() call, which will lookup
-	 * whichever subvol we're mounting and setup this fc with the
-	 * appropriate dentry for the subvol.
-	 */
-	if (fc->s_fs_info)
-		return btrfs_get_tree_super(fc);
+	ASSERT(fc->s_fs_info == NULL);
+
 	return btrfs_get_tree_subvol(fc);
 }
 
-- 
2.49.0


