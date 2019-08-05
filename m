Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D416881936
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfHEMYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 08:24:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:51963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMYg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 08:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565007870;
        bh=OUlSgA+tRdF9LsGDou7YGHUnAx0vAAl3B6HnpBG6zG4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Tr2MgTW1z8HSIEMEjtHgA84JUWHCV3KRMbE+iwjnInmMYRkTona9vszwcD3+Y4Qvq
         KrAD6xeVxdchiq686C/VqU2qhvRa23xNF1rvM+t1aYJr/dCqk+Q6PRbP+rflUCVG7x
         gEvIzXuQ4gViR8Ff2l2eme8hup+FEd2BgQiZKZgg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1iGVZC2HZn-00zUHK; Mon, 05
 Aug 2019 14:24:30 +0200
Subject: Re: [PATCH] btrfs: add an ioctl to force chunk allocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190802161031.18427-1-josef@toxicpanda.com>
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
Message-ID: <7b0e9be3-2239-ecdc-8b7e-a386f1def64f@gmx.com>
Date:   Mon, 5 Aug 2019 20:24:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802161031.18427-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5iZYx5L0x8nckH0Ebg4f76R4cVT4GRilq"
X-Provags-ID: V03:K1:CIPlm6D+VBqqHFsp87KkuLJqR1h5a6yY+GEbFfxhjMMcthk6nW3
 VOzyjvZ+9GRoQDTXQGtpJr11YFwAAbSwBWM8mf18lNO0dnE8dj93/pKxtd56Xmmo4T/W99d
 GlE8FP7t90vtWh9b/HxmSuBl1JtXOVXMoeQ8MVmFvqzixkWAGx9EDtk+PtEUS2KTWclEX3d
 5xFEINQ+0yt2Jpc5YzDHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LlBatJgt/3M=:wrw+ejgUxSJqmdy8E+mDry
 QbLcDjmX++P9zviiDGE+K89ipxiS6/6abz2ydz5dZvnNm5ub+j9PAimFnQ39SupK6dBRftH6S
 hgWhZJd0cyT9wYL+FNGsZ03TreTq19auxRWN+usR8Ne2sTVCZQqZhVLpDxNqQgns2+atC1FsT
 48Kgov4YbPNmyHve+4GaSssR7/duPVIIuyzFUQghxrRN0jo7q6JgOWxGQsY804rVWJaddc4a+
 kp0yiuL8cGssr/rB12fUU2kNqFgogT0C9qavnOpMrAmJ71asUw3/YRV9++FJNqWHkDfeW4o7M
 QIrQF1/QvUpiqM8+OVohzERYsAMbBneYotl7E9EmxxqEc5Z6dzB2SlDCWYX2CRNsn+iqyotm4
 IsWe3Erwdi+5ONBHCwaCNQsBSrof7OSzagTYFOhjDRGdUxeRpO5NWPMqh7MctbCayQWHVpHaN
 +XbmWY8MP3OPHONkZHSSHwXCOKtogMMu+X+nILomborAUoCd9V7nYF8X8hpHvUXVjXlzuV1v8
 POwXCBdYRAQpf97LgM1uky02iMoEsn/8ZURFCZPCnNytblvq7BGxFRKLWmmmyFyUD30HkrVjJ
 nyC5YzMSXEdil++WJFcYeLvUhLtt+o6cfhnHoKv2aGZfrQizCbq611a9Q227b2ZUYX08AItKh
 CZv1JqIi6fMCaxb8nW25jgV4vkdyvRmyTLvLs6R8qrzDrGAhBG/kj0hx/2BtwdWz4WUv4mSwh
 MCFXU/UU1FNSomfDxcVAXQDu5UMKnuFcpV6Mcet64EqTSA+DefI97ls2+wAcGBu/jEV0EtXla
 N79S/rNu2qZ7fsKJAC0X4su99c485iykOsAOfuda4EskydBHHLvrmU8dvy2bUcM1vpS0v2Dbf
 ORAK5YqjLm4tSBnz7Qi9/O0G4vusvtJqQC4Q3HpWgplAuUra6wXfNDOkcRiGH9YiIL+n0A1PV
 0Xe0Z+OQx+93wz/IQNwYbgscQ2REB5IXcOx7d0yokAiCMd9EEF2qWIDNLWfN+9tFIcEaVLaEJ
 P68LsgvxK8YWcNE6/GlgWDnpbgJbRhdT9vtFipPTayhkQo1lQj3wNCnXAQX/4o76H/0r5IDy2
 XbBZQHmLgE5+KThLe6LVsHHdlMVaoddnaF5ZDreCq3E2HyXPG82fcB5/A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5iZYx5L0x8nckH0Ebg4f76R4cVT4GRilq
Content-Type: multipart/mixed; boundary="Af4HMmuR5OJC12WP6RMmI2e6cCzAg2msa";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Message-ID: <7b0e9be3-2239-ecdc-8b7e-a386f1def64f@gmx.com>
Subject: Re: [PATCH] btrfs: add an ioctl to force chunk allocation
References: <20190802161031.18427-1-josef@toxicpanda.com>
In-Reply-To: <20190802161031.18427-1-josef@toxicpanda.com>

--Af4HMmuR5OJC12WP6RMmI2e6cCzAg2msa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/3 =E4=B8=8A=E5=8D=8812:10, Josef Bacik wrote:
> In testing block group removal it's sometimes handy to be able to creat=
e
> block groups on demand.  Add an ioctl to allow us to force allocation
> from userspace.

Not sure if we should add another ioctl just for debug purpose.

Although I see the usefulness in such debug feature, can we move it to
something like sysfs so we can hide it more easily?

>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c           | 30 ++++++++++++++++++++++++++++++
>  include/uapi/linux/btrfs.h |  1 +
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d0743ec1231d..f100def53c29 100644
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

It looks like MIXED bg get less and less love.

> +
> +	trans =3D btrfs_start_transaction(root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);

And the flags lacks the profile bits, thus default to SINGLE.
Is it designed or you'd better use btrfs_force_chunk_alloc()?

Thanks,
Qu

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


--Af4HMmuR5OJC12WP6RMmI2e6cCzAg2msa--

--5iZYx5L0x8nckH0Ebg4f76R4cVT4GRilq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1IH/cACgkQwj2R86El
/qjx0Af+NtQPbvkQdmUy+Qtsj6NJzgELnQX+N4Lh6K1Yc1u1X+9jcqwjrQ60yVGn
doa0F4J3Xwa98kIajMZ2x6YfRMCt/34XWVZb9k3WRhceFuJzqrRKeNi3/wkxboW8
HcvUeRi/4c5essu7fnIikLg2gGgXTPUVS4fmzlSiFknvyGGRJH+3ZRWXvbg5Nox2
VU2OAhnQ3xObo5S42Ojm5UviassMqj9ckTZurLhlaQolh8Am1DYZav7WayMSMrjo
nvsfn8F1LWtpN32qsiSiKl43CSf4tj8a2pQMA21QFZjuYNjrrmYNgF0PfEc1Vfja
jpPtTC6Auogw5+u62UgU/Z+fxkkJPg==
=wqL1
-----END PGP SIGNATURE-----

--5iZYx5L0x8nckH0Ebg4f76R4cVT4GRilq--
