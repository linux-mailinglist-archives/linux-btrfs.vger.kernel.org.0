Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98171F8720
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jun 2020 07:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgFNFOZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jun 2020 01:14:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:59261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNFOZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jun 2020 01:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592111660;
        bh=3/ZS2auAkiplEnkiLQL28Ptvl5+4tlILg6YqbxMWw2Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hBEiA4kPvGnmRUi0IqwAsBvx31CB2KbJamzH+vWtmkVU2yIbx7ZkTDWPCsleq+Sg8
         GYpLFbxqBZl05gFEkZUkgr7uigTkGGO5tN23COLmzYYLc2h8hWrP2G+2o1WNGgiRzw
         3rMaloB6oXq552oIsH9hz/ss04H9Soo+lVO66CVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO6M-1j8l9v1jw0-00onhw; Sun, 14
 Jun 2020 07:14:20 +0200
Subject: Re: [PATCH] generic/471: adapt test when running on btrfs to avoid
 failure on RWF_NOWAIT write
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200612140604.2790275-1-fdmanana@kernel.org>
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
Message-ID: <89ce0d58-5c7b-2cb9-ba8b-d4320340c234@gmx.com>
Date:   Sun, 14 Jun 2020 13:14:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612140604.2790275-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CCt0xB5v7qxSVLqzIdVcUOL65qXf68EmK"
X-Provags-ID: V03:K1:dEVX5yYud1tMCKPntAaMsTarZQp3pzgQbuTU+n1ybhR4W55miTe
 xfINCBrgbo2Ylp5f8vk6geSmLhQDzk/icbkOOQJxarzO67et5YZOFq6hl8czFKVYJgm7RCl
 QPca+hEZtsPYAu/2oUY+aLjLqs4MXXKd9/3Tq4Sg/IiIjP/M3f+4XbiZwpMMfc1hIL86N2g
 6x5t0qrfCtseHgR9nQyig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:blquaHcfZZ8=:xTaOeI20+auTlaeVXfUmIm
 sGeHF5/C8ilzSEqKpg5bx6PN65X2pXAQPysw76xJwDFWi2CVMiH1fkQSc83NO7y8Y+a6sW6FJ
 7fkEuXJb40MYyl5LTwaK1IF38juy9TdRLfjVYoBM9YchXUH+OMaAwz9C3NmiDVskmHSy10VKX
 OCKHecBD/UmGEwWTKMEFgV/rRQSE0p7nyHa0+Y23cEWzfwX7k0Fa0TERKbkiKzl3B5JCDIRJw
 Ov5MrcZy6DMwVJjNi0Mf/wmSuKRaYbiBIQYcR65R6wws1RWUpXtNgw3UHCtiwQATDlEb+t3LK
 I5UOU7sjLxXw9JAV7NlFCQoQVuhZRamCS+6nkJWtFkDvQRgadt5IrNDWMRJvgLzMauFwJ3xGS
 C84Bu5NTz7nScFF+5DFR6rOpQewZ7dypYEE9fu8bTZBFdn5RopjWvOs+Wnuw1RC5LHq0rF8eB
 wEMSQkFPa3irGsv9w2EIqDPfaWRNVE6voalSbA8x6M0qpEVHQLD/O4nSzERPJxyOlZy3L27Ov
 7CAK1nuj4k3GA7SchbWmd+by+jmsRZHdAaGspdvpf4sfL4YpzijV0XJ5Ca3aBnJU2DzSg27cU
 C/JQBkoEKa9iOEEQcGgC7N3OJDHtZQbh+ZUZ3j4sRWvej9nBy/Y6yN7zkHo1GJi0LeQCmRnsr
 QhYkxV+abc9EvfQKzRZceATSJeJY+HNN0xK6ciyfkGOL/B91/jh6P2YqpSsXcZ04nxEzC4Efn
 mwkvSIzkzr881SLmzZuS9L+wEg10gsjPZq/r1R5W39++8S8OioPzxdVjjg2zGzmiPTFDQhnKr
 h2e7xGS4fJcIrmDbMoiG/t2eVShFe02WcWhuihh06DZxlP8/YWfghsoGA/3aa3AicXbRce2IJ
 G+4J7pQbAWhY+zHY1meGmKf2gJ3uAZ1zsb1B12RgtlwhPUrNK+26xetAAI8F3YiMTG0OCksfE
 5GJCgeIPc0fmIW7xlA53kRrCrevnqVFttdmKCQOmmVFWZxCwHQM4uG4vzwDWIhBcu6NxAnPT6
 q08wLbpzaskmXAXkg+39UUYaR0bj50mCSeLFNLHwp4a88wB2X2rMPmu4LuiVPzx/pCUiTVgoh
 uvLYv0IPKhoQktxudJNGL1/pCVXVAJ3Fkc/+mf5E02v+Om53ohuudksmwViMRmBvk6CslgEyw
 zKjgvkbbyHA2Blfsr2TnGhS7YFJQ4UL8jGFjd1NATjJEaOCHrNR4C0hbvc2vJRh5YIJ9f+y1C
 Kn/ld6amgGrB5aK6h
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CCt0xB5v7qxSVLqzIdVcUOL65qXf68EmK
Content-Type: multipart/mixed; boundary="cDmvKFquN440NFPGakq3ZCis0sFJpv3gi"

--cDmvKFquN440NFPGakq3ZCis0sFJpv3gi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/12 =E4=B8=8B=E5=8D=8810:06, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> This test currently always fails on btrfs:
>=20
> generic/471 2s ... - output mismatch (see ...results//generic/471.out.b=
ad)
>     --- tests/generic/471.out   2020-06-10 19:29:03.850519863 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//generic/471.out.bad   =
=2E..
>     @@ -2,12 +2,10 @@
>      pwrite: Resource temporarily unavailable
>      wrote 8388608/8388608 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -RWF_NOWAIT time is within limits.
>     +pwrite: Resource temporarily unavailable
>     +(standard_in) 1: syntax error
>     +RWF_NOWAIT took  seconds
>=20
> This is because btrfs is a COW filesystem and an attempt to write into =
a
> previously written file range allocating a new extent (or multiple).
> The only exceptions are when attempting to write to a file range with a=

> preallocated/unwritten extent or when writing to a NOCOW file that has
> extents allocated in the target range already.
>=20
> The test currently expects that writing into a previously written file
> range succeeds, but that is not true on btrfs since we are not dealing
> with a NOCOW file. So to make the test pass on btrfs, set the NOCOW bit=

> on the file when the filesystem is btrfs.

Completely agree with the point for btrfs.

>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/471 | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/generic/471 b/tests/generic/471
> index 7513f023..e9856b52 100755
> --- a/tests/generic/471
> +++ b/tests/generic/471
> @@ -37,6 +37,17 @@ fi
> =20
>  mkdir $testdir
> =20
> +# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail wi=
th -EAGAIN
> +# when writing to a file range except if it's a NOCOW file and an exte=
nt for the
> +# range already exists or if it's a COW file and preallocated/unwritte=
n extent
> +# exists in the target range. So to make sure that the last write succ=
eeds on
> +# all filesystems, use a NOCOW file on btrfs.
> +if [ $FSTYP =3D=3D "btrfs" ]; then

Although I'm not sure if really only specific to btrfs.
XFS has its always_cow sysfs interface to make data write to always do
COW, just like what btrfs do by default.

Thus I believe this may be needed for all fses, and just ignore the
error if the fs doesn't support COW.

Thanks,
Qu

> +	_require_chattr C
> +	touch $testdir/f1
> +	$CHATTR_PROG +C $testdir/f1
> +fi
> +
>  # Create a file with pwrite nowait (will fail with EAGAIN)
>  $XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
> =20
>=20


--cDmvKFquN440NFPGakq3ZCis0sFJpv3gi--

--CCt0xB5v7qxSVLqzIdVcUOL65qXf68EmK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7lsicACgkQwj2R86El
/qiyCwgApS00iFHUb0CTdBRjbpM9bIXEo9CydjZHJjJt48FA58XQoBkPYpWKDRmB
2dNFDOXJPTwrlWkefUnSmm48Sl5E7zg9Z5zPPZ00i6qOoWeh7B/3gWjkbOKKZpLa
Du4Jz4nrpCPCCpbiEsBOJTExeHCORYis3FnJvCZQ3f9olJX4WNhpVwyPIfNkHtCY
scc67bxG/ClDftJsCSFFTadle6jQShr7Ue/uD+gyfM+/ImdaxRkJiHXL/jDdZGKw
RaZVP/IAgAVIKSIhFIJJ1JgbFA3XD6yCKDK/uOTrwUaOLZBa77wzndNUq1h9PM7c
Ypwb9pUJgR/lOrEIYjp494Ou/Ntgmw==
=31WX
-----END PGP SIGNATURE-----

--CCt0xB5v7qxSVLqzIdVcUOL65qXf68EmK--
