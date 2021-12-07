Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE546C372
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbhLGTWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 14:22:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbhLGTWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 14:22:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7D9821B39;
        Tue,  7 Dec 2021 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638904757;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KGfxnrDfy3keDHqfhFuAw5ARe/IrHK3+v7LBbX77lc=;
        b=e3ki14nseoXncvFCM99ATaI2d/N2Ko6y/D5HPERnDj6k4LvPKZ7pP86jNHZ/ZSNYIFWkem
        IFzvoOMit4XYtkhwnXLHp9GEPA/zBC112oJtHB1eSha4BMrRRlaGwhncM0afaVe49A2JbN
        RHrkvqRtuf2wIMJwRgkEDZBV73jlMRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638904757;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KGfxnrDfy3keDHqfhFuAw5ARe/IrHK3+v7LBbX77lc=;
        b=H+fhUrgFcwdkvjqnBeBiLoZG4dxzWJYI8MAv2mwu9eltwYAIHrnx1pw15gqXdG0Ai+ifgY
        cjQ/wSI1eLpueeAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D0727A3B83;
        Tue,  7 Dec 2021 19:19:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 397FCDA799; Tue,  7 Dec 2021 20:19:03 +0100 (CET)
Date:   Tue, 7 Dec 2021 20:19:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: include the free space tree in the global rsv
 minimum calculation
Message-ID: <20211207191902.GE28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1638377089.git.josef@toxicpanda.com>
 <13d6e38d365639ac7a6b982f465332a78e0a516e.1638377089.git.josef@toxicpanda.com>
 <e57e0536-779b-f617-477f-08e3c99c5c81@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57e0536-779b-f617-477f-08e3c99c5c81@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 11:07:51AM +0200, Nikolay Borisov wrote:
> > diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> > index 21ac60ec19f6..b3086f252ad0 100644
> > --- a/fs/btrfs/block-rsv.c
> > +++ b/fs/btrfs/block-rsv.c
> > @@ -352,25 +352,29 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
> >  {
> >  	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
> >  	struct btrfs_space_info *sinfo = block_rsv->space_info;
> > -	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
> > -	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
> > -	u64 num_bytes;
> > -	unsigned min_items;
> > +	struct btrfs_root *root, *tmp;
> > +	u64 num_bytes = btrfs_root_used(&fs_info->tree_root->root_item);
> > +	unsigned int min_items = 1;
> >  
> >  	/*
> >  	 * The global block rsv is based on the size of the extent tree, the
> >  	 * checksum tree and the root tree.  If the fs is empty we want to set
> >  	 * it to a minimal amount for safety.
> > +	 *
> > +	 * We also are going to need to modify the minimum of the tree root and
> > +	 * any global roots we could touch.
> >  	 */
> > -	num_bytes = btrfs_root_used(&extent_root->root_item) +
> > -		btrfs_root_used(&csum_root->root_item) +
> > -		btrfs_root_used(&fs_info->tree_root->root_item);
> > -
> > -	/*
> > -	 * We at a minimum are going to modify the csum root, the tree root, and
> > -	 * the extent root.
> > -	 */
> > -	min_items = 3;
> > +	read_lock(&fs_info->global_root_lock);
> > +	rbtree_postorder_for_each_entry_safe(root, tmp, &fs_info->global_root_tree,
> > +					     rb_node) {
> > +		if (root->root_key.objectid == BTRFS_EXTENT_TREE_OBJECTID ||
> > +		    root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID ||
> > +		    root->root_key.objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
> > +			num_bytes += btrfs_root_used(&root->root_item);
> > +			min_items++;
> > +		}
> > +	}
> 
> nit: I think those changes constitute 2 patches - the first does the
> global_root_tree iteration as preparation for global roots. And the
> subsequent patch should also include the freespace tree, no ? Otherwise
> LGTM.

As this is probably a fix we'd like to backport, the oder of the
suggested patches would have to be reversed too, so we first have the
fix and then port to the global roots. But the diff is short and a
backport to non-global roots could be done in one go as well,
referencing this patch.
