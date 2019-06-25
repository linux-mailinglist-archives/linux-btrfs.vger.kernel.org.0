Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C15267B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfFYIZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 04:25:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:43247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfFYIZb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 04:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561451103;
        bh=d2guqht07ZDntbSgC36NQ/gan+o+Iveyk4JbfiefNiQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=g3oIfxUaJ23CNfLNhIRXtWQIhj/8C13XNQUbnY1aAfqV7f/+W2616zkgTpJ4o08ky
         Iv7asUxfKjh61wOhtPV19+lsKFJ97ovfi6iwemAt5yhoTXM+1T2gak+FRpos98UBSg
         Gpm6lxfxMf5UHHU+8yl8Eu0uCgRxBUL1Ju1WBTM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Mc9U3-1hyb3R0U7T-00JbVD; Tue, 25
 Jun 2019 10:25:02 +0200
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
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
Message-ID: <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
Date:   Tue, 25 Jun 2019 16:24:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20180515073622.18732-2-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lKjiZ4aJTfSRhWzPcbzE03U4hoWR8lcNk"
X-Provags-ID: V03:K1:4XCfsfHKONa2U7ASr44f4jXLChShygMUuARU7gK5W+KBNNp2GqE
 cmST/BdMknMqyO1CGiBAGC3CJIe4C63NkYvvPJcO7Ifw2EJrUcJYF6ef1sBzvAS7KCggT7E
 suF2dhVgwcaFN9LwNIAUFqbFR6XEg0nIRMta2Q6gayEWWdVS7APjW68Ok+aspNmG1p7fNCz
 L1Ko7x5g7BgZeQeP/lXDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RdgZ2/TcGZE=:/JjxFzxp5Cw+f7DoXJERm7
 7ibuWJTKKWBEUyOE8oQZmZADOUVYX055daeN2McBrryIM+Tct+EivX9vdVomDsiTpMomdQoRY
 vxP84g5R7nadWFsA96W0AaEVqV6wWM+q/I5VYWosIQl8qh5CIF5v6FkSL+dIaVH6y9AF+LlUY
 baZ1HvonOLpWK3EJZLx/OfiTLUvjlhtoXO+9vG1i1REpP1af7TOh1mA6Qtqr8jIAm2ZRwJgSl
 4x0+0Jd9PUxduzKVSCoqe853566FV3hxrbd6khtMdZQldeFipzG1wgpHBgs6Vn1WEidUMGULU
 WsYhyR8kx0vdEY6CX4HZQbUP3mUIx/OgJw/bx7bW2HJG4iWkjRBlb3Kisn5Kmr2PlolwMvgsk
 onrMoXb2YEXQVz2jxa49/CB9jsLG3OPKVSlHnOldNlh1YLMbpmcTLuYuGRFLiWCvwIjPd9I2F
 Jrb/b8jotrb3ZKP9ce1oSQFmZu5paFjwI+gB16IWmx8tU4xL+41Us49wkLvpxsiI65jIgCEzF
 C0dKZvANoByM7rWfPGhrraU1cH83GYcSH1UJFcrr3ZPwvlhUV+ZhFCFTTXO/Oi7nQ/CphGYYB
 hsWbQtK0/oXxGVFXe3BvXA2t0AekxscRJGPXMflWdTTXG9Lle0+l1zJXOxKNgpJU2QMuyvyG5
 99IpEv0jKzcd1gy31/olJOqjVnX1r9/d06WikCAPyClpVj9bQCOPHz034ZYUedCT83FL+15rn
 7bODqKm+1iIlvrvacBR6GoF37g7HGmt7ahqcDZHwJECWgshjM/ObTNmVAkY5bhH0npIhf3+ub
 Lbcf2QuU/OD+6T2qldjnV2TQvf2iRPonSJ/khj+5GNlJzDKnJuV/WiI3Q7Rbu2XL9zcIZSLHo
 6b0A6pkyPvqoskbSH8RXdG5ZYjy/nbP/ecARiRleZIRdxkYCN8aNJCZXokegMyJ3eB81ECPCb
 ZKmxSEkuEBPmxIj91gC6scJ4HILByktkVSkiUZVjbjKrVeIy5xqDqkYHtiXwFp/gHRoWzjjHa
 MEhl1gY/D5ZIH0nTr2Uvj2O2xOLGWcG4sxILOH30VUFT3OI7W6cjX6i04QicFf8UlWcM423+D
 ASoS2/J1Ks1RDU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lKjiZ4aJTfSRhWzPcbzE03U4hoWR8lcNk
Content-Type: multipart/mixed; boundary="so1FQ5FCbKhipyoOa6V4YKDLXS799UuBi";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
In-Reply-To: <20180515073622.18732-2-wqu@suse.com>

--so1FQ5FCbKhipyoOa6V4YKDLXS799UuBi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping?

This patch should fix the problem of compressed extent even when
nodatasum is set.

It has been one year but we still didn't get a conclusion on where
force_compress should behave.

But at least to me, NODATASUM is a strong exclusion for compress, no
matter whatever option we use, we should NEVER compress data without
datasum/datacow.

So I still want to push this patch as is.

Thanks,
Qu


On 2018/5/15 =E4=B8=8B=E5=8D=883:36, Qu Wenruo wrote:
> As btrfs(5) specified:
>=20
> 	Note
> 	If nodatacow or nodatasum are enabled, compression is disabled.
>=20
> If NODATASUM or NODATACOW set, we should not compress the extent.
>=20
> Normally NODATACOW is detected properly in run_delalloc_range() so
> compression won't happen for NODATACOW.
>=20
> However for NODATASUM we don't have any check, and it can cause
> compressed extent without csum pretty easily, just by:
> ------
> mkfs.btrfs -f $dev
> mount $dev $mnt -o nodatasum
> touch $mnt/foobar
> mount -o remount,datasum,compress $mnt
> xfs_io -f -c "pwrite 0 128K" $mnt/foobar
> ------
>=20
> And in fact, we have bug report about corrupted compressed extent
> without proper data checksum so even RAID1 can't recover the corruption=
=2E
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D199707)
>=20
> Running compression without proper checksum could cause more damage whe=
n
> corruption happens, so there is no need to allow compression for
> NODATACSUM.
>=20
> Reported-by: James Harvey <jamespharvey20@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d241285a0d2a..dbef3f404559 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -396,6 +396,14 @@ static inline int inode_need_compress(struct inode=
 *inode, u64 start, u64 end)
>  {
>  	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> =20
> +	/*
> +	 * Btrfs doesn't support compression without csum or CoW.
> +	 * This should have the highest priority.
> +	 */
> +	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW ||
> +	    BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
> +		return 0;
> +
>  	/* force compress */
>  	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
>  		return 1;
>=20


--so1FQ5FCbKhipyoOa6V4YKDLXS799UuBi--

--lKjiZ4aJTfSRhWzPcbzE03U4hoWR8lcNk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0R2lkACgkQwj2R86El
/qi2SQf+JwLBpBUEWVNbY/rMMmGgq8/HnYrKEMumPSpQHjayBx400L6wwAXpDptG
HgFWzWYyy9QMLOi2XRxlTvLbP0ECKbEPMWyXORJ0RtKmyuvqn2rpnIManXDNWMub
GMAIicsOWsP3nrsEoy/Uwowk0O3bJF76f2Ayei/5KAWqKma+zrPJBKQXRMKMfsku
+ASJZ9XgwpEdNizwzaRLR9Oyl0GowUgbHjSVaqr5aqvjY0OpY6EUrVtVfuZv7XvH
nTqXIPSMy3NNs7zW1zUGPxoZynogZZlBulrNY3Eo899veEIPDE/TLYV2P4g5I+C4
L8NAwtIEMqo5Yoag4XzEk3oqXhzj3g==
=ngdu
-----END PGP SIGNATURE-----

--lKjiZ4aJTfSRhWzPcbzE03U4hoWR8lcNk--
