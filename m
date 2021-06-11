Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328E93A3BA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 08:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFKGIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 02:08:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5501 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFKGIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 02:08:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1Vd92BwlzZf3v;
        Fri, 11 Jun 2021 14:03:09 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 14:06:00 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 14:05:59 +0800
Subject: Re: [PATCH -next] btrfs: send: use list_move_tail instead of
 list_del/list_add_tail
To:     <dsterba@suse.cz>, Anand Jain <anand.jain@oracle.com>,
        <linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <yangjihong1@huawei.com>,
        <yukuai3@huawei.com>, <linux-btrfs@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20210608031220.2822257-1-libaokun1@huawei.com>
 <e860684e-959b-d126-bb1d-3214878ab995@oracle.com>
 <20210608141233.GQ31483@twin.jikos.cz>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <f7bea721-cda5-0b20-13e3-28c4bd728063@huawei.com>
Date:   Fri, 11 Jun 2021 14:05:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210608141233.GQ31483@twin.jikos.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for your advice.

I'm about to send a patch v2 with the changes suggested by you.

Best Regards


ÔÚ 2021/6/8 22:12, David Sterba Ð´µÀ:
> On Tue, Jun 08, 2021 at 01:16:21PM +0800, Anand Jain wrote:
>> On 8/6/21 11:12 am, Baokun Li wrote:
>>> Using list_move_tail() instead of list_del() + list_add_tail().
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ---
>>>    fs/btrfs/send.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>> index bd69db72acc5..a0e51b2416a1 100644
>>> --- a/fs/btrfs/send.c
>>> +++ b/fs/btrfs/send.c
>>> @@ -2083,8 +2083,7 @@ static struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
>>>     */
>>>    static void name_cache_used(struct send_ctx *sctx, struct name_cache_entry *nce)
>>>    {
>>> -	list_del(&nce->list);
>>> -	list_add_tail(&nce->list, &sctx->name_cache_list);
>>> +	list_move_tail(&nce->list, &sctx->name_cache_list);
>>>    }
>>
>>    Looks good.
>>    You can consider open-code name_cache_used() as there is only one user.
> Yeah sounds like a good idea, with part of the function comment next to
> the list_move_tail.
> .
