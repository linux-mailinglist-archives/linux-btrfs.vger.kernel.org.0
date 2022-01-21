Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C549683F
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jan 2022 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiAUXeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 18:34:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:37731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbiAUXeM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 18:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642808044;
        bh=wLz9RixPZtRWHtwOFhwkqMUduPAIl0RHKbjzwKjIr6Q=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=LxeXunGtS3U99yie4cMjRyQlaGU+cqbGn2bkAkMA5Tx6sFXfImAFEUXjqe37pMHWf
         Flt6TNx3pdEjT5KFwmhb+hROrP2r06ssgKaGktKcI46H/6kT4Xrn1xl71Oh9W8fAMA
         8fuFf2uthxJvZh4+b5kizwOk/unOugmEK/gLB1uo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1m9vAT35aw-013hoZ; Sat, 22
 Jan 2022 00:34:04 +0100
Message-ID: <7802ff58-d08b-76d4-fcc7-c5d15d798b3b@gmx.com>
Date:   Sat, 22 Jan 2022 07:34:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
 <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
 <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
 <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
 <CAEwRaO7cA3bbYMSCoYQ2gqaeJBSes5EBok5Oon-YOm7EQ8JOhw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
In-Reply-To: <CAEwRaO7cA3bbYMSCoYQ2gqaeJBSes5EBok5Oon-YOm7EQ8JOhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9k6XVWD/tZvirFM2y7zHu+Xlhyj89CJXtefvW2zReRo9tKSkG1f
 AtO60+9rfWblYIrKfNiZKg56FXzpKkc+8rGL2K7ETLeq/BYraNRGBdvUirtyVV9tqwqPs/a
 9b7nVyZe8LsJ2m8075vF2iP+mhFSLQPpKLlwa7c/zeYiXMjIXaVPbHrto9hq67dm6594K+o
 4LRJ4DJeCV2qwtfp/475A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYS/JEilA2Y=:vIt1gU7JqFPK8WvXA2FOk9
 loet9u9TU9I8Lot4BbG/zeU+C88tjqRDLqtRaof/0vjmwyBnMwl7OKLKCR5fgvrI1mDDwv2eH
 Rs56xs+MT1XONBG1EcVKon+0IIBfIzbBgOe7sJjn/mTFwXtQpbUgqybYsRNjUPdtWm++hW4k7
 3YWKv1Aeb/NpteHVTLvVYX9SykOLE9v95YunigAcU8dpZYccMnZCSmyMV+yvWoUPWGgwmsyN9
 4WYReCB/d/22usZ0uTqwl1JXaoB+DjkrfgCKa3lZ4CitbKniKgfpuTnPPgqU8dhMZ2TxfOuEa
 ccpBLFMhISMP7IgqWk1kdDrq2mOYGp1rO1lZI4YJ/k0gUGU51duEVpV7URy0p2w3eqtN5CYuE
 yy+w0GtgV662lqWJ0+SC6CbS4EBjpI2bo4IMGijmGhLdL426zRXmeN7mxG6ra610r6XtAYZxM
 NC/FKfYsoXJIxSHTvu9BzIBRj1EE6yDk783WDvUDeEDDVpYJWS08Zw0a7IwM25DVax1gi51jo
 gJ7sltWVucVNrTRIUrYNFD9n5VVkQOQVLxIaH4y+dCD84Gqgul/Cy1TKAX4U2CLmDSql2Mvv9
 blFaSBkqZVRFmvTer3y4zEwXkuBJ6KuZt2phcDso3BkpvEqx6rieJsA3nCyrNbdmtBMJE22aX
 utljfgwUrpH8H5jnImBQq7GxEnqYsSPR3hKCHsipDQh+TlU/98mogbjP+HvDtAwlHiU2/+WF+
 z1mBl+w2TdxediHEfz0NrgUFFToDy9iszfzP5uzIEdJPTPG3p9UseTBjw+z6kEZyEQIhuItj/
 uUuUn2loZPNaRhY0dOt5F93FWP0bKWYgWHrGBOWVFsUZkTa5XwEK6wE3/3keNbffZTZ/kKMLb
 933zlE84fgmuFWhn90jnEMMJtnhjmmF4I8fEExKSLA1NTnzEwUCWVik3wtVmt3aUqv+M2OM3R
 LUenYKb2Z6l6nub4ohEpT8CF8tJEwNLCJTCsCLnXtG2Uq+04phJ+ZBzUUBsN+Yrpvk6+Bt95A
 sshrKGeIrX+X4hw8cltjFWvRlO53kASCJUu5D0hAgYJH9T+nYbBgkEiKG+IBpYZevs5VB0otc
 B0cu083ZdSlKkU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/22 03:39, Fran=C3=A7ois-Xavier Thomas wrote:
> Thanks, will add that to the list and test. FYI the 6 patches didn't
> seem to have much additional effect today compared to my previous
> stack of 4.

Good and bad news.

Good news is, I got my way to reproduce (at least part of) the problem.

With fsstress, a way to trigger autodefrag at will, and io accounting
for data/metadata read/write, it's clear the newer kernel is indeed
causing more IO.

v5.15 (or just revert the defrag code) causes around 8.7% of total data
IO for autodefrag.

While v5.16, even with the 6 patches, causes 18% of total data IO for
autodefrag.


Then bad news.

I have seen cases where v5.15 doesn't defrag ranges which is completely
sane to defrag.

Something like this:

         item 59 key (287 EXTENT_DATA 118784) itemoff 6211 itemsize 53
                 generation 85 type 1 (regular)
                 extent data disk byte 339296256 nr 8192
                 extent data offset 0 nr 8192 ram 8192
                 extent compression 0 (none)
         item 60 key (287 EXTENT_DATA 126976) itemoff 6158 itemsize 53
                 generation 85 type 1 (regular)
                 extent data disk byte 300445696 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 61 key (287 EXTENT_DATA 131072) itemoff 6105 itemsize 53
                 generation 85 type 1 (regular)
                 extent data disk byte 339304448 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 62 key (287 EXTENT_DATA 135168) itemoff 6052 itemsize 53
                 generation 85 type 1 (regular)
                 extent data disk byte 301170688 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 63 key (287 EXTENT_DATA 139264) itemoff 5999 itemsize 53
                 generation 85 type 1 (regular)
                 extent data disk byte 339308544 nr 106496
                 extent data offset 0 nr 106496 ram 106496
                 extent compression 0 (none)

This 124K range is definitely sane to defrag (and the newer_than
parameter is only 35, all extents are a good fit).

But older kernel by some reason (still under investigation) doesn't
choose to defrag at all, while newer kernel is pretty happy to defrag.

Although there are cases newer kernel is doing too small defrag which
doesn't make sense, with such cases fixed, it still results 15% of total
IO for autodefrag.

I'm afraid there may be some bugs or questionable behaviors in the old
defrag code that is not defragging all good candidates.

So even with more fixes, we may just end up with more IO for autodefrag,
purely because old code is not defragging as hard.

Thanks,
Qu
>
> On Fri, Jan 21, 2022 at 11:49 AM Filipe Manana <fdmanana@kernel.org> wro=
te:
>>
>> On Thu, Jan 20, 2022 at 6:21 PM Fran=C3=A7ois-Xavier Thomas
>> <fx.thomas@gmail.com> wrote:
>>>
>>>> Ok, so new patches to try
>>>
>>> Nice, thanks, I'll let you know how that goes tomorrow!
>>
>> You can also get more one on top of those 6:
>>
>> https://pastebin.com/raw/p87HX6AF
>>
>> Thanks.
