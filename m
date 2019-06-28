Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10CCE5916E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 04:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfF1Coc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 22:44:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:51113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfF1Coc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 22:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561689863;
        bh=ota723RKsXOakb6AlGFQQS53iPtVBINGSrsr5zTpX8I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=V9f7OSwE1WLcv5U9eVF5g5oRIhOJUw19rmfVVHOEhhZM53qEgEH1zo1SmKrRyAY3x
         L1uav8fcCCpg/l2JsOrTBQGFFHh769QBosmPWysIfwiR/KmF5D8Y4f2jybFt9XchRj
         +yI4voEOTbRsNBml8e6QaQwVou8+kunLMmbVvfCs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxlzC-1iUm5o1Zks-00zCyC; Fri, 28
 Jun 2019 04:44:23 +0200
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
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
Message-ID: <0a250a9a-d710-4c7c-ca24-0e4f635a4a99@gmx.com>
Date:   Fri, 28 Jun 2019 10:44:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628022611.2844-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9IfbGTTPYJuAAHUTHKlH6HBB8xoXzw6CW"
X-Provags-ID: V03:K1:YUM2OwGGtsE8/XN1xoQUWq6u9LTCoOeG+335LlMDoOI7wY9OMr4
 0bvseoIttuuNkBBWpkCw4ycyb/+V3sGl/UrGg8vLrai72AdEFa+fYHW+dt3O1Kc1K6TVaTi
 1G6ndxSDyVismBZOR31wXSmt/hq6MY/Bmkn7wQHmXACZcirYjygezTZZaapAZDkJWD7MYRY
 xYaWDUAkPf0G/s1vdaJxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7IHe/lWneqE=:v5pEsOi2RZ5QY9JzVT7QgH
 B9upqxEcGU4Wx0wu9WkQYOmSj0cPdqKYF/ba4MiUm3JSoO3JUE0EGIvWe+i0I9GOo2upnMIwZ
 wzcluQIit1a8cLGnsbjdk6sfSBrZdlA8vsqiqpa/oWgrzwgLLXpz6agvweAGvOIaUKD3tYHV8
 8aCiYHMkl4hy5u7XNqO99iUEgYsrDUKMLAyRZ5JLnaOHN2ZYSjkfw+04JqkKnS62LHFcH1qXd
 ZXjcVhO1TB80vTzS9LcWyfJPbEabWpxO786rFcP+fxppZnzSk2qNJod5WdVG+9h2khXluwg9j
 FqcYAprk/WO+tMQBnf+Gw8DsKDAnsnI0sFrPi0EsWjyAujJWKzF1UUXROqckiBSef+byHIdyK
 3EI7QXkES5S1VxD9fPxUFgb58h3YjFPZJRjdf2y18LcoXJjegks0LUgkAP5s9mdkTfY9tTgmW
 g+VcwFw4pblVlahFLlVsbbi2DXxCje0BJErf7epPTkzdjZlAi0/pt7DeqpyoXzHfwgLksnOfp
 NTBpEMmeArT2+xzeacwL8snPxJQq57IMlaRDXFRDKpm9Vp7s0wjKoIyX+GKIh335ts9wBzBH0
 naePXpMXi13y18z1VqmrwEbQNNvRkFHV9rEsUd9ZbbZF9ID+DFCYRrfEro5HvHH51OF2F1hxl
 7ym21fmdlNQbw8RgTDw8nKW7n03igQwv8DH9BOcNRX5nXL0UhiHjoU3ra3YJuB10ENwqG1len
 bF7ocsVp7AWvSn+w0XqKfO883Db9fV0XUMqf8/osk+kp/dfbfN+q5wx+jXykZxd2NqF15NmgS
 NB48bKACJdyzZYDTvCbKk8ajq7H/j0bqi5+nKgrUn9tIIJH2hR4cjOh6VzmnnTkYopsejPis3
 LcZj+xbzJwXHC1bBeO6GD8OQKkuI7767/x07I+/gkYkuSUovMlaavxamF6cJtSxjyldNayQM9
 AYqBzjZ5Vocoh9mErIj9zCXe4rEjQYEoGce7wG5J7leN4MLiC2qHFKY5JRxJtce1Bkeg8WdVJ
 6uit+2meL+N8VFQF5LUwPZ8hNT7XcDIlkqk0OJJyKtatQ+nxKMunqD9REMOweCuxHcbj0hMg+
 Zw1PJq3OkJio/0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9IfbGTTPYJuAAHUTHKlH6HBB8xoXzw6CW
Content-Type: multipart/mixed; boundary="AaplLVez6ZzClcXbxwHCkqvBQYOLH8UPH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Message-ID: <0a250a9a-d710-4c7c-ca24-0e4f635a4a99@gmx.com>
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
References: <20190628022611.2844-1-anand.jain@oracle.com>
In-Reply-To: <20190628022611.2844-1-anand.jain@oracle.com>

--AaplLVez6ZzClcXbxwHCkqvBQYOLH8UPH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/28 =E4=B8=8A=E5=8D=8810:26, Anand Jain wrote:
> At the time mkfs.btrfs the device id and stripe index gets reversed as
> shown in [1]. This patch helps to keep them in order at the time of
> mkfs.btrfs. And makes it easier to debug.
>=20
> Before:
> Stripe 0 is on devid 2; Stipe 1 is on devid 1;
>=20
> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tre=
e -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" =
| grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsi=
ze 112
> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 2 offset 1048576
> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
> 			stripe 1 devid 1 offset 22020096
> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsi=
ze 112
> 		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 2 offset 9437184
> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
> 			stripe 1 devid 1 offset 30408704
> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
> 	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 items=
ize 112
> 		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 2 offset 277872640
> 			dev_uuid d9fe51c4-6e79-446d-87ee-5be3184798cd
> 			stripe 1 devid 1 offset 298844160
> 			dev_uuid 16f626ca-1a54-469b-ac7e-25623af884ab
>=20
> After:
> Stripe 0 is on devid 1; Stripe 1 is on devid 2
>=20
> ./mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc && btrfs in dump-tre=
e -d /dev/sdb | grep -A 10000 "chunk tree" | grep -B 10000 "device tree" =
| grep -A 13  "FIRST_CHUNK_TREE CHUNK_ITEM"
> /dev/sdb: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52=
 66 53 5f 4d
> /dev/sdc: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52=
 66 53 5f 4d
> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15975 itemsi=
ze 112
> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 1 offset 22020096
> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
> 			stripe 1 devid 2 offset 1048576
> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsi=
ze 112
> 		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 1 offset 30408704
> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
> 			stripe 1 devid 2 offset 9437184
> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
> 	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 items=
ize 112
> 		length 314572800 owner 2 stripe_len 65536 type DATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 1 offset 298844160
> 			dev_uuid 6abc88fa-f42e-4f0c-9bc3-2225735e51d1
> 			stripe 1 devid 2 offset 277872640
> 			dev_uuid 73746d27-13a6-4d58-ac6b-48c90c31d94d
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But please also check the comment inlined below.
> ---
>  volumes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/volumes.c b/volumes.c
> index 79d1d6a07fb7..8c8b17e814b8 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1109,7 +1109,7 @@ again:
>  			return ret;
>  		cur =3D cur->next;
>  		if (avail >=3D min_free) {
> -			list_move_tail(&device->dev_list, &private_devs);
> +			list_move(&device->dev_list, &private_devs);

This is OK since current btrfs-progs chunk allocator doesn't follow the
kernel behavior by sorting devices with its unallocated space.
So it's completely devid based.

But please keep in mind that, if we're going to unify the chunk
allocator behavior of kernel and btrfs-progs, the behavior will change.

As the initial temporary chunk is always allocated on devid 1, reducing
its unallocated space thus reducing its priority in chunk allocator, and
making the devid sequence more unreliable.

Thanks,
Qu

>  			index++;
>  			if (type & BTRFS_BLOCK_GROUP_DUP)
>  				index++;
> @@ -1166,7 +1166,7 @@ again:
>  		/* loop over this device again if we're doing a dup group */
>  		if (!(type & BTRFS_BLOCK_GROUP_DUP) ||
>  		    (index =3D=3D num_stripes - 1))
> -			list_move_tail(&device->dev_list, dev_list);
> +			list_move(&device->dev_list, dev_list);
> =20
>  		ret =3D btrfs_alloc_dev_extent(trans, device, key.offset,
>  			     calc_size, &dev_offset);
>=20


--AaplLVez6ZzClcXbxwHCkqvBQYOLH8UPH--

--9IfbGTTPYJuAAHUTHKlH6HBB8xoXzw6CW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0VfwIACgkQwj2R86El
/qjpNgf/V/yM1gsh0vBcPilIUmOJ168qeDeMOfZPoFqk52FI1K7cHbD7u1ZNbPWx
03FBdW7e+qK7mDDsJbhPH50HeZz00dPqbi66h7Wd6nFDSapUTHVtDrkdGEVN6xZh
mUQEym2jXB+x6qjCQTLmpOGMQhIrDkZWniAKgIqXzvKEYHKqKRLaGpraOh2RqTNE
TLGwMTAAkxgQ38Ki+r+JrWc6MVY9L0IXdwpfKu+n/DLnrQqvtgwd/FTtIUHo5yXy
jQjr4orroTO5A55IVPqhQUrof+ShjR78/jWsHa30/DyzIHSIi+w5Nf+7Nd+dUPNv
qyLGpwLDFItyJzx2ENTG4b5Iy+v41w==
=zDLC
-----END PGP SIGNATURE-----

--9IfbGTTPYJuAAHUTHKlH6HBB8xoXzw6CW--
