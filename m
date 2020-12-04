Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC72CE928
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgLDIDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 03:03:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:45329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgLDIDi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 03:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607068923;
        bh=5b8aCZH67zsj3GjPJt202B26um0LyohvWI1JM9UT+gE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AhPZs8IIvqU2/V/gp5jTQbgW23wT4uEbJvekLUR/iPYBVMNYe0Fquphp021EidzaG
         B7OdmI+YWpJSaLqhiA2KpAu3qZE+eqCUdmGHNx7zogEjJ+eQIof8vmeb0Gf6qUltUx
         x5gbqaRm0K/vRGUGRDrnyaydnO3WmXrvdt5Vi5JQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1kgKux2PPF-00V8CG; Fri, 04
 Dec 2020 09:02:03 +0100
Subject: Re: [PATCH v4 03/53] btrfs: modify the new_root highest_objectid
 under a ref count
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1607019557.git.josef@toxicpanda.com>
 <ed37cf06762e40be2fcebc9359b1c063b32afef4.1607019557.git.josef@toxicpanda.com>
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
Message-ID: <448e6b22-1a44-a3ac-bf91-632bd8dc9206@gmx.com>
Date:   Fri, 4 Dec 2020 16:01:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ed37cf06762e40be2fcebc9359b1c063b32afef4.1607019557.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VIWaoETrIJ4VmI8vNyGgFQCSeH1PtbXe8"
X-Provags-ID: V03:K1:N7Lb5eMhDjYpMyLu6YmfvfDGP6X+J3zq7aNRfzeN9EfBlL7P6u6
 dWZnHpgcKu4om37T9RMLK5icyIEuhsTPTXLf1p1SS053FNugRotrT1lXZEgreVNR0ReOEuw
 JixZAWLuKY717+yt9pXUM7W5FlWqjZXafDWLvur+CRJ61NESxwBUCj7sZ+wNjvhiflb84so
 5pTWMv4CQb8UdbpNCvkDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eoP94QkSPB8=:tg0IpNRmHNgy+6LHisgQX7
 h17tH3E66947YbG36Hq//Bdm3ySClQqqBchPvpgfc6N+FLT3rUssDg7rA9RNpPvmM7r1254Qk
 CgbYPfzxHYLlIm9wMJKfbmOAr6Lt7mszY/wunxw0aQpsxXCtcemvNZPdm1YNN/ZcLiNJYpE9V
 r9v0UGVPXksQimmkruWMqlV96yxxKf86IHja2ViewXbKAUc/mXprQV4658G7jxd/r1vvL/3Y2
 1FlYm7IZtQE5QqipKkqsDv1ePV7dzX6WHjBZ9xj/wiE8faT764I8zaviC5hLbQzFyKHmGu7k0
 OaQyK24dFQw8c89J/m6LVgrgbESy/l4u4oqDymxEL09c8ZBPQh7ThO5dxJHEKyVLMIk2wdGl2
 +ir44joDzQU0lNqMccgTKXWgfyI50L8N8uCEVg27cOjXWGEdRS+B/Us+QhmHfcIomIYIT0gOo
 RHGYmYrpyU5R8r5gS840IIHCmJAeYywjscgEdcVbQyEXEmA0aYKUZz23MRaBvZU7M1rVOZtx5
 vfxwNJibK9Pn9oYQEpnh5+fiZT+zFeXNJIMJ2fkGu1Oo/vHX6PACJJa/OlUAOa0+p7JpRVuOu
 cHtM0Pk877V5HQDAzuZ9B0RtFE/19emujamrMA++a5sJvNtVVtasGyoPYeLvILjJdpy+HUHcQ
 Py2uYIctxWavLHbSiRN+9c0obHJtu+gtFH61/tIbEfQUvyyST63oHHTopoS6ut9wKi2ia3wtf
 2E6uqBWD7r+6BfPbnfZ3pPDJ/vr5tAaZ4qXU/pAf0JI86RMuOlYzgRvHc1ZpecpJIzc/3dMMy
 qcC+QCVxaXvOdyy6q73s2Az+RUakRyplcnI1tb9fPjXIh7b2b7DLHQnJvxNjCItk7rIMtnkNR
 +ZMIC/PGIhQ0S/Rcxufg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VIWaoETrIJ4VmI8vNyGgFQCSeH1PtbXe8
Content-Type: multipart/mixed; boundary="EPFQjxa4fOLb12s1khC9xdtkbZKEKkdcz"

--EPFQjxa4fOLb12s1khC9xdtkbZKEKkdcz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/4 =E4=B8=8A=E5=8D=882:22, Josef Bacik wrote:
> Qu pointed out a bug in one of my error handling patches, which made me=

> notice that we modify the new_root->highest_objectid _after_ we've
> dropped the ref to the new_root.  This could lead to a possible UAF, fi=
x
> this by modifying the ->highest_objectid before we drop our reference t=
o
> the new_root.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But found something to cleanup in the future, inlined below.
> ---
>  fs/btrfs/ioctl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 703212ff50a5..f240beed4739 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -717,6 +717,12 @@ static noinline int create_subvol(struct inode *di=
r,
>  	btrfs_record_root_in_trans(trans, new_root);
> =20
>  	ret =3D btrfs_create_subvol_root(trans, new_root, root, new_dirid);

Firstly, btrfs_create_subvol_root() is only called here once, and
new_dirid is always a fixed value, BTRFS_FIRST_FREE_OBJECTID.

This means, we don't need the parameter at all.

> +	if (!ret) {
> +		mutex_lock(&new_root->objectid_mutex);
> +		new_root->highest_objectid =3D new_dirid;
> +		mutex_unlock(&nBut still find something suspicious for the existing =
naming, inlined below.ew_root->objectid_mutex);
> +	}
> +

Secondly, new_root is a new subvolume root which just get allocated.
It looks more sane to initialize the highest_objectid inside
btrfs_get_root_ref() for new root.

This should reduce the chance to hit such use-after-free bug completely.

Thanks,
Qu
>  	btrfs_put_root(new_root);
>  	if (ret) {
>  		/* We potentially lose an unused inode item here */
> @@ -724,10 +730,6 @@ static noinline int create_subvol(struct inode *di=
r,
>  		goto fail;
>  	}
> =20
> -	mutex_lock(&new_root->objectid_mutex);
> -	new_root->highest_objectid =3D new_dirid;
> -	mutex_unlock(&new_root->objectid_mutex);
> -
>  	/*
>  	 * insert the directory item
>  	 */
>=20


--EPFQjxa4fOLb12s1khC9xdtkbZKEKkdcz--

--VIWaoETrIJ4VmI8vNyGgFQCSeH1PtbXe8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/J7PUACgkQwj2R86El
/qh+UAgAgNyLCRC6RTxqyvMT1pRHSUuUdS2WNGTIk8V2e8ykF/L/bFsVyvEfmLHt
iKhJARHWqeTvfRUXRWmDgx281ZvqZlxnxSslhlA0MK5Mv7EbD9B7PQOQaED/yCDE
kmYYa+hTIvl311JpT9h/+LtyTlXqKMaA3WQsUgVGUnTAWLb3T4OjXr8cXYZp8gDk
EymNhI5GcrknQ/c29b1IN/SG9QHLNhG5nSeoqK1O/SqAugujDLu7GY5VaAuh2r+1
5uiEIbaZZzbdSz6gIX/Fe79wr3bHg0Wjp6hX6TOjD8KRkfszBzA9E7/5yqg/7VZ5
ZYqiH8Iede5DTHR1kb8CTLr8T4KH0g==
=yAH3
-----END PGP SIGNATURE-----

--VIWaoETrIJ4VmI8vNyGgFQCSeH1PtbXe8--
