Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62223127BDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfLTNlY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 08:41:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:48363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfLTNlY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 08:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576849281;
        bh=4MvQjGDepgLiDEEgAhJSl6cm8CUYAJOq+6Myc3jlSCE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Yav7r8bWS7DPVJSS0Gd3Q7Lbq7MIAcVu1NGmfWpRsorgKKXyuNf3SM934ES6hse8D
         SBHiAbXsPL8RpHujTifGE4+z10bucPrkpiZkBIET7D9mjnKScLt+Xyw17wXw81pRSx
         BzE2MyjTju9PjmA0N1KyxFQZKfuvgRivpNxK/xzU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYv3-1hpuOD1m4R-00u0e0; Fri, 20
 Dec 2019 14:41:21 +0100
Subject: Re: btrfs dev del not transaction protected?
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
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
Message-ID: <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
Date:   Fri, 20 Dec 2019 21:41:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220132703.GA3435@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AvKYZjinRacQwX10tqabGD468CZipvKGL"
X-Provags-ID: V03:K1:XkYX3v8tp7jM/7RSrEQ5M8uuHWVz8RFCA7RwPKVGgmMHkusxHMh
 +nY+hcqmcncOixlSgkn0cvxfXCnFjsFj0Mp0S4NSNTLJGugvNIP+Xgn1xzL/BzHc1OLaXO2
 ZNydCHT1KgEFB+hJ88gH1igvyO8GFNBKjuhLAtQoJr3rBhqtU2bCPdOhsIxyqx2OEl+urnQ
 XaN0oVUzfNlJJtav6+P4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:THLmenl5i+g=:RQgly1CCfdcsC1sc5t2uZt
 O9IcYulMavJvo1EkEfrsZVC09z3O3HZZynzy5qM/z5u163Hj0woYNjAGtL6DOkCIhMzAf0FJN
 nDVhJz7GpssegjqmoLbvBLvrS4GSZATtXvg7CbYuWZpjicOs4fWQBspL0AjkZquriVr1CPFFk
 jUo6/ytEbFSRMEkMhR3f3SJLg8fTMu/8ZwK4QSzPQUfaz+riPmzGvDZ4fI1oo5HonqqvTwFn7
 Q3N1QVHUJFljfuIkJRkbILo1fyuic08HhZ2OqFe6tzrCDxrxT4oNcU+wc7KdwvXsHXKlIf8vS
 hpttEPTP8dVHkNMIAzfAKx3hGc9znR2dHQhR7jxPon5R+KvS87jhITV5wzKEEj3nli60J7ZYf
 LJbuhWc2j0O4Ymk8ahV8LUXpBsO2u7d87mXPcDRph12YB0i4/955H3ea1pUd7UkOq7KkRXtmh
 1kI45gCzRBhrhQBOzIbdeWk3MaPrm/ukAOo31ztnDA4DbTsQKZnYEinoCtO7kd1rBGKJZwaFA
 K/Aw6G3g3opG9zkAa013JJMQCO+6+XCVfL7z+2CvUNzLk7c0fpKnCSmN2WR03H7kYd5Xbv1Hw
 9zrc0TrqYMVEiJGN04pMlPHXoAv0Y0ceGleu8zz8CPHDqL9HvYIMHbf7vmn6JNUvFJbx9X5R+
 WarJ8KpKdKo1Kd3Lj1vIUVV/DlRh6sf+B+M3ztTPJa5E9816BnQRjJbyOl+hgjBkkqwlIKses
 hH0y6caj03urURo/ihOaU4b8ioyR8m7wQ/ddB1jEHNa+J+Iid3xPM7eJPpvFWjsiBvXtkQzjw
 wT5Q7+Tn5hZIw5APR4VmqxwW6JMZ/vWPc3xnmdehxGIlJELyW9bEl2lmqrqhYrbkFjmm9utdf
 sFioEn5xFrPzB2ZkI1jo4IMk51Stihm71bb3mSQ7pVHwfoPHo4JeWo/dinUqIrdh/2iWgwvsl
 OF6Ya2maMIgMMbgraIE5NVhRqRjzUNjw7Jnxqp/zrICnRi+j45SVfN1LMIS2iFta4vgJHdtEh
 a92QFT/Z/fMZziaQvEq++y1ybhuehC27M6fnkzwpPvYjnDorixDpTgoTBQ4vBIPc8tK7k6DgS
 joGISrpJyVoNdrE7K7diY4TeNYKv4jjd+POj6oiSzg9SIBvR9C0r0SIhIAqbiz14dB0qbf4kW
 esH2mAtrfYWCKg+SBOJyZrLpZ6eEiV5WThyB1ceQx/S/e13AdMtCR0j6qLpPdG0laSb43iDP2
 5n2UnxUj9WoEbT4ZM5quCpAqWo2+ZnQirYn1rVf58VnQ7F157KuGYiDEgbvubhxkYrpfZhnIw
 AHy6wTxnQPN7d7dpcNq5FLSxnuyX38ca1WWtDts31koJ8bCCOMzq11dttd/wOyIroCR3DKWBE
 MkdSYVL1Qub78vSoJWl2hAOyIkkKgK4hXwFLIdi4JU8F8Kig664jJXLoU3ujOfQMi/1SXC56u
 Uwm+t8ucTz6sIwbYYm7CJVN6dqxQF4ad6zapZZHYcLjWS2xWgrc0KWUjGGedsUMnZwRJ+7iz9
 +ba2QZMaU9H2Ln5D1MPmVczw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AvKYZjinRacQwX10tqabGD468CZipvKGL
Content-Type: multipart/mixed; boundary="33m33AcIMrSjMXfgsB9SHrsIdSvXF02JA"

--33m33AcIMrSjMXfgsB9SHrsIdSvXF02JA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/20 =E4=B8=8B=E5=8D=889:27, Marc Lehmann wrote:
>>>  [  102.393185] BTRFS: device label COLD1 devid 5 transid 1876906 /de=
v/dm-30
>>
>> dm-30 is one transaction older than other devices.
>>
>> Is that expected? If not, it may explain why we got the dead device. A=
s
>> we're using older superblock, which may points to older chunk tree whi=
ch
>> has the device item.
>=20
> Well, not that my expectation here would mean anything, but no, from
> experience I have never seen the transids to disagree, or bad thingsa w=
ill
> happen...
>=20
>>>  [  109.626550] BTRFS: device label COLD1 devid 4 transid 1876907 /de=
v/dm-32
>>>  [  109.654401] BTRFS: device label COLD1 devid 3 transid 1876907 /de=
v/dm-31
>>
>> And I'm also curious about the 7s delay between devid5 and devid 3/4
>> detection.
>=20
> That is about the time it takes the disk to wake up when its spinned do=
wn,
> so maybe that was the case - the disks are used for archiving ("cold"
> storage), have a short spin-down and btrfs filesystems can takes ages t=
o
> mount. The real question is why the fortuh disk was already spun up the=
n,
> but the disks do not apply time outs very exactly.
>=20
>> Can you find a way to make devid 3/4 show up before devid 5 and try ag=
ain?
>=20
> Unfortunately, I had to start restoring from backup a while ago, as I n=
eed
> the machine up and restoring takes days.
>=20
> How would I go about making it show up in different orders though? If
> these messages come up independently, I could have spun down some of th=
e
> disks, right?

You could utilize the latest "forget" feature, to make btrfs kernel
module forget that device, provided by "btrfs device scan -u".

So the plan would be something like:
- Forget all devices of that volume
- Scan the two disks with higher transid
- Scan the disk with mismatched transid

Then try to mount the volume.

>=20
>> And if you find a way to mount the volume RW, please write a single
>> empty file, and sync the fs, then umount the fs, ensure "btrfs ins
>> dump-super" gives the same transid of all 3 related disks.
>=20
> I tried -o degraded followed by remounting rw, but couldn't get it to
> mount rw. I tried to mount/remount, though:
>=20
>    04:48:45 doom kernel: BTRFS error (device dm-32): devid 1 uuid f5c3d=
c63-1fac-45b3-b9ba-ed1ec5f92403 is missing
>    04:48:45 doom kernel: BTRFS error (device dm-32): failed to read chu=
nk tree: -2
>    04:48:45 doom kernel: BTRFS error (device dm-32): open_ctree failed
>    04:49:37 doom kernel: BTRFS warning (device dm-31): devid 1 uuid f5c=
3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
>    04:52:30 doom kernel: BTRFS warning (device dm-31): chunk 12582912 m=
issing 1 devices, max tolerance is 0 for writable mount

BTW, that chunk number is very small, and since it has 0 tolerance, it
looks like to be SINGLE chunk.

In that case, it looks like a temporary chunk from older mkfs, and it
should contain no data/metadata at all, thus brings no data loss.

>    04:52:30 doom kernel: BTRFS warning (device dm-31): writable mount i=
s not allowed due to too many missing devices
>    04:52:30 doom kernel: BTRFS error (device dm-31): open_ctree failed
>    04:54:01 doom kernel: BTRFS warning (device dm-32): devid 1 uuid f5c=
3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
>    04:54:45 doom kernel: BTRFS warning (device dm-32): chunk 12582912 m=
issing 1 devices, max tolerance is 0 for writable mount
>    04:54:45 doom kernel: BTRFS warning (device dm-32): too many missing=
 devices, writable remount is not allowed
>=20
> Since (in theory :) the filesystemw a completely backed up, I didn't
> bother with further recovery after I made sure the physical disk is
> actually there and was unlocked (cryptsetup), so it wasn't a case of an=

> actual missing disk.

BTW, "btrfs ins dump-tree -t chunk <dev>" would help a lot.
That would directly tell us if the devid 1 device is in chunk tree.

If passing different <dev> would cause different output, please also
provide all different versions.

>=20
>>> BTW, this (second issue) also happens with filesystems that are not
>>> multi-device.
>>
>> Single device btrfs doesn't need device scan.
>> If that happened, something insane happened again...
>> Thanks,
>=20
> It happens since at least 4.14 on at least four machines, but I haven't=

> seen it recently, after I switched to 5.2.21 one some machines (post-4.=
4
> kernels have this habit of freezing under memory pressure, and 5.2.21 h=
as
> greatly improved in this regard). That also means I had far fewer hard
> resets with 5.2.21, but the problem did not happen on the last resets i=
n
> 5.2.21 and 5.4.5.
>=20
> I originally reported it below, with some evidence that it isn't a
> hardware issue (no reset needed, just wipe the dm table while the devic=
e
> is mounted which should cleanly "cut off" the write stream):
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D204083
>=20
> Since multiple scrubs and full reads of the volumes didn't show up any
> issues, I didn't think much of it.
>=20
> And if you want to hear more "insane" things, after I hard-reset
> my desktop machine (5.2.21) two days ago I had to "btrfs rescue
> fix-device-size" to be able to mount (can't find the kernel error atm.)=
=2E

Consider all these insane things, I tend to believe there is some
FUA/FLUSH related hardware problem.
E.g. the HDD/SSD controller reports FUA/FLUSH finished way before it
really write data into the disk or non-volatile cache, or the
non-volatile cache recovery is not implemented properly...

Thanks,
Qu
>=20
> Greetings,
>=20


--33m33AcIMrSjMXfgsB9SHrsIdSvXF02JA--

--AvKYZjinRacQwX10tqabGD468CZipvKGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl38z3sACgkQwj2R86El
/qgbtwf/eq9CltUJ8TKJAKX8ebOrK2oT69dDyObXhM7suM69rkb2RiEev39l8l2T
69Qe9R1wfHoKgwBDi14rwSSEZ34OiS26PKXI22nq6l+HL28YcWkoMKOOJRDrdynC
Fu6sljbGwAdJiujU8tYH/SGpe/S489t9/z8chVjrkhA3xFIbD1FTf5ISpjFuDeVE
0LaKUsnMjzqtrq/IHmcWPfSg2ZmWG/m8R0aY9fGrGhfO6/2ueEur64tTxZYAFPYh
b5UvI56Vtq4vc/UaNlDhlJ6aKLZYiGQ+mok7U/wRex8gVzMZ3meyUoe6ui9gMfnK
E8w5yi7ezDj1bYqIjMiujwXNHAj9WQ==
=sUWE
-----END PGP SIGNATURE-----

--AvKYZjinRacQwX10tqabGD468CZipvKGL--
