Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FD13D2AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 04:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAPD2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 22:28:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:41723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAPD2X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 22:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579145300;
        bh=4NgCTVSAULa/jq+0zmA57o8WJFwn6rsFQcI0p5P/VO4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YsWlw8EtCF1EaUyPiq6/5+BEaVF9OERqTJC4qp/FhG6zKMXlX5uWaz7cXTMepp/Ls
         DIjRcKSeR60g38tLr7cMmAtbvaUuC+U9t/QnNfTwYgKhZXkaNJrvKG9AtABpeg3NNN
         ZiBdFov50TlG7BOd7A6cQBHdhSw6DNjnguqQ7bb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCK6-1j3wtr1fmO-00NCCE; Thu, 16
 Jan 2020 04:28:20 +0100
Subject: Re: Issues with FS going read-only and bad drive?
To:     Sabrina Cathey <sabcatlibra@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAM3w-7hHJkVEnrrWfpRxp46tLs1XwcyJVwcEPUr01gLJbs6rBg@mail.gmail.com>
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
Message-ID: <04e02ad9-c0ac-4e8d-1ced-04f8d4110153@gmx.com>
Date:   Thu, 16 Jan 2020 11:28:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAM3w-7hHJkVEnrrWfpRxp46tLs1XwcyJVwcEPUr01gLJbs6rBg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9OF1GZ1vMp92VKFHJwiXKD8HIEYPfxNT9"
X-Provags-ID: V03:K1:Hcw5JaIODRMUhBmksVzk2q5ekoLFSZTOyGu1N7GGJ4l1Lf99278
 yin1aVDkdu6xqCdTV7UyQ22wV94Yb+TDdRaB0p769j6KGUenVQBbaw9gPLmzNXBbiwLpZnY
 Cf45vBPXJF7DmLCPa4IlrlohWhx2TbuBFDShvo/ixfqFD2FZF0GlS/q7MpNCN6tUL733Cr0
 JoqRdybhGZTSrxndezigQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gb7MY+vgkUg=:os6lUu3vHcC5t+9qvz1V5W
 x5AgnWNyZKkpq0IqjlfNs+3NYMzcQzlk2IBqSfmFhqF0AqOdR4vT6lfKrvQ0xaAguqw7hQysS
 gmHtniWHa4/FNCl/x0AkQhcxAlnP2I2zbwRKbUsyGi5hYTyClyifPVaDJpltjVeD8a+fXKRJV
 GMPwLq6IbEoLiqIi+qo+Rw2DP+HiOKoejWFqI5bc/oxrwbmRulWHNrRsz64fLZGpkYOvk1Gc8
 ZEe20l4bxS+wpfHxImr6sJoFnrRVbYQnz5E+X1Gxs9mhyz7aNsXp54TLeCn9F2ysQIylqhxgR
 1LKjbKKuz2VWE0FOjqyElTL4ShF2BZai5fUZZjZLCx1uqKXZpF59S2v06R+hpSLi5pYK3z9Of
 HudofNTtGkDz3Lqlb/hRaBz3mnAZCWfQ6ST1m0OtIF/672ZH+xe4NK84Mx/hmIFOs3JCN8Iqk
 4pfaBP97adfdwnNDMTExSWsvYMoK0nBB4GYn6BCFqBLfawOyUxFUshxbuqNfOGlPv1on+ahWA
 inqetE0IUbNFwtO7+CjaHXNJoTc7fnP8+y5kZ/ieVNI029RsTohRV65N8kkVU1XBnSjfF0E5S
 ovWA2rX6dTFDN5PxMNZr0TDs1Xgt/jmyOQQzhN6+lAvhtO6qE0ek3sO+PKeTxUwQZO8gpxcwP
 mGKlqqwX/gyCWkyp+5itQDRZVwCjkY1tUvpFV0JOjsCPm7uLP7GJIDdLi2w1KBqugmgIsqbdb
 9hdEpYRhPfjsNJDsYih4GPnpWnJx5tmWF5Neh+mB4xRg/DyT5dL8t7WSLIiheJsNMNiBs0MWU
 LiW3Jns+gZDN0e0JZtLnfW9ejw6w4b+UMTFi4Pv7yAN/q7Y+v3zL6crNpuREnUFU+6yYNpq/n
 tTRPkbWdBK8RK4+iFzifhq8OgkZcQA+kuztoe/iWcljQf9rZvqIybKNfesjIA+tCdCpEZZoGj
 GttMNPc3noh2BEDJRyfYM6PEeRRx+HEBemweUU/+54N1PN23sgpnchCPqladLxRkoNYsBFZzo
 A/AYs4bsxWsUq9a/Ay07fnjryqXrQIotrXUXvhX4HGP5gess1zGlch04Sg9iOvPe9PtZbCLW/
 aKcLNVfmV3aTtZOPE/o882fTNGii6ctp0DxfUFA3FIgHj08Tu7AO7nKuFQH5xPKuKVV1ZbBAu
 1emID/oxVe1PbApi/VHZlfB7cMpevrIwlxxJLerrIDmCzPHqQoXsi4gvWW10HLsnx+xsTxxO0
 H0drRVDTkqOmvX0e4PbHs2phIC3KyimzG5qq7H0/kFJRXlX8HgIatApwAclKXWn05zZoph83E
 U97I4InUkFr7I+qWTzVOIZQnsofsz5hVrRkn1OIDJd7RCOkiOu0WjzXGFY4yr6M8Ez/lsTFJj
 I363WwzAAu9WtjBn8ttVg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9OF1GZ1vMp92VKFHJwiXKD8HIEYPfxNT9
Content-Type: multipart/mixed; boundary="orNenzKgtEdOmfhnp3L5YjFLnC1TkIZgx"

--orNenzKgtEdOmfhnp3L5YjFLnC1TkIZgx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/16 =E4=B8=8A=E5=8D=8811:06, Sabrina Cathey wrote:
> Up front required information
>=20
> uname -a;btrfs --version;btrfs fi show;btrfs fi df /shizzle/
> Linux babel.thegnomedev.com 5.3.8-arch1-1 #1 SMP PREEMPT @1572357769
> x86_64 GNU/Linux
> btrfs-progs v5.3.1
> Label: 'shizzle'  uuid: 92b267f2-c8af-40eb-b433-e53e140ebd01
> Total devices 10 FS bytes used 34.18TiB
> devid    2 size 5.46TiB used 4.28TiB path /dev/sdb1
> devid    3 size 5.46TiB used 4.28TiB path /dev/sdg1
> devid    4 size 5.46TiB used 4.28TiB path /dev/sdh1
> devid    5 size 5.46TiB used 4.28TiB path /dev/sdi1
> devid    6 size 5.46TiB used 4.28TiB path /dev/sdj1
> devid    7 size 5.46TiB used 4.28TiB path /dev/sdf1
> devid    8 size 5.46TiB used 4.28TiB path /dev/sda1
> devid    9 size 5.46TiB used 4.28TiB path /dev/sdd1
> devid   10 size 5.46TiB used 4.28TiB path /dev/sde1
> devid   11 size 5.46TiB used 4.28TiB path /dev/sdc1

RAID6 with btrfs is going to be messy when anything doesn't go correct.

Btrfs needs to do 10C2 to assemble a proper mirror, not to mention the
infamous write hole problem.

And unfortunately, btrfs-progs doesn't have the full RAID6 recovery (It
can handle two missing devices, but not trying all possible combinations)=
=2E

This means, we lost the most powerful tool to locate the problem.

So it's pretty hard to ping down the root cause.
>=20
> Data, RAID6: total=3D34.18TiB, used=3D34.13TiB
> System, RAID6: total=3D256.00MiB, used=3D1.73MiB
> Metadata, RAID6: total=3D60.00GiB, used=3D54.65GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> ----
>=20
> dmesg output is over 100k and my understanding is that you have a size
> limit so here is a pastebin: https://pastebin.com/d4BPRS6m
>=20
> ----
>=20
> Story is that I found the server unresponsive and when I rebooted I
> ended seeing a disk was missing https://i.imgur.com/iLgnNBM.jpg
>=20
> I mucked about trying to figure out what to do.  I ended up rebooting
> to see if I could see an issue in the drive controller BIOS and when I
> got back into the OS things seemed okay at first.  It was mounted and
> looked okay but then I noticed issues in dmesg related "parent transid
> verify failed" errors.

Normally this means some is definitely not correct.

>=20
> It's late and I was grasping a straws and random googling.  I tried a
> scrub and it failed and the filesystem went RO.  I retried a few
> times, because insanity.
>=20
> I tried btrfsck (default non-destructive) and it also bailed out
> https://i.imgur.com/ZEq0RjU.jpg

As mentioned, btrfs-progs can't help much for RAID6, especially for so
many devices.

Just to be clear, it's not recommended to use RAID5/6 for metadata or
for many devices.

>=20
> Looking at btrfs device stats it looks like one of the devices
> (/dev/sde) is bad - probably the one that was found missing initially.
> I'm attaching the output of that command.  I'm way out of my depth
> here - my thought is to use btrfs device delete /dev/sde1

If you're pretty sure which device is the culprit, then you can try just
remove the device gracefully first. (power down the system, unplug that
device).

To be extra safe, never mount the fs RW after that.

Then try mount the fs *RO*, then try scrub again.
This would at least reduce the complexity of rebuilding a good stripe.

After that, you can also try btrfs check to see if the result changes.

But considering it's transid problem, it's recommended to salvage your
data asap.


To repeat, don't use RAID5/6 for metadata, or for many devices.

Thanks,
Qu

>=20
> Please can you help me to not lose my data?  With this large an amount
> of data, I have yet to invest in another set of disks for backup (I
> know that RAID isn't backups and I should have them).
>=20
> Any help would be most appreciated
>=20
> Thanks
>=20
> Sabrina
>=20


--orNenzKgtEdOmfhnp3L5YjFLnC1TkIZgx--

--9OF1GZ1vMp92VKFHJwiXKD8HIEYPfxNT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4f2FAACgkQwj2R86El
/qg47gf/QgD+42N2GNTN0geKfwf5JC1uk+dEAKK3y9vtxKNiilLvSHj0bFD65yGR
pH2RrEpCpv97VwtsRLK2ch9ij7KRh30A0Yj+/KO9CXRXLh0lX3zKr2XUlTjoW/Xz
7SuT/miCNd843ovah8hBMXNWNH6LCG6+5YuTeVIRUD/4D1Ob4DchcTCB0sYdjclv
3agR9kF6E0s76vlxTX18Y1orM0h5meyOfF9ofPiHCuA4CND1/QORRXvxTWHlTW3U
VBDGTv0MyDbv2a+XTdvTAXmE6GrVEiVyyf61Dz0EES6KB5G31xEFOjcfxHYLa/It
GUdvyAaeu881OaGsXpiGNd54PxJJgA==
=vg/+
-----END PGP SIGNATURE-----

--9OF1GZ1vMp92VKFHJwiXKD8HIEYPfxNT9--
