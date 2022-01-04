Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF2484AE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 23:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiADWqx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 17:46:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:45235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235613AbiADWqw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 17:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641336409;
        bh=ZuHxqGk/fjrA3GAGSsuTFFOJH+EHXq2uIfiP3gX5/qU=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=he7dPqvRUFOhX5vuIKYqrEZz9IHy56gLqEKq6cu0M3v5LNoWs6+8EhGlP1ZQZ4puG
         +pjlbfIyDe1Q8Rbj4OdUiysb89EAiywpukbeW3EZlgvKk4bqMf2Z/a7hjuZTzmdi2Y
         ZoUXyyIdG1dntWkYnqkN0XdMFar59yLGLE5YOTas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO2E-1mcBfM2ZY0-00ooGx; Tue, 04
 Jan 2022 23:46:49 +0100
Message-ID: <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
Date:   Wed, 5 Jan 2022 06:46:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
 <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
 <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
 <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
 <YdSy09eCHqU5sgez@hungrycats.org>
 <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "hardware-assisted zeroing"
In-Reply-To: <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O+cFGnTVtHB2MZekNMTUuPzERp1aIWWhmw1V1HBvoeF1PW2YBBU
 GrS8azdYjdCxMCEFHzqHJGCZZKgadMPDmwo69Mn1ctK9yn3AMxdVP+i95fQovcqCJsGP6iP
 r/xuTrJ7XjBulk3pN5OdE0VKSp060p+TY6VWS5zNMBXE/2gERxU6xe7RSjM1N5PWobsRKfe
 rul4htBv3dBJFX+x5zZWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EiMAMXQj49A=:ga/gLws/zDHDy8/IFZse7G
 W/pJk/tQjlZJ+9ZY7HasupOYvyiUuacZUT2Vx2ya7SgZKJwlIBrG1QgblFt2bWQfI/55w+16e
 96bMlog+wtVo50Ji3rDHLKIZ77m39QBMkGdhCTz3mKacfSfqbJoXBpJnpXeq/YoOxovi9GdH7
 uAXEuqj8jdLiEJ2uZ3RiW5h1AGCMFoOF4kzwr1oPdrfEDtt9tGpDFdc08JdsGAQdWgyrgL+QZ
 PKiXy1XahDtRwMIdLA7ijq5waKKmu+0Dsav4HRdPsyjq7mCmb5NA0xndGDTdgcip2DxZOHfqP
 4YueYrqgThrGWB7HLUHby4mOKbQXHwIRYn4HA+nL8zSqqwaGWuTLH9Ori2CwvZAMXr441SU//
 ifij+XU9+td14oRBMz7uylvIztue87smD9+QcLyPRfhbzyP6FTUw2YRxl2bzqj4QgSZYmOv1J
 7P7TV+ebG+QhC5/rJafrUmH/JvLxvyXWU28tJQlSzD3X9NCVhA3HuUv81w7CjWpA4zcJrLC8f
 WQOPCWv2rFskCfgnXjNTZbxPqAIuwrIvzwMIqmlYGC71AWHzGHdn8IPpLSkc9RtFnoDysyhII
 b9a3vXUXZI6AeJuaMg6CsXxLmgfYGawpqV+/7LC2XQqiqDVwHTrszEPSzbOo1dP7Ev+L3KEX4
 ABvPlw9ARcgsI4tG01vtVm/kzdTieYdHiw8JyicWxVihauMaPJxsyumDTvRKpRyxWtZjq08Av
 bP2YDz0YdiRGmOQJyZlNt4SmVkK4bkg19qJvgLBpH9996953jA/ZgGQVhq0fl+G+uFpN3cHkR
 mokqm7wzEG5KIBFJW4hnbv66KP5iOaTdhsffxLB6OHz88tfXMfab9wB3YRvXSiV+y1zxex7s7
 H/iNubYdl9CuxtRDn4yY8ETiBK/JZFOQy3NCNAHfhzd6UiGk82XpS7aYiWoadOchN1NlFi7kb
 lQM42KnLCggJFnxdxBUmvGVXvLfZyzZHxlAblJV4U1Ay2S7PVj/fgN/5FPPlPWpjrReK3DWHr
 Xsv6u6iPLzHj90qvn0YDcBxHknX+qbip9VFBS10SYJTI2Uh+nfT5CTeEV6EbHNzWqUNyKXUf8
 xZde001x+ffNow=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/5 06:37, Eric Levy wrote:
> On Tue, 2022-01-04 at 15:49 -0500, Zygo Blaxell wrote:
>
>> Cheap SSD devices wear out faster when issued a lot of discards mixed
>> with small writes, as they lack the specialized hardware and firmware
>> necessary to make discards low-wear operations.  The same flash
>> component
>> is used for both FTL persistence (where discards cause wear) and user
>> data (where writes cause wear), so interleaved short writes and
>> discards
>> cause double the wear compared to the same short writes without
>> discards.
>> The fstrim man page advises not running trim more than once a week to
>> avoid prematurely aging SSDs in this category, while the discard
>> mount
>> option is equivalent to running fstrim 2000-3000 times a day.
>
> It seems much of the discussion relates to the design of physical
> hardware. I would need to learn more about SDD to understand why the
> operations are useful on them, as my thought had been that they would
> be helpful for thin-provisioned logical volumes, but not meaningful on
> physical devices.

I'm not an expert in this area, but IMHO the trim for SSD is to average
the wear, since NAND used in most (if not all) SSD has a write lifespan
limit.

This is a little different from thin-provisioned device.

>
> I wonder whether the same or a different set of concerns from the ones
> raised would be most helpful when considering management of non-
> physical devices.
>

For thin-provisioned device, it's a pretty different story then.

If the thin-provisioned device is just file backed, then trim brings
little to none performance penalty.

As such trim command will just be converted to hole punch of the
filesystem, and even on filesystems like btrfs which has very slow
metadata operations, it's still super fast.

So in that case, you don't really need to bother about the performance
penalty.

But please keep in mind that, even for heavily stacked storage, if the
final physical stack is still on SSD, the trim/discard discussion is
still true, that it's still recommended to use periodic fstrim over
discard mount option.

Thanks,
Qu
