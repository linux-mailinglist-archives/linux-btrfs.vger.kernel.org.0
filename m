Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB98C5A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfHNBuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:50:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:37101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHNBun (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565747433;
        bh=dPPXt++V04+9lEqCGJHTwl+ZUWTEq8cXPHUzJ7d3Nv4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZOWYGqWHBwFnLElx/dkyakHszTqxj9ZZ3X1XJ3PlvrtQQq0bfBCVVjXeXVyYefTjV
         OovsJ3dLEzTe6XjEi5qLk0asbjQJwgTSjtp+uQ5jWMPrVQvcHZDFymYz8zg0iNFCkx
         9ACEsAlAseuRrp7ypRraMgS+tSWcUrNU+QqYo/Ms=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ml6qM-1ij6vc1y7I-00lRCm; Wed, 14
 Aug 2019 03:50:33 +0200
Subject: Re: [PATCH 2/5] btrfs-progs: btrfs_add_to_fsid: check if adding
 device would overflow
To:     Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-2-jeffm@suse.com>
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
Message-ID: <0727646f-e356-2d41-5745-6fd01a2fb331@gmx.com>
Date:   Wed, 14 Aug 2019 09:50:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814010402.22546-2-jeffm@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8FVs4XpuP7vxCcct88lgP8LQVVSx9UHJQ"
X-Provags-ID: V03:K1:L2nEP23STFwuKkAfCdyCdBxSLtb1FCrpovQTEmIIPy1vPEkbbmz
 nf6wcsaw7avpFfZPp9ZujDF2XGIMBxWXlCbzTwybnsDF/zQJLJg/nhRfbokNulOhrYJCNnY
 rSWk59sEahS8yVbzWOzDXZ7XFoRXFeROHihm7y6o8puYUFs6IaWat+nM95cFLM4IL4GrWmi
 mQHDAWkvot3yLO54U198Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zb5emB24ngI=:3IzbhydNcsOCNOAU2oSmnr
 zlRR6Ra2IqcxMwEm51+PdhQKFWvfz5Xw3tH9h6pSnGjayIB+tEMnQrYcvcNhZ/bbgULi2J078
 xaNdpareEHtptzSVmpr/5CyeDhSHgn+itml6H+PAUpqiaO3J+km0GJUxFf4xn3zvJ/G6Ej/8D
 8J5eS6KtD6HqcEtfzcesDsnKQFL1uv0/kaLdLNrfQks+HbsdN7vg4BEZqVZQJeRKVR6p/9DG4
 KFMmBxEkezKPFSQMlxG7unhv1KooV2z6NlY7lejqbo58m0perWOSUGwIklQQuP1Tz/3z3YXBu
 yYqwP7SNJrlVcTflKJFhbG2gF8b/z7JxaY44B8NsGQRBA2tE0b57c7krd4pgo84WN2GIdH0Sh
 KUyDgkJaZsnh0IvfVrrxdx/aFmIDjbPdx49rItdTxOaGg/zT6/VJP7qxa9aW/G7rGsJ7o22RB
 vMqwqMkWL9nY8N70XDSzRUpbVBWnyW+dxGpytlHiguFaumQQDKZxQ9b+Q/SA/OtOPgiguK7n3
 HKiRdx0uLRFFG+LtlLZiqfvbcq3NGj/SoV8ApOLYw7ObO/b7zDq1J8kuUp9KEvM1H1DTY4s3D
 5bzRKADanW7P70Z8cuKYoVUGMcbEq0bHzTyZADSX5LsXa6CiLNvi8fP9rKN8ZJH1JtZExIUl3
 iCxVOSrwRc2Jr3Er/9iyyNgz5CaOLDMdPw0BlMHuH4mNVJLUk0kYA/Uj/MghrD/RgAzDbWRdc
 AC5HHu+XIY5DFl6Qj2IsQCP46k815/TLGYpmb9x8fqxQFMeVwLHExDnUQpACyp3rynJDG9R0f
 hqxqf+6VVdm63f3bUQBut6nVASukMPg/kQwTHFw0t8ko5ucYCJ+o+z743XS3JY3IrBG/Epg3r
 rwXOowCduhpqVEgBOs0pxc1xrco6bIpSwkUTpRyQGE+pNaqMe5ZpIOsZ99J39ZR1lwuXfZeJ5
 ScjxkjVqL/ods4j2eRHTYNM5zyTZesj47tDHwbgtU72o8y7XE37MJTYGVkSeAOBOow5nrQkKF
 Uc4bqHI8ihaBHSEfbI1uKsv8MTLlE/9rFZSvztXRh6xaRX9jqYtaih0H/2f1bLMiEMWa5uRk7
 SCPgUu4oP1Omuzs754j1E6JRAhzjjzOohAkuXfGAhB4CksJQFLSt90Png==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8FVs4XpuP7vxCcct88lgP8LQVVSx9UHJQ
Content-Type: multipart/mixed; boundary="tGVe9GOOhJbWdClodvuhggy6BuU0ojo55";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <0727646f-e356-2d41-5745-6fd01a2fb331@gmx.com>
Subject: Re: [PATCH 2/5] btrfs-progs: btrfs_add_to_fsid: check if adding
 device would overflow
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-2-jeffm@suse.com>
In-Reply-To: <20190814010402.22546-2-jeffm@suse.com>

--tGVe9GOOhJbWdClodvuhggy6BuU0ojo55
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/14 =E4=B8=8A=E5=8D=889:03, Jeff Mahoney wrote:
> It's theoretically possible to add multiple devices with sizes that add=
 up
> to or exceed 16EiB.  A file system will be created successfully but wil=
l
> have a superblock with incorrect values for total_bytes and other field=
s.
>=20
> Kernels up to v5.0 will crash when they encounter this scenario.
>=20
> We need to check for overflow and reject the device if it would overflo=
w.
> I've copied include/linux/overflow.h from the kernel to reuse that code=
=2E

That would be a pretty good base for later overflow check.

>=20
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1099147
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  common/device-scan.c                              |  15 +-
>  kernel-lib/overflow.h                             | 270 ++++++++++++++=
++++++++
>  tests/mkfs-tests/018-multidevice-overflow/test.sh |  22 ++
>  3 files changed, 304 insertions(+), 3 deletions(-)
>  create mode 100644 kernel-lib/overflow.h
>  create mode 100755 tests/mkfs-tests/018-multidevice-overflow/test.sh
>=20
> diff --git a/common/device-scan.c b/common/device-scan.c
> index 2c5ae225..09d90add 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -26,6 +26,7 @@
>  #include <linux/limits.h>
>  #include <blkid/blkid.h>
>  #include <uuid/uuid.h>
> +#include "kernel-lib/overflow.h"
>  #include "common/path-utils.h"
>  #include "common/device-scan.h"
>  #include "common/messages.h"
> @@ -118,7 +119,8 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *tr=
ans,
>  	struct btrfs_device *device;
>  	struct btrfs_dev_item *dev_item;
>  	char *buf =3D NULL;
> -	u64 fs_total_bytes;
> +	u64 old_size =3D btrfs_super_total_bytes(super);
> +	u64 new_size;
>  	u64 num_devs;
>  	int ret;
> =20
> @@ -156,13 +158,20 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *=
trans,
>  		goto out;
>  	}
> =20
> +	if (check_add_overflow(old_size, device_total_bytes, &new_size)) {
> +		error(
> +"adding device of %llu bytes would exceed max file system size.",
> +		      device->total_bytes);
> +		ret =3D -EOVERFLOW;
> +		goto out;
> +	}
> +
>  	INIT_LIST_HEAD(&device->dev_list);
>  	ret =3D btrfs_add_device(trans, fs_info, device);
>  	if (ret)
>  		goto out;
> =20
> -	fs_total_bytes =3D btrfs_super_total_bytes(super) + device_total_byte=
s;
> -	btrfs_set_super_total_bytes(super, fs_total_bytes);
> +	btrfs_set_super_total_bytes(super, new_size);
> =20
>  	num_devs =3D btrfs_super_num_devices(super) + 1;
>  	btrfs_set_super_num_devices(super, num_devs);
> diff --git a/kernel-lib/overflow.h b/kernel-lib/overflow.h
> new file mode 100644
> index 00000000..ab7f5d0e
> --- /dev/null
> +++ b/kernel-lib/overflow.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +#ifndef __LINUX_OVERFLOW_H
> +#define __LINUX_OVERFLOW_H
> +
> +/*
> + * It would seem more obvious to do something like
> + *
> + * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1)=
 : 0)
> + * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1=
)) - 1 : ~(T)0)
> + *
> + * Unfortunately, the middle expressions, strictly speaking, have
> + * undefined behaviour, and at least some versions of gcc warn about
> + * the type_max expression (but not if -fsanitize=3Dundefined is in
> + * effect; in that case, the warning is deferred to runtime...).
> + *
> + * The slightly excessive casting in type_min is to make sure the
> + * macros also produce sensible values for the exotic type _Bool. [The=

> + * overflow checkers only almost work for _Bool, but that's
> + * a-feature-not-a-bug, since people shouldn't be doing arithmetic on
> + * _Bools. Besides, the gcc builtins don't allow _Bool* as third
> + * argument.]
> + *
> + * Idea stolen from
> + * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
> + * credit to Christian Biere.
> + */
> +#define is_signed_type(type)       (((type)(-1)) < (type)1)
> +#define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_sig=
ned_type(type)))
> +#define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)=
))
> +#define type_min(T) ((T)((T)-type_max(T)-(T)1))
> +
> +/*
> + * Avoids triggering -Wtype-limits compilation warning,
> + * while using unsigned data types to check a < 0.
> + */
> +#define is_non_negative(a) ((a) > 0 || (a) =3D=3D 0)
> +#define is_negative(a) (!(is_non_negative(a)))
> +
> +/* Checking for unsigned overflow is relatively easy without causing U=
B. */
> +#define __unsigned_add_overflow(a, b, d) ({	\
> +	typeof(a) __a =3D (a);			\
> +	typeof(b) __b =3D (b);			\
> +	typeof(d) __d =3D (d);			\
> +	(void) (&__a =3D=3D &__b);			\
> +	(void) (&__a =3D=3D __d);			\
> +	*__d =3D __a + __b;			\
> +	*__d < __a;				\
> +})
> +#define __unsigned_sub_overflow(a, b, d) ({	\
> +	typeof(a) __a =3D (a);			\
> +	typeof(b) __b =3D (b);			\
> +	typeof(d) __d =3D (d);			\
> +	(void) (&__a =3D=3D &__b);			\
> +	(void) (&__a =3D=3D __d);			\
> +	*__d =3D __a - __b;			\
> +	__a < __b;				\
> +})
> +/*
> + * If one of a or b is a compile-time constant, this avoids a division=
=2E
> + */
> +#define __unsigned_mul_overflow(a, b, d) ({		\
> +	typeof(a) __a =3D (a);				\
> +	typeof(b) __b =3D (b);				\
> +	typeof(d) __d =3D (d);				\
> +	(void) (&__a =3D=3D &__b);				\
> +	(void) (&__a =3D=3D __d);				\
> +	*__d =3D __a * __b;				\
> +	__builtin_constant_p(__b) ?			\
> +	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
> +	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
> +})
> +
> +/*
> + * For signed types, detecting overflow is much harder, especially if
> + * we want to avoid UB. But the interface of these macros is such that=

> + * we must provide a result in *d, and in fact we must produce the
> + * result promised by gcc's builtins, which is simply the possibly
> + * wrapped-around value. Fortunately, we can just formally do the
> + * operations in the widest relevant unsigned type (u64) and then
> + * truncate the result - gcc is smart enough to generate the same code=

> + * with and without the (u64) casts.
> + */
> +
> +/*
> + * Adding two signed integers can overflow only if they have the same
> + * sign, and overflow has happened iff the result has the opposite
> + * sign.
> + */
> +#define __signed_add_overflow(a, b, d) ({	\
> +	typeof(a) __a =3D (a);			\
> +	typeof(b) __b =3D (b);			\
> +	typeof(d) __d =3D (d);			\
> +	(void) (&__a =3D=3D &__b);			\
> +	(void) (&__a =3D=3D __d);			\
> +	*__d =3D (u64)__a + (u64)__b;		\
> +	(((~(__a ^ __b)) & (*__d ^ __a))	\
> +		& type_min(typeof(__a))) !=3D 0;	\
> +})
> +
> +/*
> + * Subtraction is similar, except that overflow can now happen only
> + * when the signs are opposite. In this case, overflow has happened if=

> + * the result has the opposite sign of a.
> + */
> +#define __signed_sub_overflow(a, b, d) ({	\
> +	typeof(a) __a =3D (a);			\
> +	typeof(b) __b =3D (b);			\
> +	typeof(d) __d =3D (d);			\
> +	(void) (&__a =3D=3D &__b);			\
> +	(void) (&__a =3D=3D __d);			\
> +	*__d =3D (u64)__a - (u64)__b;		\
> +	((((__a ^ __b)) & (*__d ^ __a))		\
> +		& type_min(typeof(__a))) !=3D 0;	\
> +})
> +
> +/*
> + * Signed multiplication is rather hard. gcc always follows C99, so
> + * division is truncated towards 0. This means that we can write the
> + * overflow check like this:
> + *
> + * (a > 0 && (b > MAX/a || b < MIN/a)) ||
> + * (a < -1 && (b > MIN/a || b < MAX/a) ||
> + * (a =3D=3D -1 && b =3D=3D MIN)
> + *
> + * The redundant casts of -1 are to silence an annoying -Wtype-limits
> + * (included in -Wextra) warning: When the type is u8 or u16, the
> + * __b_c_e in check_mul_overflow obviously selects
> + * __unsigned_mul_overflow, but unfortunately gcc still parses this
> + * code and warns about the limited range of __b.
> + */
> +
> +#define __signed_mul_overflow(a, b, d) ({				\
> +	typeof(a) __a =3D (a);						\
> +	typeof(b) __b =3D (b);						\
> +	typeof(d) __d =3D (d);						\
> +	typeof(a) __tmax =3D type_max(typeof(a));				\
> +	typeof(a) __tmin =3D type_min(typeof(a));				\
> +	(void) (&__a =3D=3D &__b);						\
> +	(void) (&__a =3D=3D __d);						\
> +	*__d =3D (u64)__a * (u64)__b;					\
> +	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
> +	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) ||=
 \
> +	(__b =3D=3D (typeof(__b))-1 && __a =3D=3D __tmin);			\
> +})
> +
> +
> +#define check_add_overflow(a, b, d)					\
> +	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> +			__signed_add_overflow(a, b, d),			\
> +			__unsigned_add_overflow(a, b, d))
> +
> +#define check_sub_overflow(a, b, d)					\
> +	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> +			__signed_sub_overflow(a, b, d),			\
> +			__unsigned_sub_overflow(a, b, d))
> +
> +#define check_mul_overflow(a, b, d)					\
> +	__builtin_choose_expr(is_signed_type(typeof(a)),		\
> +			__signed_mul_overflow(a, b, d),			\
> +			__unsigned_mul_overflow(a, b, d))
> +
> +/** check_shl_overflow() - Calculate a left-shifted value and check ov=
erflow
> + *
> + * @a: Value to be shifted
> + * @s: How many bits left to shift
> + * @d: Pointer to where to store the result
> + *
> + * Computes *@d =3D (@a << @s)
> + *
> + * Returns true if '*d' cannot hold the result or when 'a << s' doesn'=
t
> + * make sense. Example conditions:
> + * - 'a << s' causes bits to be lost when stored in *d.
> + * - 's' is garbage (e.g. negative) or so large that the result of
> + *   'a << s' is guaranteed to be 0.
> + * - 'a' is negative.
> + * - 'a << s' sets the sign bit, if any, in '*d'.
> + *
> + * '*d' will hold the results of the attempted shift, but is not
> + * considered "safe for use" if false is returned.
> + */
> +#define check_shl_overflow(a, s, d) ({					\
> +	typeof(a) _a =3D a;						\
> +	typeof(s) _s =3D s;						\
> +	typeof(d) _d =3D d;						\
> +	u64 _a_full =3D _a;						\
> +	unsigned int _to_shift =3D					\
> +		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
> +	*_d =3D (_a_full << _to_shift);					\
> +	(_to_shift !=3D _s || is_negative(*_d) || is_negative(_a) ||	\
> +	(*_d >> _to_shift) !=3D _a);					\
> +})
> +
> +/**
> + * array_size() - Calculate size of 2-dimensional array.
> + *
> + * @a: dimension one
> + * @b: dimension two
> + *
> + * Calculates size of 2-dimensional array: @a * @b.
> + *
> + * Returns: number of bytes needed to represent the array or SIZE_MAX =
on
> + * overflow.
> + */
> +static inline size_t array_size(size_t a, size_t b)
> +{
> +	size_t bytes;
> +
> +	if (check_mul_overflow(a, b, &bytes))
> +		return SIZE_MAX;
> +
> +	return bytes;
> +}
> +
> +/**
> + * array3_size() - Calculate size of 3-dimensional array.
> + *
> + * @a: dimension one
> + * @b: dimension two
> + * @c: dimension three
> + *
> + * Calculates size of 3-dimensional array: @a * @b * @c.
> + *
> + * Returns: number of bytes needed to represent the array or SIZE_MAX =
on
> + * overflow.
> + */
> +static inline size_t array3_size(size_t a, size_t b, size_t c)
> +{
> +	size_t bytes;
> +
> +	if (check_mul_overflow(a, b, &bytes))
> +		return SIZE_MAX;
> +	if (check_mul_overflow(bytes, c, &bytes))
> +		return SIZE_MAX;
> +
> +	return bytes;
> +}
> +
> +/*
> + * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
> + * struct_size() below.
> + */
> +static inline size_t __ab_c_size(size_t a, size_t b, size_t c)
> +{
> +	size_t bytes;
> +
> +	if (check_mul_overflow(a, b, &bytes))
> +		return SIZE_MAX;
> +	if (check_add_overflow(bytes, c, &bytes))
> +		return SIZE_MAX;
> +
> +	return bytes;
> +}
> +
> +/**
> + * struct_size() - Calculate size of structure with trailing array.
> + * @p: Pointer to the structure.
> + * @member: Name of the array member.
> + * @n: Number of elements in the array.
> + *
> + * Calculates size of memory needed for structure @p followed by an
> + * array of @n @member elements.
> + *
> + * Return: number of bytes needed or SIZE_MAX on overflow.
> + */
> +#define struct_size(p, member, n)					\
> +	__ab_c_size(n,							\
> +		    sizeof(*(p)->member) + __must_be_array((p)->member),\
> +		    sizeof(*(p)))
> +
> +#endif /* __LINUX_OVERFLOW_H */
> diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/=
mkfs-tests/018-multidevice-overflow/test.sh
> new file mode 100755
> index 00000000..0b550685
> --- /dev/null
> +++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +# test if mkfs.btrfs will create file systems that overflow total_byte=
s
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +
> +mkdev()
> +{
> +	truncate -s 0 "$1"
> +	truncate -s "$2" "$1"
> +}
> +
> +mkdev "$TEST_TOP/test-dev1.img" 6E
> +mkdev "$TEST_TOP/test-dev2.img" 6E
> +mkdev "$TEST_TOP/test-dev3.img" 6E
> +
> +run_mustfail "mkfs.btrfs for too-large images" \
> +	     "$TOP/mkfs.btrfs" -f "$TEST_TOP"/test-dev[123].img
> +
> +rm -f "$TEST_TOP"/test-dev[123].img
>=20


--tGVe9GOOhJbWdClodvuhggy6BuU0ojo55--

--8FVs4XpuP7vxCcct88lgP8LQVVSx9UHJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1TaOQACgkQwj2R86El
/qi/kwf/Vi6aiLMKRYFVSezXlb2rEpc1rKigeDPw5ICSfd6HuAK7qMqYbl5lfTXO
DyhdewhvgkNvpqhEBdSFMOiLGkeKlI67FXgDIkimzmz7PMMCcVb0tuz+vpg3pUBF
4kIq8goAMkve5SbpQCesganVo7TRB6hQMxeDYat22CQtJvu2HlJVeNDkAasmHbD3
G67kR3tU/EC6Ub2c8Bu/FL3zQLMsatyCOw4bipBEyHymQeTKBqI7jnl0/gJXvVCm
avfO8pCpVXwROBrGE4QZ9+v//aY6YDRC1zxdAlWVs+dLqRrY5hd2qwTerNxWu4YA
s2pIbBBlJg1tpa8wgetn7V+vyuHgXQ==
=qKBu
-----END PGP SIGNATURE-----

--8FVs4XpuP7vxCcct88lgP8LQVVSx9UHJQ--
