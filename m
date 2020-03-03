Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47541769C6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 02:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCCBC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 20:02:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:39351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgCCBC6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 20:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583197372;
        bh=FuaRRdlXkDuDR8qeDO/q4vSnNnk10SXzETeODEdc5OU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EyPF/23xOl2+02KvKmW/GLQyjp6+KswA2zz7p+bhMkb3a4gCmG7992lhJs1kL0aQb
         9IVZ7lVnsPzutY8IhTPKuphRJFBUNNPRXpVno8oP+AJlYN6dak6a0Yfh6KigSSMH3p
         +mChy16KGMX2lqou+7kHBD86MZV+odv37ZZn2PwE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1j4YEl3jYu-004UNj; Tue, 03
 Mar 2020 02:02:52 +0100
Subject: Re: [PATCH 3/7] btrfs: splice rc->reloc_roots onto reloc roots in
 recover
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-4-josef@toxicpanda.com>
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
Message-ID: <d9ab8cae-3666-009e-9e81-8d6c2ed59890@gmx.com>
Date:   Tue, 3 Mar 2020 09:02:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302184757.44176-4-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kipsME4XXBcxN7k9ishJk6eXnUulW74JJ"
X-Provags-ID: V03:K1:2+ZKvgqHnvEOMACV2F8XZrb+nmwd2Oxr2ujduN79WsaH0PKhvy6
 5LZUcI1LlIKsnn23RRxLmOmG+pChi4oshRoRK8EVcSgwokBkre+b4iG4+R722Mmm+PMPhMu
 eLfgNTusEJl5PPVd95OFVr0gyD597JeyNeJIR+L+o35F+9TBBZVarTbn6hp3mZ4A4V65FMy
 y9cwI5oshzYw63e/aTkeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzMYN68fnfQ=:fJ3pQfVC7jOcDoXne6OCb7
 933eyB/DrTQXHy2we7pyeFR3d0a5LJq2kpSj2rd2HBESCCzGGKFdoR/ypVHGyl5BwE+EQszg8
 2Qo4m8AzHMrFj0qnv+t1ixs3IQj2Km4ghSoz0C9V+9oE3BgoHvYbOuha9iC+huQK+J6yJhJco
 pgsj3wk85GARrWjGQFVXSY5fyTdm8sQJBJ6XBQ749Q2JuzAutj73EQLYrgw6Ri6+dCVwWrALA
 sByA3EUTIN/XzkQ71sfZGRMccGMU/jwIwWFLuEniHy0q2LSvYgKH4ai1Vr6NmitSh2ao/H2Wg
 IGoBT04DgX3vMEIOVij169Iadfrg9/A0TENWrCQFRfY3IqNG6BENfoefluXVx5jwdsajGfizE
 UUH8+vMhGAWV5SiEHB0+zyYQ2nC5+9ETz3/eIyRPepwMNHF//c61jt8Q7TxD8fZ45eUBNXbE9
 H6vHwMomRPHH2y5huFi3kqXh6nLRpH6wAFSFB5KsGyh4EKkuiHAB8VYQjr5OhKo1FKtRBqGYN
 T9RBRnVaxrFetmgkD+x76QDHlewi481ziu7F/Heq5NXsNA8Hl/Nk2bdWlw4aXBDqzAic2YcTU
 5jmfjJb3uYeHbK7PtqbjNMOPu3BmUhYn+s3QVfheo9+Klgu+bRcXjhfznR14J07jJIFZDMEIq
 1tadaylWVg1XyKLMGZNRMKEGYhjSsnfoCcHBi3SuFlYNbFBucBStbeF1EaCGcKL8ONzUkLRS9
 DjzQsuxliIP0HH8M41fDtaQpBzGSbbKPWrBfmHFmU79u1Vpd6u9TolMQ5Kp/iv7qAOH5LlZIg
 99bMkUOb9vdu3gY/jnoU/+9vpu6CtW2SrPqPO8BtnrpeqiUnFmgXkJNh/ke6LXjfmYuGBp/n7
 TnWYge+f7dCDIkfhvaIWzQXWCD10VVPI+bb5BEgfF187g30ma9mblrEnShPsJNdkVoNWg+Qp5
 OCkU5j/e+XzPscSEjulLu1TToN9ZekGQNmwHoojhDTr2kkdYXp9J2u/qx255w6EZBrHEi4Njn
 e9kNZIuomIMQPl/o2/FX/RvkhCNFK9T2yFWemIoG7WFDMJ5w8L9FlyWzZAuurgJ3FCtDOiP0O
 LBVN4fLnq+0ACapNDyKCr9uJ1V6asVXXRDstuFrBNuEMXX4r35y04v2gDQQze/po0iOsZtPBq
 6pSlMkF8K4f+lza6Tzrz6N2Mh9xKdOBfNty7e/uDBRa5+rUn5XAqGU+SjCuFLsMSQQoH8D2im
 RfAMn4wjVKAZPsjeh
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kipsME4XXBcxN7k9ishJk6eXnUulW74JJ
Content-Type: multipart/mixed; boundary="bWNdwWacO55OMb4FJiFY57vNTxxYV5FaS"

--bWNdwWacO55OMb4FJiFY57vNTxxYV5FaS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
> If we have an error while processing the reloc roots we could leak root=
s
> that were added to rc->reloc_roots before we hit the error.  Handle thi=
s
> by splicing rc->reloc_roots onto our local reloc_roots list so they are=

> properly cleaned up.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/relocation.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 173fc7628235..f42589cb351c 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4710,6 +4710,9 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
>  	if (ret < 0 && !err)
>  		err =3D ret;
>  out_free:
> +	mutex_lock(&fs_info->reloc_mutex);
> +	list_splice_init(&rc->reloc_roots, &reloc_roots);
> +	mutex_unlock(&fs_info->reloc_mutex);
>  	kfree(rc);
>  out:
>  	if (!list_empty(&reloc_roots))
>=20


--bWNdwWacO55OMb4FJiFY57vNTxxYV5FaS--

--kipsME4XXBcxN7k9ishJk6eXnUulW74JJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5drLcACgkQwj2R86El
/qi+0gf+JF2WJtLtYzAcQ8/hhlBqSP/LLgB8Ajsroejy55kcdBhvl6ZAIwXJu0db
60xQZEzrrj4DBT+QyPoYsphV8eNzIQ49ocka5/N5nZb9PhdiT02hCpGyjVBVse2T
t18awn/YngCQx8rwJINRoa+AySkUByiVvQYEyc8UwQifKufWo3XbCqrlhYOAXBtu
Q9v8F4lDDhXY1vHvVFxjmHyZLGj4AaJeoIaurxfb5sg/i08nmDX2qbwt7jlMGU2B
PqCzEnLPYb3pNpvxpoUHUrGzE5olwgA7MGqDN7YCecDwmt6rtb4Dn+A/OE+yDeet
Pqj/JduSHMN2ulPQKtKTEMvXKP+kww==
=K+CL
-----END PGP SIGNATURE-----

--kipsME4XXBcxN7k9ishJk6eXnUulW74JJ--
