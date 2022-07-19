Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE89357925D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 07:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiGSFRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 01:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSFRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 01:17:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A76FAE53;
        Mon, 18 Jul 2022 22:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658207820;
        bh=Y3SpJE509KOHwh7EzCI2eMwF0j4vjP5ZrRSkwtDzjAc=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=acoYDx2Hyivs5QVk+MUrvBSXir19DZjJmvsivb3rtNS8cp3BIT76g/jPpjKZuz9vK
         NwaTWvRSmSVTE3UWaUFnxj1FQVkzASFhh6j0Eh/at90SR83xAUhf/ySoMS2xRPQC1I
         lyeajs6z4SWDBlXZE0jC83n9I9vAoYj5olRFVf3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89L1-1o8yds1JJr-005E6D; Tue, 19
 Jul 2022 07:16:59 +0200
Message-ID: <b8d80f54-1a0e-54eb-3bc2-8b07cbd7edf6@gmx.com>
Date:   Tue, 19 Jul 2022 13:16:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220718061823.26147-1-wqu@suse.com>
 <20220718175912.5mhc7hhkysgadvqd@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] fstests: btrfs: add a tests case to make sure btrfs
 can handle certain interleaved free space correctly
In-Reply-To: <20220718175912.5mhc7hhkysgadvqd@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:55WdjYopg8hbSTusXXIqE+myQHjmAKNPxbwf0do4ZT7FI9IwXqV
 wLo5VKd7OfZ6VydjEBLRUNx5rXFOsxzn6sf8EHNX//5bVUJhPyVqgxD8NFy1sYhmC2zIMh1
 fO6l/fhH0A3G+J/x0M+pyWoqVL7mvMWTiU6JJyqgG4lt/1wAzP9z3NPG7dumVgoH2AB7+S5
 Si74IED/uuP8hCLJg1Z/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RZHJxaf4mpA=:fk94oxQTSzSyXIAg7B5+i1
 BQeG/KDECIoLKhS9zXcpFsZj9ETFKIe4QiTllzYcKf50VTz+WsnHIhEqtFziGrmA457ViViyp
 PFaWco5s2GjpJG0xJp0hGuTGuG/LfgY1XbCoq5tiiMMNq5a48Jy6M1KeBgHMOmwnlucPVUNPo
 JvkUZQ9uzGYAIS0QMex/3vwGlRIksnv30OZs7puLgBgeY12GBn38RRMq2qKopKzzKhU6cmgjG
 nMD8GKYHpW7w/2jg0SSEyzDqcYvhSg/zviHuxDXsefTmWqt9O33lUvaWLW2HUCG31rOZP3wjX
 i6lh5jKbGQb5kZZSda5y1toRS14myykEfDQTPrN3WbAUbYxn1xwy0EQ/cLBE86wnknTnn65Xm
 ATrRZYQd+uLl85llxbEYIlgKrH98UHnr9DlA6a6TxUdrRoPmpMXXqT/gwwK7q/K6EueYaWbXP
 3MJmU70jihOLYlfnQrbNVUZba8lbF8kmkA82soJbj6fD9bhVEtNLXxoE4KKaewGGnt1JHUi9d
 u97Zgd88UASGDTkqgeZCWbmF/efcmqwe2oiU7QVjxp8kVU4SOj65e9BnYWGxkIm+bUPgLQFVv
 f+9CngZVGhHv44xiPBbSVZUa6fwVG2MX6IwKC44KtgjOfty0do1++veEnwJRZXnqAcBzONvpn
 YWGcyIz/mgMmlDuZUPAdxjX0KVUsiVi4qqrjM5ts5ceMziQX+XcWQTjjv6/uPH5k3fTu7vXYx
 goT5RQJo9CzWygbcFr/e2dWdp2JurfFyz/EeStmATVuTOQ6PG107R/aNB8A8Nyz3KY33w/5qL
 qfkLodQnH6X65uvW5ipJHLPptakTOnr1m2RlTn7qeVGx3SjoyuOGY5B17m1WHH68NqDdl3ezn
 DcMQI+bL4SMtB2GQZk7NXcV9//97k8RLfaB0CR3FUSvN/y2doGE9jaYWPDef3QP+fVJLlM0Mk
 5g5/pIOpe6nt0m6f4uCCQV9yHYOZF9jGiCO67HSKJXabtCMoRcrI4QfV5Ohs/YyI1ggV5fiSs
 pEYP9gylx3EPkG1ZoA5Zh8MzhDh0+J//hIHLcXFQ2W2YA6MS4o9HDsl3V5tgZCsJBwtYX8OIf
 9h0q8txLNCpOptXyO6socO5BRGxkoRXdeZg5biE6nfLMF5465y7NFT+QQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/19 01:59, Zorro Lang wrote:
> On Mon, Jul 18, 2022 at 02:18:23PM +0800, Qu Wenruo wrote:
>> This is a future-proof test mostly for future zoned raid-stripe-tree
>> (RST) and P/Q COW based RAID56 implementation.
>>
>> Unlike regular devices, zoned device can not do overwrite without
>> resetting (reclaim) a whole zone.
>>
>> And for the RST and P/Q COW based RAID56, the idea is to CoW the parity
>> stripe to other location.
>>
>> But all above behaviors introduce some limitation, if we fill the fs,
>> then free half of the space interleaved.
>>
>> - For basic zoned btrfs (aka SINGLE profile for now)
>>    Normally this means we have no free space at all.
>>
>>    Thankfully zoned btrfs has GC and reserved zones to reclaim those
>>    half filled zones.
>>    In theory we should be able to do new writes.
>>
>> - For future RST with P/Q CoW for RAID56, on non-zoned device.
>>    This is more complex, in this case, we should have the following
>>    full stripe layout for every full stripe:
>>            0                           64K
>>    Disk A  |XXXXXXXXXXXXXXXXXXXXXXXXXXX| (Data 1)
>>    Disk B  |                           | (Data 2)
>>    Disk C  |XXXXXXXXXXXXXXXXXXXXXXXXXXX| (P stripe)
>>
>>    Although in theory we can write into Disk B, but we have to find
>>    a free space for the new Parity.
>>
>>    But all other full stripe are like this, which means we're deadlocki=
ng
>>    to find a pure free space without sub-stripe writing.
>>
>>    This means, even for non-zoned btrfs, we still need GC and reserved
>>    space to handle P/Q CoW properly.
>>
>> Another thing specific to this test case is, to reduce the runtime, I
>> use 256M as the mkfs size for each device.
>> (A full run with KASAN enabled kernel already takes over 700 seconds)
>>
>> So far this can only works for non-zoned disks, as 256M is too small fo=
r
>> zoned devices to have enough zones.
>>
>> Thus need extra advice from zoned device guys.
>>
>> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>
> I think this patch need more review from btrfs list. I just review this =
patch
> from fstests side as below ...
>
>>   tests/btrfs/261     | 129 +++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/261.out |   2 +
>>   2 files changed, 131 insertions(+)
>>   create mode 100755 tests/btrfs/261
>>   create mode 100644 tests/btrfs/261.out
>>
>> diff --git a/tests/btrfs/261 b/tests/btrfs/261
>> new file mode 100755
>> index 00000000..01da4759
>> --- /dev/null
>> +++ b/tests/btrfs/261
>> @@ -0,0 +1,129 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 261
>> +#
>> +# Make sure all supported profiles (including future zoned RAID56) hav=
e proper
>> +# way to handle fs with interleaved filled space, and can still write =
data
>> +# into the fs.
>> +#
>> +# This is mostly inspired by some discussion on P/Q COW for RAID56, ev=
en for
>> +# regular devices, this can be problematic if we fill the fs then dele=
te
>> +# half of the extents interleavedly. Without proper GC and extra reser=
ved
>> +# space, such CoW P/Q way should run out of space (even one data strip=
e is
>> +# free, there is no place to CoW its P/Q).
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto enospc raid
>> +
>> +# Override the default cleanup function.
>> +# _cleanup()
>> +# {
>> +# 	cd /
>> +# 	rm -r -f $tmp.*
>> +# }
>
> This _cleanup looks like nothing special, you can remove it, to use the =
default
> one.

It's still commented out, just from the template.

Or you mean I should delete the unused cleanup function if we don't need?

>
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>       ^^^
>     Remove this line please.
>
>> +_supported_fs btrfs
>> +# we check scratch dev after each loop
>> +_require_scratch_nocheck
>> +_require_scratch_dev_pool 4
>> +
>> +fill_fs()
>
> There's a help named _fill_fs() in common/populate file. I'm not sure if=
 there
> are special things in your fill_fs function, better to check if our comm=
on
> helper can help you?

The fill fs here is to make sure we fill the fs in a specific way
(always fill the fs using 128KiB, while still being able to delete 64KiB).

I'll add a comment for the reason.

>
>> +{
>> +	for (( i =3D 0;; i +=3D 2 )); do
>> +		$XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/file_$i \
>> +			&> /dev/null
>> +		if [ $? -ne 0 ]; then
>> +			break
>> +		fi
>> +		$XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/file_$(($i + 1)) \
>> +			&> /dev/null
>> +		if [ $? -ne 0 ]; then
>> +			break
>> +		fi
>> +
>> +		# Only sync after data 1M writes.
>> +		if [ $(( $i % 8)) -eq 0 ]; then
>> +			sync
>> +		fi
>> +	done
>> +
>> +	# Sync what hasn't yet synced.
>> +	sync
>> +
>> +	echo "fs filled with $i full stripe write" >> $seqres.full
>> +
>> +	# Delete half of the files created above, which should leave
>> +	# the fs half empty. For RAID56 this would leave all of its full
>> +	# stripes to be have one full data stripe, one free data stripe,
>> +	# and one P/Q stripe still in use.
>> +	rm -rf -- $SCRATCH_MNT/file_*[02468]
>> +
>> +	# Sync to make sure above deleted files really got freed.
>> +	sync
>> +}
>> +
>> +run_test()
>> +{
>> +	local profile=3D$1
>> +	local nr_dev=3D$2
>> +
>> +	echo "=3D=3D=3D profile=3D$profile nr_dev=3D$nr_dev =3D=3D=3D" >> $se=
qres.full
>> +	_scratch_dev_pool_get $nr_dev
>> +	# -b is for each device.
>> +	# Here we use 256M to reduce the runtime.
>> +	_scratch_pool_mkfs -b 256M -m$profile -d$profile >>$seqres.full 2>&1
>
> Do you need to make sure this mkfs successed at here?

Yes.

>
>> +	# make sure we created btrfs with desired options
>> +	if [ $? -ne 0 ]; then
>> +		echo "mkfs $mkfs_opts failed"
>> +		return
>> +	fi
>> +	_scratch_mount >>$seqres.full 2>&1
>
> If _scratch_mount fails, the testing will exit directly. So generally we=
 don't
> need to fill out stdout/stderr. Or you actually want to use _try_scratch=
_mount
> at here?

_scratch_mount is exactly what I need, I'll just remove the unnecessary
redirection.

>
>> +
>> +	fill_fs
>> +
>> +	# Now try to write 4M data, with the fs half empty we should be
>> +	# able to do that.
>> +	# For zoned devices, this will test if the GC and reserved zones
>> +	# can handle such cases properly.
>> +	$XFS_IO_PROG -f -c "pwrite 0 4M" -c sync $SCRATCH_MNT/final_write \
>> +		>> $seqres.full 2>&1
>> +	if [ $? -ne 0 ]; then
>> +		echo "The final write failed"
>> +	fi
>> +
>> +	_scratch_unmount
>> +	# we called _require_scratch_nocheck instead of _require_scratch
>> +	# do check after test for each profile config
>> +	_check_scratch_fs
>> +	echo  >> $seqres.full
>> +	_scratch_dev_pool_put
>> +}
>> +
>> +# Here we don't use _btrfs_profile_configs as that doesn't include
>> +# the number of devices, but for full stripe writes for RAID56, we
>> +# need to ensure nr_data must be 2, so here we manually specify
>> +# the profile and number of devices.
>> +run_test "single" "1"
>> +
>> +# Zoned only support
>> +if _scratch_btrfs_is_zoned; then
>> +	exit
>
> I think this "exit" will fail this test directly, due to status=3D1 curr=
ectly.
> You can use _require_non_zoned_device() to run this case for non-zoned d=
evice
> only. Or
>
>    if ! _scratch_btrfs_is_zoned;then
> 	run_test "raid0" "2"
> 	run_test "raid1" "2"
> 	run_test "raid10" "4"
> 	run_test "raid5" "3"
> 	run_test "raid6" "4"
>    fi
>
> As this case is "Silence is golden".
>
> I'm not sure what do you really need at here, can these help?

My bad, I forgot to finish the comment, and your example is perfect.

Thanks for the review.
Qu

>
> Thanks,
> Zorro
>
>> +fi
>> +
>> +run_test "raid0" "2"
>> +run_test "raid1" "2"
>> +run_test "raid10" "4"
>> +run_test "raid5" "3"
>> +run_test "raid6" "4"
>> +
>> +echo "Silence is golden"
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
