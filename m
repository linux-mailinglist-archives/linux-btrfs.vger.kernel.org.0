Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DFA17A477
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 12:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCELlk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 06:41:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:47089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCELlk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 06:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583408494;
        bh=Q54CIMNwOtcRr9BJ1KxNgaadOugYZPR1W2HviyGltC4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QCNnlePQycNKZlyO7KY5fg7lof4j2QhTchTMf3feFrbV3ER+iY3lef4YV7zUtoMrm
         W2L0aoPUkxh6q2jn8Hs5EE3VN9odYNwaN+0F0iwxUtkByfaUePphVNiZFevQnfS98A
         jLo5cGbNHHYQherWFOdYLAlj5FkeGPyIKcrQWfZY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH9Y-1jmBV33G9s-00cdrz; Thu, 05
 Mar 2020 12:41:34 +0100
Subject: Re: [PATCH 6/8] btrfs: clear BTRFS_ROOT_DEAD_RELOC_TREE before
 dropping the reloc root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-7-josef@toxicpanda.com>
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
Message-ID: <21e4b656-af48-d10c-c549-11770eba541a@gmx.com>
Date:   Thu, 5 Mar 2020 19:41:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304161830.2360-7-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8NmwvuXo6qTe2hByXjHHsWxnUcITzXuV8"
X-Provags-ID: V03:K1:kDpaTjm8Fq8ZkBNj8bK0wQj0jZB0TUm7wzFnWRx6f45IRagDbv+
 kuDMIcW3l5LHoNNMLfO8xSwlzkUhM/kwObGr+lAkHJhEbXBppYWfKHsFbNxIjsdGgpY0nOT
 WpXXGtOScSWj2ffUfnZyiK1R5Ou/Sbcqs8f0Kr/KgpgTUckfRISJcPdTEGR4gjot3TIXu/y
 +nqATfqTT+pV1FE5hEg9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJOBN5UZ3sU=:GKBGGtt9MxDYz0syvphulW
 ExMCioj8fmHUTNGp6KOjHbeiPR/y/gGI2NoexhS21BbVC8AwQBMPPi6pGh2SoREB9kLg/knZU
 10fE7sPXJx0i7C+ZRZ5cvkvrwF5kEB+6yOCBPw8Pd1LR3jUYLf2QLmjfSOmzTSR2gLCcCCC/3
 fEjbt26094GkEu8Hcuq0WZrPMRWrXW8zGYii5JawGVGAKm/g08wf2sUVfGCjp3PEVnDAxgY2l
 9oguMwYZ6GeKw8VlxUmOsvMKXLJYiNDUwaZp6vyJvNjvaInXCPbUHQLhjrhPFAa9U5lZdGUvU
 J1TvB1FmitRKKCoRXEcsmKU/OWRN59qzca4/wVHqsPqh8cDv8ZZpREjK4w84xwJpjm1WWE88n
 /NxlL/UfJtlQ+V8QtNO1q8zZivAWy2iQpLS6uxsLKKq75Z6aAIrRRcnMjucfZT/uhf4ELjOO/
 Xpkz3G2CRymNm0I5otYaOI27Hkeq0MoFUAgprji5ZMviya6LKsQzY7Tb/xQUgL2OtyGOWQ6Ic
 ci//CdOv4U7KyM6YRC/KbJ0zVbP40JWPykXpVwRyLVKO+04rryk4rWyUNJ/rmUu+hPHd9Pdva
 ZIZEyTTyGqnJpnpoDkMt2ZxoH6W9+6tiY6Hssnt3Y5RXeRdftT4ZChqug7qIyhOlOldW8Fqf8
 QVVRwbGxLNYhKSX4Jbq+DkPr4T4pg66JcE7/iv43GFJctuhcNwTNpgHiBSgR43pb0eQUwpEcA
 pcsS9v9dJ1c+EuFEDUWzFco3lfk6acCfGv8EelBXP2wsuc4u5uMj/ZtjQ6LW5se9feUYD20aK
 h7ijfxkD19yGJf5Y3ddTpJT+gw/wSEjK/b824Nj8OvXdgAN9gRGhFDTHoEcjGZhHkO1GdtLC4
 dWx01wzUmOLy/KJVG8Bmagzk+iije+PRyp6JxmMIMHJdXYIo4m6rclG+WrCxKDiwmD7DNlGZZ
 1rwb9PeNcgbDAc0wCqk4xjSi/Z6Nv/0Ovn+aSChxfcqKgF3Egv/bgTkGWr5CpEbvMRTo7sqrt
 0hniJgOFVs/qcM9KtLnVg1QiKWcoS9GP8BVhPBbiJ+FHQ10OiA9PEelYE+OS5IdRD4pesptcW
 okC6LEmBiTK7CRKME2jORPMagDBScWsHo+31xLHrhIchz9Otnb6kTHfgleeffWCnl4QnPqOen
 9OXuCgCNOZOa/mApExIM2swAXJL5SoJoFQhDkxctZVjNpglZJS+Rr1vr9I54yU5FH6kuBPYB3
 8/9z+tJjC9eBu3+mY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8NmwvuXo6qTe2hByXjHHsWxnUcITzXuV8
Content-Type: multipart/mixed; boundary="K1gCE1pXARMNnPzoHYf5aPzYvAweHSTls"

--K1gCE1pXARMNnPzoHYf5aPzYvAweHSTls
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/5 =E4=B8=8A=E5=8D=8812:18, Josef Bacik wrote:
> We were doing the clear dance for the reloc root after doing the drop o=
f
> the reloc root, which means we have a giant window where we could miss
> having BTRFS_ROOT_DEAD_RELOC_TREE unset and the reloc_root =3D=3D NULL.=


Still, I can't see the problem where we have BTRFS_ROOT_DEAD_RELOC_TREE
and reloc_root =3D=3D NULL.

IMHO, that would cause anything wrong. Or is there anything I missed?

Thanks,
Qu
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 53509c367eff..ceb90d152cdd 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2291,18 +2291,19 @@ static int clean_dirty_subvols(struct reloc_con=
trol *rc)
> =20
>  			list_del_init(&root->reloc_dirty_list);
>  			root->reloc_root =3D NULL;
> -			if (reloc_root) {
> -
> -				ret2 =3D btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
> -				if (ret2 < 0 && !ret)
> -					ret =3D ret2;
> -			}
>  			/*
>  			 * Need barrier to ensure clear_bit() only happens after
>  			 * root->reloc_root =3D NULL. Pairs with have_reloc_root.
>  			 */
>  			smp_wmb();
>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> +
> +			if (reloc_root) {
> +
> +				ret2 =3D btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
> +				if (ret2 < 0 && !ret)
> +					ret =3D ret2;
> +			}
>  			btrfs_put_root(root);
>  		} else {
>  			/* Orphan reloc tree, just clean it up */
>=20


--K1gCE1pXARMNnPzoHYf5aPzYvAweHSTls--

--8NmwvuXo6qTe2hByXjHHsWxnUcITzXuV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5g5WgACgkQwj2R86El
/qhU5QgAkP2PbTVrDNtP8rqZgcnJa5CYuMvMi7Fz9I97MGW+x7Mv3FDsihbgJlgk
aGBDzH+C3WyuIunJnRaC+thxKcn3kDAzHhzdYEIe0SUDpCL0oF1WkQrQW8d3Ygfj
f2gDQ57aZ6PWQLa9kg/LYfK1ruEpekiqmG0YzZ27oV1ZZ1QG/WjGcEolxQ5wgrLt
UXAftteICuknIeVg59hBUxn5UjFY+q7wDYGKrY7Iiv+vaedegWfecYW6R+Q4CYXU
VmQnOZPn3RIC7yjKagn0LcpeBNLhoj+aU0D9+J2lTEoEZx2zlp3Q48c1J5JYUMdm
5xJ88ObOSvDcucDdWqeZL6Z6PI5SQg==
=U7DC
-----END PGP SIGNATURE-----

--8NmwvuXo6qTe2hByXjHHsWxnUcITzXuV8--
