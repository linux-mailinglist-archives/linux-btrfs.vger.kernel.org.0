Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2122471E
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jul 2020 01:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGQXq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 19:46:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:39535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGQXqZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 19:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595029579;
        bh=dvw/f2MdOWKhzR6kj5Ugdlama7ImJo9cFbfkb0F5DvA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Vcnz3vlp+B6cUuU/mX2Rl8JWfH0Rddq4SWCK2QELmsTMc/XKG/IaEHQo7mTzPWtQp
         Ur43r93Je0X7JyTNOzx0LtjC/hhPXAEDzZJqcyVh8UEMj1wsn5Qdt9DV6POxwFd6/T
         OKdJD9xT/VdIwrI/UPKNgUWoTqgxiSR+Mwo9mE18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZkpR-1kJQdx2Cgh-00WrIJ; Sat, 18
 Jul 2020 01:46:19 +0200
Subject: Re: [RFC][PATCH] btrfs: add an autodefrag property
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, chris@colorremedies.com
References: <20200717204221.2285627-1-josef@toxicpanda.com>
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
Message-ID: <c9b9d2f6-8e2c-01c2-193f-8f589134d39f@gmx.com>
Date:   Sat, 18 Jul 2020 07:46:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717204221.2285627-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YXg0iloXId4Q1Mp6EfbYzIvPU6zdxnD6X"
X-Provags-ID: V03:K1:rlxmdpWWQ3y9Y2HXjPNEjVx1vDRCzw0d0kBH36NLy8BBvZfmKeP
 ezEAL0fTMpN2qlGRUOtNdbotT0QZNtY7w2h9uYjSLmr2euFg+3CBZwOFp9XFKNkwsMgTFjG
 j+CyVFeBv5ZscoTX2ij9LrzAwbc9w1tL2V6+ndMnrQMb0jjYdRUYmISay/RfG4IpZ8OwBGt
 MBAYPr7sxxA2T6kjOYCgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xaNOuNLfMX4=:D759wPkZRMaB4zVb6HbNig
 ZikW3FF3YUtQZn18ygmpdz1zzD8DhX8INjt9H4WXFxUsZJtm/8mJZ1ZYLHMR5eak2gZ7uXTH8
 DFjtXZDWUhmdSi495xm8e4rqHmkBr8KfA45+u5yIBdubcOpwCP1q0rAD4MMNjSNW/tSQIzekl
 1DsIdkCK/zNl0vCSxUu6GKL6yhcrGL1h2VlImwh0uYCftLDRhDOm8c4eRfCJSTyun4Yo+kPWE
 I8je8OcrBX/q4DkSmDEAT3AaFDw3g00CAP0TMO4MkXZWaq7/26gQ+zPxuTnh2OMcZ5fLkhV+j
 Vw9jc/e3+YWXjqC0cMGMOcc+g7Iiz0oe6Xl2mWScPHQK+mz0zXsMKSs7NjFoGUtL0tGVcWnao
 DJb1Z6WQEi5w7D9IwoKWCUTdql6yY1rcrnqN7w4ARKFqYQOKbOPHI9RQiYsv+UViDei7fRbn1
 8fjPOwdWY2eGmlra5iVBkpr3/9k8yXfT9q/AFitKB5jTqsIXGscgj0NXqMqKOTuhl/YI2xw/w
 PBW9Ig83xmHesaNsHRHdug8okgTNcARQBFN5Kc4Ciar8Yh/8Kd6/ZbH4vZy44r3Xi3+3RQ8dG
 p8G4g/c6akVZpAeoaZFeBzqJYFCv5UBm7B8ab3s2AjsNtTmpPG5BY2LsFhVyoG+YVNSLnrSud
 +HjsJ3zLpPRSpXkfdGWplmMx4Du+2Qh30Pssz95yzZbC5nJw+56f1dvTFV/EKV9dEzdzIj4MQ
 di8MG1l+xuXdi6K/YpkQ0saZt80QcMozwFA5C3HiIE6M5Ym1hPJOiQsXn9xkEPIlGFzh55ptO
 jxd+EpBVXNw+BRV5qhFLw9yZfCkNSkdIA/0G+lAgMkefJuxvoNxF0IhG72ctHnwdkk3HCmo7A
 jo1Dl6h53bGHzdwYJ/XUVcvlvEyc0lIbkaciu3p0wU/564ZoHmtQDfmobcfsjTpxefyntLm2C
 UFk64tJXbWRyr970lLZekvRpBPqlT69tdQbWuZRT3Y+c7YhQd7lgvEzaXwDx2ATe5aApFJLIn
 5liWm9ce6JKkj9jrmNXt7I906f+3NSqLybp51huN4ZHrNdh5dmyPt85wbn4A5lTx9PpOgvns7
 DvDbKZbrPBUha6jfaQONDJqF4n7oexCKAa5EuiDJ8YYtDuqw39FtdV0JTsuckBKFH8FncI1BH
 v/t7bOoOSMQc8KWpNTwJW5yk2K4GgI/hKvGtnR2hpkfFe6yxfOS+2JlR6PpQ7y/FPvy0JJL3h
 uvEfgqIbnaYuqONIRSQqmdGHfACCRFsvgt+o82A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YXg0iloXId4Q1Mp6EfbYzIvPU6zdxnD6X
Content-Type: multipart/mixed; boundary="NiyOYezSiGiiJY9jpKTcvv4ZPKAlch1ro"

--NiyOYezSiGiiJY9jpKTcvv4ZPKAlch1ro
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/18 =E4=B8=8A=E5=8D=884:42, Josef Bacik wrote:
> Autodefrag is very useful for somethings, like the 9000 sqllite files
> that Firefox uses, but is way less useful for virt images.
> Unfortunately this is only available currently as a whole mount option.=

> Fix this by adding an "autodefrag" property, that users can set on a pe=
r
> file or per directory basis.  Thus allowing them to control where
> exactly the extra write activity is going to occur.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - This is an RFC because I want to make sure we're ok with this before =
I go and
>   add btrfs-progs support for this.  I'm not married to the name or the=
 value,
>   but I think the core goal is valuable.

The idea looks pretty good to me.

Although it would be much more convincing to bring some real-world micro
bench to show the benefit.


However I still have a concern related to defrag.
Since it's on-disk flag, thus can be inherited by snapshot, then what
would happen if an auto-defrag inode get snapshotted.

Would any write to the auto-defrag inode in new snapshot break the space
saving?

>=20
>  fs/btrfs/btrfs_inode.h |  1 +
>  fs/btrfs/file.c        | 16 ++++++++++------
>  fs/btrfs/props.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index e7d709505cb1..4f04f0535f90 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -31,6 +31,7 @@ enum {
>  	BTRFS_INODE_READDIO_NEED_LOCK,
>  	BTRFS_INODE_HAS_PROPS,
>  	BTRFS_INODE_SNAPSHOT_FLUSH,
> +	BTRFS_INODE_AUTODEFRAG,
>  };
> =20
>  /* in memory btrfs inode */
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 841c516079a9..cac2092bdcdf 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -116,12 +116,16 @@ static int __btrfs_add_inode_defrag(struct btrfs_=
inode *inode,
>  	return 0;
>  }
> =20
> -static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
> +static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info,
> +				     struct btrfs_inode *inode)

We can grab fs_info from btrfs_inode, thus no need for the fs_info
parameter.

Thanks,
Qu

>  {
> -	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
> +	if (btrfs_fs_closing(fs_info))
>  		return 0;
> =20
> -	if (btrfs_fs_closing(fs_info))
> +	if (inode && test_bit(BTRFS_INODE_AUTODEFRAG, &inode->runtime_flags))=

> +		return 1;
> +
> +	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
>  		return 0;
> =20
>  	return 1;
> @@ -140,7 +144,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handl=
e *trans,
>  	u64 transid;
>  	int ret;
> =20
> -	if (!__need_auto_defrag(fs_info))
> +	if (!__need_auto_defrag(fs_info, inode))
>  		return 0;
> =20
>  	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
> @@ -187,7 +191,7 @@ static void btrfs_requeue_inode_defrag(struct btrfs=
_inode *inode,
>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>  	int ret;
> =20
> -	if (!__need_auto_defrag(fs_info))
> +	if (!__need_auto_defrag(fs_info, inode))
>  		goto out;
> =20
>  	/*
> @@ -348,7 +352,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *f=
s_info)
>  			     &fs_info->fs_state))
>  			break;
> =20
> -		if (!__need_auto_defrag(fs_info))
> +		if (btrfs_fs_closing(fs_info))
>  			break;
> =20
>  		/* find an inode to defrag */
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index 2dcb1cb21634..5c6411c8b19f 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -310,6 +310,40 @@ static const char *prop_compression_extract(struct=
 inode *inode)
>  	return NULL;
>  }
> =20
> +static int prop_autodefrag_validate(const char *value, size_t len)
> +{
> +	if (!value)
> +		return 0;
> +	if (!strncmp("true", value, 4))
> +		return 0;
> +	return -EINVAL;
> +}
> +
> +static int prop_autodefrag_apply(struct inode *inode, const char *valu=
e,
> +				 size_t len)
> +{
> +	if (len =3D=3D 0) {
> +		clear_bit(BTRFS_INODE_AUTODEFRAG,
> +			  &BTRFS_I(inode)->runtime_flags);
> +		return 0;
> +	}
> +
> +	if (!strncmp("true", value, 4)) {
> +		set_bit(BTRFS_INODE_AUTODEFRAG,
> +			&BTRFS_I(inode)->runtime_flags);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const char *prop_autodefrag_extract(struct inode *inode)
> +{
> +	if (test_bit(BTRFS_INODE_AUTODEFRAG, &BTRFS_I(inode)->runtime_flags))=

> +		return "true";
> +	return NULL;
> +}
> +
>  static struct prop_handler prop_handlers[] =3D {
>  	{
>  		.xattr_name =3D XATTR_BTRFS_PREFIX "compression",
> @@ -318,6 +352,13 @@ static struct prop_handler prop_handlers[] =3D {
>  		.extract =3D prop_compression_extract,
>  		.inheritable =3D 1
>  	},
> +	{
> +		.xattr_name =3D XATTR_BTRFS_PREFIX "autodefrag",
> +		.validate =3D prop_autodefrag_validate,
> +		.apply =3D prop_autodefrag_apply,
> +		.extract =3D prop_autodefrag_extract,
> +		.inheritable =3D 1
> +	},
>  };
> =20
>  static int inherit_props(struct btrfs_trans_handle *trans,
>=20


--NiyOYezSiGiiJY9jpKTcvv4ZPKAlch1ro--

--YXg0iloXId4Q1Mp6EfbYzIvPU6zdxnD6X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8SOEcACgkQwj2R86El
/qgXGgf/QW/viXm2oXcFy3xUIDFv2laIU0u+09CbbWtCpdyHL6Btf7pBfhVoG2vI
YQ2Fbj7P6g1LAy+oAAl4IWMpfKOAc16Fk2uz5XxB8gY6dkCg4cH+anHVZEtZLLb+
VQRG0p7zxq8QI4MYKxGhYnQFjbzp4vtRuTteuxdXTbbIOeisw2YabGvuKFh5DLxT
ghlnSc/m8wdCQGpEFs9pUDZUMJK4PcWgzvxSS9aU1c4W7fyEcFpf+GbKOqNNpFdD
ajRxDNoKm57yOxXGWQgu4n+Lm2S83MMcxMwNhpT0C+lzFSZhpL1gDn3geJkzQgAJ
6weMIeBU5TUhxzRIxSextcydc7fuTA==
=Zju2
-----END PGP SIGNATURE-----

--YXg0iloXId4Q1Mp6EfbYzIvPU6zdxnD6X--
