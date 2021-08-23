Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C03F46E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhHWIul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 04:50:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:53107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235651AbhHWIuk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 04:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629708594;
        bh=kJcryesaVj9S+POEYRptasfmd07G9WNmxipz92lxgc8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R+8K4VQSP5lZyjuGyA9ZmvoGkIR/Sh9AhrTyRfFzzQvHTlNzHBrMbvgav2JfxRhcS
         3f25cKbwdC+BUXpNz7RYXXzGkPLPb/k7Uh3cB6Ue3hdSxGmWmIiDumgywKuNLED+Jo
         bUSJm+NFXYMv7ZIFl8v0ZzK93+Fzad3EfyVbaeFI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5QF-1mDxAr03LL-00FAdn; Mon, 23
 Aug 2021 10:49:54 +0200
Subject: Re: [PATCH 5/9] btrfs-progs: add helper for writing empty tree nodes
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <6692ad0e7a65488ba64f42dce542982d4b7e2047.1629486429.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ac653ba4-5253-436e-b408-706dcfff7815@gmx.com>
Date:   Mon, 23 Aug 2021 16:49:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6692ad0e7a65488ba64f42dce542982d4b7e2047.1629486429.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KhhFkt7tGzgpRE2SUrT6wNtxebxziA2fQKZLSczSplJD9cRpsx9
 kVslnzbNWVz2L5ARFu3aDWeiHnaxYqDjVroNAZJXw9C6dtfCQxq8Cnp03HC5owczI7Ct+KA
 NzX1+9yK85hxQSMIHGlu3OBYqtsuv9ZYyIUy+/RH9k2A4EKbGYHCSYjRenmiUpksu+JRQmN
 z6zl/F70PHXNAidReKblQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sqYX1Ea0hCk=:Ei87h/KTJEnHX/VE/ql7EY
 BLYfvGUWq9ceqY1DutL0A/aUGnqvmo6LeoX+lVbQ+Ou8PvZ3JiMqnHb4PtgBCS3ZqDKsv5LPq
 BEhHkBuQ3xN0jWiOAQASTMxQZrfuTGzPo0nYewT17ETMydo1WFk7MqC+7kfQsVIzw1w2l4xEG
 GHPLI7PnDUMXSKmKMz02C36OtcNPfrhWuuTXd/kixhWTFFkvGrI4r9ImUwf6sPI8c00zy2tYV
 WYvqjxe05+VfCgFR2iRMMYIkwfeqVoeHtbF3+Rn7WrOk8je+EzXPm47l8n9+fsKFdQGJkh25n
 iOUM7Dbs1rjprduOvqjZGUWwQXIUSJuHN74DhrZSZ2RszWM6f1oSkb+BWNTT2Rs+ECnJM71nZ
 Ro+pgIoh9UksSzHG/TRKeE+O2d+nJgEbr7vGLNR1I9Ax9mKsSdwloEGUxLomi3bJBaext3VPi
 ZU+jUo8iYRPxQGsOp1kgkBfYOl9vSs6YIKBfXV0jh/HFXB3tL5B4PIjhyibXfX9dl3+kujNsA
 8MBlMgBStO0og3HxMctjWInKnJnWJk3jfHb5u6rZzJ0HO6Yrozhzf3kGi+VrX5Hi8s+eZh55h
 j6JZM0+ZcFMzI0Xs/SGljmV0z1ogAX76dgR1hoi9jlNELd+iPuKtjl4DntHR2CFcACekweA3G
 Wtu4q59FU5zTvgwyRnMqBsFH1f80GMARZ/iDfiH6wXoRMot0bKH+qb7FyI4kxVXvE3uclE5p7
 fWhXV55UzdpFo4pwQjzYGmZgOMbiN5J565NsP7VNg/W+djUXTQJIhXzm52PYYdrmmMM5P+Snq
 euImSnnL1PypKm0yI/E38hIRI9xEj/SY3dmgJV0qlV5N/VEk1iXOp/K+E6CTem9L3pi274CCX
 SsMuYGO7EiN43Wvqpj1DbeY4qM+//ZT7MBBefciIs2ZuQw9xEZWz7HvUjoVnC05Xt/+wEanCG
 j5Gev6NXQ+J7U1Mb+gCsAA3ltUG+MqeAqDmXtJeNJkgw3fGfzBAziPHb4cjHdrT9lXYu6Db3S
 qjqX31F5SE0WMVGDkLufFCpxVJXox4Ri0yNLBKeBVk7exMvLvGlULUJbSM4Cpyv5k9o/krJqT
 cj/VJ5LiT4ExB4pHbscp9ni/J31qdAppau85L9MK0nt6Jq4M6TNvwambA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
> With extent tree v2 we're going to be writing some more empty trees for
> the initial mkfs step, so take this common code and make it a helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small nitpick on the function naming inliend below.

> ---
>   mkfs/common.c | 47 +++++++++++++++++++++++++----------------------
>   1 file changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 29fc8f12..9263965e 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -39,6 +39,25 @@ static u64 reference_root_table[] =3D {
>   	[MKFS_CSUM_TREE]	=3D	BTRFS_CSUM_TREE_OBJECTID,
>   };
>
> +static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cfg=
,
> +				  struct extent_buffer *buf, u64 objectid,
> +				  u64 block)

Can't we replace the btrfs prefix?

This function is specific to mkfs, and it only works for the initial
btrfs creation.

Thanks,
Qu

> +{
> +	int ret;
> +
> +	memset(buf->data + sizeof(struct btrfs_header), 0,
> +		cfg->nodesize - sizeof(struct btrfs_header));
> +	btrfs_set_header_bytenr(buf, block);
> +	btrfs_set_header_owner(buf, objectid);
> +	btrfs_set_header_nritems(buf, 0);
> +	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
> +			     cfg->csum_type);
> +	ret =3D pwrite(fd, buf->data, cfg->nodesize, block);
> +	if (ret !=3D cfg->nodesize)
> +		return ret < 0 ? -errno : -EIO;
> +	return 0;
> +}
> +
>   static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cf=
g,
>   				  struct extent_buffer *buf,
>   				  const enum btrfs_mkfs_block *blocks,
> @@ -460,31 +479,15 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *c=
fg)
>   	}
>
>   	/* create the FS root */
> -	memset(buf->data + sizeof(struct btrfs_header), 0,
> -		cfg->nodesize - sizeof(struct btrfs_header));
> -	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
> -	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
> -	btrfs_set_header_nritems(buf, 0);
> -	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
> -			     cfg->csum_type);
> -	ret =3D pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]=
);
> -	if (ret !=3D cfg->nodesize) {
> -		ret =3D (ret < 0 ? -errno : -EIO);
> +	ret =3D btrfs_write_empty_tree(fd, cfg, buf, BTRFS_FS_TREE_OBJECTID,
> +				     cfg->blocks[MKFS_FS_TREE]);
> +	if (ret)
>   		goto out;
> -	}
>   	/* finally create the csum root */
> -	memset(buf->data + sizeof(struct btrfs_header), 0,
> -		cfg->nodesize - sizeof(struct btrfs_header));
> -	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
> -	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
> -	btrfs_set_header_nritems(buf, 0);
> -	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
> -			     cfg->csum_type);
> -	ret =3D pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TRE=
E]);
> -	if (ret !=3D cfg->nodesize) {
> -		ret =3D (ret < 0 ? -errno : -EIO);
> +	ret =3D btrfs_write_empty_tree(fd, cfg, buf, BTRFS_CSUM_TREE_OBJECTID,
> +				     cfg->blocks[MKFS_CSUM_TREE]);
> +	if (ret)
>   		goto out;
> -	}
>
>   	/* and write out the super block */
>   	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
>
