Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51A4C5FF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiB0X4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 18:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0X4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 18:56:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B156426
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 15:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646006168;
        bh=JU7+8NXc7EPuUu3r38CG53M6BgPQEmRPWZ9JM+2kv58=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i1k7JI2taW6pioJZRJWl07LY0H+ck10lRgBuu/8TPmtc2GXT2QvpLuOKVAGLzgg2t
         pLJTgSwJ85ESztsS6hSIDdXNGTe6rvtVceGRy3SQ+6RJwio8or1jAugosJaZvyO/B6
         hxOHrBYumHfAuutxH7XbQuAG43ikkdg31Cf5kqa8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhhX-1nX1aC0kxb-00AmoD; Mon, 28
 Feb 2022 00:56:07 +0100
Message-ID: <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
Date:   Mon, 28 Feb 2022 07:56:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Seed device is broken, again.
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YhkrfyzmCgOGG+5n@relinquished.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ujnwgF9qpMKCz3tSn7OSmrkutJSZ9l8sXfkWaN+cNSY6Og1feKw
 N+slQ0T1zapJo+u+C+uSoK43N265d3jdoWTeN3MqGxSyGWVKiMbcvDdqCZ71gqFUeV3jv82
 QQVqUQXHFBZDsHy7+/h5a6rZzDPNKfXSYaoNVpf2WZthLdj8YYVApbQKg9ZhZAamDszGuC/
 R0TbO4ZFzFRmn++PaSEpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HSZnjaHoOVE=:BFVDt0YvD4fu+t7i2QoMXq
 CMWvuRqwRUAKZkdVyPr43W+HVFpgK5XRcSC1eBcGFkzbsj2d+3+warcabR1Nd5lozwHhW2yGN
 Cn44TipV9cZ1tSsVrv470/9HJ5UwS+9aC/9ndLqahyDzLcFAmxOMisPEple7LNSSyV1hOwWfv
 gZqQ9/3yOt1DBnQHe8bKftYLK/zEumdqWOT4xp6c7TYHB3qg3Z/ECQzOTEWEMOjmUGHuG4EWr
 2BNqX90vLKk22FBGcB4ISp09C2mcNha2Ar3gAFogafMlz7gR66nyAlVX5w0TxcDOx92A9VNhp
 6cDVmQgnZtQP4/cStsL7EAKHoxv333ZKE5B7c+HkWZ8tAnl01ox+EH4jmEK2KQFv9VzS/RDGA
 6Ptum9Ev8469oEa11dF7HzVRQ1x+DQjUD+UWu5aoD9UDMLvUPcNwazkm0i8bQTAzbB8dYIzUG
 jdGLpAjB0YBKiHkMoewLzCrY/BNzPtBJ2goBE0qIZIkeYzu82aLwjRVzZ3S+KPoR2zQdt2mEg
 tgbdrjq9+KeyFfofdtW7amNY/tqhbtShGOBTQPZKx9tRwxYpJw3y+m+P+kWIiPxybEL/lW2jz
 oVMZQhkeKh0yFIFq+TdX4ArDblwvMKP1FRO8jIZBqlLo3MLlVEq+9EJz60KY1o32Q92nBlU0B
 zZjeWjPZ7A/wwfN9P04xD2eaZ2Qzsu3ulzZdJ4PBnKFyQnfI06Kdhs/q+MzAtklHyRiheaHpJ
 RVus6VfeyMZBOT/LHnCihfPkaPvBbR/u4s5BEDQ4pgA2QTRp26PXpuYnHriykJOh1fKGsmdvC
 xd2FnVJy1StLsUuZb+eIxw2hHkCuzAOCR55RI/oV5qWry0taQOuVkkrT2KYFTUMTC5tyFdhs6
 sWxjD/noPoQJQKOWuWCggWSFwAJC8G0dFBQeYwyCfDunK+TjqKxZhGOQzeihBI/LM2y6s6C0Q
 xSCWJXYrX0dS8t8xdqxIBgqHlt+kRlagINbgPKNCpsIzde03BCEgMowHWBLfG1+NWbn6KZhEo
 WlgRiRC9Y8u9F0PtRCPnZXmhYEvGj4qXxxLKE6V5R1PhPavxS7XgttQyrQ08yGtjEd6D9BdTe
 HqKgJ82UaJEkiQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/26 03:18, Omar Sandoval wrote:
> On Fri, Feb 25, 2022 at 09:36:32PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/2/25 19:47, David Sterba wrote:
>>> On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
>>>> Hi,
>>>>
>>>> The very basic seed device usage is broken again:
>>>>
>>>> 	mkfs.btrfs -f $dev1 > /dev/null
>>>> 	btrfstune -S 1 $dev1
>>>> 	mount $dev1 $mnt
>>>> 	btrfs dev add $dev2 $mnt
>>>> 	umount $mnt
>>>>
>>>>
>>>> I'm not sure how many guys are really using seed device.
>>>>
>>>> But I see a lot of weird operations, like calling a definite write
>>>> operation (device add) on a RO mounted fs.
>>>
>>> That's how the seeding device works, in what way would you want to do
>>> the ro->rw change?
>>
>> In progs-only, so that in kernel we can make dev add ioctl as a real RW
>> operation, not adding an exception for dev add.
>>
>>>
>>>> Can we make at least the seed sprouting part into btrfs-progs instead=
?
>>>
>>> How? What do you mean? This is an in kernel operation that is done on =
a
>>> mounted filesystem, progs can't do that.
>>
>> Why not?
>>
>> Progs has the same ability to read-write the fs, I see no reason why we
>> shouldn't do it in user space.
>>
>> We're just adding a device, update related trees (which will only be
>> written to the new device). I see no special reason why it can't be don=
e
>> in user space.
>>
>> Furthermore, the ability to add device in user space can be a good
>> safenet for some ENOSPC space.
>>
>>>
>>>> And can seed device even support the upcoming extent-tree-v2?
>>>
>>> I should, it operates on the device level.
>>>
>>>> Personally speaking I prefer to mark seed device deprecated completel=
y.
>>>
>>> If we did that with every feature some developer does not like we'd ha=
ve
>>> nothing left you know. Seeding is a documented usecase, as long as it
>>> works it's fine to have it available.
>>
>> A documented usecase doesn't mean it can't be deprecated.
>>
>> Furthermore, a documented use case doesn't validate the use case itself=
.
>>
>> So, please tell me when did you use seed device last time?
>> Or anyone in the mail list, please tell me some real world usecase for
>> seed devices.
>>
>> I did remember some planned use case like a way to use seed device as a
>> VM/container template, but no, it doesn't get much attention.
>>
>>
>> I'm not asking for deprecate the feature just because I don't like it.
>>
>> This feature is asking for too many exceptions, from the extra
>> fs_devices hack (we have in fact two fs_devices, one for rw devices, on=
e
>> for seed only), to the dev add ioctl.
>>
>> But the little benefit is not really worthy for the cost.
>
> We use seed devices in production. The use case is for servers where we
> don't want to persist any sensitive data. The seed device contains a
> basic boot environment, then we sprout it with a dm-crypt device and
> throw away the encryption key. This ensures that nothing sensitive can
> ever be recovered. We previously did this with overlayfs, but seed
> devices ended up working better for reasons I don't remember.
>
> Davide Cavalca also told me that "Fedora is also interested in
> leveraging seed devices down the road. e.g. doing seed/sprout for cloud
> provisioning, and using seed devices for OEM factory recovery on
> laptops."
>
> There are definitely hacks we need to fix for seed devices, but there
> are valid use cases and we can't just deprecate it.

OK, then it looks we need to keep the feature.

Then would you mind to share your preference between things like:

a) The current way
    mkfs + btrfstune + mount + dev add

b) All user space way
    mkfs /dev/seed
    btrfstune -S 1 /dev/seed
    mkfs -S /dev/seed /dev/new
    (using seed device as seed, and sprout to the new device)

With method b, at least we can make dev add ioctl to be completely RW in
the long run.

Thanks,
Qu
