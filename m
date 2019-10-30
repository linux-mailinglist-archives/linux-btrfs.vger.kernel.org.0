Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0ACE9BAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfJ3Mmx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:42:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:56037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJ3Mmx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572439365;
        bh=zEqbnl6OpaDg8CXsY/TNeJlSRbazA+wja4nBBDTNgxk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JXAo90rBTq0/UDb60j+qzdLjFmt3EjfatS9gmRPt8id4TJ8woQVFkAAh0hlcVMJZC
         XRl/lgbZ2WCc8gMtBdQBHe298V5oZIbFIDGgCziPe1Qb5TAY4zTKCcGRbiWSzBUYXq
         q6LRLv2QS5X3+rUNv8QijW1GLEQTadvQyWjJtylw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzBp-1ihBZN3wlF-00HzOT; Wed, 30
 Oct 2019 13:42:45 +0100
Subject: Re: [PATCH 2/3] btrfs-progs: Remove type argument from
 btrfs_alloc_data_chunk
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20191030122227.28496-1-nborisov@suse.com>
 <20191030122227.28496-3-nborisov@suse.com>
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
Message-ID: <3f7170f4-ee07-f77c-bc15-2c3f611fab65@gmx.com>
Date:   Wed, 30 Oct 2019 20:42:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191030122227.28496-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wirR5sFFBufSEKgj/BxiB3RK9FYAKo3CWDkvaGcYSer8tqsuJrn
 Z0YcruWB9L3/SBTAMG9/NEBC8w5uFiwZJiMDr7FGk5vMzJWpObAE0U5tiHeqQqbg3w8dJPh
 NhlENe9gRAPh2QsgzD5Ug1qRy7055SxxbTZ34S/dPKKPakFeI/oJGeaDohSXZSu/rZM+aJB
 2/InWv+iwpjPkBj0u1x/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8O1mSVXUWNY=:hezc0+RsgTm5/Mx640xame
 Hk6D5kBDl7DeY4BkgIQM4ONBsY9brhNN7pznxa/62YNFw6CTkh6ak33b5FNezMFlusIygyegh
 dOi9tA3fmCeGXos8/FbUj7ORFdKBmCUOBDRcUGVTnqQrhyztAAEZIO98BxmLsrTDo81gRWMAm
 GXctOJFzq0g4D2l23qNSk5vwJvJFf29+8mP5l1n2J1McG9pF5Y+Kb8p7apBbEnnSxYekb5Qdr
 0EcWj1eAr+9yZN/Lw4oUfUb1Dd1sBIBGxYM5LopM+FfEwI9DkICuJurde4eCn1VTUO7P5sWWh
 MBi4oRMF/CmKJTB/a5agJMuHNVYcg0kLd/IMZsQLQYy+J3Ax+o/GuxVF3L92C0sTlaRd3Dfxf
 reAucI6X7S3zcD5TEoBm31VbzdNvQh1gG1iIkG3iA1JUSXdwhTUwHPN25nSlRaZGebpLQf75Y
 On9KGz+j0yd1AQKlS6Gc4dKFN5fyBKb/MoG5aPCsYP9bthuMkt+jV39DUsqvM4uJa+0B87HhL
 SYGn0JlYIGQFA8cC2nY/lfmNCBHfrDD7qtV8+ui1VyDoKEUkCZZBcWb8+AXimrtxW5FGPOWXw
 z9CAYlCkiaZ8vUGWPV9VjUUC4Qt1r4yOI4nJ/fkEqoTgk7hsr66uDh0uFzQn4FHPnBeZavDzx
 l0+U6uSCfIKr00mHQfQlJZnO+mCNeqdO1iQWjgwYp0kvc2Ti0FbHt83617WD0BX26f0ULECzh
 bdnyhUuqyeJC8WJN2bj2dI5Dyj4xokfEWmY6fvlk3oN0+CbO4d/rMWTrWtzZS1lr0tqTxWM4a
 ZU4yKrwcBfYalfrcPRpa/Z49RQ2qnjf2EKNF7v2qnzTGZVp5N9GYpymP2fn385EM2TWB7jlaq
 lAvn8vJBrdbuL7421B5q0hdbcXnes2rYdlB02SPk+FFyDSNfCCTMenqqXGoXewBjCw6ptci4o
 4mNbc3Nb1J2u/23WfTrV7ypIs77sBQe5Uekx1P/eCqq/mZEuEh76GjIC3IWGy87fkx9N/g7Vp
 BBT7tCeiZVqJgzrMm3MurZ+3P+TbQqauQmAjT+DEDq5qFmUDhHdRx3BxYvJML0dkP+W7DffRn
 ogY6jhNLAF1tauUl7NdojHtUCipzeAMS46WqjwyNVoR4an0lG2vhiwmHMf7ewyWrbQgejsH9l
 aUF9OMeR8r+qwAO1vl3KpB/DWZEJqV+sPbI/4HxoxU5eltQFCFSDHkh5Wdf/um4jKhbkmmcKd
 LQWIlYF+Bs4sNMGolJ22UzVIobAdKvNHzWJqOgdSN1+ogc4r81xHmf5bn59Q=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/30 =E4=B8=8B=E5=8D=888:22, Nikolay Borisov wrote:
> It's always set to BTRFS_BLOCK_GROUP_DATA so sink it into the function.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  convert/main.c | 3 +--
>  volumes.c      | 6 +++---
>  volumes.h      | 2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/convert/main.c b/convert/main.c
> index bb689be9f3e4..9904deafba45 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -943,8 +943,7 @@ static int make_convert_data_block_groups(struct btr=
fs_trans_handle *trans,
>  			len =3D min(max_chunk_size,
>  				  cache->start + cache->size - cur);
>  			ret =3D btrfs_alloc_data_chunk(trans, fs_info,
> -					&cur_backup, len,
> -					BTRFS_BLOCK_GROUP_DATA, 1);
> +					&cur_backup, len, 1);
>  			if (ret < 0)
>  				break;
>  			ret =3D btrfs_make_block_group(trans, fs_info, 0,
> diff --git a/volumes.c b/volumes.c
> index 1d088d93e788..87315a884b49 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1245,7 +1245,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *t=
rans,
>   */
>  int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *info, u64 *start,
> -			   u64 num_bytes, u64 type, int convert)
> +			   u64 num_bytes, int convert)
>  {
>  	u64 dev_offset;
>  	struct btrfs_root *extent_root =3D info->extent_root;
> @@ -1328,7 +1328,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_hand=
le *trans,
>  	btrfs_set_stack_chunk_length(chunk, num_bytes);
>  	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
>  	btrfs_set_stack_chunk_stripe_len(chunk, stripe_len);
> -	btrfs_set_stack_chunk_type(chunk, type);
> +	btrfs_set_stack_chunk_type(chunk, BTRFS_BLOCK_GROUP_DATA);
>  	btrfs_set_stack_chunk_num_stripes(chunk, num_stripes);
>  	btrfs_set_stack_chunk_io_align(chunk, stripe_len);
>  	btrfs_set_stack_chunk_io_width(chunk, stripe_len);
> @@ -1338,7 +1338,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_hand=
le *trans,
>  	map->stripe_len =3D stripe_len;
>  	map->io_align =3D stripe_len;
>  	map->io_width =3D stripe_len;
> -	map->type =3D type;
> +	map->type =3D BTRFS_BLOCK_GROUP_DATA;
>  	map->num_stripes =3D num_stripes;
>  	map->sub_stripes =3D sub_stripes;
>
> diff --git a/volumes.h b/volumes.h
> index 586588c871ab..83ba827e422b 100644
> --- a/volumes.h
> +++ b/volumes.h
> @@ -272,7 +272,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *tra=
ns,
>  		      u64 *num_bytes, u64 type);
>  int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *fs_info, u64 *start,
> -			   u64 num_bytes, u64 type, int convert);
> +			   u64 num_bytes, int convert);
>  int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		       int flags);
>  int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>
