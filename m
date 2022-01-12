Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4241148BBE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 01:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347255AbiALAdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 19:33:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:57597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347256AbiALAdg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 19:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641947610;
        bh=GcoGyti466eO8VRFFCV0UqRh6qw5z8BSMIVOjcfZkKg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=TxbACFOv2O08CF9KKrFPEAMzKhGfc6kDu04EXRbCGW1PoiwGeDS83gufQGE3WsIIw
         zctAdhHe4l0aY8eGEHWq78bCd2AfFod6keHpgBNnUrWdovFhXw9i8bZux0SZyUb0d+
         L8QPM3x8BPqpLjMjtN7XsKhlI6A4jDfTgzJdr478=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1poA-1n5Fib0BWS-002KNJ; Wed, 12
 Jan 2022 01:33:29 +0100
Message-ID: <64e131e5-bb42-5b42-d87c-bb4048a44989@gmx.com>
Date:   Wed, 12 Jan 2022 08:33:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20211206022937.26465-1-wqu@suse.com>
 <PH0PR04MB74160D826D891E5E543603769B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416374BC39FEF504430C1D59B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <253c767a-4599-94dd-1c65-34d34aaaebaa@gmx.com>
 <PH0PR04MB741670CEF6419687BC70A06A9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB741670CEF6419687BC70A06A9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJZGGGxYPV8QcjHU1zOUF4lmFstBTC2cXw8FDVgSkEw6DcYT/G5
 jhU2dYKBMc7hqiBdApFxsRqh/XJ6iS5esoe3efsC797kZAzEi64cRYqnnXWJdtiAU6PLNKT
 DDnQV/dMr4kpCiR6BW8sDx4UggiR06oJ707scRxHjULFKx84xCqpHT+P5uznHvZRfJaH41E
 wuQwpcTVyzqfc+syyhV9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jqqi0gnIuyg=:Dye+JGpCPfZDvj52DA8Sgs
 LkvfVQHxAn3GU7Inu14L9kOIoVdR0EFDXfCgpEJCmzkl++CdPa8RwX2909O2rNq3nmBR1YeIT
 ABNB7r7SbVNzkaaP2awyFxWzFEIg8afNYSmkkPdjBiAKUZJGAd0BtEaWgixmWu9EpjXQzmDVB
 dtkHzJon7N17XsJOYp6aS+pPEm22ay/0E+n5/iI8UtHZiOAaOZplDyZp/HyXAK9BhXqL175QR
 XDMEJsqoHpNF7jYURPn3vzjefQZTPnHPkoX5P91BiSajAFfWd1aARWZyvOpYYhH4glu/pTkN7
 6HAwN0Y1IFCGPMeWzXSmhBKdhQYHGyjYFEJ8Ma2WrMMNq9rtJzFDU5CaN6Oo28O7Ib/kLnQrq
 ld/QlwAMuq/mk7+IZVAvL79sY2KENxp8N/EwoK1Me7V2iCLn+uRh3O8tNSOYKK4PNJvxIQJCU
 +PqhAgpRvgro9G54ugKfQGPY4mGiw9f9YRpNPvVgDfqkMXLJuhucYLh3XVSlnQvMSwVpA5lXJ
 tkYAIANhkVCQw8mOJtvqkrdACmDVEfzmZvOLFYdqPG7JMopEELf4xTz2nVyrf9DsDERGN23P8
 buoEzTsQAoDuGQzFj5M1UjCfn5UwiM0ajXbhP9VXqnbdHNsh5Kx2a/tEmBflJKe83lSz9qUxc
 QbL39kA3Bt77e7hOFcyVHTpg/UoD/iqH3ax5q2q3awVZAbVMF5FSJeRMZSssG9H/8sAE5P2Pd
 rt4O3Eu/4JOtQnqvnQG9TgTAkq1++b2GUGw93ARr6n5DbPH2l71zYc6keWVN4agfDIFCs9IxN
 j75mXs2sFEnpU/E/GrCYJ0R3rFSfkFisr8TyN3FVisMlKPTrN9nGoombSzeZlc9Gdtgka1lXV
 ClFpVUDrzEnL4SqO9oumZ2ua61y+Sl0lcmSbNfSvPxjZ/skccwN5YLZNpz0C0kHCEO+KV8pNp
 sZfWP0ru0szR/AxsDUtjPjSxeBad4GBlooZek0BiEYy8pdgn3hIVct4KQPtoLoEvyJHEb7uio
 yUUmTrd2C9G8PgI/2FJjv1OFAYxs3AW7rNg0TmXHnAC3XYCq67Sejj2aBfnOnrS+Z4GxE7HPc
 xr8I3i+4q59iHM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/9 19:13, Johannes Thumshirn wrote:
> On 09/12/2021 12:08, Qu Wenruo wrote:
>>
>>
>> On 2021/12/9 18:52, Johannes Thumshirn wrote:
>>> On 09/12/2021 11:07, Johannes Thumshirn wrote:
>>>>
>>>>
>>>> FYI the patchset doesn't apply cleanly to misc-next anymore. I've
>>>> pulled your branch form github and queued it for testing on zoned
>>>> devices.
>>>>
>>>> I'll report any findings.
>>>>
>>>
>>> Unfortunately I do have something to report:
>>>
>>> generic/068     [ 2020.934379] BTRFS critical (device nullb1): corrupt=
 leaf: root=3D5 block=3D4339220480 slot=3D64 ino=3D2431 file_offset=3D9625=
60, invalid disk_bytenr for file extent, have 5100404224, should be aligne=
d to 4096
>>
>> No more error message after this line?
>>
>> I thought it should be either write time or read time tree-checker
>> error, but I can't see the message indicating the timing.
>>
>> And yes, that disk_bytenr is indeed not aligned.
>>
>>> [ 2020.938165] BTRFS: error (device nullb1) in btrfs_commit_transactio=
n:2310: errno=3D-5 IO failure (Error while writing out transaction)
>>> [ 2020.938688] BTRFS: error (device nullb1) in btrfs_finish_ordered_io=
:3110: errno=3D-5 IO failure
>>> [ 2020.939982] BTRFS: error (device nullb1) in cleanup_transaction:191=
3: errno=3D-5 IO failure
>>> [ 2020.941938] kernel BUG at fs/btrfs/ctree.h:3516!
>>
>> And this is the most weird part, it's from assertfail(), but no line
>> showing the line number.
>>
>> Mind to provide the full dmesg?
>> I guess some important lines are not included.
>>
>
> Let me see if I can reproduce it with a higher logging level

Any follow up on the crash?

I doubt it's related to the patchset, but I'm also curious why
tree-checker is triggered for a test without any dm-flakey/dm-rust/etc.

Thanks,
Qu
