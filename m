Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0912BB20A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391266AbfIMNZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 09:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391259AbfIMNZA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2355B671;
        Fri, 13 Sep 2019 13:24:56 +0000 (UTC)
Subject: Re: [PATCH 2/2] btrfs: qgroup: Fix reserved data space leak if we
 have multiple reserve calls
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190913015127.14953-1-wqu@suse.com>
 <20190913015127.14953-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c042c361-7b33-30a4-1cf7-01b54cd9720c@suse.com>
Date:   Fri, 13 Sep 2019 16:24:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913015127.14953-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.09.19 г. 4:51 ч., Qu Wenruo wrote:
> [BUG]
> The following script can cause btrfs qgroup data space leak:
> 
>   mkfs.btrfs -f $dev
>   mount $dev -o nospace_cache $mnt
> 
>   btrfs subv create $mnt/subv
>   btrfs quota en $mnt
>   btrfs quota rescan -w $mnt
>   btrfs qgroup limit 128m $mnt/subv
> 
>   for (( i = 0; i < 3; i++)); do
>           # Create 3 64M holes for latter fallocate to fail
>           truncate -s 192m $mnt/subv/file
>           xfs_io -c "pwrite 64m 4k" $mnt/subv/file > /dev/null
>           xfs_io -c "pwrite 128m 4k" $mnt/subv/file > /dev/null
>           sync
> 
>           # it's supposed to fail, and each failure will leak at least 64M
>           # data space
>           xfs_io -f -c "falloc 0 192m" $mnt/subv/file &> /dev/null
>           rm $mnt/subv/file
>           sync
>   done
> 
>   # Shouldn't fail after we removed the file
>   xfs_io -f -c "falloc 0 64m" $mnt/subv/file
> 
> [CAUSE]
> Btrfs qgroup data reserve code allows multiple reserve happen on a
                                                  ^
                                                 reservations to happen
> single extent_changeset:
> 
> The only usage is in btrfs_fallocate():
> 	struct extent_changeset *data_reserved = NULL;
> 	btrfs_qgroup_reserve_data(inode, &data_reserved,
> 				  range_start, range_len);
> 	...
> 	btrfs_qgroup_reserve_data(inode, &data_reserved,
> 				  new_range_start, new_range_len);
> 	extent_changeset_free(data_reserved);

I take it you refer to the while() loop in btrfs_fallocate. The code
above is really just a _VERY_ condensed version. extent_changeset_free
is at the end of the function. Instead of putting random lines of code
just explicitly state it, something along the lines of:

"The only such pattern is in btrfs_fallocate in the main while loop in
that function".

> 
> However in btrfs_qgroup_reserve_data(), if one of the call failed, it               > will cleanup all reserved space.
> The cleanup itself is OK, but it only cleans up all
> EXTENT_QGROUP_RESERVED flag, forget to release the reserved bytes.
> 
> So if multiple btrfs_qgroup_reserve_data() get called, and the last one
> failed, then previously reserved data space will get leaked.
> 
> And due to the fact that EXTENT_QGROUP_RESERVED flag is cleaned
> correctly, btrfs_qgroup_check_reserved_leak() won't catch the leakage.

How about rephraing the above 3 paragraphs along the lines of:

"btrfs_qgroup_reserve_data's error handling has a bug in that on error
it clears all ranges in the io_tree with EXTENT_QGROUP_RESERVED flag and
doesn't free the reserved bytes. This behavior has a two fold effect:

 1. Clearing EXTENT_QGROUP_RESERVED ranges prevents
btrfs_qgroup_check_reserved_leak to catch the leakage.
 2. Leak the previously reserved data bytes.


The bug manifests when N calls to btrfs_qgroup_reserve_data are made and
the last one fails, leaking space allocated in the previous ones.
"


> 
> [FIX]
> Also free previously reserved data bytes when btrfs_qgroup_reserve_data
> fails.
> 
> Fixes: 524725537023 ("btrfs: qgroup: Introduce btrfs_qgroup_reserve_data function")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 64bdc3e3652d..59f6a9981087 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3448,6 +3448,9 @@ int btrfs_qgroup_reserve_data(struct inode *inode,
>  	while ((unode = ulist_next(&reserved->range_changed, &uiter)))
>  		clear_extent_bit(&BTRFS_I(inode)->io_tree, unode->val,
>  				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0, NULL);
> +	/* Also free data bytes of already reserved one */
> +	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid,
> +				  orig_reserved, BTRFS_QGROUP_RSV_DATA);
>  	extent_changeset_release(reserved);
>  	return ret;
>  }
> 
