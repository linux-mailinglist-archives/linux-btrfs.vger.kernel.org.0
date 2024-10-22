Return-Path: <linux-btrfs+bounces-9052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A79A96FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 05:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309D21C21D34
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 03:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054F13D8A3;
	Tue, 22 Oct 2024 03:22:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF5131BDD;
	Tue, 22 Oct 2024 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567373; cv=none; b=m2sV+PV059x/zmLmlmr75MwFD7rchyB87Q0PNiWyEIqiUKbTqKsXMY+VKcbEAlpoLbPcAZAsfdzqVNbl1gQb/sUHwC97gMwZVMR18VlDA9XtjuYfPeq6vJcIlo1b88qnvfRFxDzUrxPpRvk0vt04NvwpcO8zw7pUftqVy9T7atA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567373; c=relaxed/simple;
	bh=4WQxofcJ5PFyyEzTnDLGFHKpPbVeOo9/j6MAB8rUbvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IfrbBRsAYbkxNTuM4RFxLE/hq6SlAsepNZQfPl2LFL/iKZ6zZFJszNuJK82kAAWR8WcTvtML1khFP8ygfpW4z+lXfq5/Xd1yLSm1X18Rk9EkOVuJ5ZVmoruaGUn720mhS6fJ0+LSAHPlNTeXtSsPLXx6MiOQyIXdK8TBvYab3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XXctw2TtSz1ynKb;
	Tue, 22 Oct 2024 11:22:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 57A1814010D;
	Tue, 22 Oct 2024 11:22:41 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 11:22:40 +0800
Message-ID: <01b2539f-6560-baa2-d968-5675f0ff2815@huawei.com>
Date: Tue, 22 Oct 2024 11:22:40 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "clm@fb.com"
	<clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "mpdesouza@suse.com"
	<mpdesouza@suse.com>, "gniebler@suse.com" <gniebler@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241019092357.212439-1-yuehaibing@huawei.com>
 <7daf798c-64e1-4d22-9840-8954db354c9a@wdc.com>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <7daf798c-64e1-4d22-9840-8954db354c9a@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/21 16:25, Johannes Thumshirn wrote:
> On 19.10.24 11:07, Yue Haibing wrote:
>> Return NULL instead of passing to ERR_PTR while ret is zero, this fix
>> smatch warnings:
>>
>> fs/btrfs/dir-item.c:353
>>   btrfs_search_dir_index_item() warn: passing zero to 'ERR_PTR'
>>
>> Fixes: 9dcbe16fccbb ("btrfs: use btrfs_for_each_slot in btrfs_search_dir_index_item")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>   fs/btrfs/dir-item.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
>> index 001c0c2f872c..cdb30ec7366a 100644
>> --- a/fs/btrfs/dir-item.c
>> +++ b/fs/btrfs/dir-item.c
>> @@ -350,7 +350,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
>>   	if (ret > 0)
>>   		ret = 0;
>>   
>> -	return ERR_PTR(ret);
>> +	return ret ? ERR_PTR(ret) : NULL;
>>   }
>>   
>>   struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
> 
> The only caller to this is in btrfs_unlink_subvol(), which does the 
> following:
> 
> 
>                   di = btrfs_search_dir_index_item(root, path, dir_ino,
> 						  &fname.disk_name);
>                   if (IS_ERR_OR_NULL(di)) {
>                           if (!di)
>                                   ret = -ENOENT;
>                           else
>                                   ret = PTR_ERR(di);
>                           btrfs_abort_transaction(trans, ret);
>                           goto out;
>                   }
> 
> to do:
> 
> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> index d3093eba54a5..e755228d909a 100644
> --- a/fs/btrfs/dir-item.c
> +++ b/fs/btrfs/dir-item.c
> @@ -345,10 +345,7 @@ btrfs_search_dir_index_item(struct btrfs_root 
> *root, struct btrfs_path *path,
>                          return di;
>          }
>          /* Adjust return code if the key was not found in the next leaf. */


ret is output variable of btrfs_for_each_slot, that return value can be 0, if a
valid slot was found, 1 if there were no more leaves, and < 0 if there was an
error.

> -       if (ret > 0)
> -               ret = 0;
> -
> -       return ERR_PTR(ret);
> +       return ERR_PTR(-ENOENT);

This overwrite other ret code, which expecting return to upstream caller

>   }
> 
>   struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle 
> *trans,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 35f89d14c110..00602634db3a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4337,11 +4337,8 @@ static int btrfs_unlink_subvol(struct 
> btrfs_trans_handle *trans,
>           */
>          if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
>                  di = btrfs_search_dir_index_item(root, path, dir_ino, 
> &fname.disk_name);
> -               if (IS_ERR_OR_NULL(di)) {
> -                       if (!di)
> -                               ret = -ENOENT;
> -                       else
> -                               ret = PTR_ERR(di);
> +               if (IS_ERR(di)) {
> +                       ret = PTR_ERR(di);
>                          btrfs_abort_transaction(trans, ret);
>                          goto out;
>                  }
> This is completely untested though and needs to be re-checked if it's 
> even correct.

