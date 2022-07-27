Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5255581F5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 07:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiG0FDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 01:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG0FDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 01:03:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A653ED69;
        Tue, 26 Jul 2022 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658898193;
        bh=ECv9ZN5TM/OgBkWQaSNcEhHO5zd6re0B4NGxzNs5nWw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hZEoWpfq2SdUf/6ZFumc6GZKhUZiYjj+tJyjOLbGWXs7taIRUduA77eGfM0HggO3j
         bpigbK7zKx71vSlmTeV4gWhmoeNWtUPIULVM/NHP3BnfU8HlJllOsyrU4Lz4ALE9PB
         0nhczOOIntqNtEqygFURlSh1AmETGAwkXGf6pxSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bfq-1nP4JS3D7m-01878h; Wed, 27
 Jul 2022 07:03:13 +0200
Message-ID: <8fe19e4b-11d2-d35f-5490-502db3b32da2@gmx.com>
Date:   Wed, 27 Jul 2022 13:03:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fstests: add test case to make sure btrfs can handle one
 corrupted device
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20220726062948.56315-1-wqu@suse.com>
 <20220727045736.pa46d55t67g7jwwl@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220727045736.pa46d55t67g7jwwl@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:coTCCV13btGqa4Hb5X1DyLYzKiJXTCUy5JYwKDWZMKVfkEY91Ym
 nzW1qB6BY5GNnYWlhHMlShY0f7MseFn5fAvShdeuudktgcV/q41id7Bs++np4g/nKIXuO2a
 4AUD5IMxv7qOaBkmBN0gWMDCIjqopeH9TZAJdtXqsrIMN+937Qo4bRwlYrjLSj9buoMXS3d
 pGHjbIXTI13pKRD0WmqIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ucU1dtw5Nds=:OAOxiSiiQn/sN9fyUjQsd6
 mQQg/pcMmUoEF2QLxPMnwtY2NeFCVozrgff/StCFJOrlggM0elh6vZQw+MepvFG+sjPK7Lr0I
 AzGN7yChK0VzTl8F2ogi9Cbx9HYAmyTu/UT5oxwXv/UgOk91f64sCiwJrc5uoEPae9I+rDBaY
 8xaF8cRWNW8Sxi4jseWAqmt5r5E7kSYd0SkM8o2MHQKcTSgbOvw8UZ5IuOAuBLbcTHS72gQqJ
 Rpc7315qeqb+9dAp0Oiy1kE5Jcen9H7MY50yTzAoSanySoysjmPQSVsDuLeArqESukIBkPBJP
 7x76eC2pb4cWXLHUErZXOBt/uZJ7yHFVOESsuvzcwFNzuLsyCFn8ZWhoPOo39jbkLR80ZG5Ar
 wS3z40MlNiaTBM9AB4HuRf4uu1AikjzctrRwcV7Fc5sSzFCYoDHSSE+gX0zxpQzfV5OeX2CSf
 q4pAa87u2fMdxV+BPFC82Ho7f+8N1mYNHBTP3YlaBV3XqRGeJjh1M/D+ZwIRsEUtXn0+kZIwh
 xf9LzXoXFmLYyGz+mzTsAPDM9pJ7g1oPUBy+CLJoqt989N77+xyDQlBa8inBB+t9my4k8Qwsn
 WtDeUf6MD3YzCQlrDs7kiltfrhW6QCuG384VlaLYG8vDA94zdRIa2sqp50a13F3T3WzxMIDdh
 EC2kEBJFCXKDJtFjVS+Br7euV0AGvTIYB3ua00Y+9L1fa6ixpY6/snnHFFyY7wWG6HVwE7h4A
 +KdL4+xdIAyrxEk2n5XJZ41wJ6WqcdttE+xhIlIiM4byRdpflyEypLdy5IvCa05Z3VYK7pZZT
 AaN2Idnzh6dybQBRWMZFExOC4NjNVYLS3JzcwzUKEIzpfd+aCsBrzjcJMqJJdwd9QoHOGhaAG
 JFdbloiu4ln6t/xmp31C3xwdmNfBWJ8jjhC10JGfrzyfg5a49WXiqwBxRLwX96/fP26PfkODE
 CRCrbo5W5HSb8/fwaD0jnf8FVq/yiHEkGc7+a0s1BZZXsUgfNt0Xe6+OhFOHWsqeBaI2nFUPo
 MHEs07HPrBVk5L6k+cn14/RUQuSBBVvak3tEIlt7HRdmgmx0ls0o2VuasT4JKZ4fSzCkDGEnD
 MbC+shaXfU1UaPwTgkv7XDHQA/Jw5EB6h5rRGPYsDJwVzqe2Pi4SyORVw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/27 12:57, Zorro Lang wrote:
> On Tue, Jul 26, 2022 at 02:29:48PM +0800, Qu Wenruo wrote:
>> The new test case will verify that btrfs can handle one corrupted devic=
e
>> without affecting the consistency of the filesystem.
>>
>> Unlike a missing device, one corrupted device can return garbage to the=
 fs,
>> thus btrfs has to utilize its data/metadata checksum to verify which
>> data is correct.
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
>
> Do you think about add it into auto group, or more groups?

Oh all my bad, was planning to add to auto later but forgot.

>
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
>
> If mkfs fails, below workload() will keep running, I think it's not what=
 you
> want, right?

Right, it should call _fail() instead.

>
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
>
> In common/config, we always set SCRATCH_DEV to the first of $SCRATCH_DEV=
_POOL,
> as below:
>
>          # a btrfs tester will set only SCRATCH_DEV_POOL, we will put fi=
rst of its dev
>          # to SCRATCH_DEV and rest to SCRATCH_DEV_POOL to maintain the b=
ackward compatibility
>          if [ ! -z "$SCRATCH_DEV_POOL" ]; then
>                  if [ ! -z "$SCRATCH_DEV" ]; then
>                          echo "common/config: Error: \$SCRATCH_DEV ($SCR=
ATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is s=
et"
>                          exit 1
>                  fi
>                  SCRATCH_DEV=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}=
'`
>
> is that help?

Thanks, then I can use SCRATCH_DEV directly.

>
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
>
> Do you need "_require_scratch_nocheck", if you corrupt the fs purposely?

I don't think we need that.

The point here is, we will immediately mount the fs and do a RW scrub,
which should make all devices good.

Thus if fsck after the test case found something wrong, it means the RW
scrub doesn't properly repair the fs.

Thanks for the review,
Qu

>
> But I think it won't check the SCRATCH_DEV currently, due to you even do=
n't use
> _require_scratch, and the _require_scratch_dev_pool might not trigger a =
fsck at
> the end of the testing.
>
> Hmm... I prefer having a "_require_scratch_nocheck", and you can use $SC=
RATCH_DEV
> to replace your "$target".
>
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
>
