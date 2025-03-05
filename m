Return-Path: <linux-btrfs+bounces-12020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930AA4FC61
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C61D18964D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376220A5D8;
	Wed,  5 Mar 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EaX3f/wG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dmxt4RQB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EaX3f/wG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dmxt4RQB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898191FBC84
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170828; cv=none; b=J1StF9gTO5lH1Mf6Vuqr2zIZbhLqYZ8Zsp/gbmHdl/Q9emF1ViRVyjHms2eJO8qWMxspYgLTMU9UQEaLsAsVm2tXPPb6bkoECt+jVEL7I98rQg0CIJJDvZMVNE4qVt1cfXoIyZAdM1iFQ+bk/VabfJTk/id/5RFTryK03FgQbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170828; c=relaxed/simple;
	bh=LoRE8liFSY9fOvAwFQWObqcoL3J6DEWMvCaclwj6xdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv5cWUHwSt5kiqtGW6NR13tTJdgSHkI2C39/hC6T6bDml7EauI6rQOZP0glfxKrCj9OyEOk5e2u8WBQd9oIyzFaJi9OC389uYJNUXyxHq8/YCfjImTALqEKFBD3IcW/Pjl4fDLfzp+VoK6Ai4nt5cNhGaAA7xuO0axhfJTr7AJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EaX3f/wG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dmxt4RQB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EaX3f/wG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dmxt4RQB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 964A7211A0;
	Wed,  5 Mar 2025 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741170824;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya4pu7jdLBlZ+qZRm8bkZRLN42Ptfc/Xkdjk3UBLqkE=;
	b=EaX3f/wGpPSHjQi7WD0gg2/kZBR7Dkb6u+TkBBBU6ZdkdZRInCBMK8Fws+/0uXbFE1khNM
	5Rw6xg/0ZlhPe6Xpj1iATkJYfoMNUeBrl5QcYoUx2BcyjHF3BPJpZSa+uD5ky6VDa9d7Sk
	HZC6V2EOiEmxgfE968CTkQS78tAFgsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741170824;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya4pu7jdLBlZ+qZRm8bkZRLN42Ptfc/Xkdjk3UBLqkE=;
	b=dmxt4RQBARQmSe2tf3kB7p+dT5LhdLUR0jQQRVFWROlJbSQePXKNiC6umkFC05KbHAIDny
	SOOaRw2GxXAjRlAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="EaX3f/wG";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dmxt4RQB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741170824;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya4pu7jdLBlZ+qZRm8bkZRLN42Ptfc/Xkdjk3UBLqkE=;
	b=EaX3f/wGpPSHjQi7WD0gg2/kZBR7Dkb6u+TkBBBU6ZdkdZRInCBMK8Fws+/0uXbFE1khNM
	5Rw6xg/0ZlhPe6Xpj1iATkJYfoMNUeBrl5QcYoUx2BcyjHF3BPJpZSa+uD5ky6VDa9d7Sk
	HZC6V2EOiEmxgfE968CTkQS78tAFgsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741170824;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya4pu7jdLBlZ+qZRm8bkZRLN42Ptfc/Xkdjk3UBLqkE=;
	b=dmxt4RQBARQmSe2tf3kB7p+dT5LhdLUR0jQQRVFWROlJbSQePXKNiC6umkFC05KbHAIDny
	SOOaRw2GxXAjRlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 682CA13939;
	Wed,  5 Mar 2025 10:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Io6GYgoyGe8AgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Mar 2025 10:33:44 +0000
Date: Wed, 5 Mar 2025 11:33:39 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: use atomic64_t for free_objectid
Message-ID: <20250305103339.GD5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250303182139.256498-1-maharmstone@fb.com>
 <20250304095256.GX5777@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304095256.GX5777@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [0.79 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: 0.79
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 964A7211A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Tue, Mar 04, 2025 at 10:52:56AM +0100, David Sterba wrote:
> > -	ASSERT(root->free_objectid <= BTRFS_LAST_FREE_OBJECTID);
> > -
> > -	mutex_unlock(&root->objectid_mutex);
> > +	ASSERT((u64)atomic64_read(&root->free_objectid) <=
> > +		BTRFS_LAST_FREE_OBJECTID);
> 
> I'm not sure if this was mentioned in the previous discussion. This
> assert will be always true, the atomic is signed 64 and cast to
> unsigned. Under normal circumstances the atomic will not be negative so
> it won't translate to a huge unsigned number by the cast.
> 
> What we need is an unsigned atomic type. The atomic64_t is a natural
> choice and it probably has enough margin for the simple increment
> allocation. But still I think we should make it a "u64".
> 
> The simplest implementation is to use spin lock around the updates,
> seqlock_t is also possible but it effectively uses a spin lock too and
> we don't need the read side protection.
> 
> Sorry, it's another change right before the code freeze so we may want
> to postpone it to let us think it through. I'll prototype the idea and
> do some tests, we can still target 6.15.

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 075a06db43a1..2620403fd4c9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -179,8 +179,6 @@ struct btrfs_root {
 	struct btrfs_fs_info *fs_info;
 	struct extent_io_tree dirty_log_pages;
 
-	struct mutex objectid_mutex;
-
 	spinlock_t accounting_lock;
 	struct btrfs_block_rsv *block_rsv;
 
@@ -214,7 +212,9 @@ struct btrfs_root {
 
 	u64 last_trans;
 
+	/* Locking is done only when incremented, read size relies on u64. */
 	u64 free_objectid;
+	spinlock_t objectid_lock;
 
 	struct btrfs_key defrag_progress;
 	struct btrfs_key defrag_max;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0cb559448933..e5569cec0547 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -676,7 +676,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	spin_lock_init(&root->ordered_extent_lock);
 	spin_lock_init(&root->accounting_lock);
 	spin_lock_init(&root->qgroup_meta_rsv_lock);
-	mutex_init(&root->objectid_mutex);
+	spin_lock_init(&root->objectid_lock);
 	mutex_init(&root->log_mutex);
 	mutex_init(&root->ordered_extent_mutex);
 	mutex_init(&root->delalloc_mutex);
@@ -1132,17 +1132,12 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 		}
 	}
 
-	mutex_lock(&root->objectid_mutex);
 	ret = btrfs_init_root_free_objectid(root);
-	if (ret) {
-		mutex_unlock(&root->objectid_mutex);
+	if (ret)
 		return ret;
-	}
 
 	ASSERT(root->free_objectid <= BTRFS_LAST_FREE_OBJECTID);
 
-	mutex_unlock(&root->objectid_mutex);
-
 	return 0;
 }
 
@@ -2725,8 +2720,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		}
 
 		/*
-		 * No need to hold btrfs_root::objectid_mutex since the fs
-		 * hasn't been fully initialised and we are the only user
+		 * No need to lock btrfs_root::free_objectid since the fs
+		 * hasn't been fully initialised and we are the only user.
 		 */
 		ret = btrfs_init_root_free_objectid(tree_root);
 		if (ret < 0) {
@@ -4930,20 +4925,21 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 
 int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 {
-	int ret;
-	mutex_lock(&root->objectid_mutex);
+	u64 val;
 
-	if (unlikely(root->free_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
+	spin_lock(&root->objectid_lock);
+	val = root->free_objectid;
+	if (unlikely(val >= BTRFS_LAST_FREE_OBJECTID)) {
+		spin_unlock(&root->objectid_lock);
 		btrfs_warn(root->fs_info,
 			   "the objectid of root %llu reaches its highest value",
 			   btrfs_root_id(root));
-		ret = -ENOSPC;
-		goto out;
+		return -ENOSPC;
 	}
+	root->free_objectid = val + 1;
+	spin_unlock(&root->objectid_lock);
 
-	*objectid = root->free_objectid++;
-	ret = 0;
-out:
-	mutex_unlock(&root->objectid_mutex);
-	return ret;
+	*objectid = val;
+
+	return 0;
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d6fa36674270..1ce84bf59a09 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -472,9 +472,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			 *
 			 * Ensure that we skip any such subvol ids.
 			 *
-			 * We don't need to lock because this is only called
-			 * during mount before we start doing things like creating
-			 * subvolumes.
+			 * We don't need to worry about updates to free_objectid,
+			 * this is only called during mount before we start
+			 * doing things like creating subvolumes.
 			 */
 			if (is_fstree(qgroup->qgroupid) &&
 			    qgroup->qgroupid > tree_root->free_objectid)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fc5c761181eb..97e608b251fa 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7325,9 +7325,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * We have just replayed everything, and the highest
 			 * objectid of fs roots probably has changed in case
 			 * some inode_item's got replayed.
-			 *
-			 * root->objectid_mutex is not acquired as log replay
-			 * could only happen during mount.
 			 */
 			ret = btrfs_init_root_free_objectid(root);
 			if (ret)
-- 
2.47.1


