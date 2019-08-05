Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5500181EC8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfHEOOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 10:14:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:49357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbfHEOOb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 10:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565014465;
        bh=LP3gV3XzMjmumw54Z+gJbcOfU1mtwQn6Rdt1VDzpR+I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PHN9Z8Nr+n8TOfqG5EvCmTSR2Da/NFVfJGIrnNtYrg0+x2d4u/RayNJ3PBCsphoIR
         ddj4QovlEWFQ1cxwB8YsG6STDTe+fRphueKdY1lJ3Ektt4HG4Td0m01myozKbrKXco
         cD5eoYj7e2OIqjYBpEy/HRRnkh3Y0GVZTQR//1bQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LrqNe-1iKepq0Byw-013g80; Mon, 05
 Aug 2019 16:14:25 +0200
Subject: Re: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190805131942.8669-1-josef@toxicpanda.com>
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
Message-ID: <da46587e-2471-8971-7c26-6c67720af32d@gmx.com>
Date:   Mon, 5 Aug 2019 22:14:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805131942.8669-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B4vzwPKLMqAI6H0NJyrjQZNtwtz2Lnwzf"
X-Provags-ID: V03:K1:B9hHhnLQqEoxhxtUVuhkrhoqzqB7/hdEw4eVL6fEE8f3UQ6OW+x
 KkgQWMuRjbu47jCbPi5GL6YeX+e1WtGdYF6Yu5C7jMztxVVjP9fowY6yXv61qZK4vIRnqdC
 p3i8hKjVSFgFcYd4sgvHzUXG+m/ya7i+/EFj8tF7R95tq8/bhckp+RQ7bMPR62iGy82mwrd
 WuWA7HQWjoReRFUVrX5nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zLe1PZhip7g=:r0En+vme9GL13dq4A/5RTW
 gfbA8bddoEPlHPtQW2olSfXGecx/1/uQ5YVgyxSMUYvij734QdDmIgv+uGGD2xiYCs+o/zklp
 ljUlialZoN+Mq/lzg52PzKDNFWAiMwpdFD4zFb9i6wi/Stz9VneTeL651TXGZzI2UeIm7yCgt
 3YzVVmr8k0QLcneB7PLvHBpanWf8Iqbak4zkhJtipVj5/BotIv/kzIbwjl3B5ematIiMP6d38
 eJ/spx1GYfVSexq7CkgpCHw9A8ZYlEqc5EXUOQNtU7ujF/KAwF9LCckvSJjWjnixFPZO7lhTU
 KLoEGazkff3FiVA6i4L05l9sxBrTK2fz1Pobwc3vBHAx/+MMi9miwX2IxccjF7ziiKRwnAqub
 K6tpd36qqw+mpGIuSSczLW6N5btWGtu65N39D/Vm/gjIxjltfIGnvaHEmAgzdQY8P6/NRQKCD
 KWCbYBPRlmnpMfQSDNMThITSdGAL/4zBQ0mtNGpo3n1ZntUdkuujv51eyvmLUCCXpiNni243W
 +nfOPM5tFYHx/tbwkgo/TY3qARdaiZrwPRDC/N0+Tf+VqIDBXXMj2bJ2mp4DK1cWNXoothPz8
 tSLkFhUFOfD59BmO41PyLzhiJtKNo/qCsxSwgRJNQU/gxH3EE7XMa/wAB1SneGCUcFA736+Zo
 clUk+/y/PFwHt/mYmEYGiOvHJp4fYJyZD3SCh0b37F7FTvU+WRnVS11QIsoekr25JxQ2//GPQ
 j41G2mGm0I/aLf9jsqgzBO9/5qfSS7fA8FPh/evF/AtlexkMk0Qjo2hqvMKkfTc379XTTwzrn
 IdaFJ9hmOpIOUeq3fLK+JA8Flns/839vj8jAHNDshw59VFUd33B4pEGgFfTg2x+q3f4P2vFRX
 k3WHJuN7BFOM8En4+KlYRwHiYnygD4oW9HFKLOBpSD1sQk8mKIGeZ/nKWhIXzap1u42K5NGQQ
 RxpXhlujQdoDkFmUZ4jZgHlmiL0gcFApzt+6SeVEJa8LXz9U9pYtfDXiqI+ICeUvaNz2DtC8U
 kGrvT+5hztRbOhDUwLAZtYYnH/SPTRKiFuwaY72aRAKZcvqHE8PfXgccGAySnzAV7ZfrPw4mX
 OHdG89afH03Op9hCVMgx9Gqm8qIjdspH6mv+eMLSZGGwAtox2J99Zft6w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B4vzwPKLMqAI6H0NJyrjQZNtwtz2Lnwzf
Content-Type: multipart/mixed; boundary="AnSqKnmdBFzO7vtzhFFM9EvUVHfjO73Hw";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Message-ID: <da46587e-2471-8971-7c26-6c67720af32d@gmx.com>
Subject: Re: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
References: <20190805131942.8669-1-josef@toxicpanda.com>
In-Reply-To: <20190805131942.8669-1-josef@toxicpanda.com>

--AnSqKnmdBFzO7vtzhFFM9EvUVHfjO73Hw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/5 =E4=B8=8B=E5=8D=889:19, Josef Bacik wrote:
> In testing block group removal it's sometimes handy to be able to creat=
e
> block groups on demand.  Add an ioctl to allow us to force allocation
> from userspace.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - I noticed last week when backporting this that btrfs_chunk_alloc does=
n't
>   figure out the rest of the flags needed for the type.  Use
>   btrfs_force_chunk_alloc instead so that we get the raid settings for =
the alloc
>   type we're using.

Still not sure if it's worthy to add a debug only ioctl.

If sysfs is not good enough, maybe modify btrfs_force_chunk_alloc() to
do extra chunk allocation depending on a internal return value
overridable function?

At least for the later case, we can trigger empty chunk allocation with
BPF while without messing any interface.

Thanks,
Qu
>=20
>  fs/btrfs/ioctl.c           | 30 ++++++++++++++++++++++++++++++
>  include/uapi/linux/btrfs.h |  1 +
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d0743ec1231d..891bf198d46a 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -5553,6 +5553,34 @@ static int _btrfs_ioctl_send(struct file *file, =
void __user *argp, bool compat)
>  	return ret;
>  }
> =20
> +static long btrfs_ioctl_alloc_chunk(struct file *file, void __user *ar=
g)
> +{
> +	struct btrfs_root *root =3D BTRFS_I(file_inode(file))->root;
> +	struct btrfs_trans_handle *trans;
> +	u64 flags;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(&flags, arg, sizeof(flags)))
> +		return -EFAULT;
> +
> +	/* We can only specify one type at a time. */
> +	if (flags !=3D BTRFS_BLOCK_GROUP_DATA &&
> +	    flags !=3D BTRFS_BLOCK_GROUP_METADATA &&
> +	    flags !=3D BTRFS_BLOCK_GROUP_SYSTEM)
> +		return -EINVAL;
> +
> +	trans =3D btrfs_start_transaction(root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	ret =3D btrfs_force_chunk_alloc(trans, flags);
> +	btrfs_end_transaction(trans);
> +	return ret < 0 ? ret : 0;
> +}
> +
>  long btrfs_ioctl(struct file *file, unsigned int
>  		cmd, unsigned long arg)
>  {
> @@ -5699,6 +5727,8 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		return btrfs_ioctl_get_subvol_rootref(file, argp);
>  	case BTRFS_IOC_INO_LOOKUP_USER:
>  		return btrfs_ioctl_ino_lookup_user(file, argp);
> +	case BTRFS_IOC_ALLOC_CHUNK:
> +		return btrfs_ioctl_alloc_chunk(file, argp);
>  	}
> =20
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index c195896d478f..3a6474c34ad0 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -943,5 +943,6 @@ enum btrfs_err_code {
>  				struct btrfs_ioctl_get_subvol_rootref_args)
>  #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
>  				struct btrfs_ioctl_ino_lookup_user_args)
> +#define BTRFS_IOC_ALLOC_CHUNK _IOR(BTRFS_IOCTL_MAGIC, 63, __u64)
> =20
>  #endif /* _UAPI_LINUX_BTRFS_H */
>=20


--AnSqKnmdBFzO7vtzhFFM9EvUVHfjO73Hw--

--B4vzwPKLMqAI6H0NJyrjQZNtwtz2Lnwzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1IObcACgkQwj2R86El
/qgzWAf/cZbyWHpISVXJ09Oox+WgXSN2aZ+cPbRiCeGjm2OvVnQD7zNSWfS21NLO
mLQi58H+eisQlDGs1rDAiCX/TVFO6BPUXopaZ4DwQP+GFrj4W8yPUL7376/o8fWf
LKfdh8lDVoffH2dhI2DfH00OVbVEf50NHS/rI3MrU2Ncj+giIfx4dFjazrSIjgkI
Mf/6Rb8KFuAu6INvm8wDDiPh0qCfywsJyNDYK57J4ERcLp6t7SGC9QMPTUmPqCy4
l2ipx9imReT77EZ3rv6m0FobSrwwNTfYcPLNHtcvzFF0VQWiqDbExMIr3woLKQOC
qQrbsBNVFp1ohUYnI0LDfkcAiaq5RA==
=6EOf
-----END PGP SIGNATURE-----

--B4vzwPKLMqAI6H0NJyrjQZNtwtz2Lnwzf--
