Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962752CCC94
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgLCCZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:25:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:45155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgLCCZ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606962232;
        bh=FdH57odpug8bXpgL7sdwGPw/5NzxFWEwLc05MePe6L0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YuLplsP58GirRylw+G+yuqu/R5fAyqEuVnRzq37TF3bRcNSd1m7T0Hxebdr3ar/7P
         zgo38Jx9OmHc7wUqW4x/QqPeuKnBpNvr4txxB0rFpK4zRB6OVk3bplSKMUc1PlNUTw
         XPScy6qGr6em19j33J6p2Retrl6vSscq0ycjzdSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUGi9-1kcdwS3Yax-00RIHd; Thu, 03
 Dec 2020 03:23:52 +0100
Subject: Re: [PATCH v3 13/54] btrfs: handle errors from select_reloc_root()
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <871fea9cea530b626f0f253c00d53a3e7a1ea531.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <811a4ef0-72a4-c1d3-566a-60c09cda53ef@gmx.com>
Date:   Thu, 3 Dec 2020 10:23:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <871fea9cea530b626f0f253c00d53a3e7a1ea531.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hEq4Wy2qqo2DY7l8i8EcBiEXn9FwkjYHy"
X-Provags-ID: V03:K1:Jub9OlOHV9HGWylf6s8YMzxtttG3DfOq8JGCJy2b7vUe9PSqzUt
 eCnebRCWGa5udFnwYkW2LnSjPTTMMl6Ke7xy2iYDiJVOsQni8XDtNh8jTnyePhTVTBuuDqR
 TgqJklAWQH5VEXoDAznoqwTRTmar0txHfxOO2QV8bEc0nHcq4ribf3UcYYFpllvIhAXWsBa
 BSjf4PxPhEN9aQYApiljg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EgI0kx4I0yY=:giNYgdk5TNfmiVoS/2KDWQ
 XxK/b8+QKAQTJqH6XIeN05WGZs5uUU29Ys5ub3R2CEqcQkICE7XIZn6pACI2dPXj7Y/JExzzp
 6CMvLfyJei8MurN/E5kehPRWIPr/jYmGQqy/kBwneEknr2d9+nlGY0WvQpzApUmUpCx1ibwta
 quSNUcfDnI/P8tAfMdumyvL714pFoD+mwaVd4zf5pmPNvvMG4oZHOAaqZ/4FD1FtVQNWgff+q
 36sTJsC4tihf02GhFxEhBMN0ofSAMAphsY1pIGQdjMwJNZKcuGJrg6AR0TzVdcQmP36QoOYW2
 OMtulIqqINzL/4uz0Aoqy/dPiRZO6pXu7TQAGzt+jTJ0+TFtO3Jm7bkPYP2xHDSkfuvF49Uss
 KQa8zourkzWOdTuiT+up3URNsFsIKmJ9JpvmOKP1q9uEfwR7WVQnYvwTfAKqTQJ6AtjK5HWWD
 WovydmYieyzV/P5m6PFRjVgp3mLYMq0eYPzhyUd88sLaHSOxBRJMmS2i55v+Ge5bzWCxuyp5S
 vhkgTgRsWdbhSsTi0IaULzHtGG62DTw0hWIHwQSYEwcat3zf4h5NC5Fjs77RdCidNAdpo7oem
 ssVEcs/tclfvwxAkLu9sEDMMImm3WYokZkCij8ibwCHGdwy+eWa0iZlwwEAm4lSRthE8T7anY
 NDLSmFy9/eqzcdSbcm3XjpHLyXJ4/DYYIxIApwODxa3QTu1f9k2v/q4F3Pqrw3sNy3ywrVcAA
 qK6kWlz5pKie+n/JH4m+QUe1ziCXcUjlX+MtDE39K7hqoALAA5u4sytgsdWGyxSU444NGBqaF
 oGXo2FhqNRo9eZ71w0a6nSrXna5X+mdBFU98663e08LtObbH/OV1OtHrGD+xUwkw9VrJ+oGCC
 KL75AuJK88XgR+Eg78Pw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hEq4Wy2qqo2DY7l8i8EcBiEXn9FwkjYHy
Content-Type: multipart/mixed; boundary="iWA52XQp1nJd3BOFUTTpjxHc3hZJJtRX2"

--iWA52XQp1nJd3BOFUTTpjxHc3hZJJtRX2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> Currently select_reloc_root() doesn't return an error, but followup
> patches will make it possible for it to return an error.  We do have
> proper error recovery in do_relocation however, so handle the
> possibility of select_reloc_root() having an error properly instead of
> BUG_ON(!root).  I've also adjusted select_reloc_root() to return
> ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
> error case easier to deal with.  I've replaced the BUG_ON(!root) with a=
n
> ASSERT(ret !=3D -ENOENT), as this indicates we messed up the backref
> walking code, but could indicate corruption so we do not want to have a=

> BUG_ON() here.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4333ee329290..66515ccc04fe 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2027,7 +2027,7 @@ struct btrfs_root *select_reloc_root(struct btrfs=
_trans_handle *trans,
>  			break;
>  	}
>  	if (!root)
> -		return NULL;
> +		return ERR_PTR(-ENOENT);
> =20
>  	next =3D node;
>  	/* setup backref node path for btrfs_reloc_cow_block */
> @@ -2198,7 +2198,18 @@ static int do_relocation(struct btrfs_trans_hand=
le *trans,
> =20
>  		upper =3D edge->node[UPPER];
>  		root =3D select_reloc_root(trans, rc, upper, edges);
> -		BUG_ON(!root);
> +		if (IS_ERR(root)) {
> +			ret =3D PTR_ERR(root);
> +
> +			/*
> +			 * This can happen if there's fs corruption, but if we
> +			 * have ASSERT()'s on then we're developers and we
> +			 * likely made a logic mistake in the backref code, so
> +			 * check for this error condition.
> +			 */
> +			ASSERT(ret !=3D -ENOENT);
> +			goto next;
> +		}
> =20
>  		if (upper->eb && !upper->locked) {
>  			if (!lowest) {
>=20


--iWA52XQp1nJd3BOFUTTpjxHc3hZJJtRX2--

--hEq4Wy2qqo2DY7l8i8EcBiEXn9FwkjYHy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ITDQACgkQwj2R86El
/qgpPAgApGybEksHTQcFOydywdLsx24+ugxDrKUj9c3dFi93Y4ARvvZFc6QA0738
aLJpv4S+B383tdYgBo9IhtjKqNPPHV7/8Mj4DhdeufMrblvLGS480OVPtCDZL1Ms
ynNSdDsZ1shzM1rwDW3CDNfm/vJmhxXJaj99aOchL4SmkRZwTn/WhYGNpDM/O1a7
hyvSIODuRpV1eiXbpID4AuQa4jpVIYnykNdqhY+Md6phbDLObrj/oPeKFcgVdWMo
1Yl6Iz6lV7gJIn24VAbkggf+6ccrUWREBYZFD7p5DU/HuU50J104FHK8pCG7BVfN
p18QXyUG0KIHsgCsBd6DfuTasfR9wg==
=A9Bf
-----END PGP SIGNATURE-----

--hEq4Wy2qqo2DY7l8i8EcBiEXn9FwkjYHy--
