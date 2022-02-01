Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855054A5CAC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 13:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiBAM7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 07:59:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:36709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233789AbiBAM7A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 07:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643720338;
        bh=sn2bFcjLVuf8LOQH/uDZGIyGUmSMZ6R2e+7KbdWMtuU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=gKpyI+BS3l8dUdL0U/GhxcRNVYEPdvMf0beZ3sJUBbhb5r+1VLsgUBiTsXy+8641b
         6ZC/+Jdqs8TvZQZTk7lnaTEdNtZk3Q5J3ROknQqzThlwEdfn/PcrUuEl1zGz2Auhrn
         yr9q7T1SxixS4VRE/x27ZV9en7k3RWcz6xh/CI9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwfai-1mIFRr2q8g-00yCso; Tue, 01
 Feb 2022 13:58:58 +0100
Message-ID: <a05a9bcf-d2a2-99a9-0e18-7313e74e29dc@gmx.com>
Date:   Tue, 1 Feb 2022 20:58:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220130010956.1459147-1-rosenp@gmail.com>
 <20220131143930.GL14046@twin.jikos.cz>
 <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKxU2N8jeMT_4kJrwLFng0WLYBo=kfYmrz0Hu1NpdWR-fOzVnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ws1ZKwOy5p2DZm+vvZxBFW20CdFnU71DX+BSVehjZVu2rq0lI2q
 In+j+7vHt1WIzjAm+xzecjEw6/TiBcE8obAmvavi6dYnKuxQNw/N3TBTrRVUzm278YQW22y
 jUieMQv/KLMmFvr8QQxMSZdHWXwzFJOxadGNbWjNctumAkAATywuppu5WEZgpcxzQqcO9en
 4kNB/vMwXQLS0RGLjFF6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3tupk9cwLCw=:7L2K9YcLDqtFixcgxBFgTJ
 JXiw5y9Pb7BI73mb2EDHeijT4W0niiQaIDAuXfptjiI7yo5lHbadBl22frz+1Y9xGXAvZH37a
 ZeWieBiqAga2Pn/4jIgvXOVByNNQkpZk3HSeXIBaPDMp1vghdGq7L/bOS85tj68pVB2bJGAnv
 iRpow5rkHStUVniaUL1jKlMZLZZMSVKbYpFcMxiRtOd4kmsb3nQpozPUT/9HHke0alw43yVUL
 nRcbT8WsDpU9AMOVPxsljIvLF87s80dHw5pyUX76/4Tg6UawwwtpqCmFjl7+VRJRV6l3vFeeC
 nnE33cq8WPojgB2iLw+bsjS/P7Qad2C+//IHpNIb0T5BSpRI++3iyfJPSypec7NdaMBvVLJS1
 9FSN1WRuZ6zQATkojtzy7DHWrquHqJ/45dJTZje215Gbr4Pkai1HGRVCBLwShIu0x+45mquRP
 zVCeNJNC0x4ZRGT56xYmbPLOFFDTAqZ0k/aZaSITOI6GkCtS6Bi69sR5y1UZAJxnZhrGLfbNn
 5fW2cIDyymOoB1kP7YH5IgoNTFgY5K08nr0UYXg3GX2EAp6d00ZD2SDf06Y3qddRtQVP/Awro
 J1O+wFwyS20UlBYikGA1Oy6hJtlHlUz6TZiAkFfRiNaJnn9TSVtQGFOkKtCMI0Ky88Xa4RVEF
 emV/MMZq+XfQpbk6EfxObx56+SiDfA+QBCXzucRtZfSg7Yp6LzigK3j9JlQwGX4wuA1K7FWWO
 m7tzb9TO9ooAVfrBpUMnnOou558ZqKRSKMJNufgq5IooC52o8q8b+2JpaCJLzFX4UXiKmYo75
 Ril1gNJCCeYg/bKyX/Y2P4Dy4+dVPbr/ywF2Scq4/r0AAGfL60fJIAQnYE5iEeM4G5YeSoirQ
 1xR7F7akoJCE6E42RszJzYJ7Swsyj7UVfWibS4PrU4SXa7Z/YpGlVBC070RZty7XGD7qQJZM6
 3BsEnVNDGJK5lPdIWzelqEPNS2qtj4HbxxyY+LAfZBwZY7ToU5A8KUldpyb7KMGlzczZleQsQ
 TKpQcQMlc4TBHnd4cQ3UvX8RDQaRsvTtGplrAzeFZCKMIde/H67EZSbizL9yN27e8+19nIow6
 +0uUXLcRlXBXOk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/1 04:46, Rosen Penev wrote:
> On Mon, Jan 31, 2022 at 6:40 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Sat, Jan 29, 2022 at 05:09:56PM -0800, Rosen Penev wrote:
>>> The kernel uses unsigned long specifically for ppc64 and mips64. This
>>> fixes that.
>>
>> What do you mean? Uses unsigned long for what?
> kernel's u64 is normally unsigned long long, but not for ppc64 and mips6=
4.
>>
>>> Removed asm/types.h include as it will get included properly later.
>>>
>>> Fixes -Wformat warnings.
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>   cmds/receive-dump.c | 1 -
>>>   kerncompat.h        | 4 ++++
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
>>> index 47a0a30e..00ad4fd1 100644
>>> --- a/cmds/receive-dump.c
>>> +++ b/cmds/receive-dump.c
>>> @@ -31,7 +31,6 @@
>>>   #include <stdlib.h>
>>>   #include <time.h>
>>>   #include <ctype.h>
>>> -#include <asm/types.h>
>>>   #include <uuid/uuid.h>
>>>   #include "common/utils.h"
>>>   #include "cmds/commands.h"
>>> diff --git a/kerncompat.h b/kerncompat.h
>>> index 6ca1526e..4b36b45a 100644
>>> --- a/kerncompat.h
>>> +++ b/kerncompat.h
>>> @@ -19,6 +19,10 @@
>>>   #ifndef __KERNCOMPAT_H__
>>>   #define __KERNCOMPAT_H__
>>>
>>> +#ifndef __SANE_USERSPACE_TYPES__
>>> +#define __SANE_USERSPACE_TYPES__     /* For PPC64, to get LL64 types =
*/
>>> +#endif
>>
>> Is there a cleaner way instead of defining magic macros?
> no. https://github.com/torvalds/linux/blob/master/arch/powerpc/include/u=
api/asm/types.h#L18

Really?

I have the same issue in btrfs-fuse, but it can be easily solved without
using the magic macro.

See this issue:

https://github.com/adam900710/btrfs-fuse/issues/2

including <linux/types.h> seems to solve it for btrfs-fuse.

Thanks,
Qu

>>
>>> +
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>>   #include <errno.h>
>>> --
>>> 2.34.1
