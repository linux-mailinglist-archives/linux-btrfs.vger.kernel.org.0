Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50173E2969
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbhHFLVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 07:21:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:45233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239256AbhHFLVV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Aug 2021 07:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628248863;
        bh=zIAYu+GnZomLpbdD95Ue7E0tz+5b5JRxXBtIf2AnUao=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P2JxpA0xnAmHPeMhLpVsQ7PzGZzOILcNsEbl9P+eSZ7DrtYEAjzc/5mzeEcBAMy/g
         fB/KDNjE4+lViL5a64jL4AzzNf8tr6ndAozzgowQC4fmMKeD4iqRmcDxATEkQuRXh6
         N32J2qvjO4y+XnHlF0zvDz2yVAHhlvVFCBmS3S7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1moJOV2sJp-00fApP; Fri, 06
 Aug 2021 13:21:03 +0200
Subject: Re: [PATCH] fstests: btrfs/244: add test case to make sure kernel
 won't crash when deleting non-existing device
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20210806104647.312765-1-wqu@suse.com>
 <CAL3q7H6Khz9eAnCVFYGRZCga+X8KQ5nErFuEpCnwVHZ_kucjJg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f455ffc4-0a98-f24a-ed9f-165aa3fd2f24@gmx.com>
Date:   Fri, 6 Aug 2021 19:20:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6Khz9eAnCVFYGRZCga+X8KQ5nErFuEpCnwVHZ_kucjJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yO6GF/IWNYluIG7MDdzX0lVrjUO1/MyTCTUFlfRKfNkvIFSe6au
 IlBfU/13r5TL9ze1uuvOoIBeQ+3jPvKsYWBpKivZ9XEjDaLMrQbxTdH2EJDpEsv0Ew0z5Wc
 NqFCBgxFYrf0d0nkV+kkmVfvV2duBGDnZG7DtucAq1l0gQRo3msG2Tdrrrbo/SNzOMV4zVL
 jgT20vP3xtOOk8JlhlEYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hImRLLvVjAk=:x0xgzMc0UkKaeORUt4KpAb
 9cdHxmTLycM5o5C1xMZAgqANATMr/F4sBDVzeJZX2UomsfLe9fHQLj/Dm4dpTGGukvCX3xCoI
 1gLONw1+LEJGstJrONZhqTxC+cl/9IOPLu+J0m2ZLZXcHjquPrKVAmql7BA3PYxfYv6/PDssj
 jbIBTGrqrBnYm8Ls0FkVZtRdNicQ295gtdqQuX+1kuVQ4bmvG1ZMMgoc36nzgziDIKwGUEp81
 5i4PEujTJW1M9GK9HURNq5QDEehYrl6Xq4x/TaWPvR0sI9Rap+Q65kT9g8cMS5B0nwI+L1KOO
 u+0QjlYM/xnjqWEyOc5qncPqKyXgQmcEygeHbEyuwNh77P08HBiJMGicGLgrTRzexzo5FarS7
 gV06KpjXjIZG92NYmut791vSYGKwQk4R6m0m/vGwJUq+p+U+GdIXjEv3uPEOgzQhkFv2gctCS
 3IZzTRxwUc/7rAm5JpYprfjd2pK2rvtw1HTN9A8HygNLHSas6jDVOGK+Z9nnm5mk1R8Wu+Ivz
 vf47hCcCsz+3W37zixNRsGMkcJe+5KcDYw4rtrrwxlm2ZXKzwsMOrqSDxlgApbh2IWtSHrpXX
 9FEqCMMIz6dSlUXhOORyMa+Nw3RM8REhnHtHqGrQkd6NwXTMuskbeuqzKo2YWPd6UNwTrmPnJ
 95RoTXRn4ESTYTI9m55rq4owXTvq+qbrctXuhZES/gsrSzbkJlN6IJ3Dtp/YmSkI5Hyd0uXq+
 /Q2lcQH/cve39P4WXFOsZlolDhopzAaWd4A3YE2BybIRTAa4ghZV216kGLLR7wSSHwg809q0h
 qsgUOt7CAM22K0h+n5XpVeDxjBXd3KmC6JdxCMBfe26OGuVuYfuAktjFnf8QXlG+mtavnlFRE
 5CmAUXfvsRR5+SRuIrPTUZ5QwwyKDIhCygSq4kfMqPHdFtrsWmnUNcOD4ZEHrHNN2tcGRh2gc
 VY9OnuvxEqu1EyiT5pfUSdcUReS4acYkHZO2cmI1uAToAlE8LmeF/+WjEQCdL+3OfTpDxQOYz
 p4OI4YmLtI0dv3laUdLG9s7m5zxLB6uDZw3bhCOAtU+xBn3WfOK2/FD+Gb/5wrNyJsh44nO23
 1yVyFDlaC5nWDRd7jkvDz2suvUHuJ+JWIlJt4r6cUEhIDblL0WiydUJAg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/6 =E4=B8=8B=E5=8D=887:13, Filipe Manana wrote:
> On Fri, Aug 6, 2021 at 11:47 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a kernel regression for btrfs, that when passing non-existing
>> devid to "btrfs device remove" command, kernel will crash due to NULL
>> pointer dereference.
>>
>> The test case is for such regression, it will:
>>
>> - Create and mount an empty single-device btrfs
>> - Try to remove devid 3, which doesn't exist for above fs
>>
>> The fix is titled "btrfs: fix NULL pointer dereference when deleting
>> device by invalid id".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/244     | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/244.out |  2 ++
>>   2 files changed, 44 insertions(+)
>>   create mode 100755 tests/btrfs/244
>>   create mode 100644 tests/btrfs/244.out
>>
>> diff --git a/tests/btrfs/244 b/tests/btrfs/244
>> new file mode 100755
>> index 00000000..56eb9e8c
>> --- /dev/null
>> +++ b/tests/btrfs/244
>> @@ -0,0 +1,42 @@
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
>> +#      cd /
>> +#      rm -r -f $tmp.*
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
>> +# should just fail.
>> +# We don't care about the failure itself, but care whether this would =
cause
>> +# kernel crash.
>> +$BTRFS_UTIL_PROG device remove 3 $SCRATCH_MNT >> $seqres.full 2>&1
>
> While here we could also check that the operation fails. That avoids
> adding yet another test case if one day we have a regression where the
> operation returns success instead of an error.

That's exactly what I also thought.

But there comes a small problem, the output format may change, thus in
the future the test case may cause false alert.

>
> In fact the test subject and goal should be to verify that removing a
> non-existing device fails and does not cause any harm (kernel crash,
> metadata corruption, etc).

Right, I'll just include the error output into the golden output, so
that we can verify everything, including the expected failure.

For the possible future format change, let the future guys to add a
filter to handle it then.

Thanks,
Qu

>
> Thanks.
>
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/244.out b/tests/btrfs/244.out
>> new file mode 100644
>> index 00000000..440da1f2
>> --- /dev/null
>> +++ b/tests/btrfs/244.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 244
>> +Silence is golden
>> --
>> 2.31.1
>>
>
>
