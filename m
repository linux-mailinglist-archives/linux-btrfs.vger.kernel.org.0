Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E061EA3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 05:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiKGElr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 23:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiKGElp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 23:41:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7999CE1D;
        Sun,  6 Nov 2022 20:41:42 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCKC-1ofssn2sEe-00NDpU; Mon, 07
 Nov 2022 05:41:38 +0100
Message-ID: <6dc410ea-c79f-809c-303c-f79cb7625ce3@gmx.com>
Date:   Mon, 7 Nov 2022 12:41:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221106235348.9732-1-wqu@suse.com>
 <20221107025843.osxx3alzzkkoxnl6@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fstests: btrfs: add a regression test case to make sure
 scrub can detect errors
In-Reply-To: <20221107025843.osxx3alzzkkoxnl6@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8OPEgpj5dvnhay/XPvkBuwQi8eKeC1kCiMRjMbJzmnUbuPptMz4
 /KGWNr6ypmVEMipgfcJ1ERVSt12Ds3ve3PMxY5vlqc3N4ShQySg/2st6YUnLJXVq7pffzpe
 F1PlFv0SwDgOq1fYBzE1U0pNG4tC8uSaoAWeT926Fljzs3eRWM47tu/0JvfTAX8JIMj/kgU
 m6POulMnF6FXFrD05+ing==
UI-OutboundReport: notjunk:1;M01:P0:CpA2RVfk+5c=;q6h/niGYCIjbD0DxeOtNnukJ7ji
 aT4NSesmMaHiS/wiNYkSIsoy5G+Zlq9er4+AYjjqn3+LXvf4/twcBpiE8mjVwKHJ3MZQYOPKt
 skRpU2wADoFcaTudSlw+/YVtpR3vzxybPNWM37CVhpcYtfscYLW9yXTBTlkHLkjXsW/pSAS3d
 fOuKSCpt4rp6ch5MByvA2PQKnl/Ebk4T1uHlchfsNQ70R71lCafqSh0nNpG3mhHp5yZvWTpwB
 77PDN5g6hz5KQ6brrphE0j5G/iaj6F3gg2y/sNqi+IqtWYN96GJSTB7iKg5CFyLQZ2LGQqut9
 Elt9It6C94AsgcTV5vF7ArtwXSiIMkXL6fwDu8ckr208tqdUegRhh3yeoxiqnCCPlsiLgrI5H
 HsF4QWkqFFWlruVTYYujRpk430QqBuETjiAz8fEgkmrvlHOuK0b/e2Gi91NCxej1jtcyGNdSM
 H4+T+BOr3HRKiFZA/PoZks8cjr8/bfueculo2RUtVgOC7z/CDfeTgphBAlwahl1Z5dwgnDgRD
 F6jEsOk74jv+NlxHV3EgsYrECho4ocND7ZjxCLFAbQ0moyTqj3iE64cN/AxlpN/iC48PQkLWU
 CwIZ5tgUhC+wpPRjJmKrZLRiDsoz2WysPiHPDPH+1hcDWaqyafUm1mReukOkRitGQ2s0XQ77b
 i/AAHBsWk7t4c5ENn3asLYk7byzltk2b99s/NkO+WHTzFR/fS3vtzuiK9gReoxw5TDyiZWXpN
 Msmb5vUFW7iytgYK+Q5HUhI9PkBh13NT0JZCvmx/IACVnLzKrlawjr2FkT0AcZ2IygCPqYJqh
 IqW6cfybs6IfmqdX26BPu3wKlYEk6Sog/+E3vi9JPy87t5iNI5vpPDW+i0/7wMXsiA/ERl09h
 23/PJVVCAPiCCnAPwx7S229OhhzdVa7bkJnUxt8yCvDTcJPHiArzvQxPQGvtZv97RYQgXxXDE
 VE4fIVcXw+4+1rUbXOBnuHICzRs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/7 10:58, Zorro Lang wrote:
> On Mon, Nov 07, 2022 at 07:53:48AM +0800, Qu Wenruo wrote:
>> There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
>> from detecting corruption (thus no repair either).
>>
>> The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
>> larger block size for data extent scrub").
>>
>> The new test case will:
>>
>> - Create a data extent with 2 sectors
>> - Corrupt the second sector of above data extent
>> - Scrub to make sure we detect the corruption
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/278     | 66 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/278.out |  2 ++
> 
> Hi,
> 
> btrfs/278 has been taken, please rebase on the latest for-next branch, or
> use a big enough number.

I'm not sure if some one else has already complained about this, the 
idea of a for-next branch of a test suite is stupid (nor the weekly tags).

Fstests is a test suite, it is only for fs developers, I doubt why we 
need tags/for-next at all.

Remember, before the whole for-next/tags things, developers just 
checkout the master branch and go ./new, no need to bother the 
tags/branches at all.

> 
>>   2 files changed, 68 insertions(+)
>>   create mode 100755 tests/btrfs/278
>>   create mode 100644 tests/btrfs/278.out
>>
>> diff --git a/tests/btrfs/278 b/tests/btrfs/278
>> new file mode 100755
>> index 00000000..ebbf207a
>> --- /dev/null
>> +++ b/tests/btrfs/278
>> @@ -0,0 +1,66 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 278
>> +#
>> +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
>> +# larger block size for data extent scrub"), which makes btrfs scrub unable
>> +# to detect corruption if it's not the first sector of an data extent.
> 
> So 786672e9e1a3 is the commit which brought in this regression issue? Is there
> a fix patch or commit by reviewed?

The fix (by reverting it) is send to btrfs mailing list, titled "Revert 
\"btrfs: scrub: use larger block size for data extent scrub\"".

> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick scrub
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/btrfs
> 
> The common/btrfs is imported automatically, so don't need to import it at here.
> And I think this case doesn't use any filter, if so, the common/filter isn't
> needed either.
> 
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
> 
> This comment can be removed.

If you really believe removing those boilerplate makes much sense, then 
I'd say, the template should be updated to remove those completely.

> 
>> +_supported_fs btrfs
>> +
>> +# Need to use 4K as sector size
>> +_require_btrfs_support_sectorsize 4096
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full
> 
> Just check with you, do you need "-s 4k" so make sure sector size is 4k (even
> if 4k is supported)?

I'll add "-s 4k" to make it more explicit for systems with larger page 
sizes.

Thanks,
Qu

> 
> Thanks,
> Zorro
> 
>> +_scratch_mount
>> +
>> +# Create a data extent with 2 sectors
>> +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
>> +sync
>> +
>> +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>> +echo "logical of the first sector: $first_logical" >> $seqres.full
>> +
>> +second_logical=$(( $first_logical + 4096 ))
>> +echo "logical of the second sector: $second_logical" >> $seqres.full
>> +
>> +second_physical=$(_btrfs_get_physical $second_logical 1)
>> +echo "physical of the second sector: $second_physical" >> $seqres.full
>> +
>> +second_dev=$(_btrfs_get_device_path $second_logical 1)
>> +echo "device of the second sector: $second_dev" >> $seqres.full
>> +
>> +_scratch_unmount
>> +
>> +# Corrupt the second sector of the data extent.
>> +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
>> +_scratch_mount
>> +
>> +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
>> +# it will output an error message.
>> +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
>> +cat $tmp.output >> $seqres.full
>> +_scratch_unmount
>> +
>> +if ! grep -q "csum=1" $tmp.output; then
>> +	echo "Scrub failed to detect corruption"
>> +fi
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
>> new file mode 100644
>> index 00000000..b4c4a95d
>> --- /dev/null
>> +++ b/tests/btrfs/278.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 278
>> +Silence is golden
>> -- 
>> 2.38.0
>>
> 
