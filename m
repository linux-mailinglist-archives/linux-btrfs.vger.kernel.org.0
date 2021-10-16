Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A664D42FFEB
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbhJPDcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 23:32:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:41531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239232AbhJPDcb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 23:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634355022;
        bh=+qEQl788/ShS2uUamGOt4rNGrm813YyPXLjIoMWila8=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Tc2a5QEzDpcVqlY4cIB06GbTMUSLb0yznFtLJad2SwMmyZjLN40tYDyT+PS4uGarw
         tLlvgIlzsR4PTNNVeTvEwn9Mu0mHS9Mvd44Dnn1aa/kPvZqW0O5Re4K6/aDvN72f1C
         fhA5CD5vUM39EJE7BmQssMYfEErbjOrJiW4mgkmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dwj-1mqH9644X7-015ctX; Sat, 16
 Oct 2021 05:30:22 +0200
Message-ID: <95cd0638-b070-6e92-0de7-bfe74e039684@gmx.com>
Date:   Sat, 16 Oct 2021 11:30:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     James Harvey <jmsharvey771@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
 <637a43e5-4d6f-f69a-74e4-ae240880aa1b@gmx.com>
 <CAHB2pq_6Wb7H3zxvV33gm7j4nknAvPieNtFU_xFRWr4TZE=6cA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: csum failed, bad tree, block, IO failures. Is my drive dead or
 has my BTRFS broke itself?
In-Reply-To: <CAHB2pq_6Wb7H3zxvV33gm7j4nknAvPieNtFU_xFRWr4TZE=6cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+BfnEbfoRMfC0ocQB1fbR/MRPhwh7YCj1V1C7XbZ4IgZwICNxcM
 eJKUoaJzjPtqXd3fp8fdbvBAasO/hgMFa17KxkAxl6D+sFlRXdvejGFOxN0gO5P/bD+MhCp
 ujT+0aOAocFhnlDgMgWU1arzRMaFdArMfZoBH0DhMFvO9t9vzfiPKz8BUTb2wAMEXxd/yST
 3kDSh4oChqMXeXrSnp/BA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tn0Dx0UDiuk=:B4DyGBsiv+fmNDZS6WzHkR
 NA5ReSfkya4H6eLh0+B+Vk4MFCFXXJ3uN4R+Z1Z92WBVAxYtslOj+0Gyg1TfcV96M103/lnba
 XFRw8OOgJYXuBiNna/uiK32/JtnM+OPcAjsA9NW7J9b2T6xVYyjihO/xW4rEK1va3eIC1gpvv
 X3R7q6JUU0BnvwsS7t7cqjNER3M+ll7HHx2S8xkMs2Hc6cu24F2RvICHe3x+AfTVumj1CFBT7
 1fSuwqZaLWkIFGXVIdJOKnOOzbjvoxTprH/LXiR9VI5d9G7dI3kehbpy+78n7YS3sqm6jPF/M
 mCzuByvybonEzx4H2VWRpkUnetrPQPyQI2pcbU5hDpNaaC6otbFWqXL/iLnc1CSikahIfgVEL
 oXAvaPC0VqrNzuSDwUt0mTe1Bsg4E7DzV4v2Y34QYOc68tnb3+b8+LjwM5YXLvJ1plZm1KCsP
 2sGycJLmZ0DiKCxOgoQUJzCOEncElmUQknSnqffoJb6rcDvsszE3DkMmsnxlwv8dW4gncTmB/
 DKQRGrkuKMabeM8qd7IfOikS4NRECjFvGYUlPM3O+++eirrFvacYLphpqo8SFj1hA3ZGkcrBj
 /3aedNnByGblJdO0Hlf1UFJo6Zo7+6T8DVk0enDXmdg2jVJFk9DN0CL18sDurqZjvsjhFbxEJ
 T3xbmmePq1hT9LiRUmrkc2P5H5NGNX2wbBR7pJQyFPgSoB236SegXYYESbz74DOXfTZi6FX/4
 YU2T1auWC6yMthpZw8nHIUAW6mFqdqfjf/8PtISKwQMHaXl+5Gq2O2XYn48HZ4/2w6Xk8bvhk
 dNSGIZpMQU9uZnLw1LKeU7mrBCKpJP7NgIBMGaeJwRzVhSLw/hmaUOuZl/Yj/lpVIsOAhxN/I
 K87WrsuTCZ0woGpiGU8aGwSq0YUrW+6SS/Libp7hpANtMUVJ6NkYd6xerUzIxC92S6lc/4uYy
 m9aR+ahCDqbAmHA7jMIPqCtP00oJ8Gjg6oQtIfLFe/EB0tFnRBFfdHwFv9xsRq9twDy8vGOfa
 /PFv6bwRdyvX+KHID7aCpmQd/GfAOJ39wGH+vWEWf7nC4h1MOfOCCvQhBwlGIFHT5cF43FIau
 odm199SQMENbl0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/16 11:18, James Harvey wrote:
> I have attached the full journalctl from the boot where this first
> happened. Note that this happened again after a scrub and a reboot
> during a different write operation. I'm currently doing a backup (not
> overwriting any of my other backups), so I will do a memory test to
> see if I have bad RAM. I don't have ECC memory so I can't easily
> check.

With the full dmesg, it's much clear how corrupted the fs is:

 > kernel: BTRFS warning (device sdb1): csum failed root 5 ino 97395 off
12255248384 csum 0xd6230a4c expected csum 0x723d189a mirror 1

Previous error are mostly data corruption.

So far still no idea how corrupted/what's going wrong.

But the next ones give us quite some clue:

 > BTRFS error (device sdb1): bad tree block start, want 9344471629824
have 5162927840984877996

The bytenr we got if completely garbage.

This means, some (in fact quite some) metadata blocks are completely
overwritten with garbage or whatever.

Considering the context, it looks like csum tree got some big corruption.

And it's not a common symptom of memory bitflip, but really corrupted
data on-disk.

And btrfs-check should detect such problem, if not, you can try "btrfs
check --check-data-csum" which should throw tons of corruption.

I have no idea how could this happen, maybe disk corruption, or maybe
some other problems.

Thanks,
Qu

>
> On Sat, 16 Oct 2021 at 02:52, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/10/16 08:14, James Harvey wrote:
>>> My server consists of a single 16TB external drive (I have backups,
>>> and I was planning to make a proper server at some point) and I used
>>> BTRFS for the drive's filesystem. Recently, the file system would go
>>> into read only and put a load of errors into the system logs. Running
>>> a BTRFS scrub returned no errors, a readonly BTRFS check returned no
>>> errors, and a SMART check showed no issues/bad sectors.
>>
>> This is very strange, as normally if there is really on-disk corruption=
,
>> especially in metadata, btrfs check should detect it.
>>
>>> Has BTRFS
>>> broke itself or is this a drive issue:
>>>
>>> Here are the errors:
>>
>> Could you please provide the full dmesg?
>>
>> We want the context to see get a whole picture of the problem, not only
>> just error messages from btrfs.
>>
>> If the problem only happens at write time, maybe you want to do a memor=
y
>> test to verify it's not some bitflip in your memory in the mean time.
>>
>> Thanks,
>> Qu
>>>
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105460736 csum 0x75ab540e expected csum
>>> 0xaeb99694 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105464832 csum 0xe83b4c2a expected csum
>>> 0xb9a65172 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105468928 csum 0x4769b37a expected csum
>>> 0x3598cf9e mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105473024 csum 0x7c39a990 expected csum
>>> 0x9c523a6c mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105477120 csum 0xfedc09f1 expected csum
>>> 0x68386e9a mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105481216 csum 0xf9f25835 expected csum
>>> 0x96d2dea3 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105485312 csum 0x37643155 expected csum
>>> 0x6139f8a1 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105489408 csum 0x13893c06 expected csum
>>> 0xb28c00a8 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105493504 csum 0x2a89fcff expected csum
>>> 0x4c5758ed mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 97395 off 14105497600 csum 0x7484b77c expected csum
>>> 0x0a9f3138 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343812173824 have 9856732008096476660
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343806013440 have 757116834938933
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343812173824 have 9856732008096476660
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9622003011584, 9622003015680)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343806013440 have 757116834938933
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343812173824 have 9856732008096476660
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343812173824 have 9856732008096476660
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9622003015680, 9622003019776)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343947784192 have 17536680014548819927
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343812173824 have 9856732008096476660
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343947784192 have 17536680014548819927
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9644356001792, 9644356005888)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>> tree block start, want 9343812173824 have 9856732008096476660
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9622003019776, 9622003023872)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9644356005888, 9644356009984)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9622003023872, 9622003027968)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9633973551104, 9633973555200)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9644356009984, 9644356014080)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9622003027968, 9622003032064)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> hole found for disk bytenr range [9633973555200, 9633973559296)
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>> csum 0xc096fec5 mirror 1
>>> Oct 14 21:50:41 James-Server kernel: BTRFS: error (device sdb1) in
>>> btrfs_finish_ordered_io:3064: errno=3D-5 IO failure
>>> Oct 14 21:50:41 James-Server kernel: BTRFS info (device sdb1): forced =
readonly
>>>
>>> uname -a: Linux James-Server 5.14.11-arch1-1 #1 SMP PREEMPT Sun, 10
>>> Oct 2021 00:48:26 +0000 x86_64 GNU/Linux
>>>
>>> btrfs --version: btrfs-progs v5.14.2
>>>
>>> btrfs fi show:
>>>
>>> Label: 'Seagate 16TB 1'  uuid: e183a876-95e0-4d15-a641-69f4a8e8e7e7
>>>          Total devices 1 FS bytes used 9.61TiB
>>>          devid    1 size 14.55TiB used 9.62TiB path /dev/sdb1
>>>
>>> btrfs fi df:
>>>
>>> Data, single: total=3D9.60TiB, used=3D9.60TiB
>>> System, DUP: total=3D8.00MiB, used=3D1.09MiB
>>> Metadata, DUP: total=3D11.00GiB, used=3D10.74GiB
>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>
>>> Mount options: rw,noatime,compress=3Dzstd:3,space_cache=3Dv2,autodefra=
g,subvolid=3D5,subvol=3D/
>>>
