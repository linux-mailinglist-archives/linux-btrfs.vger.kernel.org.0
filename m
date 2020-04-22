Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ADC1B39B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 10:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgDVIMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 04:12:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:51769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVIMl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 04:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587543151;
        bh=Ltne7cjTN2T5Yg5O3LFNalRSykoCzooJetjf+obP8Mo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IymacTa4l2e7Atk9hwtU9zlSEbsxRnqwitZ2yd6UrF7kfGkyNqF9U4mJKkNfjECcq
         k1nS5lt1vmJJY7uyHsSKnJwt+0/lDkSKi2mGPxcExqWWx2sP9omFaBqECtvcAbEuQ0
         f1OIDOx31vRYgafMdHgfeuee395FrwjrFkOXJnDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1ijHYu0Z8Z-00htMM; Wed, 22
 Apr 2020 10:12:31 +0200
Subject: Re: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support using
 the more widely used extent buffer base code
To:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
References: <20200422065009.69392-1-wqu@suse.com>
 <20200422095921.126fbe69@nic.cz>
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
Message-ID: <29340f1b-87f8-ced5-725b-5510fad9b6f1@gmx.com>
Date:   Wed, 22 Apr 2020 16:12:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422095921.126fbe69@nic.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1u8ujosjiVNbOLHH8k4crL6XX6kcth0M0"
X-Provags-ID: V03:K1:9KDB8BhnJwl/6ZMNnB4Jkaqte/vspcDP+E3duo2GypiZpmD+xa/
 WPhhKO7BCvywA9XZM2NFo1NZJUBbaTOFnGc7J1Bmq6SURpv6VAqBqCp9RvQeXp28Rx6Axqa
 S4TliQS/L6kMm3GA5dFGYX+iNarEIzxmTa1/DUTJ9j9ZBkWIgJI3u7p6FvFM1DwyIVEGMQ6
 F69Us3gpxomCAPM4MJ9hQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xpavG6dWAQ=:d6uYpV0MBvqvr3bEcKTPYD
 2Qt3rNLCSYCBf2WkTHmbSDWxPIBYAkMrsDqCZdKtcfM6u0fxonyGMF0rbz2LeEAiZHqGjv/xo
 fn2DhDPr4uEN4X5juGNm7PE7uTgoqs1D/RoTxiVnU7tj3bxbO26j9QRotHXfoly3GSNFel3Ia
 lkkK4/CDQBoDqkeSjhJSpwelozl3vgzHd4HMv5HSKz8QB3qXFPdriFMhU+W9Bdh1MrCDnz8BR
 y3X64DEl7RzfgVsq0LUJxW2piQyv3rmXxSw15i56JMWpnMPwSzZH1PPDJ8DPNVdCPIw107XpH
 Te79FjwwVqPMoX9v3EMHdtfBmnvzUC+fy0tYk1lK+keF6+vLd0j0X3y3XNe4kucNwdGMhfNFG
 yHD/mckrWx8Bgy8o9yLDbjTWB69RecaGXcVDh8xXfsewkFXjHkXlMO6oWeOZMKEWal0cIotDV
 Vpiotlh5YjSSnvMVBaCExLFG8APuQK+r+yD/OsmaS2JjpfSyjanjdfkMSfzyLsa2MdBT5ovKV
 cux2LHwpq6DMHDJA2FLU4x3PiNwFQs7ZQHSC8JkWPW3ehhqbCw4xZQPI9fX6Kgg6l0SJyN/CE
 7GMOTWUVDQE1Qkq72pbfWuAVzlg5+EZ0LCRxrhpPEhwNX9rZf4Wagsm7kt1b5Kxdur/qsKXiE
 zej00RIM4CzzzOEx5iAXL3vP1Xhsbp/oUYnk4akRQLu3HNuSMuiQIyaXBBUUdDqm936z7lHku
 peJ/FWxvhLxof6c80sT2Repc1VggUkRG/o1rZMVgcTfMZv3eHh2+PpA+VYjvA8J9LgtJTlW/5
 I1qfG758m7ZIRxgbYEu7bGIsfedM4TvXQiErLHspA1DO3+BiUNRKQR3DCnylFKCM/FxnkFe4z
 OFhj3ztgotZnzN53/EZ16beiCvdkb4hcX9+eVE83cqSLb/odbJJ441HiGBfZUUayxv/HRQk9T
 B5Qy1u/dmKDtaXy6OxOD1Hr+hsyCdco3f80qYwn9gyaO/cvqlw8mNGjZH+9EGP6aX3++lr/q6
 jBCIqrN/WWEuZl5fD4WzH2Xj7Ardm1LRdGZ0UH5pe4eazojgAFVdZmEcVaMyTX2A37eoONnGu
 WGegdNfL1fboIV79N7VWV05Gr+SpKTGIhkR/ATrmhbhNp/0fCIau98HNHkkKfmzk5EP2KlTY6
 awS9wBq7XJKlqVlXuYs9A0viwKDTchZt+/hEueQRh6Ea9vzX8+ryphq2miMArqJIF0iaWz1l5
 5KDxNLzIwpO47VjuI
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1u8ujosjiVNbOLHH8k4crL6XX6kcth0M0
Content-Type: multipart/mixed; boundary="PD1UsTYxfHo8Il9W3Lzw2fcJkQQ4BRQoL"

--PD1UsTYxfHo8Il9W3Lzw2fcJkQQ4BRQoL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/22 =E4=B8=8B=E5=8D=883:59, Marek Behun wrote:
> Also there are some warnings when compiling for Mox and Omnia:
>=20
>=20
>=20
>=20
> fs/btrfs/inode.c: In function =E2=80=98btrfs_lookup_path=E2=80=99:
> fs/btrfs/inode.c:141:16: warning: =E2=80=98parent_root=E2=80=99 may be =
used uninitialized in this function [-Wmaybe-uninitialized]
>   141 |   key.objectid =3D parent_root;
>       |   ~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/btrfs/inode.c:127:7: note: =E2=80=98parent_root=E2=80=99 was declare=
d here
>   127 |   u64 parent_root;
>       |       ^~~~~~~~~~~
>   CC      cmd/nvedit.o
> In file included from fs/btrfs/ctree.h:19,
>                  from fs/btrfs/disk-io.h:7,
>                  from fs/btrfs/disk-io.c:8:
> fs/btrfs/disk-io.c: In function =E2=80=98btrfs_scan_fs_devices=E2=80=99=
:
> fs/btrfs/disk-io.c:881:9: warning: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument=
 3 has type =E2=80=98lbaint_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=
=80=99} [-Wformat=3D]
>   881 |   error("superblock end %u is larger than device size %llu",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   882 |     BTRFS_SUPER_INFO_SIZE + BTRFS_SUPER_INFO_OFFSET,
>   883 |     part->size << desc->log2blksz);
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                |
>       |                lbaint_t {aka long unsigned int}
> fs/btrfs/compat.h:13:29: note: in definition of macro =E2=80=98error=E2=
=80=99
>    13 | #define error(...) { printf(__VA_ARGS__); printf("\n"); }
>       |                             ^~~~~~~~~~~
> fs/btrfs/disk-io.c:881:58: note: format string is defined here
>   881 |   error("superblock end %u is larger than device size %llu",
>       |                                                       ~~~^
>       |                                                          |
>       |                                                          long l=
ong unsigned int
>       |                                                       %lu
>=20
>=20
>=20
>=20
>=20
>=20
> In file included from fs/btrfs/ctree.h:19,
>                  from fs/btrfs/volumes.c:5:
> fs/btrfs/volumes.c: In function =E2=80=98btrfs_check_chunk_valid=E2=80=99=
:
> fs/btrfs/volumes.c:404:9: warning: format =E2=80=98%lu=E2=80=99 expects=
 argument of type =E2=80=98long unsigned int=E2=80=99, but argument 4 has=
 type =E2=80=98u32=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} [-Wforma=
t=3D]
>   404 |   error("invalid chunk item size, have %u expect [%zu, %lu)",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/compat.h:13:29: note: in definition of macro =E2=80=98error=E2=
=80=99
>    13 | #define error(...) { printf(__VA_ARGS__); printf("\n"); }
>       |                             ^~~~~~~~~~~
> fs/btrfs/volumes.c:404:58: note: format string is defined here
>   404 |   error("invalid chunk item size, have %u expect [%zu, %lu)",
>       |                                                        ~~^
>       |                                                          |
>       |                                                          long u=
nsigned int
>       |                                                        %u
>=20
I also hit those with GCC 9.2, but in GCC 9.3 they just disappear, so
I'm not sure whether they are bugs from GCC or something else...

Thanks,
Qu


--PD1UsTYxfHo8Il9W3Lzw2fcJkQQ4BRQoL--

--1u8ujosjiVNbOLHH8k4crL6XX6kcth0M0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6f/GoACgkQwj2R86El
/qhLowf/WgGv4ieIlV6oPevl+zRA8KP8ZQnzm2zYWOlQPn1wKN0WTpnfTc1Mjnyc
VBqIiWn5feg4iu/ClQn+vDzyk67Ufuibi/rY9WHHbiEcOxXAO5A8LCeuCPZfmpX2
vicbOSU9ftB7FHxqeJuDe1JqPX4L0uPAQX3vLCgdCmz/xM1631TulmS/N2acrZsT
pM9VLr61rH8iYXo88tuv/KSProo1ndR6ZQ6bM8uLMus91SzNZssKiRkBBfeKN7gK
zDeYfDkCfZG5PGCR1zM4z0SEsuVFaCM3X0K5gQTs5pc72CduWLOER8OiN331j8oL
d54O9LqJcV6NLGAo50rxLfKY5Y+wxQ==
=Gwmt
-----END PGP SIGNATURE-----

--1u8ujosjiVNbOLHH8k4crL6XX6kcth0M0--
