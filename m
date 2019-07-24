Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8AE72465
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 04:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfGXCWO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 22:22:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:37881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfGXCWO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 22:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563934923;
        bh=DW5av2JUJK96BxyD8XmI78gUF7ZN0qO/L5SUPrzCOvY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GS1lb8W7MPF5X3lR4Z5q/euzSxWcrZssvPVax6hCSqY6awe2QFvKtGwhMrDawvGcD
         X71C51Id1bKmzCaj+Nfm7iQxK+kGmbV3u4GN+T787BF3WQDbmLqWmKDx0TilBpBn/a
         qu2sGU6XIU+OjO4YvbHed5gIqrh5jV23Hq7PjL9U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MePcd-1i3Y6H36Dv-00QAXM; Wed, 24
 Jul 2019 04:22:03 +0200
Subject: Re: [PATCH] fs: btrfs: Fix a possible null-pointer dereference in
 insert_inline_extent()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190724021132.27378-1-baijiaju1990@gmail.com>
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
Message-ID: <df4b5d21-0983-3ca2-44de-ea9f1616df7f@gmx.com>
Date:   Wed, 24 Jul 2019 10:21:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724021132.27378-1-baijiaju1990@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dY9KwcNL37CoHEDoBsh6luZES4d1glcXs"
X-Provags-ID: V03:K1:yI6sFpNpDQOBeUn6tllHHoj0StdLgydeCVp9UpcrI46jPQsWDls
 HdsFD18TsO7UdcPm9fRHVCE9iMrhbeCRnk0PzIw2t0GXkoAJDnO6Y5h9Vyio0YCObLWN1ky
 IQHJNjy6p+bs/bvm0pkojAILk202ybMrDeJkxhLpt0uyKSuUyNcPakbCKWu3CtpAEf5qZGT
 2bDjy/8daoQU7N3YUfdFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTWqWoI0EnU=:sx4Edu7QylABSB3WChcMa2
 4Awoy2VShIPzqPDhB1i+8KYwpo5lO0QDwa15i+gM0r0iTP3pr5pm/pOsfQBUkSvRSIQw1iY3n
 o8CdxPpGlVssbRmxheWA3s7KyHbrcRL4n0nbV+D7PSA5h6Bmcj1tEzOFKCPcND0vXbRmkiXzt
 wQOYoaLhx/twF0IACPsrtbZX1LlAChIA2P+pviHLHSioXVAAuhbxQBZeOLElVnZIMAcyoKzCX
 7lraqlf6bjApQk4sqkokZB32oyNgj246nbOcGr1EVwg0YCOtNGUVB/ekMlHeItjQQ7UrELccs
 tyXhUhtm5LtXR+Hxna9MVxhV6IhFa0RY3cBxQy0b5BJLSi9G4D8F87RJWq2tKpIiRueAQ+pcb
 v9GB/YAVjR+dXm3dUOWoWkdK9w4Bj9PLmo2VrBEGb23RBKoWHhn/70TlNlzvInxOQlHMfC/VN
 5mfHRwBIgFZebyqOQstkfwDHrqlBaFE2oL7lFLhOkag7dVsoN1xPMLiEWy8afHKfX+71BxmUr
 jyr2wShXJr+RzP0Jgu9RMtR4vufpeakpJd7zPkag0p0vHUxkY/NiCsAyUkOfGmHD0Ba6klb0X
 RLIQhhec0beUssskOHUXm1hv84cz/2Z1Z6c0M3q8b4bGbrd+ufVB3E3p5UGa21innFWGAPoHd
 qBo6VgL0TWfnBUDyETCA4rI+By7bS1L2fJPYBBbUoVe7uhrm18hIcl3r6o74YcVZPb8pUVX5A
 UTMtWp2EIoKUYgT6Ju3I4SEBkpgFw+JRH4lX2hkm15CIn2461RtoSnNiu8hSPw4qW37Tiz5y4
 jXU1t3nVoFbfwAQ4uqvO2u3WYtCTFs/YIPp0GvGs1jBvDV03FQBOGblIQseUXh2KE4NGh08AZ
 mHnhpatowPhXgvtlVkUjZpnzAeywgNs45uWI19xNNMEvKE3LRKsY7sZthKG65QhVShEGtkRtt
 zeTRUzUpg8zcMn+ohXfNV4VdGN084oc7ObqslALDHeBW4o5Q7kPKYCFl+CwRgll+yni0kg+BL
 jOnXZDXry3zX+C3NQheS+yE5NDND+ZIxD5iz69a8b0AuqIERIwdWt/w4qoN5HKLm61ePKu/bn
 q9lHbSuZ4rqmaY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dY9KwcNL37CoHEDoBsh6luZES4d1glcXs
Content-Type: multipart/mixed; boundary="3AtBdcSJYjaVOafCYCLSQoSsAOuiQuyQM";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <df4b5d21-0983-3ca2-44de-ea9f1616df7f@gmx.com>
Subject: Re: [PATCH] fs: btrfs: Fix a possible null-pointer dereference in
 insert_inline_extent()
References: <20190724021132.27378-1-baijiaju1990@gmail.com>
In-Reply-To: <20190724021132.27378-1-baijiaju1990@gmail.com>

--3AtBdcSJYjaVOafCYCLSQoSsAOuiQuyQM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/24 =E4=B8=8A=E5=8D=8810:11, Jia-Ju Bai wrote:
> In insert_inline_extent(), there is an if statement on line 181 to chec=
k
> whether compressed_pages is NULL:
>     if (compressed_size && compressed_pages)
>=20
> When compressed_pages is NULL, compressed_pages is used on line 215:
>     cpage =3D compressed_pages[i];
>=20
> Thus, a possible null-pointer dereference may occur.
>=20
> To fix this possible bug, compressed_pages is checked on line 214.

This can only be hit with compressed_size > 0 and compressed_pages !=3D N=
ULL.

It would be better to have an extra ASSERT() to warn developers about
the impossible case.

Thanks,
Qu

>=20
> This bug is found by a static analysis tool STCheck written by us.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1af069a9a0c7..19182272fbd8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -211,7 +211,7 @@ static int insert_inline_extent(struct btrfs_trans_=
handle *trans,
>  	if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>  		struct page *cpage;
>  		int i =3D 0;
> -		while (compressed_size > 0) {
> +		while (compressed_size > 0 && compressed_pages) {
>  			cpage =3D compressed_pages[i];
>  			cur_size =3D min_t(unsigned long, compressed_size,
>  				       PAGE_SIZE);
>=20


--3AtBdcSJYjaVOafCYCLSQoSsAOuiQuyQM--

--dY9KwcNL37CoHEDoBsh6luZES4d1glcXs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl03wMQACgkQwj2R86El
/qhUaQf9EzBTiBN1PiJUePEdugKdglRzvJVLZlv9dMZKd6ULvA3MWmoPpniK7f14
OQlu6xujP1xJK+qRDiV/kKJsDDzX/x46ZVwEPtioilVctjLVOAB00dALVgBSf+H8
q8OHi/ru6xH6vlOhQL15rfuMOgXcDTizZI39X545XpNGv6keu8NNQsXMDdx1FJPF
0UI20Wy4B5Fd5LnMiOOQ/K0znqPO+Pla57YDc0Rh1m/t5tDQ62n5NUpGnouSmiHK
efubyJqfGq0V57nAE9kGlHx3W9PRO4mG9h9EFEZbMDVt+UQVy7wlTQu8hO9IjW7m
PfSX8seJuZ8STQx0W2qW4MqGHHUqvQ==
=Ry2N
-----END PGP SIGNATURE-----

--dY9KwcNL37CoHEDoBsh6luZES4d1glcXs--
