Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6FB301913
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 01:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbhAXA01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 19:26:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:47125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbhAXA0Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 19:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611447890;
        bh=53DMYGSn2+4OCTXPitFC/1Xqbo7YrRxGH+xvXxwSJnY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Cee48+3ze3sOf3Z9vgRTJad16d8x36papFNz0v+vzBqg2f4aV2hNYrt5d97OfTmMt
         QBByh6CjZ3bx45/rFtq0BHsyUmSVXQ20lrp9krju9jnqxHnP5LHj59K4Z5wfzgDowK
         gWmdO+RzRqveUKutftjr0HzxzdDS+DinYSM/5+Is=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1l55VH15XK-008NWv; Sun, 24
 Jan 2021 01:24:49 +0100
Subject: Re: [PATCH v4 03/18] btrfs: introduce the skeleton of btrfs_subpage
 structure
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-4-wqu@suse.com> <20210118224647.GK6430@twin.jikos.cz>
 <65ab6681-f694-5cc4-1b2d-b33b70ba40a3@gmx.com>
 <20210119155145.GO6430@twin.jikos.cz> <20210119160625.GP6430@twin.jikos.cz>
 <7a48d6b7-8620-b3ff-8bee-386da50f11bc@gmx.com>
 <20210123193744.GB1993@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a3224353-fe6a-73df-ace5-5348baa0463f@gmx.com>
Date:   Sun, 24 Jan 2021 08:24:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123193744.GB1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VuWWc8FzqmO5FK9N+pm7Js4Pm7PfvzICp6xJfXJ6/tfA8pWYdUU
 9aXaMGHqC1MGhJ8GlEwJZNj3Gu+a+oFz2FcKcgaYGGTTPdQwi8DUUDKB8l9+BiqtmCV18ey
 0bVdH2ztHMUGl6TihgwfQuMEDxvbsXEeU+NvqHjZfTUkLtZsEx2v1qvvwn+TQ6a4QxMWlLd
 WLSy4J2zNTaSYNhbCS0tA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iB+0CnCfyYY=:lRtnVWZ8nUc768d4VXUOjH
 T6YAlVQrLVl+TZLWNpAFM9GxGpXsydQ/kvHnXnhrwKM56PQUjgpOwEqTdqiV0egsuEnHxVvK7
 +oT57CAGVQXeN9ZvJZ8wtA1Q8n8DZeGOFaQShm7LkWKqSLQd5NilkJ/P/ZpQLuVJRXryHyEOX
 GHstiJvLulChifV9Ohi708VICdzrnjCPURBQl1lTFQjIRyncS8j+U4XLF73Qql0WlQl5hy88n
 XdUHg7xhJo0KhYCYjqxICoiX4HiIvipOjMbT/NZgAXQ2cOvUYhUZ08bea5P9lO5HhZSpSaFqV
 WGyWiMaTX+PCaQfpQbl3QlGi1RPfAyGHkiUDmZs2ChhOTJb+DjkKZK1DsbNConkphGm3wcRZp
 Igd03RXPyhx1itrk0s7M5AbhqAr5K6rmXvshkeCMC/RhrsXoFJ7VqBb34fS0PW9IFVpFSNvPf
 mJHgnGvMmO+C/+2YHbI1qSsxUBX7rzW5vIgiNpjXtVtb9H673WxgxDwoSiNi3jXt5Zlp3ZX62
 IfUGEqWkM20vsjCYXPnBwuaM6RQws/9K4kkM063aUzrQuWgruvEUz/M9grMBE8vAXDhv8txVI
 VnklZHusFSs0Ae2G8nQAufVhmmpYbxlAA8EAQRtpy7SXxwLn+rOFs0i9h/Pnkg3cUlXw0Mosp
 q3GO57MTaYTMiMUcnOvLMuJwykna0zWBCG6/WLKZAQpdMRKuGY+qFUcGUmrH3WgMZjyC42EMp
 9DFQ7ExTVk66f+keWdGCOKkVdXt/VeprHSCEDvusDE0BdoXaYdqR1M8t42lQiCwpon5mJFdO3
 209f4EWVTLowJ0NDeMOXZlAAaBUB72HcdUKcEsDFipU3iLYCOaxDmB9e3ACE+ZKkzMGsP+PVc
 PzPZ7ewP4X7BdxvVWddQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/24 =E4=B8=8A=E5=8D=883:37, David Sterba wrote:
> On Wed, Jan 20, 2021 at 08:19:14AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/1/20 =E4=B8=8A=E5=8D=8812:06, David Sterba wrote:
>>> On Tue, Jan 19, 2021 at 04:51:45PM +0100, David Sterba wrote:
>>>> On Tue, Jan 19, 2021 at 06:54:28AM +0800, Qu Wenruo wrote:
>>>>> On 2021/1/19 =E4=B8=8A=E5=8D=886:46, David Sterba wrote:
>>>>>> On Sat, Jan 16, 2021 at 03:15:18PM +0800, Qu Wenruo wrote:
>>>>>>> +		return;
>>>>>>> +
>>>>>>> +	subpage =3D (struct btrfs_subpage *)detach_page_private(page);
>>>>>>> +	ASSERT(subpage);
>>>>>>> +	kfree(subpage);
>>>>>>> +}
>>>>>>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..96f3b226913e
>>>>>>> --- /dev/null
>>>>>>> +++ b/fs/btrfs/subpage.h
>>>>>>> @@ -0,0 +1,31 @@
>>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>>> +
>>>>>>> +#ifndef BTRFS_SUBPAGE_H
>>>>>>> +#define BTRFS_SUBPAGE_H
>>>>>>> +
>>>>>>> +#include <linux/spinlock.h>
>>>>>>> +#include "ctree.h"
>>>>>>
>>>>>> So subpage.h would pull the whole ctree.h, that's not very nice. If
>>>>>> anything, the .c could include ctree.h because there are lots of th=
e
>>>>>> common structure and function definitions, but not the .h. This cre=
ates
>>>>>> unnecessary include dependencies.
>>>>>>
>>>>>> Any pointer type you'd need in structures could be forward declared=
.
>>>>>
>>>>> Unfortunately, the main needed pointer is fs_info, and we're accessi=
ng
>>>>> it pretty frequently (mostly for sector/node size).
>>>>>
>>>>> I don't believe forward declaration would help in this case.
>>>>
>>>> I've looked at the final subpage.h and you add way too many static
>>>> inlines that don't seem to be necessary for the reasons the static
>>>> inlines are supposed to be used.
>>>
>>> The only file that includes subpage.h is extent_io.c, so as long as it
>>> stays like that it's manageable. But untangling the include hell still
>>> needs to hapen some day and new code that makes it harder worries me.
>>>
>> If going through the github branch, you will see there are more files
>> using subpage.h:
>> - extent_io.c
>> - disk-io.c
>> - file.c
>> - inode.c
>> - reflink.c
>> - relocation.c
>>
>> And furthermore, about the static inline abuse, the part really need
>> that static inline is the check against regular sector size, and
>> unfortunately, most outside callers need such check.
>>
>> I can put the pure subpage callers into subpage.c, but the generic
>> helpers handling both cases still need that.
>
> I had a look and this is too much. Just by counting 'static inline'
> (wher it's also part of the btrfs_page_clamp_* helpers) it's 30 and not
> all the functions are short enough for static inlines. Please make them
> all regular functions and put them to subpage.c and don't include
> ctree.h.
>
OK, I'll go that direction for next update.

Thanks,
Qu
