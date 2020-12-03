Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21892CCC57
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgLCCRX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:17:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:39945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLCCRW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606961745;
        bh=qGICIyTqIWlkdpX+3KS/D5yiiSj63kNENgJvW6hzImg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ExoqpRppm9yob31NqX77lGd3VB4RQVj73sLFLo58GCbQ/d/CEKVubvEv+m6zASaSU
         HR2TIjBf/XwZVd8I6CTXbokoXC33N7iLUrnpSvv1ZLjcvdYPJBuFDXpt2Aa7Ee6onv
         HMnwnCwl79TOZZW+Pwevk9rH8a9XBaMVIp2w0JaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1OXT-1k1MuQ0y43-012lfh; Thu, 03
 Dec 2020 03:15:45 +0100
Subject: Re: [PATCH v3 11/54] btrfs: convert BUG_ON()'s in relocate_tree_block
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <bba6b87c894fc35055d99f51b16b66e662f1b127.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <ac9841a4-52d3-eba9-602a-9d43132fdee3@gmx.com>
Date:   Thu, 3 Dec 2020 10:15:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bba6b87c894fc35055d99f51b16b66e662f1b127.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8NeVwyEtms0vcMYuTfO1j1dYJvtBiRmWI"
X-Provags-ID: V03:K1:16thy/Bdi7CYQYM8KkaeIUfiboYTwGktmchmgF3+eZUSuypWgEz
 /MN05b8W7A5V4KSPONa5bRY1T1/CP7LsiCHX47QITwkRHFvwBT25SG0NAQUokgeuwVnHIXT
 xP+lCCXlFxiHQ0PXXUt+B833+VpwG0vJZEQt6S0fEazdVwFYEOdXHE1oMOIwgktpHXDFr2h
 f8PTmf94KoIgEankhuadA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ITXcNUBlelg=:i5/FQKNijGPWaG9OKPaPUT
 XFCToOpQHU/4STkCBumlP9k09MupV47e/Xa9cYKQjC6MevlCEDsodDNgk4YKB+eurCOZoLjAM
 t4qxlwekLt20QOUVu5OCcErstYm87VApEh8AP7q+0PwaV33kHQDyf5tMD9d+u0l9pLr2Q0viY
 LI2T797XGuQVnvDnHQZFk1pr3Xb8J3sF2lYnRR0WE9HukYUT+fal8N8MlkZTFvKpOPkgyjSqu
 fnd8mFVwT0VD48C5nL+lwqlZBAvjLX4lGZNWWCIuIOGGYbshlB02isWSy+NOmLQPLNvf2rQrc
 ooLbY/UgLuTTtXaBgt0CZ8gdwn4IfPnT6nxqMQHqliUOJMNx7Uj6R/VOBjSlzOA7C+BlQ4BEM
 RQByf6rg7r9gWEsy7hgtt0TOhgyg1It/mGY6hxd+2qeL0uVkcJxLuuhMZzZYesVDg56xr/a3+
 aGN4JxwDhVPfh/Z/BgIHw9wqUDNLw0biYMuwx6tg0JMRMURVamtv7qsFLG53KBW7esXBGGZlT
 eSQtwlZWczQMByOHabuQJbt9zkZwVU91EAqTOfnsDpRDYT/oYh3mXUDZziDTgQj3z0UGdJPjT
 KqCXDJUGut8tvGR5snyqqpQtcxBQE+FTc++LScRqB7Ccninq8YYTi3hleTituk5d6N2Of4huQ
 gBwVLymYWmK2g9aua8/DVtyTRZ0vrW32dLn9wC1zPVzKdYv4FGYzHtWEx9RVUMsmxd72gmRpu
 95KzvWlPzie4gvitkKX7u+U0HrKOVo50u2B4OeGDOAMU4kdKyk+8leO/XOA3ugIywnq8QtLM9
 9ATgFU5w/yhUqSFJzSLJKcGfNGlUkm7TOo1KSPdjbZQQk/hKauTiNaKDliks50E3XiygUFkcb
 od2pdRrk1LjNvP8Yx4QA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8NeVwyEtms0vcMYuTfO1j1dYJvtBiRmWI
Content-Type: multipart/mixed; boundary="9u8gWBElNj5oXgjagfT0PMGtJM1KQeKeR"

--9u8gWBElNj5oXgjagfT0PMGtJM1KQeKeR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> We have a couple of BUG_ON()'s in relocate_tree_block() that can be
> tripped if we have file system corruption.  Convert these to ASSERT()'s=

> so developers still get yelled at when they break the backref code, but=

> error out nicely for users so the whole box doesn't go down.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d0ce771a2a8d..4333ee329290 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2456,8 +2456,28 @@ static int relocate_tree_block(struct btrfs_tran=
s_handle *trans,
> =20
>  	if (root) {
>  		if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
> -			BUG_ON(node->new_bytenr);
> -			BUG_ON(!list_empty(&node->list));
> +			/*
> +			 * This block was the root block of a root, and this is
> +			 * the first time we're processing the block and thus it
> +			 * should not have had the ->new_bytenr modified and
> +			 * should have not been included on the changed list.
> +			 *
> +			 * However in the case of corruption we could have
> +			 * multiple refs pointing to the same block improperly,
> +			 * and thus we would trip over these checks.  ASSERT()
> +			 * for the developer case, because it could indicate a
> +			 * bug in the backref code, however error out for a
> +			 * normal user in the case of corruption.
> +			 */
> +			ASSERT(node->new_bytenr =3D=3D 0);
> +			ASSERT(list_empty(&node->list));
> +			if (node->new_bytenr || !list_empty(&node->list)) {
> +				btrfs_err(root->fs_info,
> +				  "bytenr %llu has improper references to it",
> +					  node->bytenr);
> +				ret =3D -EUCLEAN;
> +				goto out;
> +			}
>  			btrfs_record_root_in_trans(trans, root);
>  			root =3D root->reloc_root;
>  			node->new_bytenr =3D root->node->start;
>=20


--9u8gWBElNj5oXgjagfT0PMGtJM1KQeKeR--

--8NeVwyEtms0vcMYuTfO1j1dYJvtBiRmWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ISk4ACgkQwj2R86El
/qhyNgf9Htcs/jFp9XXUzv/aSWsmHPaGTSfmvXRi6rzUif1n2umpWI27ScIo6TNU
0EPTkeig8g+XWyLkb1LcIFquVBtJ1oQWORAApL/7P1PZjrZsPK9e2UhnQ2/hNUgj
YD7M6RzrYw/ypBkX01lNG1TL1YAOv66h3lGeH9EoU/XC+410hLkQsB5JWxahl1of
MiPiamDCJNpSiwsojZpLY1jfw28iqiN/EKL19yvXvYcwkU6gJxtyukYSpZEG4fB/
XrcDbxd2m/8cDrANZatMxpR+pRjESfzOEOF9GeLd/v9HU9cC0gpOyJNDOV32lB8e
zLljzLtkCP7MoyfvbWmernLJiezZ5g==
=MbtE
-----END PGP SIGNATURE-----

--8NeVwyEtms0vcMYuTfO1j1dYJvtBiRmWI--
