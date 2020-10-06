Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F56284B53
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgJFMHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 08:07:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:47177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgJFMHQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Oct 2020 08:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601986018;
        bh=thkTqNg3b3z0eJ+XPlxzV/jDIfY+bnVzUtHi1ASkVpM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OQpWsP7bDJRy/2udNMUzATVsgIMpwNUthD9lE+vJTU32FGksBxVhAm84yI2yVr2kz
         L+on9kSVH+4fPBEXn9A/liVkaFCk9fvGAwDAHUekOPUO+21N9ORFTTmJkOjQq6va+N
         S8Y+qC40sM2fWLNKzupt0ELhrbMNC2pRqe5UtlnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOA3P-1k1kYC2pRJ-00OWFB; Tue, 06
 Oct 2020 14:06:58 +0200
Subject: Re: failed to read block groups: Operation not permitted
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>,
        linux-btrfs@vger.kernel.org
References: <20201006090918.GA269054@latitude>
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
Message-ID: <9cd7f2d0-4256-7311-483e-b1169e4c3655@gmx.com>
Date:   Tue, 6 Oct 2020 20:06:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006090918.GA269054@latitude>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k1lgRC3I4TlTNmQm9L1Z6JaKli7Py6a1t"
X-Provags-ID: V03:K1:1tJp2NPdFhWbKQpuLsugZuhcSE3LcFPzsIXR7Nz1t3bR5XYpP3n
 D6PF9vw0sA42+54sS0+J/Ts02J4lq/YPFSciTdskmaG/EJNM+PHJRJUip6uXw/4SMbrM7Ek
 giy4t0QaF26fnSmORHXiuMgLIkk9NwIjJKQ+FMaNEQM9OTBruNlbVOp71ikB4nKZ40e67qW
 75bCcHRbUic4y/Ny1F1SQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xKKH751ME3I=:3hqmovpLgv2pC8sCS9EDpr
 gBgu0XTqCXSxMsVXh9RVdJDqUkSFr/zH5343/4zuhdYTAh2seOstgclKlNCMDCDVsJw4X9gGQ
 J1UPRNfb+42skuUAPFq64Na53DE6i6EX6l6vnvmPHkzRAs0kbGfjX7wAOLLF/+3UaYpagLa8R
 gtlD6JFNWo4E9da9X8pc7e+Uu8NOZ3vqGNhLgERME4b3j58l5P5vhuZdzXwPaDjNuVm1IGELE
 Hm14Fud/RaxUrFNxV9PU+Fg4ajp6mh+ArlP1hkf7QWEFZazvdU/LWUZbWzOYA/TEXsOdtCrz0
 VUx9aM424DtnGx1eH3Amseyqhpt3nGwHU+f70fHTNTsG2+caPgTi/rs7U9Sul6A1EPkgZSUhU
 IHXn94nSTXdLwViBQ9PPFP4/UBg1lHHxX1agSG2J7xNtDSZ4Cfxrit5y7P6wSwT0is9L5N+4r
 saUYHfkNzGbdx8XDZ5Qyw77S8aygzvyJ/Ex7KEIPoeS5xqGf11WcetnwFPqeBietJCCi+yIST
 kfuZjgFhdA+s0RsEkn2VVudGGztpAdCOok3sDbkIYUgn0tyn2eHravw9ix+owRYTOqxEZ9obv
 vFD3PcTKPadwQh1Kr9pBetkJELFkJQNUZlzgdCpg7s4LhzQZlR69dgXo+xBc87CQ9CTy6Useg
 RGBF4sNLJuRXzEkcUlwjOUehi15vpLwP/eCrkgSlKxuk052EwX6UCRBPwxRJa2XGe5YKXbZgi
 /a1/XabZEMXENmlUqG2HHE+le+wV23/2fCBBZ1kvvn5pRPznGP1b4se+WS9PRLhGXXxNtMK+c
 plu66BAB1e09actB4KRnibXdMEYGDx+3VZ88PFwZGDSQinf3W0cP9yko+mHIypRL2CMCgdkTw
 SlFW0SCplJ0Duuqcn7T6T1mR3idA5i1vmZf27INThzoFCeiRQw4L2iFIOAQfk4PofcBJG7ptV
 3E+IEvlLJhm/hkgV6PQhY+bRHVOnW1Pr6ouiGfKlmwMMOJbfbUhkvLboFsgoPvMlg/AaCQfjg
 /dN+QzgMbHqjRt0VzXMpZVE/aZFjP8oFvcaCTKA+tCgRw52e8KF/mpNHKIHLY6Of3BUrNGU+g
 JTWUb3t0cR3kgly0YaW4BGA29ETba+6hqoum1lZ8v33eRdpzhWsYEy43xZYHC30Hkg69aH4ob
 Jc8waIANh7d0o24k1e4Z+7JmfidhaHYEVeqRD347xpVNj6IrIsU4hLDQustZriSERlclNxqT5
 Z17jQKhg4c13210VnRfRuefwrWhCWvBQwk73Tpg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k1lgRC3I4TlTNmQm9L1Z6JaKli7Py6a1t
Content-Type: multipart/mixed; boundary="nJxeuLUHg6yE2suCUYpkrw90HAc8Y9V0d"

--nJxeuLUHg6yE2suCUYpkrw90HAc8Y9V0d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/6 =E4=B8=8B=E5=8D=885:09, Johannes Hirte wrote:
> I recently encountered filesystem damage on a VM. During normal
> operation, the filesystem was remounted ro suddenly. Dmesg showed me
> some errors about parent transid verify failed. I've forced of the VM
> and tried to mount the image on the host, but failed with:
>=20
> [  340.702391] BTRFS info (device loop0p1): disk space caching is enabl=
ed
> [  340.702393] BTRFS info (device loop0p1): has skinny extents
> [  341.815890] BTRFS error (device loop0p1): parent transid verify fail=
ed on 152064327680 wanted 323984 found 323888
> [  341.831183] BTRFS error (device loop0p1): parent transid verify fail=
ed on 152064327680 wanted 323984 found 323888

Your extent tree is corrupted. Metadata CoW is broken.

I don't believe only extent tree get corrupted, other part of your fs
can also be corrupted.

> [  341.831194] BTRFS error (device loop0p1): failed to read block group=
s: -5
> [  341.851954] BTRFS error (device loop0p1): open_ctree failed
>=20
> A btrfs check resulted in:
>=20
> btrfs check /dev/loop0p1
> Opening filesystem to check...
> parent transid verify failed on 152064327680 wanted 323984 found 323888=

> parent transid verify failed on 152064327680 wanted 323984 found 323888=

> parent transid verify failed on 152064327680 wanted 323984 found 323888=

> Ignoring transid failure
> leaf parent key incorrect 152064327680
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
>=20
> The host is running libvirt with kvm, btrfs with RAID1. The VMs are raw=

> images, with btrfs too. I've switche this VM from io=3Dnative to
> io=3Dio_uring, and suspect that this caused the damage. All machines ar=
e
> running kernel 5.8.13.

I'm not sure about the io_uring setup. IIRC as long as you're not using
cache=3Dunsafe, it should be safe.

Does the io_uring ignores the flush?

Thanks,
Qu
>=20
> I was able to recover most of the damaged filesystem with btrfs recover=
=2E
> Is there anything I can do for repair it? And why does the damage happe=
n
> at all with io_uring?
>=20


--nJxeuLUHg6yE2suCUYpkrw90HAc8Y9V0d--

--k1lgRC3I4TlTNmQm9L1Z6JaKli7Py6a1t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl98XdgACgkQwj2R86El
/qgqvAf/bVA9IljIfe5x37HHijEOAur7ysuXaYGlCyjs+nmAao/8p2FmFaGzwCKK
jOJ+LoFaPKEETaeWOeYsuOPMFyitqMOUpMaM8rkqlZo5+HKEUNf36oyofaLUA5fJ
VhJqLgGoBG0oDZTnysUhjc71HrFAgCeAZPCP/sMDzJbK1vAzrhG9eaRYoa1qBO+I
zevTMLt6LAWzFhebWnKpl7rG/VFLVALnMJogsNEZxr1r9cjnCLzhZ6+WjOSS5OUs
2l3mqjV4NkPf8yFl/hjoTxZYq9KRGBw4ZE/BzndoUJJ5AfkZ/ySyda/OH3rLf27g
+/HYFUk2ip20PA72W5H5UZahgylUkw==
=rW5+
-----END PGP SIGNATURE-----

--k1lgRC3I4TlTNmQm9L1Z6JaKli7Py6a1t--
