Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E554B19FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 01:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbiBKABg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 19:01:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiBKABf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 19:01:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB1B43;
        Thu, 10 Feb 2022 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644537688;
        bh=1ZaSPozF/u4TPSaAiNx3hDVYi5BV778Qf8GxH25H734=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kpMpoIqKis6lY0+c1APfvVCiEKWGTrDoYdbBy7LClcneecbF9CmuHRRuABfi6oF/W
         lNDqGYMel42lSOzlqJhrYTUUtd0RwzjG6B+A6MzD02SEOzP3Xsx8wdWC8UF+eYSwsv
         ciImLzxykczVlDhH17QAUwmn3rrOxaXOy2sqnOuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Rm-1nbdBB2wAA-00LWiz; Fri, 11
 Feb 2022 01:01:28 +0100
Message-ID: <08a1e4df-27b2-23e4-ec1d-1ba1c4fe7e2a@gmx.com>
Date:   Fri, 11 Feb 2022 08:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: add test case to make sure autodefrag works even
 the extent maps are read from disk
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220208071427.19171-1-wqu@suse.com>
 <CAL3q7H5TSOMDpgP0FNbP_TqOgY_zjgsthjAo6iDnZS+g2FJk8w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H5TSOMDpgP0FNbP_TqOgY_zjgsthjAo6iDnZS+g2FJk8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TovMw0JsUXVcS+Y9HWx2ZM2q3CtajxVryw/3O6VsFQUo/mRIboD
 j/sg10PAaxQ7oyEmbePTogmShRzt+sGY2Oqb8aZmviXKZS6XId375n+k79uBTnYYIwfADjt
 07i00TS9JLW9FRCMtXQ2rftE3+6sh8XSTrA8kr5xumXdULUnXy6rc4z2wz3vv4S/787AwHb
 oj2A9aPaaqc3sp0eQCwVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CARlJV3LNQA=:ZHvoUcFvOotImjhX29Mp6n
 71/3cXOx7vZzqkeN5KBY3xJtnQmNED3r9IwZnFF06LvAL+y6g/osImHGVF88oElaGIPiOD9rs
 yD4/YD9TgaPjCa1b0Myrf1mPv4vr8zf2WT+de6eedo5+DoR5RuTlcnDRJJXaCY2i5eKus8Viu
 PxOlWTveHm7fysEa6aiydhyWnDanjrm6Ir/xGwhtZ/52+DcILn2xAFcK/M8kR8GMJRZvaSraW
 a1nFAJSJOUiYPH+O8ELQKuvEkV72XzzqzVnQ+KnKoHgMvH4AxcTqyowfQtR3KtWXFwtf7KOZU
 J0FHuhFwqUs7ctmPqbfTE+cpRwBFyKM4q/Xeo07vjQE8cp4ELeUGtnUGmtWykhyPsBx6Yams/
 PKvnJQUBZs4a19+PZKP0cT/XfEVJUp00nd7uFxuKMBrX3mxpQT3nZ2KSYU0QPNYaD4ej/21D0
 0jR+36PP04j/N9rgBoEFpvGlruAx3HoxEImW9fCF9S6l1WS1HljFe/agvm+hQ3mdknfpkikVd
 39NpJ1QnytfjIjot1gN/zNKFbP+2YtH5sK7F3yREhSRVWNIV0RvGkOEIwrlOHC7cPk31OVkrR
 JHcGKNMX18kRFij/8sy4fdLVhOnDqO5wD3/vMWM14AVBL3ATmnOgLBxuhO/jMh1eeqzW8G632
 dddPKkyFwPYCFnFRtDBKkpgViNB1ClbYUUFjBH01kOmuOiTyI/v2a0oQHHxDSfYnAZKCoyVHY
 GXma9C4ghw6TBxVal2wCTeAJ74empzpe2Dp3XpwhmS0lEeNZgcBE9t/hDyvj04AiYGoVOLjeR
 jVYFoOVv8C0XWi2J4IyqAzvX9i+JhRX05cwDzFyNe9KNtddUAV1ATJKH0aJEaU9WKXxZsjYxy
 b0KUaFIt2WDpyC7HekjomvpQGTnC38fZYQ3hbAma3teSRK/SXiqs6GhadE/QnYzv63yr3uqg6
 475eT4jbmWrURwqGbFUJ6KpE3vs2yGd/MNGxJ1/2dmm8uzm9Mxwo+IGrJMyhC/P597DMxpTyr
 mF+k6Na8Wacp/hx1w0w57XgN39ygsGUeCZtEwpwl8x3TjLHAlp8y5BGSuDqDStpBdXs1WpDK+
 vGTfLsIcglR/A0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/11 00:37, Filipe Manana wrote:
> On Tue, Feb 8, 2022 at 12:00 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a long existing problem that extent_map::generation is not
>> populated (thus always 0) if its read from disk.
>>
>> This can prevent btrfs autodefrag from working as it relies on
>> extent_map::generation.
>> If it's always 0, then autodefrag will not consider the range as a
>> defrag target.
>>
>> The test case itself will verify the behavior by:
>>
>> - Create a fragmented file
>>    By writing backwards with OSYNC
>>    This will also queue the file for autodefrag.
>>
>> - Drop all cache
>>    Including the extent map cache, meaning later read will
>>    all get extent map by reading from on-disk file extent items.
>>
>> - Trigger autodefrag and verify the file layout
>>    If defrag works, the new file layout should differ from the original
>>    one.
>>
>> The kernel fix is titled:
>>
>>    btrfs: populate extent_map::generation when reading from disk
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/259     | 64 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/259.out |  2 ++
>>   2 files changed, 66 insertions(+)
>>   create mode 100755 tests/btrfs/259
>>   create mode 100644 tests/btrfs/259.out
>>
>> diff --git a/tests/btrfs/259 b/tests/btrfs/259
>> new file mode 100755
>> index 00000000..577e4ce4
>> --- /dev/null
>> +++ b/tests/btrfs/259
>> @@ -0,0 +1,64 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 259
>> +#
>> +# Make sure autodefrag can still defrag the file even their extent map=
s are
>> +# read from disk
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick defrag
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
>> +# Need 4K sectorsize, as the autodefrag threshold is only 64K,
>> +# thus 64K sectorsize will not work.
>> +_require_btrfs_support_sectorsize 4096
>
> Missing a:
>
> _require_xfs_io_command fiemap
>
>> +_scratch_mkfs -s 4k >> $seqres.full
>> +_scratch_mount -o datacow,autodefrag
>> +
>> +# Create fragmented write
>> +$XFS_IO_PROG -f -s -c "pwrite 24k 8k" -c "pwrite 16k 8k" \
>> +               -c "pwrite 8k 8k" -c "pwrite 0 8k" \
>> +               "$SCRATCH_MNT/foobar" >> $seqres.full
>> +sync
>
> A comment on why this sync is needed would be good to have.
> It may be confusing to the reader since we were doing synchronous writes=
 before.
>
>> +
>> +echo "=3D=3D=3D Before autodefrag =3D=3D=3D" >> $seqres.full
>> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.before
>> +cat $tmp.before >> $seqres.full
>> +
>> +# Drop the cache (including extent map cache per-inode)
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +# Now trigger autodefrag
>
> A bit more explanation would be useful.
>
> Set the commit interval to 1 second, so that 1 second after the
> remount the transaction kthread runs
> and wakes up the cleaner kthread, which in turn will run autodefrag.
>
>> +_scratch_remount commit=3D1
>> +sleep 3
>> +sync
>
> This sync is useless, so it should go away.

Autodefrag doesn't write data back at all.
It just mark the target range dirty and wait for later writeback.

Thus sync is still needed AFAIK.

Thanks,
Qu

>
> Otherwise, it looks good and the test works as expected.
>
> Thanks for doing it.
>
>> +
>> +echo "=3D=3D=3D After autodefrag =3D=3D=3D" >> $seqres.full
>> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.after
>> +cat $tmp.after >> $seqres.full
>> +
>> +# The layout should differ if autodefrag is working
>> +diff $tmp.before $tmp.after > /dev/null && echo "autodefrag didn't def=
rag the file"
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/259.out b/tests/btrfs/259.out
>> new file mode 100644
>> index 00000000..bfbd2dea
>> --- /dev/null
>> +++ b/tests/btrfs/259.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 259
>> +Silence is golden
>> --
>> 2.34.1
>>
