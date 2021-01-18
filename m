Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867C22FADBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 00:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbhARX15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 18:27:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:39293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbhARX1y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 18:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611012380;
        bh=U2r5q8qDbDfPSgYhHB/bx5+wE0eWxIQT+PSOcK/YeG0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=F6N45ow0UcE6Fo8Yu/g3dH+uG8pN1sOwquHcHx3kfc1nEHkytzV3Iz/YOTjcvWZ/O
         X+Hguzuk5vAcPpFKk8r6Fva5SVFOjy1k/I3ARVGO4+n13sUm+d1KS25kMO3nC+EeXO
         Do33Ft+rwbMo9tHyyYRJhZNGx1gjJqFFA1qIta4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXtS-1lS91f3rZg-00QSdb; Tue, 19
 Jan 2021 00:26:20 +0100
Subject: Re: [PATCH v4 00/18] btrfs: add read-only support for subpage sector
 size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210118231744.GN6430@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9193d7a7-500a-044c-5964-593d93aa25b2@gmx.com>
Date:   Tue, 19 Jan 2021 07:26:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118231744.GN6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qxToMrOprMTpDNPXZ9S60p2syi53vhV8tmT+w8wGw1Qc0c+skCK
 PuOZFFMtVgTWzoGMurYnZkkNZEDnfYglPwN1XZfczNCEHFpzaJoU6OvIa2gk65GanzN0FL7
 Uh0Z72qC8LmUbLwD16fPw79MjZIOHHl/b2sLRs37EHv6TAIRGal4H3C5GzSLrBSww+fTXs2
 9W5/NWcchoy2DEnA1ZFEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hygysbjb0AU=:RNhnPePyd5rszhTpU3H2Dy
 JPBWUL/Ln4cbTtixj14SU8W1au/AybQ36wUp/VxBJ9Msh69sKVn0/lbeGnJQz7MOg/BM5zism
 w/vJWVBWGd6pmJqu3RhvDi3hxqn+UjKRwCEZ2JUeI0FYjt/UnHXTEl1nvbSfOLjrFtP7Ws73H
 pxo8h2x7KWD5Aaox2Bzqrl/Md1H7tQY80ZHucyJWoILUBgRzfKsW2dpT5182rTjPreaPh5c7L
 S9tNMNeycKdPbH0pkRmwwDoXVLrR1c0m6BaDBQ7YPgaaZ7ztmQUXs1qZnxvpAK2D3V5Xy2adK
 h7eXKttYR/Re42TrTixIefbst4yS1S3jPbSZX1l/HT2/L/HVnUv4ztF/uu7i6Dvt6Kct2EKaf
 CK93eg6pTlMimmTC8SBtzlM8paukVLBFXMp4jmeUwKNuSxfIkkmbUhsk1TujLtnUpvN/kSyf5
 5a0UMIUKq4hEOkgS1PMQeIaHyUROjzkdtXK38f3jXFWGDAMQtsXE1ddHqtPqHCSQb4MLM7B7r
 rObEgT9WiVGed4bsrJfKt+O2x/BwwpNnjIGWa/9b9Bi3HgIY4dSQ7HFW6odnBSnU6QGxUlyAv
 2GXx0lAdcSKZl6gYpTLCcYsErd9xFT0i3P6PrwyNU5aMCZ8/VowvglokTbwi/EYMAops8CDVz
 tORDsR3Y4fwCI4+IKpwLQkKRCI5OSWxcpko00cQXBmZoqHVPo1RX7egUUA9eVqLA5hAl0bINa
 DRyyPajwNIfb9qook7s0Nbcwtv24BsW06snoUkrgEM/u2sufggKFtm9d6pG7zG9PMZPpISh4F
 z13DGtlgGeHbIOXZvtqdwqSFBXud9r2kOvkC7uCAVkLquM0wqv99yPJ3Qau35bfJbGJzK+xjP
 8OdVrPxh0R42gtZe5qIQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/19 =E4=B8=8A=E5=8D=887:17, David Sterba wrote:
> On Sat, Jan 16, 2021 at 03:15:15PM +0800, Qu Wenruo wrote:
>> Patches can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>> Currently the branch also contains partial RW data support (still some
>> ordered extent and data csum mismatch problems)
>>
>> Great thanks to David/Nikolay/Josef for their effort reviewing and
>> merging the preparation patches into misc-next.
>>
>> =3D=3D=3D What works =3D=3D=3D
>>
>> Just from the patchset:
>> - Data read
>>    Both regular and compressed data, with csum check.
>>
>> - Metadata read
>>
>> This means, with these patchset, 64K page systems can at least mount
>> btrfs with 4K sector size.
>
> I haven't found anything serious, the comments are cosmetic and I can
> fixup that or other simple things at commit time.
>
> Is there anthing serious still not working?

Compression write (not even touching it).
Random (rare) ordered extent related bugs (from BUG_ON() due to missing
ordered extent to data csum mismatch).
Working on the ordered extent bug now.

> As the subpage support is
> sort of an isolated feature we could afford to get the first batch of
> code in and continue polishing. Read-only suppot with 64k/4k is a good
> milestone so I'm not worried too much about some smaller things left
> behind, as long as the default case page size =3D=3D sectorsize works.

Yeah, that's the core design of current subpage support, all subpage
will be handled in a different routine, leaving minimal impact to
existing code.

>
> Tests of this branch are still running but so far so good. I'll add it
> as a topic branch to for-next for testing and my current plan is to push
> it to misc-next soon, targeting 5.12.

That's great to hear.
>
>> In the subpage branch
>> - Metadata read write and balance
>>    Not yet full tested due to data write still has bugs need to be
>>    solved.
>>    But considering that metadata operations from previous iteration
>>    is mostly untouched, metadata read write should be pretty stable.
>
> I assume the bugs are for the 64k/4k usecase.

Yes, at least the 4K case passes fstests in my local env.

Thanks,
Qu

>
>> - Data read write and balance
>>    Only uncompressed data writes. Fsstress can survive for around 5000
>>    ops and more.
>>    But still some random data csum error, and even more rare ordered
>>    extent related BUG_ON().
>>    Still invetigating.
>
> You say it's for 'read write', right now getting the read-only suport
> without known bugs would be sufficient.
>
>> =3D=3D=3D Needs feedback =3D=3D=3D
>> The following design needs extra comments:
>>
>> - u16 bitmap
>>    As David mentioned, using u16 as bit map is not the fastest way.
>>    That's also why current bitmap code requires unsigned long (u32) as
>>    minimal unit.
>>    But using bitmap directly would double the memory usage.
>>    Thus the best way is to pack two u16 bitmap into one u32 bitmap, but
>>    that still needs extra investigation to find better practice.
>
> I think that for first implementation we can afford to trade off
> correctness for performance. In this case not optimal bitmap tracking
> with the spinlock. Replacing a better bitmap tracking with atomics would
> be a separate step and can be reviewed independently once we know the
> slow but coorrect case works as expected.
>
>>    Anyway the skeleton should be pretty simple to expand.
>>
>> - Separate handling for subpage metadata
>>    Currently the metadata read and (later write path) handles subpage
>>    metadata differently. Mostly due to the page locking must be skipped
>>    for subpage metadata.
>>    I tried several times to use as many common code as possible, but
>>    every time I ended up reverting back to current code.
>>
>>    Thankfully, for data handling we will use the same common code.
>
> Ok.
>
>> - Incompatible subpage strcuture against iomap_page
>>    In btrfs we need extra bits than iomap_page.
>>    This is due to we need sector perfect write for data balance.
>>    E.g. if only one 4K sector is dirty in a 64K page, we should only
>>    write that dirty 4K back to disk, not the full 64K page.
>>
>>    As data balance requires the new data extents to have exactly the
>>    same size as the original ones.
>>    This means, unless iomap_page get extra bits like what we're doing i=
n
>>    btrfs for dirty, we can't merge the btrfs_subpage with iomap_page.
>
> Ok, so implementing the subpage support inside btrfs first gives us some
> space for the specific needs or workarounds that would perhaps need
> extensions of the iomap API. Once we have that working and understand
> what exactly we need, then we can ask for iomap changes. This has worked
> well, eg. during the direct io conversion, so we can build on that.
>
