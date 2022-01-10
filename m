Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BE48A3FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 00:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbiAJXve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 18:51:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:55711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242630AbiAJXve (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 18:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641858688;
        bh=SrztrdiFtTWJ8oXFY7r5J6kWr+hdwWVIwfstLWDVwHA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bxUbackynrgMvblPOI2xXNRRi87PVqis+oVVNWPV+USP710egppswv0evWAJZ6Kdk
         fO9Fr14Op4sM10W7JWKOgVvla0fMhM/CpA7J7na5Am8x6UX05WWZssnzX11WXfpx3U
         428o+4fl7ivVyGMRKzUThMt+ztoakZ2Ftu5NEBeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzfv-1mrwG61jS5-00XMOw; Tue, 11
 Jan 2022 00:51:28 +0100
Message-ID: <6fe33489-912c-4541-690e-1d5b335ea695@gmx.com>
Date:   Tue, 11 Jan 2022 07:51:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] btrfs/011: handle finished replace properly
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220110112848.37491-1-wqu@suse.com>
 <YdwfNDsgEGmTL6bY@debian9.Home>
 <7769bb16-39ae-73f7-e0e6-6a37c7d70dba@gmx.com>
 <CAL3q7H7eCwzM=a39AEeKRzVTbTtkA=BMgVQNWVdZ3kw4-dox+A@mail.gmail.com>
 <4e33b90e-4224-b320-ce3c-207a54cae1d0@gmx.com>
 <CAL3q7H7EdN=LvsnTuhVU5u=W5D84p7Z7YqPAugCvpAsYsU2_-g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H7EdN=LvsnTuhVU5u=W5D84p7Z7YqPAugCvpAsYsU2_-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FZadgO8MytCS6I5/S/kjciQua1lPzW2Kji3rznbD84G5KKE7thk
 rz6L63hmYmgBnmUHCaq0WtWpTpVBK91nr2Zwxpk553s5vATUPneg4bcYkIyGQN4c1pMSv/F
 gCDFbNkxr7W9hWNywCPedNA2OmheXBFAP+Cv1WKf6esohA67AbY1ZkQD0hfvvoiTxewAmkU
 7fRN2LwAAP9IuYzzQfGfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sFIbRcPl8kw=:U4WsNvD8D6M6xoPvXOC28Q
 CsoF6wjQ6wCi4BHe1fNNY5yhIGNu+nTk/QiKHBG0vcOJ+0F7fQaY1TTYbPVWug0h1DeUPTBCc
 NofZiCc2nR5TS7zUNtD4LxSjvK0ujqcuA5NrI6uQVcJN+aKF4nw+evg1uV6f9OSQYrMXypghS
 MixYEFnNWL+b7BQHM7JDFUnrZhMtF9pl5BzGJdJrZ1sD+gaamOLySstvycDPFnVG7JsQ2rEeK
 a2+SXm9AGfzwCdT67UrAKmDHFOIHU0Q/y52ySqWxg2GyC4LelXXjjGnUzpo9uAl1L6Sdc3BHS
 3L4mlftNo7N742YWgeiNq0WDfD+ff5G+uJSU1tgKo2njhTsxxfmydcz9bN3idNpvfpFijKdPk
 AIA9Q5a/UCvAs667nbMBH8a9ufTwoxJT9vUZnovDXI8/+eQeOnJxmbXpkeTB0gT0A/sJjYsbs
 0vVNKMXmgrJj8Xq4b/8ZpfbMQvNybXyFMwHlS1HEOqj4IUaakUtiUpmbnZrfo6+LMsPYe68y5
 O4M/ozjRJXmAwXUtnKZMBoJ4RHkit6QCjbiocd+XK7W6b6WvxfCyp/z7+Ep3WPb94n/9ea3JU
 kfx7KlazPIber2WaErusJPTL5EFh/wS77KRxjYjSwKVeQPKTXtaT5R2x/H10nKFmbPH7Qp73s
 CkCk3XCxtDwyDIj2G6ueRC1IuHqGMGa3JddYVbWj/qT8/SuC73CMegRjFuCvQgG8wdpSZZaSV
 hbr+okvdKLjduFuNptvlx3rGr0rFiCpcwOJTz9uHiPnXYj8sqXliDi0ooMleLuANjDQSsyeM7
 iL+gzVkKRFI7PHWT55qEoGJ0LWJsQpZKgJlxotCADoHl/eyxaXm1NI/fzpoltAtzwwrsVwBIR
 +a3IqtyuVADWASDF/wvRO8Z/HSh23oC1k1+gBM787Ycz2LAxASILErFQTB16J3xAeeiO2DXsg
 Q6JCuexOphVtzJhHZ4uiNvp6kwdhb9+RfrY4dDDfQc8VWQIBgNc7k2iqJhRlURQLE6V/5LXDX
 fn5mBVl2lsIK33Wy7pZnodTLZnLIQ0Hy6Keqd5hUqKR6LIQ6blZgqJh+ZrksG17CLXjRWKnX/
 JlzUyFvAZzQWPo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/10 21:54, Filipe Manana wrote:
[...]
>>>>
>>>> Thus I want to end the whac-a-hole game once and for all, even it wil=
l
>>>> drop the coverage for super fast setup.
>>>
>>> If everyone starts having a setup that is faster, then we will end up
>>> not getting replace cancel covered in the long run,
>>> and increasing the chances of finding out regressions only after
>>> kernels are released, by users.
>>>
>>> As I said earlier, I agree that the whac-a-mole style of change sent
>>> by Josef is far from ideal, but at least it doesn't lose test
>>> coverage.
>>
>> It still doesn't solve the possible false alerts, it's doing masking,
>> just a different way.
>>
>> But that masking will eventually hit ENOSPC and cause a different false
>> alerts.
>>
>>
>> If we have dedicated replace cancel tests, can we remove the false-aler=
t
>> prone cancel test in btrfs/011?
>
> In the end it's the same problem however, making sure that by the time
> the cancel is requested, the replace operation is still in progress.
>
> I don't see how making that in a separate test case will be more
> reliable, unless you're considering something like dm delay (and in
> that case why can't it be made in btrfs/011).

Isn't the same method of btrfs/212 more reliable?

Just run foreground replace in a loop, then another process to try to
cancel the replace.

Thanks,
Qu

>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>> One thing to notice is, since the replace finished, we need to repl=
ace
>>>>>> back the device, or later fsck will be executed on blank device, an=
d
>>>>>> cause false alert.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>>     tests/btrfs/011 | 15 +++++++++++++--
>>>>>>     1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>>>>>> index b4673341..aae89696 100755
>>>>>> --- a/tests/btrfs/011
>>>>>> +++ b/tests/btrfs/011
>>>>>> @@ -171,13 +171,24 @@ btrfs_replace_test()
>>>>>>                # background the replace operation (no '-B' option g=
iven)
>>>>>>                _run_btrfs_util_prog replace start -f $replace_optio=
ns $source_dev $target_dev $SCRATCH_MNT
>>>>>>                sleep $wait_time
>>>>>> -            _run_btrfs_util_prog replace cancel $SCRATCH_MNT
>>>>>> +            $BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $=
seqres.full
>>>>>>
>>>>>>                # 'replace status' waits for the replace operation t=
o finish
>>>>>>                # before the status is printed
>>>>>>                $BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.=
tmp 2>&1
>>>>>>                cat $tmp.tmp >> $seqres.full
>>>>>> -            grep -q canceled $tmp.tmp || _fail "btrfs replace stat=
us (canceled) failed"
>>>>>> +
>>>>>> +            # There is no guarantee we canceled the replace, it ca=
n finish
>>>>>> +            if grep -q 'finished' $tmp.tmp ; then
>>>>>> +                    # The replace finished, we need to replace it =
back or
>>>>>> +                    # later fsck will report error as $SCRATCH_DEV=
 is now
>>>>>> +                    # blank
>>>>>> +                    $BTRFS_UTIL_PROG replace start -Bf $target_dev=
 \
>>>>>> +                            $source_dev $SCRATCH_MNT > /dev/null
>>>>>> +            else
>>>>>> +                    grep -q 'canceled' $tmp.tmp || _fail \
>>>>>> +                            "btrfs replace status (canceled ) fail=
ed"
>>>>>> +            fi
>>>>>>        else
>>>>>>                if [ "${quick}Q" =3D "thoroughQ" ]; then
>>>>>>                        # The thorough test runs around 2 * $wait_ti=
me seconds.
>>>>>> --
>>>>>> 2.34.1
>>>>>>
