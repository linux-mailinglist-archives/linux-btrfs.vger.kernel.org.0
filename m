Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB08C5B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfHNBxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:53:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:51351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHNBxn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565747617;
        bh=PECcPAv3QDi7WUzWf5WQzDxetjtxNEUJ6HejqogemjA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S73rzlm7NooIQuteMgqJcXyS6t7Y2pAP5E8yKEaQCMURx7tZfYAXxg7cwnZwZyZ+p
         Ifwd5JTOwkDfFJFDYTNWWp+GaKrVLYJyddQaPAX24MHqyqQ/VAZjcSGylZlA/f7evh
         HUNL6Z89OrK5CFsJtXKD/PF7BMA9XeI5MlIl+lbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MKprU-1hxiTo4BSi-0007km; Wed, 14
 Aug 2019 03:53:37 +0200
Subject: Re: [PATCH 4/5] btrfs-progs: resize: more sensible error messages for
 bad sizes
To:     Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-4-jeffm@suse.com>
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
Message-ID: <ed2cbb17-8b93-9d29-0405-a485e8d36a7a@gmx.com>
Date:   Wed, 14 Aug 2019 09:53:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814010402.22546-4-jeffm@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EtdYNSXwlSX6vrPoqdKYwGIGU0EVU0asm"
X-Provags-ID: V03:K1:2dmG+bRTdOeYlfBfTJgIm4eEat/Sdz3S2tIrS0pDx4PwsPSuw30
 3XpS5CeE8EvirLP5IVh4kNBfHJQ7yz2xVUU5tBZaKYayT5pFqkeI5O7yC9ntN61V/xXtpbK
 e1VnZgrguh08dxLri6rjxMV2NmopdQ9CCAGo3JNZdxyihH19inbMEUmujLQaBbpNdRUZxDF
 4V9JDrkrr3YCaIOq4UMSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cSbEChZUilo=:OCd0aelIo6knW5VyGh/T8n
 rIfcfcfXYDscC/oFwoUycWMZmhte755Srj8jZcHBkSmpUZrPvAePVPe5tKVvahTSlYBBQMCHZ
 xKhEt3gEszgsn2WZcSrp6fS3Gqck0yAt5JkAzNINGuUtJHyBQTfjnrRA/F3t/2qVKbfUS5GmN
 Hr//XIz27rT9MKdlh1VGVGHzROPFaZM9Fa0uCrpbhJOaekl48Mxt2IoM6PVlgISJzhAki00DI
 dPmWCyLXJjShS+UdydL0fzlLAgQtcypzIaIT8lluXO/Yykfh9bsqwxyBDEIsQxRVXxjD/N6fO
 pIyS284GVIj23BNOuGBOOUqI5oM+JdLzIypzFuQxjRbS9IJcTn2I0lf8MwS0wGnYw0fDgECbW
 1tzU0S+v4Z0DJEil0N0qMFzFZSHFFn6nqaeaSXu8LOb3Mq/k3k01SNy4CE+QcVd30382e+Ql8
 FoSYAylLyDdC87dcDbmHcC7mdByDGYsRWYerRc8Frb+7kw2c4M46topzSLGoJwCDR6mfeMb+U
 xLwMO1pNyaIvRVv6dkDfBfv3BsrnKP8f/LAxA9EfJfh4n4UWVSl/R1xaC+EmjJh5AD1BD3O77
 7IHU/lydCOUGjQgtKPBiCp8dZqN2nZIvfgXDgCqcCFAlNZCeHipAYEzaucnosk3GbThlI0OOQ
 4Iur9d2Arn0sVZDEB6GnrotOBkwhqr5p+233XtwnjnqtnfceiXnI67thKYDY9WPF2l6XxwyLa
 I+Xo0FY3S9rHst4iAOpir8OXXYBUHvDGeYnLcT0J0RHnxJyoHNrW1Lwol4GgU8kzFQ4EHTuwR
 FqSZdiDlmMRqK28PhOMX+VXSmLppeUgYSVZnl7MDXJD2fXeMWBT2/Fh63Ij8x0y5bIXiTNpEQ
 7TwYlpistA8SlgLWUqgxj9RePLz1hbuDfVulFA577yLD6/0clZk3H9nnvgl8YX5S/Y6LY4m/p
 zYi5cn9XeGFTTY/GBH/Y/k9QygOc2eGEDXnDWjhpLPG2Q4XJi5MsNWAqrgvXRH41ThMn7bgwP
 m7/Y0LDXEYgaD0jkUyKvchAbKFvOgeAAXq6pVj9Yl8J6iNdz6kDMox36/mtMgZlfETHIcnzrg
 RT6+uoptgrcjiAEYlQplJw6oD5mQmNmiA5G/SsnWP/z1UJg7TuIMk+O1GV2dgesee2rWwEBVl
 94acWjFZxQ/kHpkxJDA81jwHnVvYq5Qb3/R4YkQTb6NG2vig==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EtdYNSXwlSX6vrPoqdKYwGIGU0EVU0asm
Content-Type: multipart/mixed; boundary="sL6GyjhC2PTGIT3oxu77KrrZHnLVNYnOe";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <ed2cbb17-8b93-9d29-0405-a485e8d36a7a@gmx.com>
Subject: Re: [PATCH 4/5] btrfs-progs: resize: more sensible error messages for
 bad sizes
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-4-jeffm@suse.com>
In-Reply-To: <20190814010402.22546-4-jeffm@suse.com>

--sL6GyjhC2PTGIT3oxu77KrrZHnLVNYnOe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/14 =E4=B8=8A=E5=8D=889:04, Jeff Mahoney wrote:
> If a user attempts to resize a file system to a size under 256MiB,
> it will be rejected with EINVAL and get then unhelpful error message
> "ERROR: unable to resize '/path': Invalid argument."
>=20
> This commit performs that check before issuing the ioctl to report
> a more sensible error message.   We also do overflow/underflow
> checking when -/+ size is used and report those errors as well.
>=20
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  cmds/filesystem.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  common/utils.c    |  2 +-
>  common/utils.h    |  2 +-
>  3 files changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 4f22089a..e3415126 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -34,10 +34,12 @@
>  #include "kerncompat.h"
>  #include "ctree.h"
>  #include "common/utils.h"
> +#include "common/device-utils.h"
>  #include "volumes.h"
>  #include "cmds/commands.h"
>  #include "cmds/filesystem-usage.h"
>  #include "kernel-lib/list_sort.h"
> +#include "kernel-lib/overflow.h"
>  #include "disk-io.h"
>  #include "common/help.h"
>  #include "common/fsfeatures.h"
> @@ -1062,6 +1064,41 @@ next:
>  }
>  static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "defragment");
> =20
> +static int check_resize_size(const char *path, const char *amount)
> +{
> +	int mod =3D 0;
> +	u64 oldsize =3D 0, size, newsize;
> +
> +	if (*amount =3D=3D '-')
> +		mod =3D -1;
> +	else if (*amount =3D=3D '+')
> +		mod =3D 1;
> +
> +	if (mod) {
> +		amount++;
> +		oldsize =3D disk_size(path);
> +		if (oldsize =3D=3D 0)
> +			return -1;
> +	}
> +
> +	size =3D parse_size(amount);
> +
> +	if (mod =3D=3D -1 && check_sub_overflow(oldsize, size, &newsize)) {
> +		error("can't resize to negative size");
> +		return -1;
> +	} else if (mod =3D=3D 1 && check_add_overflow(oldsize, size, &newsize=
)) {
> +		error("can't resize to larger than 16EiB");
> +		return -1;
> +	} else
> +		newsize =3D size;
> +
> +	if (newsize < SZ_256M) {
> +		error("can't resize to size smaller than 256MiB");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static const char * const cmd_filesystem_resize_usage[] =3D {
>  	"btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:=
]max <path>",
>  	"Resize a filesystem",
> @@ -1110,6 +1147,10 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
>  	if (fd < 0)
>  		return 1;
> =20
> +	res =3D check_resize_size(path, amount);
> +	if (res < 0)
> +		return 1;
> +
>  	printf("Resize '%s' of '%s'\n", path, amount);
>  	memset(&args, 0, sizeof(args));
>  	strncpy_null(args.name, amount);
> diff --git a/common/utils.c b/common/utils.c
> index ad938409..f2a10ccc 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -638,7 +638,7 @@ static int fls64(u64 x)
>  	return 64 - i;
>  }
> =20
> -u64 parse_size(char *s)
> +u64 parse_size(const char *s)

Although a good change, not sure if David will ask for an explict patch
for that.

Despite that, looks good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>  {
>  	char c;
>  	char *endptr;
> diff --git a/common/utils.h b/common/utils.h
> index 7867fb0a..0ef1d6e8 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -65,7 +65,7 @@ int pretty_size_snprintf(u64 size, char *str, size_t =
str_bytes, unsigned unit_mo
>  #define pretty_size(size) 	pretty_size_mode(size, UNITS_DEFAULT)
>  const char *pretty_size_mode(u64 size, unsigned mode);
> =20
> -u64 parse_size(char *s);
> +u64 parse_size(const char *s);
>  u64 parse_qgroupid(const char *p);
>  u64 arg_strtou64(const char *str);
>  int open_file_or_dir(const char *fname, DIR **dirstream);
>=20


--sL6GyjhC2PTGIT3oxu77KrrZHnLVNYnOe--

--EtdYNSXwlSX6vrPoqdKYwGIGU0EVU0asm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1TaZ0ACgkQwj2R86El
/qhULwgAg/R94d/bC/IofVR3U5J8qiwVc4KftV+n+xKME2/60VftfAbEgKmHK6hq
0GOdDPQr9RBCukj4Z9QE8+R9AhgtCZN65SF8GPvQBdiDnSOMzQeFGvuUOwmY4bbi
0DxXLNgHnlecLjtax4LA2rXBGOjQR7GyQlzt837usRgGYQYSP5EvHnA1NUY5HJlg
YQrSfCEBlFttdDhv3HUdE1Z4c2YV0WCE2USaj7/BnqYaW7KVfqA2XISavQHXCz1D
ShuGvXtSF40j8aN5XXEsRAxd1s3CoK2CE6HuMq6z0q7ayorIQhzSPK5WynLXfdw5
wHPMi2O6fA/wCyhicJDCB/3VQibAfQ==
=Cgl/
-----END PGP SIGNATURE-----

--EtdYNSXwlSX6vrPoqdKYwGIGU0EVU0asm--
