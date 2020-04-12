Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638701A5BB3
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Apr 2020 02:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgDLAwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Apr 2020 20:52:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:50097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgDLAwc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 20:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586652735;
        bh=o7WH1HuElSf495BU72Ulf3dSSlN3P/CxizUUhDu1V5w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lt+jpjBvbMH8JgxnWBCdymH+IZ9kPxVLAGhhcy8d8tTnfzN4GG03CyMgP2ubqqDQ/
         0zOeY0FWh1pbMVw/5+WPSYQrmgaJS15DBO2yVEcdDYok9+uUI3hXxQQyiurLJnGoQb
         LL6smlX1Ydr6RATE7mIuJ182AC08i15n876HlnW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6ux-1iugfF0xBb-00pai2; Sun, 12
 Apr 2020 02:52:14 +0200
Subject: Re: [PATCH] btrfs: Fix backref.c selftest compilation warning
To:     Tang Bin <tangbin@cmss.chinamobile.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200411154915.9408-1-tangbin@cmss.chinamobile.com>
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
Message-ID: <ea85377e-4648-c174-2827-53173587777c@gmx.com>
Date:   Sun, 12 Apr 2020 08:52:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200411154915.9408-1-tangbin@cmss.chinamobile.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JmAtQApbs3a74LvrlYSsuQtc1n76tUtoa"
X-Provags-ID: V03:K1:EFmFHqYGjwVLQEVxPBAN0xWzo0Ia4TCvtkrQv01D+it+9f+dOr5
 k72fw9EWqI5dD/ZtcX6/Ey01XxiQUbGwobeGTPTsU2+Px7Phvc2eg8+4OIG7TvJ+f0vEUB3
 7CdQgJYhH44rky2+IxzlJx3dU6cKpDro2NkPlOdRdbEW1UdIu1HsZWnel8XVyISG4gHRGnc
 zHD/frxlfqjTo6TZRAe+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WDJ1sXrb4Oo=:8faP7IqMcpy7H4WTWSOWH2
 2KRwRUe+kIozwYDifoQWw4G6rObSuBAnShBWShWxQdGUCBfpM5MhHh60WOZGBMSBW4JGK3ePc
 PKzsIoXiM3KuBhHCytg+Ik9Au2WOAkZGqjpYJMJ9RmTFGJW/6f+j96KWB7E86OSitK05Bj7ya
 1h7fzAc8fbWRoOsuKFRR2HmFnJwKXMrpbDSQWU+LRW9x1TcOHJ9az+KvqHEl2tCnEWiKv0KAk
 M/ANCf/YlnbI1J+hCl2BM1karfo60nKlNUY6pM5g7KyCsjynRWq5ki3yZ3p6dAFOLUw8feqIg
 5bf2kTyoKJAEtVWns9jZxF0xOFQJUzRgp9ueZdLfY/wVBY4SlDnAveW2Rj47UJLOaxJAYKICv
 m471CyliOiIg0tc1cBUEjIyfAn4QPCWrE7wZGj5w1N904yfhY6k8De4q+6GPW8neLpZ1b73tq
 afm6o56cLt7nk48HAHgDc+Gbanb1YT9S50ENlAVvmz0HJXKwCuOxSfw3u1BWw/690TAVgz4X4
 xJ6TTgmQyQQtQC5MwV5Ch792o1wdIOAmc1RuqcZnS7OJ46jltHWfTd6MokX69lSdzYmefaHna
 urHlI3kcje8Y48zQbLy4kkr0ElEtHsyMS0dbTQrNc1o+zb6KmDN5hwlv2U8uGEEyWkRd0+xUy
 KsxVurRJrSKPKF1uXUcPT1mh6r+dp5+cSGpO18Fd5JxMPIVeeUTo+5kP++ySBHmdRbFSv8kWg
 SEeNkyrLbkzQ5GwonbbVOamF2Ax+P8tBzcWEO5RgISK4v+i34zbhbt+A+i/5iAJizXXPv8yNe
 GhF694pBXiM+mhFAWF4r+GQMzZ0of4Adxy5uo5wi/dmi06wlMsydWNxvcipVS2KijB6ALoOGJ
 Mq0Kz6UPqAZUzRixnDFJbdxk+Epm6JQDsTPhalCucV6Zlj1+hxJU2YSmm2FGQOO2Bj7INAuqk
 UueqUEWSgLY+foou/Nu0ED1OUy3OuE1OgQShY0Xlk9KIZKJmGbrMWjkLDtbO/iCTINtoTL1ag
 wuAszMfzSFCrcfSZN3ccZn5O9URAPJ9o+BJgz1jPd8QQaUeOhXPVbQHzXRdrnZ+NCn/WOZg/x
 mQM9CbguIZbBQ+264X22wIVjgWiKim9HKIFLXmTh/By5idAERSf/Z+mDwRcGj5YN4BeVUXqyD
 3JCPLdbqZUhjBdJUPwM2IKh8UNuN5PEHwPIFqRVdgvYfqLwbGzCTXCpjsefMRMIMch5Kjg5pn
 9p8YIpf/AHr1NSm2f
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JmAtQApbs3a74LvrlYSsuQtc1n76tUtoa
Content-Type: multipart/mixed; boundary="cZQ9m8lO2FSKMJuBptDaAEhFbTjOKb6CE"

--cZQ9m8lO2FSKMJuBptDaAEhFbTjOKb6CE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/11 =E4=B8=8B=E5=8D=8811:49, Tang Bin wrote:
> Fix missing braces compilation warning in the ARM
> compiler environment:
>     fs/btrfs/backref.c: In function =E2=80=98is_shared_data_backref=E2=80=
=99:
>     fs/btrfs/backref.c:394:9: warning: missing braces around initialize=
r [-Wmissing-braces]
>       struct prelim_ref target =3D {0};
>     fs/btrfs/backref.c:394:9: warning: (near initialization for =E2=80=98=
target.rbnode=E2=80=99) [-Wmissing-braces]

GCC version please.

It looks like you're using an older GCC, as it's pretty common certain
prebuild tool chain is still using outdated GCC.

In my environment with GCC 9.2.0 natively (on aarch64) it's completely fi=
ne.
Thus personally I recommend to build your own tool chain using
buildroot, or run it natively, other than rely on prebuilt one.

>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> ---
>  fs/btrfs/backref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 9c380e7..0cc0257 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -391,7 +391,7 @@ static int is_shared_data_backref(struct preftrees =
*preftrees, u64 bytenr)
>  	struct rb_node **p =3D &preftrees->direct.root.rb_root.rb_node;
>  	struct rb_node *parent =3D NULL;
>  	struct prelim_ref *ref =3D NULL;
> -	struct prelim_ref target =3D {0};
> +	struct prelim_ref target =3D {};

In fact your fix could cause problem, as the original code is
initializing all members to 0, but now it's uninitialized.

You need to locate the root cause other than blindly follow the warning.

Thanks,
Qu

>  	int result;
> =20
>  	target.parent =3D bytenr;
>=20


--cZQ9m8lO2FSKMJuBptDaAEhFbTjOKb6CE--

--JmAtQApbs3a74LvrlYSsuQtc1n76tUtoa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6SZjgACgkQwj2R86El
/qgb7gf+KRnz+69MoTyVt3+9GTehkw6oW5whqntVrLgzBOyKQV1pbkna6AQK3IIX
m1PmkgUgNbuc+mByvn80vv4G9gFo+zF1jOfRSfX41fyVrkVYe8K1hm4Vpc3ltvea
0DLauT3bKpoHcNzU+Ugak+7FKyzO9DxbGlggbpOrgXIeVLtep/+iNBzD9TBYMp+r
Ta1N0onPhwSDW6aGtoGjOjjZGssjr10hfiSnVHC33C3TpFLL5Vg27UegXoTVgha8
lsnU1kOeWSe3FUPddwioxQ2wVFDBfIqoWJVnBgEhO7Zfx+N4DMYBAbk0X8kkc4S1
XS/85ih0CvYrOuqCkWz+5niFGdI1FA==
=bMKi
-----END PGP SIGNATURE-----

--JmAtQApbs3a74LvrlYSsuQtc1n76tUtoa--
