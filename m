Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE344BBE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 08:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhKJHFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 02:05:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:38771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhKJHFC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 02:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636527732;
        bh=beVM1PMuVKRvwlSzO1Q1M3XSGvodTT0y2iwjb6kC3Oc=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=EV924bJzj2q5+Ue+mswvLg+wWliezEeGBJ+IPf+6EYicSpeXGmbcxeTGua8KrEdM5
         5ztDz4gW1Zu1D+EhmIQ6+usyOl/wVj0zAX8hEuB9I3SbIayzOndIqiYDl5uqtadTIV
         EgWsxGSjgLDVbHz2BpvvLmJIn3UUx8VNicjs5DHA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1n6NKk2g77-00MJsx; Wed, 10
 Nov 2021 08:02:12 +0100
Message-ID: <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
Date:   Wed, 10 Nov 2021 15:01:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     "S." <sb56637@gmail.com>, linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
In-Reply-To: <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z8iYwmoNXswuX55JX+bqlm1VE2cZOHyVYttIgdb3OFK6fI9h9rn
 Allh3ZAE2d2gSTpmiaYzpmwUIOHQpY6MMZUb3ziWrPbOn4If10NZxg80BAJ9dL2BciQ3idZ
 Z0/Rn5qoucj6GJhZ5iD2xEDtv3B7WsVhyuzv2mpIIenUGbgbOlWMqUdGU367fQOYGl6eo1y
 i+M5gANsl14011hiF4FdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SJCAT07c16U=:v40BvLmKeFw56hUnKRqXNT
 3rF8eXiMDhgaogg4GP+iKVdF+c7dv0qeEIVGoGls5qLwTBJI9NDcGgXIgSD5Zlv5EBtP2j9Ai
 NeNMpRZF/+EhlC4O+Cid2ewG+8lWXMTCwRPPRdMFJHeoiEzmY6/deCbGotT3cPUnt7mt8oUsj
 QVFRbAgOKY2TexAZNuhTuC+nAWO7fUJHo1NIvTYX234McuS1htsdi8YH81KP5PYB/htEFqAYF
 sCri9XtkRFocajpp8625t95ySSqcHxJrx2BAEbRVGMUb9gcUpYUY8PVSt8EcOYqT2BcADQ/gb
 EQqmcKM2WjJbCQIKqOq+ofATlMrLvzBRJ3nVJde/9KZWV3GRL55tSrcekOtMm2WG2AchbnYw/
 X999lAXVpONr5yGjj2yUwaIMn/kx97VcgnSYD7LcqkZl9LRfv9NKpXdwymsw/i/Wl4aGxVU7o
 +87hNGojAwsEBfBC9bVatraZQ+RMlwn5tzqT97zUqW347PevE8PdiMXX2q+VtP674q98YKDmR
 msYpA95B2/VDsGuDJ5e2tvTUmK9ck4RjZ2B7Jcnckj1yLeeSn571NvnsOojI6VPIMWdHGuqke
 gXHjaJy43Rkkz68QY5zaEUmBMyAbuVmBuGMOciax3B2QEUG1HebNyIJjqKIr2EFjMT3IfsNM6
 ZUmvOIraF3LJWiiWo+Jt3nN3lW6qtdWZ9BKy1biElTViW7vlouaA2VWscfie1UmPT4Tc/ty1+
 NMSe68HmQz3HlMUMZVkqKLmdC1CK/HQfqVp3edLE1RMEQABTKEknDG2/ZkSMYr35QA0Y1fDHw
 MxnaNKJq+qNg2gvofMuVOyDp4lYw9ArPLYPie7ev/37OqQJPZco3eI0fzJ+l+uXN1UGSsPc0V
 Yw3BMK+Rb7m8w1w03W7G9B2P39KqUOo0VWMY5ONsrkRsIj7c3FJuAFCpG3AjRERJe+mchnRoZ
 VI9EARf6buBAnhS99tm2ggGNilCKBU9svYN6RA02ABlYGftbsdo0JEhHcg4RtBaXOTdC9Lxsh
 cMgWApp/4jN+Y7avDaxnIIw+n2EkaI3Jar4rK8NmjBRKTBxUhFmIPxUIg2BeXKGYCZoULwsg+
 gOFA0mO8DqH2+g=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 12:30, S. wrote:
> Thanks again for your help Qu.
>
>> There is a user space tool, memtester, which pins down a large chunk
>> of memory, and do tests in user space.
>
> I see, thanks, I'll try that and report back.
>
>> Yep, exactly the problem.
>
> I'm not very familiar with the low level functions of Btrfs. Could you
> please help me understand what went wrong?

Btrfs subvolumes have a UUID, mostly used for send/receive.

And btrfs also has a tree to record UUID->subvolume mapping, that's the
UUID tree involved in this case.

The problem here is in the UUID tree, we should only have two types of
keys, (XXXX BTRFS_UUID_KEY_SUBVOLUME XXXX) and (XXXX
BTRFS_UUID_KEY_RECEVIED_SUBVOLUME XXXX).

But strangely in your dump tree, you have an key type with EXTENT_ITEM,
which should not show up in UUID tree.

Now newer kernel expose such problem and refuse to mount.


> Assuming that this isn't a
> bad RAM issue, is the the filesystem in the same state as it was before
> the OS upgrade, just with a more strict kernel now that doesn't like the
> bad blocks?

The reason why I'm assuming it's RAM problem is because that every tree
block in btrfs has its checksum.

And in your case, the checksum for that tree block passed, which means
the corruption doesn't happen from disk bit rot, but something during
runtime.

And it's not from the newer kernel, as kernel newer than v5.11 will have
write time sanity check, to prevent such corruption from reaching disk.

> Or did the tree get damaged during the OS upgrade process?

I don't think so, I believe it's some very old corruption, not exposed
until the latest update.

>
>> And you haven't yet recevied any subovlume, it would be way much
>> easier to rebuild the tree.
>
> So should I wait for a btrfs-progs update? I'm not sure how to build it
> for armel. Any idea on the timeframe?
> I assume that `btrfs check --repair` is not an option?

btrfs check --repair is not yet an option.

But there is another option.

If you can revert to older kernel/distro, then you can mount the fs with
"-o rescan_uuid" to regenerate the UUID tree using the old kernel.

Then it would rebuild the UUID tree, no need for a tool in user space.

Thanks,
Qu

>
> Thanks again.
