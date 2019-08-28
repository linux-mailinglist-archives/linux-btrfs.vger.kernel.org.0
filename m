Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160619FA82
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfH1G1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 02:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:49264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfH1G1V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 02:27:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84667B03A;
        Wed, 28 Aug 2019 06:27:19 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] btrfs: tree-checker: Fix wrong check on max devid
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
References: <20190828023313.22417-1-wqu@suse.com>
 <20190828023313.22417-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e91bdb2b-e7f4-29a3-1012-bb97d96a0334@suse.com>
Date:   Wed, 28 Aug 2019 09:27:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828023313.22417-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.08.19 г. 5:33 ч., Qu Wenruo wrote:
> [BUG]
> The following script will cause false alert on devid check.
>   #!/bin/bash
> 
>   dev1=/dev/test/test
>   dev2=/dev/test/scratch1
>   mnt=/mnt/btrfs
> 
>   umount $dev1 &> /dev/null
>   umount $dev2 &> /dev/null
>   umount $mnt &> /dev/null
> 
>   mkfs.btrfs -f $dev1
> 
>   mount $dev1 $mnt
> 
>   _fail()
>   {
>           echo "!!! FAILED !!!"
>           exit 1
>   }
> 
>   for ((i = 0; i < 4096; i++)); do
>           btrfs dev add -f $dev2 $mnt || _fail
>           btrfs dev del $dev1 $mnt || _fail
>           dev_tmp=$dev1
>           dev1=$dev2
>           dev2=$dev_tmp
>   done

Instead of putting the script here, can't it be turned into a fstest to
ensure we don't regress in the future?

> 
> [CAUSE]
> Tree-checker uses BTRFS_MAX_DEVS() and BTRFS_MAX_DEVS_SYS_CHUNK() as
> upper limit for devid.
> But we can have devid holes just like above script.
> 
> So the check for devid is incorrect and could cause false alert.
> 
> [FIX]
> Just remove the whole devid check.
> We don't have any hard requirement for devid assignment.
> 
> Furthermore, even devid get corrupted by bitflip, we still have dev
> extents verification at mount time, so corrupted data won't sneak into
> kernel.
> 
> Reported-by: Anand Jain <anand.jain@oracle.com>
> Fixes: ab4ba2e13346 ("btrfs: tree-checker: Verify dev item")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove devid check completely
>   As we already have verify_one_dev_extent().
> v3:
> - Unexport BTRFS_MAX_DEVS() and BTRFS_MAX_DEVS_SYS_CHUNK macros
> - Update commit message to include the reproducer.
> ---
>  fs/btrfs/tree-checker.c | 8 --------
>  fs/btrfs/volumes.c      | 9 +++++++++
>  fs/btrfs/volumes.h      | 9 ---------
>  3 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ccd5706199d7..15d1aa7cef1f 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -686,9 +686,7 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
>  static int check_dev_item(struct extent_buffer *leaf,
>  			  struct btrfs_key *key, int slot)
>  {
> -	struct btrfs_fs_info *fs_info = leaf->fs_info;
>  	struct btrfs_dev_item *ditem;
> -	u64 max_devid = max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CHUNK);
>  
>  	if (key->objectid != BTRFS_DEV_ITEMS_OBJECTID) {
>  		dev_item_err(leaf, slot,
> @@ -696,12 +694,6 @@ static int check_dev_item(struct extent_buffer *leaf,
>  			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
>  		return -EUCLEAN;
>  	}
> -	if (key->offset > max_devid) {
> -		dev_item_err(leaf, slot,
> -			     "invalid devid: has=%llu expect=[0, %llu]",
> -			     key->offset, max_devid);
> -		return -EUCLEAN;
> -	}
>  	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
>  	if (btrfs_device_id(leaf, ditem) != key->offset) {
>  		dev_item_err(leaf, slot,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8b72d03738d9..56f751192a6c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4901,6 +4901,15 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
>  	btrfs_set_fs_incompat(info, RAID56);
>  }
>  
> +#define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
> +			- sizeof(struct btrfs_chunk))		\
> +			/ sizeof(struct btrfs_stripe) + 1)
> +
> +#define BTRFS_MAX_DEVS_SYS_CHUNK ((BTRFS_SYSTEM_CHUNK_ARRAY_SIZE	\
> +				- 2 * sizeof(struct btrfs_disk_key)	\
> +				- 2 * sizeof(struct btrfs_chunk))	\
> +				/ sizeof(struct btrfs_stripe) + 1)
> +
>  static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  			       u64 start, u64 type)
>  {
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 7f6aa1816409..789f983a98c5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -273,15 +273,6 @@ struct btrfs_fs_devices {
>  
>  #define BTRFS_BIO_INLINE_CSUM_SIZE	64
>  
> -#define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
> -			- sizeof(struct btrfs_chunk))		\
> -			/ sizeof(struct btrfs_stripe) + 1)
> -
> -#define BTRFS_MAX_DEVS_SYS_CHUNK ((BTRFS_SYSTEM_CHUNK_ARRAY_SIZE	\
> -				- 2 * sizeof(struct btrfs_disk_key)	\
> -				- 2 * sizeof(struct btrfs_chunk))	\
> -				/ sizeof(struct btrfs_stripe) + 1)
> -
>  /*
>   * we need the mirror number and stripe index to be passed around
>   * the call chain while we are processing end_io (especially errors).
> 
