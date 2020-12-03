Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788932CCCB7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgLCCfb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:35:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:60109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgLCCfa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606962835;
        bh=MtAA2MlJtY/fUh376gtsaIBJzwbrQeGPk5cGOlKkFzo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SrQR3daDfQoAGh/vObLNOWzltRgdyhtrG1mX+OVWetW1yYC65FTr+BS+6CyXirjlw
         8kp5DBLmJ2l/gCmb6wth1EKUY6teTLjmh0KnA27yO0HbiWIH1ox5J9cbrBKozmWwxo
         98m+ptYwtcLbaNpmlJC9iVP0rxtVgzL2ogyqCoB4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1k2l062aUS-00znlt; Thu, 03
 Dec 2020 03:33:55 +0100
Subject: Re: [PATCH v3 15/54] btrfs: check record_root_in_trans related
 failures in select_reloc_root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <b17d60d0e20d5898344b299d7018418d4c082fcb.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <a898fe02-ea62-8979-2e8f-a861dd5601b3@gmx.com>
Date:   Thu, 3 Dec 2020 10:33:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b17d60d0e20d5898344b299d7018418d4c082fcb.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kdN7f6qZ2QQOXB53kkEyHG3uKC6RylQmg"
X-Provags-ID: V03:K1:Dm8nJVGuHbONckqgbnHHzior9DS7LFY/O7+J8vQMAz4zCqOGl1Y
 9McQoSIcai1loPtAFOrmaQ5t7K3EsJKYD10jQLThxyLVkjNY7IeISy/+qmFpCdGRvtFbqC0
 E/AbHHsyF0YzEhZShmOaXzr0Z9ET99ORIIdzKvfRzWlKnrbwd0moqbZVlk6qVSG5+K4Hgsf
 YFmES4XZgfboDkGZVSGhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cQTSTv+f92w=:wj6zhtBJPEmA+j+coMBIXu
 Xv73i+/99mur8J0DQyRfHoGx2MoiMJdnj7BMsbXKefuI4xnCK+RTuneeZlLwdhXp06FXcepau
 X6n+iePiW5r/TpIVpamnDm/cl+h++oMcAQTU0mZHNZYpEE03ThQXLpc14Rgy4mQz405xI/tm7
 lu1jQIOL/de2vl2ZiQly6lKUC4XbBpqgB/DvZfO0A5AUVbPYqCCJkycDygo/DZumucTB3FYJr
 Q7JKakljyMO+DKsBk5eKFevG+xP+or5h61K0JSj7NOpJwvBg6ocF6vfDvayl4IS4ai36PW12Y
 spNTQygvN9TYDaUnNXBMT6Dun9CbwcO1XQIRzYiy/TmNDojMqynixysqC/znOjdpkeZ8n4r5o
 OpS5kUCH0oT7PyrjFYlMcpqmziH9B2SbyO2vI+4bidOR97mfi5BA0YrXAFmHtYJBK3XrVm4hJ
 /g/1MQeZimTFh8jOv5V9ZxaV5sRQIBz8/iG5XAsATlPYW9mA3JbiJUpcu24kuIgFVHyuEukh2
 geHl1iPmw7Wo9TgikTAxYW68AsyZwtGV8sO+Xhdwtk0JzSnNs83/9zrDYQFcAZ4nTOP7NVrah
 1vI9spcAT6ZMsJ5yAyg+/6ZJacgzkz36v9dG27RSxrVXi5UKFZDN09H4qZmnRQ6gwtilzDqYR
 CfHJ2oBGf6J6W1xDNlLiSzxhZnteEVicqjg1K5Ay1Dd4c3i9nCAXFZYWDceWRcwhwCTDdsy4i
 psJ84CO5xazmKt44LfREtJkYF7n6Zrw3ffpFHsvOy3bqkXhetqfzNBSpkzTZwg1eT2rHavBBa
 T+xH2HWI6ODNOvSXV8rhZoDQF4Nfg7m6iJ354uku0h3VNHxaC18PMciuxYlMkeXmQ1qiO4buE
 UI0xPtrZypXnW3hIv4fA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kdN7f6qZ2QQOXB53kkEyHG3uKC6RylQmg
Content-Type: multipart/mixed; boundary="3BwfYCBtDo94rhFyWYXaQP7Qz4PGczS5K"

--3BwfYCBtDo94rhFyWYXaQP7Qz4PGczS5K
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> We will record the fs root or the reloc root in the trans in
> select_reloc_root.  These will actually return errors in the following
> patches, so check their return value here and return it up the stack.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index bf4e1018356a..d663d8fc085d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1990,6 +1990,7 @@ struct btrfs_root *select_reloc_root(struct btrfs=
_trans_handle *trans,
>  	struct btrfs_backref_node *next;
>  	struct btrfs_root *root;
>  	int index =3D 0;
> +	int ret;
> =20
>  	next =3D node;
>  	while (1) {
> @@ -2027,11 +2028,15 @@ struct btrfs_root *select_reloc_root(struct btr=
fs_trans_handle *trans,
>  		}
> =20
>  		if (root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID) {
> -			record_reloc_root_in_trans(trans, root);
> +			ret =3D record_reloc_root_in_trans(trans, root);
> +			if (ret)
> +				return ERR_PTR(ret);
>  			break;
>  		}
> =20
> -		btrfs_record_root_in_trans(trans, root);
> +		ret =3D btrfs_record_root_in_trans(trans, root);
> +		if (ret)
> +			return ERR_PTR(ret);
>  		root =3D root->reloc_root;
> =20
>  		if (next->new_bytenr !=3D root->node->start) {
>=20


--3BwfYCBtDo94rhFyWYXaQP7Qz4PGczS5K--

--kdN7f6qZ2QQOXB53kkEyHG3uKC6RylQmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ITo8ACgkQwj2R86El
/qjBdQf/XBw7kU4CqA4JTyg9Ykju8IafSs/4yxgq6h+8u1oPYPi2vh9Dqwu66HSJ
372T73jEF6Y9Pnbl8A/vboalckoN/CKYV4qTW2udTuz2THklqM8AapiU2UIGFH+q
RkAjCJ+hBO7alAAtk1siMRf/CghmNynob+ifz9xJokgUkgcca6KF3SNF3YAOk38v
0aMBk6rq+G9tVJYubX21GJ6wYNoztIUTUsKZOomev+yoTvF31k0qRPvXQYhYfNyz
1SIOpV3mI3lTedLtEE5tsBrPkDee/c4+OtYL5M8reiwmGQJipHiLgSC6J2Tc7UGv
CAF+CrdxdSfJyEPhJWYlXU72Hb2Znw==
=56p3
-----END PGP SIGNATURE-----

--kdN7f6qZ2QQOXB53kkEyHG3uKC6RylQmg--
