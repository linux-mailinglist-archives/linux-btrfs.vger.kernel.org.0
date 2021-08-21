Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6C3F37D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Aug 2021 03:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhHUA6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 20:58:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:53215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhHUA6Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 20:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629507459;
        bh=5aEkR8i5wYTWMnbrkTgTjCWUJKOWLbfA81SzbGA6wpI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WgzU4Pi/83BStieC/3SLeOxByHPRzTreoBvHbpE5iF5bz78wIm1+Xig07P2RySB41
         YkbjGCXzmXNHFDQ4d+IJJpUXM7o5a5AYXYlGjxqmjOQleg7MkKlSr8+JhaUl24K6Pr
         gsA8sqDGEORd5cIIu+Ls08KFHOFwn0cPPlLV6bOc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1myYhj1ZCn-00hQRt; Sat, 21
 Aug 2021 02:57:39 +0200
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <63cd4e76-72b4-7b99-ae94-075dfaf78bb7@oracle.com>
 <39f171e0-7c3c-7194-4265-e688d2df097e@gmx.com>
 <20210820122905.GP5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <03d819a6-b3f2-c056-9ba1-3c0f1c985e20@gmx.com>
Date:   Sat, 21 Aug 2021 08:57:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820122905.GP5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FUgRf6mdP0dQniUNthx5QRpL2WMv+rzxAQirq3WaNgYj43LnGBO
 95G2aHkEAKwMOV45orUdFUyhsFcocjVYGGyX64kEmcP8dK8jNraPzLHw38yQH9rsZwo/Yoq
 qtDyt6aHGMTkM53QuXsEosvqPmB8ZtdskFjQHSauqHgHXVBidsxglvEQAxinIYf4RrKqYpQ
 CDHRYElnGn1QwlFEyO/gQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YmxhoGVYciI=:JnOPzrBrCWqnY3koCDTa7Y
 36ol0hrhnBwr3nXZPgYEfsglEdfYImsdVgI8O+4KDsuT+Ru8Go3WNhix0WH8YvujtIGDik/yT
 jCvrkt/uT0CJkefchkuWiQ24LLvuY8bD6sYrSTqsZkXvaRfgVLEQ6+qbIl5VF/cKGCA1Imrt9
 oRYdKVfcGWwQMfAJ9QMJ/QotFHmZ8YVdJ4zH1LdVRnnIRergzcx9vQMRiCk5rlXECIIi/t7pO
 AnCBhKlxT1GgA6zc+Nf2X3Bv3hPQUQfuSHbTPdhEuuGUog0+hkIg/gsBC8gnEGhoX47lXUhoy
 1d9u1xRzkLLfDyf3fQSb89cmv9w5TjjDM95Bky/khm7IY8xM01ybygVcmkVT7wS+8PV22p5iY
 jZgdiBwsRCEHS0YgCLpOelhm+08ZFMGcAyNmUaz1NeRFV0ucG+yRbhBFoW8hJyWtZA+low5An
 f3H3wbj9XJ84Wpd1UgP5ll5HYGTFco36JjQsG3ZzO2SxP0gWsbyupr4F3U1pR9g/GZNUGbOZl
 20Thx+eG0Ck67InHKT3r9pvQqf6BkWVMnoT3b6/lKRZRS8pPxYSGe32NZXexYgx9WXEHeLEZG
 1Uv8LaPmPgHVtSk5gbn1CCa7cJTW7YXguTTZ7ElhGOVnqZsNKX55qLo2FGjGe+f59IBnrev88
 rRHyE6xPo2qF6On/6+uxNQ07VdlUtWR/FC0c/V4KlXwYRBUt5ykhoqlR3B0vazwEfC0FDgxUz
 CyYz3TOgJ+p1/I6iNnCMdcQWW7zO13q0JXG0r/xtpxs7BRZG0cZoHtZRATfojyQKuoqUeTnIr
 LsdnIU57Vhipfd0ee0XuX2NjgKUCnlOjpxhaUSS/JJPfEG0DcJti6tkdM5mdFq4ipuE+zzgub
 9C5dZbMaZaYA74ifXCIVACnFoQl4SVlxbNchPkMz16xdhEsb/DWdWj6ZUDMDj+863mw0LBJHd
 7QUnbwVUq+t+G9bkPXCvwMvhiyuK9Hind5T8YQp6VWD2H+I0Es03RsQaMTzMeXdoQkgB4NUea
 WcKaqVBMWy7GFTwgDqUybCfJmLs6CVY8RzmxmcwGbJWMYstFjYTq+oDN9RxrSr0OxNZfEmGpi
 N6D1C5OBKbDphI9aZOAAncNVcvgPdaN3p0Vss6v9M/AqfxgsKTErm/Z2g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/20 =E4=B8=8B=E5=8D=888:29, David Sterba wrote:
> On Wed, Aug 18, 2021 at 01:36:32PM +0800, Qu Wenruo wrote:
>>> Looks good to me.
>>>
>>> I hope there isn't any xfstests/tests/btrfs test case that is hardcode=
d
>>> to the older block group alloc (like swap file test with relocation?).
>>> But then the test case will need a fix, not btrfs-progs. So
>>
>> Well, fsck/025 will fail, and it's not the test case needs a fix...
>>
>> We just suddenly can't mkfs on a 128MiB device due to the enlarged
>> minimal stripe length of data chunks.
>>
>> This still exposes a behavior difference between kernel and btrfs-progs=
...
>
> So I'll reply here as all people involved are also CCed - I'm dropping
> this patch for now.
>
> The test 025 fails and my idea was to skip it for now but that still
> leaves the problems with creating small filesystems, that's something
> that has been working and it should keep doing so.
>
> Proper fix: scale the chunk size for large filesystems

This is what the patch is doing, so no problem.

> and also small
> filesystems. We can probably set the minimum size to somewhere like 64M
> (for non-mixed setups), and scale the chunk sizes according to that.

In fact, it's the minimal stripe size causing the problem and could be
easily fixed by just synchronizing the same value from kernel.

But for sure, we still need to do extra tests for small fs size to be
extra safe.

Thanks,
Qu

>
> d.
>
