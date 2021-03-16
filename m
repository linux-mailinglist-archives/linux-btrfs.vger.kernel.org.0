Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2E33CA3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 01:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCPADv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 20:03:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:40269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhCPADW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 20:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615852996;
        bh=j5uxCNJbz/VbPSetyb7JBqJp44drZsHryfvKPUpkF4c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Z/lu1DHXgRr7wFsgRFNJhIZ/e2ncFAbqRnI06LzQYwhtJ1PsdUW1OtUM6kQAgENDd
         O3Bo+uqE4SIOExPItdws2tHy2A7tikvIYaBcsBrk/8Sy/qPD2h6NjcIv2GbQiUz8t7
         V3a93VQblS8hI5MwXtSAdGLek/teK03dUxlPkVSY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1lQKtn2nQG-004VvA; Tue, 16
 Mar 2021 01:03:16 +0100
Subject: Re: [PATCH 1/2] btrfs: fix wild pointer access during metadata read
 failure for subpage
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210315053915.62420-1-wqu@suse.com>
 <20210315053915.62420-2-wqu@suse.com>
 <PH0PR04MB741641D5C56FD335C864FD0B9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <f4ebad22-2004-b051-2871-8f1ed64cc6cc@gmx.com>
 <20210315185108.GA7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <accdabeb-81c4-c016-47f7-f0a137361788@gmx.com>
Date:   Tue, 16 Mar 2021 08:03:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315185108.GA7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J2srTlZQEVq0UvlCKbPKwaZFSvA8U+l9PoTAiaRE+HFxR9DwOy1
 pULdkvQcR3C7OQU3Wea+FeYjVZ6KqQE3NzPQJb5PNjG3FPcsCDflKfxtvVJT2srsd4+pbot
 g6C6HUeb5eopbP2wi2C4p4NX1/HU/yBcoVOIUdeXwoAGPqTs3ha4kfyTZHM6xQcGtQoVe0h
 WIrMDsW+guUpBi6xCWTIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:645gjUxsFvI=:iaFZ1TD6ByK47sTmfZi/+Q
 qWf6WtMAc75dIxwp1aZjaKrkwLp2JkmHPIgwafZ7Cxpg/AkQpDMR5Mho314HwiFhD30jvgWIS
 rv7DKndqs6PxRdjO/1LHObsx0+kz27so6Bf/c2hrIvyX7l1iV7putq/oryO5omzG3AV5YfHAs
 s5jOL6tk1l5q4OXC1yXa2DSd8u4ckekxAzBIr/gmKh2pNWRoILha4uD9FwH9QDt2C+kVZsiTR
 ZA5WT7/YHbokqQHYF62dmmN7jrAYiqamQq1vY+XwIbyZI7NQp/YQ/4HIJO/J+ZTkHWoNNNg3g
 cwqtMBQPzggI4pQ4JvbLA0nFzoyajXbaXx5yY8OiiVvDW7npM2IZzECqLFAtBHdnoIGdzNLwg
 i87xbOpsg/IdlcR0LNGmd5bAg3M9Woy4XpHiCeKWTFG7LinVwJ5gfSOIr9rdJ9nlK763kui0e
 I2EW3XCEWCE2qREJUjatrj9YkjJe4jmIqF0Gajgf2msacbpvnmykogh4PW+xXoapRthUBUjNu
 uYtGIa4Y9jBNIULyJyEOV+BoZpTcfZKco2VvJPbyso99MnOwriOk5qgfvmhNB4UmQ4YUvvszQ
 A8NTCQdD6P4G1SgWwYpvX2MHLtnGnMFNFT9wVbhoSzCt74eZae/B7hcVMo3O+rt4QVDAs4suu
 B8yDxylk1engDbpofGJFG+N0Ujd2wFbBPrU9eWtv4XdSnkUZp9UaPXXXmKONGInNC/5m3hNRW
 pnCVlO0IXpMEA4I+liuXdUCUEnkz+tQWN/ODcmJjuqvMbdqA6kqbbz2LfM12akPQXUb4WEwGE
 6pFrX+ecgXj3fTM1txYMXHqdQT9l8uLCTT7DAJoPVp225MUk+SaErwy7kbrtADVKt3yXqGexU
 1B5sR/9S6T/uw/eYxQqw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/16 =E4=B8=8A=E5=8D=882:51, David Sterba wrote:
> On Mon, Mar 15, 2021 at 04:25:32PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/3/15 =E4=B8=8B=E5=8D=883:55, Johannes Thumshirn wrote:
>>> On 15/03/2021 06:40, Qu Wenruo wrote:
>>>> The difference against find_extent_buffer_nospinlock() is:
>>>> - Also handles regular sectorsize =3D=3D PAGE_SIZE case
>>>> - No extent buffer refs increase/decrease
>>>>     As extent buffer under IO must has non-zero refs.
>>>
>>> Can these be merged into a single function? The sectorsie =3D=3D PAGE_=
SIZE case
>>> won't do anything for find_extent_buffer_nospinlock() and the
>>> atomic_inc_not_zero(&eb->refs) can be hidden behind a 'if (write)' che=
ck.
>>
>> That would make the eb refs change too inconsistent.
>>
>> But I get your point.
>>
>> How about calling find_extent_buffer_nospinlock() and then dec the refs
>> manually?
>
> Is this equivalent to this patch? Ie. the atomic_inc_not_zero in
> find_extent_buffer_nospinlock happens inside the RCU section, while what
> you suggest looks like
>
> find_extent_buffer_nospinlock()
>    rcu_lock
>    radix_lookup
>    rcu_unlock
> atomic_inc_not_zero()
>
No, I mean just call find_extent_buffer_nospinlock() directly.

Then manually call atomic_dec() on the returned eb.

Thanks,
Qu
