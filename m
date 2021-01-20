Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C732FC5AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 01:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbhATAVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 19:21:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:49189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730751AbhATAU5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 19:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611101959;
        bh=elQgK9nXTo4i/yTiH494/bv1KtP3KdZjFVbjgFX3zvY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kNt/z6p8YuzhG1L5Vd40QKKLcvrN9/vincPjST34htWeXFf5iIxuUHcShmE6Wpx8J
         tvs09nJPogy8xCAGCh/ECZMptgG/98AWWvYaxdSSF0lo0YfZ2dlgJXiC3bA0Cms6o/
         qiCHrpWGaOOdx/3F0cKpbur5N0y3MjZoKgUUbddI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7i8Y-1m5Tqm1jog-014hn2; Wed, 20
 Jan 2021 01:19:19 +0100
Subject: Re: [PATCH v4 03/18] btrfs: introduce the skeleton of btrfs_subpage
 structure
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-4-wqu@suse.com> <20210118224647.GK6430@twin.jikos.cz>
 <65ab6681-f694-5cc4-1b2d-b33b70ba40a3@gmx.com>
 <20210119155145.GO6430@twin.jikos.cz> <20210119160625.GP6430@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7a48d6b7-8620-b3ff-8bee-386da50f11bc@gmx.com>
Date:   Wed, 20 Jan 2021 08:19:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119160625.GP6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QRZlYMo9soDWznF/FBnxWBSA0Q0WHCr7qbP5lUc+RgFNlBndWq+
 LD9rNnY6eRIhbI/9lj60wWqee/2PhR7eRovDTI+ti73F2Ap2l0tMg2PvCM38DvLWi2RTC9G
 PnxtE74bYyH79i47fZvNqJfBBjOsGt4FnYH2E5SEIj1BwN1RrTJnyLpLW7/n/HDsoIgA89n
 I6Tl1pi+VDPMpLhtOQIqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/dZ/0iwLuj8=:OfBVOm0xkkOALptPgzwZ+I
 wXCMgbQSxlvBJWGExpPnY8VOy2DV3rRllW4xU3LE2faWqmqj/Eb/RksEgvIgAYFvM0bC21NOu
 nwS4pTj2ccLH99r4i4HGC5Os7ourj8Grc202dNFVR+hC+JKIdKxSaUyr+LjUSpN+W4evcIvXd
 2S78S/pxLOnY4qhDk2wEwHTqGAuZK2YK+qHfxmr1twbqZTkdq0SytSDScTJgLQ/jDWhL6ej76
 QNkX7UqYjlFKeRyPUD7/prcBgyOFwaHTVSMirLH6CLEo4/qrLCmDvZXMSkS7TXMFOa/VwkvXo
 BUwN0kFXglefc3Yydgydlg3cGIJtSeQEh/rOMSNicckt9uqqC7HwSNqk07Pv11u5w5r3uaph6
 9AYVdLMjCxqJ8vZm64AS5AlLQJAJywvCKi7HN+tnvg75wwHWBH1u1ZqWcgd1ve0w1fzZK3SWw
 /8x+57jOZl82E6A50ogCvfVXUZW9utHF7Gu6o/EbFE60t8qXdjsysoB0sEPPLiEtamAJ2kl+h
 qeO7ZJqKbSZEkdcVpXMkowKQK7Q6UeT9TpdiJS5yxTWSVhQO4AuwVAcskmrKWHM/o4hdgfRF1
 ErQ4CgyeO/erjv5S8nQnrtCJQtA+NajplHZqnP59bMEysWp4DZJMA62eyr+F/bMnm8gc810or
 xIL99bQDyRQoIyoxEuVC2BTz3Lh93588M/3TDpQgn7RR1EIEz1ckc/3JOElxARo5E5E9OulUq
 nsB1mZF472DmTnf+K+e6XDywSQdP9GLhzG1xbq979EtjJwyDjNk/uqWRXNHfCWzPrwjF51tCI
 6NFWAbRM/TveKF5dPNxmGibYJVYbqv/y5gyBcMDqP62gYx4iaHXLpe/sJeb/8zyEfg2FD4ESt
 QtZyC/P+PxZbNHpXlNhg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8A=E5=8D=8812:06, David Sterba wrote:
> On Tue, Jan 19, 2021 at 04:51:45PM +0100, David Sterba wrote:
>> On Tue, Jan 19, 2021 at 06:54:28AM +0800, Qu Wenruo wrote:
>>> On 2021/1/19 =E4=B8=8A=E5=8D=886:46, David Sterba wrote:
>>>> On Sat, Jan 16, 2021 at 03:15:18PM +0800, Qu Wenruo wrote:
>>>>> +		return;
>>>>> +
>>>>> +	subpage =3D (struct btrfs_subpage *)detach_page_private(page);
>>>>> +	ASSERT(subpage);
>>>>> +	kfree(subpage);
>>>>> +}
>>>>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>>>>> new file mode 100644
>>>>> index 000000000000..96f3b226913e
>>>>> --- /dev/null
>>>>> +++ b/fs/btrfs/subpage.h
>>>>> @@ -0,0 +1,31 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +
>>>>> +#ifndef BTRFS_SUBPAGE_H
>>>>> +#define BTRFS_SUBPAGE_H
>>>>> +
>>>>> +#include <linux/spinlock.h>
>>>>> +#include "ctree.h"
>>>>
>>>> So subpage.h would pull the whole ctree.h, that's not very nice. If
>>>> anything, the .c could include ctree.h because there are lots of the
>>>> common structure and function definitions, but not the .h. This creat=
es
>>>> unnecessary include dependencies.
>>>>
>>>> Any pointer type you'd need in structures could be forward declared.
>>>
>>> Unfortunately, the main needed pointer is fs_info, and we're accessing
>>> it pretty frequently (mostly for sector/node size).
>>>
>>> I don't believe forward declaration would help in this case.
>>
>> I've looked at the final subpage.h and you add way too many static
>> inlines that don't seem to be necessary for the reasons the static
>> inlines are supposed to be used.
>
> The only file that includes subpage.h is extent_io.c, so as long as it
> stays like that it's manageable. But untangling the include hell still
> needs to hapen some day and new code that makes it harder worries me.
>
If going through the github branch, you will see there are more files
using subpage.h:
- extent_io.c
- disk-io.c
- file.c
- inode.c
- reflink.c
- relocation.c

And furthermore, about the static inline abuse, the part really need
that static inline is the check against regular sector size, and
unfortunately, most outside callers need such check.

I can put the pure subpage callers into subpage.c, but the generic
helpers handling both cases still need that.

Thanks,
Qu
