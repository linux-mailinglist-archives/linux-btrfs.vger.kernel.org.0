Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150E82DDC71
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 01:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgLRAnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 19:43:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:33909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbgLRAnw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 19:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608252139;
        bh=Gx8n3m4tp1HpJngoZ9vdKRkzHaBTtzTtQI0tssnff3c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=W029lIYZuqo5oPVixMM6AsWXrwwkP9LPbUfwEELACLSImhpKT5m64TgjUp5r7dydO
         WE39pL5YQueMg8mt/Cn9NR/P4GRW6Ni9RqwYZ2omxxDgWtWavnOX/oIowFo/MqgxdD
         nN+eWWsJLwk9PlrJZx2tyM8Bgluq+sbRoZwkEi2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1kwLMh1uor-00BJze; Fri, 18
 Dec 2020 01:42:19 +0100
Subject: Re: [PATCH RFC 4/4] btrfs: inode: make btrfs_invalidatepage() to be
 subpage compatible
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-5-wqu@suse.com>
 <778948b8-ec8c-fcbe-310f-eccb37d424f8@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <573bdfd2-54f3-d4f8-1030-4a8c158e54fb@gmx.com>
Date:   Fri, 18 Dec 2020 08:42:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <778948b8-ec8c-fcbe-310f-eccb37d424f8@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pAUK7glR9GKeBYfr0LiQf3TUi5fXFnJARJKhbswJm/kN6j4jcKG
 9nGdNv27v+Tr6br8nNXIbldMt5A2qayGH/7qIXaGjp5nzojc3uL9QuTzl7cD6s56vjqZCDu
 4lC0l7udZrMa0EbgpZsdMXPVuDfS36N/EBUAB2kAfIp5Yv6iCb58gXi17yA7/NZcFS1FTVQ
 kYrAMJ3ALAwG1q6i/FEXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IX42vflnRYU=:DTEay7SZ0/KAgZV7Q8pK87
 6npqBFfljldPyrw9CDwZtqIhL+e+3NW1Y/gBEg8CGlb6nSrW3UPnesyNGfOGW1kUaLg0427Jn
 NpacYyf8QBJHgdPBWXK9MneMH5l2zFrW2RCFD+hLKrcaPhZiTRprmOaCKDYlj02ed4PJ36PKx
 hsgPu8rp1Slz2i/VpqSCArp646joAHnZQQr61RusxDVBJKB+udI3moNCjycqlh/CCZGWw6V/I
 9wUVy4DfqZXMgNMLVZGY8Vq1m03w7H9ZzGm0i2M6pDHNafuRZD2yHL7efLC9/oSKJdWJy719t
 iy45vdSZH6rcOwIXfCm6aKcDWjo+5GysQSqmxRcCrOZSDlA3c8jHhDTJqs3F3I1HUEJzknzZv
 rNQ6X2ffTEMwCaCCj/8FCZ1CajSR77XbFr/WlQy3yfhFkTZVh8JYS1nJbSbKBTDgbljpFLFS7
 CVNCEA+NrAPjZwjWSKqOO5bfeVFqXmKY8mKy0C/FW/gXvF3+ThFX5ye6dv5gjO3QewYW8/Cv7
 y8ZiFhAwAo+whHqT3qrXnRViRVlpPGkniflMjeFXfGV7gJzT1dfKhJvrB/LrWOytQHsp59Asw
 lnuZQcehITICdkDtK0ATCxDU+HVWK5+gBYvd1T+VSLlrcA0cOYaZLLL/3HlcYPQ9aaJKOnUXi
 QdWFFUv0P/CF5ACJ+Rq/a/uZTe8b1/EBBah6jyuzEGx6ZAb2X6kL7jjhvQDj7XSO4/mimzf6z
 +win2VO9/1s8beJ/7EsBrVonFeiFnTHuJ04dhJG4DfuANECYOG/7Wdk8LvmxjexA5a++4BQb4
 elq0Wwsps27A3MD+qUYf5jMLZb2TEeSuszUdxV5Mb3vlnQl68hW6Th4dZ8svc4z77nK7O/W6e
 d3io7tL2VpuBfhDTO9JQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/17 =E4=B8=8B=E5=8D=8810:51, Josef Bacik wrote:
> On 12/16/20 11:57 PM, Qu Wenruo wrote:
>> [BUG]
>> With current subpage RW patchset, the following script can lead to
>> filesystem hang:
>> =C2=A0=C2=A0 # mkfs.btrfs -f -s 4k $dev
>> =C2=A0=C2=A0 # mount $dev -o nospace_cache $mnt
>> =C2=A0=C2=A0 # fsstress -w -n 100 -p 1 -s 1608140256 -v -d $mnt
>>
>> The file system will hang at wait_event() of
>> btrfs_start_ordered_extent().
>>
>> [CAUSE]
>> The root cause is, btrfs_invalidatepage() is freeing page::private whic=
h
>> still has subpage dirty bit set.
>>
>> The offending situation happens like this:
>> btrfs_fllocate()
>> |- btrfs_zero_range()
>> =C2=A0=C2=A0=C2=A0 |- btrfs_punch_hole_lock_range()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- truncate_pagecache_range()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- btrfs_invalid=
atepage()
>>
>> The involved range looks like:
>>
>> 0=C2=A0=C2=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0 64K=C2=A0=C2=A0=C2=A0 96K=C2=
=A0=C2=A0=C2=A0 128K
>> =C2=A0=C2=A0=C2=A0=C2=A0|///////||//////|
>> =C2=A0=C2=A0=C2=A0=C2=A0| Range to drop |
>>
>> For the [32K, 64K) range, since the offset is 32K, the page won't be
>> invalidated.
>>
>> But for the [64K, 96K) range, the offset is 0, current
>> btrfs_invalidatepage() will call clear_page_extent_mapped() which will
>> detach page::private, making the subpage dirty bitmap being cleared.
>>
>> This prevents later __extent_writepage_io() to locate any range to
>> write, thus no way to wake up the ordered extents.
>>
>> [FIX]
>> To fix the problem this patch will:
>> - Only clear page status and detach page private when the full page
>> =C2=A0=C2=A0 is invalidated
>>
>> - Change how we handle unfinished ordered extent
>> =C2=A0=C2=A0 If there is any ordered extent unfinished in the page rang=
e, we can't
>> =C2=A0=C2=A0 call clear_extent_bit() with delete =3D=3D true.
>>
>> [REASON FOR RFC]
>> There is still uncertainty around the btrfs_releasepage() call.
>>
>> 1. Why we need btrfs_releasepage() call for non-full-page condition?
>> =C2=A0=C2=A0=C2=A0 Other fs (aka. xfs) just exit without doing special =
handling if
>> =C2=A0=C2=A0=C2=A0 invalidatepage() is called with part of the page.
>>
>> =C2=A0=C2=A0=C2=A0 Thus I didn't completely understand why btrfs_releas=
epage() here is
>> =C2=A0=C2=A0=C2=A0 needed for non-full page call.
>>
>> 2. Why "if (offset)" is not causing problem for current code?
>> =C2=A0=C2=A0=C2=A0 This existing if (offset) call can be skipped for ca=
ses like
>> =C2=A0=C2=A0=C2=A0 offset =3D=3D 0 length =3D=3D 2K.
>> =C2=A0=C2=A0=C2=A0 As MM layer can call invalidatepage() with unaligned=
 offset/length,
>> =C2=A0=C2=A0=C2=A0 for cases like truncate_inode_pages_range().
>> =C2=A0=C2=A0=C2=A0 This will make btrfs_invalidatepage() to truncate th=
e whole page when
>> =C2=A0=C2=A0=C2=A0 we only need to zero part of the page.
>>
>
> Are we ever calling with a different length when pagesize =3D=3D
> sectorsize?=C2=A0 That's probably why it works fine now.

The range passed in can be unaligned at all.

MM layer functions like truncate_inode_pages_range() relies on that.

That's why I'm wondering why the current code is working.

As for start =3D=3D 0 and length !=3D PAGE_SIZE case it may clear the
Private2/Checked bit unintentionally.

Or is that CoW fixup saving the problem?
>
> But I think we should follow what all the other file systems do, if len
> !=3D PAGE_SIZE || offset !=3D 0 then just skip it, that would probably b=
e
> easier and work for you as well?=C2=A0 Thanks,

Definitely it would work for me.

Thanks,
Qu

>
> Josef
