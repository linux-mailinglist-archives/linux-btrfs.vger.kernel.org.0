Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38D65AA379
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiIAXB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 19:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiIAXBY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 19:01:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F131203
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662073275;
        bh=8kws6XMsafHByQq1zK0w5MkBshs310oObgMSYcSk67M=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=MJ3XVw/sY0DlI+NfvS/KXghAiQcL9YVXeSITGJ3MWTOKjepAyLpbGGGMTN77iKGkc
         T8mXtdY56YEnLFJvFf4AXFs2Q4wse1u45EpS8NLTP0p54VhEsCZ0jLyZvg7xwpDpZu
         NwWkNyxEKmkw19DfFtagFGYc+sgSAMc1d3wj9tes=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1oTtBS2KiO-0001pK; Fri, 02
 Sep 2022 01:01:15 +0200
Message-ID: <97ffaadc-4b8f-96bb-6ed4-6857c13919c2@gmx.com>
Date:   Fri, 2 Sep 2022 07:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <d80f75e12d0212da59cbcccac2eddd506c8998af.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 09/10] btrfs: skip unnecessary extent buffer sharedness
 checks during fiemap
In-Reply-To: <d80f75e12d0212da59cbcccac2eddd506c8998af.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mrWt4LEehQAZGGGTdewDpE0n+y6IrpFQDmCh5UiBAaJMupQ6z5r
 UtlvgR0w4SrintQcNFsNjc0TGW00/1BIpCXk8ry2vKWZXlATKCitvn3Qd+9p21hL1wbnC7/
 LIu2jaOf1SCF8+a2njJ0UdyFWNcO8ww8idi/T507y+QstA9/8MQbsgeqpXNSUuLlqUearut
 amS5OkccNXsmOTPqsAJGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T/tc6DZQrAM=:Er21F2tpr3ZQztT35UoO5n
 vzwJohxAKHrC/Yp6PKIHLNpajjS8qyfIaIMChxARwcWE/D+D01J+9VBNXOGElrrCRspa83IiQ
 HeAW80VE8Q33XoFteRXqHoZGefWbaa1wIrBY94rTNTnarhOOwj1G8BFYz0lmhdleENwhg2oky
 IQY1ohosqQk1HsW9cQ2JjhtWclgfmQReFtWXMinky17J07wJxYy4QEXF1De4M+2hiihKY7AfL
 A3Lnna6vnClf6iPM+f0mbcE1VfjpMXUn8iaM91vEVjnYQRgCOgBwUYuyEGD5dcgUOgDVQkBkM
 weGL+ug8KcPemttzUuVz/j5sMs/I1mp5ibQqfW4p8vP3llVpVvvpU8Vznbv9EYo9kTKH+rRzT
 PiD8pVFAE5/rkpPlAcD1yoIhZDOT2gyCn7+ZvLcLn4ZL8UjZX9e5AmRnZ+Uhb1dthgp8fMyMO
 3zJOxSemwfVK67PGAJrWVmWNJpwlRudkwPlrFDWlFSNXqla0An86trXtyqtcGEd7OUeWK82Yr
 HgMwdXv3pbLNCTRdc8xJzufoDpPZlRB4F0H8+OA8UWz4Wi+sgdxFTbznVcQoeZrLN99ZR13ld
 5C4v+M3p7ZP1pyrqIjNICb7vX4Yb3N35UOaiFTbp5H7iIIF4S1M1M8rHnBWJdCIj11etKg6IR
 kUWriSov18F0na8BwqSunPj8HQnEND9v0VVMHAQAOOdKBaJqSI41RKc60KLiGA3xMHq3jv7M5
 FSmRIdXnq5vBn49wvRSt2bCCoBQoL1nSCjG0QnMhilQ+sS9NO3IxWYL5DulQiv2X+rVFSMT59
 9CLZ1nABw2811wV/t09QfkbjxKbtgxaTlAhWkL38+/YamuKPnxyqE+bltpen9zSuX3Fx+G+q+
 sNrgPGJV8H6FUXmKr/IgSDrnvHiae/8nxpD8byTUD2gS9YDG+CsfohNi4xUbI/PKHXTcXA7Kp
 HHilE/FU/e/Wv8ItLx83VkZ3w9L3oMouZ3jRD9+cxUOv7jmmkMvbQuiANkXNPoJZsHJ7c+UXu
 h/FoMb/aavAsTCH+Pd8cUCf+F+iZs3ngZw16f5B0DErdz0u5dC/kZ9CrvYAtQIlfSHVDEd/r/
 XPfJb/GMGJmDV4yE6uartKC4n4d7R4kyyYpGXXS7WxMFVKxqoVx9iHoC/95XXBQUm/a8FaVO1
 dfzXHJx7sJ1VP7Ju0SFR962qn5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
> During fiemap, for each file extent we find, we must check if it's share=
d
> or not. The sharedness check starts by verifying if the extent is direct=
ly
> shared (its refcount in the extent tree is > 1), and if it is not direct=
ly
> shared, then we will check if every node in the subvolume b+tree leading
> from the root to the leaf that has the file extent item (in reverse orde=
r),
> is shared (through snapshots).
>
> However this second step is not needed if our extent was created in a
> transaction more recent than the last transaction where a snapshot of th=
e
> inode's root happened, because it can't be shared indirectly (through
> shared subtrees) without a snapshot created in a more recent transaction=
.

This is a pretty awesome!

>
> So grab the generation of the extent from the extent map and pass it to
> btrfs_is_data_extent_shared(), which will skip this second phase when th=
e
> generation is more recent than the root's last snapshot value. Note that
> we skip this optimization if the extent map is the result of merging 2
> or more extent maps, because in this case its generation is the maximum
> of the generations of all merged extent maps.

And this pitfall also taken into consideration, even better.

>
> The fact the we use extent maps and they can be merged despite the
> underlying extents being distinct (different file extent items in the
> subvolume b+tree and different extent items in the extent b+tree), can
> result in some bugs when reporting shared extents. But this is a problem
> of the current implementation of fiemap relying on extent maps.
> One example where we get incorrect results is:
>
>      $ cat fiemap-bug.sh
>      #!/bin/bash
>
>      DEV=3D/dev/sdj
>      MNT=3D/mnt/sdj
>
>      mkfs.btrfs -f $DEV
>      mount $DEV $MNT
>
>      # Create a file with two 256K extents.
>      # Since there is no other write activity, they will be contiguous,
>      # and their extent maps merged, despite having two distinct extents=
.
>      xfs_io -f -c "pwrite -S 0xab 0 256K" \
>                -c "fsync" \
>                -c "pwrite -S 0xcd 256K 256K" \
>                -c "fsync" \
>                $MNT/foo
>
>      # Now clone only the second extent into another file.
>      xfs_io -f -c "reflink $MNT/foo 256K 0 256K" $MNT/bar
>
>      # Filefrag will report a single 512K extent, and say it's not share=
d.
>      echo
>      filefrag -v $MNT/foo
>
>      umount $MNT
>
> Running the reproducer:
>
>      $ ./fiemap-bug.sh
>      wrote 262144/262144 bytes at offset 0
>      256 KiB, 64 ops; 0.0038 sec (65.479 MiB/sec and 16762.7030 ops/sec)
>      wrote 262144/262144 bytes at offset 262144
>      256 KiB, 64 ops; 0.0040 sec (61.125 MiB/sec and 15647.9218 ops/sec)
>      linked 262144/262144 bytes at offset 0
>      256 KiB, 1 ops; 0.0002 sec (1.034 GiB/sec and 4237.2881 ops/sec)
>
>      Filesystem type is: 9123683e
>      File size of /mnt/sdj/foo is 524288 (128 blocks of 4096 bytes)
>       ext:     logical_offset:        physical_offset: length:   expecte=
d: flags:
>         0:        0..     127:       3328..      3455:    128:          =
   last,eof
>      /mnt/sdj/foo: 1 extent found
>
> We end up reporting that we have a single 512K that is not shared, howev=
er
> we have two 256K extents, and the second one is shared. Changing the
> reproducer to clone instead the first extent into file 'bar', makes us
> report a single 512K extent that is shared, which is algo incorrect sinc=
e
> we have two 256K extents and only the first one is shared.
>
> This is z problem that existed before this change, and remains after thi=
s
> change, as it can't be easily fixed. The next patch in the series rework=
s
> fiemap to primarily use file extent items instead of extent maps (except
> for checking for delalloc ranges), with the goal of improving its
> scalability and performance, but it also ends up fixing this particular
> bug caused by extent map merging.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.c   | 27 +++++++++++++++++++++------
>   fs/btrfs/backref.h   |  1 +
>   fs/btrfs/extent_io.c | 18 ++++++++++++++++--
>   3 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 40b48abb6978..bf4ca4a82550 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1613,12 +1613,14 @@ static void store_backref_shared_cache(struct bt=
rfs_backref_shared_cache *cache,
>   /**
>    * Check if a data extent is shared or not.
>    *
> - * @root:   root inode belongs to
> - * @inum:   inode number of the inode whose extent we are checking
> - * @bytenr: logical bytenr of the extent we are checking
> - * @roots:  list of roots this extent is shared among
> - * @tmp:    temporary list used for iteration
> - * @cache:  a backref lookup result cache
> + * @root:        The root the inode belongs to.
> + * @inum:        Number of the inode whose extent we are checking.
> + * @bytenr:      Logical bytenr of the extent we are checking.
> + * @extent_gen:  Generation of the extent (file extent item) or 0 if it=
 is
> + *               not known.
> + * @roots:       List of roots this extent is shared among.
> + * @tmp:         Temporary list used for iteration.
> + * @cache:       A backref lookup result cache.
>    *
>    * btrfs_is_data_extent_shared uses the backref walking code but will =
short
>    * circuit as soon as it finds a root or inode that doesn't match the
> @@ -1632,6 +1634,7 @@ static void store_backref_shared_cache(struct btrf=
s_backref_shared_cache *cache,
>    * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
>    */
>   int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64=
 bytenr,
> +				u64 extent_gen,
>   				struct ulist *roots, struct ulist *tmp,
>   				struct btrfs_backref_shared_cache *cache)
>   {
> @@ -1683,6 +1686,18 @@ int btrfs_is_data_extent_shared(struct btrfs_root=
 *root, u64 inum, u64 bytenr,
>   		if (ret < 0 && ret !=3D -ENOENT)
>   			break;
>   		ret =3D 0;
> +		/*
> +		 * If our data extent is not shared through reflinks and it was
> +		 * created in a generation after the last one used to create a
> +		 * snapshot of the inode's root, then it can not be shared
> +		 * indirectly through subtrees, as that can only happen with
> +		 * snapshots. In this case bail out, no need to check for the
> +		 * sharedness of extent buffers.
> +		 */
> +		if (level =3D=3D -1 &&
> +		    extent_gen > btrfs_root_last_snapshot(&root->root_item))
> +			break;
> +
>   		if (level >=3D 0)
>   			store_backref_shared_cache(cache, root, bytenr,
>   						   level, false);
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 797ba5371d55..7d18b5ac71dd 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -77,6 +77,7 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64=
 inode_objectid,
>   			  struct btrfs_inode_extref **ret_extref,
>   			  u64 *found_off);
>   int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64=
 bytenr,
> +				u64 extent_gen,
>   				struct ulist *roots, struct ulist *tmp,
>   				struct btrfs_backref_shared_cache *cache);
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 781436cc373c..0e3fa9b08aaf 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5645,9 +5645,23 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>   			flags |=3D (FIEMAP_EXTENT_DELALLOC |
>   				  FIEMAP_EXTENT_UNKNOWN);
>   		} else if (fieinfo->fi_extents_max) {
> +			u64 extent_gen;
>   			u64 bytenr =3D em->block_start -
>   				(em->start - em->orig_start);
>
> +			/*
> +			 * If two extent maps are merged, then their generation
> +			 * is set to the maximum between their generations.
> +			 * Otherwise its generation matches the one we have in
> +			 * corresponding file extent item. If we have a merged
> +			 * extent map, don't use its generation to speedup the
> +			 * sharedness check below.
> +			 */
> +			if (test_bit(EXTENT_FLAG_MERGED, &em->flags))
> +				extent_gen =3D 0;
> +			else
> +				extent_gen =3D em->generation;
> +
>   			/*
>   			 * As btrfs supports shared space, this information
>   			 * can be exported to userspace tools via
> @@ -5656,8 +5670,8 @@ int extent_fiemap(struct btrfs_inode *inode, struc=
t fiemap_extent_info *fieinfo,
>   			 * lookup stuff.
>   			 */
>   			ret =3D btrfs_is_data_extent_shared(root, btrfs_ino(inode),
> -							  bytenr, roots,
> -							  tmp_ulist,
> +							  bytenr, extent_gen,
> +							  roots, tmp_ulist,
>   							  backref_cache);
>   			if (ret < 0)
>   				goto out_free;
