Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBBB22FF2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 03:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgG1B7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 21:59:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:59897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgG1B7K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 21:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595901544;
        bh=WxUa5AYoOz3Y+A4obr0nT28kCtJeLwObZSfpyR+TPgE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YNqFquSi27GIDultU2wuM6gPzFMo2TCuBB5ITD4idSWYC0FB8iUYjmuQVlboWbAHW
         OIV5xUW4GYL3vDHGuuCL009idnZ+yqpsChuH/w1CF6Q1IlzGvKs48H2M6vacKWHVMS
         d/p9IYOmvb9WWKdaiFl5rjSOW5CUk0NBwBkV1C+g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1kRLeE2V0n-00hJlw; Tue, 28
 Jul 2020 03:59:04 +0200
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <20200728015715.142747-1-dxu@dxuuu.xyz>
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
Message-ID: <00342f00-b18e-0d5f-8b5d-5b8f58cc8645@gmx.com>
Date:   Tue, 28 Jul 2020 09:58:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728015715.142747-1-dxu@dxuuu.xyz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yzdSZ2RrCEApRkgtRYB6lHcLMaC2Tppy5"
X-Provags-ID: V03:K1:CtMWRtqm0PM9owgICHFjhd6m74JPOlfA9r8gTSElN6ZCCs8oedm
 vLFBaSzfvqEVmGZJenW04HCodkC8sTj/EPWLNfQ3eEUZZJTZaEHswz0soFz0A0pq9tmzszl
 Pqr0JXauyPrDQDKciTSxpkUDjE/suvI8XGnoBezm9aJnFRUcWt2kf97BeEGMDMGqRRpJBrW
 gj3rg/SjbxMJTvZl3N+9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7MJj2E+pb90=:mc8GVUlTXeedjw67m1Cfot
 /it1k6Sc3s9JTiPastVNT0xr+3k+HgA0e1ZO0h/ANr7YWqrfqjdnsUahp96kP7N1IzVWWX6ct
 Ynv82bE26qBvFoDCBvCTYjK+RLL6ihxIGwDxJZI/liRAxj/vvdBlwiPuC44BvlTZrRaEU8ljg
 M+m9xKOzr71quqigxZPZ6WAZd+oXGeH05BOY09x0GnDfXERNvLjXDT5CRiAoewxGVVEloiRTE
 lx52oU5HP+Erw3vBC7If1gY9HVAt7KS/WLhD+yTA9OfvzqQ0YE5eqepheXpcWrQ05tFAGwFA9
 ImoWYmzVbaWrG6Xui9tYihlli1GJ/dqGbRuCVETvCAbYn6xaMfcm8zFbI4pOG/rvWZDDqGc3Y
 PyUUBR9l8iWd+lSonPoPiO81EWVBfizNfrGqFdJ74SuOf/0BLQvw+6FnQtLHW0lJ6F7PVVj2G
 5SI07uUe4sU2ClFk4ymQHF3X6O0uca3vlq8nuYmRtJ7T54y+x9uwT19+V8s0FAOzXEmMWltA7
 qAFcOBDbPYyq5cCMRVq3URsnLggUrKW3rqw0+CZxDYR+y0PrQyDRn+1ZOc0f3J3WSuL8YXdSd
 5yQaYdHGGO1OXDlSCUeqEP8zqoaZ1TTwwooXpYGrntOMOVyY3CtMH1V1rIaDOjP/4OyF2fiTc
 zWqP1rtSHDKog35yqEweSdYp+j9vHwgjAFA634WnWlEGUi1VKqh3rrbRRddF0G2fgnE66dl72
 kWKNxlCZfIeu8IR9cG1bp6cERCgecfNgXHVZrRGQEXoxe9R71IX4M2k3yvUzPC88InGF6LDMJ
 vsfubC0owvIIIDe38fwvx5UerYx/TK75Gc2NriNfDJhzprYf8Jz43D8KZ8q8NEM2YBw4dTCN3
 dY+TygoWjkUUAvEGmenDFC5t3zG9R/08zCfY0wzOmEc+6s5glIoCnPcejv42NKuZkA/VYEuZI
 GZAKL8Ved0GNRw9Mi8K/K7/7AgP4h1jjKPGteJbu8qrhs0VxTCaeNxbffuV5x6/7aVEmycqb5
 GYNRrJSC8cxEoO6z0rp9MVjvUaOXKeSB//sNYdhbwZF/+wOK0yBA9SDBZDpMP6X8L3pL170sP
 cRTydtuhsO9JrxFwkiddg2vNuQzPYuD4IAuBYW2gyntXbUsSnqzT58tfb6xy0O5qt9k0NtieL
 nZDJvAqyrIYz74EFJCXEijv9CTtjPR+PW2JmhGPsh68CE+nGGjRwZ0s+pIwwcil2fq05GzGOc
 UvTjPeU8TLZ1vpDL4I2ch3zHP7x2njzspkZiTVA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yzdSZ2RrCEApRkgtRYB6lHcLMaC2Tppy5
Content-Type: multipart/mixed; boundary="VxUwJCQCMJ5G45RanzRSBDSEPNpbJWUnh"

--VxUwJCQCMJ5G45RanzRSBDSEPNpbJWUnh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8A=E5=8D=889:57, Daniel Xu wrote:
> Not all contributors work on projects that use linux kernel coding
> style. This commit adds a basic editorconfig [0] to assist contributors=

> with managing configuration.
>=20
> [0]: https://editorconfig.org/
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> Changes from V1:
> * use tabs instead of spaces

That's fast! Just seconds before I exposed the indent_style problem.

Now it's properly reviewed.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>=20
>  .editorconfig | 10 ++++++++++
>  .gitignore    |  1 +
>  2 files changed, 11 insertions(+)
>  create mode 100644 .editorconfig
>=20
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 00000000..7e15c503
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,10 @@
> +[*]
> +end_of_line =3D lf
> +insert_final_newline =3D true
> +trim_trailing_whitespace =3D true
> +charset =3D utf-8
> +indent_style =3D tab
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
>=20
>  /Documentation/Makefile
>  /Documentation/*.html
> --
> 2.27.0
>=20


--VxUwJCQCMJ5G45RanzRSBDSEPNpbJWUnh--

--yzdSZ2RrCEApRkgtRYB6lHcLMaC2Tppy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8fhmMACgkQwj2R86El
/qioEwgAqGkQN37DxnW296P6+80QF356W6rxFlYIgdoUU0Jfoqo5LaE3NdaeQ11J
BvSCzjvSW9eggPSwCP0ssLU2vzzE+fii/7zkKBfc+5hkj2lo9TexwtXILL1nIFic
yn8OsF2odgielEsYASpdkflU74hc5uDXdAGgyPWeHAiZ5XrEFRWa/viAAbm4+t42
3HOunzB3sKjIRDqVvLUAB/0jiJV0mOx41QIzd05CeAvo9eLrzD1OFp/+6Nmy+IDU
LoMpNQSU7k/IwuHwsxsA8pqHoqpSH0kwhagzpQNgGkz49SjQ4tR+YecXi7blTsxR
JjPsw5xMZKnrgo7zN2u3iPFSlLye5g==
=Bhf4
-----END PGP SIGNATURE-----

--yzdSZ2RrCEApRkgtRYB6lHcLMaC2Tppy5--
