Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2229E3D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgJ2HVs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:21:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:35171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgJ2HVs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603956105;
        bh=BkWCLJ4nTiw7C/83OfBCcfDQyLjrOA9zQECu+PxMjHk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EYnhDDk3y5O0ErBwJtBHiWvphivt0ult8JFx11mK99FeYSaVao2yYbqJMa5t1G8it
         vJ+KgSl2FiPY3sFbkrAtvC0xOus5QTkvV/cMHWmi7F8DcEygwliB1YR/WIOreb26D5
         TRs4l4n9SuvELY3jnFa+wnzbH+jCf1KdP21WHf0o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1jwRYt0VbP-00cMQ3; Thu, 29
 Oct 2020 04:12:53 +0100
Subject: Re: [RFC PATCH] Revert "btrfs: qgroup: return ENOTCONN instead of
 EINVAL when quotas are not enabled"
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <33ce2f6df841772666ca1cf3a4876b0ff6612983.1603921124.git.osandov@fb.com>
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
Message-ID: <0593a1e8-e10a-a5f8-83e3-750a7b8f9ae2@gmx.com>
Date:   Thu, 29 Oct 2020 11:12:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <33ce2f6df841772666ca1cf3a4876b0ff6612983.1603921124.git.osandov@fb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bXG1GBcmHqQnXxROU8inIvo7Ify1WmkNh"
X-Provags-ID: V03:K1:kuLymvRJn0KEoLPsYqIIVTzhoAwLL5AHO9PMzlzJLSfMIvC0J9l
 KnWa6jv3M/IFpK6VN9KY5PIPa5PyzO8eeYGxCWS9lrWyadJLNhkGQs82dQospOdeDEI553d
 9/ymebKmKBgG8NRhA6rSIIfhd1AF7Oq9fu+4PauUZNkV2FIo8LL0nmcfKPe5KBQAg9SX4rs
 OWwV18VDVDoUgyJPKMLfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V20Ta1Q562M=:HWvh5VSo39nybVqnvAUK73
 mAuPy6YNxsp8E+umgMmqL2DEcHzK04IxHJgPa0iiWdt5l4wYjX2ee+xgBkuGrFPxShVOGbTbl
 dLIQUCiyfPo1Ye8pc3lpTVFqcKRcaKmA1VN1ELrnpkTggHIYEfzh5paIDUuC0pb+NyoMEVAi3
 GCtamOZUdmKNuxjuFd9Yww1rQaxCNUwkVtbINe/GUFef//GtRdFJnZ9nXUhhF5sMMExReBKYV
 2gMFcABmWRdXG79OhWE+488mO+wVZSQ8+ABwDLWeeHv5v4j7OZc+onqbYYT9fQtYsRAiwNPI6
 cS4IeYhZO+MhCsPiklcDcu9/s5NWjLvBDfPHyRgX+LESAno2mxkv/fH84tWHQ6jf8jxDFaQXI
 w8XPTxusy+mCQqVJRxEhg24T0aKzLO+RWOCh0heSgVd2jKjYc4x/d2PXDw4E7LnxQZ3c6bkQC
 xJDNCVJibu+abPhl3sRLV+CgjHbnjgGRUzSWUM9iFJMrSeqPU/5Mjb40yXdKcFpHtV3dtCAz1
 76g45W2D5mn2p+PM/heXxhWARCZiwcqcPptD9j+KToWWYklU8WjIPo8YFBfTlFJcF6920SuvF
 3CJ/FTtLKW75NUgJe7lV450KowVC4gTLPnKYjgahvIPAUGhMPaXweoO22ENxveYRMO2Vu/mGl
 JVnj9NHyCbfrG9o0NyjuTMyEoWM6iVTj7Mpy7fdHp3bpGxLDuQYAyP4HR8C+cVNDsi1BwDR54
 ZTEto3eNFCL1AZL72vZxJEdTFBbJcfHEJgjT5NPDwmVy2ph2hLIrENYTa+wJy3EFDyuth7SlZ
 3S/G4uDrjrLDAOqlxfrmD49+9LoQZRxXu0yR0tC9aJRQQmfuh+79ZTyf/lx01TjDqG+Nfd9uv
 K+udoGDJMnpcRSNPf4fg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXG1GBcmHqQnXxROU8inIvo7Ify1WmkNh
Content-Type: multipart/mixed; boundary="4otGnon8TQ5MMAnwA3hAKwzUnzTvbpycI"

--4otGnon8TQ5MMAnwA3hAKwzUnzTvbpycI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/29 =E4=B8=8A=E5=8D=885:42, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> This reverts commit 8a36e408d40606e21cd4e2dd9601004a67b14868.
>=20
> At Facebook, we have some userspace code that calls
> BTRFS_IOC_QGROUP_CREATE when qgroups may be disabled and specifically
> handles EINVAL. When we updated to 5.6, this started failing with the
> new error code and broke the application. ENOTCONN is indeed better, bu=
t
> this is effectively an ABI breakage.
>=20
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> The userspace code in question is actually unit testing code for our
> container system, so it's trivial for us to update that to handle the
> new error. However, this may be considered an ABI breakage, so I wanted=

> to throw this out there and see if anyone thinks this is important
> enough to revert.

Well, I'm afraid that reverting back to -EINVAL is too ambitious and the
new -ENOTCONN is indeed better to indicate the special case of quota not
enabled.

Thus reverting back to the old EINVAL is not really a good idea, it's
more like a dirty fix specific to the use cases at FB.

Sorry, I'm not a fan of reverting this patch.

Thanks,
Qu

>=20
>  fs/btrfs/qgroup.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 580899bdb991..50396e85dd92 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1318,7 +1318,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_=
handle *trans, u64 src,
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -ENOTCONN;
> +		ret =3D -EINVAL;
>  		goto out;
>  	}
>  	member =3D find_qgroup_rb(fs_info, src);
> @@ -1377,7 +1377,7 @@ static int __del_qgroup_relation(struct btrfs_tra=
ns_handle *trans, u64 src,
>  		return -ENOMEM;
> =20
>  	if (!fs_info->quota_root) {
> -		ret =3D -ENOTCONN;
> +		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
> @@ -1443,7 +1443,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -ENOTCONN;
> +		ret =3D -EINVAL;
>  		goto out;
>  	}
>  	quota_root =3D fs_info->quota_root;
> @@ -1480,7 +1480,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -ENOTCONN;
> +		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
> @@ -1531,7 +1531,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle =
*trans, u64 qgroupid,
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -ENOTCONN;
> +		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
>=20


--4otGnon8TQ5MMAnwA3hAKwzUnzTvbpycI--

--bXG1GBcmHqQnXxROU8inIvo7Ify1WmkNh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+aMzAACgkQwj2R86El
/qiI0QgAoSiDnM8Cmj6LxfBVzmwOE+2HGnCtPRcTj8+YrHTMS0YYCzq4ATMdsSJ1
M2CTKEPPu9pBARbFdXS0NBPQFayC4UT7jWwu/1T2GeNhOjLrN2cklVXUlYWHb4gp
xeRmjuICNN8f2/vi7J7xFMqtjOMQ0IrBBSqu3vjnrYwwuuTJgLwDWpeyPuZdiSFx
UcYsZbll2+j/Di5bIACn3u2bQZh32D7xn9Qjm5Ofg78quvs16uHreX2FURyt4vXr
rli/jtrJclPXZrd3hKrbDljNNIpfLo50pjamducRlBFjNDvXh6ZqW1NXVynYohEc
jQv2sffk4SC51xHZ4lhaIq6UdXP8xQ==
=VpOW
-----END PGP SIGNATURE-----

--bXG1GBcmHqQnXxROU8inIvo7Ify1WmkNh--
