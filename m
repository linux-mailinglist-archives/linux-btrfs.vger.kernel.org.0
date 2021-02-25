Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7A3252C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 16:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBYPzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 10:55:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:46344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhBYPzA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 10:55:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71EACAF6F;
        Thu, 25 Feb 2021 15:54:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DEBEDA790; Thu, 25 Feb 2021 16:52:25 +0100 (CET)
Date:   Thu, 25 Feb 2021 16:52:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use transid for DIR_ITEM/DIR_INDEX's location
Message-ID: <20210225155225.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200828132010.27886-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828132010.27886-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 04:20:10PM +0300, Nikolay Borisov wrote:
> When a snapshot is created its root item is inserted in the root tree
> with the 'offset' field set to the transaction id when the snapshot
> was created. Immediately afterwards the offset is set to -1 so when
> the same key is used to create DIR_ITEM/DIR_INDEX in the destination
> file tree its offset is really set to -1. Root tree item:
> 
>     item 13 key (258 ROOT_ITEM 7) itemoff 12744 itemsize 439
>         generation 7 root_dirid 256 bytenr 30703616 level 0 refs 1
>         lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x0(none)
>         uuid f13abf0d-b1f5-f34b-a179-fd1c2f89e762
>         parent_uuid 51a74677-a077-4c21-bd87-2141a147ff85
>         ctransid 7 otransid 7 stransid 0 rtransid 0
>         ctime 1598441149.466822752 (2020-08-26 11:25:49)
>         otime 1598441149.467474846 (2020-08-26 11:25:49)
>         drop key (0 UNKNOWN.0 0) level 0
> 
> DIR_INDEX item for the same rooti in the destination fs tree:
> 
> item 5 key (256 DIR_INDEX 9) itemoff 15967 itemsize 39
>         location key (258 ROOT_ITEM 18446744073709551615) type DIR
>         transid 7 data_len 0 name_len 9
>         name: snapshot1
> 
> The location key is generally used to read the root. This is not a
> problem per-se since the function dealing with root searching
> (btrfs_find_root) is well equipped to deal with offset being -1, namely:
> 
>     If ->offset of 'search_key' is -1ULL, it means we are not sure the
>     offset of the search key, just lookup the root with the highest
>     offset for a given objectid.
> 
> However this is a needless inconcistency in the way internal data
> structures are being created. This patch modifies the behavior so that
> DIR_INDEX/DIR_ITEM will have the offset field of the location key set
> to the transid. While this results in a change of the on-disk metadata,
> it doesn't constitute a functional change since older kernels can cope
> with both '-1' and transid as values of the offset field so no INCOMPAT
> flags are needed.
> 
> Finally while at it also move the initialization of the key in
> create_pending_snapshot closer to where it's being used for the first
> time.

For the record I'll reply here too.

This is technically correct and probably wouldn't cause any noticeable
problem. The main concern here is that it's changing the item data from
a format that's been out there forever. Once this patch would land, the
dir items will have a different location key, making it inconsistent.

That the root item key itself has the transaction id is part of the
format, that dir item location keys have the -1 in the offset is as
well.  That the two are different and not the same is maybe unfortunate
but certainly not harmful.

Changing the format even a little always brings a risk and we never know
in advance. We only learn from mistakes here and did a few in the past.
My gut feeling is to keep it as-is, or do it properly with incompat
bits if needed. In this case it's not necessary so we'll keep things
unchanged.

> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/transaction.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 7243532cd34b..83f4e7056488 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1509,9 +1509,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>  			goto clear_skip_qgroup;
>  	}
>  
> -	key.objectid = objectid;
> -	key.offset = (u64)-1;
> -	key.type = BTRFS_ROOT_ITEM_KEY;
>  
>  	rsv = trans->block_rsv;
>  	trans->block_rsv = &pending->block_rsv;
> @@ -1613,7 +1610,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>  
>  	btrfs_set_root_node(new_root_item, tmp);
>  	/* record when the snapshot was created in key.offset */
> +	key.objectid = objectid;
>  	key.offset = trans->transid;
> +	key.type = BTRFS_ROOT_ITEM_KEY;

This can be sent as a cleanup, it's better to keep the key intialization
at one place.

>  	ret = btrfs_insert_root(trans, tree_root, &key, new_root_item);
>  	btrfs_tree_unlock(tmp);
>  	free_extent_buffer(tmp);
> @@ -1634,7 +1633,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>  		goto fail;
>  	}
>  
> -	key.offset = (u64)-1;

And a comment explaining the difference between the root item and dir
item keys.

>  	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->anon_dev);
>  	if (IS_ERR(pending->snap)) {
>  		ret = PTR_ERR(pending->snap);
> -- 
> 2.17.1
