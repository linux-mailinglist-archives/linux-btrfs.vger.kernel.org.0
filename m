Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52B72F9F05
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 13:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbhARMDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 07:03:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:45759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403796AbhARMC5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 07:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610971281;
        bh=eg7+Zp84FOO9B0OD3hOQ20DfMmShZfElPaM3CLCxtpo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X1oMdBRu3l24t0QwIWOnMKyP1kyCsQwKvNcyZK0mjF/Pt38ecenrQ9UrxVovnnsf8
         jjIwxHYvAuU+fsR9av7y3/Uz9moJ2YvQU6O8FdfS9QJXZfKVIq32p0o8tBM8Lj0Te6
         OPB675ZuGN/m3MNjDJnlC851NPT/Y5r/O0ohn/Hw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCKC-1lMHtb27YC-00NA8J; Mon, 18
 Jan 2021 13:01:21 +0100
Subject: Re: "bad tree block start" when trying to mount on ARM
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
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
 <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
Date:   Mon, 18 Jan 2021 20:01:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3UkO6XqfPmj7McwQdVc2g+/k9yqvqygrf45n1LUXsOFoChc1h7I
 6hmDCM+1A6HcPJhi9qmNgfeWWPHVmiYlSwREQT64dLN2z8BTThBZOMUWNBmO+DUyFGfgAm/
 sPeDAWwZqOvNOlOm3u8pzqYPbCWbvLvjC2MDqOAAVRGAkZe3NnyzQ9p1m4L0tp3nj9KJ7FX
 0rf0a4DcNQwbE8hrUmUvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:stonZHFttUA=:mAS1ujI3TOk5LBjV/WfKfG
 hi9wusYUtkBe0mTULjwWCuqJn/wEXEnj44PyyyyCDAYIEl2J3JbGcyvvqHMCrn+juSFDdq60y
 X386Crzc4xXzQNPWdZroJg+Rd0mKG5TctHxzR3yAEbWyACh31/nIbETtHx/UdFVkSOjzjJUcH
 IASQFbS+Qzb1SB5g1T3YIr+1c4SZQgDp6qe68Nwq/gLLb52lDl+9seBUuVMJ6Wh3nM6C16/75
 KLmD5juLc2L1R4+8oi7U3YOlhEXFMUZi+ZukWa72S1T/BYBgI2GQdGwISS8Av9FxcoMShGj3D
 MHiZNuOHs6oQNiC5PU9BSRCB8Iq/B3eYOCMxwXid1cMa8OqC2SjV9mo/+GqEOdPjkjIzN9TQJ
 Hk079O8os2BZMNpsBjdgzvRvDbWTGWTOMhOyQ7if21U0B6S7/q0A0SFFRIoRIqK6MUjRfiZIa
 8K9WaTIM3NIDKmsqcBSd6kBFsNFsRDgeh2Dypje+e7tqEvDBsBeYb/CAv5rhNCd3O0xr+gv2P
 cz7Ou3/m3OFmohNTdHP0gG9ba2rsVtElo2zGe0h2nv4gFHSgs96v2WGnCk4t06cszHycMBN8g
 BzLPKpvETbjOSNRxHvOnom+aQbV5c0w+TcTuWS7QCGkPsdDPB2BIr0t7gpfkjbfabF+O6z64x
 sAYYL7KAGZSzEXuFdXo5QvSD+4Dz5IPM2x1IOHSTVvqABLmqM7ApjcV4L0HKz94uRn8dcyIDa
 sPI69aXy9N+MsSOKKeFtZyangSSuzF9N7pi/6gBqOPtglbjjweR23pK+WNDHiqK8yCHP09L6P
 z86NpiHC5TuE6vLcnT7BZL/V2iK0/QIUinYQWw28Qi4vt4N6aPWCwWhRk+nVhday6CzhwhNCv
 8SmqoEGQle1GcHX7isSg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/18 =E4=B8=8B=E5=8D=887:55, Erik Jensen wrote:
> On Mon, Jan 18, 2021 at 3:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>> On 2021/1/18 =E4=B8=8B=E5=8D=886:33, Erik Jensen wrote:
>>> I ended up having other priorities occupying my time since 2019, and t=
he
>>> "solution" of exporting the individual drives on my NAS using NBD and
>>> mounting them on my desktop worked, even if it wasn't pretty.
>>>
>>> However, I am currently looking into Syncthing, which I would like to
>>> run on the NAS directly. That would, of course, require accessing the
>>> filesystem directly on the NAS rather than just exporting the raw
>>> devices, which means circling back to this issue.
>>>
>>> After updating my NAS, I have determined that the issue still occurs
>>> with Linux 5.8.
>>>
>>> What's the next best step for debugging the issue? Ideally, I'd like t=
o
>>> help track down the issue to find a proper fix, rather than just tryin=
g
>>> to bypass the issue. I wasn't sure if the suggestion to comment out
>>> btrfs_verify_dev_extents() was more geared toward the former or the la=
tter.
>>
>> After rewinding my memory on this case, the problem is really that the
>> ARM btrfs kernel is reading garbage, while X86 or ARM user space tool
>> works as expected.
>>
>> Can you recompile your kernel on the ARM board to add extra debugging
>> messages?
>> If possible, we can try to add some extra debug points to bombarding
>> your dmesg.
>>
>> Or do you have other ARM boards to test the same fs?
>>
>>
>> Thanks,
>> Qu
>
> It's pretty easy to build a kernel with custom patches applied, though
> the actual building takes a while, so I'd be happy to add whatever
> debug messages would be useful. I also have an old Raspberry Pi
> (original model B) I can dig out and try to get going, tomorrow. I
> can't hook it up to the drives directly, but I should be able to
> access them via NBD like I was doing from my desktop.

RPI 1B would be a little slow but should be enough to expose the
problem, if the problem is for all arm builds (as long as you're also
using armv7 for the offending system).

Thanks,
Qu

> If I can't get
> that going for whatever reason, I could also try running an emulated
> ARM system with QEMU.
>
>>>
>>> On Fri, Jun 28, 2019 at 1:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com
>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>
>>>
>>>
>>>      On 2019/6/28 =E4=B8=8B=E5=8D=884:00, Erik Jensen wrote:
>>>       >> So it's either the block layer reading some wrong from the di=
sk
>>>      or btrfs
>>>       >> layer doesn't do correct endian convert.
>>>       >
>>>       > My ARM board is running in little endian mode, so it doesn't s=
eem
>>>      like
>>>       > endianness should be an issue. (It is 32-bits versus my deskto=
p's 64,
>>>       > though.) I've also tried exporting the drives via NBD to my x8=
6_64
>>>       > system, and that worked fine, so if the problem is under btrfs=
, it
>>>       > would have to be in the encryption layer, but fsck succeeding =
on the
>>>       > ARM board would seem to rule that out, as well.
>>>       >
>>>       >> Would you dump the following data (X86 and ARM should output =
the
>>>      same
>>>       >> content, thus one output is enough).
>>>       >> # btrfs ins dump-tree -b 17628726968320 /dev/dm-3
>>>       >> # btrfs ins dump-tree -b 17628727001088 /dev/dm-3
>>>       >
>>>       > Attached, and also 17628705964032, since that's the block
>>>      mentioned in
>>>       > my most recent mount attempt (see below).
>>>
>>>      The trees are completely fine.
>>>
>>>      So it should be something else causing the problem.
>>>
>>>       >
>>>       >> And then, for the ARM system, please apply the following diff=
,
>>>      and try
>>>       >> mount again.
>>>       >> The diff adds extra debug info, to exam the vital members of =
a
>>>      tree block.
>>>       >>
>>>       >> Correct fs should output something like:
>>>       >>   BTRFS error (device dm-4): bad tree block start, want 30408=
704
>>>      have 0
>>>       >>   tree block gen=3D4 owner=3D5 nritems=3D2 level=3D0
>>>       >>   csum:
>>>       >>
>>>      a304e483-0000-0000-0000-00000000000000000000-0000-0000-0000-00000=
0000000
>>>       >>
>>>       >> The csum one is the most important one, if there aren't so ma=
ny
>>>      zeros,
>>>       >> it means at that timing, btrfs just got a bunch of garbage, t=
hus we
>>>       >> could do further debug.
>>>       >
>>>       > [  131.725573] BTRFS info (device dm-1): disk space caching is
>>>      enabled
>>>       > [  131.731884] BTRFS info (device dm-1): has skinny extents
>>>       > [  133.046145] BTRFS error (device dm-1): bad tree block start=
, want
>>>       > 17628705964032 have 2807793151171243621
>>>       > [  133.055775] tree block gen=3D7888986126946982446
>>>       > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
>>>       > [  133.065661] csum:
>>>       >
>>>      416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cb=
a9656fc
>>>
>>>      Completely garbage here, so I'd say the data we got isn't what we=
 want.
>>>
>>>       > [  133.108383] BTRFS error (device dm-1): bad tree block start=
, want
>>>       > 17628705964032 have 2807793151171243621
>>>       > [  133.117999] tree block gen=3D7888986126946982446
>>>       > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
>>>       > [  133.127756] csum:
>>>       >
>>>      416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cb=
a9656fc
>>>
>>>      But strangely, the 2nd try still gives us the same result, if it'=
s
>>>      really some garbage, we should get some different result.
>>>
>>>       > [  133.136241] BTRFS error (device dm-1): failed to verify dev
>>>      extents
>>>       > against chunks: -5
>>>
>>>      You can try to skip the dev extents verification by commenting ou=
t the
>>>      btrfs_verify_dev_extents() call in disk-io.c::open_ctree().
>>>
>>>      It may fail at another location though.
>>>
>>>      The more strange part is, we have the device tree root node read =
out
>>>      without problem.
>>>
>>>      Thanks,
>>>      Qu
>>>
>>>       > [  133.166165] BTRFS error (device dm-1): open_ctree failed
>>>       >
>>>       > I copied some files over last time I had it mounted on my desk=
top,
>>>       > which may be why it's now failing at a different block.
>>>       >
>>>       > Thanks!
>>>       >
>>>
