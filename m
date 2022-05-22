Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D6C530140
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 08:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiEVGbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 02:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiEVGbt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 02:31:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99F3A717;
        Sat, 21 May 2022 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653201101;
        bh=6aWwLxFU9fJB8ZkSGOgzvyrjI99y4qDlNupy2q6nVtU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YzWN9fUWgWU17ztAtIHZ39JY4zDREtRF4wfaW65Zamc6S5u3i0aDat6yC2bWQV64s
         piLukh/JCWRjIszEeiFseijSndM46iDjOqsseyRP91dRGpPGqFGlK19duzfAfmGiJq
         pf9tTI+HXkvWnis8eCxRq3kiP8QSoOI5qQF0rDLM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVHe-1o7z3E0euO-00JqgF; Sun, 22
 May 2022 08:31:40 +0200
Message-ID: <c28607d6-34c5-5c9e-cb55-2a64273c477f@gmx.com>
Date:   Sun, 22 May 2022 14:31:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] btrfs: test repair with corrupted sectors interleaved
 over multiple mirrors
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220520164743.4023665-1-hch@lst.de>
 <20220520164743.4023665-3-hch@lst.de>
 <791e365d-eb41-9073-80b7-40ee9a42d659@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <791e365d-eb41-9073-80b7-40ee9a42d659@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xPcw960ZH4Lc/QJyU/CaPJXzqz1NDH5QNoF3yBZeYgO2pDpFYaI
 mOqxQRrMkWDaBqlUacxeimbVsU79eC/wsOcvsxnx4w2JbVAobimg7JWZa8Rk0p0soSutApd
 30GGMeE6zUat8nFvRkJiYZDi6f11VoTzWOUiy4Nf4Sa9l+mv697xEzBJbjCAGhlTy0FwkCn
 WI+v7n2uBJm0TY54ugl7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:atf3jZl92rw=:cyKPfgy/wHxmRrQsvnGs8o
 XvnHqqRvZVGv5Us/V8pnUtb7oaG/aGzp3kaPVwXZSUshL/jynKKYSS8lSTrLlfAtF3en3JoQy
 IUFaSA8M4fCXiihTBwP2D5iKGYzYjhwBcer+O2b63d3XMxBh63lltHrzac6xDuo5BrmIRMppR
 DZdaZEy+4MRwrZGiCXUW2KzVO9Jub26lG3DEossUw7JenbveK0K1FX8iZ8IYoiRuBO9WDSkqG
 27bxXlhrmkgmVvFsH+sH78LcjAFqgqV50RifQ6cPxnKiemvW6fc8BWlnHRTHU22DNutYziQV3
 8bhVJSsw4GPwhDSLsDUUrNKzZV+x3R10VWju/DJGMXiH3b3Gu73SG8hPMb3Q+FQoXsvIvLxWa
 DvTAz5FVVyuaHQH8PoN3hLCgtuayjxd9m2xKhadVgNVIx18UZVNNfNiwbyza9MxybU4XRcXS3
 4KUcLVHUXCB48YXJWuQ5eHQEed/y443YK3DTLqZ0hNkd5ZGxsI3IOYBntQUh2XYse4aPANx95
 kLYF2CBija2Ok3Hw++rcuv66ijuZlChr6vCDqgH4O8BA8q1RuDBxwkZ9OOXiK2v2U6yRcLXE5
 fFPdakVVAz+XO1AHW5z8otL0NaEFsbrYXWz0p2pqvRK1KD8qh4grjuGytbs81WqXihXc7VRuY
 21zNvM8f6ZuuhY8oUAfmYaASmMXFgzVqUpxPK8C9wHaouUCX4p/bJzJESKsedCkiNKHW3R9hx
 4OCKj2wSZjNYXktqfqsx3zJlhEcZi8CZOXLk7MVcs5XhQmiqLyr0ispwNEMTpzcldCz24RFzB
 5MD2IVmrQrbfhVbq+EpR21Gd92kg7UADXAFb9zt/OKjclNwbBRAA1pW7kduospDy6HN3Njv72
 pT+5EJqDxADzI2fYYixGSealN6hkEuYI3eZcb+aKEs0I+Xgs/AwtOj0ZsQJlhymWboWC2wcxJ
 9AhU0JM8YhyAZ0n4+XuDW9zylrYIlP4MDHLUyLgB4Gk4CmCKIxnVrLvMJ9oIb/TBlYHdLgStr
 MBkxlj+xO4Xl8Y4hFwxL5nOKoWwfzo1q38SoS/U9y83zeaZV/m30j05Ld/BAGOwkIYg/NPLvm
 0bFrOeQxqwYYspr/Acu2drpdIK7727gLAs8BPTOz7zHATzIYJMoN/cCxQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/22 09:13, Anand Jain wrote:
> On 5/20/22 22:17, Christoph Hellwig wrote:
>> Test that repair handles the case where it needs to read from more than
>> a single mirror on the raid1c3 profile and needs to take turns over the
>> mirrors to recover data for the whole read.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>> =C2=A0 tests/btrfs/266=C2=A0=C2=A0=C2=A0=C2=A0 | 145 ++++++++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0 tests/btrfs/266.out | 109 +++++++++++++++++++++++++++++++++
>> =C2=A0 2 files changed, 254 insertions(+)
>> =C2=A0 create mode 100755 tests/btrfs/266
>> =C2=A0 create mode 100644 tests/btrfs/266.out
>>
>> diff --git a/tests/btrfs/266 b/tests/btrfs/266
>> new file mode 100755
>> index 00000000..24c2b5fd
>> --- /dev/null
>> +++ b/tests/btrfs/266
>> @@ -0,0 +1,145 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2017 Liu Bo.=C2=A0 All Rights Reserved.
>> +# Copyright (c) 2022 Christoph Hellwig.
>> +#
>> +# FS QA Test 266
>> +#
>> +# Test that btrfs raid repair on a raid1c3 profile can repair
>> interleaving
>> +# errors on all mirrors.
>> +#
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick read_repair
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs btrfs
>> +_require_scratch_dev_pool 3
>> +
>> +BTRFS_MAP_LOGICAL_PROG=3D$(type -P btrfs-map-logical)
>> +
>> +_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
>> +_require_command "$FILEFRAG_PROG" filefrag
>> +_require_odirect
>> +# Overwriting data is forbidden on a zoned block device
>> +_require_non_zoned_device "${SCRATCH_DEV}"
>> +
>> +get_physical()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local logical=3D$1
>> +=C2=A0=C2=A0=C2=A0 local stripe=3D$2
>> +
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >>=
 $seqres.full
>> 2>&1
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | =
\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $AWK_PROG "(\$1 ~ /mirror/ =
&& \$2 ~ /$stripe/) { print \$6 }"
>> +}
>> +
>> +get_device_path()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local logical=3D$1
>> +=C2=A0=C2=A0=C2=A0 local stripe=3D$2
>> +
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | =
\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $AWK_PROG "(\$1 ~ /mirror/ =
&& \$2 ~ /$stripe/) { print \$8 }"
>> +}
>> +
>
> Can wrap into a helper in common/btrfs.
>
>> +_scratch_dev_pool_get 3
>> +# step 1, create a raid1 btrfs which contains one 128k file.
>> +echo "step 1......mkfs.btrfs"
>> +
>> +mkfs_opts=3D"-d raid1c3 -b 1G"
>> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>> +
>> +# make sure data is written to the start position of the data chunk
>> +_scratch_mount $(_btrfs_no_v1_cache_opt)
>> +
>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
>> +=C2=A0=C2=A0=C2=A0 "$SCRATCH_MNT/foobar" | \
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +
>> +# ensure btrfs-map-logical sees the tree updates
>> +sync
>> +
>> +# step 2, corrupt 4k in each copy
>> +echo "step 2......corrupt file extent"
>> +
>> +${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>> +logical=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag =
|
>> cut -d '#' -f 1`
>> +
>> +physical1=3D$(get_physical ${logical} 1)
>> +devpath1=3D$(get_device_path ${logical} 1)
>> +
>> +physical2=3D$(get_physical ${logical} 2)
>> +devpath2=3D$(get_device_path ${logical} 2)
>> +
>> +physical3=3D$(get_physical ${logical} 3)
>> +devpath3=3D$(get_device_path ${logical} 3)
>> +
>> +_scratch_unmount
>> +
>
>
>
>> +$XFS_IO_PROG -d -c "pwrite -S 0xbd -b 4K $physical3 4K" $devpath3 \
>> +=C2=A0=C2=A0=C2=A0 > /dev/null
>> +
>> +$XFS_IO_PROG -d -c "pwrite -S 0xba -b 4K $physical1 8K" $devpath1 \
>> +=C2=A0=C2=A0=C2=A0 > /dev/null
>> +
>> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 4K $((physical2 + 4096)) 8K"
>> $devpath2 \
>> +=C2=A0=C2=A0=C2=A0 > /dev/null
>> +
>> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 4K $((physical3 + (2 * 4096)))
>> 8K"=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 $devpath3 > /dev/null
>> +
>
> Could you please make this test case compatible with the 64K sectorsize
> configs too?
>
>
>
>
>> +_scratch_mount
>> +
>> +# step 3, 128k dio read (this read can repair bad copy)
>> +echo "step 3......repair the bad copy"
>> +
>> +# since raid1c3 consists of three copies, and the bad copy was put on
>> stripe #1
>> +# while the good copy lies the other stripes, the bad copy only gets
>> accessed
>> +# when the reader's pid % 3 is 1
>> +while true; do
>> +=C2=A0=C2=A0=C2=A0 echo 3 > /proc/sys/vm/drop_caches
>> +=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MN=
T/foobar" >
>> /dev/null &
>> +=C2=A0=C2=A0=C2=A0 pid=3D$!
>> +=C2=A0=C2=A0=C2=A0 wait
>> +=C2=A0=C2=A0=C2=A0 if [ $((pid % 3)) =3D=3D 1 ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0 fi
>> +done
>> +while true; do
>> +=C2=A0=C2=A0=C2=A0 echo 3 > /proc/sys/vm/drop_caches
>> +=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MN=
T/foobar" >
>> /dev/null &
>> +=C2=A0=C2=A0=C2=A0 pid=3D$!
>> +=C2=A0=C2=A0=C2=A0 wait
>> +=C2=A0=C2=A0=C2=A0 if [ $((pid % 3)) =3D=3D 2 ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0 fi
>> +done
>> +while true; do
>> +=C2=A0=C2=A0=C2=A0 echo 3 > /proc/sys/vm/drop_caches
>> +=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MN=
T/foobar" >
>> /dev/null &
>> +=C2=A0=C2=A0=C2=A0 pid=3D$!
>> +=C2=A0=C2=A0=C2=A0 wait
>> +=C2=A0=C2=A0=C2=A0 if [ $((pid % 3)) =3D=3D 0 ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0 fi
>> +done
>> +
>
> Same here. They can wrap into a helper.

In fact, we should recheck the way we handle the read on specific mirror
behavior.

For a lot of runs, btrfs/14[01] can take super long time (over 100s) to
really trigger the data read on expected mirror.

For a lot of runs, the read just got the same pid again and again.

Can't we at least add some noise at background to make the pid more random=
?

Thanks,
Qu
>
> Thanks, Anand
>
>> +_scratch_unmount
>> +
>> +echo "step 4......check if the repair works"
>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +
>> +_scratch_dev_pool_put
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
>> new file mode 100644
>> index 00000000..243d1e1d
>> --- /dev/null
>> +++ b/tests/btrfs/266.out
>> @@ -0,0 +1,109 @@
>> +QA output created by 266
>> +step 1......mkfs.btrfs
>> +wrote 131072/131072 bytes
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +step 2......corrupt file extent
>> +step 3......repair the bad copy
>> +step 4......check if the repair works
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +read 512/512 bytes
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +read 512/512 bytes
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +read 512/512 bytes
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>
