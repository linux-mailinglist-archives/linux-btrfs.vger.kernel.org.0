Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9FD433952
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhJSO4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 10:56:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJSO4x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 10:56:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DA5A2197F;
        Tue, 19 Oct 2021 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634655280;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCm/xuM+KGWgfVc6ZRLGb3Qb8nb/lTds9YkLYTMCxHw=;
        b=1za/F9h80PE+KH9k2IXUqKrdBlOt+fmMExjfw+2wqQQqRGua9gUbrhHhzl4RkGVYtUTeWh
        1DNX5SV9PeFdBVenlSDnXU4/qD0OltJf3ypwEB8OTdJOzoIPOdkKu5xz0SWkriK3ZigLZ/
        NKMhyGfnym74lMx1IRgeaFhrJLDXxng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634655280;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCm/xuM+KGWgfVc6ZRLGb3Qb8nb/lTds9YkLYTMCxHw=;
        b=l91shijl1IqO2j9ptfrM3aIsTdoWoDuBoDRPz9sW8vKpllNFw/NjD98X385+jbpqf4IaX7
        3OgTkrQ96PvuxMCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 45A43A3B87;
        Tue, 19 Oct 2021 14:54:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76B66DA7A3; Tue, 19 Oct 2021 16:54:12 +0200 (CEST)
Date:   Tue, 19 Oct 2021 16:54:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add stub argument to transaction API
Message-ID: <20211019145412.GT30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20211018173803.18353-1-dsterba@suse.com>
 <YW3nBs4cr99TcyRL@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3nBs4cr99TcyRL@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 05:28:38PM -0400, Josef Bacik wrote:
> On Mon, Oct 18, 2021 at 07:38:03PM +0200, David Sterba wrote:
> > Why the stub/context argument is needed: the NOFS protection is per call
> > site, so it must be set and reset in the caller thread, so any
> > allocations between btrfs_start_transaction and btrfs_end_transaction
> > are safe. We can't store it in the transaction handle, because it's not
> > passed everywhere, eg. to various helpers in btrfs and potentially in
> > other subsystems.
> 
> So the plan is to instead pass the tctx around everywhere to carry the flags?  I
> thought the whole point of memalloc_nofs_save() is that we don't have to pass
> gfp_t's around everywhere, it just knows what we're supposed to be doing?

Nothing needs to be passed around, it will be hidden inside the
transaction start/end, the only thing the caller needs to do is to
define the variable and pass it to to transaction start call. The NOFS
section will then apply to any calls until the transaction end call.

--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1232,6 +1232,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
        struct btrfs_path *path;
        struct btrfs_block_rsv *block_rsv;
        int ret;
+       DEFINE_TCTX(tctx);
 
        if (!delayed_node)
                return 0;
@@ -1244,7 +1245,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
        }
        mutex_unlock(&delayed_node->mutex);
 
-       trans = btrfs_join_transaction(delayed_node->root, NULL);
+       trans = btrfs_join_transaction(delayed_node->root, tctx);
        if (IS_ERR(trans)) {
                ret = PTR_ERR(trans);
                goto out;
@@ -1271,7 +1272,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
        btrfs_free_path(path);
        trans->block_rsv = block_rsv;
 trans_out:
-       btrfs_end_transaction(trans, NULL);
+       btrfs_end_transaction(trans, tctx);
        btrfs_btree_balance_dirty(fs_info);
 out:
        btrfs_release_delayed_node(delayed_node);
---

This is what needs to be done per caller.


> So
> the trans should be able to hold the flags since we only care about starting it
> and restoring it, correct?  Or am I wrong and we do actually need to pass this
> thing around?  In which case can't we still just save it in the trans handle,
> and pass the u32 around where appropriate?  Thanks,

I had to dig in my memory why we can't store it in the transaction
handle, because this is naturally less intrusive. But it does not work.

There are two things:

1) In a function that starts/joins a transaction, the NOFS scope is from
   that call until the transaction end. This is caller-specific.
   Like in the example above, any allocation with GFP_KERNEL happening
   will be safe and not recurse back to btrfs.

2) Transaction handle is not caller-specific and is allocated when the
   transaction starts (ie. a new kmem_cache_alloc call is done). Any
   caller of transaction start will only increase the reference count.

So, on each refcount_inc, we'd need to store the nofs_flags, on each
refcount_dec to restore it.

It is possible that the NOFS context is also needed outside of the
start/end region, but it depends and has to be done case by case. For
the transcation start/end we're sure the NOFS must be set.

The NOFS scope should be also more fine-grained to where we know we
really need it, so it's not "GFP_NOFS everywhere" just implemented by
other means.

There is (and will be more) code adding assertions and additional checks
to verify the invariants. For anybody who's interested I can share the
WIP branches, but I haven't worked on it since 5.6.

Getting the API parameter extension would help to shorten the
start-again time, it's possible I'm missing something and it can be done
in an easier way but I don't see it right now.
