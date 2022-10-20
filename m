Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB139606BCD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 01:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJTW76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJTW74 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 18:59:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4D3AB37;
        Thu, 20 Oct 2022 15:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666306779;
        bh=rLUPxXtxPepPoIm5ghEV0d8Qlwtp5xZsBc2Qx3WYxno=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XS7npSAApxMgRHyOI9rThf+dine6hv5TfIUGWp0PVA0PH3tzhEXaU6a8T3K1AEMjO
         ld95jE9AMdYVqmCEptsIhEqFm3Qlt96pR7czGNrlopLtqANcc2jnL7cD4M28dHfAYP
         GCuj6JiZz8HkK7W69a1JOGVWqSCc8bPa/gCcmfgI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1pBsVe3x0C-00zpK3; Fri, 21
 Oct 2022 00:59:39 +0200
Message-ID: <04a92673-9721-1a6c-6693-efb24aef5f90@gmx.com>
Date:   Fri, 21 Oct 2022 06:59:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] generic: check if one fs can detect damage at/after fs
 thaw
To:     Zorro Lang <zlang@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20221019052955.30484-1-wqu@suse.com>
 <20221020150019.jp65m3kejbhds6mf@zlang-mailbox>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221020150019.jp65m3kejbhds6mf@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0CXnnAqE2Ie3fuTIIXa2xW/9ku7BvEbA5c8IsuE8ai5XFqbrNd8
 SwmTyWScbeMlhbPfdTCaZyKCdjsxE4irVHY8/tsuv0qBTIhQcPoeYDoZQH2gomCxf4Up9n7
 jxw6Assfb5iRBt1QUS8/FJjpJUWdF+ykYzBz0yAcJrnWOwebQ6M8zeka0cpJCFzWhgaglU6
 KJw4CdxEDJyMUE+RA9MgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f4B7zVk1nOs=:JA3yu0Y8xmwWakEuXi3JH1
 GVqeYOWXmEflZoDobFPahcJCauOie/3roDTG8i9qpAwTithYsFGtV6r5SuP3Ky/ftW9UMGXVA
 l8VnWqCAKaGaFxhi1/UaKdSKe4MvOANvpbnvty8RRW7ZffPxIc3eeW6cpuasItkZwdmRWu2WY
 DnCyjlbx9ybsnuPEPvM2kfr1paJCDElvVza49aofWV+2XvAXRd0KxobSDzvOJefjyYJw27dQO
 U/wN+8I6Q9J6qN9I595fF8t82Gi9bYkgAWxGQiHxlDjtIfoco98Omk66bL2TDW9Rcauf8b3j7
 Krr+3jOLUbewIQuH6uqddkiTEkRwwu4RK5F5QItahD1mvO81gOoaRT9QsJ24GCV2xyHitogAT
 Zjz930zG7AXR9ZMCXSHIcbpQOitE/FiboH4VsmEKAUsBQ5Kd2rwlQdTE42dcK9IEe132aj7Bk
 sNTjv6q799oj1oY6bdVIZw1vLacwfKki+lx2HAWPo2Y/mPtDrLR96gMYOiJ2bRT0Pdkne+oAp
 R2W7gBvqiVmV1rkusaS1m/YGImaGSP7id03X3hAv82JezyMrL+d3u4de/2ScB5AjMfLgDTe1i
 LDzjM/SOR/VTxDOrIAW8+p9dPDRbt0rRkSCNLveKidlcO+Ja9Vc1ePXTxuh6MoVS+X+sI52UO
 cRtYRH96DXZY4FQhoM+2MBpnwYjFG2IoIHNsLx69oiFeK6NkT3D725yBraV2uF4fiSZnp9Bo3
 OdrHv/eCBR4b/OXzGvoAGQDl0PkdeUDqMTASEu8zvurufqwJsriOdeHgSIXsmkUWqS1cfWxIe
 z/72UfC4NTbzgNWQLe+5nlN0mTd6FMBEHUsvZVcewdwyzGoPSHe8DWnll1/R3hoRyKJDQmf5H
 yHAxJN1OfmNZrSnGLvhgculbf9EqHrHArrqEeCJ6Ef3hYPHg4uDiXefJInF+Bm1pXTKSJXTDM
 67+3c9bRLwik9WbUPzrQeU2IZYvNIlC6gXXBvQqerFhPA0P9NgmB6DhFnEoLJBouaTMQB8HJD
 qxCW1iNi1iHoPQjSINHoruKBWw4QGXIaH0mC+gPs1z1Qv4Aguz6lOg2Q6xc9eVl92zcnx+vw9
 +MlSn/3+6ezWcw/x2fQqYwzHweuX0AXKn66NagTJNBW5oH0CFTZNgX+Po8AVfztA2PjndW9RR
 JOeEG/DXphAxkBv4oqdQTpbuWklAtbMknWPEJlxPqnMK6vqThV21iHxjrOBtVAiWZuL0ooz4P
 j5BzU7W/LvoB3ELEOaHUJIk7I3xJkPhg759ynKbq5OltLHbFIio5HJagw9D3jBwJkattYx+og
 TSCpstliQ9PXLOlzRs8MVfOuUtgYsii7FksaQ/Qh8UfuiXUCWZbm+xSwxuV+2GrzXO/0EMdtF
 DxEGJYRDIClM52amgOIePefXulNasvnYOPczZX8cMVydZJZ+VEY1a0QSO9FimV6CVOSWtzeFz
 JMjArcGtXQejRIQn9TuL15rV1Up4Zf7nNAz/uEsCP3iPS8yWQoPLqJ+DvUrsekVqR0OTyHYQq
 EmBW6gUDZGkdU9GHK2ax/hX4JLHN7fnmny42/H8cqNFlp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/20 23:00, Zorro Lang wrote:
> On Wed, Oct 19, 2022 at 01:29:55PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> There is bug report from btrfs mailing list that, hiberation can allow
>> one to modify the frozen filesystem unexpectedly (using another OS).
>> (https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e=
34@bluemole.com/)
>>
>> Later btrfs adds the check to make sure the fs is not changed
>> unexpectedly, to prevent corruption from happening.
>>
>> [TESTCASE]
>> Here the new test case will create a basic filesystem, fill it with
>> something by using fsstress, then sync the fs, and finally freeze the f=
s.
>>
>> Then corrupt the whole fs by overwriting the block device with 0xcd
>> (default seed from xfs_io pwrite command).
>>
>> Finally we thaw the fs, and try if we can create a new file.
>>
>> for EXT4, it will detect the corruption at touch time, causing -EUCLEAN=
.
>>
>> For Btrfs, it will detect the corruption at thaw time, marking the
>> fs RO immediately, and later touch will return -EROFS.
>>
>> For XFS, it will detect the corruption at touch time, return -EUCLEAN.
>> (Without the cache drop, XFS seems to be very happy using the cache inf=
o
>> to do the work without any error though.)
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/generic/702     | 61 ++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/generic/702.out |  2 ++
>>   2 files changed, 63 insertions(+)
>>   create mode 100755 tests/generic/702
>>   create mode 100644 tests/generic/702.out
>>
>> diff --git a/tests/generic/702 b/tests/generic/702
>> new file mode 100755
>> index 00000000..fc3624e1
>> --- /dev/null
>> +++ b/tests/generic/702
>> @@ -0,0 +1,61 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 702
>> +#
>> +# Test if the filesystem can detect the underlying disk has changed at
>> +# thaw time.
>> +#
>> +. ./common/preamble
>> +. ./common/filter
>> +_begin_fstest freeze quick
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_fixed_by_kernel_commit a05d3c915314 \
>> +	"btrfs: check superblock to ensure the fs was not modified at thaw ti=
me"
>> +
>> +# We will corrupt the device completely, thus should not check it afte=
r the test.
>> +_require_scratch_nocheck
>> +_require_freeze
>> +
>> +# Limit the fs to 512M so we won't waste too much time screwing it up =
later.
>> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +# Populate the fs with something.
>> +$FSSTRESS_PROG -n 500 -d $SCRATCH_MNT >> $seqres.full
>> +
>> +# Sync to make sure no dirty journal
>> +sync
>> +
>> +# Drop all cache, so later write will need to read from disk, increasi=
ng
>> +# the chance of detecting the corruption.
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +$XFS_IO_PROG -x -c "freeze" $SCRATCH_MNT
>> +
>> +# Now screw up the block device
>> +$XFS_IO_PROG -f -c "pwrite 0 512M" -c sync $SCRATCH_DEV >> $seqres.ful=
l
>> +
>> +# Thaw the fs, it may or may not report error, we will check it manual=
ly later.
>> +$XFS_IO_PROG -x -c "thaw" $SCRATCH_MNT
>> +
>> +# If the fs detects something wrong, it should trigger error now.
>> +# We don't use the error message as golden output, as btrfs and ext4 u=
se
>> +# different error number for different reasons.
>> +# (btrfs detects the change immediately at thaw time and mark the fs R=
O, thus
>> +#  touch returns -EROFS, while ext4 detects the change at journal writ=
e time,
>> +#  returning -EUCLEAN).
>> +touch $SCRATCH_MNT/foobar >>$seqres.full 2>&1
>> +if [ $? -eq 0 ]; then
>> +	echo "Failed to detect corrupted fs"
>> +else
>> +	echo "Detected corrupted fs (expected)"
>> +fi
>
> Thanks for all help to review!
>
> That `_require_freeze` will skip exfat and others which not support free=
ze.
>
> And `_require_block_device $SCRATCH_DEV` helps you to avoid this test ru=
n/fail on
> overlayfs, nfs, tmpfs, etc. Due to you try to write the $SCRATCH_DEV dir=
ectly.
>
> And you can use `_supported_fs ^f2fs` to skip this test from some specif=
ied fs
> if they're not suit for this test.
>
> But I'm wondering if the last test step will fail on every fs soon? Exce=
pt
> you're trying to test how fast a fs can find itself is corrupted. Or how
> about give some fs more chance/time to detect errors? Likes do more oper=
ations
> which enough to trigger errors on most fs?

I don't think any timeout/extra work would help, there is already a drop
cache to make sure the fs won't have any cached info.

Or fs like old btrfs or XFS can easily continue without any problem by
using all the cached info.

And without cached info, any write should cause the fs to read its
metadata and detect the problem.

Thanks,
Qu

>
> Thanks,
> Zorro
>
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/generic/702.out b/tests/generic/702.out
>> new file mode 100644
>> index 00000000..c29311ff
>> --- /dev/null
>> +++ b/tests/generic/702.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 702
>> +Detected corrupted fs (expected)
>> --
>> 2.38.0
>>
