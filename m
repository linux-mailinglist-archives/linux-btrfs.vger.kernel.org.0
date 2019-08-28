Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7179FA04F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 16:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfH1O1y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 10:27:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:51459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfH1O1x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 10:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567002466;
        bh=6dON/JFO/ccTs22mAgJ4I6TNeNlm1nFTxq/I8ECexNI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CXK1WoLsAXDB6gmgnT7cgOVb/++RHTPcUPRcX5pk2VRvITINihooJHbAnWfR7mj4t
         Jcj/Kj/hYdGeIUYzOUi82jQ3ycL0qzmWqRjSVbdVFa0J9sp/eL1/KxhR2yZCXzDWxs
         GKbDoYMw2hKp7TzjJyEs282Mjz0OB1b/7tvtPSrU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M5IdH-1iPjoM2b9j-00zZGY; Wed, 28
 Aug 2019 16:27:46 +0200
Subject: Re: [PATCH v2 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in
 comment in print-tree
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190828095619.9923-1-anand.jain@oracle.com>
 <20190828140605.20790-1-anand.jain@oracle.com>
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
Message-ID: <364d1417-c86f-9866-2388-637514037195@gmx.com>
Date:   Wed, 28 Aug 2019 22:27:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828140605.20790-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cJUoUmgqgI5iAMkmzUpCZwyvlivGc6TRf"
X-Provags-ID: V03:K1:pBLAOpP5peTUYHXNCmKOkH6p65CMBC6MgMmL1xLI2cuS8mZtcwf
 tsSZx/nVabfoKhiHXRvovP5JziFebkFoAA0/mCX3LFQY9Rmlud/yVewm1dx3NxBKIryLakG
 /dV6KGi9uku6PDk1/v7IhwkDGYjALe8KDzRLolhjKT95VmliogyR6242kENiR9ouUSN9vUG
 SUrz3UMDFLIApS90Oig2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U4LOTqFsFyM=:PQra55Fpxryjja/R6bFuZC
 L+i306An8ekVJWio9GayXuDgPlFhRhWOocs7AtV+wFfwUP060GKfHS1xUwkxwD3eqDokl+GLm
 qWgYtF3/La+hPS0S3a3rBDD5/9Q1kxJI62ZN2SIASKbvSMCrR0LIgTjT2wo6c1KXvz7JlLO74
 M5ztA6sM3aATbwecQCxxgU0lcxPVxPuXp3jrifWZZfz7ASdIXvM9ldptoxdJYlLREho3kY2ac
 jmbqKwjGrv4qxDiVGWPlnFfyDHyFXVQ2MvOnZ/JpnggwWR6Hss1f9SckLAXZuHwp4Ci9caQO2
 Eydtf42427lwknWwlrKSpztMTDizCln8tEKILaZ5eBukcvBU+X69iWo8IePSaHypLDroKEnc0
 9pQ2dYPD14dyd+cbr0So7XyKoU/BhAtHxxf9XQd0wSalanqm6amCeVvo9nBmys6ceU21FsG+0
 qc31IMl0a74VvuMfORSu1Q7S4ZNW7CzOkVPAoDlB3QnGXnXQogSkJyh4nusHPczguj7YqCMR5
 AApi5Ti9ZDsixh2o0e0PUuou7vCKfI9EZ7zDoNOSMnyULM832z8WgbdAIzImpqB9EKVfvHma+
 0GdNOhpKU/Xmr8OQ5TckbYQu9vee/Ncjw6vK3HhZjZu9bk3qQvsP65aBidi8yKc8P95osrNxS
 DbmUxQU0osyKeP2xRkM7ATUxadMPUafHzuRZu2DYYkwlJGw7p8FYEJlJQMaTXRWrYieE75MzM
 HkR9//vVxNdzDOcFmhKsgE8l+y8YyC9He7gcohMxwe+hNCTC4Nk9jZJy0NvdtcJoOlK72Aa2s
 Nv+loZstAMCxLubKVV4M9DQPlmHefRNm3MlaSLu4fxxCBVHf8v96TLvFQXot1d3z21VOWt3PE
 sLUywjDiGJ60GQJvijdmygE9I1KSedwmsX2FMy9D3OjweFQt0fsoHrlzyvSzXF4/XcGc5dNv1
 du/aorXAXZZ1KkmixLbHQt7Q2POGO5iFUPKeydvmI/5sJPaizYO1VzlShkIAAZ0iHag3qAd9r
 XlRSkCv86RrraO/g22y18b/XF5Z+4mR0WnNUlj2y4iVPErQ9ERvlImu8/DeaL7O31gQXk/RnM
 uJiexZi71Uclq99Jj/oYuMrHW8LTLd4zcHskN+aYJrEWHjCtrAM5fysCNJYWT+JmgMshgjMQU
 LN/BPf+I0Pj95r5OVzQqKj0RHpMZId/1Zg83ddxhyr6TgFpQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cJUoUmgqgI5iAMkmzUpCZwyvlivGc6TRf
Content-Type: multipart/mixed; boundary="zYijM4koUmt3vz9JHFHaaey0vrSCz4jJk";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Message-ID: <364d1417-c86f-9866-2388-637514037195@gmx.com>
Subject: Re: [PATCH v2 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in
 comment in print-tree
References: <20190828095619.9923-1-anand.jain@oracle.com>
 <20190828140605.20790-1-anand.jain@oracle.com>
In-Reply-To: <20190828140605.20790-1-anand.jain@oracle.com>

--zYijM4koUmt3vz9JHFHaaey0vrSCz4jJk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/28 =E4=B8=8B=E5=8D=8810:06, Anand Jain wrote:
> So when searching for BTRFS_DEV_ITEMS_OBJECTID, it hits, albeit it is
> defined same as BTRFS_ROOT_TREE_OBJECTID.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
> v1->v2: Improve comment.
>=20
>  print-tree.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/print-tree.c b/print-tree.c
> index b31e515f8989..b1c59d776547 100644
> --- a/print-tree.c
> +++ b/print-tree.c
> @@ -705,6 +705,11 @@ void print_objectid(FILE *stream, u64 objectid, u8=
 type)
> =20
>  	switch (objectid) {
>  	case BTRFS_ROOT_TREE_OBJECTID:
> +		/*
> +		 * BTRFS_ROOT_TREE_OBJECTID and BTRFS_DEV_ITEMS_OBJECTID are
> +		 * defined with the same value of 1ULL, distinguish them by
> +		 * checking the type.
> +		 */

Oh, some bad design from the very beginning of btrfs.

Any other duplicated objectid?

Thanks,
Qu

>  		if (type =3D=3D BTRFS_DEV_ITEM_KEY)
>  			fprintf(stream, "DEV_ITEMS");
>  		else
>=20


--zYijM4koUmt3vz9JHFHaaey0vrSCz4jJk--

--cJUoUmgqgI5iAMkmzUpCZwyvlivGc6TRf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1mj10ACgkQwj2R86El
/qgeNwf+NiRz7ZXlimT45qzH0PcW0fdcCnvpQP3JrfNlR/ln5PiGcw3ZfXEgwWKI
4DT/T6t1V9nj8dsM2PgdnK6kxaYEItKOUqOCfl6GFI96R0NFu5NDlOiYgExsrLgM
6+MVkE+tghwdGWUVvdtilzz2GVoBNos+p9cOBRiH9LRQO1K/eyFIlNIEHN/R4J7F
+id9R2uhrfkAuE/nT5xv3EXV1UxdVBh2oJoMz2ck66Iy3xp1OJHwAjdriMoW/BQS
QOTcelwWr4WT8Oob94t/MCrpZQyunCPnJflq+SBC2hOx7fNFLM+U+/VlvVSQp1R/
bBJM8Ov2ZLf4SQ3jvzZ3M7J645Ml3g==
=GXso
-----END PGP SIGNATURE-----

--cJUoUmgqgI5iAMkmzUpCZwyvlivGc6TRf--
