Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38210F9E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 09:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfLCIdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 03:33:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCIdx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 03:33:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B2160C238957AF1B488A;
        Tue,  3 Dec 2019 16:33:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 16:33:44 +0800
Subject: Re: [PATCH] btrfs: remove unused condition check in
 btrfs_page_mkwrite()
To:     Omar Sandoval <osandov@osandov.com>
CC:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <a84442bc-304b-2514-272e-ea89aae4b992@huawei.com>
 <20191203082426.GC829117@vader>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <4796f90f-ca5d-7b7c-5645-034af21d7c8b@huawei.com>
Date:   Tue, 3 Dec 2019 16:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191203082426.GC829117@vader>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/3 16:24, Omar Sandoval wrote:
> On Tue, Dec 03, 2019 at 04:16:43PM +0800, Yunfeng Ye wrote:
>> The condition '!ret2' is always true. so remove the unused condition
>> check.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> For this sort of change, one should mention how the code got in this
> state. In this case, commit 717beb96d969 ("Btrfs: fix regression in
> btrfs_page_mkwrite() from vm_fault_t conversion") left behind the check
> after moving this code out of the goto.
> 
ok, I will update the comment, thanks.

> Ohter than that,
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
>> ---
>>  fs/btrfs/inode.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 56032c518b26..eef2432597e2 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -9073,7 +9073,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>>  		ret = VM_FAULT_SIGBUS;
>>  		goto out_unlock;
>>  	}
>> -	ret2 = 0;
>>
>>  	/* page is wholly or partially inside EOF */
>>  	if (page_start + PAGE_SIZE > size)
>> @@ -9097,12 +9096,10 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>>
>>  	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
>>
>> -	if (!ret2) {
>> -		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
>> -		sb_end_pagefault(inode->i_sb);
>> -		extent_changeset_free(data_reserved);
>> -		return VM_FAULT_LOCKED;
>> -	}
>> +	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
>> +	sb_end_pagefault(inode->i_sb);
>> +	extent_changeset_free(data_reserved);
>> +	return VM_FAULT_LOCKED;
>>
>>  out_unlock:
>>  	unlock_page(page);
>> -- 
>> 2.7.4
>>
> 
> .
> 

