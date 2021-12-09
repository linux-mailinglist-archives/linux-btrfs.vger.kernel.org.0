Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92C046E91B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhLINaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 08:30:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:34203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234416AbhLIN35 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 08:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639056375;
        bh=JfZqOsEv17BogBn4oTUfKfAyog80U6xcvFba/H5Ae08=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=T2bW0/AI37YbP4+L17UTIzX9SsCb0dFYcFRbiCBmxFUcgMDg8l4OSineItRvEtEkP
         aHXUPHg2SfAgJUTvtLoTSkImvVUBaKrftENlrWMWFoeV4MfvaS+1Vcmr1E2EYOFkZs
         NoMmQeVYijl9nPUjxSQAm2M74RM1jFHKzX/367T0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ml6qM-1mGnc62rnA-00lRSr; Thu, 09
 Dec 2021 14:26:15 +0100
Content-Type: multipart/mixed; boundary="------------XDWZ3J3IdJLung0OfUbUuNB2"
Message-ID: <7eb7b1f6-6f2b-ebcd-e5da-f5945843da3f@gmx.com>
Date:   Thu, 9 Dec 2021 21:25:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
 <Ya9L2qSe+XKgtesq@debian9.Home>
 <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
 <20211207145329.GW28560@twin.jikos.cz> <20211207154048.GX28560@twin.jikos.cz>
 <CAL3q7H6uUasjNSxpfAN_oNEVQiTtMNGbsEKrvywES4fCbHcByg@mail.gmail.com>
 <20211208140411.GK28560@twin.jikos.cz> <YbHZhGGpBvqoqfiT@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
In-Reply-To: <YbHZhGGpBvqoqfiT@debian9.Home>
X-Provags-ID: V03:K1:PXL/AFz0e9hLF5EUL7I0firv5zoNZesPrg6vVxZWoEhOyEmHPuq
 gbGQ4vznut4lPBlK7TWHL+9acbc9Nnftd9+uEa3YdlCEqqAO9QqQt7gRmcrUAkms9x8JG47
 kNUCqLQ+zPhBSveSefJoM6kVXqEluRHsQJZesA0EnuqY2TWJF4SDNxCo0TvvnyWeubEdb/C
 C6oj4YviNYq411kJVUMTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MuW35Pqb5xA=:9Zpib0atKvybAOzXFWkCIL
 QR0xwW2mNPC1PETMKTSgtxWBlOWh1EHA9UrAl6/8/qxne93Nzr+OG9uZGVKEls/B/g3FDzQdP
 xBLv/72BtOnkVrUoFDvURQA9syCiRWqhLsRKJ96iWrzzwvbgvQovFubixBpR7Dt4IJ2vcLBBk
 Tc53wJlc+fL+F8dGLgKtDgLwTf+TYFiYCZfzsjL7tnH1JsEASXSjFzkU1MUX7gGSNa8NKlayo
 eZA+EWRCSF6JNN12ZPN34OcJ94tLHjayR1PJED7CULGMdiQWstX9pvcD8of0x8ptXoAagHBBE
 TTm3sNlGJZZPXNn8m0RrgME4nleUGz3By4nhF3df1hgUqRy5gO7xGvlXNZlcPegUE+EoFIPMN
 UgRWIN6CrBIEJSCz50m/yUDYD/NpZqC5a0cwBEz0IKIViUNGjuCBhDD5fNCEdNIp3ifCi3rsE
 Mzvr/QxUZWX1RQ9Bf8P6+QX7rjcmEJqfKLk2Ol4rNLqKUVUehB036RSl0dio8jFvvGjld93YB
 QWMX0NaEMO+y4H8T91msnFMypaTAW0c4OtNlLTHJThDAo5MCwwFBiBnudWiA9lOeEV+GYoJwF
 QNJKpKlZYQB3bBSAhQoAe2GeDlFvdMjU3Igae6qPOqy9FtxW76iBRbMvJqfGx3Q0vxFuzYqv8
 IqhrWFMrPukH3AAhzlM00rqrXNn+iVUj1ED8l1FtDEYYUhlgJi59vx+e7XP7zwtguyM9oxeZj
 0UbEnujOzE41fXHr2enPNG6hJuNmOlc2mUIuWWNICdRHSlxBGBEl+/MHtuMneku6LOeP4oBh6
 1caKY/9S8JgP9ZTthNbPrF1QyGxWhqM+JTSMHmyMO87VwMTXl4/mfZ4LzjORTe4/rqFWP7Sno
 ncjx1xOlGy92yd72BM+ocb7f2xD4ZcDMPC5Mt29nJAYk1/oRuKoRqfJ9XntSjNzy2gY9i3Zdb
 +JaYXw0oQwfSc7B08KTOl7emDeH0ld6AlBKqqg9VQLRPGQkLM+Fklm2qLm6BKTGdolmyr6cu+
 h1qa9Jjoili17qqbHP3Hx6u2jcBUcPtL42mY+AHh+orrlYvMfZOtYVX4MMpH1EQBe5NOE7ggv
 GX9nhZA6oSsF5s=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------XDWZ3J3IdJLung0OfUbUuNB2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/12/9 18:25, Filipe Manana wrote:
> On Wed, Dec 08, 2021 at 03:04:11PM +0100, David Sterba wrote:
>> On Tue, Dec 07, 2021 at 03:53:22PM +0000, Filipe Manana wrote:
>>>>> I'm doing some tests, in a VM on a dedicated HDD.
>>>>
>>>> There's some measurable difference:
>>>>
>>>> With readahead:
>>>>
>>>> Duration:         0:00:20
>>>> Total to scrub:   7.02GiB
>>>> Rate:             236.92MiB/s
>>>>
>>>> Duration:         0:00:48
>>>> Total to scrub:   12.02GiB
>>>> Rate:             198.02MiB/s
>>>>
>>>> Without readahead:
>>>>
>>>> Duration:         0:00:22
>>>> Total to scrub:   7.02GiB
>>>> Rate:             215.10MiB/s
>>>>
>>>> Duration:         0:00:50
>>>> Total to scrub:   12.02GiB
>>>> Rate:             190.66MiB/s
>>>>
>>>> The setup is: data/single, metadata/dup, no-holes, free-space-tree,
>>>> there are 8 backing devices but all reside on one HDD.
>>>>
>>>> Data generated by fio like
>>>>
>>>> fio --rw=3Drandrw --randrepeat=3D1 --size=3D3000m \
>>>>           --bsrange=3D512b-64k --bs_unaligned \
>>>>           --ioengine=3Dlibaio --fsync=3D1024 \
>>>>           --name=3Djob0 --name=3Djob1 \
>>>>
>>>> and scrub starts right away this. VM has 4G or memory and 4 CPUs.
>>>
>>> How about using bare metal? And was it a debug kernel, or a default
>>> kernel config from a distro?
>>
>> It was the debug config I use for normal testing, I'll try to redo it o=
n
>> another physical box.
>>
>>> Those details often make all the difference (either for the best or
>>> for the worse).
>>>
>>> I'm curious to see as well the results when:
>>>
>>> 1) The reada.c code is changed to work with commit roots;
>>>
>>> 2) The standard btree readahead (struct btrfs_path::reada) is used
>>> instead of the reada.c code.
>>>
>>>>
>>>> The difference is 2 seconds, roughly 4% but the sample is not large
>>>> enough to be conclusive.
>>>
>>> A bit too small.
>>
>> What's worse, I did a few more rounds and the results were too unstable=
,
>> from 44 seconds to 25 seconds (all on the removed readahead branch), bu=
t
>> the machine was not quiescent.
>
> I get such huge variations too when using a debug kernel and virtualized
> disks for any tests, even for single threaded tests.
>
> That's why I use a default, non-debug, kernel config from a popular dist=
ro
> and without any virtualization (or at least have qemu use a raw device, =
not
> a file backed disk on top of another filesystem) when measuring performa=
nce.
>
I got my 2.5' HDD installed and tested.

[CONCLUSION]

There is a small but very consistent performance drop for HDD.

Without patchset:	average rate =3D 106.46 MiB/s
With patchset:		average rate =3D 100.74 MiB/s

Diff =3D -5.67%

[TEST ENV]

HDD:	2T 2.5 inch HDD, 5400rpm device-managed SMR
	(WDC WD20SPZX-22UA7T0)
HOST:	CPU:	AMD RYZEN 5900X
	MEM:	32G DDR4 3200, no ECC

	No obvious CPU/IO during the test duration

VM:	CPU:	16 vcore
	MEM:	4G
	CACHE:	none (as even writeback will cause read to be cached)

Although I'm still using VM, the whole disk is passed to VM directly,
and has cache=3Dnone option.

The initial fs is using 1 device RAID0, as this will cause more stripe
based scrub, thus more small metadata readahead triggered.

The initial content for the fs is created by the following fio job first:

[scrub-populate]
directory=3D/mnt/btrfs
nrfiles=3D16384
openfiles=3D16
filesize=3D2k-512k
readwrite=3Drandwrite
ioengine=3Dlibaio
fallocate=3Dnone
numjobs=3D4

Then removed 1/16th (4096) files randomly to create enough gaps in
extent tree.

Then run scrub on the fs using both original code, and the patchset with
reada enabled for both extent tree (one new one-line patch) and csum
tree (already enabled in btrfs_lookup_csums_range()).

Both cases get 8 scrubs run each, between each run, all caches are
dropped, and fs get unmounted and re-mounted.

(Yes, this is the perfect situation for the original code, as the fs is
not changed, thus current node is the same as commit root)

Each scrub runs shows every small variants, all the duration difference
is within 1 second.

The result shows results benefit the original code, while with
btrfs_reada_add() removed, the difference is not that large:

[POSSIBLE REASON]

- Synchronous readahead
   Maybe this makes readahead less interruptive for data read?
   As with btrfs_reada_add() removed, path reada is alwasy asynchronous.

- Dedicated readahead thread io priority
   Unlike path reada, the readahead thread has dedicated io priority.

I can definitely rework the framework to make it more modern but still
keeps above two features.

Or is the 5% performance drop acceptable?

Raw scrub test result attached.

Thanks,
Qu

--------------XDWZ3J3IdJLung0OfUbUuNB2
Content-Type: text/plain; charset=UTF-8; name="scrub.log.original"
Content-Disposition: attachment; filename="scrub.log.original"
Content-Transfer-Encoding: base64

c2NydWIgZG9uZSBmb3IgMTZlY2QzZjktNTQ2Ni00Zjk5LTg1NGItMmE1MGE0MzY5YTk3ClNj
cnViIHN0YXJ0ZWQ6ICAgIFRodSBEZWMgIDkgMjA6MjI6NDAgMjAyMQpTdGF0dXM6ICAgICAg
ICAgICBmaW5pc2hlZApEdXJhdGlvbjogICAgICAgICAwOjAyOjI2ClRvdGFsIHRvIHNjcnVi
OiAgIDE4LjAyR2lCClJhdGU6ICAgICAgICAgICAgIDEwNi4wME1pQi9zCkVycm9yIHN1bW1h
cnk6ICAgIG5vIGVycm9ycyBmb3VuZApzY3J1YiBkb25lIGZvciAxNmVjZDNmOS01NDY2LTRm
OTktODU0Yi0yYTUwYTQzNjlhOTcKU2NydWIgc3RhcnRlZDogICAgVGh1IERlYyAgOSAyMDoy
NTowNiAyMDIxClN0YXR1czogICAgICAgICAgIGZpbmlzaGVkCkR1cmF0aW9uOiAgICAgICAg
IDA6MDI6MjUKVG90YWwgdG8gc2NydWI6ICAgMTguMDJHaUIKUmF0ZTogICAgICAgICAgICAg
MTA2LjczTWlCL3MKRXJyb3Igc3VtbWFyeTogICAgbm8gZXJyb3JzIGZvdW5kCnNjcnViIGRv
bmUgZm9yIDE2ZWNkM2Y5LTU0NjYtNGY5OS04NTRiLTJhNTBhNDM2OWE5NwpTY3J1YiBzdGFy
dGVkOiAgICBUaHUgRGVjICA5IDIwOjI3OjMyIDIwMjEKU3RhdHVzOiAgICAgICAgICAgZmlu
aXNoZWQKRHVyYXRpb246ICAgICAgICAgMDowMjoyNQpUb3RhbCB0byBzY3J1YjogICAxOC4w
MkdpQgpSYXRlOiAgICAgICAgICAgICAxMDYuNzNNaUIvcwpFcnJvciBzdW1tYXJ5OiAgICBu
byBlcnJvcnMgZm91bmQKc2NydWIgZG9uZSBmb3IgMTZlY2QzZjktNTQ2Ni00Zjk5LTg1NGIt
MmE1MGE0MzY5YTk3ClNjcnViIHN0YXJ0ZWQ6ICAgIFRodSBEZWMgIDkgMjA6Mjk6NTcgMjAy
MQpTdGF0dXM6ICAgICAgICAgICBmaW5pc2hlZApEdXJhdGlvbjogICAgICAgICAwOjAyOjI2
ClRvdGFsIHRvIHNjcnViOiAgIDE4LjAyR2lCClJhdGU6ICAgICAgICAgICAgIDEwNi4wME1p
Qi9zCkVycm9yIHN1bW1hcnk6ICAgIG5vIGVycm9ycyBmb3VuZApzY3J1YiBkb25lIGZvciAx
NmVjZDNmOS01NDY2LTRmOTktODU0Yi0yYTUwYTQzNjlhOTcKU2NydWIgc3RhcnRlZDogICAg
VGh1IERlYyAgOSAyMDozMjoyMyAyMDIxClN0YXR1czogICAgICAgICAgIGZpbmlzaGVkCkR1
cmF0aW9uOiAgICAgICAgIDA6MDI6MjUKVG90YWwgdG8gc2NydWI6ICAgMTguMDJHaUIKUmF0
ZTogICAgICAgICAgICAgMTA2LjczTWlCL3MKRXJyb3Igc3VtbWFyeTogICAgbm8gZXJyb3Jz
IGZvdW5kCnNjcnViIGRvbmUgZm9yIDE2ZWNkM2Y5LTU0NjYtNGY5OS04NTRiLTJhNTBhNDM2
OWE5NwpTY3J1YiBzdGFydGVkOiAgICBUaHUgRGVjICA5IDIwOjM0OjQ5IDIwMjEKU3RhdHVz
OiAgICAgICAgICAgZmluaXNoZWQKRHVyYXRpb246ICAgICAgICAgMDowMjoyNQpUb3RhbCB0
byBzY3J1YjogICAxOC4wMkdpQgpSYXRlOiAgICAgICAgICAgICAxMDYuNzNNaUIvcwpFcnJv
ciBzdW1tYXJ5OiAgICBubyBlcnJvcnMgZm91bmQKc2NydWIgZG9uZSBmb3IgMTZlY2QzZjkt
NTQ2Ni00Zjk5LTg1NGItMmE1MGE0MzY5YTk3ClNjcnViIHN0YXJ0ZWQ6ICAgIFRodSBEZWMg
IDkgMjA6Mzc6MTQgMjAyMQpTdGF0dXM6ICAgICAgICAgICBmaW5pc2hlZApEdXJhdGlvbjog
ICAgICAgICAwOjAyOjI2ClRvdGFsIHRvIHNjcnViOiAgIDE4LjAyR2lCClJhdGU6ICAgICAg
ICAgICAgIDEwNi4wME1pQi9zCkVycm9yIHN1bW1hcnk6ICAgIG5vIGVycm9ycyBmb3VuZApz
Y3J1YiBkb25lIGZvciAxNmVjZDNmOS01NDY2LTRmOTktODU0Yi0yYTUwYTQzNjlhOTcKU2Ny
dWIgc3RhcnRlZDogICAgVGh1IERlYyAgOSAyMDozOTo0MCAyMDIxClN0YXR1czogICAgICAg
ICAgIGZpbmlzaGVkCkR1cmF0aW9uOiAgICAgICAgIDA6MDI6MjUKVG90YWwgdG8gc2NydWI6
ICAgMTguMDJHaUIKUmF0ZTogICAgICAgICAgICAgMTA2LjczTWlCL3MKRXJyb3Igc3VtbWFy
eTogICAgbm8gZXJyb3JzIGZvdW5kCg==
--------------XDWZ3J3IdJLung0OfUbUuNB2
Content-Type: text/plain; charset=UTF-8; name="scrub.log.removed"
Content-Disposition: attachment; filename="scrub.log.removed"
Content-Transfer-Encoding: base64

c2NydWIgZG9uZSBmb3IgMTZlY2QzZjktNTQ2Ni00Zjk5LTg1NGItMmE1MGE0MzY5YTk3ClNj
cnViIHN0YXJ0ZWQ6ICAgIFRodSBEZWMgIDkgMjA6NDM6MDQgMjAyMQpTdGF0dXM6ICAgICAg
ICAgICBmaW5pc2hlZApEdXJhdGlvbjogICAgICAgICAwOjAyOjM0ClRvdGFsIHRvIHNjcnVi
OiAgIDE4LjAyR2lCClJhdGU6ICAgICAgICAgICAgIDEwMC41ME1pQi9zCkVycm9yIHN1bW1h
cnk6ICAgIG5vIGVycm9ycyBmb3VuZApzY3J1YiBkb25lIGZvciAxNmVjZDNmOS01NDY2LTRm
OTktODU0Yi0yYTUwYTQzNjlhOTcKU2NydWIgc3RhcnRlZDogICAgVGh1IERlYyAgOSAyMDo0
NTozOSAyMDIxClN0YXR1czogICAgICAgICAgIGZpbmlzaGVkCkR1cmF0aW9uOiAgICAgICAg
IDA6MDI6MzMKVG90YWwgdG8gc2NydWI6ICAgMTguMDJHaUIKUmF0ZTogICAgICAgICAgICAg
MTAxLjE1TWlCL3MKRXJyb3Igc3VtbWFyeTogICAgbm8gZXJyb3JzIGZvdW5kCnNjcnViIGRv
bmUgZm9yIDE2ZWNkM2Y5LTU0NjYtNGY5OS04NTRiLTJhNTBhNDM2OWE5NwpTY3J1YiBzdGFy
dGVkOiAgICBUaHUgRGVjICA5IDIwOjQ4OjEzIDIwMjEKU3RhdHVzOiAgICAgICAgICAgZmlu
aXNoZWQKRHVyYXRpb246ICAgICAgICAgMDowMjozNApUb3RhbCB0byBzY3J1YjogICAxOC4w
MkdpQgpSYXRlOiAgICAgICAgICAgICAxMDAuNTBNaUIvcwpFcnJvciBzdW1tYXJ5OiAgICBu
byBlcnJvcnMgZm91bmQKc2NydWIgZG9uZSBmb3IgMTZlY2QzZjktNTQ2Ni00Zjk5LTg1NGIt
MmE1MGE0MzY5YTk3ClNjcnViIHN0YXJ0ZWQ6ICAgIFRodSBEZWMgIDkgMjA6NTA6NDggMjAy
MQpTdGF0dXM6ICAgICAgICAgICBmaW5pc2hlZApEdXJhdGlvbjogICAgICAgICAwOjAyOjMz
ClRvdGFsIHRvIHNjcnViOiAgIDE4LjAyR2lCClJhdGU6ICAgICAgICAgICAgIDEwMS4xNU1p
Qi9zCkVycm9yIHN1bW1hcnk6ICAgIG5vIGVycm9ycyBmb3VuZApzY3J1YiBkb25lIGZvciAx
NmVjZDNmOS01NDY2LTRmOTktODU0Yi0yYTUwYTQzNjlhOTcKU2NydWIgc3RhcnRlZDogICAg
VGh1IERlYyAgOSAyMDo1MzoyMiAyMDIxClN0YXR1czogICAgICAgICAgIGZpbmlzaGVkCkR1
cmF0aW9uOiAgICAgICAgIDA6MDI6MzMKVG90YWwgdG8gc2NydWI6ICAgMTguMDJHaUIKUmF0
ZTogICAgICAgICAgICAgMTAxLjE1TWlCL3MKRXJyb3Igc3VtbWFyeTogICAgbm8gZXJyb3Jz
IGZvdW5kCnNjcnViIGRvbmUgZm9yIDE2ZWNkM2Y5LTU0NjYtNGY5OS04NTRiLTJhNTBhNDM2
OWE5NwpTY3J1YiBzdGFydGVkOiAgICBUaHUgRGVjICA5IDIwOjU1OjU2IDIwMjEKU3RhdHVz
OiAgICAgICAgICAgZmluaXNoZWQKRHVyYXRpb246ICAgICAgICAgMDowMjozNApUb3RhbCB0
byBzY3J1YjogICAxOC4wMkdpQgpSYXRlOiAgICAgICAgICAgICAxMDAuNTBNaUIvcwpFcnJv
ciBzdW1tYXJ5OiAgICBubyBlcnJvcnMgZm91bmQKc2NydWIgZG9uZSBmb3IgMTZlY2QzZjkt
NTQ2Ni00Zjk5LTg1NGItMmE1MGE0MzY5YTk3ClNjcnViIHN0YXJ0ZWQ6ICAgIFRodSBEZWMg
IDkgMjA6NTg6MzAgMjAyMQpTdGF0dXM6ICAgICAgICAgICBmaW5pc2hlZApEdXJhdGlvbjog
ICAgICAgICAwOjAyOjM0ClRvdGFsIHRvIHNjcnViOiAgIDE4LjAyR2lCClJhdGU6ICAgICAg
ICAgICAgIDEwMC41ME1pQi9zCkVycm9yIHN1bW1hcnk6ICAgIG5vIGVycm9ycyBmb3VuZApz
Y3J1YiBkb25lIGZvciAxNmVjZDNmOS01NDY2LTRmOTktODU0Yi0yYTUwYTQzNjlhOTcKU2Ny
dWIgc3RhcnRlZDogICAgVGh1IERlYyAgOSAyMTowMTowNCAyMDIxClN0YXR1czogICAgICAg
ICAgIGZpbmlzaGVkCkR1cmF0aW9uOiAgICAgICAgIDA6MDI6MzQKVG90YWwgdG8gc2NydWI6
ICAgMTguMDJHaUIKUmF0ZTogICAgICAgICAgICAgMTAwLjUwTWlCL3MKRXJyb3Igc3VtbWFy
eTogICAgbm8gZXJyb3JzIGZvdW5kCg==
--------------XDWZ3J3IdJLung0OfUbUuNB2--

