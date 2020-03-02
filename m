Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA417512C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 01:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCBAC5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 19:02:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:44873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgCBAC5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 19:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583107357;
        bh=QeMpmZfuxnoKOorDJHu+lkHpdbgI4akPfDnC+vuFGJY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R6uNGmnw6LbBN1in/zW+bThAyCgkixKV47l64IeJ19jRSIqZqcd5N2Z4i1aujxVys
         f7fhhFrOQ/2fkQ+L4B3OkECy6nGlBPodinprwUaZnjUf0W05FAayQDDusenzbN5OV4
         /RaEXo+xBu/78GUY6VbkEodsIZ1Jyu15xEkj5A/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ygY-1j3caY3Oic-00696r; Mon, 02
 Mar 2020 01:02:37 +0100
Subject: Re: [PATCH 2/3] progs: Include btrfs-find-root and btrfs-select-super
 in testsuite
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20200301033344.808-1-marcos@mpdesouza.com>
 <20200301033344.808-3-marcos@mpdesouza.com>
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
Message-ID: <c0521ff0-2adb-0ef5-3dbe-e4f698188ec0@gmx.com>
Date:   Mon, 2 Mar 2020 08:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200301033344.808-3-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2QDc1CiT0R6FldNhAGmPPYNfSUPHYIRS3"
X-Provags-ID: V03:K1:Zm0d+uv575+RjmG2j7nIdwWKfyC36Xb4bukuYXZzVdiPoXRKL3s
 Solw5n6OrM3deGmb6V9dxnq+AKNSS1Vp+CdWNhhuXvnIht8zKYWFFoF7xhk/DpgHORa4MED
 jMHNILXdK8nqGVHtpN+b7VGop4xMmDz2FJLfA1FjF+SYl5AS3j+UYpyTnRAWzYbEVT50nLj
 fTGqh4HPSm2sWqHRIPBwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0irI6fugUKY=:zJ8w+uLHQwXeXWk8js7TV/
 wTd6Gu8onTsFLHvuzQiEn3mL5zY+jsJZVpph6L4umHTe4fn7iuajdcgP0vDIPjqXgId446AgM
 FH4e1ggpAQqNiYKxqtvzdjHff522sRuhwNSujHiiMGRKhm/4Gh07OYW5XesTHxg4JvdjX5bx1
 Lvs6wh6ULGbr8RfiNwEAVEiT6TDU1Gy8zwv6zYEPp40RPQoyBxdot+L6tVzdah3sSFVNuRfS9
 kiEsDW3B6PiFPpSSswpqLfHVyuSIBCPpSe6FpH9jq3LtMgro5S9YG6YE29FTspffT4g5Ctg5X
 n289hxRcTEOyn0In3vHukDcFpXzXhX6b++ScK10vPp5TCSc3WUzpyIyWhpkAc5ED8G2wImKWL
 sPxEo0A0uwsnDPymWlxrsRY8LzgxnZ+oCmbMbykxoBoYnPOStQ+FN85JXq4SYuYt7dUM/SVzL
 T50CFIZx5RyL+5Z31fRVjZxpYcANEQLmmV8tHZeBa3T5rRnW9yFRTSXN6PXlX/FEaT6zADjWY
 i0y1Rc8Caroo/R0LDHCz+xoezg7V03vIfIwGP4OheqV4PsDToHPF+D+QGfPT/EckBtI+P/zSG
 WrSZkO24qI3Wt65PH7Ak+a40Ce+dvCx5142d7iFOt1nrCAw1iqAaCZNCMAQtSDecGzxCGhhvr
 MfEUuAnvTwG+9KjE1o+JXc2Grm4BEAyDMu5u/SPv17A0F1F9pT74X1bbFkXP0i9XhiaoyZPUe
 vgyvRTUiaThRkk8LzisbueyXeLk8qClo6a7OjafeD1XdZMyGITB3sSZXBHKeGIk0BRRhBWAWq
 jl0YpPoLLp0XIq5CAKBg4+OQcLyg2GKpBJRWUulIPfM3rvp7o39BM6+PVxQ+OgI4sxQfm4n0Q
 1pn7E60ixCF73mGBD4wspQGrtdHdv2GIxdqucpQ2LJlBl0A5pAl8DF5tYJKt24vR+HCZHxT3m
 NtPBZC5yjFW3icGLOzkGAXolWqZUr7cV5QDq4eD6a8bCCI0WxSd6WM3OKFiYUFwCQZlPTdvfq
 q1sVm4uB27Dllk9F55nijWGCe2XYNJ9jN80dnn7cOBrPsy5sJwBcQwuLSAZDYu7ikNjnidzjn
 ay/6RoQJhiZgo7cjcbX7sQrn5j+SzC3orMxweLyFqPFq7IRV9ndkXKE893Y675C0jphKBRHh/
 VoUaiLCxggyL2bs0dRAYC1mtQs+0SR133lq06mXKFbeqnK39cP+howtr/5X1w2bVVXQf3BLyt
 wQxJriTkDfy0EYFLT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2QDc1CiT0R6FldNhAGmPPYNfSUPHYIRS3
Content-Type: multipart/mixed; boundary="vnBb21zbm06exBls2Q4LTA3V9qrIfFEs9"

--vnBb21zbm06exBls2Q4LTA3V9qrIfFEs9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/1 =E4=B8=8A=E5=8D=8811:33, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Since these two binaries are not shipped into userspace, and they are
> used by the testsuite, they need to be include in the final tar.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small nitpick, the prefix for the patch should be "btrfs-progs: "
not "progs: ".

Thanks,
Qu
> ---
>  Makefile              | 2 +-
>  tests/testsuite-files | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index b00eafe4..0cd7f0c1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -424,7 +424,7 @@ test-inst: all
> =20
>  test: test-fsck test-mkfs test-misc test-cli test-convert test-fuzz
> =20
> -testsuite: btrfs-corrupt-block fssum
> +testsuite: btrfs-corrupt-block btrfs-find-root btrfs-select-super fssu=
m
>  	@echo "Export tests as a package"
>  	$(Q)cd tests && ./export-testsuite.sh
> =20
> diff --git a/tests/testsuite-files b/tests/testsuite-files
> index 09df6298..507d35fb 100644
> --- a/tests/testsuite-files
> +++ b/tests/testsuite-files
> @@ -3,6 +3,8 @@ G Documentation/
>  F testsuite-id
>  F ../fssum
>  F ../btrfs-corrupt-block
> +F ../btrfs-find-root
> +F ../btrfs-select-super
>  F common
>  F common.convert
>  F common.local
>=20


--vnBb21zbm06exBls2Q4LTA3V9qrIfFEs9--

--2QDc1CiT0R6FldNhAGmPPYNfSUPHYIRS3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5cTRgACgkQwj2R86El
/qg38wf/c5rPS/aoqP8D3J/3ixt/kjRqV2eYtx5ZCTEeqFbI0chLRtQs3UhpDSGl
3FFpJvfZ9EysVwmETfPeWQcYQHx2FkCFQZEKrn9wLi/IbuA43m2lA93xgzlCAnoj
XLwcMN5MdA3LOYqXEwI/hwaU+KvX9A9KTVGXXb9uMnbTzKDvnBJMcvXg6vnd24cA
UFzipy37y3aGJqAcx16zynR540MovDfV56/ln+VwIl9mW26l61Hy8mr0McIqUuU2
SmPECQeSynKT8UF2Zs6S8/I9/ZzSCaUqndGDgdT33IfSwqE+Ztv2jP/TcV/eNCM5
jncz7niPfN86DHfVb3DmHleBctXQrQ==
=qrz2
-----END PGP SIGNATURE-----

--2QDc1CiT0R6FldNhAGmPPYNfSUPHYIRS3--
