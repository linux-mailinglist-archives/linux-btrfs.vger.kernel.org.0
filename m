Return-Path: <linux-btrfs+bounces-8702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E8996DD6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC7281BBF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600892AD1C;
	Wed,  9 Oct 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lkET7Na6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lkET7Na6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69A5336E
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484278; cv=none; b=hkDjgc8AYr1EH5p1Y+MmVtF3U1BzwXsarMvaz3vqjztbN03/FnAA6xQ6WEtm4h/cw9O8vHMnFEVMUfWc8VmToTVi0oYS7Ftks9YFG/UhhePfsFdTBmKVTPxyR94C7spx7UY7aumUa25JMwUkerc0Q6oiCxT1/RZs01peyJpb4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484278; c=relaxed/simple;
	bh=z2QOH0cZXVeLp1nvlEljk8Fl13yHITqseJyZ1a5Zrc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifdJj0E2pI+NpRrvV18sWGrI0jvH1Vmcxm7i5jInAFp53uL7mKVKFw0Age3dfzPU8NkqeQryRxQmWuas6Tx6uaUAQ7O7jRLqQoptcj/YBHFj/5kSMvBYTUuxLSjuDKlsiKeg9WJ4tr4RGjSLag9kG+sEmzSmV90NSQuoL7lfd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lkET7Na6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lkET7Na6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BA6721EB2;
	Wed,  9 Oct 2024 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZnZtO0ZF8sHwraFRYVI9/xBtBvB6nNllnSRdicH1oM=;
	b=lkET7Na6mSszX1EiLtV8ceoug4EwtggTmmae/C2UFjofiuxEAyWC8m7LNBwzA1DhXxqKex
	l6r1rx28EPaDzOwX9fOiPXIvg39RbXitxTKPFOXGTnI1727hz7aivQLQA3RHzGMTuy3Cc8
	wd1jJJbY2C5etZuZzMktAyZYgvqBNPg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZnZtO0ZF8sHwraFRYVI9/xBtBvB6nNllnSRdicH1oM=;
	b=lkET7Na6mSszX1EiLtV8ceoug4EwtggTmmae/C2UFjofiuxEAyWC8m7LNBwzA1DhXxqKex
	l6r1rx28EPaDzOwX9fOiPXIvg39RbXitxTKPFOXGTnI1727hz7aivQLQA3RHzGMTuy3Cc8
	wd1jJJbY2C5etZuZzMktAyZYgvqBNPg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9472D136BA;
	Wed,  9 Oct 2024 14:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sGc6JLGTBmcORQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/25] btrfs: send: drop unused parameter index from iterate_inode_ref_t callbacks
Date: Wed,  9 Oct 2024 16:31:09 +0200
Message-ID: <17385b6848399336dc3ff12e9afa578fe1d79908.1728484021.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

None of the ref iteration callbacks needs the index parameter (this is
for the directory item iteration), so we can drop it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 18aecef3567d..db16879c798f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -980,9 +980,7 @@ static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
 	return ret;
 }
 
-typedef int (*iterate_inode_ref_t)(u64 dir, int index,
-				   struct fs_path *p,
-				   void *ctx);
+typedef int (*iterate_inode_ref_t)(u64 dir, struct fs_path *p, void *ctx);
 
 /*
  * Helper function to iterate the entries in ONE btrfs_inode_ref or
@@ -1007,7 +1005,6 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	u32 name_len;
 	char *start;
 	int ret = 0;
-	int index;
 	u64 dir;
 	unsigned long name_off;
 	unsigned long elem_size;
@@ -1042,13 +1039,11 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 			iref = (struct btrfs_inode_ref *)(ptr + cur);
 			name_len = btrfs_inode_ref_name_len(eb, iref);
 			name_off = (unsigned long)(iref + 1);
-			index = btrfs_inode_ref_index(eb, iref);
 			dir = found_key->offset;
 		} else {
 			extref = (struct btrfs_inode_extref *)(ptr + cur);
 			name_len = btrfs_inode_extref_name_len(eb, extref);
 			name_off = (unsigned long)&extref->name;
-			index = btrfs_inode_extref_index(eb, extref);
 			dir = btrfs_inode_extref_parent(eb, extref);
 		}
 
@@ -1093,7 +1088,7 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		cur += elem_size + name_len;
-		ret = iterate(dir, index, p, ctx);
+		ret = iterate(dir, p, ctx);
 		if (ret)
 			goto out;
 	}
@@ -1225,8 +1220,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 	return ret;
 }
 
-static int __copy_first_ref(u64 dir, int index,
-			    struct fs_path *p, void *ctx)
+static int __copy_first_ref(u64 dir, struct fs_path *p, void *ctx)
 {
 	int ret;
 	struct fs_path *pt = ctx;
@@ -4706,8 +4700,7 @@ static int record_ref_in_tree(struct rb_root *root, struct list_head *refs,
 	return ret;
 }
 
-static int record_new_ref_if_needed(u64 dir, int index,
-				    struct fs_path *name, void *ctx)
+static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 {
 	int ret = 0;
 	struct send_ctx *sctx = ctx;
@@ -4736,8 +4729,7 @@ static int record_new_ref_if_needed(u64 dir, int index,
 	return ret;
 }
 
-static int record_deleted_ref_if_needed(u64 dir, int index,
-					struct fs_path *name, void *ctx)
+static int record_deleted_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 {
 	int ret = 0;
 	struct send_ctx *sctx = ctx;
-- 
2.45.0


