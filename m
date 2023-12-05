Return-Path: <linux-btrfs+bounces-668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4529805E67
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE301F21604
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B66D1A9;
	Tue,  5 Dec 2023 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FsrL/Bsc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DIu60kw6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F23B0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 11:11:52 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 058711FBA1;
	Tue,  5 Dec 2023 19:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701803510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XvyhmI0bnUNZ32U+FIeBn+JSTVj4IR44nentmR4ItQ=;
	b=FsrL/BscrK3zOFcNab1wwOujBcQesehxk0CmiHjul+RHqGyBKDl0ibKp7K0KryRnhr4FaN
	KspNlhvz4B0NULRGFhicqDhHkNjFlKIFU0yMridPwmSvoVZ/2ESgYyevrFWJLBh+0lnXNf
	LMzmx9+8TWldoQT72diQugKNbqv2hq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701803510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XvyhmI0bnUNZ32U+FIeBn+JSTVj4IR44nentmR4ItQ=;
	b=DIu60kw6fm0zTvZ7Ng4IzyFHyLYMg2BTd4QMFXWwp3V3aS+v3Gy/bVNBmvWk3STMFlMYpg
	PSJxhg4taSUOqbDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A3CC6138FF;
	Tue,  5 Dec 2023 19:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Dx/ZJPV1b2V+YAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 19:11:49 +0000
Date: Tue, 5 Dec 2023 20:04:59 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: use xarray for btrfs_root::delayed_nodes_tree
 instead of radix-tree
Message-ID: <20231205190459.GQ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701384168.git.dsterba@suse.com>
 <e283f8d460c7b3288e8eb1d8974d6b5842210167.1701384168.git.dsterba@suse.com>
 <CAL3q7H7a0nu8xa6dNZeBzzez1D3e8dr2tUkOcaUNNnPbFJ_YLA@mail.gmail.com>
 <20231204154934.GA2205@twin.jikos.cz>
 <20231204160731.GB2205@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204160731.GB2205@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.36
X-Spamd-Result: default: False [-0.36 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.36)[76.74%]

On Mon, Dec 04, 2023 at 05:07:31PM +0100, David Sterba wrote:
> On Mon, Dec 04, 2023 at 04:49:34PM +0100, David Sterba wrote:
> > On Fri, Dec 01, 2023 at 11:03:25AM +0000, Filipe Manana wrote:
> > > On Thu, Nov 30, 2023 at 10:56 PM David Sterba <dsterba@suse.com> wrote:

> It the lock conversion would not be the right way, the xa_reserve can be
> done but it it's not as simple as the preload, it inserts a reserved
> entry to the tree which is NULL upon read so we'd have to handle that
> everywhere.

Seems that xa_reserve can emulate the preload. It takes the GFP flags
and will insert a reserved entry, btrfs_get_delayed_node() expects a
NULL and there's no other xa_load() except
btrfs_get_or_create_delayed_node() that's doing the insert.

The insertion is done to the reserved slot by xa_store() and serialized
by the spin lock, the slot reservation can race, xarray handles that.
xa_store() also takes the GFP flags but they should not be needed.

I'm running the code below with manual error injection (xa_reserve()
fails every 100th time), so far fstests continue, reporting either
enomem or transaction aborts.

--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -122,6 +122,8 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	int ret;
 
 	do {
+		void *ptr;
+
 		node = btrfs_get_delayed_node(btrfs_inode);
 		if (node)
 			return node;
@@ -134,15 +136,25 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		/* Cached in the inode and can be accessed. */
 		refcount_set(&node->refs, 2);
 
+		ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
+		if (ret == -ENOMEM) {
+			kmem_cache_free(delayed_node_cache, node);
+			return ERR_PTR(-ENOMEM);
+		}
 		spin_lock(&root->inode_lock);
-		ret = xa_insert(&root->delayed_nodes, ino, node, GFP_ATOMIC);
-		if (ret < 0) {
+		ptr = xa_load(&root->delayed_nodes, ino);
+		if (ptr) {
+			/* Somebody inserted it. */
 			spin_unlock(&root->inode_lock);
 			kmem_cache_free(delayed_node_cache, node);
-			if (ret != -EBUSY)
-				return ERR_PTR(ret);
-			/* Otherwise it's ENOMEM. */
+			ret = -EEXIST;
+			continue;
 		}
+		ptr = xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
+		ASSERT(xa_err(ptr) != -EINVAL);
+		ASSERT(xa_err(ptr) != -ENOMEM);
+		ASSERT(ptr == NULL);
+		ret = 0;
 	} while (ret < 0);
 	btrfs_inode->delayed_node = node;
 	spin_unlock(&root->inode_lock);

