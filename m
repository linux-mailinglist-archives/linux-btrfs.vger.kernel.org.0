Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD54E2CCE1E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 05:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgLCEzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 23:55:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:41619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgLCEzs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 23:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606971253;
        bh=jH0QfCGmgGu8qkR/8QECEM3bv/t2yVnU0kCbRjkJ8n4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=THmGnJMjdTQ98f6z3HWg7nX/Rwb5bcwmQRdikGGGzSb5WlxN2FpnOQWCLA7J0oUpy
         3ek4VWuwGPGgFroer6UMw2dkOiBc3YCATR+TuhQ+pbTCtEZGbtNSggPdxyTVXfimy4
         RfYA3BpyGxEvUYnOEb+mmAOT6zaZ+PpDNlU5R3tM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5mKP-1k5koY0tH1-017G2i; Thu, 03
 Dec 2020 05:54:13 +0100
Subject: Re: [PATCH v3 35/54] btrfs: do proper error handling in
 btrfs_update_reloc_root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <dc884af858abedd5596d31fbf365a830ec6b26d2.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <d6450478-973c-43da-4b47-219cefa536eb@gmx.com>
Date:   Thu, 3 Dec 2020 12:54:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <dc884af858abedd5596d31fbf365a830ec6b26d2.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CqemEGZ1hnMSAURd86SrDraRQ5elXRKtX"
X-Provags-ID: V03:K1:fBxEsvdpSK8i5z52gF3J9PZsFaMPQfAMbJQoanWE103FOYUoI8q
 R4UmVN456dzg8aWihnaVDv9wogDUpECK/seBKiWEReNKdN9eIashuY6dWtlDjEkN+mXl9S3
 5vagC5iKjHAqEjNyKRGEaqal4JdAufVlPYWwX6SyZh0u1pDvUzCQXBVbe+hB8z5YNAAZBW8
 f0boy1zwjLzXVFaW2/jNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5o6nB622fjg=:u2GokUpcD0qCQoOA7mNxFU
 aMjmkEi9lq//0NmV2QElrmtKwaHHRVu+16J7HB5X9pJrk8hflTlDijARKvmhzhMqTUKuZ3gte
 QrS2pzLhaAauFm5WdZmiYs/d2a5a8V5em8+A/LfMhn7+aff1aV86zkovpFT/hJYW4jyVjGO0L
 /mYnXV9CLgMbjvCEjPMPq5gwsP+gfIDgzKTAKA1ja+72ZEjFGtMw6fzM0xxEu4gOraVwet1Z3
 I43BErAf9pkIRoQE2myCcSwsfgagVa71cSyYBnxcBWnRGB78l3gdCs4sMkpvZQnUUnCn8H1wE
 7Z4mULuqNIHBDtscPo2tS2Ic39Cgcho/cTKzEfaJGbGSmMpLcU+TAcz7b/uBKKtMZgPlu8u1R
 Xxavo4QGeabP0CneCKhKF8BSNpOjSnkYMXa9aKZ0WRqNwb2qGYzxHvvOUiEwM6/5tnouHsz53
 shQ0b9E4sooNrbD5MYPECYXzGdoFys9w7ZkgxJvM1tvTMl4m73w/J71hdn7NBHUsvZQ8/twtZ
 kNocT0y6vJV6wMJ7USjAvr1VMiXpTMUyGdHnBhzKsr0XkEY7TETEQ/14X/0QfPppUA/XKUlHF
 7Qglr5avDviKEPhA1Ey0mOulZMqOLQ/SqaScxpr/SVHMsgo5pMHmi6NMCZQsNCLiYnDp8Oe2g
 DkIkHV0m01DlsynHr8MeDAw32G9GPl0qGpSS0DxDschSQzvCkfEwSb1quqX+69Jt3tzCgwiLE
 AIMNmj9mwngolqXaYCcFovDx+geDqy/5VLGai6/KXmf582zCoTTPOQdIVmTjTwbyVLKWKQhsY
 pdihJJu3sh1j2L4Z4CoC99D+pa5azE0gQ+k3kflgM5VDh8qYPej0PAo6DWOKvrAjARpA4iozy
 khoVWsovLsGw0Vz9HLGQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CqemEGZ1hnMSAURd86SrDraRQ5elXRKtX
Content-Type: multipart/mixed; boundary="ImJgjN3fbEvPcOjd2ujbCt7F4PsxdNiTw"

--ImJgjN3fbEvPcOjd2ujbCt7F4PsxdNiTw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> We call btrfs_update_root in btrfs_update_reloc_root, which can fail fo=
r
> all sorts of reasons, including IO errors.  Instead of panicing the box=

> lets return the error, now that all callers properly handle those
> errors.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But a little surprised that, btrfs_update_reloc_root() has int return
value but we still uses BUG_ON() for error handling.

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index e41d14958b8b..2fcb07bc8450 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -894,7 +894,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_hand=
le *trans,
>  	int ret;
> =20
>  	if (!have_reloc_root(root))
> -		goto out;
> +		return 0;
> =20
>  	reloc_root =3D root->reloc_root;
>  	root_item =3D &reloc_root->root_item;
> @@ -927,10 +927,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_han=
dle *trans,
> =20
>  	ret =3D btrfs_update_root(trans, fs_info->tree_root,
>  				&reloc_root->root_key, root_item);
> -	BUG_ON(ret);
>  	btrfs_put_root(reloc_root);
> -out:
> -	return 0;
> +	return ret;
>  }
> =20
>  /*
>=20


--ImJgjN3fbEvPcOjd2ujbCt7F4PsxdNiTw--

--CqemEGZ1hnMSAURd86SrDraRQ5elXRKtX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Ib3IACgkQwj2R86El
/qjkhQgAkrwwjWTEvalE2B4r1KNSd7mLxnvm6+lq+rWLho6aTM4oJUzUYnd/XVrY
tdMV12xAJthb2tGnvKcTQIHtx1LnActrhnrUffoZpeOOalbxNYbOrzZSCSqkApq6
Pb0DPIhWl+SBbTdOcoJ2ITfJoyw3kXp1c7tF+kOcHc9a5Rbln/YB/tYxUjX1sOBV
Y5yFbdLS0vGaH2uTooJhnzkCTWIVpRe4pXxyg0On/xY+uikv7CbFTXE6KOSmky69
YQAF8wYZkRA+AplmLTRuaCPRBSroUAW3VDIx53LoZ9kW15amuqd/mXZZPN/DCVYI
EVx2LEV9ZgXmtLHL8e0X5ag6oTnxyg==
=Ocnd
-----END PGP SIGNATURE-----

--CqemEGZ1hnMSAURd86SrDraRQ5elXRKtX--
