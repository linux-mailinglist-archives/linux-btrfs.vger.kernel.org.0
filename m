Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6E48FA25
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 02:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiAPBZv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 20:25:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:33139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234022AbiAPBZu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 20:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642296347;
        bh=ATML6B0EJGFdYVxCqZO34DJbdSMMg+AAaguDRWskVi8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cp4BaqocV+YrHhHc+HnRND37WgeDluBYP6usCQ7Jb6hj5H0cUPntl38Hd0k469xL8
         lJxpWeOntZAHzMSA598NsG24kY8+X/VHYEP5iZjTQCevk66EVuEggpMH7AtB4k+t2T
         kEFIcN3iGKZjQbJVwctIXMfRwDdweCNC5S2BQUZk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59C2-1nA0EQ27Wu-001AGc; Sun, 16
 Jan 2022 02:25:47 +0100
Message-ID: <0aed5133-5768-f9c5-492f-3218fbc3bb46@gmx.com>
Date:   Sun, 16 Jan 2022 09:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Stickstoff <stickstoff@posteo.de>
References: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
 <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MyVHhOegRCuIUt/N+TsycIG6FL8Zlp0PXQ/dHl1LBN7/R+b51R4
 tZ69qcewZWPqJmUdcDAGBpz1m7q4KeDCaWUZbtR68wJujW7APngorqyFDOEYUyFWnjkv2Fp
 0NpLtJ49Ejn3sSKiUJUGoAiTgQxvYS8moACDMmeQtP310NuffdpmbNMC3g0giJ0mBuab/7n
 kwuW8MaK4mxaTungZyZfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ywWfP6fJj38=:/5ZgydWL1kShen9NzUy9FB
 W8ycAVWc5azoLFEG/4GnHr8kaA8ensK7ku0qQn5TW3HvxIxHNTnn2m19al3Av8obY6pHmNfxD
 owvdQgWV56xZ8TI/jlPlp7UKBlIGtWYXrPql1WHvRlfie8XIWj6GEv7pN1sc2JBPUUF/YxOeU
 LxVaix2OeGS4QpmvHCQY6CO3yB3BmcaFj1PEjLlHSWU1Wnj4it6/YtjMqKDpaj0tz9Fc8D14/
 tpgVO6Jn/hXfWfQE1g9l/oh1R8yKIctRnlpL2kZH2LMrl2dH58XVz1V/RWL5Az89KFFZjWw/U
 9LQiIbbkJW74Hdp2nFGhNsfMMdgMHrSo0zvNiJtiw0ELmk6PGVa3M0JJdXVGFoJwC89He7fsH
 +XbmqD/+sgI6IZnukis7fezhbv50/Uow0FNxNhoo9Qw2fkEdRpBZ+P02cfe6fE+FnWcqhvpEp
 ES0yBHnQJHOeGY3i1bu8BS5mFLAxYDDLD7x3xKHSWm/Eav6tp2Ob1KG9bVaibxZczZXPZKoj1
 bDTBUCb0230TgRLVp7JlRIrkh1JryLwVb7qWdGPvg7sh/ZUq/Z+cMoicGiQACJ/CSvNybXClQ
 YqToEdaJXaYoXnNySiyFaS+wnmmIc45oIucK1OxFSl+uY6Jev2jRmnH8KJb4nCcgMxVo6dL1e
 O7kwt4640flzrryu0rggXcT8lWm0LcEaq8jWhkm5c8CZUuHsgX6OkhekozinOQQJnp8hVO7Ax
 kSCZsLddKCHuviUu8HFh7+igqhYz8xk2eBf4ei6eBNDfnKPs+7/jctyO54J6Z8G6OExwi+T17
 Mh+Qc9tGvaL6OuDU448axIY8cXw/hFMVYO/hRA95G9d6u+e9dCoYmugfUEdMsuPoBfJjFtJSg
 U3RLYlRFmwXke5KpGd0v0W6vZtpk9rZadiPhOVLkjNK1OTM3KWFWkTcr7pWuLNRVljNTux0xa
 GTbCRwbGxduwCq4Id1N/6JibN919atPnHYobSIgRfniMeYanmYw2Wsl860W56Dm91y1g5iLsM
 7YRlbF1X2UyOAC08xqjQiuP1ybITgpLCW5LDFhJWx8TBl4SJ9x9OUO8FAq7oYE3PYGY6WkLla
 RqZGXphpGbqI9c=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/16 04:45, Chris Murphy wrote:
> On Sat, Jan 15, 2022 at 6:17 AM Stickstoff <stickstoff@posteo.de> wrote:
>>
>> Dear btrfs-mailinglist,
>>
>> I upgraded a machine from Debian Stretch (kernel 4.9, btrfs-progs
>> v4.7.3) to Debian Buster (kernel 4.19, btrfs-progs v4.20.1) to Debian
>> Bullseye (kernel 5.10, btrfs-progs v5.10.1) in one go, with a
>> few clean reboots in the process.
>> No (other) traumatic events (like hard shutdown) happened in the last
>> months.
>>
>> Now I got an
>>> 'read time tree block corruption' and
>>> 'corrupt leaf: block=3D934474399744 slot=3D68 extent bytenr=3D42517325=
4144 len=3D16384 invalid tree level, have 33554432 expect [0, 7]'
>> error.
>
> Older kernels don't have the read time tree checker, so they tolerate
> this form of old corruption likely by a bug in an older kernel (but
> hard to say).
>

This doesn't make sense at all.

Tree level is only u8, thus it should never go beyond 255, but we ave
hex 0x2000000 here, which is way beyond the upper limit.

Please provide the output of the following command:

# btrfs ins dump-tree -b 934474399744 <device>

Normally for such impossible cases, hardware problem would be more
possible, but I want to be extra safe before making a conclusion.

Thanks,
Qu

>
>> The filesystem mounts and works, after a while this error shows up and =
sometimes the fs is then forced read-only.
>> A scrub quits after a few minutes with the exact same error.
>
> Forcing read only is the way the file system avoids corrupting itself
> when it gets confused. That way the confusion stays in memory
> (hopefully) rather than ending up making things worse on disk.
>
> Take advantage of the fact you can mount the file system, and freshen
> backups to prepare to abandon this file system. Depending on the
> problem, it might be fixable with current btrfs-progs' btrfs check but
> ... if it's extent tree damage it's going to take a really long time
> to find out, and then only at the end when it either fails or makes
> things worse do you find out.
>
>> After consulting the IRC (thank you again for your help!) I tried "btrf=
s check --readonly"
>> and "btrfs check --repair" both with the stock btrfs-progs v5.10 and v5=
.16 from kdave's git.
>> All runs found no errors or problems and did not fix the corruption.
>
> Interesting that btrfs check doesn't see any problem, while the tree
> checker does. That's its own bug somewhere...
>
> Can you provide a complete dmesg of the read time tree checker error?
> Ideally everything from mount to going read-only.
>
>
>> One possible explanation from IRC was that the corruption might have ex=
isted for a long time, and was only caught
>> when the newer 5.x btrfs started to first check these parts of the fs.
>> The corruption itself might have been caused by bitrot, bad memory or s=
ome random event, the machine is a consumer grade PC with
>> regular non-ECC memory. I noticed maybe two, three unexplained program/=
daemon crashes since 2015.
>
> Yep hard to say but with complete dmesg it might be possible to figure
> it out because bit flips have a pretty unamibiguous signature compared
> to the random junk that a bug from an older kernel might have
> injected. But still, it's unexpected that the tree checker finds
> things that the fsck doesn't.
>
>
