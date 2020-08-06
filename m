Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31AC23D724
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Aug 2020 09:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHFHEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Aug 2020 03:04:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:56799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgHFHEI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Aug 2020 03:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596697439;
        bh=x0RkFEYjyiGg3VEmiwU1JB5iOp+ulzqMAgTJ3hgJf9w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TZllDJ6ut+Mrwf1+gILiYH38WGE7cTJwEaWodUCAG7ZQJ38jdjvX/KZCxA0Kppi8A
         jxXvmE25OvrC/aGhsnfNighcVQ7oqivlTy3zHbpgxC/5MxX0kmV09qaPJQKCyr2mTJ
         vMfdxXVGv+DG8buWTkZNZHxpKCh9nqNqUUjZweLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNtP-1kSQRW05VN-00lkc3; Thu, 06
 Aug 2020 09:03:59 +0200
Subject: Re: [PATCH] btrfs: backref: this patch fixes a null pointer
 dereference bug.
To:     Boleyn Su <boleynsu@google.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Boleyn Su <boleyn.su@gmail.com>, linux-btrfs@vger.kernel.org
References: <20200806063144.2119712-1-boleynsu@google.com>
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
Message-ID: <13d20404-ef74-bb04-d206-086207561464@gmx.com>
Date:   Thu, 6 Aug 2020 15:03:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806063144.2119712-1-boleynsu@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gYDDne2CJ7im3gn6sorvpsx0QIuV1DO9T"
X-Provags-ID: V03:K1:bQM+SAFjn8Nj9UqSQQzvtsMBlLnt1vt+S8bCW8e4m13N+vza7/8
 62J53o6mCGT94TEYoQBdszqYszjAUJe1c+N5v7Bp9kaS2Rnk7zZVYAe7yecUseer6tTitqw
 7/UYVG2Twgpi4ZohZyq7EOemuxk6ScGjnVomoHk57uU1eUrNMvxDGviaedHumBwGMcdCjhX
 YosKZuwU91vopIz88Nwyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lfj7HnkOu54=:J1sMHWdlVDqoYtQAJ9XLEN
 z5m0dMwNQOyj7k6740zwH7ugUHcrjqy08A3vBcpk2dw8jVKogNo5S83yHAoW59PR+5StxVvXD
 SNqR3d0wqmZcCkp9ZS56jAY6mEzYMrha1f9OFs9aOKHHFxH0RAxfBLzCbL1jMvIRjueCR1osw
 CmE4/7j0XSNn7hdxTw0KI0G3yp75tZYnmfEjL5mW+5PEwDqqymvVTM1PotDNN7nGnLTgf7nYI
 d3MUx7WWfJzt2UWp8gm7sNt44VZmTFJgW+OlVUZX29LiXM0K0tLNoG4P0G8kccPv9ylbeZlFl
 TNAwZzuJ1wnTrdNcwSi5Y5nlPV1NNWrDhLogqvzuFDHznSyTk6l++F9GYu8IPRPf2SrQHcIrK
 4iO0tjg3ko/nDH6rSg3UBGOdyIymNJgb0FJkvmXmxlIotNixgt+xp36Rd7k7I7nzEZnQw6IrV
 UmCaTjvBWYeca/q6T+nju1alMMavs7fJV8R6YUIsBHFn8ie2oW0QCJEvGGtlTK+jrthZNfUao
 4iEmKnTo1Rv8zb/wkd+CtpLiWwaOKI9Uv4TZVW0smMaWBE6iGJ6Bpt5sdcZnrs2cFNCvM6TBW
 Jy0oDzAm7EDihFqEZhAqE9rZqC936SQlW89imGJ7UeVqoHgvKXpvttKRsr1CFQrTU1yAMNcO9
 8pGSUAAsecNddR/AByeHtp8Ba+0CT/mdU+80jNlVP5gybEoruVr6XBkaL2147krXM1fctcMU7
 +wnYHVPdvJnydzNm8oFV1gikPaajdbfHUWhfNMvD/B63TAf4OwEft0GcrjOr/oj+/Q+YjX06+
 S5Vg1zlslYEC6yMgCA2HRwluaWAywBft4OqSjnfTCFzZ7S8JiLwTzroqr4qB1EbAwGNuW9YH1
 ED7eKQ+wzjcDBeYcs+0Y3aN/1blaXrPrHlUBBseVuw/OlAwv07NGjJM6DgqfA15iLt7MDVi/w
 3p7ns85heRkzSHCbpz+zFPq/xxoxoCoyphKO2jaw6Q7kPdtWNCRg0e6vcbZF7W622A2Y46zUi
 mmOcSYMe7QDNiUXFqqbeOwR2/j0+YrnKw6/i8iYx1iFLAGHEzRD/fg6y27HnjYGhxEZlDgisJ
 k68tPG2iQTE9o/Sc4IN0UPt5iDXIfer18q9AGWWqrHorhufsA3n1l270RJW8TtBuQ4tzhJFqH
 7Tt58F6NxW8bFxiL8hJqP/v4WBdcVpxiTUDfu9U+6ypwqNSekTOaZkpgwQD0IUJyzqNl3MSDs
 ulhPDWIRquiVLD0xiW4vWGcSqhkYpsJv+a0xrjg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gYDDne2CJ7im3gn6sorvpsx0QIuV1DO9T
Content-Type: multipart/mixed; boundary="6ea43cgh1rPLxZbMdvYTXEsk0JKNHg5Ma"

--6ea43cgh1rPLxZbMdvYTXEsk0JKNHg5Ma
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/6 =E4=B8=8B=E5=8D=882:31, Boleyn Su wrote:
> The `if (!ret)` check will always be false and it may result in ret->pa=
th
> being dereferenced while it is a null pointer.
>=20
> Fixes: a37f232b7b65 ("btrfs: backref: introduce the skeleton of btrfs_b=
ackref_iter")
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Boleyn Su <boleyn.su@gmail.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Boleyn Su <boleynsu@google.com>

Nice catch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/backref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index ea10f7bc9..ea1c28ccb 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2303,7 +2303,7 @@ struct btrfs_backref_iter *btrfs_backref_iter_all=
oc(
>  		return NULL;
> =20
>  	ret->path =3D btrfs_alloc_path();
> -	if (!ret) {
> +	if (!ret->path) {
>  		kfree(ret);
>  		return NULL;
>  	}
>=20


--6ea43cgh1rPLxZbMdvYTXEsk0JKNHg5Ma--

--gYDDne2CJ7im3gn6sorvpsx0QIuV1DO9T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8rq1QACgkQwj2R86El
/qjgeQgAjNQl20YiMxcerr25UitasyvpYh2nPrZb4GyGeGuLwOl0XH7vGmVJAfD9
iA7at6tDfz4zreIIxGdKLoBaqqZwtTTeCx29uu1geEYsxRM5xqcIX7JnyzyWS0dh
Tv2XmZby+Xw759DgRgZBXnKCPgViytCv0SJm/5I0kM5hOVdOgoVd2vxKvd4qYXYV
9KMIJUHWQh5l6iY+joehsqPzESG2ezYwlS/71rDsXrk+iS/XiAyIVrK7KZdZgKet
QVZ4vAl6RraGLTmZUsJGPXZmAP2htxo+wwhGels9c4/Ue55O31eqIQQ83lElp3Xi
rBz9hY+dUTVmkpx/LO6Zf+ETRzR83w==
=Mm4V
-----END PGP SIGNATURE-----

--gYDDne2CJ7im3gn6sorvpsx0QIuV1DO9T--
