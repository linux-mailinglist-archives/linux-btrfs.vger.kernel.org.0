Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412615B5175
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIKWMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 18:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIKWMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 18:12:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67637252BF
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662934342;
        bh=h3rAp7VI/GRVj7Z2NYad5t57evop2C/OREO5BfcyIsQ=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=VNwaufHcWEYRqEvIGuKfx4TBlSo/LHzKCoYRKhiMrkcXsd8wmXg58AnnGhAfqRj2x
         XW++IxEHWESUUojFeORHnkILIcI5k1q0QnyjsACz90JtsMm5odFvFIblrFo/a2UtTi
         q36KHxGYVX1XErZ2MHqHBuTW/E14CcmPgDn1UyEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDkm-1pHk5d1sKm-00xeUA; Mon, 12
 Sep 2022 00:12:22 +0200
Message-ID: <d1e22323-0498-d29b-a821-563b09b84647@gmx.com>
Date:   Mon, 12 Sep 2022 06:12:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <246cd5358b28e3e11a96fe2abd0a4a34840cdb85.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 02/10] btrfs: make hole and data seeking a lot more
 efficient
In-Reply-To: <246cd5358b28e3e11a96fe2abd0a4a34840cdb85.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9g3sSknpKVm9+V7ea0QmzU8oAqzaJtVa3m+2eInHAo2/x49eCQv
 72sgwZ2J18PUhMqfay8ZWbNryzKQ4egkH5AbIESclv0rdF4DUFVDOv1dIDODtlXZGIZhZ6T
 /QHZ/JkufIbmJ8gaaXch3RR2tBi00o/xEVZjIkYO7ASUKlpEpxNd3tmEXTFGHsPoT/CUqaj
 biYeYOIwF8GqPgXEeOuIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wj4HsLaX6V8=:lZBJL4tlUD1BgITq4QWiiY
 3GD/l2Gm79oSGRgGVBEZkOimw7hsubG2wkitJlU5b3kgHQ+azgMC2+x3BfUNOP/ZA3WgV77lR
 8UVq/m+ocJt1EjeCSGQVWDCPg1LaAG/c1+hDK5BGGpZOKIgTh4Yus0C97kI2uvXAdurrBYYiW
 R/+CeCnzrqooGSwOMxS7f15pZOye7+3/3QZYNRhYZjPjkDJg8W9J8dXXb5yEGd74stXVcilKt
 NIMMbC/dxIZM27bKWolnzsWCt7kPXrZRAsI1s+Vf8rXGVr+ar44Yof1OCWX8jzUNasf7sSQKF
 4FirOhxZaIL2RKIs4NSkCw7JRPa31zw9iWolXj99rcRk6hUdM9ojcyid+KQe09l4zZajqCWuc
 0p6DmN2Zj/ymsAWGAma0+3JmMasVVqqfwDp1/awaGoRzmKJciL0YODKVAz8ThbD1zy8yEufeb
 FIfQJcwHkear3K+igeKyhnKaMOTAZcCmbFBIp3j5m9RqEJ2UKtR76x2UA23VjWGXs2yK753m3
 1KCSowhh+IdRFVjJQE8hdRXy3AAt0gks0c5UmLBG4mbVvvDKS85KlMai5DjyDu00tyZ6bvgYA
 v6REDgSYCnDjYpUWYuHjzKUZ8P5/SwIcNpsxUdWLC8QtOC6MWZpuAg/rv+qZ/9UtHXKBDSxn8
 UEnd2uIgNYKJ/DXzrKEbW2Ulyt5Rbkj4XCabBirlMtBZ2UvQTI1JHpDKNVVacsL32mxVvF/HW
 Dkd4E9xfkRyoeIiDGoBcDdqHR+bvGi9C21qQMBwpv7KJlbY8wUGt/LNMKBuHQJVeVYFOgbNUL
 bg5vVh0SnyYVCaAoO+aIwvTfOf00OzdQtBqS+ew3CCOmbzYbwfod86ouXBT8xjojvjE49M2oh
 ywR3tT3fTt8qD+bkH1XbSRXhpajeripo7ApYJ3hhfwGYjkV+TzuMV92Slp7OCzCERbsvW+HW6
 Rhgz3a8YCJJyexr9YqO8J4XudQZiop2w6fzOAKb0D1cnZz+WaU1ZHc+8xf9OiDr03b29vLgzo
 x9D0A954/PjbLFJFm3MoC40hkmYOR3zcvRPOv+wnGkD82+F0ieWjYY5G/fjGtQ3keIfCnuOI3
 I76iSyjpmIJ27RAlowGgtMBNScRpZL9J9BuG+6Ar+/FWfPlVEsB833sKDibCE92ne5PGdJHxR
 JgMw/SskCtyjCJZiTGouZ6HMcL
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The current implementation of hole and data seeking for llseek does not
> scale well in regards to the number of extents and the distance between
> the start offset and the next hole or extent. This is due to a very high
> algorithmic complexity. Often we also get reports of btrfs' hole and dat=
a
> seeking (llseek) being too slow, such as at 2017's LSFMM (see the Link
> tag at the bottom).
>
> In order to better understand it, lets consider the case where the start
> offset is 0, we are seeking for a hole and the file size is 16G. Between
> file offset 0 and the first hole in the file there are 100K extents - th=
is
> is common for large files, specially if we have compression enabled, sin=
ce
> the maximum extent size is limited to 128K. The steps take by the main
> loop of the current algorithm are the following:
>
> 1) We start by calling btrfs_get_extent_fiemap(), for file offset 0, whi=
ch
>     calls btrfs_get_extent(). This will first lookup for an extent map i=
n
>     the inode's extent map tree (a red black tree). If the extent map is
>     not loaded in memory, then it will do a lookup for the corresponding
>     file extent item in the subvolume's b+tree, create an extent map bas=
ed
>     on the contents of the file extent item and then add the extent map =
to
>     the extent map tree of the inode;
>
> 2) The second iteration calls btrfs_get_extent_fiemap() again, this time
>     with a start offset matching the end offset of the previous extent.
>     Again, btrfs_get_extent() will first search the extent map tree, and
>     if it doesn't find an extent map there, it will again search in the
>     b+tree of the subvolume for a matching file extent item, build an
>     extent map based on the file extent item, and add the extent map to
>     to the extent map tree of the inode;

One small question, unrelated to the whole series since the series
mostly no longer utilize the extent map tree anymore.

I'm wondering if we should add all near by extent map in a batch, other
than one by one, in btrfs_get_extent()?
(E.g. if we find what we need, and there are more file extents in the
same leaf, we can just continue to add them all into the cache)

However I'm not 100% sure if it's good or not, as the extent map can
take up memory space and no way to free unless truncation/evict.
And we have very limited usage for extent map (other than read and log
tree?)

Thanks,
Qu

>
> 3) This repeats over and over until we find the first hole (when seeking
>     for holes) or until we find the first extent (when seeking for data)=
.
>
>     If there no extent maps loaded in memory for each iteration, then on
>     each iteration we do 1 extent map tree search, 1 b+tree search, plus
>     1 more extent map tree traversal to insert an extent map - plus we
>     allocate memory for the extent map.
>
>     On each iteration we are growing the size of the extent map tree,
>     making each future search slower, and also visiting the same b+tree
>     leaves over and over again - taking into account with the default le=
af
>     size of 16K we can fit more than 200 file extent items in a leaf - s=
o
>     we can visit the same b+tree leaf 200+ times, on each visit walking
>     down a path from the root to the leaf.
>
> So it's easy to see that what we have now doesn't scale well. Also, it
> loads an extent map for every file extent item into memory, which is not
> efficient - we should add extents maps only when doing IO (writing or
> reading file data).
>
> This change implements a new algorithm which scales much better, and
> works like this:
>
> 1) We iterate over the subvolume's b+tree, visiting each leaf that has
>     file extent items once and only once;
>
> 2) For any file extent items found, that don't represent holes or preall=
oc
>     extents, it will not search the extent map tree - there's no need at
>     all for that - an extent map is just an in-memory representation of =
a
>     file extent item;
>
> 3) When a hole is found, or a prealloc extent, it will check if there's
>     delalloc for its range. For this it will search for EXTENT_DELALLOC
>     bits in the inode's io tree and check the extent map tree - this is
>     for accounting for unflushed delalloc and for flushed delalloc (the
>     period between running delalloc and ordered extent completion),
>     respectively. This is similar to what the current implementation doe=
s
>     when it finds a hole or prealloc extent, but without creating extent
>     maps and adding them to the extent map tree in case they are not
>     loaded in memory;
>
> 4) It never allocates extent maps, or adds extent maps to the inode's
>     extent map tree. This not only saves memory and time (from the tree
>     insertions and allocations), but also eliminates the possibility of
>     -ENOMEM due to allocating too many extent maps.
>
> Part of this new code will also be used later for fiemap (which also
> suffers similar scalability problems).
>
> The following test example can be used to quickly measure the efficiency
> before and after this patch:
>
>      $ cat test-seek-hole.sh
>      #!/bin/bash
>
>      DEV=3D/dev/sdi
>      MNT=3D/mnt/sdi
>
>      mkfs.btrfs -f $DEV
>
>      mount -o compress=3Dlzo $DEV $MNT
>
>      # 16G file -> 131073 compressed extents.
>      xfs_io -f -c "pwrite -S 0xab -b 1M 0 16G" $MNT/foobar
>
>      # Leave a 1M hole at file offset 15G.
>      xfs_io -c "fpunch 15G 1M" $MNT/foobar
>
>      # Unmount and mount again, so that we can test when there's no
>      # metadata cached in memory.
>      umount $MNT
>      mount -o compress=3Dlzo $DEV $MNT
>
>      # Test seeking for hole from offset 0 (hole is at offset 15G).
>
>      start=3D$(date +%s%N)
>      xfs_io -c "seek -h 0" $MNT/foobar
>      end=3D$(date +%s%N)
>      dur=3D$(( (end - start) / 1000000 ))
>      echo "Took $dur milliseconds to seek first hole (metadata not cache=
d)"
>      echo
>
>      start=3D$(date +%s%N)
>      xfs_io -c "seek -h 0" $MNT/foobar
>      end=3D$(date +%s%N)
>      dur=3D$(( (end - start) / 1000000 ))
>      echo "Took $dur milliseconds to seek first hole (metadata cached)"
>      echo
>
>      umount $MNT
>
> Before this change:
>
>      $ ./test-seek-hole.sh
>      (...)
>      Whence	Result
>      HOLE	16106127360
>      Took 176 milliseconds to seek first hole (metadata not cached)
>
>      Whence	Result
>      HOLE	16106127360
>      Took 17 milliseconds to seek first hole (metadata cached)
>
> After this change:
>
>      $ ./test-seek-hole.sh
>      (...)
>      Whence	Result
>      HOLE	16106127360
>      Took 43 milliseconds to seek first hole (metadata not cached)
>
>      Whence	Result
>      HOLE	16106127360
>      Took 13 milliseconds to seek first hole (metadata cached)
>
> That's about 4X faster when no metadata is cached and about 30% faster
> when all metadata is cached.
>
> In practice the differences may often be significantly higher, either du=
e
> to a higher number of extents in a file or because the subvolume's b+tre=
e
> is much bigger than in this example, where we only have one file.
>
> Link: https://lwn.net/Articles/718805/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/file.c | 437 ++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 406 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 96f444ad0951..b292a8ada3a4 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3601,22 +3601,281 @@ static long btrfs_fallocate(struct file *file, =
int mode,
>   	return ret;
>   }
>
> +/*
> + * Helper for have_delalloc_in_range(). Find a subrange in a given rang=
e that
> + * has unflushed and/or flushing delalloc. There might be other adjacen=
t
> + * subranges after the one it found, so have_delalloc_in_range() keeps =
looping
> + * while it gets adjacent subranges, and merging them together.
> + */
> +static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start=
, u64 end,
> +				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> +{
> +	const u64 len =3D end + 1 - start;
> +	struct extent_map_tree *em_tree =3D &inode->extent_tree;
> +	struct extent_map *em;
> +	u64 em_end;
> +	u64 delalloc_len;
> +
> +	/*
> +	 * Search the io tree first for EXTENT_DELALLOC. If we find any, it
> +	 * means we have delalloc (dirty pages) for which writeback has not
> +	 * started yet.
> +	 */
> +	*delalloc_start_ret =3D start;
> +	delalloc_len =3D count_range_bits(&inode->io_tree, delalloc_start_ret,=
 end,
> +					len, EXTENT_DELALLOC, 1);
> +	/*
> +	 * If delalloc was found then *delalloc_start_ret has a sector size
> +	 * aligned value (rounded down).
> +	 */
> +	if (delalloc_len > 0)
> +		*delalloc_end_ret =3D *delalloc_start_ret + delalloc_len - 1;
> +
> +	/*
> +	 * Now also check if there's any extent map in the range that does not
> +	 * map to a hole or prealloc extent. We do this because:
> +	 *
> +	 * 1) When delalloc is flushed, the file range is locked, we clear the
> +	 *    EXTENT_DELALLOC bit from the io tree and create an extent map fo=
r
> +	 *    an allocated extent. So we might just have been called after
> +	 *    delalloc is flushed and before the ordered extent completes and
> +	 *    inserts the new file extent item in the subvolume's btree;
> +	 *
> +	 * 2) We may have an extent map created by flushing delalloc for a
> +	 *    subrange that starts before the subrange we found marked with
> +	 *    EXTENT_DELALLOC in the io tree.
> +	 */
> +	read_lock(&em_tree->lock);
> +	em =3D lookup_extent_mapping(em_tree, start, len);
> +	read_unlock(&em_tree->lock);
> +
> +	/* extent_map_end() returns a non-inclusive end offset. */
> +	em_end =3D em ? extent_map_end(em) : 0;
> +
> +	/*
> +	 * If we have a hole/prealloc extent map, check the next one if this o=
ne
> +	 * ends before our range's end.
> +	 */
> +	if (em && (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> +		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) && em_end < end) {
> +		struct extent_map *next_em;
> +
> +		read_lock(&em_tree->lock);
> +		next_em =3D lookup_extent_mapping(em_tree, em_end, len - em_end);
> +		read_unlock(&em_tree->lock);
> +
> +		free_extent_map(em);
> +		em_end =3D next_em ? extent_map_end(next_em) : 0;
> +		em =3D next_em;
> +	}
> +
> +	if (em && (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> +		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
> +		free_extent_map(em);
> +		em =3D NULL;
> +	}
> +
> +	/*
> +	 * No extent map or one for a hole or prealloc extent. Use the delallo=
c
> +	 * range we found in the io tree if we have one.
> +	 */
> +	if (!em)
> +		return (delalloc_len > 0);
> +
> +	/*
> +	 * We don't have any range as EXTENT_DELALLOC in the io tree, so the
> +	 * extent map is the only subrange representing delalloc.
> +	 */
> +	if (delalloc_len =3D=3D 0) {
> +		*delalloc_start_ret =3D em->start;
> +		*delalloc_end_ret =3D min(end, em_end - 1);
> +		free_extent_map(em);
> +		return true;
> +	}
> +
> +	/*
> +	 * The extent map represents a delalloc range that starts before the
> +	 * delalloc range we found in the io tree.
> +	 */
> +	if (em->start < *delalloc_start_ret) {
> +		*delalloc_start_ret =3D em->start;
> +		/*
> +		 * If the ranges are adjacent, return a combined range.
> +		 * Otherwise return the extent map's range.
> +		 */
> +		if (em_end < *delalloc_start_ret)
> +			*delalloc_end_ret =3D min(end, em_end - 1);
> +
> +		free_extent_map(em);
> +		return true;
> +	}
> +
> +	/*
> +	 * The extent map starts after the delalloc range we found in the io
> +	 * tree. If it's adjacent, return a combined range, otherwise return
> +	 * the range found in the io tree.
> +	 */
> +	if (*delalloc_end_ret + 1 =3D=3D em->start)
> +		*delalloc_end_ret =3D min(end, em_end - 1);
> +
> +	free_extent_map(em);
> +	return true;
> +}
> +
> +/*
> + * Check if there's delalloc in a given range.
> + *
> + * @inode:               The inode.
> + * @start:               The start offset of the range. It does not nee=
d to be
> + *                       sector size aligned.
> + * @end:                 The end offset (inclusive value) of the search=
 range.
> + *                       It does not need to be sector size aligned.
> + * @delalloc_start_ret:  Output argument, set to the start offset of th=
e
> + *                       subrange found with delalloc (may not be secto=
r size
> + *                       aligned).
> + * @delalloc_end_ret:    Output argument, set to he end offset (inclusi=
ve value)
> + *                       of the subrange found with delalloc.
> + *
> + * Returns true if a subrange with delalloc is found within the given r=
ange, and
> + * if so it sets @delalloc_start_ret and @delalloc_end_ret with the sta=
rt and
> + * end offsets of the subrange.
> + */
> +static bool have_delalloc_in_range(struct btrfs_inode *inode, u64 start=
, u64 end,
> +				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> +{
> +	u64 cur_offset =3D round_down(start, inode->root->fs_info->sectorsize)=
;
> +	u64 prev_delalloc_end =3D 0;
> +	bool ret =3D false;
> +
> +	while (cur_offset < end) {
> +		u64 delalloc_start;
> +		u64 delalloc_end;
> +		bool delalloc;
> +
> +		delalloc =3D find_delalloc_subrange(inode, cur_offset, end,
> +						  &delalloc_start,
> +						  &delalloc_end);
> +		if (!delalloc)
> +			break;
> +
> +		if (prev_delalloc_end =3D=3D 0) {
> +			/* First subrange found. */
> +			*delalloc_start_ret =3D max(delalloc_start, start);
> +			*delalloc_end_ret =3D delalloc_end;
> +			ret =3D true;
> +		} else if (delalloc_start =3D=3D prev_delalloc_end + 1) {
> +			/* Subrange adjacent to the previous one, merge them. */
> +			*delalloc_end_ret =3D delalloc_end;
> +		} else {
> +			/* Subrange not adjacent to the previous one, exit. */
> +			break;
> +		}
> +
> +		prev_delalloc_end =3D delalloc_end;
> +		cur_offset =3D delalloc_end + 1;
> +		cond_resched();
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Check if there's a hole or delalloc range in a range representing a =
hole (or
> + * prealloc extent) found in the inode's subvolume btree.
> + *
> + * @inode:      The inode.
> + * @whence:     Seek mode (SEEK_DATA or SEEK_HOLE).
> + * @start:      Start offset of the hole region. It does not need to be=
 sector
> + *              size aligned.
> + * @end:        End offset (inclusive value) of the hole region. It doe=
s not
> + *              need to be sector size aligned.
> + * @start_ret:  Return parameter, used to set the start of the subrange=
 in the
> + *              hole that matches the search criteria (seek mode), if s=
uch
> + *              subrange is found (return value of the function is true=
).
> + *              The value returned here may not be sector size aligned.
> + *
> + * Returns true if a subrange matching the given seek mode is found, an=
d if one
> + * is found, it updates @start_ret with the start of the subrange.
> + */
> +static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int =
whence,
> +					u64 start, u64 end, u64 *start_ret)
> +{
> +	u64 delalloc_start;
> +	u64 delalloc_end;
> +	bool delalloc;
> +
> +	delalloc =3D have_delalloc_in_range(inode, start, end, &delalloc_start=
,
> +					  &delalloc_end);
> +	if (delalloc && whence =3D=3D SEEK_DATA) {
> +		*start_ret =3D delalloc_start;
> +		return true;
> +	}
> +
> +	if (delalloc && whence =3D=3D SEEK_HOLE) {
> +		/*
> +		 * We found delalloc but it starts after out start offset. So we
> +		 * have a hole between our start offset and the delalloc start.
> +		 */
> +		if (start < delalloc_start) {
> +			*start_ret =3D start;
> +			return true;
> +		}
> +		/*
> +		 * Delalloc range starts at our start offset.
> +		 * If the delalloc range's length is smaller than our range,
> +		 * then it means we have a hole that starts where the delalloc
> +		 * subrange ends.
> +		 */
> +		if (delalloc_end < end) {
> +			*start_ret =3D delalloc_end + 1;
> +			return true;
> +		}
> +
> +		/* There's delalloc for the whole range. */
> +		return false;
> +	}
> +
> +	if (!delalloc && whence =3D=3D SEEK_HOLE) {
> +		*start_ret =3D start;
> +		return true;
> +	}
> +
> +	/*
> +	 * No delalloc in the range and we are seeking for data. The caller ha=
s
> +	 * to iterate to the next extent item in the subvolume btree.
> +	 */
> +	return false;
> +}
> +
>   static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t of=
fset,
>   				  int whence)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	struct extent_map *em =3D NULL;
>   	struct extent_state *cached_state =3D NULL;
> -	loff_t i_size =3D inode->vfs_inode.i_size;
> +	const loff_t i_size =3D i_size_read(&inode->vfs_inode);
> +	const u64 ino =3D btrfs_ino(inode);
> +	struct btrfs_root *root =3D inode->root;
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	u64 last_extent_end;
>   	u64 lockstart;
>   	u64 lockend;
>   	u64 start;
> -	u64 len;
> -	int ret =3D 0;
> +	int ret;
> +	bool found =3D false;
>
>   	if (i_size =3D=3D 0 || offset >=3D i_size)
>   		return -ENXIO;
>
> +	/*
> +	 * Quick path. If the inode has no prealloc extents and its number of
> +	 * bytes used matches its i_size, then it can not have holes.
> +	 */
> +	if (whence =3D=3D SEEK_HOLE &&
> +	    !(inode->flags & BTRFS_INODE_PREALLOC) &&
> +	    inode_get_bytes(&inode->vfs_inode) =3D=3D i_size)
> +		return i_size;
> +
>   	/*
>   	 * offset can be negative, in this case we start finding DATA/HOLE fr=
om
>   	 * the very start of the file.
> @@ -3628,49 +3887,165 @@ static loff_t find_desired_extent(struct btrfs_=
inode *inode, loff_t offset,
>   	if (lockend <=3D lockstart)
>   		lockend =3D lockstart + fs_info->sectorsize;
>   	lockend--;
> -	len =3D lockend - lockstart + 1;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +	path->reada =3D READA_FORWARD;
> +
> +	key.objectid =3D ino;
> +	key.type =3D BTRFS_EXTENT_DATA_KEY;
> +	key.offset =3D start;
> +
> +	last_extent_end =3D lockstart;
>
>   	lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
>
> +	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	if (ret < 0) {
> +		goto out;
> +	} else if (ret > 0 && path->slots[0] > 0) {
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
> +		if (key.objectid =3D=3D ino && key.type =3D=3D BTRFS_EXTENT_DATA_KEY)
> +			path->slots[0]--;
> +	}
> +
>   	while (start < i_size) {
> -		em =3D btrfs_get_extent_fiemap(inode, start, len);
> -		if (IS_ERR(em)) {
> -			ret =3D PTR_ERR(em);
> -			em =3D NULL;
> -			break;
> +		struct extent_buffer *leaf =3D path->nodes[0];
> +		struct btrfs_file_extent_item *extent;
> +		u64 extent_end;
> +
> +		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> +			ret =3D btrfs_next_leaf(root, path);
> +			if (ret < 0)
> +				goto out;
> +			else if (ret > 0)
> +				break;
> +
> +			leaf =3D path->nodes[0];
>   		}
>
> -		if (whence =3D=3D SEEK_HOLE &&
> -		    (em->block_start =3D=3D EXTENT_MAP_HOLE ||
> -		     test_bit(EXTENT_FLAG_PREALLOC, &em->flags)))
> -			break;
> -		else if (whence =3D=3D SEEK_DATA &&
> -			   (em->block_start !=3D EXTENT_MAP_HOLE &&
> -			    !test_bit(EXTENT_FLAG_PREALLOC, &em->flags)))
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +		if (key.objectid !=3D ino || key.type !=3D BTRFS_EXTENT_DATA_KEY)
>   			break;
>
> -		start =3D em->start + em->len;
> -		free_extent_map(em);
> -		em =3D NULL;
> +		extent_end =3D btrfs_file_extent_end(path);
> +
> +		/*
> +		 * In the first iteration we may have a slot that points to an
> +		 * extent that ends before our start offset, so skip it.
> +		 */
> +		if (extent_end <=3D start) {
> +			path->slots[0]++;
> +			continue;
> +		}
> +
> +		/* We have an implicit hole, NO_HOLES feature is likely set. */
> +		if (last_extent_end < key.offset) {
> +			u64 search_start =3D last_extent_end;
> +			u64 found_start;
> +
> +			/*
> +			 * First iteration, @start matches @offset and it's
> +			 * within the hole.
> +			 */
> +			if (start =3D=3D offset)
> +				search_start =3D offset;
> +
> +			found =3D find_desired_extent_in_hole(inode, whence,
> +							    search_start,
> +							    key.offset - 1,
> +							    &found_start);
> +			if (found) {
> +				start =3D found_start;
> +				break;
> +			}
> +			/*
> +			 * Didn't find data or a hole (due to delalloc) in the
> +			 * implicit hole range, so need to analyze the extent.
> +			 */
> +		}
> +
> +		extent =3D btrfs_item_ptr(leaf, path->slots[0],
> +					struct btrfs_file_extent_item);
> +
> +		if (btrfs_file_extent_disk_bytenr(leaf, extent) =3D=3D 0 ||
> +		    btrfs_file_extent_type(leaf, extent) =3D=3D
> +		    BTRFS_FILE_EXTENT_PREALLOC) {
> +			/*
> +			 * Explicit hole or prealloc extent, search for delalloc.
> +			 * A prealloc extent is treated like a hole.
> +			 */
> +			u64 search_start =3D key.offset;
> +			u64 found_start;
> +
> +			/*
> +			 * First iteration, @start matches @offset and it's
> +			 * within the hole.
> +			 */
> +			if (start =3D=3D offset)
> +				search_start =3D offset;
> +
> +			found =3D find_desired_extent_in_hole(inode, whence,
> +							    search_start,
> +							    extent_end - 1,
> +							    &found_start);
> +			if (found) {
> +				start =3D found_start;
> +				break;
> +			}
> +			/*
> +			 * Didn't find data or a hole (due to delalloc) in the
> +			 * implicit hole range, so need to analyze the next
> +			 * extent item.
> +			 */
> +		} else {
> +			/*
> +			 * Found a regular or inline extent.
> +			 * If we are seeking for data, adjust the start offset
> +			 * and stop, we're done.
> +			 */
> +			if (whence =3D=3D SEEK_DATA) {
> +				start =3D max_t(u64, key.offset, offset);
> +				found =3D true;
> +				break;
> +			}
> +			/*
> +			 * Else, we are seeking for a hole, check the next file
> +			 * extent item.
> +			 */
> +		}
> +
> +		start =3D extent_end;
> +		last_extent_end =3D extent_end;
> +		path->slots[0]++;
>   		if (fatal_signal_pending(current)) {
>   			ret =3D -EINTR;
> -			break;
> +			goto out;
>   		}
>   		cond_resched();
>   	}
> -	free_extent_map(em);
> +
> +	/* We have an implicit hole from the last extent found up to i_size. *=
/
> +	if (!found && start < i_size) {
> +		found =3D find_desired_extent_in_hole(inode, whence, start,
> +						    i_size - 1, &start);
> +		if (!found)
> +			start =3D i_size;
> +	}
> +
> +out:
>   	unlock_extent_cached(&inode->io_tree, lockstart, lockend,
>   			     &cached_state);
> -	if (ret) {
> -		offset =3D ret;
> -	} else {
> -		if (whence =3D=3D SEEK_DATA && start >=3D i_size)
> -			offset =3D -ENXIO;
> -		else
> -			offset =3D min_t(loff_t, start, i_size);
> -	}
> +	btrfs_free_path(path);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (whence =3D=3D SEEK_DATA && start >=3D i_size)
> +		return -ENXIO;
>
> -	return offset;
> +	return min_t(loff_t, start, i_size);
>   }
>
>   static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int =
whence)
