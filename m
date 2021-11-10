Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC944BF09
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhKJKvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 05:51:00 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53096 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhKJKu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 05:50:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UvutiRx_1636541289;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UvutiRx_1636541289)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Nov 2021 18:48:10 +0800
Date:   Wed, 10 Nov 2021 18:48:09 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
Message-ID: <20211110104809.GV60846@e18g06458.et15sqa>
References: <20211110093417.47185-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110093417.47185-1-wqu@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 05:34:17PM +0800, Qu Wenruo wrote:
> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> v2 cache by default.
> 
> However nospace_cache mount option will not work with v2 cache, as it
> would make v2 cache out of sync with on-disk used space.
> 
> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> to reject the mount.
> 
> There are quite some test cases relying on nospace_cache to prevent v1
> cache to take up data space.
> 
> For those test cases, we no longer need the "nospace_cache" mount option
> if the filesystem is already using v2 cache.
> Since v2 cache is using metadata space, it will no longer take up data
> space, thus no extra mount options for those test cases.
> 
> By this, we can keep those existing tests to run without problem for
> both v1 and v2 cache.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add _scratch_no_v1_cache_opt() function
> v3:
> - Add _require_btrfs_command for _scratch_no_v1_cache_opt()
> ---
>  common/btrfs    | 11 +++++++++++
>  tests/btrfs/102 |  2 +-
>  tests/btrfs/140 |  5 ++---
>  tests/btrfs/141 |  5 ++---
>  tests/btrfs/142 |  5 ++---
>  tests/btrfs/143 |  5 ++---
>  tests/btrfs/151 |  4 ++--
>  tests/btrfs/157 |  7 +++----
>  tests/btrfs/158 |  7 +++----
>  tests/btrfs/170 |  4 ++--
>  tests/btrfs/199 |  4 ++--
>  tests/btrfs/215 |  2 +-
>  12 files changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac880bdd..e21c452c 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -445,3 +445,14 @@ _scratch_btrfs_is_zoned()
>  	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
>  	return 1
>  }
> +
> +_scratch_no_v1_cache_opt()

This name indicates it's a general helper, but it's btrfs-specific, how
about _scratch_btrfs_no_v1_cache_opt ?

> +{
> +	_require_btrfs_command inspect-internal dump-tree

This will call _notrun if btrfs command doesn't have inspect-internal
dump-tree sub-command, and _notrun will call exit, but ...

> +
> +	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
> +	   grep -q "FREE_SPACE_TREE"; then
> +		return
> +	fi
> +	echo -n "-onospace_cache"
> +}
> diff --git a/tests/btrfs/102 b/tests/btrfs/102
> index e5a1b068..c1678b5d 100755
> --- a/tests/btrfs/102
> +++ b/tests/btrfs/102
> @@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
>  # Mount our filesystem without space caches enabled so that we do not get any
>  # space used from the initial data block group that mkfs creates (space caches
>  # used space from data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount $(_scratch_no_v1_cache_opt)

_scratch_no_v1_cache_opt is called in a sub-shell, so the _notrun will
just exit the sub-shell, not the test itself. Should call the _require
rule in test.

Thanks,
Eryu

>  
>  # Need an fs with at least 2Gb to make sure mkfs.btrfs does not create an fs
>  # using mixed block groups (used both for data and metadata). We really need
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 5a5f828c..77d1cab9 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -60,9 +60,8 @@ echo "step 1......mkfs.btrfs" >>$seqres.full
>  mkfs_opts="-d raid1 -b 1G"
>  _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>  
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# makes sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>  	_filter_xfs_io_offset
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index cf0979e9..9bde0977 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -59,9 +59,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>  mkfs_opts="-d raid1 -b 1G"
>  _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>  
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>  	_filter_xfs_io_offset
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index 1318be0f..ffe298d6 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -37,9 +37,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>  mkfs_opts="-d raid1 -b 1G"
>  _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>  
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>  
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>  	_filter_xfs_io_offset
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 6736dcad..1f55cded 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -44,9 +44,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>  mkfs_opts="-d raid1 -b 1G"
>  _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>  
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>  
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>  	_filter_xfs_io_offset
> diff --git a/tests/btrfs/151 b/tests/btrfs/151
> index 099e85cc..b343271f 100755
> --- a/tests/btrfs/151
> +++ b/tests/btrfs/151
> @@ -31,8 +31,8 @@ _scratch_dev_pool_get 3
>  # create raid1 for data
>  _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
>  
> -# we need an empty data chunk, so nospace_cache is required.
> -_scratch_mount -onospace_cache
> +# we need an empty data chunk, so need to disable v1 cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  # if data chunk is empty, 'btrfs device remove' can change raid1 to
>  # single.
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 0cfe3ce5..e779e33a 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -64,9 +64,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>  mkfs_opts="-d raid6 -b 1G"
>  _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>  
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> @@ -94,7 +93,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>  
>  # step 3: read foobar to repair the bitrot
>  echo "step 3......repair the bitrot" >> $seqres.full
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  # read the 2nd stripe, i.e. [64K, 128K), to trigger repair
>  od -x -j 64K $SCRATCH_MNT/foobar
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index ad374eba..52d67001 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -56,9 +56,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>  mkfs_opts="-d raid6 -b 1G"
>  _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>  
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>  $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> @@ -85,7 +84,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>  
>  # step 3: scrub filesystem to repair the bitrot
>  echo "step 3......repair the bitrot" >> $seqres.full
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
>  
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> index 15382eb3..3efe085d 100755
> --- a/tests/btrfs/170
> +++ b/tests/btrfs/170
> @@ -27,9 +27,9 @@ _require_xfs_io_command "falloc" "-k"
>  fs_size=$((2 * 1024 * 1024 * 1024)) # 2Gb
>  _scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
>  
> -# Mount without space cache so that we can precisely fill all data space and
> +# Mount without v1 cache so that we can precisely fill all data space and
>  # unallocated space later (space cache v1 uses data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  # Create our test file and allocate 1826.25Mb of space for it.
>  # This will exhaust the existing data block group and all unallocated space on
> diff --git a/tests/btrfs/199 b/tests/btrfs/199
> index 6aca62f4..7fa678e7 100755
> --- a/tests/btrfs/199
> +++ b/tests/btrfs/199
> @@ -67,7 +67,7 @@ loop_dev=$(_create_loop_device "$loop_file")
>  loop_mnt=$tmp/loop_mnt
>  
>  mkdir -p $loop_mnt
> -# - nospace_cache
> +# - _scratch_no_v1_cache_opt
>  #   Since v1 cache using DATA space, it can break data extent bytenr
>  #   continuousness.
>  # - nodatasum
> @@ -75,7 +75,7 @@ mkdir -p $loop_mnt
>  #   Disabling datasum could reduce the margin caused by metadata to minimal
>  # - discard
>  #   What we're testing
> -_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
> +_mount -o nodatasum,discard $(_scratch_no_v1_cache_opt) $loop_dev $loop_mnt
>  
>  # Craft the following extent layout:
>  #         |  BG1 |      BG2        |       BG3            |
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index fa622568..d62b2ff6 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -30,7 +30,7 @@ _require_non_zoned_device $SCRATCH_DEV
>  _scratch_mkfs > /dev/null
>  # disable freespace inode to ensure file is the first thing in the data
>  # blobk group
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>  
>  pagesize=$(get_page_size)
>  blocksize=$(_get_block_size $SCRATCH_MNT)
> -- 
> 2.33.0
