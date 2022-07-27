Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8B581D43
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 03:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiG0Bj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiG0Bj5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 21:39:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B103AE6E;
        Tue, 26 Jul 2022 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658885990;
        bh=VnV2SSO7hnwHWE0Z78AyqLkArvoShSWDiyQAUeDO5fk=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=LSGdjf0CxWlXaHiQ3pmM5w4vnW4pYwhJX8BhgEN3YcXw1HGABIddXXcQdf6W82sd9
         vBIhqMxz2lKkcx3rxU5Np4Z/FDhzveHZH02FZ5+7wMdFVCo9lr8OgWr+EW/IqZ/0WK
         do0H4W1QYgNgt68+KzUZLApE8miSb37RLXAq8R3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3lYB-1oHKyM1kUF-000ws2; Wed, 27
 Jul 2022 03:39:50 +0200
Message-ID: <340382bc-6428-ffc3-1b1f-82d8408a5883@gmx.com>
Date:   Wed, 27 Jul 2022 09:39:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20220726062948.56315-1-wqu@suse.com> <YuB0RD9fx5nBnv2m@zen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fstests: add test case to make sure btrfs can handle one
 corrupted device
In-Reply-To: <YuB0RD9fx5nBnv2m@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eJIeN3U0gmEVvpeH3S+iFo8g9Pa1hUwZRBVUxO0sm4QWmtpAjIA
 g91uUvh2aFKyvvl1lUSAj5MOImE7ORukrP/iE31OnostBfnK5De/M+bmwQc6OtI8bP9rhoR
 2q7GfVE6ZIaU8yw99o6UyyJCJ2NNAocvv9qrQDv2gFnyzvHObdsdV/TmR+qVlOLQbrrouRE
 8TltFS7lN+x6vyBvA3Zqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PowdyAWdyNs=:8Naj20xaXy4pY+5DA9x+qv
 14XmkpcBI3LEcwpKtkm5jnBFhCyKJPAnaBU55Ucl2vQ+SazcrtXpAzJjbO3fYii+EQgmNjeEp
 cTCtfnr1a6admdaFtkW4xf8UlB72Lcu47LOWh7vQfFMvJhEr1SCTR56gYfO2QM8Rzj1vW9Ubf
 3DS56D8ffRwnPHJgrqslZHf4AxoeNfx2ZPCDfgUdyFCu9Ty/LsanX8nQCGxI9G0n080ywUTUP
 +FbgCLSzH5Hn2s494MMfLYRmOYrCPHEgsSaZPUywKbahxHeSd/j5sovtjKUsK/Q6T35mwItJJ
 VKmB2UoNif+/le03kEB6BDWpEU6KfLquB2wvrBHCFSjyC+DPrvSZjsIHLNnIku5+hS4chfqBA
 2Mzbg20MmIMRrmR4uLeHDbx9HaBEXTcsDEzWrEDCNX09Fb82vLsbMCM/AmPt+Ci1zwWVhiLj+
 5y6SD66QmcFr6re0YNDrgv0tPWXSDxiSe4AkqouwISRZkz6yQlONncQpamULMhabiFJWTpF/G
 PrqNsHh2tlEZEIAmV35bWr5ei1kSMfwvDM7iyA/7TpNU59Q2Bdo2OcaskkJDUFTp3WRn9wuGP
 zXjMJ9qAibboCB+2QTgm8zp/GlFvBGEdwP/LlrVbd8HULeESrj3A/eeb4BInznKQpqtETcxdb
 1JjPSm2+ZT15z397CE5r7mRHFJgIZ9jK8F3b1B8dCKiPYugGcvYVWCgi/1cEdcbwV1UtZsiJg
 fr3aQtmveGPY2Ssp4zq2q+pYO7kzv/p0mgnstjmnQMM3P5vg4Fc3MAkObwgDZn+MU9jEZKVwR
 2S05FT5Q7saGu6/89McoO4jBK0NpBAg+xc0KYD93plOjdCbcTUnqqyAKsreXSkG9lmV2tumcP
 nISBEwm8RCNAxtmQnE7iOE+Uw1lU5jH8+FMvQOuqgLX5FcUyZ9Ka2JessRL3/31M46+rEbYta
 F+Tw1APM5tKHoNQpdi446jMQg/JHYn08iAfz3AqhI1CdibFJj6wUcD9Ekj5eGOS1avOPwSq9c
 AnyjaAckRbdOWtDvOohtccKUMdy3iwvh5d8Gquu4L49LJ2ucL2OPhsJ4vVdWlTx5LilM0vN3N
 cRrr9k8BGH0y5GElOmDekpifK6P7qFUrESuZiF+FQLAq3ueG8hZvaDSXQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/27 07:09, Boris Burkov wrote:
> On Tue, Jul 26, 2022 at 02:29:48PM +0800, Qu Wenruo wrote:
>> The new test case will verify that btrfs can handle one corrupted devic=
e
>> without affecting the consistency of the filesystem.
>>
>> Unlike a missing device, one corrupted device can return garbage to the=
 fs,
>> thus btrfs has to utilize its data/metadata checksum to verify which
>> data is correct.
>
>>
>> The test case will:
>>
>> - Create a small fs
>>    Mostly to speedup the test
>>
>> - Fill the fs with a regular file
>>
>> - Use fsstress to create some contents
>>
>> - Save the fssum for later verification
>>
>> - Corrupt one device with garbage but keep the primary superblock
>>    untouched
>>
>> - Run fssum verification
>>
>> - Run scrub to fix the fs
>>
>> - Run scrub again to make sure the fs is fine
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Works for me, and looks like a nice test to complement btrfs/027.
> Reviewed-by: Boris Burkov <boris@bur.io>
>
>> ---
>>   tests/btrfs/261     | 94 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/261.out |  2 +
>>   2 files changed, 96 insertions(+)
>>   create mode 100755 tests/btrfs/261
>>   create mode 100644 tests/btrfs/261.out
>>
>> diff --git a/tests/btrfs/261 b/tests/btrfs/261
>> new file mode 100755
>> index 00000000..15218e28
>> --- /dev/null
>> +++ b/tests/btrfs/261
>> @@ -0,0 +1,94 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 261
>> +#
>> +# Make sure btrfs raid profiles can handling one corrupted device
>> +# without affecting the consistency of the fs.
>> +#
>> +. ./common/preamble
>> +_begin_fstest raid
>> +
>> +. ./common/filter
>> +. ./common/populate
>> +
>> +_supported_fs btrfs
>> +_require_scratch_dev_pool 4
>> +_require_fssum
>> +
>> +prepare_fs()
>> +{
>> +	local profile=3D$1
>> +
>> +	# We don't want too large fs which can take too long to populate
>> +	# And the extra redirection of stderr is to avoid the RAID56 warning
>> +	# message to polluate the golden output
>> +	_scratch_pool_mkfs -m $profile -d $profile -b 1G >> $seqres.full 2>&1
>> +	if [ $? -ne 0 ]; then
>> +		echo "mkfs $mkfs_opts failed"
>> +		return
>> +	fi
>> +
>> +	# Disable compression, as compressed read repair is known to have pro=
blems
>> +	_scratch_mount -o compress=3Dno
>> +
>> +	# Fill some part of the fs first
>> +	$XFS_IO_PROG -f -c "pwrite -S 0xfe 0 400M" $SCRATCH_MNT/garbage > /de=
v/null 2>&1
>> +
>> +	# Then use fsstress to generate some extra contents.
>> +	# Disable setattr related operations, as it may set NODATACOW which w=
ill
>> +	# not allow us to use btrfs checksum to verify the content.
>> +	$FSSTRESS_PROG -f setattr=3D0 -d $SCRATCH_MNT -w -n 3000 > /dev/null =
2>&1
>> +	sync
>> +
>> +	# Save the fssum of this fs
>> +	$FSSUM_PROG -A -f -w $tmp.saved_fssum $SCRATCH_MNT
>> +	$BTRFS_UTIL_PROG fi show $SCRATCH_MNT >> $seqres.full
>> +	_scratch_unmount
>> +}
>> +
>> +workload()
>> +{
>> +	local target=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>> +	local profile=3D$1
>> +	local num_devs=3D$2
>> +
>> +	_scratch_dev_pool_get $num_devs
>> +	echo "=3D=3D=3D Testing profile $profile =3D=3D=3D" >> $seqres.full
>> +	rm -f -- $tmp.saved_fssum
>> +	prepare_fs $profile
>> +
>> +	# Corrupt the target device, only keep the superblock.
>> +	$XFS_IO_PROG -c "pwrite 1M 1023M" $target > /dev/null 2>&1
>> +
>> +	_scratch_mount
>> +
>> +	# All content should be fine
>> +	$FSSUM_PROG -r $tmp.saved_fssum $SCRATCH_MNT > /dev/null
>> +
>> +	# Scrub to fix the fs, this is known to report various correctable
>> +	# errors
>> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
>> +
>> +	# Make sure above scrub fixed the fs
>> +	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
>> +	if [ $? -ne 0 ]; then
>> +		echo "scrub failed to fix the fs for profile $profile"
>> +	fi
>> +	_scratch_unmount
>> +	_scratch_dev_pool_put
>> +}
>> +
>> +workload raid1 2
>> +workload raid1c3 3
>> +workload raid1c4 4
>> +workload raid10 4
>> +workload raid5 3
>> +workload raid6 4
>
> Speaking of 027,
>
> Can you implement this with _btrfs_profile_configs?

In fact _btrfs_profile_configs() is what I went initially, but the
following factors prevent it from being used:

- No way to specify the number of devices
   That's not a big deal though.

- No way to skip unsupported profiles
   Like DUP/SINGLE can not meet the duplication requirement.


And since _btrfs_profiles_configs() directly provides the mkfs options,
it's not easy to just pick what we need.

Personally speaking, it would be much easier if we make
_btrfs_profiles_configs() to just return a profile, not full mkfs options.

>
> Further, you could imagine writing a more generic test that does:
> for raid in raids:
>          create-fs raid
>          screw-up disk(s)
>          check-condition

I have seen some helper in `common/populate`, but unfortunately it only
supports XFS and EXT4.

It may be a good idea to enhance that file though.

Thanks,
Qu

>
> and make 027 and this new one (and others?) special cases of that.
> I think this might fall under YAGNI.. Food for thought :)
>
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
>> new file mode 100644
>> index 00000000..679ddc0f
>> --- /dev/null
>> +++ b/tests/btrfs/261.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 261
>> +Silence is golden
>> --
>> 2.36.1
>>
