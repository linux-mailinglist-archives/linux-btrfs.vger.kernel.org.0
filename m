Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCADE3E2A71
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbhHFMPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 08:15:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:45229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343646AbhHFMPn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Aug 2021 08:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628252126;
        bh=9hq2jaSkj+EGen58CEpicWyEhH6Rz7lv/r1kVoHXO9s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Vi6D0Uhu8LUM1FcpBp8w8JWSlGN13ECPsbMiP9tmjK90VnJx7Y4ZRmmj84F7egjP8
         FQoFGVMOV2VbN60Nx9T4lG6fIE0bORKnFZC/te7QJmJQetSb+5QXvAMvuIynKgghx8
         g84NUNW+NXuIeRvkYSr0SXTCBRk8JuLyzJgfHnGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1mIYL7190C-00B4aK; Fri, 06
 Aug 2021 14:15:25 +0200
Subject: Re: [PATCH v2] fstests: btrfs/244: add test case to verify the
 behavior of deleting non-existing device
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20210806113333.328261-1-wqu@suse.com>
 <5547039c-2989-e9d7-6126-15877758b3f0@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2760b7ed-d216-1d5c-e73d-1569ac4c702d@gmx.com>
Date:   Fri, 6 Aug 2021 20:15:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5547039c-2989-e9d7-6126-15877758b3f0@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D8Ec7M62ZFgH7+h0DrAeqP1C5KTyg9Std2l4J8qE9NS2a26zrUQ
 Zi3q4Z8/wie8yExzK1XDEAJC2QFY+oFwiljFYSKWGa+VGuCstyjqNNM8McGzgPdL3Ej7r/4
 c/Wxbuz1aMDYcZ3A+OkcEn2bjdjZAfYd2QX9K+KKF59/Tw4pynJONLlCzmvNHMOJJpoC5In
 yGT8D/W7mM/aTuRxMfMfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C4YvHmS6z18=:hChThROdBWljpT9pApMIUG
 rEfiBtdRqvlWUZeXFnyCXlencVzC2NmtfnNx2ntYvqFVvCPIOKl3HGAU9z/f4K0pNFvxRlaXy
 NVNHGD2k7rXHYyoYTS51ZSIeteeTsuJrRpGct8F014xF7YFrgdfyQnnzgGDJ3Pqhskyta+v5L
 j1noxFgVOTKtvAsZYWlgNNptA4g/pzMA7wIY+5vXdl2jFTb4csm0lDIJNQd1topq9nsTjAXsq
 Ht6O4DyeX1+U/IjPQT+32pKW8EnCnk0IFXH+K9n2EAvXUW6d0yDyDAZeoXW0iFnl9wefPVtxC
 saGmIxYVVjzSyd2aiTQ6Ohtq8WyES17AJZxZF2vT1TZAThFF0q331bBnJ4FEiBdzxtCccqMVe
 Li4ifaWuOsbAj6mBPESqgjcIUmbSfKGEjxjAmKZXUAm6PFvJgAScCxr2EnC5u7aF/Wr0JkAz2
 OD4wbBTmveUKZQXRsDhEzfWz/vU518LHmBzO7HtJvwa3TIqZldridxyxrl0WtrziLitTTMvjf
 4wKtFJrdjf6fEpMealtUQSmE5w+3B1vh2uwuVpRn4orMFIE9ip8ENhAgCOaCy4AnL4i8GfhwK
 yw//UDrqYEHjgp6/1i26SB7jqbJRk+j8HxzTpN+K64qh0JaiEMppUpvI0+6r4EmKe+MSQ1eEX
 bVcLWi8adAesrBV9VsWC41Oxbn78diafZvCjUaO8JGqikZZXcQV3gEAdbO84Bbw6tfstfnM7m
 gNn18rW6TE158ltJC5JWg8bZiScx+m4IgVVZA9gXet86Ub5UKpyH/c/vLbxeMlQaVa0Sjbwoc
 CNjFH8bORo/94cN6H4hqFEtE2/ZdkiQeD+Y9Oo1iv301TAtE520KvmcgqkvMotuMxGko+XR/e
 7Z8X02yvO4I0Ra/uoRMNjkKpNbqrxtA3aj4bwwUMrF6zqRKX2VeekOxmwtKUN7msuAcXRRRY8
 lcOlByXvWiaeSqu+lb2Pe9fKqH6RA16GyP1evF6qSaaTmZ591rc4dTd3I3gwNnWPLTW+TNmOH
 go+gsm0NKnNhO2ZEDFCZML0zwnO6yIOgZxN2PiYJXNQU9QE4xGOD+Livm6xwMtLTunLCLlLA/
 PJCai9XqYFvgQBhj3WuVnAYm9XZBTLOYcxdEKOMZmxQu4S0vUYrWHaVKA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/6 =E4=B8=8B=E5=8D=887:42, Nikolay Borisov wrote:
>
>
> On 6.08.21 =D0=B3. 14:33, Qu Wenruo wrote:
>> There is a kernel regression for btrfs, that when passing non-existing
>> devid to "btrfs device remove" command, kernel will crash due to NULL
>> pointer dereference.
>>
>> The test case is for such regression, it will:
>>
>> - Create and mount an empty single-device btrfs
>> - Try to remove devid 3, which doesn't exist for above fs
>> - Make sure the command exits properly with expected error message
>>
>> The kernel fix is titled "btrfs: fix NULL pointer dereference when
>> deleting device by invalid id".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Change the subject to also verify the error behavior
>> - Include the error message into golden output
>> - Also verify the return value of btrfs command
>> ---
>>   tests/btrfs/244     | 47 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/244.out |  2 ++
>>   2 files changed, 49 insertions(+)
>>   create mode 100755 tests/btrfs/244
>>   create mode 100644 tests/btrfs/244.out
>>
>> diff --git a/tests/btrfs/244 b/tests/btrfs/244
>> new file mode 100755
>> index 00000000..fbefeedf
>> --- /dev/null
>> +++ b/tests/btrfs/244
>> @@ -0,0 +1,47 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 244
>> +#
>> +# Make sure "btrfs device remove" won't crash when non-existing devid
>> +# is provided
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick volume dangerous
>> +
>> +# Override the default cleanup function.
>> +# _cleanup()
>> +# {
>> +# 	cd /
>> +# 	rm -r -f $tmp.*
>> +# }
>> +
>> +# Import common functions.
>> +# . ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +# Above created fs only contains one device with devid 1, device remov=
e 3
>> +# should just fail with proper error message showing devid 3 can't be =
found.
>> +# Although on unpatched kernel, this will trigger a NULL pointer deref=
erence.
>> +$BTRFS_UTIL_PROG device remove 3 $SCRATCH_MNT
>> +ret=3D$?
>> +
>> +if [ $ret -ne 1 ]; then
>> +	echo "Unexpected return value from btrfs command, has $ret expected 1=
"
>> +fi
>
> <rant>
> This just shows how broken progs are w.r.t return values. The generally
> accepted return value is 0 on success, yet it returns 1 on success since
> the functions implementing this functionality in progs treat the return
> value as a boolean.
> </rant>


Nope, we're testing a failure case, thus returning 1 is what we expect.

Thanks,
Qu
>
>
>
>> +
>> +# Fstests will automatically check the filesystem to make sure metadat=
a is not
>> +# corrupted.
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/244.out b/tests/btrfs/244.out
>> new file mode 100644
>> index 00000000..629adf2a
>> --- /dev/null
>> +++ b/tests/btrfs/244.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 244
>> +ERROR: error removing devid 3: No such file or directory
>>
