Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6934A6F47
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 11:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbiBBK5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 05:57:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:38095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbiBBK5o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Feb 2022 05:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643799458;
        bh=AVf1wwddGyZq1MzIMb5tKFDt6SX1eHUWjV/ve6DFQ58=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JLXCAN6fGgVIpZRR/1BOtZt3Js4gJBVKnbcF6qyQ4O3rSYFKYFcWrYD90PxKMnw1N
         wiS383Fp2KxWUNiHOPjtmSpESuVtXGgdDWMBeC77e1Pb/Lt3jJnu/FpXAsOElGsnGt
         HJIU4cUvboqw4v0UptcnjRGA54YZf10WDkPFsgeY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbkv-1mqh8U2wdH-00P9iC; Wed, 02
 Feb 2022 11:57:38 +0100
Message-ID: <52509e7d-16ec-e42e-8c4e-effa225e3034@gmx.com>
Date:   Wed, 2 Feb 2022 18:57:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: add test case to verify "btrfs filesystem defrag
 -c" behavior
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220202083158.68262-1-wqu@suse.com>
 <CAL3q7H6uc8qHnMTW1S5mQf=sL5GEW5rJjYJHge8WKsdvhxQ88Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H6uc8qHnMTW1S5mQf=sL5GEW5rJjYJHge8WKsdvhxQ88Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aOFigxoyZ9xf4Gt7Lgocd1CqSY6v/+2Zwf78+HGtRp49CcaCvW5
 wb7Dlymfcfc4jHw6JJRdNl83RSSWyLwpr2CFSCBCF7yTobcCol32hxjURgtHDFrV0bsQU1e
 7A/lPaEgeEsWKZih1osbqhVGwoBpmScNL0LHm3IryT4jofBVS28EI3ZDqcsKalpUjEDhKRE
 YWDyV88tgijBgWNBJU60w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJlja8CjBc4=:UlmhKMy42SlSadvWHnsfAU
 aUpHWLE8m8buFhdgtNuzTGqiNcjq+lPy5x7SwalYWbH43Y4ydQZ+g5KffiYgkwtDpSkI+St44
 9jt/uEX4101WDkjXAb5tY0M+V98srkcEak2PbayBVYMtIHa/dPZMVq5KoBNnFrcEuNTBpj1RB
 pliKCTnV60LDOLYrwGxjh5gpJ1p3N2qhF80Xx6fADiAupO1m3CccIlvn6rSX0GpK84y97HMbR
 nmWbqDBtTiRe49I6qCiI989rApBbsyicNKul9M/sMcp+1zv8YMi5f5dPAwwJcDy2MvjhJH+Gs
 D21JVNeP++ZY/NrznT31WOlUvF+aD9oern7rRfpzWvEodo/qvGvcn9D5OK3W6hd0gzlg4H1VE
 9ml3TgfNs1tsLRfteUhJg8C6swTdo+jkbGABOJeLKT9Nkie2yANyvplS8pThLmUkAXEzKpsP3
 u1E3OmZRy+j4CY31mL4WY26MgmArA5kD7t5QIFAxYQf6c3RUyYwO5SUOja4q5GmP340eWj2pp
 dc1CUyZOHKXRKumgdYnJFBDv3vnlh/qE5vBrcptLsQpQ6c13lpuMmmxXblF3CpclF72zumWEx
 du7k6B6Eth8shihoCA2aaVIucKRxeiKHlyrrSZ5aEAteJMvNTyO4FCkwHEDiUPnx7ZmwiE9Vh
 C4TWeJ7aS3eW2SIhUfS4DL7RMwuukJaEDz6Fo+/+haXDlYDS7NTpeadXhQ2Y0ET8IHxoltICX
 NFV8CozifnLQA5ma+y/viB1F3GtnBBMiPAa6orQ/GgRC00upUknV1zFXTXtRuTEd2qqxFxin5
 aU237iiN4kWOxUoOPTnjsULFFDwxVqzSzJl9xiftqBfyuBkEc/waqx02rYnR0EWWa8j1/XZsU
 aXnPOnPtX4y+uFgcI2D99VCuwdnIzhCyboVHDOYLe9UG0aeqMxtmm9C8z9xIU1+7nL/qNmb16
 FOBt5j1HL8y3VDvE8imRm9ClGSlCksCNIDKAZb1V1Rj+CEFgt8+9pxYEipd2Q3Y7Z8udkbIQa
 Fd5ZINRjhLZsFGvs4nDQ0IunaYpqUvtNgyt1zBhryOHbM5RL3ETQHAI/vtS94KqaYUYRjelE/
 EHLSJSZ4y+75UI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/2 18:52, Filipe Manana wrote:
> On Wed, Feb 2, 2022 at 10:13 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Despite the regular file defragging, "btrfs filesystem defrag" provides
>> an option, -c, to convert all data extents (except holes and
>> preallocated ranges) to a new compression algorithm.
>>
>> The special behavior here is, unlike defrag which is not going to touch
>> extents which are adajacent to preallocated/hole ranges, with -c, all
>
> adajacent -> adjacent
>
>> non-hole/non-preallocated extents should be defragged and converted to
>> the new compression algorithm.
>>
>> This test case will ensure the old behavior is properly kept.
>>
>> Currently both old kernels (v5.15 and older) and newer kernel with
>> refactored defrag (v5.16 and newer) can pass the tests.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/258     | 153 +++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/258.out |   2 +
>>   2 files changed, 155 insertions(+)
>>   create mode 100755 tests/btrfs/258
>>   create mode 100644 tests/btrfs/258.out
>>
>> diff --git a/tests/btrfs/258 b/tests/btrfs/258
>> new file mode 100755
>> index 00000000..a82e5af9
>> --- /dev/null
>> +++ b/tests/btrfs/258
>> @@ -0,0 +1,153 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 258
>> +#
>> +# Make sure "btrfs filesystem defrag" can still convert the compressio=
n
>> +# algorithm of all regular extents.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick defrag compress
>
> Missing 'prealloc' group, as the test uses fallocate.
>
>> +
>> +# Override the default cleanup function.
>> +# _cleanup()
>> +# {
>> +#      cd /
>> +#      rm -r -f $tmp.*
>> +# }
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +get_inode_number()
>> +{
>> +       local file=3D"$1"
>> +
>> +       stat -c "%i" "$file"
>> +}
>> +
>> +get_file_extent()
>> +{
>> +       local file=3D"$1"
>> +       local offset=3D"$2"
>> +       local ino=3D$(get_inode_number "$file")
>> +       local file_extent_key=3D"($ino EXTENT_DATA $offset)"
>> +
>> +       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |=
\
>> +               grep -A4 "$file_extent_key"
>
> Misses a "_require_btrfs_command inspect-internal dump-tree" at the top.
>
>> +}
>> +
>> +check_file_extent()
>> +{
>> +       local file=3D"$1"
>> +       local offset=3D"$2"
>> +       local expected=3D"$3"
>> +
>> +       echo "=3D=3D=3D file extent at file '$file' offset $offset =3D=
=3D=3D" >> $seqres.full
>> +       get_file_extent "$file" "$offset" > $tmp.output
>> +       cat $tmp.output >> $seqres.full
>> +       grep -q "$expected" $tmp.output ||\
>> +               echo "file \"$file\" offset $offset doesn't have expect=
ed string \"$expected\""
>> +}
>> +
>> +# Unlike file extents whose btrfs specific attributes need to be grabb=
ed from
>> +# dump-tree, we can check holes by fiemap. In fact recent no-holes fea=
ture
>
> no-holes was added in 2013, so I wouldn't call it recent.
> What you can say is that mkfs enables it by default in new versions of
> btrfs-progs.
>
>> +# even makes it unable to grab holes from dump-tree.
>> +check_hole()
>> +{
>> +       local file=3D"$1"
>> +       local offset=3D"$2"
>> +       local len=3D"$3"
>> +
>> +       output=3D$($XFS_IO_PROG -c "fiemap $offset $len" "$file" |\
>> +                _filter_xfs_io_fiemap | head -n1)
>
> As the test is using ranged fiemap, it should add:
>
> _require_xfs_io_command "fiemap" "ranged"
>
> At the top.
>
>> +       if [ -z $output ]; then
>> +               echo "=3D=3D=3D file extent at file '$file' offset $off=
set is a hole =3D=3D=3D" \
>> +                       >> $seqres.full
>> +       else
>> +               echo "=3D=3D=3D file extent at file '$file' offset $off=
set is not a hole =3D=3D=3D"
>> +       fi
>> +}
>> +
>> +# Needs 4K sectorsize as the test is crafted using that sectorsize
>> +_require_btrfs_support_sectorsize 4096
>> +
>> +_scratch_mkfs -s 4k >> $seqres.full 2>&1
>> +
>> +# Initial data is compressed using lzo
>> +_scratch_mount -o compress=3Dlzo,compress-force=3Dlzo
>
> Why both compress options? Why isn't only compress-force enough?
> It's redundant to use compress when using compress-force, or did I
> miss something?

My bad, the thing here is from my initial runs, the `fragment` file
never go its extents written as compressed.

It turns out that my initial runs are always doing
pwrite->falloc->pwrite->pwrite, causing the PREALLOC inode flag and
tries go NOCOW path first, then fallback to COW without compression.

The root reason is spotted later, but forget to change the mount option
which is tried to solve the problem but won't really work.

All the comments will be addressed in the next update.

Thanks for the review,
Qu
>
>> +
>> +# file 'large' has all of its compressed extents at their maximum size
>> +$XFS_IO_PROG -f -c "pwrite 0 1m" "$SCRATCH_MNT/large" >> $seqres.full
>> +
>> +# file 'fragment' has all of its compressed extents adjacent to
>> +# preallocated/hole ranges, which should not be defragged with regular
>> +# defrag ioctl, but should still be defragged by "btrfs fi defrag -c"
>> +$XFS_IO_PROG -f -c "pwrite 0 16k" \
>> +               -c "pwrite 32k 16k" -c "pwrite 64k 16k" \
>> +               "$SCRATCH_MNT/fragment" >> $seqres.full
>> +sync
>> +# We only do the falloc after the compressed data reached disk.
>> +# Or the inode could have PREALLOC flag, and prevent the
>> +# data from being compressed.
>> +$XFS_IO_PROG -f -c "falloc 16k 16k" "$SCRATCH_MNT/fragment"
>
> -f should go away, the file already exists.
>
> Also, missing a:
>
> _require_xfs_io_command "falloc"
>
> at the top.
>
>> +sync
>> +
>> +echo "=3D=3D=3D=3D=3D=3D Before the defrag =3D=3D=3D=3D=3D=3D" >> $seq=
res.full
>> +
>> +# Should be lzo compressed
>> +check_file_extent "$SCRATCH_MNT/large" 0 "compression 2"
>> +
>> +# Should be lzo compressed
>> +check_file_extent "$SCRATCH_MNT/fragment" 0 "compression 2"
>> +
>> +# Should be preallocated
>> +check_file_extent "$SCRATCH_MNT/fragment" 16384 "type 2"
>> +
>> +# Should be lzo compressed
>> +check_file_extent "$SCRATCH_MNT/fragment" 32768 "compression 2"
>> +
>> +# Should be hole
>> +check_hole "$SCRATCH_MNT/fragment" 49152 16384
>> +
>> +# Should be lzo compressed
>> +check_file_extent "$SCRATCH_MNT/fragment" 65536 "compression 2"
>> +
>> +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/large" -czstd \
>
> Tests should use the full name of btrfs commands and no abbreviations.
> So it should use "defragment" and not "defrag", even if it seems very
> unlikely the shorter name
> will ever be unsupported.
>
> Thanks.
>
>> +       "$SCRATCH_MNT/fragment" >> $seqres.full
>> +# Need to commit the transaction or dump-tree won't grab the new
>> +# metadata on-disk.
>> +sync
>> +
>> +echo "=3D=3D=3D=3D=3D=3D After the defrag =3D=3D=3D=3D=3D=3D" >> $seqr=
es.full
>> +
>> +# Should be zstd compressed
>> +check_file_extent "$SCRATCH_MNT/large" 0 "compression 3"
>> +
>> +# Should be zstd compressed
>> +check_file_extent "$SCRATCH_MNT/fragment" 0 "compression 3"
>> +
>> +# Should be preallocated
>> +check_file_extent "$SCRATCH_MNT/fragment" 16384 "type 2"
>> +
>> +# Should be zstd compressed
>> +check_file_extent "$SCRATCH_MNT/fragment" 32768 "compression 3"
>> +
>> +# Should be hole
>> +check_hole "$SCRATCH_MNT/fragment" 49152 16384
>> +
>> +# Should be zstd compressed
>> +check_file_extent "$SCRATCH_MNT/fragment" 65536 "compression 3"
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/258.out b/tests/btrfs/258.out
>> new file mode 100644
>> index 00000000..9d47016c
>> --- /dev/null
>> +++ b/tests/btrfs/258.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 258
>> +Silence is golden
>> --
>> 2.34.1
>>
