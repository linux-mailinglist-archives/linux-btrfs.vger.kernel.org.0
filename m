Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9824A6943
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiBBAbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:31:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:50427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243361AbiBBAbJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 19:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643761867;
        bh=HYvmmq2SsixcA8tIXwpuG9PkBB1svtzode8jywLwCkk=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ZjDtNhQJPWACLNjNpnzTYRfKv4eJcaTFRmoCHba/kVKF7Xem0mr2VNLJRohEI25vY
         +9N9cl9xRhApEmcEfX+20DSOD2G7EBDZ8ElsTIkVSCLosr9XUqxmQyEth5+sYSwRr9
         Ek3+8tOzeMPA5eM4bhFScTg39zY7Vq449x+0PSTQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1n1sHS1c6i-00DGAX; Wed, 02
 Feb 2022 01:31:07 +0100
Message-ID: <2d9decd4-7442-efb2-3bd5-df00705f02ff@gmx.com>
Date:   Wed, 2 Feb 2022 08:31:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20220130010956.1459147-1-rosenp@gmail.com>
 <20220131143930.GL14046@twin.jikos.cz>
 <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
 <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com>
 <20220201134402.GM14046@twin.jikos.cz>
 <CAKxU2N8YVZOrPTEi0tL2dAKRgpLuSs+F8rqqvwHcw1Bbzurh5w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
In-Reply-To: <CAKxU2N8YVZOrPTEi0tL2dAKRgpLuSs+F8rqqvwHcw1Bbzurh5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:axG0zz05suuoLwCJqgvFszsAbVNKbbr9q70LSGYufnG8VSJLdoM
 O2jqMvIoE+c+uRnBB9m4Lg2ytVdIe3u4V6iNLlQc1aYlhqGaP1Xa3TQ+veDesUmY1y408JD
 V8FmbpwKwekUtFzLX2ORLgxbPsePZnHVYeqYF0SKeCr8DX9HtPMZvPC3t1tXyMnX4BTbUUr
 zUsj0qI4t6X+lHHvxPLyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b9SkNXj6drc=:2NREDLnca5o0wMN97Kaal2
 xGTdVpCB+ftX9YiGp0ZIuEcRQ068QgwL1X8ZAJEmUA40X41qVjW3CjDawSFGzBx+phVm8F1fd
 Ov5lbFuSmxfoF4Af7wqzc2ORcmhvziFybxr3mv+tsqRvjPe4e4CAasNfJIXadawdUQOfW0Y1B
 MWFizXkbceHVXePG8agTuV5suUPDbejZjRL7y+5jm9Iq7pqTuk8JtnkTvHJfRv0+nZVU9WZ4i
 3SaPfObPXRnIfnnuUY8P7XRDNcatjwmVXRA9PBhIDDpEWP3mggZu9+ddhEm3wNpScoPAJtWXr
 ISvGZFM8Gv1g+M3GGwTYODrYH6fwL1VRgaKeaTYCFTWKmOqyesHGgh6VDND9N/+Hywsz8IuB8
 zVHfTBELDsjqBhCsvBcblEUEe+jV13o38gRUY5vqs4GEqaTdgZAMHXZToZd/XpYWbmCfjs1Lr
 a3dMghrVC9ihyeDXvGgZnXcm40DfSgCyQZmtizHmjJd4ovT8UexAyJ3kOEnFbtra4pfg0Hd25
 q2w+QSW5A+noEBmEVXfdVFFXWE5hNDpKbMnSSHNfrJsRJhl8aKJsRlwqRRg2AHh5tVv/56jaf
 1A3ZVHrzN5aH7vJFRPDIK9lttVF/A20poea/z/c1VZe/tErov+O2jltB56AanJnzUMkb0bpCN
 2LX9Xcbjb2bFnxX45CaCYblNhq6G5Fnnm0MWgtKnzP9qaX7TG60ayRXPtkqIOeBVFTR4zgCN1
 OCreJEwbaT9k/TJU2MmQCLqqnqXQmN4+1Ctu6T86KzXxRw+d0JIiqSYAWpIAWfinS0LOLyY8q
 4Pv/69aYDcQocTHKq9DkcGbw6ahRgvEZYLocPOPQ0TI1TOLTyEM7W6AYaSdCXIRMqDByVibWt
 0C8PC/TLTr/aQGwd8bHq46BWRIfqIGUSyLu9qC8KikI6DDfaORhnl5xuwruRsL4nz7qivOKIV
 5xU9nFAIzMUu3KZ/nm4VLEVkrTCTfOzP7X5WUgkNDboKpRr6t9OAbiVJ5I1DQWeAtPkP0HnPw
 DQeXidU/Dy7c8jRuvQ1g5AFWcjlZti/bAQi119SGtNvtdaHLig9/I68btLF7o+qA1slwECeoc
 Vt/H7LRL3xhOPo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/2 08:11, Rosen Penev wrote:
> On Tue, Feb 1, 2022 at 5:44 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Tue, Feb 01, 2022 at 08:58:55PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/1 04:46, Rosen Penev wrote:
>>>> On Mon, Jan 31, 2022 at 6:40 AM David Sterba <dsterba@suse.cz> wrote:
>>>>>
>>>>> On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
>>>>>> The kernel uses unsigned long specifically for ppc64 and mips64. Th=
is
>>>>>> fixes that.
>>>>>
>>>>> What do you mean? Uses unsigned long for what?
>>>> kernel's u64 is normally unsigned long long, but not for ppc64 and mi=
ps64.
>>>>>
>>>>>> Removed asm/types.h include as it will get included properly later.
>>>>>>
>>>>>> Fixes -Wformat warnings.
>>>>>>
>>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>>>> ---
>>>>>>    cmds/receive-dump.c | 1 -
>>>>>>    kerncompat.h        | 4 ++++
>>>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
>>>>>> index 47a0a30e..00ad4fd1 100644
>>>>>> --- a/cmds/receive-dump.c
>>>>>> +++ b/cmds/receive-dump.c
>>>>>> @@ -31,7 +31,6 @@
>>>>>>    #include <stdlib.h>
>>>>>>    #include <time.h>
>>>>>>    #include <ctype.h>
>>>>>> -#include <asm/types.h>
>>>>>>    #include <uuid/uuid.h>
>>>>>>    #include "common/utils.h"
>>>>>>    #include "cmds/commands.h"
>>>>>> diff --git a/kerncompat.h b/kerncompat.h
>>>>>> index 6ca1526e..4b36b45a 100644
>>>>>> --- a/kerncompat.h
>>>>>> +++ b/kerncompat.h
>>>>>> @@ -19,6 +19,10 @@
>>>>>>    #ifndef __KERNCOMPAT_H__
>>>>>>    #define __KERNCOMPAT_H__
>>>>>>
>>>>>> +#ifndef __SANE_USERSPACE_TYPES__
>>>>>> +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 typ=
es */
>>>>>> +#endif
>>>>>
>>>>> Is there a cleaner way instead of defining magic macros?
>>>> no. https://github.com/torvalds/linux/blob/master/arch/powerpc/includ=
e/uapi/asm/types.h#L18
>>>
>>> Really?
>>>
>>> I have the same issue in btrfs-fuse, but it can be easily solved witho=
ut
>>> using the magic macro.
>>>
>>> See this issue:
>>>
>>> https://github.com/adam900710/btrfs-fuse/issues/2
>>>
>>> including <linux/types.h> seems to solve it for btrfs-fuse.
>>
>> Ok, so it's just the asm/types.h, once it's deleted it should all work
>> with linux/types.h (included via kerncompat.h).
> Qu is referring to a different issue. I am referring to bad printf forma=
ts.

Weird, as the report includes format '%llu' warning for printf formats.

>>
>> Rosen, could you please verify that this is sufficient (without the
>> extra macro)?
> It is not.
>
> Also note that this is specific to ppc64 and mips64. and alpha
> (whatever that is).
>
> a git grep of the linux tree for that macro shows that it's used in tool=
s/

OK, after checking the latest build log from Fedora36 ppc64le, it indeed
still shows the warning:

https://kojipkgs.fedoraproject.org//packages/btrfs-fuse/0/6.20211113git863=
5fbc.fc36/data/logs/ppc64le/build.log


Although from what I see, that magic is more common set for packaging,
not directly into the source code:

https://chromium.googlesource.com/chromium/src.git/+/7d38bae3ef691d5091b6d=
4d7973a9b4d2cd85eb2/build/config/compiler/BUILD.gn#988

Where chromium choose to add that magic only for mips64

Or this:

https://github.com/LLNL/lustre/blob/2.12.7-llnl/lustre.spec.in#L343

Which is only defined during packaging, not in the source code.


We can put this into our Makefile, and only for affected archtectures then=
.

Thanks,
Qu
