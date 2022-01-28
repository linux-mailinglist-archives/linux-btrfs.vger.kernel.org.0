Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB449F8FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348355AbiA1MN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:13:57 -0500
Received: from mout.gmx.net ([212.227.15.18]:45793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbiA1MN4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643372030;
        bh=VXEAHEdSLYWacmvPyLHxYFl7gaSlwXSoNraFgfsqiVw=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=WNt9FOOdoI5Bq2iBZhb/wYhmmnI1rWvWAqliQO8jobkL/iURwWlxY4zqBDv1ZcMX7
         BbtizzmSWRr/L+Z9weMc4o1pFPpgghRsaJ0f2/1sMhFbo3/CtATL5j2M7g4oBIYDyS
         cnzcC22Wc3RpRTScgeS3YH28o4n6ESzitrESNKN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHGCo-1n0EqD3BwG-00DDwV; Fri, 28
 Jan 2022 13:13:50 +0100
Message-ID: <704d3e1a-38a5-cafe-d50c-ed2158bb20f5@gmx.com>
Date:   Fri, 28 Jan 2022 20:13:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220128002701.11971-1-wqu@suse.com>
 <20220128002701.11971-2-wqu@suse.com> <YfPaJHzW4/KJoRAI@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 2/3] btrfs: test autodefrag with regular and hole
 extents
In-Reply-To: <YfPaJHzW4/KJoRAI@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OwcimyXuWlXbqseBRdddy3Ntf1V4nLSkFBR/QTSg3TVYCqSggPh
 woYU2OQQjS9+wG7zdAOsqaAuhQLVRqZ3foNVk7e3R/8bxfsnxP59RiIy6Z6PgZlwROxIZnb
 JIeWGBlCaqauUhFd15YcUNKAkSKJyEI8Z5TSmAwR7EnZm/FaQqk6LnbslNZxvUTN+1vN7LG
 qMJfz4lhlSi4IjXRFvk1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BxIxq68rcy4=:fr7s12YFC8lpu0OAFx4VtQ
 X3kFaRaYVQFx+b8LXFV11JJTpobPTFDAqsX+iSTQ7ZlaF+/28mea7vNJvxUXoo76Mf7Y7UOjO
 gOFKuy0DVmggsaKnVlMHq9V/WXzQCis6UCA5cejImqMDFPHyjnBkQTYajASkyZMDNX/aqVj8P
 ZLwjZXN4ydtw3KTd7BfbQjNmJmzq/TJuj/xJtEbnT9GJT1RRAWpItIWwieO1R+faNaCsmxK0E
 smOvCUzaO4A7BEZ+p7KQCQ5sP0C3Gpg4ypP8vk6un+XY06VqVjJeIB1cbS/KZBIZP+V25cBNN
 pXP0ID1t5yGcTHR+iONH/RnVMiTLloaKh9a5p7QJZEObk9Tyo9oCRqYFFf7C8aJqD20rwYOsN
 J93yUobbKZqt16Uo7KbVC5gc3Vkpd1xE3a5zBRpaVokZgiWc9rNLB2Y5cbvMEdaMFOho7hz+Z
 UnTtSpIiRhzPKoFi1q2Dg6wKs9LOjR0eubEOhwy1DIngP+ZOOQvuLnjpxE8yWaCGpFiMcixZE
 WtWP8j/Pl2g84DuKjpsXyGs/oZAnOTpKrP7IBHpC9us0BNduRM0J2EuZj13uLErY2m2owKOTW
 o1qgeNqax/ZsaIiD5D6PksXbwiuj46xvVieyzFcZVPTr5dhMb2KsF0Mr1FnPR0dbFLxigwJYv
 zWuRG4U7zNh/ySRIAmWsR1/v+WMPrhQMu+ej8WOE90sTK3H/b8I2+36qvjtkl9JV5c3fkURRJ
 LXRzi71SsupkYwLD9S110tviYEeespSn5kHdTPlIbfUyElKKGdTEgm1o4MHydwpPTiJ1wdJ+P
 6XhGE7Ej/H3LXE5TWafJAgGarOA840FN0F+NbogOyDSO1s58wI07NwNydbCWhUHnGFrcJXiGB
 pAeQXFQHQMq7H0EZeDzxOqxXQsXV9S53T/yCs4HfNpRFx4cFpqJJocKbGMF3rPQ20+VX2b2Ri
 5Xt1eCr97XzBKQhtTY6NFtk2BWtdSR/D0yRqTmPqd3ANgi3O6sq4DQdlYj4OjqIIFotw7eb//
 zCKkNWJ8m+0tXTdM1nIlXmuH5AekgWt8QKNCDGXVPI+/hvUBORyvGFdW/e8705wz/R+MHySXq
 I8a2cBt17XUBvc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/28 19:57, Filipe Manana wrote:
> On Fri, Jan 28, 2022 at 08:27:00AM +0800, Qu Wenruo wrote:
>> In v5.11~v5.15 kernels, there is a regression in autodefrag that if a
>> cluster (up to 256K in size) has even a single hole, the whole cluster
>> will be rejected.
>>
>> This will greatly reduce the efficiency of autodefrag.
>>
>> The behavior is fixed in v5.16 by a full rework, although the rework
>> itself has other problems, it at least solves the problem.
>>
>> Here we add a test case to reproduce the case, where we have a 128K
>> cluster, the first half is fragmented extents which can be defragged.
>> The second half is hole.
>>
>> Make sure autodefrag can defrag the 64K part.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Tried the test, and it succeeds here without the kernel fix applied.
> I've ran it 10 times, and it always passed without the kernel fix.

Have you tried v5.15 kernels? As v5.16 has the reworked code and will
always pass.

Or you can try to revert those 3 commits:

c22a3572cbaf ("btrfs: defrag: enable defrag for subpage case")
c635757365c3 ("btrfs: defrag: remove the old infrastructure")
7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement
btrfs_defrag_file()")

That's how I tested the case with the same kernel base without going
back to v5.15.

And with those 3 commits reverted (aka, my baseline to emulate v5.15),
it fails like this:

btrfs/256 4s ... - output mismatch (see
/home/adam/xfstests-dev/results//btrfs/256.out.bad)
     --- tests/btrfs/256.out	2022-01-28 08:19:11.123333302 +0800
     +++ /home/adam/xfstests-dev/results//btrfs/256.out.bad	2022-01-28
20:10:18.416666746 +0800
     @@ -1,2 +1,3 @@
      QA output created by 256
     +regular extents didn't get defragged
      Silence is golden
     ...
     (Run 'diff -u /home/adam/xfstests-dev/tests/btrfs/256.out
/home/adam/xfstests-dev/results//btrfs/256.out.bad'  to see the entire dif=
f)
Ran: btrfs/256

With the fiemap result in the full log:
=3D=3D=3D File extent layout before autodefrag =3D=3D=3D
/mnt/scratch/foobar:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..31]:         26720..26751        32   0x0
    1: [32..63]:        26688..26719        32   0x0
    2: [64..95]:        26656..26687        32   0x0
    3: [96..127]:       26624..26655        32   0x1
    4: [128..255]:      hole               128
old md5=3D9ef8ace32f3b9890cff4fd43699bbd81
=3D=3D=3D File extent layout after autodefrag =3D=3D=3D
/mnt/scratch/foobar:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..31]:         26720..26751        32   0x0
    1: [32..63]:        26688..26719        32   0x0
    2: [64..95]:        26656..26687        32   0x0
    3: [96..127]:       26624..26655        32   0x1
    4: [128..255]:      hole               128
new md5=3D9ef8ace32f3b9890cff4fd43699bbd81

With my POC patch for v5.15 or v5.16 kernel it passes as expected.

Thus that's why there is no fix mentioned in the commit message.

Thanks,
Qu



>
> Thanks.
>
>> ---
>> Changelog:
>> v2:
>> - Use the previously define _get_file_extent_sector() helper
>>    This also removed some out-of-sync error messages
>>
>> - Trigger autodefrag using commit=3D1 mount option
>>    No need for special purpose patch any more.
>>
>> - Use xfs_io -s to skip several sync calls
>>
>> - Shorten the subject of the commit
>> ---
>>   tests/btrfs/256     | 80 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/256.out |  2 ++
>>   2 files changed, 82 insertions(+)
>>   create mode 100755 tests/btrfs/256
>>   create mode 100644 tests/btrfs/256.out
>>
>> diff --git a/tests/btrfs/256 b/tests/btrfs/256
>> new file mode 100755
>> index 00000000..def83a15
>> --- /dev/null
>> +++ b/tests/btrfs/256
>> @@ -0,0 +1,80 @@
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
>> +# Needs 4K sectorsize, as larger sectorsize can change the file layout=
.
>> +_require_btrfs_support_sectorsize 4096
>> +
>> +_scratch_mkfs >> $seqres.full
>> +
>> +# Need datacow to show which range is defragged, and we're testing
>> +# autodefrag
>> +_scratch_mount -o datacow,autodefrag
>> +
>> +# Create a layout where we have fragmented extents at [0, 64k) (sync w=
rite in
>> +# reserve order), then a hole at [64k, 128k)
>> +$XFS_IO_PROG -f -s -c "pwrite 48k 16k" -c "pwrite 32k 16k" \
>> +		-c "pwrite 16k 16k" -c "pwrite 0 16k" \
>> +		$SCRATCH_MNT/foobar >> $seqres.full
>> +truncate -s 128k $SCRATCH_MNT/foobar
>> +
>> +old_csum=3D$(_md5_checksum $SCRATCH_MNT/foobar)
>> +echo "=3D=3D=3D File extent layout before autodefrag =3D=3D=3D" >> $se=
qres.full
>> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
>> +echo "old md5=3D$old_csum" >> $seqres.full
>> +
>> +old_regular=3D$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
>> +old_hole=3D$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
>> +
>> +# Now trigger autodefrag, autodefrag is triggered in the cleaner threa=
d,
>> +# which will be woken up by commit thread
>> +_scratch_remount commit=3D1
>> +sleep 3
>> +sync
>> +
>> +new_csum=3D$(_md5_checksum $SCRATCH_MNT/foobar)
>> +new_regular=3D$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
>> +new_hole=3D$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
>> +
>> +echo "=3D=3D=3D File extent layout after autodefrag =3D=3D=3D" >> $seq=
res.full
>> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
>> +echo "new md5=3D$new_csum" >> $seqres.full
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
