Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F39B1D596D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEOSsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 14:48:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgEOSsI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 14:48:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ADA54AE95;
        Fri, 15 May 2020 18:48:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32271DA732; Fri, 15 May 2020 20:47:14 +0200 (CEST)
Date:   Fri, 15 May 2020 20:47:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: Don't set SHAREABLE flag for data reloc
 tree
Message-ID: <20200515184713.GP18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200515060142.23609-1-wqu@suse.com>
 <20200515060142.23609-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515060142.23609-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 15, 2020 at 02:01:42PM +0800, Qu Wenruo wrote:
> @@ -1525,6 +1526,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>  	btrfs_put_root(fs_info->uuid_root);
>  	btrfs_put_root(fs_info->free_space_root);
>  	btrfs_put_root(fs_info->fs_root);
> +	btrfs_put_root(fs_info->data_reloc_root);
>  	btrfs_check_leaked_roots(fs_info);
>  	btrfs_extent_buffer_leak_debug_check(fs_info);
>  	kfree(fs_info->super_copy);

> +	location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
> +	root = btrfs_get_fs_root(fs_info, &location, true);
> +	if (IS_ERR(root)) {
> +		ret = PTR_ERR(root);
> +		goto out;
> +	}
> +	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +	fs_info->data_reloc_root = root;

I've read the code more carefully, the data reloc tree needs to be read
as the others, like fs_tree as you said before. A new tree has the
reference count set to 1, which is what I missed before, so calling
btrfs_get_fs_root would set it to 2 and then btrfs_free_fs_info won't
free it as it expects refs == 1. Sorry for misleading you.

> @@ -3470,14 +3470,12 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
>  {
>  	struct inode *inode = NULL;
>  	struct btrfs_trans_handle *trans;
> -	struct btrfs_root *root;
> +	struct btrfs_root *root = btrfs_grab_root(fs_info->data_reloc_root);

Which means you can use the pointer directly as you had in previous
versions.

>  	struct btrfs_key key;
>  	u64 objectid;
>  	int err = 0;
>  
> -	root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
> -	if (IS_ERR(root))
> -		return ERR_CAST(root);
> +	ASSERT(root);
>  
>  	trans = btrfs_start_transaction(root, 6);
>  	if (IS_ERR(trans)) {
> @@ -3870,13 +3868,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>  
>  	if (err == 0) {
>  		/* cleanup orphan inode in data relocation tree */
> -		fs_root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
> -		if (IS_ERR(fs_root)) {
> -			err = PTR_ERR(fs_root);
> -		} else {
> -			err = btrfs_orphan_cleanup(fs_root);
> -			btrfs_put_root(fs_root);
> -		}
> +		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
> +		ASSERT(fs_root);
> +		err = btrfs_orphan_cleanup(fs_root);
> +		btrfs_put_root(fs_root);

Here it's fine to grab/put so it's clear the tree is in use but it's
merely for clarity.
