Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB574DA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 14:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404417AbfGYMC1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 08:02:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:43897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404362AbfGYMC0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 08:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564056138;
        bh=pzTDNSzlVo4Q4Yi7FQQ/WQwukBNUTvNPn/q2nBr1BOc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JC3urCBDzEKQ+p8xB1Ipgn+cg7cCHapSCQgNHI4y7EerJhfhaTnuKQUrX/V/JV0tV
         kK73VMvn2gvuZZYZwQ2C7V8/vQHIxrRk6nFPQVzXpDMi4lQpvf7TWQ3BHfg3scfgde
         yHRfVObPe1ASwjLVgweoDMQDF2J5F2aB9u/pk7oc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MRoRF-1hx2US3Sjh-00T030; Thu, 25
 Jul 2019 14:02:18 +0200
Subject: Re: [RFC PATCH 3/4] btrfs: use xxhash64 for checksumming
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <4ac3332af1fa5ba7ecb92181329151382b800f3d.1564046812.git.jthumshirn@suse.de>
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
Message-ID: <c2f5e995-6edf-991a-51a6-2c7ba43df41b@gmx.com>
Date:   Thu, 25 Jul 2019 20:02:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4ac3332af1fa5ba7ecb92181329151382b800f3d.1564046812.git.jthumshirn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LcIunSoXYpXkbTtPucwFolri722sl5etT"
X-Provags-ID: V03:K1:gjbSOewiVclyac1DUXrKtiwJO8F6WPiQg1bi8ZWFa9xGMhrLzW2
 S82fftIvhzzlW7dHicLCzjSbH1iDPP+UmflM9rnKrr34+hag/1S/L3pu/nw6ENxFhcp7DgN
 jMlEWVdwinmy5A6J8SDR8dSvD4EHxjqM28FL42O1ZgyLZkUYlw8gz5sTULyX7zvGgDTWikH
 UhM7CQyftsK2GuphnNKFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sRv8UA/uiU8=:KS2jxZd8iHcYRXtUcl7oKc
 GeFpkUPoq/cX+D62XG6f0l0R5r+M0tBZmCo3H+lk+IdlIRP/xzUak8QNZTbF0zLxzjQqNK+wc
 ZspH0AY0f9xw52ZLuR+yLzjlHnHuin0bkJIWb8C8txdVrKgPjyUP6Fc6jgoppJ80M+bxTZlvu
 G/wJdAQk6u71iHP4mCaOQ9+dzc2StWUSXxQ1aibJlmJ8dsxiSiLaHJinHKcpLb8nS9/wgEnuT
 QzBZaCcCB6UdDnrKka0gmoamgJLZdStWSdBX7w9KJaw0/ghd0qDHudJycWQDvQyUjoIG/rUQv
 KfKPjSnTPb483kbznlBuiOeIaINFkasSHmUfMM3g8zuihY43rflCP4GjfXP/pe6sD+gcwXq4E
 8KJ/QN/2sEq6fzgyp17h/o6rm3sYEv36po1XiXxKUfc+vY+eZ9y3D7i62WJSR9y63n3PFrKy7
 NjBIOW7QmKIUHt7nKtOnA65rj/gZQBnpPKsM+VpEpsl3LrpXcRVZW/cb402FugnU9XiOSV6SB
 8chN5uAQLTbmI0Iu45xeYflWmaKLy40HAyWt+OhRhRUbM5okTpO23k3REsw8hzvecBNOucLNZ
 RHSGXUMOMibtYLtOMLoQt7hS309V0Yixbe/WzC9bKZRw4IUob2JHAEiO0m6YPuoYu4ZMbk9s9
 QQwM2qiNg7BD9UFsgTH4zwUzmPlkuYpe7O55/bM8juUPo3soldRX87txPflqzXdd/kilU+rLF
 U6D+QKFYl4hLMsUeBmXzu7Oq4s66WK4QBzbNvIMRgqHtxLAXS/aaL8A4+glTvBnsBi3H2oT7w
 e/Yjx4AHysSWHv4eZ7hGeN5i7X2XpS8LV5tbuXhqxr86sJvAP5TBTZP8SARymLLvA01Lk9dQz
 eLRDh3Rf9NGS0nsslFyf5kcX6mjgtApG/YNNqUrl9wnpPrjh5tfnHgIIAjPUfwzcZmPuWp6M6
 JYlmVSkuvmz5wqLeg0wC5X0eXl126jzyQr/rjHYbyd1fdGQFrtPcTE3fwxN01SkaWfnkHzLL1
 EfptmLDwNxc8JpuZkHkro2dzC0fSoRPxIDed/DU2WVDh7kT+3ldSWIZmzvQkyIkt8g4ZJdZIr
 jmyId8h04ezgMI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LcIunSoXYpXkbTtPucwFolri722sl5etT
Content-Type: multipart/mixed; boundary="s410T96vFKXg7FaF08DDQ0lsPplzw6ZWn";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>
Cc: Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Message-ID: <c2f5e995-6edf-991a-51a6-2c7ba43df41b@gmx.com>
Subject: Re: [RFC PATCH 3/4] btrfs: use xxhash64 for checksumming
References: <cover.1564046812.git.jthumshirn@suse.de>
 <4ac3332af1fa5ba7ecb92181329151382b800f3d.1564046812.git.jthumshirn@suse.de>
In-Reply-To: <4ac3332af1fa5ba7ecb92181329151382b800f3d.1564046812.git.jthumshirn@suse.de>

--s410T96vFKXg7FaF08DDQ0lsPplzw6ZWn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/25 =E4=B8=8B=E5=8D=885:33, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/Kconfig                | 1 +
>  fs/btrfs/ctree.h                | 1 +
>  fs/btrfs/disk-io.c              | 1 +
>  fs/btrfs/super.c                | 1 +
>  include/uapi/linux/btrfs_tree.h | 1 +
>  5 files changed, 5 insertions(+)
>=20
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 38651fae7f21..6d5a01c57da3 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -5,6 +5,7 @@ config BTRFS_FS
>  	select CRYPTO
>  	select CRYPTO_CRC32C
>  	select LIBCRC32C
> +	select CRYPTO_XXHASH

Just an off topic idea, can we make such CRYPTO_* support configurable?
E.g. make something like CONFIG_BTRFS_CRYPTO_XXHASH.

Not sure if everyone would like to pull all hash algorithm.

Thanks,
Qu
>  	select ZLIB_INFLATE
>  	select ZLIB_DEFLATE
>  	select LZO_COMPRESS
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 099401f5dd47..b34f22e55304 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -90,6 +90,7 @@ static const struct btrfs_csums {
>  	const char	*name;
>  } btrfs_csums[] =3D {
>  	BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_CRC32, 4, "crc32c"),
> +	BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_XXHASH, 8, "xxhash64"),
>  };
> =20
>  #define BTRFS_EMPTY_DIR_SIZE 0
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5f7ee70b3d1a..54a8ef489850 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -351,6 +351,7 @@ static bool btrfs_supported_super_csum(u16 csum_typ=
e)
>  {
>  	switch (csum_type) {
>  	case BTRFS_CSUM_TYPE_CRC32:
> +	case BTRFS_CSUM_TYPE_XXHASH:
>  		return true;
>  	default:
>  		return false;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 78de9d5d80c6..7312f675d702 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2464,3 +2464,4 @@ module_exit(exit_btrfs_fs)
> =20
>  MODULE_LICENSE("GPL");
>  MODULE_SOFTDEP("pre: crc32c");
> +MODULE_SOFTDEP("pre: xxhash64");
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs=
_tree.h
> index babef98181a2..af4f5dec10b7 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -302,6 +302,7 @@
>  /* csum types */
>  enum btrfs_csum_type {
>  	BTRFS_CSUM_TYPE_CRC32	=3D 0,
> +	BTRFS_CSUM_TYPE_XXHASH	=3D 1,
>  };
> =20
>  /*
>=20


--s410T96vFKXg7FaF08DDQ0lsPplzw6ZWn--

--LcIunSoXYpXkbTtPucwFolri722sl5etT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl05mkQACgkQwj2R86El
/qgFEQf/bZQCBlZ5VcbeRPNeUcJ/vcxExKw1fQRYAiL7dYwGscMhVqp37aTuLNm5
A0eEqqRazmL6BfqEjuXMP5krFPu+InFyTLLk4IvVepEKMXXvYTUXqUHHJfPI/lyo
920HJ4ju/a567IE9yumABCWlKSCk59aFTy3uvmXzsuONgZ60F7DiRKQmIPpOk1vF
mXebITNT1RndJz1M5ImJPvNpdhuQEQ4Qre/JvamXndxKyK8DhKPk8OM1mzW6FWYq
ElqsV28ufHNyq/RqHu4L03RYuHujOmq4fLRAw5HgZM1QqgASeE01AtVIS846NIA7
xXEKg+9SWFrF5mA1UGTG7H3nLdjiwQ==
=NM12
-----END PGP SIGNATURE-----

--LcIunSoXYpXkbTtPucwFolri722sl5etT--
