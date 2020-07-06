Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0726215279
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgGFGRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 02:17:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:50405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgGFGRR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 02:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594016223;
        bh=mKodQ0Y23blwZ4y+cpLZtdo8358ICaHyf4ytArKLYuU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TE+vS5op6OSOVP8PF836wTL9chimcORF7ksTKKVzTuJIuH1aQc7J4OfLgC12u8xLk
         JqUYWEXLsaOzot6d3gaPnYitWzSIoGvcOPbl84NgHJv/qgVCYCnyWhvlVwKHtu8Nxt
         5sBP6B7vXchlk71cvsnyxXC0ovlyoKReOgKAOorY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1OXT-1ktgdJ1DVz-012mXL; Mon, 06
 Jul 2020 08:17:02 +0200
Subject: Re: [PATCH] btrfs: speedup mount time with force readahead chunk tree
To:     Robbie Ko <robbieko@synology.com>, linux-btrfs@vger.kernel.org
References: <20200701092957.20870-1-robbieko@synology.com>
 <aeb651c8-0739-100b-90ad-9f36ecdc26e6@synology.com>
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
Message-ID: <7da55a96-131c-b987-edfb-97375a940cd2@gmx.com>
Date:   Mon, 6 Jul 2020 14:16:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <aeb651c8-0739-100b-90ad-9f36ecdc26e6@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mlRMY68DA2QAMmYm2zqnAD6NEE3Vsmjkt"
X-Provags-ID: V03:K1:+DunM0UKVFzsxHGls8tIeUvVO6Zfk/DDFH6035FbcONWi2im0Lv
 O+fOv7X6OxVMpZZmhlRfRtOyNRi97d5PyyP6hYSn4blrcXBkMrC4KUIZ4YHb0O/zpfdkGBL
 9LPdS+D7XbV22wtonT5oH40aQYiV3Lg5rL9h3ieh7HlAG4drv2dIm+26TAK5qMkugeqiuz5
 imWhBFgrrdcMR3D7zDbrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mEnrtRT76bg=:DifVa3xgVw1AqK/Snn3MDT
 +X/lEsQUHQrR4lh/4LvLO4dgB3eXjgJSfXOe+RFmDZhDMToM8rnX+iy+NdvRA5QFVzb+Xu5o/
 j0Pn0dyolBV7Pbe1slwhbpFYbYQszszHry1J8dOdKEbz8SBIOl2r8pDMfHhGxswDBVT6mxllN
 XOSOhCxjYNRJx+GbgQeY+j2JPO1ucuk3kw7XchbCcCaiOaeBryO4ek23KxLN8+1qdAzYytFZ/
 FvgFPKFHv+wLo9k5Evxm0F7K3d5Cu1yoLU90KG+cyDzoH4B0jtzsetJgOU9su1ITt7i3GHUGK
 Wtr4wV5v58z/kwAFD+KWuaL+a78dfQ38C4KdPg5EeM9kqbSC8KmSShcqhRftm5iAFqNumRgbe
 +NFBe9RtTgxWDJEcuN7TH0SCumZkFx5j7gTsp15rptJWjBHwhSOWl+lsicU8C9YUvxT07UR+v
 iz1cSrltTGAe0kmFUkAwoCvzR+SoBAqk4aWtLfyWNxfcS0nXarr8lykDDGCHPJwkatKZYwsNs
 HfzVnx0EdsTX2l1qxdPi7Qe9aKDioIu4dI2ofp4gOuoHClfibl33eDvDfFLRnQn9YwV02o3eU
 FeB13BjnT0Be/dRa66oENRjoCBak8OUR8OfkaR6qrhpdMs9KMi/FjC937KEMrkrOwoKL5LQjZ
 nUwxIyBYaQdZWtC4OUv1nGH8dxrQqXcCZyOlMRTM3E76MtwOiS0UGJjSqQfZS5rPyYaSbjVzg
 dhqh9CvmUsma35VYsK3kl94kTq7K+XSU+d2kuxw500u/JNIQrwMcrqgp2CZl5N4WnZ7vIdDd1
 j+UBLRPA1msIFJkLKcrUYoMSZacZpvFXX80ftsNml8YCKpSr1jbKXFduoDok5kG6IavE8Y558
 7pFGkGuoSYYHM8vHqXLf89GKfe0O5zND+Ti8+gIUm5YhSEApwNfvoA2TKAu3ZmkmUYUgB7Dft
 Y1zrCsFtXdXedjhMe084jMtIvc8dilkgIMcXjlHoaB1+LnlgvZ89sooDLFVVqoNNpWJ7d5Yn2
 YAv3G0k7kXiCKu97Kg2d/4eBmT5XYRWKgMUR9OcCPQu8b3LGcXLxV+M+whwW7mttk6avDvQ6c
 tnEtq53X3PmYkzdOBaFiBWelmc00xmz42kWF63azRPSn2KblvvZMqCF1weQBapwVcEEzNCQgj
 Ff7GCVxZzwKKDKTRaV2ggKW0e+Pgx/E4+blBOMs91kRfqWqQPZFEJg/m7Q0SWHSdKYfmWOAqT
 fvx04n42/YwxIEOKY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mlRMY68DA2QAMmYm2zqnAD6NEE3Vsmjkt
Content-Type: multipart/mixed; boundary="PSLQ3v73p37nWbgPX258oxqYERoXR9xnL"

--PSLQ3v73p37nWbgPX258oxqYERoXR9xnL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/6 =E4=B8=8B=E5=8D=882:13, Robbie Ko wrote:
> Does anyone have any suggestions?

I believe David's suggestion on using regular readahead is already good
enough for chunk tree.

Especially since chunk tree is not really the main cause for slow mount.

Thanks,
Qu

>=20
> robbieko =E6=96=BC 2020/7/1 =E4=B8=8B=E5=8D=885:29 =E5=AF=AB=E9=81=93:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> When mounting, we always need to read the whole chunk tree,
>> when there are too many chunk items, most of the time is
>> spent on btrfs_read_chunk_tree, because we only read one
>> leaf at a time.
>>
>> We fix this by adding a new readahead mode READA_FORWARD_FORCE,
>> which reads all the leaves after the key in the node when
>> reading a level 1 node.
>>
>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>> =C2=A0 fs/btrfs/ctree.c=C2=A0=C2=A0 | 7 +++++--
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0 | 2 +-
>> =C2=A0 fs/btrfs/volumes.c | 1 +
>> =C2=A0 3 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index 3a7648bff42c..abb9108e2d7d 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -2194,7 +2194,7 @@ static void reada_for_search(struct
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (nr =3D=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nr--;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (path->reada =3D=
=3D READA_FORWARD) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (path->reada =3D=
=3D READA_FORWARD || path->reada =3D=3D
>> READA_FORWARD_FORCE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nr++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (nr >=3D nritems)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> @@ -2205,12 +2205,15 @@ static void reada_for_search(struct
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 search =3D btrf=
s_node_blockptr(node, nr);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((search <=3D target &&=
 target - search <=3D 65536) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((path->reada =3D=3D RE=
ADA_FORWARD_FORCE) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s=
earch <=3D target && target - search <=3D 65536) ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (search > target && search - target <=3D 65536)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 readahead_tree_block(fs_info, search);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nread +=3D blocksize;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nscan++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (path->reada =3D=3D REA=
DA_FORWARD_FORCE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((nread > 65=
536 || nscan > 32))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index d404cce8ae40..808bcbdc9530 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -353,7 +353,7 @@ struct btrfs_node {
>> =C2=A0=C2=A0 * The slots array records the index of the item or block =
pointer
>> =C2=A0=C2=A0 * used while walking the tree.
>> =C2=A0=C2=A0 */
>> -enum { READA_NONE, READA_BACK, READA_FORWARD };
>> +enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE };
>> =C2=A0 struct btrfs_path {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *nodes[BTRFS_MAX_L=
EVEL];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int slots[BTRFS_MAX_LEVEL];
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 0d6e785bcb98..78fd65abff69 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D btrfs_alloc_path();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!path)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;=

>> +=C2=A0=C2=A0=C2=A0 path->reada =3D READA_FORWARD_FORCE;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * uuid_mutex is needed only if we=
 are mounting a sprout FS


--PSLQ3v73p37nWbgPX258oxqYERoXR9xnL--

--mlRMY68DA2QAMmYm2zqnAD6NEE3Vsmjkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8CwdoACgkQwj2R86El
/qiVngf/c+ZYEytOSN7vwsPOVpLlgnj3ETWDdCWM6L7FNYB4qVzwXEcrXCg31qr8
xOkflYzIWNA+nB5uCBT+1bDdNmJfoHPORqO3VzN41NdMe/3nEZLdf7Akycnh0II1
7ztHDtPDeAwa3UlbnqeJeo3/jv+c1nXcXS5Xtyp1huntmxrXRor25LgQULRqk4bx
HH7SKbSntnf9e+8+9pIMIlVtrrR2QzVTmvbatj7cmdjWev7S36V5w+COdqUnA7G9
gcb4V3xfj+/vMCitz7zSJWVjwW5Ihs1B3+jCJHcf09iP1qb73mto+UpK8vG8+ltf
A2FrBAydokvNAkXZlowpJJQw/kFhpA==
=hZsZ
-----END PGP SIGNATURE-----

--mlRMY68DA2QAMmYm2zqnAD6NEE3Vsmjkt--
