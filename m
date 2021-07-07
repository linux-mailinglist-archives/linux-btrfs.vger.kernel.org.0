Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8254A3BF260
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 01:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhGGXW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 19:22:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:37885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhGGXWY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Jul 2021 19:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625699972;
        bh=FSq5hOg20GzKGUSP9BoJRMwTbY31oDy+zlIif7Cs6oE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=A4aV50jujp1YD4cwQc0P383jkG3zrILbZC4TAugeMJzycOojhJ8Gv+9eDvzyuZWoH
         5w3z7696GRRN56mO2XNgBgTCtCJCQcoDLsAuMcXcTEEzMjcwBAMmCCma/2Z1ssifht
         LB/guCr+x7wEUN9w1yUyJkIjmn9HulVtSx5Mea1M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5GE1-1l11Ak30zt-0116kO; Thu, 08
 Jul 2021 01:19:32 +0200
Subject: Re: [PATCH v6 00/15] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210705020110.89358-1-wqu@suse.com>
 <5ad76de9-d1df-cafa-f5c3-44e316e0fb23@suse.com>
 <CAEg-Je8A=d6JOMfAPFcfppuhXvatLqpLb6UK5dOzdLZnfBfq7Q@mail.gmail.com>
 <20210707181451.GS2610@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <843d839c-11f5-40e3-9871-e462254113b1@gmx.com>
Date:   Thu, 8 Jul 2021 07:19:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707181451.GS2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LT5TzKAJLWUP3mQL4LC9M7SjSFYEmGpnwUxNwPJp/3Ktaazrbdz
 gk8R1ItO6ypI+YNU1i4k0zedvhLoCWVyskCV/mjvhwEDARWEoDe4R95JPz+iBYbRGENWTPo
 FcSkuDkMG39OkoOZVxX6WnGVP+oWnpZCBhMmh9M3ftrW7G2KFmEJJlblcIvvKbDv1mWxpcH
 LWOIpmxAG7TJCCq7/Wkdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qiks1iXrk+Y=:uD+BLARkAoODEYG3loIIvl
 3D8YpQc/5q9f7dqw8dHFdlRWuZJZqioIlFOEgLioc0xdakxMV8AFbYcnsLd4yCyqMJu7r79Nu
 E/vrVU9TuZXz/zCN21sg9z3bDEbJVkABoT7Rjlll8g3pdy46hzIBh4I8iyvqTy9OzXQoRsYvn
 eMcRd5WxfhsUaTKqLlWS2/fqg0V0bugqsfTpSSXOYgRwf5m2M4tNJWtl6LY8v4VQwyw+o9I16
 Wfhgq5IvjrrhZDeFnmVZIEa+eI/NlVBzcnKwyDcDgZzxmwvhnJnLemP20sYYDtsGChbEh5sD8
 TQwgQOaip/64FH94sHDmTjJmU6doehRpLKVkjW58aCkFRVcJuk9AG5HCrsJM+X/0nCJlp2fq5
 DjD0kJu0qWs371KiODvBbCwz6NMpclD0xb4c8m/8qYJtEONqIgItruJy06ox1dOTzUy5zVAOe
 TwYNqlWkP1VZqzF6QqNh6agHjS+KXG5U/iirx9mDEVu3XrcUD3ncYUVzD1Jaz8NfazBCyDK6u
 qjT693PeRUx+NYY49aJA4mx6IMO34OjpzGDLkxdKwH/MREwlF/+IrVs9AwlwH5fu1tsIxPMzG
 k7/u6OTHYvEkMqUowkWJDC6EmGn/wNye0WPszyJjXjkxYRmEnygxnprsscVnya3rldzlxUM71
 0o+2u/3R40FJKyBxhid+sOYgjqABHZZlGthlpjHrkVOgFhMNnJlOJgNYIOlQSaRQOX738mUmE
 waxO3Y9gMvDw0lYWL6lMRR19cgMh/GPfhVv+lq8DTvKhqulSWukxZ9hor7ZpggCxQYdM/Xv5f
 WVTk6B8zn2FwBZtCZGOwFvOlhPqWotCRLdFvoku6ItlfvbRIwgBNuiDu5T/x5F0/qkRmxGG20
 iWnkL/TbsVOHzgj88lYwHmUZ63q7Vv1LcVz1+5tnOUQReKAqqOgk0KUerTEVsqiHzQIL74WOx
 R/DHk8LalDIpFsigqP8b8FV69QaSoc0q8mZ2YZ5QoKr97iTNumaKYOrcyTonPsdn9QXzcskt4
 i3iGmG8L4c7IhNW5ek/Suu9RKKpqlbnkDZarc3HG3XsV2OobV8AL9np9f1KkqQ/aKW7CMsymd
 FlZuE31GQsb78pn76wo4qVzfOIJrvJV+hM0a6o86p68QcEoUSxvmyUqCw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/8 =E4=B8=8A=E5=8D=882:14, David Sterba wrote:
> On Wed, Jul 07, 2021 at 01:41:46PM -0400, Neal Gompa wrote:
>>> But on the other hand, I'm not sure what's the proper way to introduce=
 a
>>> fix for v5.15 window.
>>>
>>> Should I just disable readahead for compression read (which just needs
>>> two lines to return 0 for subpage case in add_ra_bio_pages())?
>>>
>>> Or should I add the proper fix into the patchset?
>>
>> If this is going into 5.15 instead of 5.14, just add the proper fix
>> into this patch set. But if we want to land this in 5.14, I would
>> suggest disabling it for now and then having a separate patch set for
>> that.
>
> 5.14 is not possible, there are other subpage changes already merged so
> fixes to existing level of support (still limited) can go to 5.14-rcs
> but this whole patchses it is targeting 5.15.
>
>> You're already targeting 5.15 (though I kind of want this in 5.14...),
>> so I suggest going with adding the fix to the patch set.
>
> For 5.15 it's free to do any change, eg. fold the fix or do a separate
> patch explaining all the details.

Another reason why I'm considering to disable that readahead ability is,
it really makes little sense for 64K page size.

Our maximum compressed extent size is just 128K, at most 3 pages for 64K
page size (that's when the extent is not page aligned).

Just saving two reads (which may only be one or 2 4K sectors) doesn't
really make it worthy, especially considering the change to ra itself is
going to affecting common code path.

Thus I prefer to disable for the initial support, and only add the
proper fix for the compression write support.

>
> In general the development changes must be ready at the rc5 time at the
> latest (with a week or two for some testing and catching last bugs).
> Once it's due there's like two months until the next code freeze.
>

Great, I'll just add a simple disabling patch with comments on why the
current code doesn't work and why it's fine to disable it for 64K page siz=
e.

Thanks,
Qu
