Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1364149C8D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 12:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbiAZLkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 06:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiAZLkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 06:40:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CE3C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 03:40:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B296193E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 11:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B88EC340E3;
        Wed, 26 Jan 2022 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643197238;
        bh=PUa0W2oats1AHN55jcLJoYXfAMR3UdPSFf5Af/Fuo64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLDL8/2KwLlQi8a2ilGTTQr9LhNMmVJBQn9mSu5s/ybCtysYHlnxAwh6iD54WoSCF
         C6XVuik8K/XN3srvh4PY11n+xKv38WAxLKbhb578bs0pOEUM/hUQ7gJfJMBxwPdypy
         J+DbcBF93HkMs8f+cQYqsAXDynWbTsyStUv5krsQM1bjJ+9ihhZI0Nksb6x7CWBzUD
         khnrTSuXVGaUwUm5vX2c+ypviYMJ+3cydm2XTRBv/gzuOMitpLJYQ+P5bthsotggTx
         UGen9Sr4lfsNEbSwEQXWOptxIkNA/Elyy7baxNwa9BQXalf7I2hSWhhbf8ZhvzQuA3
         +Xmjfo9GFVMcg==
Date:   Wed, 26 Jan 2022 11:40:36 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: defrag: use extent_thresh to replace the
 hardcoded size limit
Message-ID: <YfEzNCybtrSufSvu@debian9.Home>
References: <20220126005850.14729-1-wqu@suse.com>
 <20220126005850.14729-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126005850.14729-2-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 08:58:49AM +0800, Qu Wenruo wrote:
> In defrag_lookup_extent() we use hardcoded extent size threshold, SZ_128K,
> other than @extent_thresh in btrfs_defrag_file().
> 
> This can lead to some inconsistent behavior, especially the default
> extent size threshold is 256K.
> 
> Fix this by passing @extent_thresh into defrag_check_next_extent() and
> use that value.
> 
> Also, since the extent_thresh check should be applied to all extents,
> not only physically adjacent extents, move the threshold check into a
> dedicate if ().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0d8bfc716e6b..2911df12fc48 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1050,7 +1050,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>  }
>  
>  static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> -				     bool locked)
> +				     u32 extent_thresh, bool locked)
>  {
>  	struct extent_map *next;
>  	bool ret = false;
> @@ -1066,9 +1066,11 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  	/* Preallocated */
>  	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>  		goto out;
> -	/* Physically adjacent and large enough */
> -	if ((em->block_start + em->block_len == next->block_start) &&
> -	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
> +	/* Extent is already large enough */
> +	if (next->len >= extent_thresh)
> +		goto out;

So this will trigger unnecessary rewrites of compressed extents.
The SZ_128K is there to deal with compressed extents, it has nothing to
do with the threshold passed to the ioctl.

After applying this patchset, if you run a trivial test like this:

   #!/bin/bash

   DEV=/dev/sdj
   MNT=/mnt/sdj

   mkfs.btrfs -f $DEV
   mount -o compress $DEV $MNT

   xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
   sync
   # Write to some other file so that the next extent for foobar
   # is not contiguous with the first extent.
   xfs_io -f -c "pwrite 0 128K" $MNT/baz
   sync
   xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
   sync

   echo -e "\n\nTree after creating file:\n\n"
   btrfs inspect-internal dump-tree -t 5 $DEV

   btrfs filesystem defragment $MNT/foobar
   sync

   echo -e "\n\nTree after defrag:\n\n"
   btrfs inspect-internal dump-tree -t 5 $DEV

   umount $MNT

It will result in rewriting the two 128K compressed extents:

(...)
Tree after write and sync:

btrfs-progs v5.12.1 
fs tree key (FS_TREE ROOT_ITEM 0) 
(...)
	item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
		index 2 namelen 6 name: foobar
	item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
		generation 6 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 1 (zlib)
	item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
		generation 8 type 1 (regular)
		extent data disk byte 14163968 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 1 (zlib)
(...)

Tree after defrag:

btrfs-progs v5.12.1 
fs tree key (FS_TREE ROOT_ITEM 0) 
(...)
	item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
		index 2 namelen 6 name: foobar
	item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 14430208 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 1 (zlib)
	item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 13635584 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 1 (zlib)

In other words, a waste of IO and CPU time.

So it needs to check if we are dealing with compressed extents, and
if so, skip either of them has a size of SZ_128K (and changelog updated).

Thanks.

> +	/* Physically adjacent */
> +	if ((em->block_start + em->block_len == next->block_start))
>  		goto out;
>  	ret = true;
>  out:
> @@ -1231,7 +1233,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			goto next;
>  
>  		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
> -							  locked);
> +							  extent_thresh, locked);
>  		if (!next_mergeable) {
>  			struct defrag_target_range *last;
>  
> -- 
> 2.34.1
> 
