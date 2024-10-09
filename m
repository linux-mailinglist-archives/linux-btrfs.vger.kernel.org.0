Return-Path: <linux-btrfs+bounces-8701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A8996DD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E7828240E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A51836D9;
	Wed,  9 Oct 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P7aJkGIu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P7aJkGIu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA41DA3D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484271; cv=none; b=CrYAannoYvh9vNiENHnb44ea/eCxJZyOBPaSZ++1s12ZGsfYLycrMYh4CwJv7GR1x3k3lULe913U/WscRbLmkWFUo1F4w+qj7uQleKaRt8ujsAWva8espuK8oLKHbwPN8f+xZO7XRvLqa64BWadvm8VBs/0mt8pBCNXpBw4rfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484271; c=relaxed/simple;
	bh=YF+hAD/nlnC6sM9lReJ6U8sixZMCGwu9hNtSKHq3la4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGTg38zcwcpeajulz9+IUjpzYP34FD5jNohx7EZ0bsO+ao/MZRdwHODeHmVt/uZ54MLSNUlf0Ls7rqviABHwqW9xaV9Y9COXRxnz8inwqZZBkaXQqvjIh7KsDQvC8QXREL7yTZcI8TBH8tZahJz7Msp0Tamk5yhNC+cwGLKjviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P7aJkGIu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P7aJkGIu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FF7D21EB2;
	Wed,  9 Oct 2024 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6fGt0Dz7SLdx+PLGOH9I2zH+lLuO6l7grhyNOdYpBE=;
	b=P7aJkGIuSp+A+dy5s1uEeK9pLV8NfOoPTNppHTsJ7qwfZyMYsOXrjDKG8JkaFAYtmHeXxs
	qYrpDCWfMv78SRU11CofaaMgd5ySXzvjIhzOQYzKUI24LYZOF4fqQOGvXE0rgdwh2xr16w
	hOtsQrfpfR3Lh2hiGlEdsuSqrTKwpRY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6fGt0Dz7SLdx+PLGOH9I2zH+lLuO6l7grhyNOdYpBE=;
	b=P7aJkGIuSp+A+dy5s1uEeK9pLV8NfOoPTNppHTsJ7qwfZyMYsOXrjDKG8JkaFAYtmHeXxs
	qYrpDCWfMv78SRU11CofaaMgd5ySXzvjIhzOQYzKUI24LYZOF4fqQOGvXE0rgdwh2xr16w
	hOtsQrfpfR3Lh2hiGlEdsuSqrTKwpRY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 390D4136BA;
	Wed,  9 Oct 2024 14:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NEvsDauTBmcLRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/25] btrfs: send: drop unused parameter num from iterate_inode_ref_t callbacks
Date: Wed,  9 Oct 2024 16:31:06 +0200
Message-ID: <a7de7308ba1aad3e3cbb2775eacde97d85332230.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

None of the ref iteration callbacks needs the num parameter (this is for
the directory item iteration), so we can drop it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 27306d98ec43..18aecef3567d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -980,7 +980,7 @@ static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
 	return ret;
 }
 
-typedef int (*iterate_inode_ref_t)(int num, u64 dir, int index,
+typedef int (*iterate_inode_ref_t)(u64 dir, int index,
 				   struct fs_path *p,
 				   void *ctx);
 
@@ -1007,7 +1007,6 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	u32 name_len;
 	char *start;
 	int ret = 0;
-	int num = 0;
 	int index;
 	u64 dir;
 	unsigned long name_off;
@@ -1094,10 +1093,9 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		cur += elem_size + name_len;
-		ret = iterate(num, dir, index, p, ctx);
+		ret = iterate(dir, index, p, ctx);
 		if (ret)
 			goto out;
-		num++;
 	}
 
 out:
@@ -1227,7 +1225,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 	return ret;
 }
 
-static int __copy_first_ref(int num, u64 dir, int index,
+static int __copy_first_ref(u64 dir, int index,
 			    struct fs_path *p, void *ctx)
 {
 	int ret;
@@ -4708,7 +4706,7 @@ static int record_ref_in_tree(struct rb_root *root, struct list_head *refs,
 	return ret;
 }
 
-static int record_new_ref_if_needed(int num, u64 dir, int index,
+static int record_new_ref_if_needed(u64 dir, int index,
 				    struct fs_path *name, void *ctx)
 {
 	int ret = 0;
@@ -4738,7 +4736,7 @@ static int record_new_ref_if_needed(int num, u64 dir, int index,
 	return ret;
 }
 
-static int record_deleted_ref_if_needed(int num, u64 dir, int index,
+static int record_deleted_ref_if_needed(u64 dir, int index,
 					struct fs_path *name, void *ctx)
 {
 	int ret = 0;
-- 
2.45.0


