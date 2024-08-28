Return-Path: <linux-btrfs+bounces-7616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8AC9627E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01311C23BC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E148188CAD;
	Wed, 28 Aug 2024 12:53:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AE17C9BA;
	Wed, 28 Aug 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849629; cv=none; b=st98vM4nE0rUdRY9kXxbzK9H/BR28QVwvQ6Vdekvc0HL/luFnipiFJfpiMrAs/L0LEzdNOlgxc/tV1ixOG8M6DYChw6hLlvj4grIWP2dk53KGR7orE3f3OHio4ogC7btMtaxzCJeEZPeiVLKg4G1tn+PiGoJFqnyfK2Z8fWDHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849629; c=relaxed/simple;
	bh=iJABBce2yqZMbaxDvBMY/LZjkjggxq+k4dcuQAm1i5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XZWDfH4E24OMXZpK5IJ6mGwT4iD9FiUHQwUxPfQD2VMrn8AtDVHmnqjD9X4Nrn9Xrna9MvOQnL7irz+5LiGjaKLFt8Ul77t0N4eLf2+nN0iFHfC41/ygtTIGi93aYBjIZcmdkF4wnF0ytfoiyvkjoGxvvQE4zkzsSBmuNcza9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wv43X2QMSz20n22;
	Wed, 28 Aug 2024 20:48:56 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id C46471A016C;
	Wed, 28 Aug 2024 20:53:45 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 28 Aug 2024 20:53:45 +0800
Message-ID: <40421bdb-4573-4768-8d6d-39b0d0df9260@huawei.com>
Date: Wed, 28 Aug 2024 20:53:44 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] btrfs: Fix reversed condition in
 copy_inline_to_page()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <3a05145b-6c24-4101-948e-1a457b92ea3e@stanley.mountain>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <3a05145b-6c24-4101-948e-1a457b92ea3e@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500018.china.huawei.com (7.185.36.186) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi Dan,

在 2024/8/27 18:21, Dan Carpenter 写道:
> This if statement is reversed leading to locking issues.
> 
> Fixes: 8e603cfe05f0 ("btrfs: convert copy_inline_to_page() to use folio")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This patch is obviously correct but it's from static analysis so additional
> testing would be good as well.
> 
>   fs/btrfs/reflink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 1681d63f03dd..f0824c948cb7 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -146,7 +146,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
>   	btrfs_folio_clear_checked(fs_info, folio, file_offset, block_size);
>   	btrfs_folio_set_dirty(fs_info, folio, file_offset, block_size);
>   out_unlock:
> -	if (IS_ERR(folio)) {
> +	if (!IS_ERR(folio)) {
This is a mistake caused by my carelessness,thank you for the patch
>   		folio_unlock(folio);
>   		folio_put(folio);
>   	}

Can I merge your patch into my patchset and add you as a co-author?

Thanks,
Li Zetao.

