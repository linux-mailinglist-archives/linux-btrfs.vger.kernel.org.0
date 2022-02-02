Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197D44A694B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbiBBAkn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:40:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:47361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbiBBAkn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 19:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643762438;
        bh=1MV+yvWnuQnUWvHRtM87oWFkWcnO6VfIx1EMd6Et1q4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j52CsnbONWOSB4AUd+xtblHOrkWItPh0RU7k4z7FP+28N2b3Dz5kpM5XJDurRxC3m
         W/FBH0VIyo1Jq2VLdCjoMw3AzGzAsAuvyggj4wzdYABXmUZSevSLYu4/Jg4eln2Ycj
         yw4tL6l+6Qr4tsNccydmp0S6MfXsjJExC0oU2lWA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UZG-1nFbfD1Hus-000Zm2; Wed, 02
 Feb 2022 01:40:37 +0100
Message-ID: <8978c22f-9f7c-0ece-545a-eece0b51ee4e@gmx.com>
Date:   Wed, 2 Feb 2022 08:40:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20220130010956.1459147-1-rosenp@gmail.com>
 <20220131143930.GL14046@twin.jikos.cz>
 <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
 <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com>
 <20220201134402.GM14046@twin.jikos.cz>
 <CAKxU2N8YVZOrPTEi0tL2dAKRgpLuSs+F8rqqvwHcw1Bbzurh5w@mail.gmail.com>
 <2d9decd4-7442-efb2-3bd5-df00705f02ff@gmx.com>
 <CAKxU2N-93WgUcv_hNZPXcfhWh1GmtNmLdA92J7ZoFzK5Lx_7aw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKxU2N-93WgUcv_hNZPXcfhWh1GmtNmLdA92J7ZoFzK5Lx_7aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VU4/isxknHKa8OhiJmG+eUjMz4+L1bjjNpwZ7WQHHh9EVRu2S6e
 5dvR2CXxeo3MNZetx6Q4UjY4c94H1jnjZjR2mKMEL+mO6QT0O7LtijsoB7Enzb1umqMIJ3O
 +2cXc6rSbyM2tHZaOePLuwL1w77MJJJvlbQOZl9KMHS9oshFjkWBaXXGb6RBgAPL0aEWhZK
 PqTuhLooT14UMENjKjrJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EojWwk0Buh8=:Tdol8+ez1WSHOHuskp9aCg
 hNGxj4uYfTqqtDfUgts/Is5lVm4yhIiKt600CHMrp6C2eR05I/r2Fx0BNGSiHGCg1YcnJeLK5
 1fY6des0j+ldvNCWN/uTIQ98RoLGfHWNceQJcDzFm64pPPEEODTrwc8RkpFB+GqPk3lWkY6T3
 j9s1p26rx7CdRuDh3nQR/eTxB+H9rWeKdM4xCCivN1uOFq6BwBsq4ylVy/3fRnV5jeoRygUHq
 szLG+EEFw2w8P6u2N52WdkkpHMTYZZpTf071lbKSik9bMJyHe5vTWoyGMF9lX6MPr+oKxDV80
 CrrSgXDRS6OKMBl7JQ10tT4hOTnxS0RZWDpFfiuSeyQlukNgXa6FnHp9cUEdlLBGnnEbG9r4r
 qF4sDr7So3Sk8rp6W9XKJjhNMKl0MtLPKHfvaRMe/I5YsseVI0A2EjEpEwc8L8Oww4XXjqs0a
 DHOTKIInrSqUR22Szmghxeg8liReLDvSi0nLwLKZ/VLEfxAVC804I1ZvaMp88JQ2rGLMZeTN4
 o+jDjly2lSwckKdd7EHas/wUEHWBVdkkijYdrutDjbFjMW4S4kRqRKCuoYaHce06O7gCpogIc
 tV+Ozx6lNdK3UNY/G4eH62h6774E19RUwmUXQ45QAD3UOE6SMA0L7EZl1HvFc3cXZw3xG737c
 TBE69I0uT8wgTPcIq8ix8GukDHeAr3X4xuyljr3Umfl9ZQ1C/vz1508ME1caPZhPzOItGoY5+
 c4NgM0xtS03iSrLTt6cEEN7YzA2IfcMXhrzvxmAt4e1KSfbYHBgq1Xt+sGBpYyL2LWH402eoT
 S5GtUXdqzxwWZSccZ+9v+KDj+JKTRyhEQR+LgJpOMoiP9lHuyinlxdP5n4AhfQUSRyukc6omT
 TJMN1MKoBK/v4fre3ArIxjR4mmtF+qgfMOPODQdLwvOkWmBwClICuu66y4uqamU7qmxRgfp9b
 qefS5BkECt1JcJ0Fw5ZEoN9nmDyI2W3E+b97QHRVnKmm/FYcOY93WE5Wot05EwoltyzC+s8Lj
 UJFX72J8a4BKt6dP7n//Nwes4nEl+KFebWmi+nIUbe05tK9R8FI6rgN12RO9cwP6ppimQ5AE8
 DUqGhDErY23bmQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/2 08:35, Rosen Penev wrote:
> On Tue, Feb 1, 2022 at 4:31 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/2/2 08:11, Rosen Penev wrote:
>>> On Tue, Feb 1, 2022 at 5:44 AM David Sterba <dsterba@suse.cz> wrote:
>>>>
>>>> On Tue, Feb 01, 2022 at 08:58:55PM +0800, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/2/1 04:46, Rosen Penev wrote:
>>>>>> On Mon, Jan 31, 2022 at 6:40 AM David Sterba <dsterba@suse.cz> wrot=
e:
>>>>>>>
>>>>>>> On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
>>>>>>>> The kernel uses unsigned long specifically for ppc64 and mips64. =
This
>>>>>>>> fixes that.
>>>>>>>
>>>>>>> What do you mean? Uses unsigned long for what?
>>>>>> kernel's u64 is normally unsigned long long, but not for ppc64 and =
mips64.
>>>>>>>
>>>>>>>> Removed asm/types.h include as it will get included properly late=
r.
>>>>>>>>
>>>>>>>> Fixes -Wformat warnings.
>>>>>>>>
>>>>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>>>>>> ---
>>>>>>>>     cmds/receive-dump.c | 1 -
>>>>>>>>     kerncompat.h        | 4 ++++
>>>>>>>>     2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
>>>>>>>> index 47a0a30e..00ad4fd1 100644
>>>>>>>> --- a/cmds/receive-dump.c
>>>>>>>> +++ b/cmds/receive-dump.c
>>>>>>>> @@ -31,7 +31,6 @@
>>>>>>>>     #include <stdlib.h>
>>>>>>>>     #include <time.h>
>>>>>>>>     #include <ctype.h>
>>>>>>>> -#include <asm/types.h>
>>>>>>>>     #include <uuid/uuid.h>
>>>>>>>>     #include "common/utils.h"
>>>>>>>>     #include "cmds/commands.h"
>>>>>>>> diff --git a/kerncompat.h b/kerncompat.h
>>>>>>>> index 6ca1526e..4b36b45a 100644
>>>>>>>> --- a/kerncompat.h
>>>>>>>> +++ b/kerncompat.h
>>>>>>>> @@ -19,6 +19,10 @@
>>>>>>>>     #ifndef __KERNCOMPAT_H__
>>>>>>>>     #define __KERNCOMPAT_H__
>>>>>>>>
>>>>>>>> +#ifndef __SANE_USERSPACE_TYPES__
>>>>>>>> +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 t=
ypes */
>>>>>>>> +#endif
>>>>>>>
>>>>>>> Is there a cleaner way instead of defining magic macros?
>>>>>> no. https://github.com/torvalds/linux/blob/master/arch/powerpc/incl=
ude/uapi/asm/types.h#L18
>>>>>
>>>>> Really?
>>>>>
>>>>> I have the same issue in btrfs-fuse, but it can be easily solved wit=
hout
>>>>> using the magic macro.
>>>>>
>>>>> See this issue:
>>>>>
>>>>> https://github.com/adam900710/btrfs-fuse/issues/2
>>>>>
>>>>> including <linux/types.h> seems to solve it for btrfs-fuse.
>>>>
>>>> Ok, so it's just the asm/types.h, once it's deleted it should all wor=
k
>>>> with linux/types.h (included via kerncompat.h).
>>> Qu is referring to a different issue. I am referring to bad printf for=
mats.
>>
>> Weird, as the report includes format '%llu' warning for printf formats.
>>
>>>>
>>>> Rosen, could you please verify that this is sufficient (without the
>>>> extra macro)?
>>> It is not.
>>>
>>> Also note that this is specific to ppc64 and mips64. and alpha
>>> (whatever that is).
>>>
>>> a git grep of the linux tree for that macro shows that it's used in to=
ols/
>>
>> OK, after checking the latest build log from Fedora36 ppc64le, it indee=
d
>> still shows the warning:
>>
>> https://kojipkgs.fedoraproject.org//packages/btrfs-fuse/0/6.20211113git=
8635fbc.fc36/data/logs/ppc64le/build.log
>>
>>
>> Although from what I see, that magic is more common set for packaging,
>> not directly into the source code:
> OTOH tools/perf and some tests define this macro.

That's a trade-off between easier to package and easier to read.

Although as mentioned, it seems more common to define it at packaging time=
.

Personally I'm fine with both way, but a little more towards defined in
Makefile.

(Also my time to update btrfs-fuse to handle the build warning)

Thanks,
Qu
>>
>> https://chromium.googlesource.com/chromium/src.git/+/7d38bae3ef691d5091=
b6d4d7973a9b4d2cd85eb2/build/config/compiler/BUILD.gn#988
>>
>> Where chromium choose to add that magic only for mips64
>>
>> Or this:
>>
>> https://github.com/LLNL/lustre/blob/2.12.7-llnl/lustre.spec.in#L343
>>
>> Which is only defined during packaging, not in the source code.
>>
>>
>> We can put this into our Makefile, and only for affected archtectures t=
hen.
>>
>> Thanks,
>> Qu
