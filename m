Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4B22FF1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgG1Buc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 21:50:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:33299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG1Bub (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 21:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595901023;
        bh=eo1w9ER5Ny0bYPRWKMRdY1SdpqvSKHwZdIq1efPB8Ew=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NPVF4hUSN0YoSddoSM+qpav0fnRO95wHSRTdWMsK+ywsE7DWXtemayryaYu2o1oXv
         f0XtHo13qRlm//4xkKHdqlPleFY04S9Z5AB831V8Xe4bRWaCAJ/WeAwuYH8Tkh/qR4
         sTL2frp/K/393B6iwhXNd83a4jwDG6q0ZWxLagsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VHG-1ksg3o2lcQ-016v7G; Tue, 28
 Jul 2020 03:50:23 +0200
Subject: Re: [PATCH] btrfs-progs: Add basic .editorconfig
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <20200728012409.130252-1-dxu@dxuuu.xyz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <85567980-5c9f-99a9-80e3-89e6418ed86f@gmx.com>
Date:   Tue, 28 Jul 2020 09:50:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728012409.130252-1-dxu@dxuuu.xyz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SlXh3KfiEcxUgM9ZbiFssnHzaoooL3IpE"
X-Provags-ID: V03:K1:yXAWU3dJ3Dr0yNY6AoReTBGaxqw7AIjs1V4rleI6sduHc+QIp/1
 qpIUw2buE6vNT94SFpppvpFeYqHUbQkUPNNKc0oq5rFMdAZb63IYWEKCOekKADNNL3nDZcM
 F4o5dR33Y6hkabcKXtfxB+t84evb4y/boVHFLHYhL90Nl5WMwzULC+HLnyNlLqW3pwPab8i
 7u87jTfTCTNrEIDqVwreQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I9hKN8u+cz8=:qexYvwScSraHVEkpMmmMAu
 dtzjE9l5sBNx786+rE4vhXgpAeNvrQ8PlgLkf6OU9TdVs9h4c4GVqnf79BeDvj9pdQF6UTzsz
 7woPhq/TvxOCIvekPAzZHkEF1nnpJrWxKeiuMQrSTKWs4lSnyFAKQLpK8IVYRlddC/uWkcyBj
 5RBg1lB7C9INLfq2NnGDEWoJvkE1AM13wx3xYzmIqIzaT+2yPaoEUZWt6ty60zuzwB+TYGkTc
 Bqq7sRGea2Mxycg1txPSd0DUZjNVfQfGD566AyDrlhoitfky6LRppDT5eH1OlbbPYGcF84qq2
 kvvGToVeq/MmOE9NQBdVcrxXCNxkhpDSQo8Z94q1OJHsvYJHjdWA7pEC9OCLW1rnih/NsojfP
 Uav8PqhZy5SG9gqcx3NvEVZNhm7swMmJ8VCGOaT57w9RyDcj56pY1uuNXnZj+9xLvHJEhHBeI
 1PFPqqzEZ6ip9E407/fKtz+4/yvX9S+HoDTDQhOFGvtdy9CY3ZzDwX4iTm/o2Uty1rRlyniTX
 4FlfHCu6iZI5bYnq5Yb7Y4Gbm03WWiIHzoKyQofrmB0XBkr9MFcp6zc7VSkxvyN0D60UDrcD/
 mo3cVp4wXgcyHFMlPRtMx/tHlf697D+bDJ6BwTSGXyTTrf0a8KRXSIitnTSxT4QGc5mOCMZix
 TCPwr0IiF/94vJ+HXVxv5+2fFXmbjd4jHU1MraQ9N4b+00w0HmzkprboHWanvk4n6mI3aWj9+
 9fjiwPgVcBYwnBftRcV+e1ZjMEP65Q7vzivwtsqQ/gOEfpD0LauuPjHttxqnlhUurtOzMgbud
 MvkhJg6dfFW1sR1xPnooSuYijb39Mf75QRu9R11CruJzdAJu3JRhABzcfupco7ns5EgYgU2S1
 jcmKYACYZRp3IqhEucY/F2o+vET2Je0UJDH0mfdEqhzuubUJiMbqVbn/tYRmBpTZYQnt1cU2l
 TOq5UWB3n1C5Xol3Kkg+Npknt/xXbI36mbJS5FwBo7AebfIcknFmuWmhw9lIVBv0yHgvYpqfh
 7l1ua/3HviIMPlwvSBtlqYsIpPzM/exRWM6PksIYaMlOZXpLoNk0PSFmh145WkiqVp+ROW0Ll
 +gwjM0ZljDTaJaz6I+Q7/i0ZFAu1qrHx9mnA3AUWz7tcYN+0gzfCyhceuHwsjBeGIDq7lAVUv
 WD5X+pL5p8zj9gVCrfUYI8yer3DnnepPW4uinPH/OWBA7NEO0/EZbIXXG4CccPsQ85Sr4uvWe
 zIkF91pPVfSRgsVxin1QTb9qQPxcotz2sQqjZiw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SlXh3KfiEcxUgM9ZbiFssnHzaoooL3IpE
Content-Type: multipart/mixed; boundary="xbBS3hj1fUNPEDA7qbJpeQRWYWE0tyfk5"

--xbBS3hj1fUNPEDA7qbJpeQRWYWE0tyfk5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8A=E5=8D=889:24, Daniel Xu wrote:
> Not all contributors work on projects that use linux kernel coding
> style. This commit adds a basic editorconfig [0] to assist contributors=

> with managing configuration.
>=20
> [0]: https://editorconfig.org/

I like the idea of the generic style file.
It's just one single file for all editors.

Although most btrfs developers I know use vim, and it's not supported
natively, it shouldn't be a big problem, a plugin would handle it
without problem.

>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But a small nitpick inlined below.

> ---
>  .editorconfig | 10 ++++++++++
>  .gitignore    |  1 +
>  2 files changed, 11 insertions(+)
>  create mode 100644 .editorconfig
>=20
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 00000000..2829cfbe
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,10 @@
> +[*]
> +end_of_line =3D lf
> +insert_final_newline =3D true
> +trim_trailing_whitespace =3D true
> +charset =3D utf-8
> +indent_style =3D space
> +indent_size =3D 8
> +
> +[*.py]
> +indent_size =3D 4
> diff --git a/.gitignore b/.gitignore
> index aadf9ae7..1c70ec94 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -65,6 +65,7 @@
>  /cscope.in.out
>  /cscope.po.out
>  .*
> +!.editorconfig

You can force add that file and git should handle it without problem,
and later modification would also be traced by git.

Thanks,
Qu

>=20
>  /Documentation/Makefile
>  /Documentation/*.html
> --
> 2.27.0
>=20


--xbBS3hj1fUNPEDA7qbJpeQRWYWE0tyfk5--

--SlXh3KfiEcxUgM9ZbiFssnHzaoooL3IpE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8fhFsACgkQwj2R86El
/qiMkQf/UC2mxV7PNqXbx8l48KYW8Q7WBO0qRFOoO/xPrUZ2vTMYxy5EmSyIfoaf
9vXn7l9kXouty0WnxdbhKk5iyfAdmkjsi3jyMXtcwH9M1CPR89pEWejAVYmkSBXz
sj9Y+O88SGsiaclvjd0pTt41hiAHltybUCfpZxezXx4zqmlb4+zYhZ1zVCPt3zok
DRaPXSeUnDZ3ox0DTum9yOMHlq/7/Um4o4hm3Fna3JxkhLrq92LZJBPUWkxZZjDu
Ku7LoQ37kH+zsWGVVeiLgRxfs4qO0N6B7mtGC2SlpJbv8dywcKfoMATTwkSsGPxj
MVjjSNUass3SzMPk62zAOfhm/Gjb1w==
=TrgI
-----END PGP SIGNATURE-----

--SlXh3KfiEcxUgM9ZbiFssnHzaoooL3IpE--
