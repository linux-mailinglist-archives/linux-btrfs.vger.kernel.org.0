Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C16E0F2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 02:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfJWA0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 20:26:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:50685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbfJWA0A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 20:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571790358;
        bh=lg2LiG+1DsG98JhymzkoPNAiC2ZYx4bfli9PP/rLY1U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bkwINSBUJ1vhLZ0OxQD7Noc5E9X6gW5e1B3aVtduOWxKe625oErH832Gt2Ifw3ktL
         hMm2dfjDTeBUlPX8UBT5oyqxKSwjGesZIyQEfrOk/2bAbks83YkocljzvnKcbv8bCS
         VmdU7lLY/maQNKPJchVnGOM9LEuBcVaSQhV7YaBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlTC-1hdJbP1HUc-00js5A; Wed, 23
 Oct 2019 02:25:58 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6745c9b1-d9e5-f541-0774-1596a2d95104@gmx.com>
Date:   Wed, 23 Oct 2019 08:25:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="31nqtepoYkxZndbaBuIpVTOgusTdWwxZs"
X-Provags-ID: V03:K1:lm6xcFt4/0a9H9DoxNfYAhrjrd7vqcb4usNGbVml5sd3o/XEA2W
 agtHwqVAo57B0qTc1vbC1zcIIzCbpzCS231zycqtQzIQIv5I80O77v0O9+qyttPHtX5MYG/
 yvYZ6Uw39VUYjFiWENAZ62mBgy9RiNKwOr8LWd/xRKDOzQBaPG0oW2eBd54eDGsQGgQu6qK
 hpPzmnxJuSShJJgXBBDMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FJxmNtUqeLk=:rE91J7jJc9chr1TYrW3hdF
 99oZo8zPrSVZQkCYurCDeSVdKauYtd0pWOD6wLonG+hLOpb4AdgynVSIANGEHGwGpqbad6k47
 u4qqG0IkHM3FgviQNoHaEpsixQlUTHlrcS7P8D4UQRvHh5jxVwYnnWqoCdR9rtEnlzpJ5acOe
 WDVa6k6G7T+OGIh3mn6JtQ2FgyBVvQW/ne6jMFEGQulAozjOCqz8NwrHy5JOHPBVzcInF0S2f
 FTXQfIpxN5VX1Wr93SCzwIW78i9W15cbixgk+3gc/xKB8xisHnYLhMkYu2L8LNdp3k5Omzoum
 3qaqCGIYyI/13kW4YGEOB4dvnRAbGZy+G4l7VyGT59HPMNcT4yHxfRMCsbO4Sep20HUcGBmrk
 Gix3FV8LWmN9+ZfOx3j77VcnYtkn8u1Cl0AQ3s2Fo58DOGuBNHRjgHe8cSRcsUYJa94C2sxZ7
 6mL+IByO19EjbldXgAVNI36TL4oFURelqdTlIdiQjnKexLQoDN4IoShUOb/TXc4uDfPg6SXdI
 bTW6Pc+T/cfoFjAuIaLsmsxesLkm1EXibXIf1SgKVzzJWcFGcugwkd/0SePBIT+G5KyaZf0bH
 aKr/sAE8RfTW69XJ/5Hu28Nwz6wG3o7mzOnqVoT1fEGOYbS+NJZrUYrZLrLmq9bVDwr9Mp/ZZ
 VUa8LOrPSwznCEEr+0xix9Z7qtF4j+GBHbLRTrR36KEl+LcePELz0YpwP3vZhiZi+W/t6I6iF
 6gQTi8KhuH8GhtQ8rMCzoLQFp3Il4pM4CCmmcYGOB3GLkNy282Bw3ui8yZlMaJS9EgqXoUYHZ
 hKcEZsEsxBWQ2JRB0THUWTNrSheZ32YAzLKuNkb7sjUq+A2DYQXOagUwWClCZCTkFEJjqWR0l
 g6IVvooTnNNUynJ4ZPjKCp9aRh8qX6RxNFE7iWUqk26l9hzGLdTw1Ef/eMRg+KQmYnIigN6+D
 aRTaYotrFpr/EIB4/6b7r2Bez9vQDG/gKkD/Ca9WhP/+OpgWfGR6AY2UafCvHTqfUM1To3ywC
 R6Q3E2Om9Gw11eCGWe/Fa5XIaLcjKfq+FVJ298GGpnjoStnnyqPZqSyAjLi4RgsqLHlMtbIWc
 si7S4zKbdBe12HfHW544qsUuo1XOC0yBWHPX3S4TuFiGKuHys2492GZHFNRTM6D+gkYbPSEeF
 yZD9ttmzmvn84xn/NrcIcysWoc2deffIZh74dV168xs2jeomIFwEQ9u2Ld4/sFlURzI7ZPWbp
 t4tH80xOMrtfyZpMoPzifz/YfL1eWUUlnF8ZbGELnTPZrrqQbC+lOhTis0IY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--31nqtepoYkxZndbaBuIpVTOgusTdWwxZs
Content-Type: multipart/mixed; boundary="ZkZy7KtGlVFALqrBU6xQSEuWLFavPN7h2"

--ZkZy7KtGlVFALqrBU6xQSEuWLFavPN7h2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/23 =E4=B8=8A=E5=8D=886:56, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
>=20
> Am Mo., 21. Okt. 2019 um 15:34 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>> [...] just fstrim wiped some old tree blocks. But maybe it's some unfo=
rtunate race, that fstrim trimmed some tree blocks still in use.
>=20
> Forgive me for asking, but assuming that's what happened, why are the
> backup blocks "not in use" from fstrim's perspective in the first
> place? I'd consider backup (meta)data to be valuable payload data,
> something to be stored extra carefully. No use making them if they're
> no goo when you need them, after all. In other words, does fstrim by
> default trim btrfs metadata (in which case fstrim's broken) or does
> btrfs in effect store backup data in "unused" space (in which case
> btrfs is broken)?

Even backup roots are not trimmed, they has no use, it's just a pointer
to older tree blocks.
The older tree blocks are still trimmed, since they are not in use.

Btrfs has its protection of not trimming tree blocks in use, but I don't
know why it doesn't work.

BTW, to make it clear, here "used" block group just means it has space
being used.
Not means all its space is being used.
Trimming "used" block group is only trimming the unused space (like all
other fs).

And to your last question, yes, backup roots are in unused space, thus
they get trimmed.
But the timing is, only after current transaction is fully committed, to
ensure crash won't cause any problem.
(all in theory though)

>=20
>> [...] One good compromise is, only trim unallocated space.
>=20
> It had never occurred to me that anything would purposely try to trim
> allocated space ...
>=20
>> As your corruption is only in extent tree. With my patchset, you shoul=
d be able to mount it, so it's not that screwed up.
>=20
> To be clear, we're talking data recovery, not (progress towards) fs
> repair, even if I manage to boot your rescue patchset?

Then you should have all your fs accessible, although only read-only.
(Isn't that obvious since the skipbg mount option is under rescue=3D grou=
p?)

Btrfs-progs won't really help here, as it just like kernel, needs to
read extent tree to go on.
But in fact, extent tree is only needed for write operations.

That's exactly what my patchset is doing, skip extent tree completely
for rescue=3Dskipbg mount option.

>=20
> A few more random observations from playing with the drive image:
> $ btrfs check --init-extent-tree patient
> Opening filesystem to check...
> Checking filesystem on patient
> UUID: c2bd83d6-2261-47bb-8d18-5aba949651d7
> repair mode will force to clear out log tree, are you sure? [y/N]: y
> ERROR: Corrupted fs, no valid METADATA block group found
> ERROR: failed to zero log tree: -117
> ERROR: attempt to start transaction over already running one
> # rollback
>=20
> $ btrfs rescue zero-log patient
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> bad tree block 284041084928, bytenr mismatch, want=3D284041084928, have=
=3D0
> ERROR: could not open ctree
> # rollback
>=20
> # hm, super 0 has log_root 284056535040, super 1 and 2 have log_root 0 =
=2E..
> $ btrfs check -s1 --init-extent-tree patient
> [...]
> ERROR: errors found in fs roots
> No device size related problem found
> cache and super generation don't match, space cache will be invalidated=

> found 431478808576 bytes used, error(s) found
> total csum bytes: 417926772
> total tree bytes: 2203549696
> total fs tree bytes: 1754415104
> total extent tree bytes: 49152
> btree space waste bytes: 382829965
> file data blocks allocated: 1591388033024
>  referenced 539237134336
>=20
> That ran a good while, generating a couple of hundred MB of output
> (available on request, of course). In any case, it didn't help.
>=20
> $ ~/local/bin/btrfs check -s1 --repair patient
> using SB copy 1, bytenr 67108864
> enabling repair mode
> Opening filesystem to check...
> checksum verify failed on 427311104 found 000000C8 wanted FFFFFF99
> checksum verify failed on 427311104 found 000000C8 wanted FFFFFF99
> Csum didn't match
> ERROR: cannot open file system
>=20
> I don't suppose the roots found by btrfs-find-root and/or subvolumes
> identified by btrfs restore -l would be any help?

No help at all, especially for trimmed fs.

> It's not like the
> real fs root contained anything, just @ [/], @home [/home], and the
> Timeshift subvolumes. If btrfs restore -D is to be believed, the
> casualties under @home, for example, are inconsequential, caches and
> the like, stuff that was likely open for writing at the time.

btrfs restore is the skip_bg equivalent in btrfs-progs.
It doesn't read extent tree at all, purely use fs trees to read the data.=


The only disadvantage is, you can't access the fs like regular fs, but
only through btrfs restore.

Thanks,
Qu
>=20
> I don't know, it just seems strange that with all the (meta)data
> that's obviously still there, it shouldn't be possible to restore the
> fs to some sort of consistent state.
>=20
> Good night,
> Christian
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>>
>> But extent tree update is really somehow trickier than I thought.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Will keep you posted.
>>>
>>> Cheers,
>>> C.
>>>
>>


--ZkZy7KtGlVFALqrBU6xQSEuWLFavPN7h2--

--31nqtepoYkxZndbaBuIpVTOgusTdWwxZs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2vnhEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qigZQgAk9zoqWGyQmTv1X0+9HpKBSoH
XY8XlVMrg8UCJKol9kIpZmIwZZq6lpmuD3g9L9skoEoxZrGOy6BKCYQsA0OSkzeX
Vu9dYrZef/1ZhZPDtEfliVrpoZOOhrAJ+NCP9n1jYrer+EG1WCxhpjtIivVVm0jv
Wcu9ZrF+q7avu4q+/xEqDtAMRs/XEgwedCpUQ9maQYjXqKkipoL1r3Ke+2yFJZQ0
rMdo6le5QzMKUj0WOVB45uDWJ5oj5n33N+2EYI3XWQaZh0CcBqNKoVGNHz7EkxCy
1SidD2Fy+C8nJDUhuw2L9/WMlAQVc9OqNHitr/bE1Pv+RGzKuld4dbul9BjjJA==
=Rvk2
-----END PGP SIGNATURE-----

--31nqtepoYkxZndbaBuIpVTOgusTdWwxZs--
