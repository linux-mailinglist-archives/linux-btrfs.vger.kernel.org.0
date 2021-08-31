Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C23FCFB7
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhHaXAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 19:00:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:49011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhHaXAB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 19:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630450741;
        bh=/goVm610HBWwRTwznpYXQNq6tkyQJ01jG4J9ao7Wj/g=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=TdKwU4XP2oowil2K/bjRP1z5tZYtCVBfbr8AF0eDD3mDrt6B+yaGKJsunFjkcJozB
         rNNBUZ+/1cWtKtemq7fyZrUBLf6CaCEpeWSaVQileKdyXVU1ztqPoeruupJTkiUDFC
         oZPzwl14r195zQ3EcZdxX8QoJY6GIp+TwU2tIFyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dwj-1n6eYb123x-015Yhk; Wed, 01
 Sep 2021 00:59:00 +0200
To:     Greg KH <gregkh@linuxfoundation.org>, Qu Wenruo <wqu@suse.com>
Cc:     rafael@kernel.org, linux-btrfs@vger.kernel.org
References: <20210831065009.29358-1-wqu@suse.com> <YS3S5Nd5YW5pwcta@kroah.com>
 <9236c202-03f0-e42f-e9c0-cde6a5bfad19@suse.com> <YS6Laf6AT3Bhwxeq@kroah.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] kobject: add the missing export for kobject_create()
Message-ID: <17c7a0b4-86ea-a32d-7190-b3a4a4aaaf65@gmx.com>
Date:   Wed, 1 Sep 2021 06:58:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS6Laf6AT3Bhwxeq@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nv6czx6fuZ4qMaMYy6/2IivbWV+JIH35uwiI4XbAND2edxLuZxk
 HD/nIdH7KY/VrS2vWVjIuMQKCSGgggM0HF43AWdHYXZrT+q2gITTPRCh7QyMzakxKAG7WYG
 J1o5BmTFqKWWolWWo1GAtTQK/dQqQ1LF4o1ZhYJiH3MEQhQB7dGm709ltyp/9hK6CPo5YuN
 3Z1Ch4GMgdlcGkSJKziVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8KOvCseitks=:B0KiLDMD+56RBsTCJXXR4V
 Bnhe9ATknjlgOcJssO4OSWFE6OWXkghUI8jFJkwyuCDh1Egu6jIhgS1945uk04SZqCcWxTAfB
 kNXxb88+jbGDZFxHaYnJ6uDf/JAb+LdflHRNRqcFzchuDuGjQmifWfBaONd7VZuzPyROWQ3B8
 iFOsnCUEWrmCDoE9yH7giMFNRJMLC3yn1oGpn0/YhKqyH4qujH16ct9oS9FwMlOZ8R6HF2D/Q
 WdLLsqHKfbtIzQO9xK0J6gOnkwPG+gz9DmyBGYvWpPGu0nE41R/6yRkePAU38KjsroGah8Dsl
 94PnrlVpHwsRan0nwJ7aZVZf/entmjkr5cidtymbahBkDRKMzT6LX0F4pnbUqtYlZ+bsZc9Nt
 b7ogevLi9ouUa1Bel3xqT7+B1O/nfdHQ9aguQwWFSDhx7X7CGMm6sPoJjOvjktQdeOV6F8NwM
 iDLs/A3ULHArzrujE+FO5tJtTFd6wqeeH9DhwoscAVUk9xzU+IaAE4kChofjIC9mZS1d/a8GH
 AgjloAyzKEG4WV2Z0KLnZ78X9aO6acPnXz6OFxiESeNkbAS3J+T3D9N94CbyqYZ47MO2zuwO7
 xpjlIwhmXffjboWe2e9WzcgM7tuT9sQssHhb9NCbbIw1aMp0Eo7vk0kiP/13xqLpD7f9KIdTj
 OENa8Jybq8fcQFbxDnz9SPnpBts7KiNWwEdmpVNNISwDrwGCQBP7j9S4+MKPuYUXkN8WX2/Ar
 qwc5vLKR//+fjketd5P6U+kBkKkTVCZmjGp2niZLDqA9jGqM0JthAaWBRSdV5LnWTFz9kDbYG
 Szl+dayF5Hqvm835YKdxHnU5W1ZLldrZb2mkL+sXCKCY0oLUz3i/ribWjcQz3cjZJ9/0wW6SD
 aBWbd0kMXgLQqB1JxCGippr6JnWYxA/3PZ7MyTVphvKI13q2KfDyztTANVLzfbNEp+uguSJ9Q
 ldPATHqiRBaruiVcbkFfxtkgKQXmDdjYQkXFcGJBLnUJl3ShcIa1hSiwM3dCOwkq4qfDXM1ch
 GBo0vyCv8LrPOWLVHSic8YsUIQl/uLu10M3QTbc97yBT/0GBdiDdRQwGDFwyt3GZHGb/N8BU1
 8ku5nAo3Ea5EMRvsXXfyvOY04c0g9/0r5k0yl7pbtezOqynmIdNh7gv2Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/1 =E4=B8=8A=E5=8D=884:04, Greg KH wrote:
> On Tue, Aug 31, 2021 at 03:53:02PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/8/31 =E4=B8=8B=E5=8D=882:57, Greg KH wrote:
>>> On Tue, Aug 31, 2021 at 02:50:09PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> For any module utilizing kobject_create(), it will lead to link error=
:
>>>>
>>>>     $ make M=3Dfs/btrfs -j12
>>>>       CC [M]  fs/btrfs/sysfs.o
>>>>       LD [M]  fs/btrfs/btrfs.o
>>>>       MODPOST fs/btrfs/Module.symvers
>>>>     ERROR: modpost: "kobject_create" [fs/btrfs/btrfs.ko] undefined!
>>>>     make[1]: *** [scripts/Makefile.modpost:150: fs/btrfs/Module.symve=
rs] Error 1
>>>>     make[1]: *** Deleting file 'fs/btrfs/Module.symvers'
>>>>     make: *** [Makefile:1766: modules] Error 2
>>>>
>>>> [CAUSE]
>>>> It's pretty straight forward, kobject_create() doesn't have
>>>> EXPORT_SYMBOL_GPL().
>>>>
>>>> [FIX]
>>>> Fix it by adding the missing EXPORT_SYMBOL_GPL().
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> A little surprised by the fact that no know even is calling
>>>> kobject_create() now.
>>>>
>>>> Or should we just call kmalloc() manually then kobject_init_and_add()=
?
>>>> ---
>>>>    lib/kobject.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/lib/kobject.c b/lib/kobject.c
>>>> index ea53b30cf483..af308cf7dba2 100644
>>>> --- a/lib/kobject.c
>>>> +++ b/lib/kobject.c
>>>> @@ -788,6 +788,7 @@ struct kobject *kobject_create(void)
>>>>    	kobject_init(kobj, &dynamic_kobj_ktype);
>>>>    	return kobj;
>>>>    }
>>>> +EXPORT_SYMBOL_GPL(kobject_create);
>>>>    /**
>>>>     * kobject_create_and_add() - Create a struct kobject dynamically =
and
>>>> --
>>>> 2.33.0
>>>>
>>>
>>> What in-kernel module needs to call this function?  No driver should b=
e
>>> messing with calls to kobjects like this.
>>
>> But kobject_create_and_add() can't specify ktype if we want extra attri=
butes
>> to the new kobject.
>
> You didn't answer this question, what in-kernel driver needs this?  We
> do not export things that are not needed to be exported.

Then the function should not be declared in kobject.h either.

Originally I just want a dynamically allocated kobject with extra
attributes.

Thus I look into the callers of kobject_create_and_add(), and lsp points
to the header where just one line before kobject_create_and_add(), there
comes kobject_create().

But after more reading into kobject.c, kobject_create() creates kobject
with dynamic ktype, thus in theory we shouldn't change its type halfway.

>
>> Or is the following way the preferred call style?
>>
>> local_kobj =3D kmalloc();
>> ret =3D kobject_init_and_add();
>
> Depends on your need.
>
> Why do you need to call this function from a module?

As explained, a want a dynamically allocated kobject while has extra
attributes.

As kobject_create_and_add() can't have extra attributes, while
kobject_init_and_add() needs an existing kobject.

But now I understand why it's not that possible, as kobject_create()
will initialize its dynamic ktype, thus with its .release function fixed.

Currently I go the kmalloc() then kobject_init_and_add() way instead,
and the .release is just the same as the dynamic ktype to kfree() the
kobject.

Thus I send a new patch to unexport kobject_create() from kobject.h.

Thanks,
Qu

>
> thanks,
>
> greg k-h
>
