Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2104C1BDDB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgD2Nc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 09:32:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:36001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgD2Nc5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 09:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588167152;
        bh=aHsnW+3gzO8pCxyORwBO+Ihsp+HtkeIuWsCjVlZWnI8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DZ8uNnwI5rDdQnvNCKbdQoNsCK55xaFj+8TAPHlwWV707sR8shiGMzxv+Qrzb45Gw
         w1UhBLRxIj3xwQ+iPsUHJp3TOuycOAkRFx7DdYqLVGSAStoTS9Tls4pHjfMd3OUy8M
         bTgXYNJ+JU9Z40Wt8fnokn38OuZz1fzHatmOiuiY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPGRz-1joVXO2I8r-00Pfqu; Wed, 29
 Apr 2020 15:32:32 +0200
Subject: Re: [PATCH] btrfs: fix gcc-4.8 build warning
To:     Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ethanwu <ethanwu@synology.com>
Cc:     Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200429132743.1295615-1-arnd@arndb.de>
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
Message-ID: <fb79edfb-5fce-30f5-40af-cf06316c61e9@gmx.com>
Date:   Wed, 29 Apr 2020 21:32:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429132743.1295615-1-arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hGiVpMqgzQBpw32GEM0P8G7xiVUYVMVde"
X-Provags-ID: V03:K1:6Q3p/I25aT/DaKPoGA/+zWyOb+WMYiqs5U6uPmtlr7dj76bZ7+D
 BfFY+R6zKubIYMZcj2QgyVYivIUpVWn2oPIFjb3Tl2NOvJK/OoumCHgTTrm2piSN0v11TmA
 3pD7m8ZzzQWPxueevowiK5QEfWzIBDXB5GXbF2ou9R8HNfRZvQwu1Br+IhNIxLqIgriKBHx
 eB9yUtQqOPTlEISDfCRyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0PmqAXVh58=:MqZtzvLdYH8EJ8jP4uG/Uf
 U2HL3/MRlYn1s7jQZXjD1X+clDip5ANN515TUNvFo13QOTU4Uf6Xl6JC2Y2uJdZ9xSec3t7af
 m/1XcLq22K7TBei4aufh2g3nAkBmV0nClvdF30MlCz5GV6opVDsROQA8qGvdcYS5gwbpZjMRg
 xhX9JOa02pHMGADsGcWY4T8e5tccB0W4b39ZEARjhzAyOY4FY4x1WSLra4211Fp6GoZeQqjwd
 APfirAE4XpVey+YFErUV0cp8cwU+qaKywOztFUEuN9Mt4vY6JENUsGykMIboDzcqhT2rOUaqF
 l0wnWISnAx1Y7hYwyLxI0HZnuTJX29f2/puDpIHBXMDh+IuG+3uvCWWf9aTkK8OdhIywVnUXy
 xocnELtrJnsa4QQrPJtz8dsTsEryJ7kvfzW7CNKlv67PoOjqPx+qhdNTGzhEUuQOkleGOOFXw
 Qtkvm/bIpipqxRb5A4XlF9RNAHvQbQ4PRZBiwRMDHaH1RYRVDZbca90H37vATVAc+Ts04D2M9
 9LQ4GwAZ18EA+dR2HgxrQgU7ij6COHkCEyDz78DA5Kvn4ZEVM8BjLouYEIe4ILPKFNJGSaLxC
 cOmZGybblXpFHAKuhINtP9ZyDPzaoL6awEcMbZZ+60n6nIOywI6ympRGsWAxm5KMnFu0ywwkH
 bbW4W9cHOt84zIJ53GVN3emGuTP/MvQoIar9+qOlFsbOeWjBkLhohIW6e3fC18fiEc3et3ToD
 ZRKjt3QyeFZoyR5egBFNMRcFRAuskjtrs0fdk4IepzOtj+ZWwggL3heP+OJMl34RCTNvAT+e4
 t17ZiDRNCo65W+GhXQ9+M9jxmSqVnRtd4rHPH42PaRI+R469G2slqV3Kjl7UXrjjV7SKop7Jl
 1XX9E/Tsn96TpxcFBxGctDKtVv/iaf/tLor+iYTMGu4fCx13UlyjXYWQsSMOeEfRN868dkaV+
 arc2prIL2Cuci7CwZcYQVNUMYf8WJDtkU/Vj2+DknXR2+BDvXoz6qxpr02DuLW6Y0r18AAbwL
 jRrQl1IgmHEDz28aXJIf33kBPQnx0myazBeVt7Un4YxmSrqWwX7WxPPcmLrdUuo59uhTuQ0Xc
 sH2OEahzHtzd30JVlMF1p5nL2FOpmrZSNyOvgNeQrOr/ZYG5+/T3PsRD1p8EC+hoDXDoy7FDR
 nPEdwljWz5G63Tm0yPZxeEgBLICZIhbRuBmN5jibGRgayKDZm+mAXGRT7fYEFMiNtjl0nmvtF
 iQQeuUJ6uL/tJqL3P
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hGiVpMqgzQBpw32GEM0P8G7xiVUYVMVde
Content-Type: multipart/mixed; boundary="7Tnk2qS8xsife5TvIYPkRuMZifPQXojKQ"

--7Tnk2qS8xsife5TvIYPkRuMZifPQXojKQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/29 =E4=B8=8B=E5=8D=889:27, Arnd Bergmann wrote:
> Some older compilers like gcc-4.8 warn about mismatched curly
> braces in a initializer:
>=20
> fs/btrfs/backref.c: In function 'is_shared_data_backref':
> fs/btrfs/backref.c:394:9: error: missing braces around
> initializer [-Werror=3Dmissing-braces]
>   struct prelim_ref target =3D {0};
>          ^
> fs/btrfs/backref.c:394:9: error: (near initialization for
> 'target.rbnode') [-Werror=3Dmissing-braces]
>=20
> Use the GNU empty initializer extension to avoid this.
>=20
> Fixes: ed58f2e66e84 ("btrfs: backref, don't add refs from shared block =
when resolving normal backref")

OK, at least this fix is mentioning it's older gcc causing problem, and
the fix using GNU extension is also clear.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/btrfs/backref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 60a69f7c0b36..ac3c34f47b56 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -392,7 +392,7 @@ static int is_shared_data_backref(struct preftrees =
*preftrees, u64 bytenr)
>  	struct rb_node **p =3D &preftrees->direct.root.rb_root.rb_node;
>  	struct rb_node *parent =3D NULL;
>  	struct prelim_ref *ref =3D NULL;
> -	struct prelim_ref target =3D {0};
> +	struct prelim_ref target =3D {};
>  	int result;
> =20
>  	target.parent =3D bytenr;
>=20


--7Tnk2qS8xsife5TvIYPkRuMZifPQXojKQ--

--hGiVpMqgzQBpw32GEM0P8G7xiVUYVMVde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6pgecACgkQwj2R86El
/qh83Af+Mi6sxc8pKMdHYx0GySA15pJkfgTmRYbEsqBSoFhbBiowh1ahHS0oM2tY
Zk27iTPEz/Q5506fJnW+i7r/ctHmPF7JQE+xIzTS6TIWtiSuYyDs1vYXmUfC5W8m
saz/VulS5un9H08KzVzl/GrsJIW4OTTDMpQXEjJz9+DWDOuA1Lob7I/ew2RSrNHY
HDEd28yah/ryDK93cMFElZCH84aqaIxHlminqHgsYYd4etPYSMfCYPcg/wCPGlLp
tBKOHWPA22nIML8VE6rrYUS78anvW7c8Ec0uXdFyKBUFaScWfhyn0/CljP8qVIZ4
PI8OF0HuiaaETOce/6YY1QLZQWme1g==
=r/5k
-----END PGP SIGNATURE-----

--hGiVpMqgzQBpw32GEM0P8G7xiVUYVMVde--
