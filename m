Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB41769AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 01:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgCCA6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 19:58:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:56341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgCCA6d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 19:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583197107;
        bh=G942lF6WiWqXOH3JrjWrjVZGpWIBGCALetw4ocoGnKU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bBM9BecmBGvys4Wd3blMh8sadQUYbqCSqJnI+s7Z6cB13C9+npAFWAEXhGSKhAzTW
         1zsCWO3rC20o9Y1/o1jj1KWzE10bFM5Tz+E9qwF9IH4Iaho9qHL6vNUD0MO4M0e33t
         wNrkufTVN9ZHLAJZHpOfiuFrA1T8rMXvkLDosIZs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKKX-1jApYZ0u5Z-00FnNA; Tue, 03
 Mar 2020 01:58:27 +0100
Subject: Re: [PATCH 2/7] btrfs: unset reloc control if we fail to recover
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-3-josef@toxicpanda.com>
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
Message-ID: <27afa0d3-e030-b53a-0033-674f13199c68@gmx.com>
Date:   Tue, 3 Mar 2020 08:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302184757.44176-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I2NbZ0sEKx18xCTrUEOJiKRHIaqPPpe5B"
X-Provags-ID: V03:K1:UJN/eAobfHKok8OMMDwHuHytzewzYUOS6zO50PN7Cc6ZnxTMzem
 YK5bA50vHrznH6cTazSb9VA/InT0AE5ltE+Jy3Xobsevr2ViexFjUYaKr7bGQuRJRk8kDJj
 XXp3vXTeC6yitCme/JsYn4Lw/kdHT4bxdLdWleLMBfVBPiVuZKu2xHu4HG+GWG5oT6IxG+X
 aVwhvoHNrwLhPO3Sm7AXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jAHEHm7gcBk=:Y6RUk0SBLabXN0UXXJ5rGu
 k+/G/m3O52fWpTccl4jSHnpqjjnmDoRfBbgK7ew97Gt0JCy+0EwqxxmF9mNwyCcu+OIT9vtFb
 ToFR90ZY7kxjnI7vMYTYlQ0YsYibWepL19xmQpDKPHp1a+LfNNVs4Cvf1s3opDm7DgmyGlvT9
 g7Li2q4NRFcpoDPqX2WAx/vEdVlwdJ/bycxCr5u2V3BT4ciTA6veaMWh70yLieFn7Jhnpe51K
 EiBBFnt78d690e3oD87NJKQ+SOFiWKstsmpouSCUtmmQFk3VBHR1mKbE9sSydxcBzdVSrTwXZ
 PQWkX0Tlnl0kClLxB2wRORFaBoFnBzhV2JlB+Nbs2wjW6/Rm8n9Fe3ncPpIdCk3riVwJ/dQi2
 Mc+HdT0P2/dDsD7/Mb1NZM911X92O8yxD0wWMQIoV3UtzNc7m/rxT7CE9MgkHgHNSngnqofUP
 EhTMwsdo/mKVWZ/gJm9dl7RHP36p0kpJ7LwBEsXjYdJiJ5IfOlXoWXdvZGaEM2FWvBxBgBbUW
 qEIjzaj6VdLjLwxQG1uT7Cuvi9R3EvAnNVZYpmlMMkt6tVtpCO0hN1imlpziK42ClFBdL1C6o
 mAWWNE4UBfTGyCWNBiDUjNkokzxExQ44dqEKCK0r5YiAOlpLrdGjvVoxMu+wP2NydbJhZFmwz
 DN6G/PZQKRxKOFvTbQgXbpLIScQT21pDKzOX/yJgjXwAegZCFvJbuCjrGy9rf/oT/ypLtuffa
 FGqYh4D3WU0/6YoL2stPo6SBM2hsyOkkWUnZzxj3KgQoX60ggZy63NvwkXuhLaRAz3Nh5SgEo
 kkEQwGvBue7zNqndEp9K6D4co/Iqft2H5kGiBpQmsbZcbrdoZ+sGXnKZwIGLNnG9XeADks4u3
 H4R+W3bZ8PGVK6cJXa+QlVDm7i6QVbmxyj7x3s9aMSybnmIkh2adkENzK8WN3Pgj72Rbo9hKt
 N19wf+CHYnEa2tMQnvGcjXpTEhBAL71Awer5+N2miMhI6iehjfVCyiR/vNSD9ooJwrNO05RQt
 6ItkVPnugpy5x/ACO+zUjthtLTRqGsnPeXfnhOc7ozfwXwoRxsUCV33eXFNp1tngxYDGY5Vwe
 az1I+Hw4MNjbN1qbmvn8HDlxXoc2v2Kaa/PGHWkeqJ5r0gNyqukpwVwWvuEVvY4958cW/dhYZ
 +Gr0BkGA1KGfOPsRyh/67oig0MCjBFV2YcTl4zIP/fbPuleXMN8scIi0ZGDWiS2Q+8kHVYbG/
 8zrkGZk8sYTbw1Shs
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I2NbZ0sEKx18xCTrUEOJiKRHIaqPPpe5B
Content-Type: multipart/mixed; boundary="UDJMxBFCqtgZbjxH2fYPqcFIi8B6jLucj"

--UDJMxBFCqtgZbjxH2fYPqcFIi8B6jLucj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
> If we fail to load an fs root, or fail to start a transaction we can
> bail without unsetting the reloc control, which leads to problems later=

> when we free the reloc control but still have it attached to the file
> system.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 507361e99316..173fc7628235 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4678,6 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
>  		fs_root =3D read_fs_root(fs_info, reloc_root->root_key.offset);
>  		if (IS_ERR(fs_root)) {
>  			err =3D PTR_ERR(fs_root);
> +			unset_reloc_control(rc);
>  			list_add_tail(&reloc_root->root_list, &reloc_roots);
>  			goto out_free;
>  		}


Shouldn't the unset_reloc_control() also get called for all related
errors after set_reloc_control()?

That includes btrfs_join_transaction() (the one after
set_reloc_contrl(), which looks missing), the read_fs_root() and the
commit transaction error you're addressing.

Thanks,
Qu

> @@ -4689,8 +4690,10 @@ int btrfs_recover_relocation(struct btrfs_root *=
root)
>  	}
> =20
>  	err =3D btrfs_commit_transaction(trans);
> -	if (err)
> +	if (err) {
> +		unset_reloc_control(rc);
>  		goto out_free;
> +	}
> =20
>  	merge_reloc_roots(rc);
> =20
>=20


--UDJMxBFCqtgZbjxH2fYPqcFIi8B6jLucj--

--I2NbZ0sEKx18xCTrUEOJiKRHIaqPPpe5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5dq64ACgkQwj2R86El
/qg+kAf8CWGuToqWFpz/zzrR99IrU3RO5QTrRkncmS1GOv9K+ZEDWcJ9H4lgrh9x
P++QQ9tDmR/mA4uKD0SVpriJVi9NQLq2Hm7D9gdm1is12pLBPN6/ksYYYTBAFmX5
GVUs5bGB4jeRszi/C93khmj1i8CCmqyPfFoW5Sth7yt0DlYOkYGCdB4P0/H4qzWh
LkYLEWL7zKFbJZ5va0RERSETxonja01ucU/riTXs47ptvxRmVFwfp8uaa3U9n3NL
4qeijvjSzIp3Ue8+ecSRLtrskYTb+sFKiYeeNqnMtSBCKtwzUe9BDdcXbLDeUJ+M
rZ+7HaS3FNzbuJ46gyg+hLLaGNaakw==
=1Wa8
-----END PGP SIGNATURE-----

--I2NbZ0sEKx18xCTrUEOJiKRHIaqPPpe5B--
