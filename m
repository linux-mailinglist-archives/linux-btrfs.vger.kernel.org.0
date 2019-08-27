Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54149E18E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfH0INF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 04:13:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:38819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbfH0INE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 04:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566893578;
        bh=NqTq6Wuq4XX/TyEqmjQx50cNvWLjE+c0kYhoSCUgglo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CAgv+6I4TXOsP7S0gYwh8y4s9nO7ilEmReF0fy8Gt7okAYDUO5TG1x9jma4T+ceJp
         Vbq7CdGDRoCNoujP7GsftToTSCOmjMrH3v5UxwJWxj61n3PuKByG7wVoLUm/hGvMN6
         rmRGU4fIs94mT140WDTHKAnIsng4UrCbdXu4S8Os=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1iNmLX123S-00x5gj; Tue, 27
 Aug 2019 10:12:57 +0200
Subject: Re: [PATCH 1/2] btrfs: fix BUG_ON with proper error handle in
 find_next_devid
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190827074045.5563-1-anand.jain@oracle.com>
 <20190827074045.5563-2-anand.jain@oracle.com>
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
Message-ID: <2a203bdb-7cde-f970-6e33-38ba5f190c1b@gmx.com>
Date:   Tue, 27 Aug 2019 16:12:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827074045.5563-2-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0EW5g37VMWI4VI35wc9dOwYRwXUBoxtFA"
X-Provags-ID: V03:K1:vHNedYI4akiDESrj+r35DzzQ+cp+34Lee1UHYcnowDlMEgO2jer
 Q9jlgcZKXf5u7YzjYrXLUI8ZylHpKZnCP8oQN0i5PtjjLhdxarYVms+qAJflJuCkZ64iNQN
 5GnIMJnBeet9NR5JD+ctc0TGMX4mDEuJwTKu05h+u4w0Xr0t1R/NA9xpJ3Yagn03D6bPYg/
 RSHOV2iMiFgA28sJR04uA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZhIDK3L1PJQ=:9RUxeX3SYJ9sKZRo/n/zSx
 pVgHtkJt5jmL3gx8jg4Tyt8krmXq8ZUTysR0+mi9I8oLYJybFp9tOWNTZwN2Kozh+8g1+sQO5
 8C+vQpkcUv/JHKnGp36e7KEGVOcRdBeNcKE8Nb72K+UISSRDTAfxwOybWbscUTHVs7lCe09B5
 4+QaeX6G5jkqw3GUlq5ukMWE7hUhD7RsGgKWflzACZeMQ7OBjG2HopWOUuxrS/eDeFkEvb+n9
 shqxeFqclcagJqyk0FGaNw6rODTMAD5C3KBxs8aVpbmZuNWJ7Om9NYWg/GrXobmpn6LF2kVE1
 WMObDte9/ZjmdFJHGcOC7Iz2L/hjpxJL6wsXfuehP/pFpVfPU9QZko+cMdUmLJmLoNpgG2COx
 OtUQrmGfb3kpSVCLOTy/Byv84sFBwg8DzvADm6bWFnWtt1Y6wQ5LSes4oa7qcIkqi+F66IB+E
 I3QbW92DnQGJIro1Uod6lpvAV+XYHUTcgRTVnl55+UwGL2Qz6vu0sRHiplFydeos2V4PxKnei
 UzKLYZ2Ss5ZknBxHqDvL0/apbMfGcQURzDd5ONxlEbn0XJ9dI/AzrDZZvPNG11DJDxgROrHlF
 vbJH+wYA1KdyqtnLM725JNPU7q/G/ccq0eFtDiLngiKt0ErvIYOiRq7SsamNy0Od+fF5Ji0cR
 mrRht7+8EYpSeh7tLXEincKf5cueq40knNtPT6xaQa/iahhRJp59T+wDmyV/J/MyXP76YqTYJ
 KEF4k4Euy2u0+5E5TpeFUUnCs3oyrZdnUKsbKQduh5/W6ZxvNdbw2/souIHFICEehc9lKgGEs
 2KJCZsZ/BuTLfQIvkFuLkO1yxNkC2poNSZb9nOij2++dInYtTs088yTkHw1EyQiCTCT4fuW3K
 NCbBMRh485VSYtUtWySd4xbHskJrAlLm71/KYYEvkPl6vKQ44paCmAynCyhSNhPGiE88llzkR
 F45uoIC4lAwhVoydrDOEiW0TkcrTTi4fWVHV2GQRvg/EIgr6Mn0KpPxYbMXf+OE4ae8z1rxPa
 HoZsZUa51khcChBmr5zH3gscVdCVXUFzV1zyFMPnZDrt5tNHorTGPPzmlPG8+04TOMkMlnKQF
 5qvQmMBTm7TwRqChpz+Paaclsm0D/Lt5AEdJhViKqzGwKTuAEIOIPFRt4FGH2urNO373NbjoX
 r+unOt/y2wuJMSstnKUBYAtSjvhOhs6oQImeJdQ5UeQpbMbg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0EW5g37VMWI4VI35wc9dOwYRwXUBoxtFA
Content-Type: multipart/mixed; boundary="Dl6fCRbFjyzduAMgLvZsLPiMZewRNsDnx";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Message-ID: <2a203bdb-7cde-f970-6e33-38ba5f190c1b@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: fix BUG_ON with proper error handle in
 find_next_devid
References: <20190827074045.5563-1-anand.jain@oracle.com>
 <20190827074045.5563-2-anand.jain@oracle.com>
In-Reply-To: <20190827074045.5563-2-anand.jain@oracle.com>

--Dl6fCRbFjyzduAMgLvZsLPiMZewRNsDnx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/27 =E4=B8=8B=E5=8D=883:40, Anand Jain wrote:
> In a corrupted tree if search for next devid finds the device with
> devid =3D -1, then report the error -EUCLEAN back to the parent
> function to fail gracefully.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4db4a100c05b..36aa5f79fb6c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1849,7 +1849,12 @@ static noinline int find_next_devid(struct btrfs=
_fs_info *fs_info,
>  	if (ret < 0)
>  		goto error;
> =20
> -	BUG_ON(ret =3D=3D 0); /* Corruption */
> +	if (ret =3D=3D 0) {
> +		/* Corruption */
> +		btrfs_err(fs_info, "corrupted chunk tree devid -1 matched");

It will never hit this branch.

As in tree checker, we have checked if the devid is so large that a
chunk item or system chunk array can't contain one.

That limit is way smaller than (u64)-1.
Thus if we really have a key (DEV_ITEMS DEV_ITEM -1), it will be
rejected by tree-checker in the first place, thus you will get a ret =3D=3D=

-EUCLEAN from previous btrfs_search_slot() call.

Thanks,
Qu
> +		ret =3D -EUCLEAN;
> +		goto error;
> +	}
> =20
>  	ret =3D btrfs_previous_item(fs_info->chunk_root, path,
>  				  BTRFS_DEV_ITEMS_OBJECTID,
>=20


--Dl6fCRbFjyzduAMgLvZsLPiMZewRNsDnx--

--0EW5g37VMWI4VI35wc9dOwYRwXUBoxtFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1k5gIACgkQwj2R86El
/qh5igf/bG653cA+oufe/z2twlDzTGaEak5Gev/52DKmsL7QMidqS6pMM+TnQmVq
Nzo13NTTAJMG94JBgIdXA1yiLJ/AVoQgIoGG25oJfwbrKhUn6M7UBjB041E8BvuK
8Ui9X09nRtTzoUsG+NFTyDb29AVixHjU3NBXJ8LWVm5kaOZ4inhzPIKN8aWwLBBx
XWOgOW6BkcN2pU63NRQQ3bvqqZpSolG50r6ithaxuMoGblb8m+Hk3/vyi43xfny3
8SZoNWT7DRG4zF0azROhzW3mRGpPYXTiiAXuSHkQ3fdgGrurwMfrbnVXEqjx6iyD
FmmEW2Ca/9emr6hOneL+jnXHreEvVw==
=TOyC
-----END PGP SIGNATURE-----

--0EW5g37VMWI4VI35wc9dOwYRwXUBoxtFA--
