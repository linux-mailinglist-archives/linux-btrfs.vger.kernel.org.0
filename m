Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562D22CCBCD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 02:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgLCBra (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 20:47:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:52503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgLCBr3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 20:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606959954;
        bh=RRGY+IOylYOg1ZEU0Fxt+i4m1UnlNMfDp+juxCZhAR0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Xvlw9gQRS6iuov+cCqTqtst9lgt9r++dKO8m86Os1vP6iaZBGcWuDLormgumUSm1d
         va6Fvwz/38/czV9VlNxZyr0cpnk5tAZ7fmMkWjiyRWiNvqLmwC4M84Xzxm23UluWyo
         VZas8QRCtMxl4cAPIJ2MKd925fMU4Jg7pdtInQ9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mdvqg-1kDEPv2fnK-00b5zZ; Thu, 03
 Dec 2020 02:45:54 +0100
Subject: Re: [PATCH v3 01/54] btrfs: fix error handling in commit_fs_roots
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <502d2273052e95e19366d785ee85e542e86fe61e.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <7567aa9c-1217-f24d-396c-88d6a0da9101@gmx.com>
Date:   Thu, 3 Dec 2020 09:45:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <502d2273052e95e19366d785ee85e542e86fe61e.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XmTzzoIrR61LsTA7xIMwcIxZ3wrKISFlf"
X-Provags-ID: V03:K1:fbFXxT032zDlMn1J3ReOVxTWT9pk0Wc3js42vuxT6vqn5R1H3zT
 sEeaa3Rv+nnLOgvj1xlE6mlEk4AI9gkPBl8Zn6MhUaxmG8r299+FcBYUCbEPUh8O0vbTKeE
 7k3Y5PEwVylzWYMyEXrHRBPbkc7ksWXjvkLtyUj3HItgEA1Lm29yjrSvhzPK8YOnJJyZJ9A
 P1gcpF4RTQcs7/yF5O+oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FqzgxRL10JQ=:rn8s64NagERFIn12hXiXKR
 U75KxsY4Fc/Dpk98LPRvKoBQJ4fLZPArnG4xkkzOBueHN8k1TSrI5aFyIF87xB2EnDYMwAcOx
 gRVZ543YgtvaiAs++A49P7FaJsGlKE4VeujqgcMxQCuEXZ+ZdZb03Y3QILFpW+dyyLhOALJE3
 0UqRB5Mq2fwbNNjvM4kBZWnR68Til9qNVcBdYJjT01Boo/ZoR/zrom1Ai02EpZK8lxSRmfAq0
 g8T2WkhNrannC7Wm8kMwCGo++LAvlR9IwLEJzzS4k0CTNd76ej2n8Ua25dK+L5PApNaCKtBvC
 C9a3LnztcsknLQlSMPG53UGEKwJ7xiBPu8LJmjTb0+cX2SkoIDuJV8OdazeZV0yAs8zfqmclx
 pVbYM0Mdlv3WLy1aAL1M9uGQTTy9NXNGVzN/hql0157QJFG4QySOyGnsLK3h8JtY8iBuDegoq
 iMCHRYNxJ/CyR1ERdVSVfFuYiMtka33Is0wMQZoLE5WHKc4CyN0Clw1qWmdP5bCV9+SkiqUmP
 jUJA7ICUrk6bIdvG25n5hUytpV+3wvKAvjAIo1IbDehY29Ht3+EAiqyfdsLEfIIqi9PYcx6Tt
 OP1xQpi+hZch1lxii5HRqnGdD67pKWKRna60newxk1SAStHy+X33W08TNMVaf58Q2+48kCmI7
 Hs4BY01cTeisBAJ9aaKZzuDkcQuldSX3KPtuJfzm3EnCFIWQ+ayjG1IR/i8XJMRPzn/0MSegD
 amGnD4appOaTLjs6K4kwYAoVwibAUZZvG0f+y901dtvgiHcfCVYP25Fu+MliYPm8nOkzp6BCJ
 xTOhOyXNddqLTogX82+wfcDSP8GSPTwtJjfjmywfSj6HB+mVgiUWAqI1O6yDgtC38kfCKDWKc
 F3ffCBzJc5k+Db1yc3Cg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XmTzzoIrR61LsTA7xIMwcIxZ3wrKISFlf
Content-Type: multipart/mixed; boundary="ulp1NH0pyhtHmSRLKWehIlKVExrn7jcxe"

--ulp1NH0pyhtHmSRLKWehIlKVExrn7jcxe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> While doing error injection I would sometimes get a corrupt file system=
=2E
> This is because I was injecting errors at btrfs_search_slot, but would
> only do it one time per stack.  This uncovered a problem in
> commit_fs_roots, where if we get an error we would just break.  However=

> we're in a nested loop, the main loop being a loop to find all the dirt=
y
> fs roots, and then subsequent root updates would succeed clearing the
> error value.
>=20
> This isn't likely to happen in real scenarios, however we could
> potentially get a random ENOMEM once and then not again, and we'd end u=
p
> with a corrupted file system.  Fix this by moving the error checking
> around a bit to the nested loop, as this is the only place where
> something will fail, and return the error as soon as it occurs.
>=20
> With this patch my reproducer no longer corrupts the file system.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Yep, that err can be overwritten by next loop, so definitely a problem.

Thanks,
Qu
> ---
>  fs/btrfs/transaction.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 8e0f7a1029c6..a614f7699ce4 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1319,7 +1319,6 @@ static noinline int commit_fs_roots(struct btrfs_=
trans_handle *trans)
>  	struct btrfs_root *gang[8];
>  	int i;
>  	int ret;
> -	int err =3D 0;
> =20
>  	spin_lock(&fs_info->fs_roots_radix_lock);
>  	while (1) {
> @@ -1331,6 +1330,8 @@ static noinline int commit_fs_roots(struct btrfs_=
trans_handle *trans)
>  			break;
>  		for (i =3D 0; i < ret; i++) {
>  			struct btrfs_root *root =3D gang[i];
> +			int err;
> +
>  			radix_tree_tag_clear(&fs_info->fs_roots_radix,
>  					(unsigned long)root->root_key.objectid,
>  					BTRFS_ROOT_TRANS_TAG);
> @@ -1353,14 +1354,14 @@ static noinline int commit_fs_roots(struct btrf=
s_trans_handle *trans)
>  			err =3D btrfs_update_root(trans, fs_info->tree_root,
>  						&root->root_key,
>  						&root->root_item);
> -			spin_lock(&fs_info->fs_roots_radix_lock);
>  			if (err)
> -				break;
> +				return err;
> +			spin_lock(&fs_info->fs_roots_radix_lock);
>  			btrfs_qgroup_free_meta_all_pertrans(root);
>  		}
>  	}
>  	spin_unlock(&fs_info->fs_roots_radix_lock);
> -	return err;
> +	return 0;
>  }
> =20
>  /*
>=20


--ulp1NH0pyhtHmSRLKWehIlKVExrn7jcxe--

--XmTzzoIrR61LsTA7xIMwcIxZ3wrKISFlf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IQ00ACgkQwj2R86El
/qg70gf/VMFNQ1PfjQ6+mIEIM0liNbGCTGTi7xmJvh2RgQA2n6NYAC0NatMUMQJH
hVxpgw1tomprewN+2ZQ43342I0EFoTpqidSyAKKvRcr6I8EsQSzsIUShth8hU5hb
IIJ/Y25ncxq+vH72PffpHjVg1DqltpbVzfB+U4p5xUIGlAS94nzZzIoHGPazBzNm
NiKelYgAmseA/WkkX+uB6iynrw1PzCHULQDMNRchLb9jylBkP4xobCWZKRRy0XXC
1RfQ7QVisRh6tIa3Se73x+vfxExgV4EQ+bl2FN1X8FeR17POepkUWtEAlOQzlaTd
+/ZCx4MQ6YT5SBLwMAq2OoA+iyDZ2Q==
=OetW
-----END PGP SIGNATURE-----

--XmTzzoIrR61LsTA7xIMwcIxZ3wrKISFlf--
