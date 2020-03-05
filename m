Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1A17A423
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 12:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCELYw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 06:24:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:56457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCELYv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 06:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583407487;
        bh=mm0sDbhcJ7D8sm3fsdgSe6SxNZhlj7n/A5Ui+CDyU5o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=h5Ed7PK7RyQNa0hMGX92jka6rbBjZ1q1cUwJ2yC+reM8LbgeL6BUmcYJtR5uvkF1u
         fiBd2VHUWAPrwjSDxNvCGxoYxYoLCDXfI+K4OTGO8lj2TD0Q0x2QIcD73FAIryUFJ2
         tkD6+N5VoHpWqgB30YfVG/JuyT/MCT6lXSrAZ+qM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpDJd-1jib7i3mP9-00qg42; Thu, 05
 Mar 2020 12:24:46 +0100
Subject: Re: [PATCH 2/8] btrfs: do not init a reloc root if we aren't
 relocating
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-3-josef@toxicpanda.com>
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
Message-ID: <c6b97399-b367-6bbf-9424-00c10c582ace@gmx.com>
Date:   Thu, 5 Mar 2020 19:24:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304161830.2360-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aZDQwJvhaQMovnWjSQkpGiySDGg9Vw0yM"
X-Provags-ID: V03:K1:Reox2nw4W6Ym9Ga1/JYwK7dLtymR1BJStNGFgPa3vKfh18UzMGo
 WbsqhVUI8X5cAIgy/bULKJPYTF9+len21xU9ImtboqurkNdOyItfwmmKECi4PwLCgctfd6q
 Zga3gf5mK43iHEiz1QQiWC9JlbWSMtWQn1fJWeM+TxY+lC5K+vSZAhEPH0y7rKkAuIfdVSn
 kgyWYwGnyLt90dcBNQ2yQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iKrd/6a+aIg=:2n2BvLItDT9jTYpsCxIAhy
 WUTbuosEvCYgIqyqbfkWaw0ofE2Igm4PdCnjm07BYCoiPkyLiatcpZu2J/hCL/pmVCfNEUXli
 iegxH+0dkMV2hM0B89/g4Otnq+vtbWlJIvE05G9fZQ6/R33WrP88mMS7WytYLjOG7O81Q3K3Q
 oUB4EjrAlyyYeWKCTYwd8vZ2Aa1DayNsBRqZeI0nGuNF0ttrzhJ88InZf3THBWJiHMUV3+ufz
 239qpVM6AESLrXPkvILPWCcSANCGh50bVLHeuX/K39Mj5mNTOaBzbXx8yYo357gJVlW9CBuLb
 ftPHBX4q3nItKHtRpSfHbrsYAt90cKjl/+zIIH6CXQjPO4VgbeBmpnUDJCR1+2QzFarghzvmA
 zCPl99wpCC+9sySW/sAtmqGpO7ho4iBkzij8rBqtoUqlDZlqc0gD0w4aKObslp0b91IX9vFZu
 jxbGWIKx86DOuKUXGhWZyJ9xg6Mq/s6LknW8ir8YLjvl5IvnHTplv/OeXcZ+UsBy5eEHwkv60
 6Hwgx2b9fdkDOS0fehRUs6Y35fcD9W+WCCFaoaPQPCY2EHWPRbIudqJsf4jdJ80ksH0eRw9+n
 rHxvfCB6IZUTMW+NRrPK0fqnVdwIJ2Ko+1BCD0X2uAWeJ3lfWuKVdjTAqwGmpEhpkoMVBA7pc
 wTh91TDLMnTRBTtWrJiai05aEOJmRRC9VRMXm95ELKH8JHVTCQjc4KYhG4nHbMdmxrwJZSFan
 fPeSkWflC/Y983UH+ag5RZQQ2XUidejxROUIHKcHL6bGtEpdFgL4GbJ33slU9v08mSDOPFOem
 JzW66YuPvu6Fr/l6o7tJbc+aRHIvc9QYAnYTDv4QWeQBNgYPAgJo8C1ObcIbpXNST0opsRXVs
 DO/OC4BzM7ThRYn/8jZ/JN/x2Vp5KuXaV6eviBZmpA92Ww61oqMLPOtsJsdiUH7WOuH4iozj9
 KKYWRpr9t7KWVEtLj9/C744eCRqCAKTib3na+2DiX43mAVE2MRxtPV4YkiWw2vYWb8doE8pZl
 hV+r9JGn42Dl3elHLIiQFzK8/GLqqm6iecvpo4yPMNKJWNDvvvk4/rJG8hczx9ZL/TopGhE5K
 XpeL8gBOz7IYPHOHv4+ezyzhaJAfyAXeGfW7YOh/8n44kENLGkn88hm4HiKx5IR1t8u1L0pWV
 xzdJRNAyRrXD6S3SBX43McR4LlONtdZZzTtm3M42oDasQlWVDxOtZXWJqoqmbG+3gz0edZBzd
 qR+ewJZ6H3Hg+EqLr
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aZDQwJvhaQMovnWjSQkpGiySDGg9Vw0yM
Content-Type: multipart/mixed; boundary="4fKFU4OlRmlDEE8OYNFpTJhGQlltidpPJ"

--4fKFU4OlRmlDEE8OYNFpTJhGQlltidpPJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/5 =E4=B8=8A=E5=8D=8812:18, Josef Bacik wrote:
> We previously were checking if the root had a dead root before accessin=
g
> root->reloc_root in order to avoid a UAF type bug.  However this
> scenario happens after we've unset the reloc control, so we would have
> been saved if we'd simply checked for fs_info->reloc_control.  At this
> point during relocation we no longer need to be creating new reloc
> roots, so simply move this check above the reloc_root checks to avoid
> any future races and confusion.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Right, for btrfs_init_reloc_root() checking rc before accessing root is
fine.

So,

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although other location, like btrfs_reloc_post_snapshot() still needs
such check, as we have a window where just merged reloc roots but not
yet unset the reloc control.

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 507361e99316..2141519a9dd0 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1527,6 +1527,10 @@ int btrfs_init_reloc_root(struct btrfs_trans_han=
dle *trans,
>  	int clear_rsv =3D 0;
>  	int ret;
> =20
> +	if (!rc || !rc->create_reloc_tree ||
> +	    root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> +		return 0;
> +
>  	/*
>  	 * The subvolume has reloc tree but the swap is finished, no need to
>  	 * create/update the dead reloc tree
> @@ -1540,10 +1544,6 @@ int btrfs_init_reloc_root(struct btrfs_trans_han=
dle *trans,
>  		return 0;
>  	}
> =20
> -	if (!rc || !rc->create_reloc_tree ||
> -	    root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> -		return 0;
> -
>  	if (!trans->reloc_reserved) {
>  		rsv =3D trans->block_rsv;
>  		trans->block_rsv =3D rc->block_rsv;
>=20


--4fKFU4OlRmlDEE8OYNFpTJhGQlltidpPJ--

--aZDQwJvhaQMovnWjSQkpGiySDGg9Vw0yM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5g4XoACgkQwj2R86El
/qgIZAf/QZuZ7GpTYPR+jmBoPU9jKEe6FcmmB1ewPHc9LT0ZG9RDEaplpn5DXVtR
3QnukV+c3l4xdfqKXSOH2WdUoD8SZSUzkXHqEmgnVy0uKUdqFT153zm2ZPE8xE0n
HSU3O4uP8F1XHs+jMzIKwQIcDupkn1MaNJ6h5YlokwIeW2z3037Ddr6omUrGXM6E
u1rDQTsPbBPS7XHGgvkIzfOWtm9EOw76LizeDyhiffh3UQtMbceeU/7q157So5ld
Hep2C34knU5sZsM5RN1BdCrPqj5kY66gxnMpdnKdgCkiWrNVKy+Si3d+DTIN282H
78p7WAm3502y9N20aoVmhAG+uc6XhQ==
=O1HO
-----END PGP SIGNATURE-----

--aZDQwJvhaQMovnWjSQkpGiySDGg9Vw0yM--
