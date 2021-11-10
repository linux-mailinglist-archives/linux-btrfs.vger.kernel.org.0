Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FFE44BF18
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 11:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhKJKzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 05:55:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:56851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhKJKzP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 05:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636541542;
        bh=y9NRbhZfiB+7oZw2kUHtX53owi6ZZtl1oCxXT6wnHNE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=X9QQiTYZCir9E7aAvuWxwt0eM3KwkDkIgIhbi2vMAai2s20IGrHFZ8//l6uJTi84e
         NVMpGHqTsNdcTP7WUxW/uKLV1FCNAScxdv83nP3BKRLGwkvPnCfEI0Z775cAQ2vmxy
         WbYFqTjYeLeqjHGmZInAik5R/q3XU6QE9S1s3MLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsUC-1mtWdh0hd2-008ugC; Wed, 10
 Nov 2021 11:52:21 +0100
Message-ID: <e33a7317-d740-b698-61bf-4882bea4a70b@gmx.com>
Date:   Wed, 10 Nov 2021 18:52:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
Content-Language: en-US
To:     Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20211110093417.47185-1-wqu@suse.com>
 <20211110104809.GV60846@e18g06458.et15sqa>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211110104809.GV60846@e18g06458.et15sqa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SUXbLM9wFEx6DCXfQ7TfSwje+kJjH3s6f4DlP5K0uCVBvuUuq2f
 YGX9wsmOJaUnHQd8vt5U+fNTfQf1ePrSTfIvdvZe61vhlKJ6G0X4KZqK0+8NK9VBKMofvVi
 sUlGiNMtcKmYPOcswZ/FIbqIP32vnaL7f/zdWLK0e4r3koDc2tEE6a2o+3bDW2tZ7PBLjje
 WdsGupMLFN4q/j5xFfbfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQRCAoFpAQE=:nt5q5KBbuS05MWFsk0XBwv
 gkotLQmvB3MwTpOlJh/5QL76K0JFNv9LnWEQQrFDRaCGuQo5waRiDPfk1RsX75i7syhyNWe1t
 X3bMP+O343N4cwOiwuALJf2LRkEl+uA8ezRqbIC7YNqSb8yTcayjWn/f6XARaaxasLQvZoeoY
 dP66h08L+WzpGCYnDSCggm7/QYbthwV2V+khJZe06USISMKiun1z1yP+rvqe1jN/seSMDo5Fj
 IcFr4Lx0G36WGsEjKw6CYW51feuq0SjplJ51AImX3DGxedpQ51MAumn/6gf/jpxuMdT/7VsJm
 3ZVvZhnaHSFjpWldGDsFVA0lSVecPBWLlv4mtnizLPs5j0F9Pc88Vhz+/4MTzaPab7CjpTBtV
 AkVEs7pVO9IsgGwXMY3L391ViYo+21x3yNZyBxfi+lspqP2Mt6F+8H1ZVv2mtiohODd4w42BG
 08gdYzg+3mU8VanAv+faEBx0vKfHNGlE0LsJbmpK00j9uXYXm4AquO8l/AR3qSBnEp62lq+Qx
 zRD47paVqVWxN3QO1xVDU9eBzgnlD+ucQQK7wqxZtMDScg9JhNLklmUlWsaMxYdg+OXOIQaiu
 ibLwYHT18qNEpt41poSseWumTVfVOVxRhNP/gI7BQJfv5bO3T+JF0BUemNyv6Tq9p6giO1rJG
 rK+LdfOJPvMYK1OGYrh/xowmY9V0ydd3VvrBhPptCc6WE8IdZ+kowoADfR5KCHNgS6ozCxzLN
 kzcnK5ha+Cu1oX8+SRfGG1+/MsIfjT52FtXlTC6+KXufCodNdjWtuehPnnFXygjj/LUc+98SD
 zOImJmrVOvcX6I92l3yz7IWdeJE6Y29ur23zBrckGj2V5tlnHYcRnTpXA0jeqyxZs2Nm8p4pE
 2Xd1/KgOYjxa7Dopy6DC/VNAodxF/z2ymy1fLdp0fB4lEQGYEDMzzychRKi2hMX1qfnQr+nma
 GvTc9t4rHSy/GkY2FXOccPZFOH8M/aEFLE0/v51wIK7EgKOleobNW6X6x1ZgdHEZAho3yYlQ9
 25GcM74KepGw8GASurO14fC18VrtFiF4kAccvvUgXI4IMLSudUkvzPs+bJSvgYbyKsyzSGmDh
 osCiSA2Sh/GtFw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 18:48, Eryu Guan wrote:
> On Wed, Nov 10, 2021 at 05:34:17PM +0800, Qu Wenruo wrote:
>> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
>> v2 cache by default.
>>
>> However nospace_cache mount option will not work with v2 cache, as it
>> would make v2 cache out of sync with on-disk used space.
>>
>> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
>> to reject the mount.
>>
>> There are quite some test cases relying on nospace_cache to prevent v1
>> cache to take up data space.
>>
>> For those test cases, we no longer need the "nospace_cache" mount optio=
n
>> if the filesystem is already using v2 cache.
>> Since v2 cache is using metadata space, it will no longer take up data
>> space, thus no extra mount options for those test cases.
>>
>> By this, we can keep those existing tests to run without problem for
>> both v1 and v2 cache.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add _scratch_no_v1_cache_opt() function
>> v3:
>> - Add _require_btrfs_command for _scratch_no_v1_cache_opt()
>> ---
>>   common/btrfs    | 11 +++++++++++
>>   tests/btrfs/102 |  2 +-
>>   tests/btrfs/140 |  5 ++---
>>   tests/btrfs/141 |  5 ++---
>>   tests/btrfs/142 |  5 ++---
>>   tests/btrfs/143 |  5 ++---
>>   tests/btrfs/151 |  4 ++--
>>   tests/btrfs/157 |  7 +++----
>>   tests/btrfs/158 |  7 +++----
>>   tests/btrfs/170 |  4 ++--
>>   tests/btrfs/199 |  4 ++--
>>   tests/btrfs/215 |  2 +-
>>   12 files changed, 33 insertions(+), 28 deletions(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index ac880bdd..e21c452c 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -445,3 +445,14 @@ _scratch_btrfs_is_zoned()
>>   	[ `_zone_type ${SCRATCH_DEV}` !=3D "none" ] && return 0
>>   	return 1
>>   }
>> +
>> +_scratch_no_v1_cache_opt()
>
> This name indicates it's a general helper, but it's btrfs-specific, how
> about _scratch_btrfs_no_v1_cache_opt ?
>
>> +{
>> +	_require_btrfs_command inspect-internal dump-tree
>
> This will call _notrun if btrfs command doesn't have inspect-internal
> dump-tree sub-command, and _notrun will call exit, but ...
>
>> +
>> +	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
>> +	   grep -q "FREE_SPACE_TREE"; then
>> +		return
>> +	fi
>> +	echo -n "-onospace_cache"
>> +}
>> diff --git a/tests/btrfs/102 b/tests/btrfs/102
>> index e5a1b068..c1678b5d 100755
>> --- a/tests/btrfs/102
>> +++ b/tests/btrfs/102
>> @@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
>>   # Mount our filesystem without space caches enabled so that we do not=
 get any
>>   # space used from the initial data block group that mkfs creates (spa=
ce caches
>>   # used space from data block groups).
>> -_scratch_mount "-o nospace_cache"
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>
> _scratch_no_v1_cache_opt is called in a sub-shell, so the _notrun will
> just exit the sub-shell, not the test itself. Should call the _require
> rule in test.

That means we will have a hard dependency on binding
_scratch_btrfs_no_v1_cache_opt() with _require rule then.

Then a sudden "_require_btrfs_command inspect-internal dump-tree"
without context could be sometimes confusing AFAIK.

Considering "inspect-internal" should be in btrfs-progs for a very long
time, any non-EOF distro should have them already, can we just remove
the _require rule?

Thanks,
Qu

>
> Thanks,
> Eryu
>
>>
>>   # Need an fs with at least 2Gb to make sure mkfs.btrfs does not creat=
e an fs
>>   # using mixed block groups (used both for data and metadata). We real=
ly need
>> diff --git a/tests/btrfs/140 b/tests/btrfs/140
>> index 5a5f828c..77d1cab9 100755
>> --- a/tests/btrfs/140
>> +++ b/tests/btrfs/140
>> @@ -60,9 +60,8 @@ echo "step 1......mkfs.btrfs" >>$seqres.full
>>   mkfs_opts=3D"-d raid1 -b 1G"
>>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>
>> -# -o nospace_cache makes sure data is written to the start position of=
 the data
>> -# chunk
>> -_scratch_mount -o nospace_cache
>> +# makes sure data is written to the start position of the data chunk
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/f=
oobar" |\
>>   	_filter_xfs_io_offset
>> diff --git a/tests/btrfs/141 b/tests/btrfs/141
>> index cf0979e9..9bde0977 100755
>> --- a/tests/btrfs/141
>> +++ b/tests/btrfs/141
>> @@ -59,9 +59,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>>   mkfs_opts=3D"-d raid1 -b 1G"
>>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>
>> -# -o nospace_cache makes sure data is written to the start position of=
 the data
>> -# chunk
>> -_scratch_mount -o nospace_cache
>> +# make sure data is written to the start position of the data chunk
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/f=
oobar" |\
>>   	_filter_xfs_io_offset
>> diff --git a/tests/btrfs/142 b/tests/btrfs/142
>> index 1318be0f..ffe298d6 100755
>> --- a/tests/btrfs/142
>> +++ b/tests/btrfs/142
>> @@ -37,9 +37,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>>   mkfs_opts=3D"-d raid1 -b 1G"
>>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>
>> -# -o nospace_cache makes sure data is written to the start position of=
 the data
>> -# chunk
>> -_scratch_mount -o nospace_cache,nodatasum
>> +# make sure data is written to the start position of the data chunk
>> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>>
>>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/f=
oobar" |\
>>   	_filter_xfs_io_offset
>> diff --git a/tests/btrfs/143 b/tests/btrfs/143
>> index 6736dcad..1f55cded 100755
>> --- a/tests/btrfs/143
>> +++ b/tests/btrfs/143
>> @@ -44,9 +44,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>>   mkfs_opts=3D"-d raid1 -b 1G"
>>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>
>> -# -o nospace_cache makes sure data is written to the start position of=
 the data
>> -# chunk
>> -_scratch_mount -o nospace_cache,nodatasum
>> +# make sure data is written to the start position of the data chunk
>> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>>
>>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/f=
oobar" |\
>>   	_filter_xfs_io_offset
>> diff --git a/tests/btrfs/151 b/tests/btrfs/151
>> index 099e85cc..b343271f 100755
>> --- a/tests/btrfs/151
>> +++ b/tests/btrfs/151
>> @@ -31,8 +31,8 @@ _scratch_dev_pool_get 3
>>   # create raid1 for data
>>   _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
>>
>> -# we need an empty data chunk, so nospace_cache is required.
>> -_scratch_mount -onospace_cache
>> +# we need an empty data chunk, so need to disable v1 cache
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   # if data chunk is empty, 'btrfs device remove' can change raid1 to
>>   # single.
>> diff --git a/tests/btrfs/157 b/tests/btrfs/157
>> index 0cfe3ce5..e779e33a 100755
>> --- a/tests/btrfs/157
>> +++ b/tests/btrfs/157
>> @@ -64,9 +64,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>>   mkfs_opts=3D"-d raid6 -b 1G"
>>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>
>> -# -o nospace_cache makes sure data is written to the start position of=
 the data
>> -# chunk
>> -_scratch_mount -o nospace_cache
>> +# make sure data is written to the start position of the data chunk
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe=
 1
>>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
>> @@ -94,7 +93,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $dev=
path1 > /dev/null
>>
>>   # step 3: read foobar to repair the bitrot
>>   echo "step 3......repair the bitrot" >> $seqres.full
>> -_scratch_mount -o nospace_cache
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   # read the 2nd stripe, i.e. [64K, 128K), to trigger repair
>>   od -x -j 64K $SCRATCH_MNT/foobar
>> diff --git a/tests/btrfs/158 b/tests/btrfs/158
>> index ad374eba..52d67001 100755
>> --- a/tests/btrfs/158
>> +++ b/tests/btrfs/158
>> @@ -56,9 +56,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>>   mkfs_opts=3D"-d raid6 -b 1G"
>>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>
>> -# -o nospace_cache makes sure data is written to the start position of=
 the data
>> -# chunk
>> -_scratch_mount -o nospace_cache
>> +# make sure data is written to the start position of the data chunk
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe=
 1
>>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
>> @@ -85,7 +84,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $dev=
path1 > /dev/null
>>
>>   # step 3: scrub filesystem to repair the bitrot
>>   echo "step 3......repair the bitrot" >> $seqres.full
>> -_scratch_mount -o nospace_cache
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
>>
>> diff --git a/tests/btrfs/170 b/tests/btrfs/170
>> index 15382eb3..3efe085d 100755
>> --- a/tests/btrfs/170
>> +++ b/tests/btrfs/170
>> @@ -27,9 +27,9 @@ _require_xfs_io_command "falloc" "-k"
>>   fs_size=3D$((2 * 1024 * 1024 * 1024)) # 2Gb
>>   _scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
>>
>> -# Mount without space cache so that we can precisely fill all data spa=
ce and
>> +# Mount without v1 cache so that we can precisely fill all data space =
and
>>   # unallocated space later (space cache v1 uses data block groups).
>> -_scratch_mount "-o nospace_cache"
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   # Create our test file and allocate 1826.25Mb of space for it.
>>   # This will exhaust the existing data block group and all unallocated=
 space on
>> diff --git a/tests/btrfs/199 b/tests/btrfs/199
>> index 6aca62f4..7fa678e7 100755
>> --- a/tests/btrfs/199
>> +++ b/tests/btrfs/199
>> @@ -67,7 +67,7 @@ loop_dev=3D$(_create_loop_device "$loop_file")
>>   loop_mnt=3D$tmp/loop_mnt
>>
>>   mkdir -p $loop_mnt
>> -# - nospace_cache
>> +# - _scratch_no_v1_cache_opt
>>   #   Since v1 cache using DATA space, it can break data extent bytenr
>>   #   continuousness.
>>   # - nodatasum
>> @@ -75,7 +75,7 @@ mkdir -p $loop_mnt
>>   #   Disabling datasum could reduce the margin caused by metadata to m=
inimal
>>   # - discard
>>   #   What we're testing
>> -_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
>> +_mount -o nodatasum,discard $(_scratch_no_v1_cache_opt) $loop_dev $loo=
p_mnt
>>
>>   # Craft the following extent layout:
>>   #         |  BG1 |      BG2        |       BG3            |
>> diff --git a/tests/btrfs/215 b/tests/btrfs/215
>> index fa622568..d62b2ff6 100755
>> --- a/tests/btrfs/215
>> +++ b/tests/btrfs/215
>> @@ -30,7 +30,7 @@ _require_non_zoned_device $SCRATCH_DEV
>>   _scratch_mkfs > /dev/null
>>   # disable freespace inode to ensure file is the first thing in the da=
ta
>>   # blobk group
>> -_scratch_mount -o nospace_cache
>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>
>>   pagesize=3D$(get_page_size)
>>   blocksize=3D$(_get_block_size $SCRATCH_MNT)
>> --
>> 2.33.0
