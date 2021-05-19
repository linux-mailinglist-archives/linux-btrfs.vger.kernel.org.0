Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E50388F73
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353757AbhESNsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 09:48:07 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48955 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbhESNsG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 09:48:06 -0400
Received: (Authenticated sender: swami@petaramesh.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6FE4F60007;
        Wed, 19 May 2021 13:46:45 +0000 (UTC)
Subject: Re: System freeze with BTRFS corruption on 4 systems with kernel 5.12
 (MANJARO)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a924147d-1403-369b-85d5-a5ba5be662d8@petaramesh.org>
 <31eea3fb-926e-ce69-95bc-5ade744100d3@gmx.com>
 <d88d8d90-9218-dd51-a47e-7b7c507eb583@petaramesh.org>
 <2e5259da-fcec-0abe-09a6-3c86c1750477@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <c2989b24-f8a0-d01b-3584-8c0bb2c056ab@petaramesh.org>
Date:   Wed, 19 May 2021 15:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2e5259da-fcec-0abe-09a6-3c86c1750477@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/19/21 12:02 PM, Qu Wenruo wrote:
>
> Have you tried something like net-console to catch something?

Nope but the machines were each time plain dead : screen frozen, mouse 
frozen, kbd frozen (LEDs not changing), no ssh, no ping, not even any 
reaction to [Magic SysRq] keys...

>
> If it's some hang, after 120s it would have some dmesg popping out.
> But in that hang case, you should still be able to do a lot of things.
>
More than a hang, appears to be a complete kernel crash.
> Without the dying message, it's really hard to further debug.
>
I would guess so...

> AFAIR it was some kind of “generation mismatch”, expected something,
>> found another, in very large quantities.
>
> That means flush command doesn't work as expected.
>
I would suppose that those machines running bcache in writeback mode, 
some data didn't make it to permanent storage at the time the system 
suffered a sudden death...

Thus incomplete or out-of-order data on disk.

> Considering there are extra layers involved, it's pretty hard to tell
> which is the cause, btrfs or dm-* modules.
>
Well... My view is that the systems crash with or without bcache, but 
BTRFS gets corrupt only when bcache is in use. So I would say that 
bcache is not responsible for the system crashing, but is responsible 
for data not having been properly committed to disk in the good way or 
order at the time the system crashes...

I was wondering if you got any report of other kernel 5.12 issues with 
BTRFS in different configs, or kernel 5.12 crashes that might not be 
related to BTRFS...

>>
>> The machine with BTRFS RAID-1 could heal itself out of this by running a
>> simple btrfs scrub,
>
> This further proves it may be lower layer doing something wrong.
>
I would guess so...

> It's really a good practice to have LUKS under all your fs, but it also
> introduces an extra layer of flush problems.

Yes. However I've been doing this for years on a bunch of machines and 
never got any problem that would relate to this except with this 5.12 
kernel.

I was however wondering if some new optimizations introduced in BTRFS in 
5.12 could have made it prone to crashes or maybe something not being 
properly commited to disk, use of fsyncs or barriers or whatever...

> Did you have any raw btrfs directly over HDD/SDD experiencing such 
> problem?

Unfortunately I don't have any BTRFS out ok LUKS, except for /boot on 
some machines, but this one gets so little activity that I wouldn't 
expect an issue with a /boot partition.

Thanks again for your help Qu.


ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E

