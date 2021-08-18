Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB53F02B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhHRL10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 07:27:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:36457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234903AbhHRL1Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 07:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629286008;
        bh=eKJRaXgtgMHVcJr7E8nQiwvXiuavp2HjYNiSXb8m0fY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fuc1tKLGrOxpuchgUlNfR6xdI5aAD9xtMht70hlpckROgfxHn9pgJ7gmC6GJy0wDq
         pXNdk0C+tyFCIRV/kwci3bfXbJ9uQUHmJRNDpTcUZMkxLrQsNq/7x8LDf0qe5Dn/Al
         xyDJZO8t0U+icxq9sTypMwgssyW9Z0cih0hODu6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1n8Fly21Ov-017j9s; Wed, 18
 Aug 2021 13:26:48 +0200
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
To:     dsterba@suse.cz, Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <20210817132419.GK5047@twin.jikos.cz>
 <04abaf84-12e3-3983-dee4-a5073ec786f1@gmx.com>
 <20210818103542.GR5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9c0ac24c-b43d-419b-c1c7-4f8a226d4f62@gmx.com>
Date:   Wed, 18 Aug 2021 19:26:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818103542.GR5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IcOEEUWhZlfp2t1UBVbOIrRGThdDC1SyfeBWi20H/+7/roIwtaJ
 eKHr99YMDxFyDWGtbTwkxBMJjVndyuM4fUzCl4vKSoBdk7YMwpjQK84kwkMwg8XBNoNA25G
 c4nIaYZrOZ/xAgstAygYN7O2stnT0R7yLP88tib4hsVT0bouyKU75zuGe8xgAp+bDFh2qR0
 68DfgvouDR4T1EXTI3BJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZiU86rcked4=:JCZ0sq5GgCi/XXd2q3zqlz
 CZRuawn/fsNos0LGKyEP4j1CcJkF3T3rM0BXutkh/hVp4mGruNF6WWi1gFsA0oMJWBDMu3Xeg
 lN6UppmdwT0YGvI8vJv7jj5+x5+mfOJmzxPyXhxDW2kxs2Lz7GgjrKr0/eDszHGJqi8XvTliB
 mdBS505THsWKjingscPcQomgv49FY5xTpXxuUocy7nI4/4OEx+7gFuBoC1tLtNUj4cwYMBLKR
 OaPzqT1nSAWwu5Qs7RxRWP0bZtqABWVaUSM0PvjVgNnDmva0ofZI26VIwMCpEzrRN3w9B0NAD
 eOksLu+lHxFziAhHua5psgQ+gKBtNG93ua9JnL65szHETm0XgzJs8AA4a3pZVJbDCa6p8V8E8
 GYdGdoCWYKTJngX3DlHN3KxKubFMnOTi2ng902gswCMcAkzLEJlr+Bp8wMShvI+ZFXuk9llwn
 XmpqtjfWbOkYbG+jZ8iOVKlBWNqIL3Yj4Bv0l73hGDRdeH015cribzYsc0ES7XrpFIL2B2TsZ
 /qRFW8KbFSQVZ7FWVB64d4zfiiNmPPFMRofTQWZZUU4jjegPAPHlJqR7aXqEL12gBRrdOFdUU
 XU+By61EMZ6lfBa+BDwyhXZiHAdte/gbymFWu3MpcekmTVLjbURxL8+7Yuk7+TEay854xA96F
 wbgxWUIjT9koQ0VcDNZmpjA4uTG+C/kSAxWwxz3eHI+hlQWSD2w8SPSCappuef27dd66zUDZN
 6EDH+kBaHrTEv2BbhtejA38XaETwNaa3lmG/U02OxnMSU4mseQVnY937+mHkRvY+41R/nhi/0
 Yt6VqBj08hO6jzBoXkCSOT72NNt/v7D26CM0VGrZNLa0NjAzRqKO3CLznov1IfVqHJ141D5tA
 xCUfB8+bYehBkYK6rBcW12/Nxz8UUx7gYEUrpntdJZlQlwMi5f3gKlz11t6NaqbUEMoihfnkv
 ve+ox3fhmB6AwzHCWvxMkF0+mXyvrAi7HCXfl0QxOW2fMI9ivdNqLwZ5Z6aLg4djAwfMv73ma
 Z0DxlE7rkxWDYlm4RtAF/ZrVm2gTbZb1FHRH8ux8trxexARIoEAdDtpOgYV/sk794gpgFfZMk
 Y0Ib3n3CUXiZYVGHyXROpn0/0/3iQatNfyheeJciU3zuSDHrhL+CqYMcg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/18 =E4=B8=8B=E5=8D=886:35, David Sterba wrote:
> On Wed, Aug 18, 2021 at 01:17:46PM +0800, Qu Wenruo wrote:
>> On 2021/8/17 =E4=B8=8B=E5=8D=889:24, David Sterba wrote:
>>> On Mon, Aug 09, 2021 at 03:26:13PM -0300, Marcos Paulo de Souza wrote:
>>>>
>>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>>> ---
>>>>
>>>>    This change mimics what the kernel currently does, which is set th=
e stripe_size
>>>>    regardless of the profile. Any thoughts on it? Thanks!
>>>
>>> Makes sense to unify that, it works well for the large sizes. Please
>>> write tests that verify that the chunk sizes are correct after mkfs on
>>> various device sizes. Patch added to devel, thanks.
>>
>> It in fact makes fsck/025 to fail, bisection points to this patch
>> surprisingly.
>>
>> Now "mkfs.btrfs -f" on a 128M file will just fail.
>>
>> This looks like a big problem to me though...
>
> This is known that the small filesystem size and intial chunk layout is
> not scaled properly, the patch OTOH fixes the more common case where the
> normal block group sizes fit and leave enough room for the rest.
>
> Can the test 025 be scaled up so we don't have to create the 128M
> filesystem? I'd rather go that way.
>
Sure, we can scale up the size, but this still indicates the problem of
the progs chunk allocator.

So far that's the only failure, but that also means, the minimal device
size calculation is no longer correct.

As kernel has no problem allocate SINGLE chunk smaller than 64M.

I'd prefer to unify the minimal stripe size with kernel.
(And of course, also do proper chunk size calculation for metadata chunks)

Thanks,
Qu
