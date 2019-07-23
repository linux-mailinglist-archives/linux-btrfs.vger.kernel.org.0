Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0250671517
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfGWJ1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 05:27:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:58121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfGWJ1X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 05:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563874037;
        bh=mR0Kf/tQh7yls2y9qDYFTGnp6Vrbbq+GLKL09T4dOv4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Z73A4OxmcEmKxGK8kvEwGE6PaF9RpkYyVPUzxkZEyKq+3O3F9870DqGUmVexfvdyR
         IS0Nwab59BvrSfvNcrc3t1ngvI0ac0fTweJbvk/Xr1bEnnj/xj99T86OqNhrHbnzjp
         6LG5TwPzVWp+yb9Vmm+EgtanX/1UBQuDhGXntB8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDbx-1ihpk13Cyj-00udfC; Tue, 23
 Jul 2019 11:27:17 +0200
Subject: Re: [PATCH] btrfs-progs: check: initialize qgroup_item_count in
 earlier stage
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20190723091911.19598-1-naohiro.aota@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <7b1ca640-224b-dfb6-3ab2-22e70999c81f@gmx.com>
Date:   Tue, 23 Jul 2019 17:27:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723091911.19598-1-naohiro.aota@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MJ5DLCJEGPXs9cJJclTu8hprfpCEP83md"
X-Provags-ID: V03:K1:2pb3yNHGuOohj37IPpWXCN2kxRCtjIaf+ObkrRPrgmGtEq49fBZ
 n3idutAMfV6Fj02WfWAfjCDM7SAEGr3iozo4XrUiZUzNv67MiuoObyAORsmAqRvEtQPiUci
 ZiO5T5ePiUGkJOAieW7k3FQclj3MfkrgDQOMAl8XGJrwiJpbt4JznKHExh2KmGr3zyicOLZ
 VnNrTj4sv9WArFuIc1ImQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ci1xHs/7Lko=:GosmmA2GbidJ5Jclq8+qTJ
 ES10YxxgHkl63sGgpdUrKjreN+mEfpYqEzBHe/6HXNNAptRzU80/EekBLMPYHj34g5wPQVwd4
 ZHJdsTVABnJW8nujzRbEu9CtJ34DpbHB0s6P4ExgMbmJ2eKvk9G5MEWZhcslqL6+eS+VtATUA
 6PVMBPIhodJSUVrpnliS9lOnnezH2ehXUUf8KfrvagLin1kVfN7OduREp/ZOSjwAd0iZVvJ3s
 mRtNL+wVpr6wdLmYnfk1GwKdtWI7KQr1D2P3qtkoFLhDLRj/G+PrJvY8LMUThl2rfrWFMl1LU
 9hi41jmQ8SCt7gxCc1xF1LfQHi6Zz8l43WdZbkave5x2bZYTzLiJwobjTv6tusraoxbaUm0QE
 MybHCOYf1/OGvSEqNsl5Px37LEh17/LRKBLe9NMd9+ZGaJAV4gDOjKW43k4PuOdxxww8/RSdh
 HsESYPJLEwxZVYuTXI3TIV9foAEYoFDL9EeeQmijwPVM9qGqpoGt8X4Ct9n9OcG7IwKn2eMav
 0aUPdtAG22s+gqzEMHQsh5UbqFvcw0fjBsqYU+pP9Op5EvxCYwtqF3gpv0QdTg9AaJUDEoqIb
 y+UKhwv3Vxhd2CFuy8WJKbsN0/2qL10BGOYQhdnP6SwRniJMmFJNG9hg1OYiDQXL2xxVhvZ5a
 TsgqtGF/RyEMRy4vcasfV4nQZaQbph1M1xuzLIKmXTYuDRwz0Jmrz+iu027JQff96cg5Vi3+0
 +SC4iDJ2EjDW0d8E4HxcI/AtmHsDUaArIVxjtEDv5LDYbNvFm4JnXLnY68aDAQ0Y8OlArR8X6
 iRElGgNQKQ5jNE5wNJ0KmywNkg9cs+h+H7z6cFmOqn99bWEpEYDY73sPROyKxKE//oRsyC6kp
 UeH/+3wHeBXAgOFUewHDI9DRYBlEQKDI0ouYa76qECmB/OCrI4m1HBwD+HqeJ3icEfTABFZVL
 BaSe3TV6T4edR5BZOga3XUsoLgb/8Agpk+LSd13MJ76aWYrh9dWKesK/BaVqiU1N/0+MElMFn
 nXeFbi9RIDEvdMRZmEiFrXqhCg6G+hafb1f5ci2jiJuAGIrDwTglEZHIZcSSB/BttdFBPG4k0
 w60V5wB5MAatSo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MJ5DLCJEGPXs9cJJclTu8hprfpCEP83md
Content-Type: multipart/mixed; boundary="Sg52xXHSrtsYdKs6XO5Zcf3Kkzc1yLOH0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Message-ID: <7b1ca640-224b-dfb6-3ab2-22e70999c81f@gmx.com>
Subject: Re: [PATCH] btrfs-progs: check: initialize qgroup_item_count in
 earlier stage
References: <20190723091911.19598-1-naohiro.aota@wdc.com>
In-Reply-To: <20190723091911.19598-1-naohiro.aota@wdc.com>

--Sg52xXHSrtsYdKs6XO5Zcf3Kkzc1yLOH0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/23 =E4=B8=8B=E5=8D=885:19, Naohiro Aota wrote:
> "btrfsck -Q" segfaults because it does not call qgroup_set_item_count_p=
tr()
> properly:
>=20
>   # btrfsck -Q /dev/sdk
>   Opening filesystem to check...
>   Checking filesystem on /dev/sdk
>   UUID: 34a35bbc-43f8-40f0-8043-65ed33f2e6c3
>   Print quota groups for /dev/sdk
>   UUID: 34a35bbc-43f8-40f0-8043-65ed33f2e6c3
>   Segmentation fault (core dumped)
>=20
> Since "struct task_ctx ctx" is global, we can just move
> qgroup_set_item_count_ptr() much earlier stage in the check process to
> avoid to forget initializing it.
>=20
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  check/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/check/main.c b/check/main.c
> index bb57933b83fc..7248a8209532 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9965,6 +9965,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
> =20
>  	radix_tree_init();
>  	cache_tree_init(&root_cache);
> +	qgroup_set_item_count_ptr(&ctx.item_count);
> =20
>  	ret =3D check_mounted(argv[optind]);
>  	if (!force) {
> @@ -10291,7 +10292,6 @@ static int cmd_check(const struct cmd_struct *c=
md, int argc, char **argv)
>  	}
> =20
>  	if (info->quota_enabled) {
> -		qgroup_set_item_count_ptr(&ctx.item_count);
>  		if (!ctx.progress_enabled) {
>  			fprintf(stderr, "[7/7] checking quota groups\n");
>  		} else {
>=20


--Sg52xXHSrtsYdKs6XO5Zcf3Kkzc1yLOH0--

--MJ5DLCJEGPXs9cJJclTu8hprfpCEP83md
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl020vAACgkQwj2R86El
/qgWBAgAoHpaJ7Bi+Ss3bKvzG5YrstvDd1pkDFGDbvgJ1zGbDP9g/RZ5Obig1otz
g5Qbwym/qSsO/y6qttVwOaRPFM4ZukkXPKJqqCjS7Gglz1VMVTjdUGf16ZZ1q8Ht
CN7teCdYT0slD+4QBoWoHHfEy0VwKm107pGFMD9HTosoFS4q8se/2qlctfDN0e/P
QMjHX5sKIHEb6W+oc3jsFI+rVUOhecsQGqfJ5dtkYJrErbfXwtmZjvem8/19JdLu
7r+RJeainR1QrsMnp0TQNzuF7Uu/DIBFQq8A+tDnw3YtxlKO/K1xwUGJzUQa0E+h
lkWQVAj0DEBY03AJRk6baGddOod4LA==
=T+52
-----END PGP SIGNATURE-----

--MJ5DLCJEGPXs9cJJclTu8hprfpCEP83md--
