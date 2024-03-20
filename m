Return-Path: <linux-btrfs+bounces-3481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA18818FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 22:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF9B2837CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A63285955;
	Wed, 20 Mar 2024 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="K4C37thQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A304F8B2
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969601; cv=none; b=m2pcv7Iw5hQn5wqe/S3vrFtd8R4Ra5DBc+qKFv8Xax58IPpCn6/rE0mhBhEoRA88Vd5riBVh8lESRoUi6YFzkFzjnKwCwnrjrFTBLP/4A9dYjSoXSikzY5yxWWo3QN8ZzTVVBOc8/o8f/u4KJvHR0XyMyDvBXhhDxD0ph3LQC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969601; c=relaxed/simple;
	bh=O0NyS2tAlYjn72Mc5iGSUnA9rKMdkK2ylPJexRPn9BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kczs/Cfy9vKeTV0mx5/9boAZcZM0EnZpJXiIOj8974EMzbWwNXbdQlMA35jEZpVBllh1lUGP3W25HUSXQpghuPCzOH5QbdCnr5qEyEkZjeK3g22rv1UpVGT5mA9wt2E6l8eM6h7iqQnVUb4jnoU0+wruOKipN1gkBgji91CW5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=K4C37thQ; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id n3JHrElBYwDoyn3JHr66ks; Wed, 20 Mar 2024 22:17:19 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1710969439; bh=iL1e33md96VwKNQwarO8vX0OoIcPitoCyjAlT7+Myps=;
	h=From;
	b=K4C37thQUhpxmO8IWrWD4GERAtzn7jAqXz5p7lLObJpnFTnOT8IvtBWFa6gKBTCyI
	 Ng+Z29ES8e9PDIXRdDzoqZg+nwzvSjlUIWcJxraPcRDipAk/lrVnPl47F3WekzH6wh
	 ltuV1bTQ93fbAuaoWlXSBnHBk66YPDulezDDzHu55OeG75TbdbIu/Fkr11F0fbHynv
	 XQFJwP3szq7dh+3WT9+HV2QYU8zIqBxrHsU3lacUMysc3JpFbAgQna5PwgE6a2EF64
	 rFtZZIodal68MUJ5OQiT4bAhMdXEiCz2CqkVIBj+/mhzyLK6erOhhW3xq7K2fwCFzM
	 x8nf37YN1MFrw==
X-CNFS-Analysis: v=2.4 cv=N5qKFH9B c=1 sm=1 tr=0 ts=65fb525f cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=CDD-V8FDm4eWBCFA3boA:9 a=QEXdDO2ut3YA:10
 a=cMe9W2YZAC63McFW2YE1:22
Message-ID: <38144688-ec35-4c35-bf5b-4e7a581c4d1f@libero.it>
Date: Wed, 20 Mar 2024 22:17:19 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 01/29] btrfs: btrfs_cleanup_fs_roots rename ret to ret2
 and err to ret
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOie61XDtljm5i0Qv70xMSq6rNr7dNTxpq2MmAAkNNLV/bB3T1rj5whmGmJKKmse+WBzuX5iGz3GNNNldACjJoz5kYjqGrrpNO6nLuKuEMZBQPlIW+e0
 i5nPGVUiT+1wJgej2dE6XF6rO4l860RfxWJSFiIjX2SjZodPLvqfX+2aI0Q2NJ67xojE3E6rdWR1Pw0srQc8SvROuCe5S3dt/8OhoThTcUWAmm4boEts0Zlt

On 19/03/2024 15.55, Anand Jain wrote:
> Since err represents the function return value, rename it as ret,
> and rename the original ret, which serves as a helper return value,
> to ret2.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/disk-io.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3df5477d48a8..d28de2cfb7b4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2918,21 +2918,21 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>   	u64 root_objectid = 0;
>   	struct btrfs_root *gang[8];
>   	int i = 0;

I suggest to change also the line above in
         unsigned int = 0;

This to avoid a comparation signed with unsigned in the two for() loop.
In this case this should be not a problem but in general is better to avoid
mix signed and unsigned.


> -	int err = 0;
> -	unsigned int ret = 0;
> +	int ret = 0;
> +	unsigned int ret2 = 0;

In this *specific* case, instead of renaming 'ret' in 'ret2', it would be better
rename 'ret' in 'items_count' or something like that. This because
radix_tree_gang_lookup() doesn't return a status (ok or an error), but the number of
the items found.

>   
>   	while (1) {
>   		spin_lock(&fs_info->fs_roots_radix_lock);
> -		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> +		ret2 = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>   					     (void **)gang, root_objectid,
>   					     ARRAY_SIZE(gang));
> -		if (!ret) {
> +		if (!ret2) {
>   			spin_unlock(&fs_info->fs_roots_radix_lock);
>   			break;
>   		}
> -		root_objectid = gang[ret - 1]->root_key.objectid + 1;
> +		root_objectid = gang[ret2 - 1]->root_key.objectid + 1;
>   
> -		for (i = 0; i < ret; i++) {
> +		for (i = 0; i < ret2; i++) {
>   			/* Avoid to grab roots in dead_roots. */
>   			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>   				gang[i] = NULL;
> @@ -2943,12 +2943,12 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>   		}
>   		spin_unlock(&fs_info->fs_roots_radix_lock);
>   
> -		for (i = 0; i < ret; i++) {
> +		for (i = 0; i < ret2; i++) {

Comparation signed (i) with unsigned (ret2).

>   			if (!gang[i])
>   				continue;
>   			root_objectid = gang[i]->root_key.objectid;
> -			err = btrfs_orphan_cleanup(gang[i]);
> -			if (err)
> +			ret = btrfs_orphan_cleanup(gang[i]);
> +			if (ret)
>   				goto out;
>   			btrfs_put_root(gang[i]);
>   		}
> @@ -2956,11 +2956,11 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>   	}
>   out:
>   	/* Release the uncleaned roots due to error. */
> -	for (; i < ret; i++) {
> +	for (; i < ret2; i++) {

Comparation signed (i) with unsigned (ret2).

>   		if (gang[i])
>   			btrfs_put_root(gang[i]);
>   	}
> -	return err;
> +	return ret;
>   }
>   
>   /*

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


