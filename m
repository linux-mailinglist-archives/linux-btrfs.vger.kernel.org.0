Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3918A60537A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJSWyV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 18:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiJSWx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 18:53:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4C1D1E35;
        Wed, 19 Oct 2022 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666219961;
        bh=3zPbvi2JaWHjL4Ht9k3NX4dbEvEUkWos/YMCB52jdZE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ET3kVk3uSGYGFqJO4B8aX3yp337TfQDwuQY6meUfOv2XBfciauQf5KQCD0Xerztxu
         xF1AsJaznqEAIH0ppOF7QzCc7dbzSRdRUqtvSLZSyHcatH/gSC31wY4UGsW66WDm2z
         EM0AvHT/coU/cZVBkmATukt3ZX50LBl/bMMOtopw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXGrE-1obnsM1p30-00Yhne; Thu, 20
 Oct 2022 00:52:41 +0200
Message-ID: <cb39519d-8e31-5f39-71fe-ebb0a886780e@gmx.com>
Date:   Thu, 20 Oct 2022 06:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] generic: check if one fs can detect damage at/after fs
 thaw
To:     "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221019052955.30484-1-wqu@suse.com> <Y1AZl3o+iSqNZgMw@magnolia>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y1AZl3o+iSqNZgMw@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QFz5v/Dh2NB9pyRQ8qfgpQ+4Z6tLK0ldZj+p5t9kGB7t9ckc/KW
 6sGX4um3CvobAdFVdVy7MrSKaKP6Y+01DUkmIKDS78OqK0WDqwx8otfHw/ks/j04fmqMdMT
 yf3MaagrOYk3DaXkPKMBjC0mkvJVSU7hSCVa3SjOGzp42ik5g7sPDWuBz9Vn3qYQLxxSHrM
 C1CNOf27HQzW4lpUBYvZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7gP2n14rL9k=:wPEdSVPl/soWl74GcRVEp9
 bEWSpDu+vfqgdDMwc9eqDvSrXMD52kN1jkq/31Lqgo482HPOjd2VM2aQsLjKtLUJ02kfnI8nh
 OGpM0l/vssDuTVhfpyfvP/ZoO/OZDBgrmI18VghvsR7vLlnivf14llLQXEaxMcHgY0T9FF52+
 bB5dRCwQp6ErHINMAGdstU3qmwws4EHQk9apY1T86dZD2qiOqOrwC9bbDnr5lZb/eC14oYdZY
 zfNbtFIOCszfnKed47ws/6keNFxaCg38dO0hPKgWjjRgR64R529VEnPE0797yXirlvnlf9k9d
 T7q3u/tLq8/WB98zRIqiFzdK2oAbRXsCFWRgWRMa+zetBciBfAy3L5/e54xLqH89O0KYqj9iH
 UgDRBCI+0xUAmtSmW9kT3ZeVkcq9m9czBjgU1apAy2xztF8Ng40kUG0VD5xVjQX6EjkjbhnAb
 zasI6Pf9h/nbpliMTyObiuyUBCXEFKShtNNXdhOpSofnLR6aA9hy1hivakwDYtCqf7wdBUwoq
 D+jnymZm3lMfE/l6kXWPp9JUAVN74nft97OGp1ZGwKwykw4cWubnFSMFwYBpfdURI/DmaZs0Q
 LlmyyL/mu/BlsFXn7RH6CQNAZQEMXumw65IsBF62gIH6HU8jNVJx4kri+BvgYs6gFjndxv0Vq
 4tC1cmFAGl1brdpFgTnThzXDVUGvQcbJgisIuDHU4egqSjEJuXKHeB2rs37ZOZNYThKwipE0c
 bUa6T9s+m77efk65PL6wA+M0LxFkMAqQ1++VN9iXqalJCm/yof0Xwr47FrAWSA6BJzO32LKVT
 IxpvEmvcKRNcd3tHcBE0nk7ZhlUVI+6Z7rCsb8C7Gr8R7bpXVMvngdvOOGzV8TBFDcYUQXurD
 eTFbuwtk8XhfgWMsClrC3Ac0NjAbfgGqkuk9J1a+wzRaD7lM4VSZcRKpBETX793cpu/HpxMEt
 IDRvtMv4gCe5a0H5M7e4rBwInT5qPqeMK2dtXcKpanzusaVGyPRx7xjYfmljsn1pLY9+QT0rX
 IS0bFAzkGbIk4ZJKqOqthIJItE3yu/jwj4CnBhT5bJo33/O5UWSlfkieFoAFAhm6K6ZFLfgTd
 HITyyKBSto9KztKMRBNJp2Gy69T/i5LsxXOfYCptPNj3qEWHXDwgkaWtP/KSrT2SXDaV7U0zK
 FhQcK4af+1JRj6JJZbU3o5iJFrSRdrNBoWkdesl2NQocqKz+AdB5u9FMGCpde4WqFlD20CwFC
 SFNMI5zS9SPSPAfBwXWqjZj9AOZ8RtBsraEv2Qh0jlyGUPb7IaHhJQaJVbQqA47uz3IEH25jh
 LsBa2a8rDqWuSwGgrLo3jcSbIdnETycy9MWo3Ci8dngS/D21GtQ8zKx43QPobZneNG3FRERqo
 B7SbLUYd1GFxtWmMbQ2L5ziqqWqIEkVFOUiKDPI2+F6+Hm1PD5QF5UDoT5VejbQyrQlTzzOrC
 6UQm7IyCW3il7Kw3pFA6YiUW/qiCkcq+PUra8//2MntK4hiHrcc3HOkR7Zd1GPRxpFZCcBI7t
 7zy7id7nEJaj+UtzsCkH9wJ/eTtztx+GOdxLtYDpUT2gR
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/19 23:36, Darrick J. Wong wrote:
> On Wed, Oct 19, 2022 at 01:29:55PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> There is bug report from btrfs mailing list that, hiberation can allow
>
> "hibernation".
>
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
>
> Heh, yikes.  That's pretty scary for ext4 since it still uses buffer
> heads from the block device to read/store metadata and older kernels are
> known to have crashing problems if (say) the feature bits in the primary
> superblock get changed.
>
> I wonder if this should force errors=3Dremount-ro for ext4 since
> errors=3Dcontinue is dangerous and erorrs=3Dpanic will crash the test
> machine.
>
>> For Btrfs, it will detect the corruption at thaw time, marking the
>> fs RO immediately, and later touch will return -EROFS.
>
> What /does/ btrfs check, specifically?

- Read sb without using cache

- The same mount time sanity checks on the superblock
   Which already implies an fsid check.

- Extra generation check
   To make sure no one has touched out cake.

>  Reading this makes me wonder if
> xfs shouldn't re-read its primary super on thaw to check that nobody ran
> us over with a backhoe, though that wouldn't help us in the hibernation
> case.  (Or does it?  Is userspace/systemd finally smart enough to freeze
> filesystems?)

I doubt if userspace/systemd is that smart, because the error report is
running not-that-old distro.

Especially for hibernation there is really no way for anyone to know if
our cakes are touched.

>
>> For XFS, it will detect the corruption at touch time, return -EUCLEAN.
>> (Without the cache drop, XFS seems to be very happy using the cache inf=
o
>> to do the work without any error though.)
>
> Yep.
>
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
>
> Hmmm, it's not very useful for a test failure on (say) xfs spitting
> out a message about how this "may" get fixed with a btrfs patch.  How
> about:
>
> $FSTYP =3D btrfs && _fixed_by_kernel_commit a05d3c915314 \
> 	"btrfs: check superbloc..."

That sounds pretty good.

>
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
>
> directio and a larger buffer size to speed this up? e.g.
>
> $XFS_IO_PROG -d -c 'pwrite -b 1m 0 512M' -c sync $SCRATCH_DEV

I guess no need for directio especially we're doing a sync after the write=
.
Although larger blocksize may only help a little considering by default
it's already buffered write.

>
>> +
>> +# Thaw the fs, it may or may not report error, we will check it manual=
ly later.
>> +$XFS_IO_PROG -x -c "thaw" $SCRATCH_MNT
>
> I'm a little surprised you don't check for btrfs returning an error
> here...?

Great you have asked!

This is the special pitfall related to thaw error handling.

If we return an error for .unfreeze_fs hook, the VFS treats it as we
failed to thaw the fs, and will still consider the fs frozen.

Thus for now, btrfs only output error message into dmesg during thaw,
but always return 0 to workaround it.

We may want a better way for .unfreeze_fs hook to distinguish between
"something really went wrong, but please consider it unfreezed" and
"nope, please keep it frozen".

Thanks,
Qu

>
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
> But otherwise this test looks reasonable so far.
>
> --D
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
