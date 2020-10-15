Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227F828EDB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 09:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgJOH0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 03:26:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:35705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJOH0o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 03:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602746800;
        bh=o4S9Hplqjp9OtUXRBJYNw0QLR49h3q+i/8rMA2pIzIA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d0X+kAiGcERKW7RSN76YbjcU52Dz9aOvqakmFUJDPHxR8RLggknlbBp9e9o4WdkTL
         dn6D60bJAyuUqSEtvRHcRBRKQLnoYfM8zuxhejBvQmibjpGbqL1o3NsQdtJnTAoQCn
         GCOHC0qUGKh/9756j4/d3ylzuoHOXty9W1WULmHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsYqp-1kCWV219i7-00u1Mk; Thu, 15
 Oct 2020 09:26:39 +0200
Subject: Re: [PATCH] btrfs: Use round_down while calculating start position in
 btrfs_dirty_pages()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201014145545.10878-1-rgoldwyn@suse.de>
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
Message-ID: <b4424edf-8e94-31c2-4269-d23ad6b910e4@gmx.com>
Date:   Thu, 15 Oct 2020 15:26:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014145545.10878-1-rgoldwyn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B7nc0swnnzGXVTTr2sTlLdQNgk0HnCs7m"
X-Provags-ID: V03:K1:u48O7oV+OT+7wvoO4FazoFWR55elfJ6iC68MfOPWkXvIggPoQ8Y
 Eyipm3xjLXSc/Ke+iTlnquuINDGo8zzMSVEsqgUO3tUfO5F0RaLmNkGTJc79NZcWvNYRttK
 U3p7Xh303UEYSoyMl/vbaQ/4cWELD9okzVMyBN6FRb9YI17w4udV48JgABWTwM4mYTXMw5A
 r1wJ0Weue45PQGqr2qJnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3LW5EgyGytQ=:nPZMt30ObF4ilfoWVQM1y6
 INRv76xO/nIZ33GmYPb6durSF4Xbqz4ONGWPM1dlwsc48osaD36lIS949qxLhURHYrMkkV09Z
 GgXFuNzmS/zpuqxLRyPA3cjuoNlXyR1fd1rdTERiCTbiyFgC38yQ6n2eJ1/NYt6i7Ll1DyIdW
 I8ToVVTp2Q9uLhO4seBi5PvBYRlxBHJNO/QYNaatrIyfj5QUIrC7fSrBFKUNGqgBa7/iy2Rvc
 oWqYpMb+/52jyAq0t5yfiWXGO5fk3sKShLgV2YscLvvs/npFXz9HYb6mc/vrwtMpstPKCXQm1
 6lE7dqkxta4rRY6B0CEs2jluI8XRxa1+Q5uITmahe+zKE9qeZeQWxULPToSIKZTbp7ESZ/Woz
 rSYtHlQ5jdZqa3/Br/wNTSnFCQv7XxTFvMHBo43BzwkGW/Heay1UNtlTfw7BTiGtas54eUgBU
 IoJX94iJOsS7+DZLo9ZCw4Dvx5aRYUSpmp3q5pMHYw9D4K5R3Gv2uNz7JtEtpM/qSD94Dw8g+
 N9eErClFJbb6a+Qy/XgRaG4u8JmTzEE2fBuXYPxoG3nWuqLHKBJMlsuGl6vHp9wtf+Ora5o70
 vYQl2A4n/DeZlLLhFlPfnGS/KadA14GDCwLP7LXQXmcCJPHi9STXw3ZSN0XiKB8p+l2CJ2263
 Md1VIXPG4EHvxQl8PUqWKo7ajR0dIbVRypguwL3gkyqYdzlBPMY4kKSEGJDnpdhnneb/l0ikE
 gRU03HGOonKLCSmryg0PYGf2am0Wzqv9QRJRWziEkepNbJUxh8XFVQX97GdF3Gz8wMZ+DIACO
 V99vJ8le65d5Jv/kR1YyhEg1nojwJ3BZApr/kEHomrohbVTjTYL66r9p4tX7Qq34uF+oIkAAG
 FYGcqjUKIhxxH5LQHEbg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B7nc0swnnzGXVTTr2sTlLdQNgk0HnCs7m
Content-Type: multipart/mixed; boundary="XiMurL57DFmFggIQPvJwmXnuLLVy2iaWt"

--XiMurL57DFmFggIQPvJwmXnuLLVy2iaWt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/14 =E4=B8=8B=E5=8D=8810:55, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>=20
> round_down looks prettier than the bit mask operations.
>=20
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0ff659455b1e..6e52e2360d8e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -514,7 +514,7 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, st=
ruct page **pages,
>  	loff_t isize =3D i_size_read(&inode->vfs_inode);
>  	unsigned int extra_bits =3D 0;
> =20
> -	start_pos =3D pos & ~((u64) fs_info->sectorsize - 1);
> +	start_pos =3D round_down(pos, fs_info->sectorsize);
>  	num_bytes =3D round_up(write_bytes + pos - start_pos,
>  			     fs_info->sectorsize);
> =20
>=20


--XiMurL57DFmFggIQPvJwmXnuLLVy2iaWt--

--B7nc0swnnzGXVTTr2sTlLdQNgk0HnCs7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+H+asACgkQwj2R86El
/qiJxAf+LAMxlNTYzRLKOfx6H9dNEQSbh1/jMHfYWqVHTKuXyxP/9Oq9Z8sUjB74
TMEOIjIb09dn22NXr4mGx6q9e/zsqx6dXtbG/l+GjayNNLO7wwgLK4+BJBeBIVLy
Bca2NJKAhXXetGLxoKgpqlmIf2AsjYCWhS4J2492ra6oWRV0niZOq4mM518Emb6z
hWBk8USywJWHKSvVZ6p+r2ruHrmwz2bxoFuCvVZnym7qVdJNO/Kt2t+fBZtMejUf
Av7NhTsXj0GJbl9ZphqdpscDeP3gqaisvpvGTno+JwwGWm2twL1AayRH2SawaH4b
CoeuBv52AN9+e/GOJv63x9h72N+kxg==
=2rxC
-----END PGP SIGNATURE-----

--B7nc0swnnzGXVTTr2sTlLdQNgk0HnCs7m--
