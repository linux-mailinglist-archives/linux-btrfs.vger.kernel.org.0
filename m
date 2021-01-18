Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9A2F9DA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 12:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbhARLJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 06:09:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:44253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389852AbhARLJI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 06:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610968054;
        bh=yUFGFmI+xESPuS+jsA821uzVB6to8z0vJ6W9hFos+Zs=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=ayCc7slDlWzhYpET2+ggCA7o77cWp7gq+Nm4wg5aUa7W1HbgWrqDqfLdgr4wdGIv6
         ZGYCmpH9sIJBkE0NN8ynBouMOfsjgJmCDpwfJc+4eNpoAz1bM0ZrHL6Qs3w6QGW5Vo
         bJArTuEikfg8wiGUojci5Y6BHsg6xgM1JSTsKjSs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUUw-1lp4Kf0Twy-00pyCr; Mon, 18
 Jan 2021 12:07:33 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
 <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
 <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
 <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
Date:   Mon, 18 Jan 2021 19:07:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6HqbcVwVgvFNfBhmhBXYYVKQEGriYTLK+zabG2WEREv9ZpYqBNq
 aL3lvpmqWsUMWF37lvbC74Royxm0k/IAELMTBZUirxbJtSWvkTkrAS0HwTSBu6fOGbkcR3L
 KWFvOeKg2FkdjrXvvraRlXNoleg0/nkos9x/4+wGPKjAQV+brS7JJcGIA/H6hvzd+H9wD7b
 ESPyGYwV3fYlffMUZSuRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xjWgak2Z9U8=:U3ESLPHRXF+Hf69+IRncuj
 K9bxmyr8Onp73eMzfhysEuraB9DNwYWa4SMGQcGzuply1XNlTo+D2vSFIXbVXggcBEhLn0jkq
 XChacCf4G6iCFCZVaUrB70/+E2YBgeEvN4oh2PF3ijzBY7W0PWjXeYSPdH4D2m79SeIHthpHX
 MNODpgwyGumLcwb8HjMKhJypmpl72rPiqGhuD0u6lAf3BO92DAyKA7z1kUXKHZwEeybB8Lk12
 L+PqmoX9VJ6Kiq3Dp0nuxjXi+pv2BEN/w55lqoIxE0fOqHGz2+aDt1ErxLvaoq8CzJP9xR/Rk
 hfXb9wDhbln/al0UYx4VQflbZzhfZVyaT6qjaWBeZ6NLuwAdkTxfrnrtajtEHHhZEH5B6YqGN
 m+rplpzl7T+n0aYo0kJOJJ3J9SDTsdsU5rzDJZbH7BwQgo4sdBiXMVj5yNwOoWYJEowPJ9EMV
 TiGTt8zNIcrLSDpQZk3fsMl/Yn2zqOSI4TnQpJvXJHsWu3n3JhE6WuR0VkZgijqMZtsZRYXwS
 ujZNchRk8Emvr/3fFRDa+rbX0hXDD/0OfgjJuVX0WS1uu95vs9qdQdXetzFfM5E3PVYVHhJmI
 cErLHCVliKQ/Gtg6V67JIiUmMmmW352Tep/gzRFCoKbtfHOo1o1ETeiLo12hlpJ6YS+K5XeSH
 h4P6VDvI4TTXQhkXhfdAnNL7Pid/AxnUspu4PGGOo+SWtoRScTinzt+qWqM+Yt8F0ii6P6mXq
 amnxPHNJ98U4iWyWgI8IQjErDV27eZpy/a6JiqsrdB9rS2B0gKzKEql7M4dSnHI0T/io/Om1E
 NoAC4YGlYFVWesgYLNWC03+QclO7mNSIsqZWi0g6xIBnvJuI2xrVvKqbHp61SSBcHUBNSjuVb
 1jVtZKTIz0pslc5JoYUQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/18 =E4=B8=8B=E5=8D=886:33, Erik Jensen wrote:
> I ended up having other priorities occupying my time since 2019, and the
> "solution" of exporting the individual drives on my NAS using NBD and
> mounting them on my desktop worked, even if it wasn't pretty.
>
> However, I am currently looking into Syncthing, which I would like to
> run on the NAS directly. That would, of course, require accessing the
> filesystem directly on the NAS rather than just exporting the raw
> devices, which means circling back to this issue.
>
> After updating my NAS, I have determined that the issue still occurs
> with Linux 5.8.
>
> What's the next best step for debugging the issue? Ideally, I'd like to
> help track down the issue to find a proper fix, rather than just trying
> to bypass the issue. I wasn't sure if the suggestion to comment out
> btrfs_verify_dev_extents() was more geared toward the former or the latt=
er.

After rewinding my memory on this case, the problem is really that the
ARM btrfs kernel is reading garbage, while X86 or ARM user space tool
works as expected.

Can you recompile your kernel on the ARM board to add extra debugging
messages?
If possible, we can try to add some extra debug points to bombarding
your dmesg.

Or do you have other ARM boards to test the same fs?


Thanks,
Qu


>
> On Fri, Jun 28, 2019 at 1:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     On 2019/6/28 =E4=B8=8B=E5=8D=884:00, Erik Jensen wrote:
>      >> So it's either the block layer reading some wrong from the disk
>     or btrfs
>      >> layer doesn't do correct endian convert.
>      >
>      > My ARM board is running in little endian mode, so it doesn't seem
>     like
>      > endianness should be an issue. (It is 32-bits versus my desktop's=
 64,
>      > though.) I've also tried exporting the drives via NBD to my x86_6=
4
>      > system, and that worked fine, so if the problem is under btrfs, i=
t
>      > would have to be in the encryption layer, but fsck succeeding on =
the
>      > ARM board would seem to rule that out, as well.
>      >
>      >> Would you dump the following data (X86 and ARM should output the
>     same
>      >> content, thus one output is enough).
>      >> # btrfs ins dump-tree -b 17628726968320 /dev/dm-3
>      >> # btrfs ins dump-tree -b 17628727001088 /dev/dm-3
>      >
>      > Attached, and also 17628705964032, since that's the block
>     mentioned in
>      > my most recent mount attempt (see below).
>
>     The trees are completely fine.
>
>     So it should be something else causing the problem.
>
>      >
>      >> And then, for the ARM system, please apply the following diff,
>     and try
>      >> mount again.
>      >> The diff adds extra debug info, to exam the vital members of a
>     tree block.
>      >>
>      >> Correct fs should output something like:
>      >>=C2=A0 =C2=A0BTRFS error (device dm-4): bad tree block start, wan=
t 30408704
>     have 0
>      >>=C2=A0 =C2=A0tree block gen=3D4 owner=3D5 nritems=3D2 level=3D0
>      >>=C2=A0 =C2=A0csum:
>      >>
>     a304e483-0000-0000-0000-00000000000000000000-0000-0000-0000-00000000=
0000
>      >>
>      >> The csum one is the most important one, if there aren't so many
>     zeros,
>      >> it means at that timing, btrfs just got a bunch of garbage, thus=
 we
>      >> could do further debug.
>      >
>      > [=C2=A0 131.725573] BTRFS info (device dm-1): disk space caching =
is
>     enabled
>      > [=C2=A0 131.731884] BTRFS info (device dm-1): has skinny extents
>      > [=C2=A0 133.046145] BTRFS error (device dm-1): bad tree block sta=
rt, want
>      > 17628705964032 have 2807793151171243621
>      > [=C2=A0 133.055775] tree block gen=3D7888986126946982446
>      > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
>      > [=C2=A0 133.065661] csum:
>      >
>     416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba96=
56fc
>
>     Completely garbage here, so I'd say the data we got isn't what we wa=
nt.
>
>      > [=C2=A0 133.108383] BTRFS error (device dm-1): bad tree block sta=
rt, want
>      > 17628705964032 have 2807793151171243621
>      > [=C2=A0 133.117999] tree block gen=3D7888986126946982446
>      > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
>      > [=C2=A0 133.127756] csum:
>      >
>     416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba96=
56fc
>
>     But strangely, the 2nd try still gives us the same result, if it's
>     really some garbage, we should get some different result.
>
>      > [=C2=A0 133.136241] BTRFS error (device dm-1): failed to verify d=
ev
>     extents
>      > against chunks: -5
>
>     You can try to skip the dev extents verification by commenting out t=
he
>     btrfs_verify_dev_extents() call in disk-io.c::open_ctree().
>
>     It may fail at another location though.
>
>     The more strange part is, we have the device tree root node read out
>     without problem.
>
>     Thanks,
>     Qu
>
>      > [=C2=A0 133.166165] BTRFS error (device dm-1): open_ctree failed
>      >
>      > I copied some files over last time I had it mounted on my desktop=
,
>      > which may be why it's now failing at a different block.
>      >
>      > Thanks!
>      >
>
