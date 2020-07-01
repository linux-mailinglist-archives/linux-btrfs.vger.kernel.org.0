Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E0210192
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgGABg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 21:36:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:54075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgGABg7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 21:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593567415;
        bh=8T2ne8/FoE2W4UzjJZf+nLNcwvu0jsQ8js63U0xyJ8A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RzG8RzMW+Nre38kjGKRycrr2cawgmYo3zJAuocU3RHJewYAHQ0vLEmpsENwHCQL8F
         AzAcxChWPI5T+hL0QcJKFfF7RBGABlXrTG3s0E8pPqS3k0QX+8KIYFODFaq3vUnnRP
         biDZNuuX+wyjmyt5CA8iiK9nGFOXYe0ZAbEIJluQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1jMujN29cZ-00TSii; Wed, 01
 Jul 2020 03:36:55 +0200
Subject: Re: "parent transid verify failed" and mount usebackuproot does not
 seem to work
To:     Illia Bobyr <illia.bobyr@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHzXa9XOa1bppK44pKrqbSq50Xdsm63D_698gvo2G-JDWrNeLg@mail.gmail.com>
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
Message-ID: <45900280-c948-05d2-2cd8-67480baaedae@gmx.com>
Date:   Wed, 1 Jul 2020 09:36:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHzXa9XOa1bppK44pKrqbSq50Xdsm63D_698gvo2G-JDWrNeLg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q4mAGj9WU7SKXUnsGz8Yh3NWN6oD0Lmod"
X-Provags-ID: V03:K1:kcPeqKJg69z4M3usklLE4qp2nt3B1vR6TC9jWvYZh6bYm61NwdI
 kIP5Df4O9bUbqPSMls/gHtMH0u1ISavZlJ9H6ZtNM7dfXUQ4VCZT2bzPMXQOi4izzs7gD2w
 2FI7da/pQBe2qcd1UCez9fX8OfebLXivgMtfYFQ2ZY8fsh0sAs2AyGDkVe8ybl5x4tZGL4I
 rFrgIcttFDjz0DU2alvwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DumHawyipwU=:cei8zEBIYUwWb5AMnhwJwj
 mexLUu09h2Hlal5H6pfjm8cLY0K5P+Z+arvTmxnvn656Q2HnPdWpDnx67nrTNtECkRAM4kPb8
 X/bw6sUtYyjEbNHmyTEQQnmrVUr5tw00NLvYlHgkNIXgcBNyflNK6XO9/WZ2G4U4B39A4vpXY
 DgFAdpL8+xvbEFWN6s7szhgcKGL1Xrru5dSkuup6lmdDIJp9gUWTSTFwrksFJdokmfl43OWZR
 6ARJXIST8xyk4c6VcXrCXSquHXQ52UqJHVxftY6+u+AvTu62kPJRGMYQvZTHCYzIrIqHTCEcb
 xFiiRHLNiAJf97gXlLAURCHVWVbvHWQdw4QUeJs91etQjW1IQEKljHOf4Nl14C9RcARbcpwh4
 r7C9aXUi9/F514NmWqQHhjIYtRrTrMdlxr4pILcNey3+cZqJBlip7cFxiXfQ7U/FgJob4jhy4
 JbduddHUKH/zw0urEk94qIg3Z2XtPatq4QQYAzEYutRe6H2jY4o9U/HvAhJxrWfVWwdV3tnnS
 eiAoKZ3uu+jac7uqffW3vWGMCm0FN4QTLFjF41wW2fgBX4I6DywC/WHe1dC5epJ6N8Ghriiv4
 o5qPrDL68GXPcg/9+QlIXyzw7zXy/gDFwvFVSAu04KuWmv7NimNSgGE1ykbGSpY04zo4AMKw8
 jDQGByx14QVgdp76rLLB2GhKIv5vdwmYa0kLPU6HQGQTQXk6Fo3bI8vw6O/l4PjCjKmuB0VPC
 ZFXcqKRL1mGihW0inbS09/O9AVtxssgSxzeYsHBPiLXSQFixaCRdvER0o3Sl4o8jrb13XWAqO
 D6dVlIzUtmFTyqWExirNqOctxLMKd6B/VrL7glWne3DKcS/EHTyNDCQbfICQ/J6y0ae6YioJB
 rEFlg/MmCFgl8OFkkvck0wDKQfDd5xb4HE9F+yzEE6nQLNMpj6LlL1bnq73tQ3qpKOQpgcx9n
 YzwlwVU8S6fP7MZmcwvP3T/i4/PjzN3w3sacsOiI7u2hkF7fo8Dmo2rV9Oov0qW1cpZi5Xdrg
 DXdNTJLhEIQUyGxMYGNKrVteeRCfaDrl7eq14GC6Fjl8QfUiTxpW0wKKbRfjC3ivHX1I5RzYz
 iJ6apYM57thf0tV0UYeRKhbtUfakKTiyXkxy0TRoi8wgb9ieoERWZFToSi29ueWoOkBynW3fA
 Qbzl3vkR7as0NDBZj/mLmKMajvAGgIsEb1g0FCkCru+ngY3wk+fqPODFFUi2iMitr8keH5fHE
 OwW1WT1/uIuw6kis/1VbCUcvTUDQCNCBeB9J/bQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q4mAGj9WU7SKXUnsGz8Yh3NWN6oD0Lmod
Content-Type: multipart/mixed; boundary="1FA6ehq8XJxQoVsJE7HSgTzjOvV65M3eF"

--1FA6ehq8XJxQoVsJE7HSgTzjOvV65M3eF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/1 =E4=B8=8A=E5=8D=883:41, Illia Bobyr wrote:
> Hi,
>=20
> I have a btrfs with bcache setup that failed during a boot yesterday.
> There is one SSD with bcache that is used as a cache for 3 btrfs HDDs.
>=20
> Reading through a number of discussions, I've decided to ask for advice=
 here.
> Should I be running "btrfs check --recover"?
>=20
> The last message in the dmesg log is this one:
>=20
> Btrfs loaded, crc32c=3Dcrc32c-intel
> BTRFS: device label root devid 3 transid 138434 /dev/bcache2 scanned
> by btrfs (341)
> BTRFS: device label root devid 2 transid 138434 /dev/bcache1 scanned
> by btrfs (341)
> BTRFS: device label root devid 1 transid 138434 /dev/bcache0 scanned
> by btrfs (341)
> BTRFS info (device bcache0): disk space caching is enabled
> BTRFS info (device bcache0): has skinny extents
> BTRFS error (device bcache0): parent transid verify failed on
> 16984159518720 wanted 138414 found 138207
> BTRFS error (device bcache0): parent transid verify failed on
> 16984159518720 wanted 138414 found 138207
> BTRFS error (device bcache0): open_ctree failed

Looks like some tree blocks not written back correctly.

Considering we don't have known write back related bugs with 5.6, I
guess bcache may be involved again?

>=20
> Trying to mount it in the recovery mode does not seem to work:
>=20
> (initramfs) mount -t btrfs -o ro,usebackuproot /dev/bcache0 /mnt
> BTRFS info (device bcache1): trying to use backup root at mount time
> BTRFS info (device bcache1): disk space caching is enabled
> BTRFS info (device bcache1): has skinny extents
> BTRFS error (device bcache1): parent transid verify failed on
> 16984159518720 wanted 138414 found 138207
> BTRFS error (device bcache1): parent transid verify failed on
> 16984159518720 wanted 138414 found 138207
> BTRFS error (device bcache1): parent transid verify failed on
> 16984173199360 wanted 138433 found 138195
> BTRFS error (device bcache1): parent transid verify failed on
> 16984173199360 wanted 138433 found 138195
> BTRFS warning (device bcache1): failed to read tree root
> BTRFS error (device bcache1): parent transid verify failed on
> 16984171298816 wanted 138431 found 131157
> BTRFS error (device bcache1): parent transid verify failed on
> 16984171298816 wanted 138431 found 131157
> BTRFS warning (device bcache1): failed to read tree root
> BTRFS critical (device bcache1): corrupt leaf: block=3D16984183013376
> slot=3D36 extent bytenr=3D11447166291968 len=3D262144 invalid generatio=
n,
> have 138434 expect (0, 138433]
> BTRFS error (device bcache1): block=3D16984183013376 read time tree
> block corruption detected
> BTRFS critical (device bcache1): corrupt leaf: block=3D16984183013376
> slot=3D36 extent bytenr=3D11447166291968 len=3D262144 invalid generatio=
n,
> have 138434 expect (0, 138433]
> BTRFS error (device bcache1): block=3D16984183013376 read time tree
> block corruption detected
> BTRFS warning (device bcache1): failed to read tree root
> BUG: kernel NULL pointer dereference, address: 000000000000001f
> #PF: supervisor read access in kernel mode
>=20
> <a stack trace follows>
>=20
> (initramfs) btrfs --version
> btrfs-progs v5.4.1
>=20
> (initramfs) uname -a
> Linux (none) 5.6.11-050611-generic #202005061022 SMP Wed May 6 10:27:04=

> UTC 2020 x86_64 GNU/Linux
>=20
> (initramfs) btrfs fi show
> Label: 'root' uuid: 0a3d051b-72ef-4a5d-8a48-eb0dbb960b56
>         Total devices 3 FS bytes used 6.55TiB
>         devid    1 size 3.64TiB used 1.62TiB path /dev/bcache1
>         devid    2 size 7.28TiB used 5.21TiB path /dev/bcache0
>         devid    3 size 12.73TiB used 6.80TiB path /dev/bcache2
>=20
> I have tried booting using a live ISO with 5.8.0 kernel and btrfs v5.6.=
1
> from http://defender.exton.net/.
> After booting tried mounting the bcache using the same command as above=
=2E
> The only message in the console was "Killed".
> /dev/kmsg on the other hand lists messages very similar to the ones I'v=
e
> seen in the initramfs environment: https://pastebin.com/Vhy072Mx

It looks like there is a chance to recover, as there is a rootbackup
with newer generation.

While tree-checker is rejecting the newer generation one.

The kernel panic is caused by some corner error handling with root
backups cleanups.
We need to fix it anyway.

In this case, I guess "btrfs ins dump-super -fFa" output would help to
show if it's possible to recover.

Anyway, something looks strange.

The backup roots have a newer generation while the super block is still
old doesn't look correct at all.

Thanks,
Qu
>=20
> P.S. Please CC me, as I am not subscribed.
>=20
> Thank you,
> Illia Bobyr
>=20


--1FA6ehq8XJxQoVsJE7HSgTzjOvV65M3eF--

--q4mAGj9WU7SKXUnsGz8Yh3NWN6oD0Lmod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl776LMACgkQwj2R86El
/qizrAf9Exe3gLWDAophlpIzYprT+Ayl3EvPnSsQ/TQAtBM0/h74YMH0lHLzzhfR
Wc7/JtnhtHIKK3Z/e5bgk0ZcID/s2rls1XZd/5BDic4srx0mKtU++VrIQxKBP5dO
p2TPdOTLREkqcNjGEWJWmq30AeWx4qxXGWTK5OZnTNeJ/N1+5JOwbLOLugdQKWii
9Gs7M5kXWsOHg6iC039AWKlocPIA13CfkDGJr4nuzQgxH5LMtND1s1evV7gxU7q+
j8ppTzDDpX7a2WRtOdwFQmjJ3+gVTuNq5uNIIVwCU5rS+ETqqKWD85rrkVBxhy+L
yzwg+dWAtm8dp22BfuZooz9Gj2qZrQ==
=icxM
-----END PGP SIGNATURE-----

--q4mAGj9WU7SKXUnsGz8Yh3NWN6oD0Lmod--
