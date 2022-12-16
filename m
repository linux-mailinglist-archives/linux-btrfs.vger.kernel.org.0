Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FEB64E885
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 10:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLPJOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 04:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPJOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 04:14:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84CB3D3BC;
        Fri, 16 Dec 2022 01:14:37 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1p5YIX2jp8-001eOF; Fri, 16
 Dec 2022 10:14:20 +0100
Message-ID: <d5c05013-f9a2-1368-3bd8-554533f3ba48@gmx.com>
Date:   Fri, 16 Dec 2022 17:14:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: new test for logical inode resolution panic
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>, Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
References: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
 <20221216084627.ipg772ugfedo6mig@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221216084627.ipg772ugfedo6mig@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PhKBQSkV125F8bbnyXTZobp5FR6tuYjigsze7bWKHLLygxATyYu
 6IdEDOW5uXFoptElf3vM1s1tLJJs99qQrYbtlUzf3M05eadOMrhQFbqcFlqmzFnz/xlJlIs
 xRo2hUnWWgEFmcxMWz2cUmH5065iFfO5pOqvR9HWmpUlO711D6Hkmv94nZC8kbttM4a3OHn
 v91RNyJctknEaIYXSoA7w==
UI-OutboundReport: notjunk:1;M01:P0:qnZb4n7M7k8=;Ko+If2vvDG/85A5p9dfjB2xVI2y
 xKx5ADzSd9OeukqQshYXABFMB6JykGGZCk6hdo5hvboh9nw5evWIPDcUnukkIpX5Er4Ciwhh4
 0R9Wkk7C6ww+BD36D/AiPZOSb/65Eu3l9JDNjfB9j2PamvuB5SJGEN4YXgZ4bGibodtFoN/rQ
 767a60nGZ43WeEBHiLHaJmqss9dEiWKOW+PrX3Lfo8uXM05jSnR4zh1gqTT3AmzEzIlE5Zmf0
 g/YHCBsM+NDldJ2KXb+Cdmtd/o4p4M/YiRnQ4gvoKDLNbrsAk21Y68U59INOnbPnuBEr6sI95
 IsuhjkZkd6VoOEQNm/T2uD5pt18EN5vjqet3d2Kih+hEBTmYHLQ6fTxFGOuFD6NXC567Twtmn
 0KCcXqc7iFrwKsyf3yKVylmWAGSr7qZuS0k2c0JZbdmkvLKRxhW1S0bcIaKSg2m2QNy4lDyL+
 U9eXcSZWkkp8N1tYp3hiM9b0Og9O2dVVkbR9anAFgg13xwciRvzZ4PdjFJF5CoKzq7ILPZFHY
 QP0FdsXL77v9pxeVqwFA855FyvZHnusm+FLEqOQElUWcKH2N1VAXLLokk8jlv+sqqtnOVk/LT
 cJz0mAHobMhzV3VXs2DKoj61LQGYeT9iSuXJCS1eK0LHB2ZQmwnOjUP6/ELOtvsv3F2C5r32w
 l7LQOs6zMeSFeD0LrJXgYlfmftWJ0RGHBqAUOp9bukcedgVgzMdSQmgOPW89OgcDwXpX0pgpg
 gL9FwjjscsdKZVy0YOc7hHJKnmNGytV1mUT3aQZ9v5sWUKe35eJAcf1joc6WM4+6dEQHYFaR/
 cdxCkHSuoR+Qt8dybODo6uhj7g6gE+ivwkuoUwKLpPFW+wYxs429x5t7eBrrvaLs4PoRHi5Dx
 lTiZsmQyQopHRHDalg2FvvDyl5O9OJFvH0x9MCoMwSuR/gGMBVRREXwHP0C685h3pQ2Npvunp
 Gqau/U9RhcfGkQoz9a8zWcmo0iI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/16 16:46, Zorro Lang wrote:
> On Wed, Dec 14, 2022 at 03:12:01PM -0800, Boris Burkov wrote:
>> If we create a file that has an inline extent followed by a prealloc
>> extent, then attempt to use the logical to inode ioctl on the prealloc
>> extent, but in the overwritten range, backref resolution will process
>> the inline extent. Depending on the leaf eb layout, this can panic.
>> Add a new test for this condition. In the long run, we can add spew when
>> we read out-of-bounds fields of inline extent items and simplify this
>> test to look for dmesg warnings rather than trying to force a fairly
>> fragile panic (dependent on non-standardized details of leaf layout).
>>
>> The test causes a kernel panic unless:
>> btrfs: fix logical_ino ioctl panic
> 
> Hi,
> 
> Thanks for this new case.
> 
> Is this patch merged, does it has a commit id? BTW, please mark this
> known issue by _fixed_by_kernel_commit in case source code.

This fix is not yet merged, but I believe it would soon get merged:

https://patchwork.kernel.org/project/linux-btrfs/patch/80f01f297721481fd0d4cbf03fd2550e25b578fb.1671058852.git.boris@bur.io/

> 
>> is applied to the kernel.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>> ---
>>   tests/btrfs/279     | 95 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/279.out |  2 +
>>   2 files changed, 97 insertions(+)
>>   create mode 100755 tests/btrfs/279
>>   create mode 100644 tests/btrfs/279.out
>>
>> diff --git a/tests/btrfs/279 b/tests/btrfs/279
>> new file mode 100755
>> index 00000000..ef77f84b
>> --- /dev/null
>> +++ b/tests/btrfs/279
> 
> btrfs/279 was just token last weekend, please help to rebase to the latest
> fstests for-next branch, or change the 279 to a big enough number which won't
> cause conflict (I'll give it a proper number when merge it).
> 
>> @@ -0,0 +1,95 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
>> +#
>> +# FS QA Test 279
>> +#
>> +# Given a file with extents:
>> +# [0 : 4096) (inline)
>> +# [4096 : N] (prealloc)
>> +# if a user uses the ioctl BTRFS_IOC_LOGICAL_INO[_V2] asking for the file of the
>> +# non-inline extent, it results in reading the offset field of the inline
>> +# extent, which is meaningless (it is full of user data..). If we are
>> +# particularly lucky, it can be past the end of the extent buffer, resulting in
>> +# a crash.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/dmlogwrites
> 
> Does this case really use helpers in above two included files?
> 
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +_require_xfs_io_command "falloc"
> 
> Add this case to prealloc or preallocrw group
> 
>> +_require_xfs_io_command "fsync"
>> +_require_xfs_io_command "pwrite"
>> +
>> +dump_tree() {
>> +	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV
> 
> _require_btrfs_command inspect-internal dump-tree
> 
>> +}
>> +
>> +get_extent_data() {
>> +	local ino=$1
>> +	dump_tree $SCRATCH_DEV | grep -A4 "($ino EXTENT_DATA "
>> +}
>> +
>> +get_prealloc_offset() {
>> +	local ino=$1
>> +	get_extent_data $ino | grep "disk byte" | awk '{print $5}'
>> +}
>> +
>> +# This test needs to create conditions s.t. the special inode's inline extent
>> +# is the first item in a leaf. Therefore, fix a leaf size and add
>> +# items that are otherwise not necessary to reproduce the inline-prealloc
>> +# condition to get to such a state.
>> +#
>> +# Roughly, the idea for getting the right item fill is to:
>> +# 1. create an extra file with a variable sized inline extent item
>> +# 2. create our evil file that will cause the panic
>> +# 3. create a whole bunch of files to create a bunch of dir/index items
>> +# 4. size the variable extent item s.t. the evil extent item is item 0 in the
>> +#    next leaf
>> +#
>> +# We do it in this somewhat convoluted way because the dir and index items all
>> +# come before any inode, inode_ref, or extent_data items. So we can predictably
>> +# create a bunch of them, then sneak in a funny sized extent to round out the
>> +# difference.
>> +
>> +_scratch_mkfs "--nodesize 16k" >/dev/null
> 
> We recommend calling _fail at here if _scratch_mkfs fails with a *specified*
> option.
> 
> _scratch_mkfs "--nodesize 16k" >>$seqres.full || _fail "mkfs failed"
> 
>> +_scratch_mount
>> +
>> +f=$SCRATCH_MNT/f
>> +
>> +# the variable extra "leaf padding" file
>> +$XFS_IO_PROG -fc "pwrite -q 0 700" $f.pad
>> +
>> +# the evil file with an inline extent followed by a prealloc extent
>> +# created by falloc with keep-size, then two non-truncating writes to the front
>> +touch $f.evil
> 
> Not sure if you reall use this touch command as you've used "-f" option for
> xfs_io.
> 
>> +$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
>> +$XFS_IO_PROG -fc fsync $f.evil
>> +ino=$(stat -c '%i' $f.evil)
>> +logical=$(get_prealloc_offset $ino)
>> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
>> +$XFS_IO_PROG -fc fsync $f.evil
>> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
>> +$XFS_IO_PROG -fc fsync $f.evil
> 
> xfs_io commands can be combined in one line, to make the code looks clear (except
> you hope the fd closed after each command done) E.g:
> 
> $XFS_IO_PROG -fc "falloc -k 0 1m" -c fsync $f.evil
> ino=$(stat -c '%i' $f.evil)
> logical=$(get_prealloc_offset $ino)
> $XFS_IO_PROG -c "pwrite -q 0 23" -c fsync \
> 	     -c "pwrite -q 0 23" -c fsync \
> 	     $f.evil
> 
>> +sync
>> +
>> +# a bunch of inodes to stuff dir items in front of the extent items
>> +for i in $(seq 122); do
>> +	$XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
>> +done
>> +sync
>> +
>> +btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT | _filter_scratch
>     ^^
>     $BTRFS_UTIL_PROG
> 
> _require_btrfs_command inspect-internal logical-resolve
> 
> The .out file only has "Silence is golden", what's this _filter_scratch used for?
> 
>> +_scratch_unmount
> 
> Is the ending _scratch_unmount useful?
> 
>> +
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
>> new file mode 100644
>> index 00000000..c5906093
>> --- /dev/null
>> +++ b/tests/btrfs/279.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 279
>> +Silence is golden
>> -- 
>> 2.38.1
>>
> 
