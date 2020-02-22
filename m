Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368DF168D31
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 08:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBVHXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 02:23:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:46271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgBVHXE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 02:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582356173;
        bh=EQu4EetwEow8o7GG8XHjxHdEw0VYlgngupX3JgWPl+s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Pocc5QTbhaBERAewjc9uCExALhQpmrZAngtIaD3CC7PAtyEeBjuShLtkgKAiZbRbq
         OBSp2Fg/rllrGQA+H7cCDBeIcPrs9ZtZsxIP+rJUfngYC69ob3Cl8QeaEiSAeWuXvI
         HYCpIFZYAJWFbbz56cJ5Dg6aQd9FAh3FVA1j51xk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRMs-1izsGr3vZc-00Ti3x; Sat, 22
 Feb 2020 08:22:53 +0100
Subject: Re: FIDEDUPERANGE woes may continue (or unrelated issue?)
To:     halfdog <me@halfdog.net>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2442-1582352330.109820@YWu4.f8ka.f33u>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <31deea37-053d-1c8e-0205-549238ced5ac@gmx.com>
Date:   Sat, 22 Feb 2020 15:22:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2442-1582352330.109820@YWu4.f8ka.f33u>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="54vY29lUBsplmB6pdnC4L1SmkZbNAH4V6"
X-Provags-ID: V03:K1:MAiy5x/dJOXLA16VE8+uveyVm4ALLPP3tDbqPGgjYUYrFcay+H5
 OOGRoiYtY8W0SHXW8PXgTuFssmTktqfXqDiLoTrrnhI/RClUHbcbwTKMRPzyz8Kb5DvUyI6
 XhhRPOAPP4Jjb9URCs7VbW0JWeayzpA/E4D7PIl4N96xC5bHcGoAKj+rTYQxhHVvqpPYCZW
 M8ywa25ayziOQnR3YR5Ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k+Ej43hO7Oc=:L7F3PI6q6EDI1H27MoogiU
 9JD6p5qtiWBTywfNK06Em7ljWj5QyV/zF44lr7D6rvwgzUnok4iEEFJqtCJMNL7deCG+rLsqB
 5en6OFCFjE6WOGrWgljlwB2pn6fokrkXNsnLkOb93w13F249SpwYCQvNiHtIg3/KNjyY1DM7W
 mC5RkrVwpsxLm7zGgTLpJxF1c3a9hoZfCFDpxlGO5Ex7eUiFb7uk0KnUXP0i1dn3o1hbQJFE7
 k0O6W2W5ZCgOWxNAUIr6/zlJuJEMLEIHWyPfJHQi7lARrZMXgxYurGarFcJ48kV4ahje5epZO
 uR5oO7bw2aDpshbVUq2ycHrUZnli75vCL/J/vsZJaCq9ISq8Gc266jKe6cQ+XZiOdhgwaxP8F
 a9iGOCpmszysA5g71iLez6FmBnpeTfSO+JXUBBjz++cIrskyod9UFEo1kS4QP00KUGNYAYOEM
 E2+HG66wStjX3XHXduZbQz5sqfbmYfKOBfgYvlZM6DBa7TX0x4M2oqgD22pcx+usX6tzNJtxM
 wz4imCsdIQ9gRdG6XqBzcpvrsrKjFrxWnE0hNvrHZYahm5TDs7FbQRIji8TBbfEJTVx1uujJ5
 AS90ouS42eIfHp79sv+UtqEDJqdAi7FmVtabAABMlMxZmCes2tXiHnyWILTvLVoLxRn9DcE3f
 aUjz5TTUADiknmMx8J35zmnkbFyck1NivCLz2MX3uA1ZXRlCXo8H8BXLZqlvQVLbJ7av56Q0g
 0fiXDt9WsGy6C2r+3Y1POfxNDhULeC1PILdZarUTVTyr7Dt8sqzqZ/KdWUkBLpEX9EtaosyVa
 2gz+7+IYyjqwhSrInNKZwC6I9s9pEdW6eeLFe+oFC9XknlKWPcJValiz1UuPnZrjQh3LZ8G+/
 +0h3TaLlkBKbKGXfdKSD99ekSN3SBqHoLZ6sVAC9ZSDGr73pp7LHKOMvjRzhKZyj6WHgArw2a
 2jKt9usY4l3gdZg7/5/v3HhTG7FafrwOu/EZ5cpUAYGIET/fSEi5voP2XAVdCtZUIpLSC1+dq
 +U5h3qO3w60etsYpypaYU/Loj0yr+jtq/u5AD+NtRrzG++7l/9EiLfH3UiDTRmTOKkivgImY9
 FUf9Zg9oZRnDY0gFLQVdyyyG3CqacR/JaRsPgrKGOmmUfZe5f+hzAlKIHLBR49GDLmW116Go2
 FI6Zseb9yzw3S/8Xi0MBLkp6E9Lg9A31jnooR0M8EPy4y/+GVDoTyjq4bZviuf8dvTRAKct9h
 +wPOf5R69AqijW6yO
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--54vY29lUBsplmB6pdnC4L1SmkZbNAH4V6
Content-Type: multipart/mixed; boundary="aqTWflKxqtdiZxkiPuL1q3oT6QjGLv299"

--aqTWflKxqtdiZxkiPuL1q3oT6QjGLv299
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/22 =E4=B8=8B=E5=8D=882:18, halfdog wrote:
> Hello list,
>=20
> Thanks for the fix to the bug reported in "FIDEDUPERANGE woes".
>=20
> I now got a kernel including that fix. I verified, that deduplication
> now also worked on file ends. Deduplication also picked up the
> unfragmented version of a file in cases, where the second file
> was fragmented due to the bug having a single tail block extent.
>=20
> Looking now at the statistics, I noticed that the "duperemove"
> did not submit all small files to deduplication for unknown
> reason (also not relevant for the current problem).
>=20
> So I modified the process to submit all identical files and started
> to run it on a drive with bad fragmentation of small files due to
> earlier bug. This procedure terminated middle of night with
> following errors:
>=20
> [53011.819395] BTRFS error (device dm-1): bad tree block start, want 90=
184380416 have 5483876589805514108
> [53011.819426] BTRFS: error (device dm-1) in __btrfs_free_extent:3080: =
errno=3D-5 IO failure

Extent tree already screwed up.

This means your fs is already screwed up.

> [53011.819434] BTRFS info (device dm-1): forced readonly
> [53011.819441] BTRFS: error (device dm-1) in btrfs_run_delayed_refs:218=
8: errno=3D-5 IO failure
> [53624.948618] BTRFS error (device dm-1): parent transid verify failed =
on 67651596288 wanted 27538 found 27200
> [53651.093717] BTRFS error (device dm-1): parent transid verify failed =
on 67651596288 wanted 27538 found 27200
> [53706.250680] BTRFS error (device dm-1): parent transid verify failed =
on 67651596288 wanted 27538 found 27200

Transid error is not a good sign either.

>=20
> Could this be related to the previous fix or is this more likely
> just a random hardware/software bug at a weird time?

Not sure, but I don't think the reflink-beyond-eof fix is related to the
bug, as the main problem is the tree block COW.

Normally such transid corruption is related to extent tree corruption,
which matches the result from btrfs check.

Thanks,
Qu

>=20
> I also tried to apply the btrfs-check to that, but it fails opening
> the device, thus not attempting to repair it ...
>=20
> # btrfs check --progress --clear-space-cache v1 --clear-space-cache v2 =
--super 1 [device]
> using SB copy 1, bytenr 67108864
> Opening filesystem to check...
> checksum verify failed on 90184388608 found 00000000 wanted FFFFFF96
> checksum verify failed on 90184388608 found 00000000 wanted FFFFFF96
> bad tree block 90184388608, bytenr mismatch, want=3D90184388608, have=3D=
15484548251864346855
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>=20
> Any ideas?
>=20
>=20
> PS: I have a database of all file checksums on another drive
> for comparison of file content, if useful.
>=20
>=20
> Filipe Manana writes:
>> On Sat, Dec 14, 2019 at 5:46 AM Zygo Blaxell
>> <ce3g8jdj@umail.furryterror.org> wrote:
>>>
>>> On Fri, Dec 13, 2019 at 05:32:14PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2019/12/13 =3DE4=3DB8=3D8A=3DE5=3D8D=3D8812:15, halfdog wrote:
>>>>> Hello list,
>>>>>
>>>>> Using btrfs on
>>>>>
>>>>> Linux version 5.3.0-2-amd64 (debian-kernel@lists.debian.org) (gcc v=
er=3D
>> sion 9.2.1 20191109 (Debian 9.2.1-19)) #1 SMP Debian 5.3.9-3 (2019-11-=
19)
>>>>>
>>>>> the FIDEDUPERANGE exposes weird behaviour on two identical but
>>>>> not too large files that seems to be depending on the file size.
>>>>> Before FIDEDUPERANGE both files have a single extent, afterwards
>>>>> first file is still single extent, second file has all bytes sharin=
g
>>>>> with the extent of the first file except for the last 4096 bytes.
>>>>>
>>>>> Is there anything known about a bug fixed since the above mentioned=

>>>>> kernel version?
>>>>>
>>>>>
>>>>>
>>>>> If no, does following reproducer still show the same behaviour
>>>>> on current Linux kernel (my Python test tools also attached)?
>>>>>
>>>>>> dd if=3D3D/dev/zero bs=3D3D1M count=3D3D32 of=3D3Ddisk
>>>>>> mkfs.btrfs --mixed --metadata single --data single --nodesize 4096=
 d=3D
>> isk
>>>>>> mount disk /mnt/test
>>>>>> mkdir /mnt/test/x
>>>>>> dd bs=3D3D1 count=3D3D155489 if=3D3D/dev/urandom of=3D3D/mnt/test/=
x/file-0
>>>>
>>>> 155489 is not sector size aligned, thus the last extent will be padd=
ed
>>>> with zero.
>>>>
>>>>>> cat /mnt/test/x/file-0 > /mnt/test/x/file-1
>>>>
>>>> Same for the new file.
>>>>
>>>> For the tailing padding part, it's not aligned, and it's smaller tha=
n
>>>> the inode size.
>>>>
>>>> Thus we won't dedupe that tailing part.
>>>
>>> We definitely *must* dedupe the tailing part on btrfs; otherwise, we =
can'=3D
>> t
>>> eliminate the reference to the last (partial) block in the last exten=
t of
>>> the file, and there is no way to dedupe the _entire_ file in this exa=
mple=3D
>> .
>>> It does pretty bad things to dedupe hit rates on uncompressed contigu=
ous
>>> files, where you can lose an average of 64MB of space per file.
>>>
>>> I had been wondering why dedupe scores seemed so low on recent kernel=
s,
>>> and this bug would certainly contribute to that.
>>>
>>> It worked in 4.20, broken in 5.0.  My guess is commit
>>> 34a28e3d77535efc7761aa8d67275c07d1fe2c58 ("Btrfs: use
>>> generic_remap_file_range_prep() for cloning and deduplication") but I=

>>> haven't run a test to confirm.
>>
>> The problem comes from the generic (vfs) code, which always rounds
>> down the deduplication length to a multiple of the filesystem's sector=

>> size.
>> That should be done only when the destination range's end does not
>> match the destination's file size, to avoid the corruption I found
>> over a year ago [1].
>> For some odd reason it has the correct behavior for cloning, it only
>> rounds down the destination range's end is less then the destination's=

>> file size.
>>
>> I'll see if I get that fixed next week.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/comm=3D
>> it/?id=3D3Dde02b9f6bb65a6a1848f346f7a3617b7a9b930c0
>>
>>>
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>> ./SimpleIndexer x > x.json
>>>>>> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/tes=
t/=3D
>> x > dedup.list
>>>>> Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/te=
st=3D
>> /x/file-1': [(0, 5472256, 155648)]}
>>>>> ...
>>>>>> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt=
/t=3D
>> est/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
>>>>> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D=
3D0=3D
>> , src_length=3D3D155489, dest_count=3D3D1, info=3D3D[{dest_fd=3D3D4, d=
est_offset=3D3D=3D
>> 0}]} =3D3D> {info=3D3D[{bytes_deduped=3D3D155489, status=3D3D0}]}) =3D=
3D 0
>>>>>> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/tes=
t/=3D
>> x > dedup.list
>>>>> Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/te=
st=3D
>> /x/file-1': [(0, 5316608, 151552), (151552, 5623808, 4096)]}
>>>>> ...
>>>>>> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt=
/t=3D
>> est/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
>>>>> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D=
3D0=3D
>> , src_length=3D3D155489, dest_count=3D3D1, info=3D3D[{dest_fd=3D3D4, d=
est_offset=3D3D=3D
>> 0}]} =3D3D> {info=3D3D[{bytes_deduped=3D3D155489, status=3D3D0}]}) =3D=
3D 0
>>>>>> strace -s256 -f btrfs-extent-same 4096 /mnt/test/x/file-0 151552 /=
mn=3D
>> t/test/x/file-1 151552 2>&1 | grep -E -e FIDEDUPERANGE
>>>>> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D=
3D1=3D
>> 51552, src_length=3D3D4096, dest_count=3D3D1, info=3D3D[{dest_fd=3D3D4=
, dest_offset=3D
>> =3D3D151552}]}) =3D3D -1 EINVAL (Invalid argument)
>>>>>
>>>>
>>>
>>>
>>>
>>
>>
>> --=3D20
>> Filipe David Manana,
>>
>> =3DE2=3D80=3D9CWhether you think you can, or you think you can't =3DE2=
=3D80=3D94 you're=3D
>>  right.=3DE2=3D80=3D9D
>=20


--aqTWflKxqtdiZxkiPuL1q3oT6QjGLv299--

--54vY29lUBsplmB6pdnC4L1SmkZbNAH4V6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Q1sYACgkQwj2R86El
/qiG5wf/cXAOBSw+nYiIUsojGAZH7z0DVVKwTWw7oFZu2khpj/0cvXSckLlNJgVm
X5RN7eERkjJjP8ZDgSGX2E5rkfLx0ASvE9iBzqui62P+yw58bnVUzXrOhuO77IkO
iecrKpAK0oM2unpd83ug6ai/j62UOkTIjceYyvAWXGn//oEZ2Vg7M2Y4MkbXximu
g8vnC3uSaP4VJGdn39Q4mn94z7PUZsCLF47CZ11ZJTXvyHo3S/j/jPKr+lBakHpi
2glq7D8nHmc4FMbs1NrNxqU9bBNcSAaSCrxg+IC/fEW3xdYZZhqLJ8u7+ZeXfKpi
OvpqpteUA4XWrqF267NtiCUfb2t8og==
=V6Zn
-----END PGP SIGNATURE-----

--54vY29lUBsplmB6pdnC4L1SmkZbNAH4V6--
