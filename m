Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3112CCE63
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgLCFPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:15:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:49131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgLCFPv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606972455;
        bh=ukU55AujZJvtozuqQuYW96qCcbDDbocoOCmFtQHj1Mo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=cgjGnsJcr9T6Q9+AnCpIvivTKEh137uuzDf911dqgJURVk+momWOlGp4RmbKEOgsE
         9c8tsn7WRHXrYCDLTLIBt7GUrk6S73J0cGJW9p4OIrP6u4U953IzVhcDXo4VWwLLTM
         o6l2gQ6NRlSAJrxyw6eXp/9qFdPawowQb8qkACxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUnK-1juW603VYY-00rW2X; Thu, 03
 Dec 2020 06:14:15 +0100
Subject: Re: [PATCH v3 40/54] btrfs: handle errors in reference count
 manipulation in replace_path
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <25314fe734d56e1a4fc924e7a5f923ce01fed88d.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <a04ddfd9-7242-5dfd-58c4-9d065f745e48@gmx.com>
Date:   Thu, 3 Dec 2020 13:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <25314fe734d56e1a4fc924e7a5f923ce01fed88d.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ywhTzDbvjd2g72SR4OYzF50hQRRPVLZyI"
X-Provags-ID: V03:K1:JoOSWugdf3vrAn7KmDqOF4ww1KWoYiWxdcS9k/8WZhV3sCkIsi0
 z6Tb7GJXTzs7BEip4xxO8Bl0rQjHJ922RT9VxDIbluEq+ssjggzZjGYhDt1YvEeSz2eD8yp
 FprpN/DdgeOOI3rqcMoGk0QsW1s8OnuOHv5CAO/TZHTMRw5rrLCqJuNzzA4gkSutB9TDA+5
 vfvE/XYlniHoKLVtG/K7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+nh36QwstRg=:tWb+JSaykkpzI6Qbc0xU2M
 v7Kqod7ylaJ0U6l+unhRgy0tG5ENW2FyoLmeiaUrIBkZSeV7mUErqLoSpyp2LMwQhKqXa2yi1
 LtXx2e1cubMZ6ZSdfhIWRmzWNp8Sjo9RMNQrdh3pGT7/UVNHyLhjreCAULl01dvXdtn4Piqxc
 la+nmNg6QW0/59Ljx4UlMY0Y4HL3r09DHQdgQYIWqvEJ1m4ryIte4RXRIACRTjo4Ugd8kFc+0
 V0EWdQmuCJ9sTpVh3xLJbF3RmvcVLOeJl86XBbVbDhUE98Wo7yDoBxbJ9oPfuwW+zCECsSFAb
 Iar/mZSojz0t5/LiKClHqdO8k8pAdKVV9GgMwGuqd/qll3Gt2aUrOxxDg2J+j/BR6FKp2d5B4
 +5cKUiBGHtD51lDf1G7iZIw3c+bvD9kUn763ElKI65eWeLJSIBqiF/J1PSeCxxqF6u3648K6t
 Fe3cDX/kxoKp3FhA1B42QBTW8zEi7qwU+FiA730v8zWi1J0imLAPW0mi/SValeIVAD3Da0Kuw
 HGuNeIRlZxVLwij7LAL++7DmynCU/27IMZxqEpc22j0NLW4xXcGDICcIc+vzDjvgvli7qSmG5
 x1xh32YjEb9zDFRun/250SthTrkgrrtkIXrWnnUAjKFznMe+fgGAoz8wgtLRrn2zvuj+Vqs+3
 XFm9Q0QSjzSHizw+eGQyBSFqTeN0aRSNpbOC2lU4Udh0p4r/N6Gt1LXlD83XtaNhUbsc5Xyx3
 YGxv7AOpUT/RflAr2rkXtJJzkzuxgEtfnsFzvTm7v3oVDxp4L/BN8VSdcPRhpy9H3v5O7tJK8
 nuI/+/04XOPYQLRKisYDG0WcLparVDXDN/XFPWvePlUZQxKFj9r4VNVjYE3bxy2CWJKAv9VGm
 kmfMgdz1+MXRr8oy5SJA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ywhTzDbvjd2g72SR4OYzF50hQRRPVLZyI
Content-Type: multipart/mixed; boundary="wS1tlQEQNrFqjmqzu5IioRCTVai4yLHz0"

--wS1tlQEQNrFqjmqzu5IioRCTVai4yLHz0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> If any of the reference count manipulation stuff fails in replace_path
> we need to abort the transaction, as we've modified the blocks already.=

> We can simply break at this point and everything will be cleaned up.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8c407ebc5500..ef33b89e352e 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1355,27 +1355,39 @@ int replace_path(struct btrfs_trans_handle *tra=
ns, struct reloc_control *rc,
>  		ref.skip_qgroup =3D true;
>  		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
>  		ret =3D btrfs_inc_extent_ref(trans, &ref);
> -		BUG_ON(ret);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			break;
> +		}
>  		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
>  				       blocksize, 0);
>  		ref.skip_qgroup =3D true;
>  		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
>  		ret =3D btrfs_inc_extent_ref(trans, &ref);
> -		BUG_ON(ret);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			break;
> +		}
> =20
>  		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
>  				       blocksize, path->nodes[level]->start);
>  		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
>  		ref.skip_qgroup =3D true;
>  		ret =3D btrfs_free_extent(trans, &ref);
> -		BUG_ON(ret);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			break;
> +		}
> =20
>  		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
>  				       blocksize, 0);
>  		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
>  		ref.skip_qgroup =3D true;
>  		ret =3D btrfs_free_extent(trans, &ref);
> -		BUG_ON(ret);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			break;
> +		}
> =20
>  		btrfs_unlock_up_safe(path, 0);
> =20
>=20


--wS1tlQEQNrFqjmqzu5IioRCTVai4yLHz0--

--ywhTzDbvjd2g72SR4OYzF50hQRRPVLZyI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IdCMACgkQwj2R86El
/qjS6wgAip8TRVbTU5MJSjNilI71PUWDO4tWRbcmRxNklJAxHG6pghTXYXa2wvek
Gt2eX1tOaEdPxmxjEPs/eweyuVcPuUAAEwln95VOjLqhg7vaR/5RSkywKEskT8VW
x2bUbKKHt8EHRonRxWlzAoBCQrymPIPgjhdnUjVHbCf4oVpbCUIcZw73gOGTvUyR
66Z6MtMqK6jovkR1C1f/7vcmh8LqgfeMAYgu9/9hkBGnvnWNrS/CIer4O04rcuce
ZOPG2Atz6PuuEVLlkJNp9GpB/stnYp6JNUeJkKtkD2JRnGwIiHxMQhqTBWNNcnC7
2zXt+2C3NlLX9nauyrptsIHm/PtBZQ==
=Y2db
-----END PGP SIGNATURE-----

--ywhTzDbvjd2g72SR4OYzF50hQRRPVLZyI--
