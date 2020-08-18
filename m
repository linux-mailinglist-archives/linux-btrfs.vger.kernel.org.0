Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B4D247FD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 09:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRHvI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 03:51:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:48885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbgHRHvG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 03:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597737062;
        bh=B8id+7Egb4ZOp8EtNovEMW+RPwp+gM+rGm4jB66H3dc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k+lApNOnIaOYJ9ORw5meZjpKi4VVLvsMZFRiUydJk9z246nil/Cfhy6+ujGUYjNfW
         gx2ndndrOFEmw4lolR6M/IWpG04hnRUqKUuBKjqh1rq1a7s2lQ4aJWzvyEjuJijhbg
         p2cZ+4RxMonCq4DuFQhzqMvKGylOo8eeZiHMc5jE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOA3P-1kIk9c28U5-00OaAq; Tue, 18
 Aug 2020 09:51:02 +0200
Subject: Re: [PATCH] btrfs: Merge inode_can_compress in inode_need_compress
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200818063056.9094-1-nborisov@suse.com>
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
Message-ID: <662ce31b-7996-0a96-85d1-3872afa452e8@gmx.com>
Date:   Tue, 18 Aug 2020 15:50:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818063056.9094-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Dftp5E+aOEtUHYtBqXTuk4fQryj1zIqw44Km3t5Ihx2s1GDia6
 D29ufxDMiyBF1EAYZoghc5jstFI3q4aK4lDZXeLrEcVhS9qmRuPWuLU+KJ2FaNBMs5QpxoO
 rAeO3Qj/w0OcYvuo4Tl1uhp1Tz4MY1pzwB6/+HQG2UMF0xcVQ4DBq+dUaMH7Wio5jlIUkY6
 KIW2Pmy4v8jJyL0Lc1pNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uSngnqOCN5A=:w3BYoE7+boGZri7YhOeJOs
 6oG37rlLr6WEb2E3xmS3SHadoMposBQT8L5N/6oCAtGUVgM+b4b7NJUbuHvYiSgt96EDI+N3w
 wXQsSnntAR7hSJIIvt/BYwfjinUUjczYtwhRa9Fmq233Nd4WDP6RojKHgv5XHCVsB2/GYl4rv
 43wenXTLHows3Ec5DKQi8Fpe8AQZdZJaKyFpXhBTYFmM8J4Y00cu7rAaONrBALgIMMA3r+JwE
 sao/o3jo7M9ZGHHUIiBSa3cUPLiNaw/u0dVFaVrm8648k8tN3CZuDNyCc1gRlSExJ9WcqISDD
 ZzIr3+VM93G08Z/bs7cG/357ryhEmlz6TCUTgND1uAYrurofwU50hJ0ZpX57f0qDfU1IWNXqC
 X0Zrxq2F1roUtYpyjIZVOTZArocMO4IZBN1+BgKG9J46YZXDVb5hvarnnzTsNwriTKxUNDcxF
 YmA9TCR1kC5VBXciaYVrNdfqjSnfcB84sVonb7bteyPP2nAexQFQDoTZp5A2p2//MEvFyKgw1
 LInAwlD+2SvPB8j5z2CwEsDri3bXzMUTaUXfQQlaPZiDn/6jrnsPXpg57sByejxmjAso507ja
 z73ZWfAg+1OFq/QjfwgCo2tKs79TsKmsoFipPa+IBb2SEcQWFasj+sJfqPdj3UIPNMMc3VRes
 0KPSOg76yp8bPJP4hf6EPQlCAQGCZaMBpR12yoOtmeaRHXPgSlBmH7DtF+1eN+ErR+/vX/NR1
 N7tdiLOrXOn9A88ufNoRSob+8bFj3B4F7bqPmE1PAeJOC9II8U9SI1KICZbx1G1Adjv+zUW6b
 Qd6t2pXTd5s0HN+YWm+kbnTzqk1+XjEFja1/ARDkKMOW+TU7sK9/4RGDE2Zr9tZP/Yayc5ux7
 EMXOQ55k+BhmytBeuW92EpcrxhA0jIIDP799NGFHlg2hiHB6uvgztz42UBFOynHjEV+x5zl9x
 svn7XGAZm7Ql69tfecPUtKMCUZXv8eywRCCSf8rFTwSTovXb9yQGG0lHBMMQD4Vv0sPMWrPzo
 p1PwymXXfehzjhRnPfYIU6mTXWQqbNyystyOVKs7pxY3OYtAkmjDgj4bVqWIfo36DT3VpGwkM
 F1bW/UtlVD32irFJWsAVIVPimzXwXxMZ/UVhORxibDlM9uKc+W/sYy2ojM08RACgiLdn0pb2c
 sTtftFyhZc0egRb2gnLaSdG32M0lAAEbOWO/OE44sucjWsE4rVyIJW/DdXy0rKsGyWW51+kM2
 S4AF8XpZ06ZWV6xRfvESp1FlaBEJLlcwY3xMwLA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/18 =E4=B8=8B=E5=8D=882:30, Nikolay Borisov wrote:
> The latter is the only caller of the former. Just open code can_compress
> into need_compress and also remove the warning since it's made redundant
> by this change.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>  fs/btrfs/inode.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 15dc8b6871ac..19e1918bad5c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -410,17 +410,6 @@ static noinline int add_async_extent(struct async_c=
hunk *cow,
>  	return 0;
>  }
>
> -/*
> - * Check if the inode has flags compatible with compression
> - */
> -static inline bool inode_can_compress(struct btrfs_inode *inode)
> -{
> -	if (inode->flags & BTRFS_INODE_NODATACOW ||
> -	    inode->flags & BTRFS_INODE_NODATASUM)
> -		return false;
> -	return true;
> -}
> -
>  /*
>   * Check if the inode needs to be submitted to compression, based on mo=
unt
>   * options, defragmentation, properties or heuristics.
> @@ -430,12 +419,9 @@ static inline int inode_need_compress(struct btrfs_=
inode *inode, u64 start,
>  {
>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>
> -	if (!inode_can_compress(inode)) {
> -		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
> -			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
> -			btrfs_ino(inode));
> +	if (inode->flags & BTRFS_INODE_NODATACOW ||
> +	    inode->flags & BTRFS_INODE_NODATASUM)
>  		return 0;
> -	}
>  	/* force compress */
>  	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
>  		return 1;
> @@ -1833,8 +1819,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *i=
node, struct page *locked_page
>  	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
>  		ret =3D run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, 0, nr_written);
> -	} else if (!inode_can_compress(inode) ||
> -		   !inode_need_compress(inode, start, end)) {
> +	} else if (!inode_need_compress(inode, start, end)) {
>  		ret =3D cow_file_range(inode, locked_page, start, end,
>  				     page_started, nr_written, 1);
>  	} else {
>
