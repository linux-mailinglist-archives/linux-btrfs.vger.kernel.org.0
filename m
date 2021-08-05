Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AF3E16DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhHEOYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 10:24:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50154 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhHEOYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 10:24:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7039E1FE58;
        Thu,  5 Aug 2021 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628173455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Og8x/gyy+4nek1+IFr3K+t79ZOraRmhRrkC1xybmcWM=;
        b=XN7frrdiM4Ylxy76oTplCKjXJ+4ZbO0llNR9l9lVcstWhf6Obpt1K0X4PbE/0FmPowBWOB
        KIrRQ9LPCqLf5UGPtO5pSeymPxEbm9924y176thh76wNoChHjc/sL49favDCNQb9CUc6bV
        r9ztmtr9qkqbiFljbAnZc66mQcpEOTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628173455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Og8x/gyy+4nek1+IFr3K+t79ZOraRmhRrkC1xybmcWM=;
        b=xjqyK57RTEZyPJaBbEgpuPygNGP0vxlBN+zlMEpGx8mlfcAN0c7WxqM3xLsoHtS+NejrST
        VeUAm8AVkYwS6NDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BAED13D66;
        Thu,  5 Aug 2021 14:24:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 32nmNof0C2GbZAAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Thu, 05 Aug 2021 14:24:07 +0000
Message-ID: <00ab6e41219e5b863a1cac5cce86bf0a49da4945.camel@suse.de>
Subject: Re: [PATCH 7/7] btrfs: ioctl: Simplify btrfs_ioctl_get_subvol_info
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Anand Jain <anand.jain@oracle.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
Date:   Thu, 05 Aug 2021 11:23:40 -0300
In-Reply-To: <8b887a24-b676-360e-4cc1-d0dc0e0a0b19@oracle.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
         <20210804184854.10696-8-mpdesouza@suse.com>
         <8b887a24-b676-360e-4cc1-d0dc0e0a0b19@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2021-08-05 at 20:13 +0800, Anand Jain wrote:
> On 05/08/2021 02:48, Marcos Paulo de Souza wrote:
> > By using btrfs_find_item we can simplify the code.
> 
>   Yep. I like the idea.
> 
> > Also, remove the
> > -ENOENT error condition, since it'll never hit. If find_item
> > returns 0,
> > it means it found the desired objectid and type, so it won't reach
> > the -ENOENT
> > condition.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
>   Looks good to me.
> 
>   Reviewed-by: Anand Jain <anand.jain@oracle.com>

Sorry, I believe that I did a mistake here.

See bellow.

> 
> Thanks, Anand
> 
> > ---
> >   fs/btrfs/ioctl.c | 56 +++++++++++++++++++----------------------
> > -------
> >   1 file changed, 22 insertions(+), 34 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index d09eaa83b5d2..2c57bea16c92 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -2685,6 +2685,7 @@ static int btrfs_ioctl_get_subvol_info(struct
> > file *file, void __user *argp)
> >   	unsigned long item_off;
> >   	unsigned long item_len;
> >   	struct inode *inode;
> > +	u64 treeid;
> >   	int slot;
> >   	int ret = 0;
> >   
> > @@ -2702,15 +2703,15 @@ static int
> > btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
> >   	fs_info = BTRFS_I(inode)->root->fs_info;
> >   
> >   	/* Get root_item of inode's subvolume */
> > -	key.objectid = BTRFS_I(inode)->root->root_key.objectid;
> > -	root = btrfs_get_fs_root(fs_info, key.objectid, true);
> > +	treeid = BTRFS_I(inode)->root->root_key.objectid;
> > +	root = btrfs_get_fs_root(fs_info, treeid, true);
> >   	if (IS_ERR(root)) {
> >   		ret = PTR_ERR(root);
> >   		goto out_free;
> >   	}
> >   	root_item = &root->root_item;
> >   
> > -	subvol_info->treeid = key.objectid;
> > +	subvol_info->treeid = treeid;
> >   
> >   	subvol_info->generation = btrfs_root_generation(root_item);
> >   	subvol_info->flags = btrfs_root_flags(root_item);
> > @@ -2737,44 +2738,31 @@ static int
> > btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
> >   	subvol_info->rtime.sec = btrfs_stack_timespec_sec(&root_item-
> > >rtime);
> >   	subvol_info->rtime.nsec = btrfs_stack_timespec_nsec(&root_item-
> > >rtime);
> >   
> > -	if (key.objectid != BTRFS_FS_TREE_OBJECTID) {
> > +	if (treeid != BTRFS_FS_TREE_OBJECTID) {
> >   		/* Search root tree for ROOT_BACKREF of this subvolume
> > */
> > -		key.type = BTRFS_ROOT_BACKREF_KEY;
> > -		key.offset = 0;
> > -		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
> > path, 0, 0);
> > +		ret = btrfs_find_item(fs_info->tree_root, path, treeid,
> > +					BTRFS_ROOT_BACKREF_KEY, 0,
> > &key);
> >   		if (ret < 0) {
> >   			goto out;
> > -		} else if (path->slots[0] >=
> > -			   btrfs_header_nritems(path->nodes[0])) {
> > -			ret = btrfs_next_leaf(fs_info->tree_root,
> > path);
> > -			if (ret < 0) {
> > -				goto out;
> > -			} else if (ret > 0) {
> > -				ret = -EUCLEAN;
> > -				goto out;
> > -			}

btrfs_next_leaf returns > 0 if it there aren't any other leaf. So, in
this case, it can find another leaf.

> > +		} else if (ret > 0) {
> > +			ret = -EUCLEAN;
> > +			goto out;
> >   		}

This is wrong, since btrfs_find_item can return 1 is next_leaf returned
something different OR if the objectid or type aren't the same.

In this case, the -ENOENT path can be reached, since there can be more
leaves but with different objectid and type.

In this case, with the following change, we would report such situation
wrongly as -EUCLEAN.

I'll rework this patch in the v2 of this patchset.

> >   
> >   		leaf = path->nodes[0];
> >   		slot = path->slots[0];
> > -		btrfs_item_key_to_cpu(leaf, &key, slot);
> > -		if (key.objectid == subvol_info->treeid &&
> > -		    key.type == BTRFS_ROOT_BACKREF_KEY) {
> > -			subvol_info->parent_id = key.offset;
> > -
> > -			rref = btrfs_item_ptr(leaf, slot, struct
> > btrfs_root_ref);
> > -			subvol_info->dirid = btrfs_root_ref_dirid(leaf,
> > rref);
> > -
> > -			item_off = btrfs_item_ptr_offset(leaf, slot)
> > -					+ sizeof(struct
> > btrfs_root_ref);
> > -			item_len = btrfs_item_size_nr(leaf, slot)
> > -					- sizeof(struct
> > btrfs_root_ref);
> > -			read_extent_buffer(leaf, subvol_info->name,
> > -					   item_off, item_len);
> > -		} else {
> > -			ret = -ENOENT;
> > -			goto out;
> > -		}
> > +
> > +		subvol_info->parent_id = key.offset;
> > +
> > +		rref = btrfs_item_ptr(leaf, slot, struct
> > btrfs_root_ref);
> > +		subvol_info->dirid = btrfs_root_ref_dirid(leaf, rref);
> > +
> > +		item_off = btrfs_item_ptr_offset(leaf, slot)
> > +				+ sizeof(struct btrfs_root_ref);
> > +		item_len = btrfs_item_size_nr(leaf, slot)
> > +				- sizeof(struct btrfs_root_ref);
> > +		read_extent_buffer(leaf, subvol_info->name,
> > +				   item_off, item_len);
> >   	}
> >   
> >   	if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
> > 

