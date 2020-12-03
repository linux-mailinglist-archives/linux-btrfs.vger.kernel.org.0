Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596532CCEC6
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgLCFpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:45:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:59855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbgLCFpv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606974254;
        bh=rwil77U2WjN+jFRF4EpFmwg6FQXf+pimXOC5gZGoZAU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GhrsTB9Tvwlg5ceCfgOhTA+5+jWUF6PpsVkGkHGtcsHlWZsBKS3ZLorL/tDOF+MtP
         JXjZu25ti9QYmdxVv4y0goNVBjAj9xKqULaGeQnF6ruULOoNbBZOnpBJvMBVRMbsuO
         IXSXVJ2d15cM7H661l8ih3GJEyNcynQ7ms+TlrFQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCKBc-1ku0nn2Rz0-009M9D; Thu, 03
 Dec 2020 06:44:14 +0100
Subject: Re: [PATCH v3 52/54] btrfs: print the actual offset in
 btrfs_root_name
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <3575cc74f0d9f63647e92082979fa8cfd3901e90.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <3489ca09-8e7d-41e4-27ab-5f65c1b6d801@gmx.com>
Date:   Thu, 3 Dec 2020 13:44:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3575cc74f0d9f63647e92082979fa8cfd3901e90.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3jexgDSP9pSIY5PGEGSP0YlvigMuEAzKG"
X-Provags-ID: V03:K1:2HnbJ3nv8poNXiBKyl7ZOxqjmmQGAGcaH4kQNb/1lyb0n91uIF8
 Zy1dO/CXgDDtsiqthiX5BDkPLtIfNqI3fd9QmL/68HIOKosEzETTddiS+tBQvl6gkwhcSar
 cw5FekXxCFUtCFlIow5HamMV+DbLZTHfWVOVV2jhNJEfsqOlrLxYpJyDyf4X+JjGiZ3Gcdj
 W1l2cyZ8LBI8npUD+qy2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C2Z3QAx8MiI=:wL812XyNEU2oBi/9P1tHF4
 r7fsv4XhkGInpniHyyQI1FoEsPGI3HLlcT/71kYNY27p4voVfBBNuaj1rmxb4SCNiUWQIQ3Z9
 s/8LlmKwdZuJ2zobhzAnTw4HzoVRCfmDe4oC1lzet4o+GaBEFJZ0RxhWwJnoyi9oJD+hSChek
 gZ3npOf0l2x5JfUfR5FSOsreTKP0V0H55zwA1Y817q6+n8KuyJe+vup8gJI2qZjASjqeKaDvr
 +x68qspoQOW9hFcvGfRI7HU7cVrU4RFcoldXxI+acMfDaI4rlNUDnk3rBXiK8TE7EzI/J7Ho8
 mOVIOCvh7YtfzRijEx0w4oebvj1vE3sih+sfo1oQGwrcOdq/rJEp5BdaL881OLZ/zTw5GhU8i
 yiwinsZDFJHe0nMDTFRCf3XLc7lAmfPPxq/6ZOqVjr11gLUSAFOfxT7ipH/lS3CS+Z42MqAKE
 KvnU5WslusoP1UEik7JJjlMSrV/N8mZ11oH6gbPMzrP4zOMRJ9vXhcc26OKciym7gDSY96pAB
 zkgrkhEDhZWMqLeUFZCULwZ1EWUwwYUNBP0nDuKAbkt9zMbYfg2yX3HwEweqil4Oy3zUE3rn+
 /ZA1BUqBgrI47n2bWSA3UF8p1QcYGrSV1zp2giinM/R4+Al3KAP2LJbzI5oEbRGsJ6tULVNBN
 ObIk1l06n16fo9kddIi37RwOlxQ25w+nimzTY00HjKPwAZsUulgolXNRPcMY647Jpzj9ZFfOi
 wDczbvGdeKCbvghb3OKGH58f+EHfpGUI5mE4mWz3R0pLmn6/FY6Gzb/8WdWUemrAij/1OYhuu
 IHow3+wEumy21hQ8Usr9oywy7zFFjeEdAGJM81mB29y4JxhqbcOKnoLWzfN9YHVLy5KnY1zlc
 lD/xNcZ/sgfYwfGfDDkNvbL15TqolEJBjNl4IxJzw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3jexgDSP9pSIY5PGEGSP0YlvigMuEAzKG
Content-Type: multipart/mixed; boundary="fZCpdppZVvaZesvAw5WcDUE0yoakKvz74"

--fZCpdppZVvaZesvAw5WcDUE0yoakKvz74
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> We're supposed to print the root_key.offset in btrfs_root_name in the
> case of a reloc root, not the objectid.  Fix this helper to take the ke=
y
> so we have access to the offset when we need it.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

THanks,
Qu

> ---
>  fs/btrfs/disk-io.c    |  2 +-
>  fs/btrfs/print-tree.c | 10 +++++-----
>  fs/btrfs/print-tree.h |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 46dd9e0b077e..c73d172aa1f7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1458,7 +1458,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_inf=
o *fs_info)
>  		root =3D list_first_entry(&fs_info->allocated_roots,
>  					struct btrfs_root, leak_list);
>  		btrfs_err(fs_info, "leaked root %s refcount %d",
> -			  btrfs_root_name(root->root_key.objectid, buf),
> +			  btrfs_root_name(&root->root_key, buf),
>  			  refcount_read(&root->refs));
>  		while (refcount_read(&root->refs) > 1)
>  			btrfs_put_root(root);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index fe5e0026129d..b8137dbf6a3a 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -26,22 +26,22 @@ static const struct root_name_map root_map[] =3D {
>  	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
>  };
> =20
> -const char *btrfs_root_name(u64 objectid, char *buf)
> +const char *btrfs_root_name(struct btrfs_key *key, char *buf)
>  {
>  	int i;
> =20
> -	if (objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID) {
> +	if (key->objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID) {
>  		snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN,
> -			 "TREE_RELOC offset=3D%llu", objectid);
> +			 "TREE_RELOC offset=3D%llu", key->offset);
>  		return buf;
>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(root_map); i++) {
> -		if (root_map[i].id =3D=3D objectid)
> +		if (root_map[i].id =3D=3D key->objectid)
>  			return root_map[i].name;
>  	}
> =20
> -	snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", objectid);
> +	snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", key->objectid);
>  	return buf;
>  }
> =20
> diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
> index 78b99385a503..802628dd1a6e 100644
> --- a/fs/btrfs/print-tree.h
> +++ b/fs/btrfs/print-tree.h
> @@ -11,6 +11,6 @@
> =20
>  void btrfs_print_leaf(struct extent_buffer *l);
>  void btrfs_print_tree(struct extent_buffer *c, bool follow);
> -const char *btrfs_root_name(u64 objectid, char *buf);
> +const char *btrfs_root_name(struct btrfs_key *key, char *buf);
> =20
>  #endif
>=20


--fZCpdppZVvaZesvAw5WcDUE0yoakKvz74--

--3jexgDSP9pSIY5PGEGSP0YlvigMuEAzKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IeyoACgkQwj2R86El
/qhJkAf/ZOyWdWSOvnKkMT1Rw8/V479MgOvnPmM8pNEJxGm8G0z7Bh9ST+BzMEph
kYc38XSWmKaGO5Se/XkeOXlrn9ARaWLLkaKsaox0NGLdZYk2iROVRrOrl7Nbg3va
CAGTXAShK8fUUWEpNdjebQqBkfBT9Yhj5nFUZoYo/m+Uj+aJFBeP6syB5hiV2AY+
DMtqzToGjxmnj7tS64o74QKsV/MIEHg4c/yPX5QcU5vtB2A6ipUofHkXKk4wmVxt
FQumpXNxGmFPhMGVpqJ63mmrqXg1il2PZ4A0NC738BDAysc2PPj8es3oPoV79CbG
IOQRTq4A5CnbR+mAzjLLpnsW5xqfyQ==
=w354
-----END PGP SIGNATURE-----

--3jexgDSP9pSIY5PGEGSP0YlvigMuEAzKG--
