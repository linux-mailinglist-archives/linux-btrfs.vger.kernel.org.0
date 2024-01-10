Return-Path: <linux-btrfs+bounces-1355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8482953E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 09:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326EC1C25D39
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ECA38DC8;
	Wed, 10 Jan 2024 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rWnPjPYi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rWnPjPYi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB879DD
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EA6321B4C
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704875816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRMtky3SeZddYhWULi6/inMU8Ssrwo5/bg7cL//g79c=;
	b=rWnPjPYi/014zxQp6kS87zY38Za8kVS6KG/jT11CTcXdJpIDHsPqJGhA+KuwmnEEn2LQ/s
	X2MkKuHkKD6cY0/EBrDmKT2lxdPXwilkrnZT1LilGsDtEZGDTQI9kCo8tum1P9cLh/tDcp
	hF6wgKcqUP/Lo4tH6RHHmS7qD5+b+D4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704875816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRMtky3SeZddYhWULi6/inMU8Ssrwo5/bg7cL//g79c=;
	b=rWnPjPYi/014zxQp6kS87zY38Za8kVS6KG/jT11CTcXdJpIDHsPqJGhA+KuwmnEEn2LQ/s
	X2MkKuHkKD6cY0/EBrDmKT2lxdPXwilkrnZT1LilGsDtEZGDTQI9kCo8tum1P9cLh/tDcp
	hF6wgKcqUP/Lo4tH6RHHmS7qD5+b+D4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF0F413CB3
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OBWIiZXnmV/aQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs-progs: cmd/subvolume: fix return value when the target exists
Date: Wed, 10 Jan 2024 19:06:33 +1030
Message-ID: <f92666963689150f0fd732b2418c317da916781c.1704875723.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704875723.git.wqu@suse.com>
References: <cover.1704875723.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rWnPjPYi
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.99 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 4.99
X-Rspamd-Queue-Id: 1EA6321B4C
X-Spam-Flag: NO

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


