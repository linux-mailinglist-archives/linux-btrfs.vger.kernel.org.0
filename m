Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEA2CCEBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLCFma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:42:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:52005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgLCFm3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606974054;
        bh=Xh7L/lLXZoUsPSVBKx/efU/vaxt8BSH4cGY5nepQ8R4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OeFA+b+h6n0miqOimLd8D8kk3nM0tVXnqrNG9LhDTB+xZn2Iq8e+KvJ3bJ1OzYIkK
         4AqaoWEt3pObK7QMjT08NIEh0FkQ2s2ogmSR1mLaA4KkpZVGeHcCyLG34Tlv2u0XgO
         0GBhzFKgp6LWTdKkSOoibcfMcXFDWqLKNjNk1nV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ycr-1kjJWA3pHv-0034KN; Thu, 03
 Dec 2020 06:40:54 +0100
Subject: Re: [PATCH v3 48/54] btrfs: handle extent corruption with
 select_one_root properly
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <6570c4cd1433a02a9d84e6fcd93f9a971d7f42fd.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <da77d32d-2c80-9974-8011-9ca096383a0b@gmx.com>
Date:   Thu, 3 Dec 2020 13:40:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6570c4cd1433a02a9d84e6fcd93f9a971d7f42fd.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3pdgsYZPgPBb2ZE3ABpTu61GjVqi5nyIc"
X-Provags-ID: V03:K1:2ISiCW0R2cVbuuKgA/scj34nouOC2AssqSb39G8VD/TBcNToVRa
 uIFRiX91NmQPpJN0QYp1jNNin+30ki3taBRboe5YCx9v8NF8K79X7zLt4YL8CJjEUjCAMGN
 AB+U/ih12GD8SWQSINb7/qUGTqZOh10ISlvY+OuCpjyovVqOrPi8VTfqqUxyWj+YlJ7Vq6i
 zinMYr4lIP8dUuUPJaB2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7fEKDEPNgD0=:ZhneuJplPtwTdqVkjwGz+f
 LQFT9uCFJzDQpuhysrvm6vtPuSEcP/vX4ziQkDbc7iUX1U2g76ucezzWNL4fiCr6rK8uCM/Ed
 8s063YXqh9tPXW/4MHVdgc26wOLEvK6G+uyfN1PwSLFDp3cQEYMxmoikZJ92xAEuvIlhorJgL
 S8sbdnmjPBiXSYKln39lH0X82rs8yMtOMzhAG4HGr/96OHfgh55kbFeZEnLgGOCt5UUB23HOO
 9pf8SyA/YFYBDua8vI4CxYg3YxhRwypjN9Qie4P9WlnMOG9wwXBToSJGct5ptZ1biRgofsumV
 81oFZXQvwDqb4kKlLW22HMF7gRtKtY+PJs0hAe3LeOEXg5NF5CWMQBjRg+RfoUdrO8hrYzizN
 Cl032bOma/4qEKZKiSyRy4FTwNHtqDeG7ZlpWLv0puU7Xumx5csWs+W0pIW5AhYf9iawDcDAa
 R/U1bVDEOzxNun9oixnJaQRuBfK/w0Vr8E6nY3fT37coJI1H4IzG25PTwom+6A3D1EWkk0+sx
 tq4zB85CIPNkjiqh1mRzlDQ1HbpFFNYoFMveB1Z61ovDV7I9x57KKhbsZHeQZLys3VeIx4PMn
 FSIGbBE8hgsed6USU40mSgPQelLc1KB5dHcFGEkyaQ5rFlPPdGd8IjTmABekXckH3IlaBvZyd
 +/9NEIHZKoRunJ78CfpLO0+Z73OMyrpzaqZt1CtjhaWpeQ8DCq8HQi7cxUSw1/bADpuy6PLby
 4u67jC1qFUDMxFhepj0Nga6vaW2Y0TiEY+Fr67sE3gGaLjANqgs/8czfgmuu+wQ1HyJqWtgGy
 faPWku20CQDtIBPKpGPedAKrPXzqsgfMtpRP0jtHtbBTk68ad0o53sfM/B+gLjtIsr1sk825E
 4R+Nytt+eheT7kIiiES+OQzOeIp95p5s6GRUfVyp8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3pdgsYZPgPBb2ZE3ABpTu61GjVqi5nyIc
Content-Type: multipart/mixed; boundary="N6BjLtBGKFAkPycyZJQlwXmJv3jxtuhWa"

--N6BjLtBGKFAkPycyZJQlwXmJv3jxtuhWa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> In corruption cases we could have paths from a block up to no root at
> all, and thus we'll BUG_ON(!root) in select_one_root.  Handle this by
> adding an ASSERT() for developers, and returning an error for normal
> users.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d4656a8f507d..91479979d2a7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2200,7 +2200,16 @@ struct btrfs_root *select_one_root(struct btrfs_=
backref_node *node)
>  		cond_resched();
>  		next =3D walk_up_backref(next, edges, &index);
>  		root =3D next->root;
> -		BUG_ON(!root);
> +
> +		/*
> +		 * This can occur if we have incomplete extent refs leading all
> +		 * the way up a particular path, in this case return -EUCLEAN.
> +		 * However leave as an ASSERT() for developers, because it could
> +		 * indicate a bug in the backref code.
> +		 */
> +		ASSERT(root);
> +		if (!root)
> +			return ERR_PTR(-EUCLEAN);

Just the same comment on using ASSERT(0) in the error branch.

Despite that looks OK to me.

Thanks,
Qu
> =20
>  		/* No other choice for non-shareable tree */
>  		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
> @@ -2598,8 +2607,12 @@ static int relocate_tree_block(struct btrfs_tran=
s_handle *trans,
> =20
>  	BUG_ON(node->processed);
>  	root =3D select_one_root(node);
> -	if (root =3D=3D ERR_PTR(-ENOENT)) {
> -		update_processed_blocks(rc, node);
> +	if (IS_ERR(root)) {
> +		ret =3D PTR_ERR(root);
> +		if (ret =3D=3D -ENOENT) {
> +			ret =3D 0;
> +			update_processed_blocks(rc, node);
> +		}
>  		goto out;
>  	}
> =20
>=20


--N6BjLtBGKFAkPycyZJQlwXmJv3jxtuhWa--

--3pdgsYZPgPBb2ZE3ABpTu61GjVqi5nyIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IemEACgkQwj2R86El
/qgt0Af/Vpa8JTSd9FjQSTbG46UhZ/qWhlZAoe4XW7URaEWzosoMpIGaYMhfMp0y
aMI/yHphaLaNeu7sA2ZQsewrFoM6fBtVp2JPRR5As+VcN55uXXs8OIBKHrgf9Jd4
N5J5cDjvjYQuZmp2VRnXeQ2SDvYXUyhaYGFbr0GqDiyd2vzpfSy53DUTiPY+r+bh
jRRRjrlG9hysoNouYbAE0B4hwSEQ66h1zGpEvGn0J19giaZNaBmuJ1O7NKENy4Fb
lWjdfGmO7GUD3BfdDiz+J1OE/obkxHx+te6QTqmka6BLurGy1l7y0OtnxZV7WohI
Yl1KRRHo6tMjaqio1JiNeVMYUM8xsQ==
=ft3C
-----END PGP SIGNATURE-----

--3pdgsYZPgPBb2ZE3ABpTu61GjVqi5nyIc--
