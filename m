Return-Path: <linux-btrfs+bounces-1349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154B829289
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78261F26C5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F116125;
	Wed, 10 Jan 2024 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXgTAxfM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXgTAxfM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DACF4C6B
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 816D81F843
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704855242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRMtky3SeZddYhWULi6/inMU8Ssrwo5/bg7cL//g79c=;
	b=tXgTAxfMqItZ6CIQNes4tHwP6SB00VUDbumH9fDYPb+xX0npM4GjsoCpG5bI+IQ594HV/f
	gXn8bY4ES1k9+qfD7X4TSztZSCM9Q7sHbw8DTKpOKZSSSinh8ar3C33A20IgJxfe9NtdXS
	A3hdM1VYJGPA9sZ4QJnDtxMBIkAg8sI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704855242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRMtky3SeZddYhWULi6/inMU8Ssrwo5/bg7cL//g79c=;
	b=tXgTAxfMqItZ6CIQNes4tHwP6SB00VUDbumH9fDYPb+xX0npM4GjsoCpG5bI+IQ594HV/f
	gXn8bY4ES1k9+qfD7X4TSztZSCM9Q7sHbw8DTKpOKZSSSinh8ar3C33A20IgJxfe9NtdXS
	A3hdM1VYJGPA9sZ4QJnDtxMBIkAg8sI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF56D13786
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EDcCG8cGnmWqKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:53:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: cmd/subvolume: ix return value when the target exists
Date: Wed, 10 Jan 2024 13:23:31 +1030
Message-ID: <33315f98796380a5a216de912966ea6ed6d589fc.1704855097.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704855097.git.wqu@suse.com>
References: <cover.1704855097.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *******
X-Spam-Level: 
X-Spam-Score: 0.50
X-Rspamd-Queue-Id: 816D81F843
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tXgTAxfM
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.19)[-0.959];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

[BUG]
When try to create a subvolume where the target path already exists, the
"btrfs" comannd doesn't return error code correctly.

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # touch $mnt/subv1
  # btrfs subvolume create $mnt/subv1
  ERROR: target path already exists: $mnt/subv1
  # echo $?
  0

[CAUSE]
The check on whether target exists is done by path_is_dir(), if it
return 0 or 1, it means there is something in that path already.

But unfortunately commit 5aa959fb3440 ("btrfs-progs: subvolume create:
accept multiple arguments") only changed the out tag, which would
directly return @ret, not updating the return value correct.

[FIX]
Make sure all error out branch has their @ret manually updated.

Fixes: 5aa959fb3440 ("btrfs-progs: subvolume create: accept multiple arguments")
Issue: #730
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 57be9eac5e56..b01d5c80f63d 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -160,12 +160,14 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 	}
 	if (ret >= 0) {
 		error("target path already exists: %s", dst);
+		ret = -EEXIST;
 		goto out;
 	}
 
 	dupname = strdup(dst);
 	if (!dupname) {
 		error_msg(ERROR_MSG_MEMORY, "duplicating %s", dst);
+		ret = -ENOMEM;
 		goto out;
 	}
 	newname = basename(dupname);
@@ -173,18 +175,21 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 	dupdir = strdup(dst);
 	if (!dupdir) {
 		error_msg(ERROR_MSG_MEMORY, "duplicating %s", dst);
+		ret = -ENOMEM;
 		goto out;
 	}
 	dstdir = dirname(dupdir);
 
 	if (!test_issubvolname(newname)) {
 		error("invalid subvolume name: %s", newname);
+		ret = -EINVAL;
 		goto out;
 	}
 
 	len = strlen(newname);
 	if (len > BTRFS_VOL_NAME_MAX) {
 		error("subvolume name too long: %s", newname);
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -208,6 +213,8 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 					goto out;
 				}
 			} else if (ret <= 0) {
+				if (ret == 0)
+					ret = -EEXIST;
 				errno = ret ;
 				error("failed to check directory %s before creation: %m", p);
 				goto out;
@@ -218,8 +225,10 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 	}
 
 	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
-	if (fddst < 0)
+	if (fddst < 0) {
+		ret = fddst;
 		goto out;
+	}
 
 	pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, newname);
 	if (inherit) {
-- 
2.43.0


