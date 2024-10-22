Return-Path: <linux-btrfs+bounces-9055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A925D9A9A45
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A9CB211E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963E0146D59;
	Tue, 22 Oct 2024 06:53:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB1C8FE;
	Tue, 22 Oct 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580004; cv=none; b=lJC0c+sA/hGfn2gsDbWkz1MRcpfw3lfG6CukeSoxEAG09QpiGmSMRhZjifWYRbNMxMoBg7jIXQEsZsSFQEkw82UQT7StO5IwIcYHAtLalpUYgpRitdo8n0LXKAsg+s0JIs+q0/+pSYZsiQWrlCJCvhcTyThvlJhxSCyRM/DZFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580004; c=relaxed/simple;
	bh=JbyQaJQwFDvjHRavjVioBV612kkFzFCJwAMBOWr+Ujg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sy7t5Wb+jKdvAY+j7GRqLAzsV9lOU5B+N1WZzUcj2OruA0GW2+8o0s3FyIYE948jGqaA/pCnOV8rnO5tTzuL35BWHmWkfWWH9Pgymxdc1dgD6payI9E2kOJyUT/TC/1si3pC0dJmCgY36tHXZyue6B5m6Y+J4Z+yTq5R3z7AQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XXjSn2L8bz1HLPl;
	Tue, 22 Oct 2024 14:48:57 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 04EBB180042;
	Tue, 22 Oct 2024 14:53:17 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 14:53:16 +0800
Message-ID: <4cefb5b1-648b-58f6-abd7-d3cabfe507ec@huawei.com>
Date: Tue, 22 Oct 2024 14:53:16 +0800
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
 <01b2539f-6560-baa2-d968-5675f0ff2815@huawei.com>
 <89f8474b-c7da-470f-b145-a73088ee381c@wdc.com>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <89f8474b-c7da-470f-b145-a73088ee381c@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/22 14:37, Johannes Thumshirn wrote:
> On 22.10.24 05:22, Yue Haibing wrote:
>> On 2024/10/21 16:25, Johannes Thumshirn wrote:
>>> On 19.10.24 11:07, Yue Haibing wrote:
>>>> Return NULL instead of passing to ERR_PTR while ret is zero, this fix
>>>> smatch warnings:
>>>>
>>>> fs/btrfs/dir-item.c:353
>>>>    btrfs_search_dir_index_item() warn: passing zero to 'ERR_PTR'
>>>>
>>>> Fixes: 9dcbe16fccbb ("btrfs: use btrfs_for_each_slot in btrfs_search_dir_index_item")
>>>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>>>> ---
>>>>    fs/btrfs/dir-item.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
>>>> index 001c0c2f872c..cdb30ec7366a 100644
>>>> --- a/fs/btrfs/dir-item.c
>>>> +++ b/fs/btrfs/dir-item.c
>>>> @@ -350,7 +350,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
>>>>    	if (ret > 0)
>>>>    		ret = 0;
>>>>    
>>>> -	return ERR_PTR(ret);
>>>> +	return ret ? ERR_PTR(ret) : NULL;
>>>>    }
>>>>    
>>>>    struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
>>>
>>> The only caller to this is in btrfs_unlink_subvol(), which does the
>>> following:
>>>
>>>
>>>                    di = btrfs_search_dir_index_item(root, path, dir_ino,
>>> 						  &fname.disk_name);
>>>                    if (IS_ERR_OR_NULL(di)) {
>>>                            if (!di)
>>>                                    ret = -ENOENT;
>>>                            else
>>>                                    ret = PTR_ERR(di);
>>>                            btrfs_abort_transaction(trans, ret);
>>>                            goto out;
>>>                    }
>>>
>>> to do:
>>>
>>> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
>>> index d3093eba54a5..e755228d909a 100644
>>> --- a/fs/btrfs/dir-item.c
>>> +++ b/fs/btrfs/dir-item.c
>>> @@ -345,10 +345,7 @@ btrfs_search_dir_index_item(struct btrfs_root
>>> *root, struct btrfs_path *path,
>>>                           return di;
>>>           }
>>>           /* Adjust return code if the key was not found in the next leaf. */
>>
>>
>> ret is output variable of btrfs_for_each_slot, that return value can be 0, if a
>> valid slot was found, 1 if there were no more leaves, and < 0 if there was an
>> error.
>>
> 
> Yes.
> 
>>> -       if (ret > 0)
>>> -               ret = 0;
>>> -
>>> -       return ERR_PTR(ret);
>>> +       return ERR_PTR(-ENOENT);
>>
>> This overwrite other ret code, which expecting return to upstream caller
> 
> Right for ret < 0, but for ret >= 0 we set it to 0 and then do return 
> (void*)0 a.k.a. return NULL.
> 
>>
>>>    }
>>>
>>>    struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle
>>> *trans,
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 35f89d14c110..00602634db3a 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -4337,11 +4337,8 @@ static int btrfs_unlink_subvol(struct
>>> btrfs_trans_handle *trans,
>>>            */
>>>           if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
>>>                   di = btrfs_search_dir_index_item(root, path, dir_ino,
>>> &fname.disk_name);
>>> -               if (IS_ERR_OR_NULL(di)) {
>>> -                       if (!di)
>>> -                               ret = -ENOENT;
> 
> 
> and then set it to ENOENT if it is NULL. So it should be
> 
> if (ret >= 0)
> 	ret = -ENOENT;
> return ERR_PTR(-ENOENT);

Here should be
return ERR_PTR(ret);

Will rework and send v2, thanks!
> 
> and in the caller
> 
> if (IS_ERR(di)) {
> 	ret = PTR_ERR(di);
> 	btrfs_abort_transaction(...);
> 	break;
> }
> 
> 

