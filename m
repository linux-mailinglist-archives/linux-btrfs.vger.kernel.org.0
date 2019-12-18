Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D171243C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLRJxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 04:53:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:44417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfLRJxG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 04:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576662784;
        bh=psWA0SA94eTdxRlRYkic7Ez489tqPwhXrVv0ZBOKMkY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l50O7OhfGcjjT64ScZ/1oDHIJLTYiL5hMT6AfcY4lb22Z+3tG+rW1SUs0E8bX27Gv
         BwxXsiiBMG6o8gTrsChja9CcV/5gL6Pq7yRTsHlJxm6Lno/Tr/kpWhU+2V0pvhHgRo
         L8LvbMsE/nkOMEEip1aNQxtAgEtiYXO6xxpQv374=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3mz-1iF61O25Yh-00TRGp; Wed, 18
 Dec 2019 10:53:04 +0100
Subject: Re: [PATCH V2 05/10] btrfs-progs: adjust ported block group lookup
 functions in kernel version
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
 <20191218051849.2587-6-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b87626bd-911c-8fcd-4713-58968458e078@gmx.com>
Date:   Wed, 18 Dec 2019 17:52:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218051849.2587-6-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LpRCM8wAfrGvu25CfPZyJoYqzPK2M7Ndm"
X-Provags-ID: V03:K1:TdQsEIrZJr6iXiA3V0xVPtnYL4mrugdLwUmzUtOePeCtR8Bn41n
 /ozlesYgH9YRdHFA2IfTeGFzZyxqqVDv/oyP1piso9+SFM/eWfr8RuMNrK1T3coQ0ML7SyP
 1Yn32M4HNXT73O24hM0idVaF7KluLIydws5j2hhYbE03WnnJgS3sw/tmnn6+AzCIiuuPiLQ
 m11lOgKj8Q1WPvRXrdH1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q91agXveWwU=:RJME7kobi+CnjFDzi+W98A
 sJ9ec7GdEnKVG6l1VrEKmL3gaJnLRwSvifrzPg6mnMUqeH/31UWfX+C+rFlI69smTA99PDlAX
 KgIctXdjCA8VmLge15mNAJQE1PTaf0nvZxwqbpGhlVmAVtgjME3BTU5rU3M5z2GtduDyT6BgG
 f1QGoRZL432OYd+UWkpKW/naG1OG3Yzwr4lZZiuf05JpclRkObr+F8yW/4i4nl2mU/HAIXPV2
 HR+iajR29vpeGPPCGe6zSe6w9Te/Nez2izIxF+UeJSVe+cJCCwsZjuYqRtbYlbP9EeyTF6N7F
 PcRstXteJ8iuqdpxGLCHOGk6djmRSXaSsajhNVcoZo3WBK1zLL8qMPI9VeQSJnKJF5OnxESxi
 U2+I8bXOOGpk0uoNtRpd2RZJrndP9QoF7WArZxdorrl+w3251R52xEHJ2J/CJZN0JBPRzwJEu
 odZgMy/u6KhZMT8SEfHN3+xtqspHPr9PYb7cbtJyV9om9ZrBOFUunUJ4/MR7jx4hgrR/S8ffo
 WOeTCg7T+eskTT60yVVQa2+yYC9t7GKeb3fx/fxLmTigaR4ed7pWVgCNtscOxWDxeBBDYsLvn
 CzrzJK6eATB8v/lln6SXqvpWhgFRfAymOoFzNV3mXcwZe/lNKGcSA7oyVfSNiQaFkf8PFNqCi
 DnZKzB+lkczOokbq9C9Awdn+172awc8D3nUtgjD27fpjX2wX7Bo+RiAHxDSBpS5E0EAE6pX7W
 Cae9V6xRYMtk2x4vt5Py7fFMof2QFAZTYKeSg4os32cLwal4DB7RoqR2LGT+iOMdUEfdBPReY
 LrW+7DZCYFoVajRWD6TQRcWJBJ0VFbEGpa+wn0cVkg8iLKPO3dRMNUM8IJAtq4gC7F7ruEFRE
 H7JUxNtpkgTx+x5gTAxBgdt3z2jEOCqIliStaNA+OZfYekqw0Mie8EnMaGgoZZol7XnZonTLh
 +CDwX6SuqlgAwR20b4enaJWN4L2zevClZhp7iCDNkfuRucz4d/bWBdvf4VA4IfX7QKHlj/Dw9
 s3OReVdvE8LfyYwL15ZF4H2m1dy8e+XdwkO3wnWpbuQ1mV+cnXnOOkGJcPAh7BfaRdZXwwlQ0
 x7k5qQlD4olvq9p0r5Xmje82sJ3oxfXfoO0CuVX+YoQbJK36YQmfa7yJi27cc4RJfq1aZRhwa
 V+VqEdd6rEv7dSZkYNFA/yFaXG/qeATuSiQDh1AewGj5qzmZwssu4o+xoMqLxwuiDrOcWvlep
 LOsYazl59hJTmfQsUr/DboUIbG1EEz4h8zoy1hSjvM9j/uZTjAbE9BAzHNVc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LpRCM8wAfrGvu25CfPZyJoYqzPK2M7Ndm
Content-Type: multipart/mixed; boundary="HjYF24wcp0TLjXGoUE3TL1kN5K697w9me"

--HjYF24wcp0TLjXGoUE3TL1kN5K697w9me
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8B=E5=8D=881:18, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> The are different behavior of btrfs_lookup_first_block_group() and
> btrfs_lookup_first_block_group_kernel().
> There are many palaces calling the lookup function include extent
> allocation part. It's too complicated to check and change those.
> It will influence many functionalities in progs.
>=20
> So here, just make kernel version lookup functions run likely in
> progs behavior.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

It should be folded into previous commit, or this will break bisect.

Thanks,
Qu

> ---
>  extent-tree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index fdfa29a2409f..3f7b82dc88a2 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -238,12 +238,13 @@ static struct btrfs_block_group_cache *block_grou=
p_cache_tree_search(
>  }
> =20
>  /*
> - * Return the block group that starts at or after bytenr
> + * Return the block group that contains @bytenr, otherwise return the =
next one
> + * that starts after @bytenr
>   */
>  struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(=

>  		struct btrfs_fs_info *info, u64 bytenr)
>  {
> -	return block_group_cache_tree_search(info, bytenr, 0);
> +	return block_group_cache_tree_search(info, bytenr, 1);
>  }
> =20
>  /*
> @@ -252,7 +253,7 @@ struct btrfs_block_group_cache *btrfs_lookup_first_=
block_group_kernel(
>  struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
>  		struct btrfs_fs_info *info, u64 bytenr)
>  {
> -	return block_group_cache_tree_search(info, bytenr, 1);
> +	return block_group_cache_tree_search(info, bytenr, 0);
>  }
> =20
>  /*
>=20


--HjYF24wcp0TLjXGoUE3TL1kN5K697w9me--

--LpRCM8wAfrGvu25CfPZyJoYqzPK2M7Ndm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFKBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl359voXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg7dwf3axHcCD7AFr4OATZd/XiXX7zd
iHQS1dGnwZO1zror8on6KOpFXClUw/EJc0G9wjxmwidvbn9nCblhijgrN1PrFLsz
Ivsa6BHmWxjZ503ql11VaKrUaVcQpTv8Yy23bfo5RLW7n+dzAVzAVORMduPoIk+x
40W3HntPzmVah8UV2TSbr/sc0XQrWQ01ii4uGK0OTqWWd3Aa40GvIScwcjyiH3D8
9CD6JeZYKwRLGgeZiW/B3LrG86y2y0U2CaSBWm1EZ14uOi1CQM9QEi+cKz2D/TmT
qax2vGpoKMKBBzhZUwg0L5cv7cTRSArG4zQ0IhDwQeug/tZ0eeq/5Q6Jgb/B
=bQAq
-----END PGP SIGNATURE-----

--LpRCM8wAfrGvu25CfPZyJoYqzPK2M7Ndm--
