Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478852CCCE7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgLCC5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:57:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:42053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgLCC5u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606964173;
        bh=qF/k0AwSCmK1NAcat4z+/3kOfJXSgTJpH30TNgaU2tg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UoLl0nLUCZ9IB8DknJHhZxbHn3cPfK0z3cYNAC1blGaXk4RCGXdfvxElKkEFkBuQ+
         hCL0KR0RUJOzKuNuZQXpHxEIRMIE7i3Bu6iz/ZmcQ+LTWx4awdYZzERXec50DBoO7n
         IB2/ESqFxj4vjgYbkwssF954BSd/aBYZQpLkbV4s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDIo-1kKQiz05Im-00i8dg; Thu, 03
 Dec 2020 03:56:13 +0100
Subject: Re: [PATCH v3 26/54] btrfs: handle record_root_in_trans failure in
 create_pending_snapshot
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <602641114c0a6c5ba07f78371a4d94fd1c442218.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <525db807-743b-cfb0-221d-8db26dcd9f98@gmx.com>
Date:   Thu, 3 Dec 2020 10:56:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <602641114c0a6c5ba07f78371a4d94fd1c442218.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s8qFCmO64j2x0JV4yEEzpdaAE8w529X7t"
X-Provags-ID: V03:K1:mPqPjHhurPJ9D4w25o2yJPxvIljg5Sr14pG5Ht8PaAhXx0Q1hdF
 6n+E1JZVa9d02b+InS2Z/Sxpwr5YCY0+akRFKG00EVtzP55a/WkaV46yKKszugspG5znst7
 4Z8EJDqd/8YJ2oTtz0EpeUKw42JF1fZ1GPOrBZhGijtAvNITHsvyFCuMMVmVFM9XDPOWz67
 B30SEgzbwRFVNLMo+SF6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mvJKYutI8d8=:P9AgnowlTrqAWyhVfuE0s1
 gA7SOP5uR63z8Gnz83wvcgr8ZlymG1NopOsanw7qg/wd+KtmEXi32hCeJ5PSWVxmH5yHPygKd
 d0Nl7Hk8s/myDLZK7oNXPs46ZDlZs/a2+QlNPmKbSVLaqjeWq9IGxb3G8vnRtLdsDFxDp7QIM
 v0ZF82NzsZqGUjYe02nnlsGjzdO661Em91sn3MdLlV0R4xv5UXJtV2GuocXdJOjzxvkECLm7v
 1lAkOnOstJj4iR04fgHZMe75L++avai/o80aVg86ILCYQSyPvSRM9BV9DUCPTGKcQYYwa3XZK
 zC6VPKEBqYTZDErE2HhZWaPyp5MNTWsiKi9gGjpmXqllQQwpUFbIabQbxXkIPQ89vHk60DjQB
 5EPV+rGFWYgTwastNlFQs6RMxmsviKiQ9/8LpppznldhIAAU0i7xDL732moDtPbLRK82jmX0a
 lYclSQ1Esc8bW+RFd8k04JgTC+j5I+IzFIKF/TV/PXT6epxWQ8HHeEGVUzPzA8vG/Ai8GJ/L7
 nsf9xehYNfPLkb2Gn07ek11UouCPG0JfFZH3H6m4NiRwefsV2vNSuu/+RMwCe42UPpwAKZ6pM
 jprrs6yLMN76dl5j1MF9IAyWu6DelukQ9Nf2inAo/HCGATUjGRF5Y++AEv5eFuRXah5NZaKkt
 IhT/bm8FpBe52DAcCIUja/2pDQNwh76WILrZOum9jlW6FAx92/OKPOyNS1RNlTGaiLFYAPuXI
 glL4Bj/Qu5gdB0FHWdxEZGMKsnJt2zOVFmbSM69EYgcojEOQImN3alBi1nhi2FWf1/e7gxIO2
 hayF0d+cdrMg8L4aLdNDcjfXnnlcyx++1CjSjDb5/UFMdW1AilWH6eZhe6Wl7AZtr3M7o0gOP
 CXvbObEMwfh56Kwi3llg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s8qFCmO64j2x0JV4yEEzpdaAE8w529X7t
Content-Type: multipart/mixed; boundary="K3WXRkVHRVhiz02Q11FDeckaqR8n2Zoas"

--K3WXRkVHRVhiz02Q11FDeckaqR8n2Zoas
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> record_root_in_trans can currently fail, so handle this failure
> properly.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But I guess it would be better to folding patch 17~26 into one big patch.=


Since each of them are really small.

Thanks,
Qu

> ---
>  fs/btrfs/transaction.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 087d919de9fb..5393c0c4926c 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1568,8 +1568,9 @@ static noinline int create_pending_snapshot(struc=
t btrfs_trans_handle *trans,
>  	dentry =3D pending->dentry;
>  	parent_inode =3D pending->dir;
>  	parent_root =3D BTRFS_I(parent_inode)->root;
> -	record_root_in_trans(trans, parent_root, 0);
> -
> +	ret =3D record_root_in_trans(trans, parent_root, 0);
> +	if (ret)
> +		goto fail;
>  	cur_time =3D current_time(parent_inode);
> =20
>  	/*
> @@ -1605,7 +1606,11 @@ static noinline int create_pending_snapshot(stru=
ct btrfs_trans_handle *trans,
>  		goto fail;
>  	}
> =20
> -	record_root_in_trans(trans, root, 0);
> +	ret =3D record_root_in_trans(trans, root, 0);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto fail;
> +	}
>  	btrfs_set_root_last_snapshot(&root->root_item, trans->transid);
>  	memcpy(new_root_item, &root->root_item, sizeof(*new_root_item));
>  	btrfs_check_and_init_root_item(new_root_item);
>=20


--K3WXRkVHRVhiz02Q11FDeckaqR8n2Zoas--

--s8qFCmO64j2x0JV4yEEzpdaAE8w529X7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IU8oACgkQwj2R86El
/qjecgf/YPJ26ads8KOUkrPqiPQOgpMysmZgthXnxjcEVoIb3pQ333yLmvmMQ/er
4X+6D3ql9Nj/KA3fGs0joJk1fgLeLFy5+5otdgb+6P8587RuSe2U/l8OlpPe2HkO
dtm7JOJqUHYrfxlXD+IDJ0pFFzmGD3OJJw6R2S84nntwI9fEAjpnTRopnChwM9Hp
G6ErWw9aHxURbmoMk6LJWGu38TtPFFkuvS4XXjYHCcCjcvUUAKEpXQQ/ixT8y+d4
q+ga5S4iqVDH3uAfazmjoV0W6WXcC9NF2a4mhKTypcLAs4pCrjKGtkrJrx0l+3ML
re6k9rYI/+aI1U4zx6t8RjXNhpjlzA==
=o1nz
-----END PGP SIGNATURE-----

--s8qFCmO64j2x0JV4yEEzpdaAE8w529X7t--
