Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB649EEDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 00:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiA0XdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 18:33:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:47633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232474AbiA0XdE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 18:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643326377;
        bh=c74OiCiccVKGTFcLug3+DEJgppnPIsPtvyou/Np4JYU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kswo83oWD+KycSBneJj6MFiTu/iTIWAKUp4m/usrR5PEmS7RCA2l+oMjY0Bxg+au1
         prAfhrVAYRCnGhQ+TVpsjMzZjabYD1tlSomelTATqs79ROF5FDOaFQ+Cz2yTDQz2V2
         6mivmBQAq8gj289AhBlNo2AHqyHvXyNJoqz31hgw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJlc-1mWRFU2Alg-00jIdO; Fri, 28
 Jan 2022 00:32:57 +0100
Message-ID: <f76aed97-42a7-ae3e-c7e4-cdbbd2d001c8@gmx.com>
Date:   Fri, 28 Jan 2022 07:32:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: add test case to make sure autodefrag won't give
 up the whole cluster when there is a hole in it
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220127054543.28964-1-wqu@suse.com>
 <YfKAr3AaFpzmY0LX@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YfKAr3AaFpzmY0LX@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MFajcCsBWJBIQ9WUOgoyITZ7l7Wpa1nfS9JtRqaqKnJGTqA/X2b
 SisJ+EpEzQ5sdTAvEbQCThDLSFuxx2G/3qoD+9rumFyx5eioh6zFG0uXCmyeL3FDQ49DD1+
 N9BQd4N8QlLq7CcjEV0n4znjNg+DCF9ZnAIWujIZXy7khXtWWltQ5Pj7/RLRmhizH65S6By
 +pNYlLI2Uo30/UQ3Nkaaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hp3wY3mVnIo=:4KwLU/pX75Ir6ulmYWxtQM
 nPvxscUB/rrYra+KF3jW5fUj/EAhQsweIKCi8DbNR4PaW1/LnmC3hLv9GcGwFsNCF8EP+KTHl
 PjRI6XYqyFJ/ub20w5d43DgFL2KZCfzXZcWDFy4YOb8MxoAa2orKaSc6Zw2k/GSFcFhA9o6Az
 okShw02h0wwAYTu5MRkveNLCs/ciKG8qtMpQDtkVasRj1GUbgBtfMJVd02qVtDCiiF4V08acl
 wAZHqO77z57fx68+hMZ8zo8m0CuKeq6SJLgorZOUtc8t9QwQJUL5UKaYnaIOGILvUbfesZuqK
 tb9r0bQiFa7FMRkB/mjZnUQ7NENJZOEMQOt34iI0F5qwBBKrSBE1Yg6CZrRF5BVaVFPbK3ozL
 DG5RwQ2GSZdsCHcX5YErxqomvGjdKxQX9nvIAYIQn20UxnifyLbmGO3f9EC9p8rpzgZs/zwH9
 69q+vdSwpjo7dZMDtQft3B5lFf1GYJsJP513drclY9uY9rmalVvhN5vtqPK1HNDOvF92il/80
 r29mBGbmIAoZMdYvsraCqv7DUaurfJRQJuLBHpc9M66YzGDIwIjemMlMOnVsm7qK2RtgLQmbB
 6zHNm4vzhrX56Xy8u/e9o6WGDGNDfviGS5Twy11UWVCj1/k44bTzfSuJr66LmgW1FzX0TT86F
 haN7HF7K5X0VBrUarJsFZ3PMnB3nrr3X0t9KRm8dVU+UMCXir6IyWv5TV8WnHucH2/amzVigP
 YwoaR53cOee6SJBmfPqcP/kaCmbskoMBR9ORMQG9Au5X0diGF+4RPgD99k3mVs2LLYGDwXSPQ
 NldDuF7jxlrgP6xBLqOv2FC1GlkeKJPib+Ml1xK36k7TQ0n5g37rvyc7zJrSALhNSQbPHcXuf
 uTBpXlJfysgtxAYzaFoXoaF3Zj9hB0nbAPgosSx5YqWI+0/w+Lh5EdQb1MDeQT4FJ4JnRl+F0
 EH+1KW8allSpdxzBD05s3IYnUo5s87PBJbBKMH7LOnEZgx1y14ovJNRUUt3M8g3DtgjFUwcwf
 bRun8N1TkwAMZPKxwX8TU0SjE+HyKb4CqJH/Vh+BLtanhS1f5kooCQHI+ytXSjLWpglyEaacc
 FGIqpxuHcoKQTM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/27 19:23, Filipe Manana wrote:
> On Thu, Jan 27, 2022 at 01:45:43PM +0800, Qu Wenruo wrote:
>> In v5.11~v5.15 kernels, there is a regression in autodefrag that if a
>> cluster (up to 256K in size) has even a single hole, the whole cluster
>> will be rejected.
>>
>> This will greatly reduce the efficiency of autodefrag.
>>
>> The behavior is fixed in v5.16 by a full rework, although the rework
>> itself has other problems, it at least solves this particular
>> regression.
>>
>> Here we add a test case to reproduce the case, where we have a 128K
>> cluster, the first half is fragmented extents which can be defragged.
>> The second half is hole.
>>
>> Make sure autodefrag can defrag the 64K part.
>>
>> This test needs extra debug feature, which is titled:
>>
>>    [RFC] btrfs: sysfs: introduce <uuid>/debug/cleaner_trigger
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/btrfs        |  11 +++++
>>   tests/btrfs/256     | 112 +++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/256.out |   2 +
>>   3 files changed, 125 insertions(+)
>>   create mode 100755 tests/btrfs/256
>>   create mode 100644 tests/btrfs/256.out
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 5de926dd..4e6842d9 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -496,3 +496,14 @@ _require_btrfs_support_sectorsize()
>>   	grep -wq $sectorsize /sys/fs/btrfs/features/supported_sectorsizes ||=
 \
>>   		_notrun "sectorsize $sectorsize is not supported"
>>   }
>> +
>> +# Require trigger for cleaner kthread
>> +_require_btrfs_debug_cleaner_trigger()
>> +{
>> +	local fsid
>> +
>> +	fsid=3D$($BTRFS_UTIL_PROG filesystem show $TEST_DIR | grep uuid: |\
>> +	       $AWK_PROG '{print $NF}')
>> +	test -f /sys/fs/btrfs/$fsid/debug/cleaner_trigger ||\
>> +		_notrun "no cleaner kthread trigger"
>> +}
>> diff --git a/tests/btrfs/256 b/tests/btrfs/256
>> new file mode 100755
>> index 00000000..86e6739e
>> --- /dev/null
>> +++ b/tests/btrfs/256
>> @@ -0,0 +1,112 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 256
>> +#
>> +# Make sure btrfs auto defrag can properly defrag clusters which has h=
ole
>> +# in the middle
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto defrag quick
>> +
>> +. ./common/btrfs
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_require_scratch
>> +
>> +get_extent_disk_sector()
>> +{
>> +	local file=3D$1
>> +	local offset=3D$2
>> +
>> +	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
>> +		head -n1 | $AWK_PROG '{print $3}'
>> +}
>> +
>> +# Needs 4K sectorsize, as larger sectorsize can change the file layout=
.
>> +_require_btrfs_support_sectorsize 4096
>> +
>> +# We need a way to trigger autodefrag
>> +_require_btrfs_debug_cleaner_trigger
>
> In order to trigger the cleaner, we don't need another special purpose
> RFC debug patch.
>
> Just mount the fs with "-o commit=3D1", and then leave the "sleep 3" as =
it
> is. We do this in other tests that expect the cleaner thread to do
> something. Every time the transaction kthread wakes up, it will wake up
> the cleaner kthread, even if it doesn't have any transaction to commit.

Right! That's way better than the RFC patch.

>
>> +
>> +_scratch_mkfs >> $seqres.full
>> +
>> +# Need datacow to show which range is defragged, and we're testing
>> +# autodefrag
>> +_scratch_mount -o datacow,autodefrag
>> +
>> +fsid=3D$($BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT |grep uuid: |\
>> +       $AWK_PROG '{print $NF}')
>> +
>> +# Create a layout where we have fragmented extents at [0, 64k) (sync w=
rite in
>> +# reserve order), then a hole at [64k, 128k)
>> +$XFS_IO_PROG -f -c "pwrite 48k 16k" -c sync \
>> +		-c "pwrite 32k 16k" -c sync \
>> +		-c "pwrite 16k 16k" -c sync \
>> +		-c "pwrite 0 16k" $SCRATCH_MNT/foobar >> $seqres.full
>
> Instead of adding a bunch of "-c sync", you can pass -s to xfs_io:
>
> xfs_io -f -s -c "pwrite ..." -c "pwrite ..." ...
>
> It does exactly the same.
>
>> +truncate -s 128k $SCRATCH_MNT/foobar
>> +sync
>> +
>> +old_csum=3D$(_md5_checksum $SCRATCH_MNT/foobar)
>> +echo "=3D=3D=3D File extent layout before autodefrag =3D=3D=3D" >> $se=
qres.full
>> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
>> +echo "old md5=3D$old_csum" >> $seqres.full
>> +
>> +old_regular=3D$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
>> +old_hole=3D$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 64k)
>> +
>> +# For hole only xfs_io fiemap, there will be no output at all.
>
> You can get around that by not using _filter_xfs_io_fiemap at
> get_extent_disk_sector.

Unfortunately I have tried and failed.

The problem is really xfs_io fiemap -v will just output nothing if there
is only hole.

$ sudo xfs_io -c "fiemap -v" /mnt/btrfs/file2
/mnt/btrfs/file2:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..31]:         26688..26719        32   0x1
    1: [32..63]:        hole                32
$ sudo xfs_io -c "fiemap -v 16k" /mnt/btrfs/file2
/mnt/btrfs/file2:

Maybe it would be something to fix in the future?

Anyway, I'll integrate the special hole handling into the helper.

Thanks,
Qu
>
>> +# Re-fill it to "hole" for later comparison
>> +if [ ! -z $old_hole ]; then
>> +	echo "hole not at 128k"
>
> 128K -> 64K
>
>> +else
>> +	old_hole=3D"hole"
>> +fi
>> +
>> +# Now trigger autodefrag
>> +echo 0 > /sys/fs/btrfs/$fsid/debug/cleaner_trigger
>> +
>> +# No good way to wait for autodefrag to finish yet
>> +sleep 3
>> +sync
>> +
>> +new_csum=3D$(_md5_checksum $SCRATCH_MNT/foobar)
>> +new_regular=3D$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
>> +new_hole=3D$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 64k)
>> +
>> +echo "=3D=3D=3D File extent layout after autodefrag =3D=3D=3D" >> $seq=
res.full
>> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
>> +echo "new md5=3D$new_csum" >> $seqres.full
>> +
>> +if [ ! -z $new_hole ]; then
>> +	echo "hole not at 128k"
>
> 64K
>
>> +else
>> +	new_hole=3D"hole"
>> +fi
>> +
>> +# In v5.11~v5.15 kernels, regular extents won't get defragged, and wou=
ld trigger
>> +# the following output
>> +if [ $new_regular =3D=3D $old_regular ]; then
>> +	echo "regular extents didn't get defragged"
>> +fi
>> +
>> +# In v5.10 and earlier kernel, autodefrag may choose to defrag holes,
>> +# which should be avoided.
>> +if [ "$new_hole" !=3D "$old_hole" ]; then
>> +	echo "hole extents got defragged"
>> +fi
>> +
>> +# Defrag should not change file content
>> +if [ "$new_csum" !=3D "$old_csum" ]; then
>> +	echo "file content changed"
>> +fi
>> +
>> +echo "Silence is golden"
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/256.out b/tests/btrfs/256.out
>> new file mode 100644
>> index 00000000..7ee8e2e5
>> --- /dev/null
>> +++ b/tests/btrfs/256.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 256
>> +Silence is golden
>> --
>> 2.34.1
>>
