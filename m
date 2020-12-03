Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8912CCCC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgLCCpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:45:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:38361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgLCCpP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963420;
        bh=NSDaTFvYNiUhWthEcY2jtnuXbqlGZOtPY1BuGeYrthY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QMta16HB5qPhfbU8hpi8W8d44r8vJUOK2pDRjOAQj3+vtN8mITm9kfRzAivec/Pii
         kHYzMCYKlIutMTGW3oKVdBamTDKAPphz+aZ5LRPgmkTKo6W/PiF/1KbdQFpw2n+Xrw
         YKKaubaisN9rgCTxRMIkFN474wFsNm0B7UBte7TU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1jt78I38eL-00uWku; Thu, 03
 Dec 2020 03:43:40 +0100
Subject: Re: [PATCH v3 21/54] btrfs: handle btrfs_record_root_in_trans failure
 in create_subvol
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <8da8919da73bdaf0e652f03d59391e7710da6e5c.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <a8f6422c-c33c-46aa-abd0-c634316935e0@gmx.com>
Date:   Thu, 3 Dec 2020 10:43:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8da8919da73bdaf0e652f03d59391e7710da6e5c.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xo1r6aDP5Lm9XZQEHO3j80QWm1PyzIbbE"
X-Provags-ID: V03:K1:SdbG7RNrmJ0cveQinmU3v8ke3VrGwG5/+2wOI/wfr7PkMmgYcOK
 0OvF58NSFN1ePCIckjd1BC0cD6ejBZHcZrGgqycSCAP3D1F3vTbRof/XZolDPUUE3fKvd/N
 qTERMmb9hkj+1SAsBZ4LMv5z3YeeUZX3mdnSSMlh/qzhQiq/Z2XGd5IY6RxLX4DhGtBA+Kv
 P9TRS5Ekwx7XkxqM040eQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Ig43C5nles=:bKkTSUVjgc8+caBRe7cccJ
 H/hbyOJGPwv1lL2R7nRtQsHWNuve50vpRKWc2OMlpoSvXf/axBcxg3YIBAg1qkXCUTobXEog1
 GboMhzi3B288gv5lAZ5qxHsjuOLwjCRenCPj4EN0rTfpq42FLP4aPvpSb8Job1tF21+/7spiI
 H51ShMaOoSAoumqit33uTHgXooZPRy2atzQnM5uMbvmp1Vk2RqaXLpplDyu6JRDJb5NJxIqgX
 oriMEM24T09gZy7VfKH7qtLl5UNhB5psb+vjbkVMndS0Kz6neTLUa3Q8Z0ynJVwt0hJFZsB3i
 te0ck+1slQdgDOLOgmk5kV5dQKb+hKl2qHwTKEv7eSEAKYx/i4nP8mN6SFHQGFAOzexWlvazU
 27ifxf+jAbXEyDZPfD89WLzE/yRea+Rg6M07qSQ31WytqVW+kAUCy873qGKOxFnSjHcbAqB4D
 EtECNYQdt0FwNf27AGvxoWz828LSXcvkKoJW5TUm1Szc6hV+pM7u6lwFYyqdBAyfNCwJZfkzn
 w2BP+7i8ae9ZqhxMTo7jHRsXd+4DlkO4XR2vh9CDeu279ZCJL+JpgkUeLQ0PqCPEXjf9z5bu9
 nSlGn818oHCHcQr/x14EJwEf6WFkKragURDMPPEjjWEwt2IoijYvXrBZALhsJlwhzqcwA2kyD
 Ji9Q7Itv6/FZMsqqyWHeCMTDDLXDt094r4G0HXqwNSO/ujRLh5qG/It/Z2yChQeeX/7sbAsz6
 jhDhQ0hIXrepvl7JvnpvADxUYwmBwGJ6gzEijdgKJiPtzqA+6aKBk7/wj2XiE1no2BJDWsVS1
 /bQF6j/+xh6Z0gfG9kHH+OJYppT9gajgkiqJFgtYe1bjBHxy3zDSIBSB05gaXhi2H+V8Xi64e
 w2hegkofpUZkQyxvbweg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xo1r6aDP5Lm9XZQEHO3j80QWm1PyzIbbE
Content-Type: multipart/mixed; boundary="XuCtSRrEC9MwWIiVkrAGJzvhETQzHBdMi"

--XuCtSRrEC9MwWIiVkrAGJzvhETQzHBdMi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> btrfs_record_root_in_trans will return errors in the future, so handle
> the error properly in create_subvol.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 703212ff50a5..ad50e654ee64 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -714,7 +714,11 @@ static noinline int create_subvol(struct inode *di=
r,
>  	/* Freeing will be done in btrfs_put_root() of new_root */
>  	anon_dev =3D 0;
> =20
> -	btrfs_record_root_in_trans(trans, new_root);
> +	ret =3D btrfs_record_root_in_trans(trans, new_root);
> +	if (ret) {

Dont' we need to call btrfs_put_root()? Or since we're going to abort
transaction anyway, it doesn't matter that much any more?

Thanks,
Qu
> +		btrfs_abort_transaction(trans, ret);
> +		goto fail;
> +	}
> =20
>  	ret =3D btrfs_create_subvol_root(trans, new_root, root, new_dirid);
>  	btrfs_put_root(new_root);
>=20


--XuCtSRrEC9MwWIiVkrAGJzvhETQzHBdMi--

--Xo1r6aDP5Lm9XZQEHO3j80QWm1PyzIbbE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IUNgACgkQwj2R86El
/qhzbQgAhqTU9Vx0pktArJX4BqpLs3qFTRvgZTClnhqqEVYi8Gv9OMhtVGXd0e2b
7t7LNfndM3xWOEXRi3Pc+pSGu0pcornVcsKINsAoanP8xu+MR7E5X6/6IdSciEpY
EN4DLEvS5TEnybhoithguOkVhyi4AQw4JKRJUdueylbxJItpOxpyycTejvGJyZFS
GNZaY+qpzQwpGHM7I8s2q964U2nmir4CGw+ibqDX7P5Kly1mjS0qc0JeFQV8ixJ1
jHMCVKUVd+NZPc20XcVNLHmD8TaH+DsSDRvr4qR/x5aW3t9xVRLIZhKWlEvsRTpx
n6AoVA1j65g5XMnKGp/D1zj0OGIaAg==
=UoBQ
-----END PGP SIGNATURE-----

--Xo1r6aDP5Lm9XZQEHO3j80QWm1PyzIbbE--
