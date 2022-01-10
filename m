Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA148992B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiAJNDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 08:03:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:37179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234082AbiAJNCP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 08:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641819725;
        bh=lFNEzeyeWaYyYalrACMuBgxpzWo6rDSNWiS/Z6I5jnA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EWWcgtm2QQgMVFonTogMyO4PaFaxRcefygSW1qxYSfuB1LOivDe/IKbr0P8P1hTI4
         j4MZoXOlmAishqEMM2gI8agLxvoxvE86oEVZMlMNhqjkMiJVDy8jwh0pYJkNK0a30Y
         OPSGLlCgDokMF/EPeHKxpVd7AzsLg3UJNMGVeLoE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTmY-1mtCeo3V8Y-00WTGK; Mon, 10
 Jan 2022 14:02:05 +0100
Message-ID: <4e33b90e-4224-b320-ce3c-207a54cae1d0@gmx.com>
Date:   Mon, 10 Jan 2022 21:01:57 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H7eCwzM=a39AEeKRzVTbTtkA=BMgVQNWVdZ3kw4-dox+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZuuMXtlHb/Lhrg9SMlo7KJslNwKZm0WEmnSrTKp8agzxKTQCXQG
 Akis4U90+vGZfYnUxGmZDnw8cW4h/5v3qp7W6MGJ3ZYTwoC+siUM+tBg4OF48CgejGNTUsR
 HC9frV38yyXWhPEdEtVdeOtcg9Z+dQmFR4iuwJZQxbPoCRGEZyPEpX1fUri2bGG/4mDbhV/
 f7uQY2RetxG92ebeEgTZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TGEFG/k/e1o=:k3xOC8YudQgFps1h2PFy+R
 /h1Zpm41lNdRyjmvyJ7DKjDzeUt3RcROrjff7wdbQtJqG3MhIdtGyctyrk8X9yJnGpXIAH8NP
 9WQwwI5Kq2H/7cHFC6oH0rOdGCQ0TmZmmmpyCif13dG2OJ77lPbFdOgGQNk128mwW2Sw4vR0y
 9zUBES82UxE16f/zHIBslDbHlfbEy3Cek0TbfgiAavGcuMphnyTtJ3jHHMQtGeu4zZQBsYAi9
 nNG+IAuFfh7YNkMW/ck+EJYpFyfZCegQYpbx/kd8YS3aRW8YF5OxIe/avzMrx9nMoaFy8N8PQ
 nY245V+G1oFkLpzUb+Cn133VvIqA9pTPeepB7bS/OXoGQ8KGwKu26YN4Ov5GcPFcsSvFuR6zt
 UmZ/fP6mUEbZCr0mozZ4FfofpbXRjkG9JHiZvJiP5wn3Y0PPKkmt2XMueQ0KzspSVmIKWO2es
 FKwj7sahnRYZfvD1NOyCGY1vJFBiu24WQP+smZZDo9kXSyYdraa8qX54zIHBHFP84rhWm2ieN
 G894gIk3PF94a6afvCOEIZ17iGtgY0T0Loqt4sg4BGvbWWnkBdbM1zbzSzTMMQkgU/V7aNPo/
 MNgg5F6THxHhrRHw+VqbFi2jd4Q+0XA4DHQcokgXhzEMElHatQU6XZiR0/AA7tBqPM4isfMl7
 OTs4Yt5fACnEk8k4fbwY3m09hX8CH3LyChFvVutp26YWJkY018IvJDU0UlgDlzzu3fkVJ9Q6h
 8HloI9BM7NUVwq+2ZUIFvz4Py6GSM+VCDDJB5NOyUTwFG4VxyvfsXQ262r2pczjvIDWw7LTxA
 swUumpjP3GOtao+97kTNk9glEimxoMBhoNyL0AEV+Yyl5S5f/qdbOY/zJfdKkKsYYCtqkke4V
 PqCmoeZE43v671+YxGs24G1Vz2VPaSKGdsQCmIOFqmm/akCT/KoAtwv1CF2bDLdoLQSuvnvmQ
 NTsAKVeXN7XntD7Sll435nVJYkSAHljPBKlsB3a/czQDRE+busgSHX8WxcQjDA+ikG6OvZ55/
 xIDQk0QxUVncnxGrtoAaHCUbH7cryo85MimI3lSLO+TYsdv0TFusqLaR7WIq4gylCZ7d9ZnuP
 vPN0Gs8qAdtg7g=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/10 20:52, Filipe Manana wrote:
> On Mon, Jan 10, 2022 at 12:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2022/1/10 19:57, Filipe Manana wrote:
>>> On Mon, Jan 10, 2022 at 07:28:48PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> When running btrfs/011 inside VM which has unsafe cache set for its
>>>> devices, and the host have enough memory to cache all the IO:
>>>
>>> Btw, I use the same setup and the test never fails for me.
>>> It's quite of a strech assuming that using unsafe caching and having
>>> enough memory are the only reasons for the failure.
>>>
>>> I use a debug kernel with plenty of heavy debug features enabled,
>>> so that may be one reason why I can't trigger it.
>>
>> I guess that's the reason.
>>
>> For most cases I only enable light-weight debug features for regular ru=
ns.
>> The heavy ones like KASAN/kmemleak are reserved for more tricky cases.
>>
>>>
>>>>
>>>> btrfs/011 98s ... [failed, exit status 1]- output mismatch
>>>>       --- tests/btrfs/011.out 2019-10-22 15:18:13.962298674 +0800
>>>>       +++ /xfstests-dev/results//btrfs/011.out.bad    2022-01-10 19:1=
2:14.683333251 +0800
>>>>       @@ -1,3 +1,4 @@
>>>>        QA output created by 011
>>>>        *** test btrfs replace
>>>>       -*** done
>>>>       +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>>>       +(see /xfstests-dev/results//btrfs/011.full for details)
>>>>       ...
>>>> Ran: btrfs/011
>>>> Failures: btrfs/011
>>>> Failed 1 of 1 tests
>>>>
>>>> [CAUSE]
>>>> Although commit fa85aa64 ("btrfs/011: Fill the fs to ensure we
>>>> have enough data for dev-replace") tries to address the problem by
>>>> filling the fs with extra content, there is still no guarantee that 2
>>>> seconds of IO still needs 2 seconds to finish.
>>>>
>>>> Thus even we tried our best to make sure the replace will take 2
>>>> seconds, it can still finish faster than 2 seconds.
>>>>
>>>> And just to mention how fast the test finishes, after the fix, the te=
st
>>>> takes around 90~100 seconds to finish.
>>>> While on real-hardware it can take over 1000 seconds.
>>>>
>>>> [FIX]
>>>> Instead of further enlarging the IO, here we just accept the fact tha=
t
>>>> replace can finish faster than our expectation, and continue the test=
.
>>>
>>> If I'm reading this, and the code, correctly this means we end up neve=
r
>>> testing that the replace cancel feature ends up being exercised and
>>> while a replace is in progress. That's far from ideal, losing test
>>> coverage.
>>
>> Yep, you're completely right.
>>
>> In fact for my environment, only around 10% runs really utilized the
>> cancel path, the remaining 90% go finished routine.
>>
>> But...
>>
>>>
>>> Josef sent a patch for this last month:
>>>
>>> https://lore.kernel.org/linux-btrfs/01796d6bcec40ae80b5af3269e60a66cd4=
b89262.1638382763.git.josef@toxicpanda.com/
>>>
>>> Don't know why it wasn't merged. I agree that changing timings in the
>>> test is not ideal and always prone to still fail on some setups, but
>>> seems more acceptable to me rather than losing test coverage.
>>
>> My concern is, it's just going to be another whac-a-mole game.
>>
>> With more RAM in the host, and further optimization, I'm not sure if 10
>> seconds is enough.
>> Furthermore 10 seconds may be too long for certain environment, to fill
>> the whole test filesystem and cause other false alerts.
>>
>> As a safenet, we have dedicated cancel workload test in btrfs/212, and
>
> btrfs/212 is about balance, not device replace.

Oh, my bad.

Then I guess it's time for us to have dedicated replace and cancel test
case.

>
>> IIRC for most (if not all) bugs exposed in btrfs/011, it's in the
>> regular replace path, not the cancel path.
>
> Even if we have had few bugs in the replace cancel patch, compared to
> the regular replace path,
> that's not an excuse to remove or reduce replace cancel coverage.
>
>>
>> Thus I want to end the whac-a-hole game once and for all, even it will
>> drop the coverage for super fast setup.
>
> If everyone starts having a setup that is faster, then we will end up
> not getting replace cancel covered in the long run,
> and increasing the chances of finding out regressions only after
> kernels are released, by users.
>
> As I said earlier, I agree that the whac-a-mole style of change sent
> by Josef is far from ideal, but at least it doesn't lose test
> coverage.

It still doesn't solve the possible false alerts, it's doing masking,
just a different way.

But that masking will eventually hit ENOSPC and cause a different false
alerts.


If we have dedicated replace cancel tests, can we remove the false-alert
prone cancel test in btrfs/011?

Thanks,
Qu

>
> Thanks.
>
>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>>
>>>> One thing to notice is, since the replace finished, we need to replac=
e
>>>> back the device, or later fsck will be executed on blank device, and
>>>> cause false alert.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    tests/btrfs/011 | 15 +++++++++++++--
>>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>>>> index b4673341..aae89696 100755
>>>> --- a/tests/btrfs/011
>>>> +++ b/tests/btrfs/011
>>>> @@ -171,13 +171,24 @@ btrfs_replace_test()
>>>>               # background the replace operation (no '-B' option give=
n)
>>>>               _run_btrfs_util_prog replace start -f $replace_options =
$source_dev $target_dev $SCRATCH_MNT
>>>>               sleep $wait_time
>>>> -            _run_btrfs_util_prog replace cancel $SCRATCH_MNT
>>>> +            $BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $se=
qres.full
>>>>
>>>>               # 'replace status' waits for the replace operation to f=
inish
>>>>               # before the status is printed
>>>>               $BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp=
 2>&1
>>>>               cat $tmp.tmp >> $seqres.full
>>>> -            grep -q canceled $tmp.tmp || _fail "btrfs replace status=
 (canceled) failed"
>>>> +
>>>> +            # There is no guarantee we canceled the replace, it can =
finish
>>>> +            if grep -q 'finished' $tmp.tmp ; then
>>>> +                    # The replace finished, we need to replace it ba=
ck or
>>>> +                    # later fsck will report error as $SCRATCH_DEV i=
s now
>>>> +                    # blank
>>>> +                    $BTRFS_UTIL_PROG replace start -Bf $target_dev \
>>>> +                            $source_dev $SCRATCH_MNT > /dev/null
>>>> +            else
>>>> +                    grep -q 'canceled' $tmp.tmp || _fail \
>>>> +                            "btrfs replace status (canceled ) failed=
"
>>>> +            fi
>>>>       else
>>>>               if [ "${quick}Q" =3D "thoroughQ" ]; then
>>>>                       # The thorough test runs around 2 * $wait_time =
seconds.
>>>> --
>>>> 2.34.1
>>>>
