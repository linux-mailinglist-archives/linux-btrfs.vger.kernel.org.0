Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F0631907
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 04:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKUDuC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Nov 2022 22:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUDuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 22:50:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183D51EEF0;
        Sun, 20 Nov 2022 19:50:00 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NFtgF5wHNzmVxP;
        Mon, 21 Nov 2022 11:49:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:49:58 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:49:57 +0800
Subject: Re: [PATCH] btrfs: fix a resource leak in btrfs_init_sysfs()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221119064348.1743-1-thunder.leizhen@huawei.com>
 <a076e281-022f-1f49-b70d-513272ca86cf@gmx.com>
 <afa7552c-d673-b387-d516-38024f417137@gmx.com>
 <c3b20a4b-bb32-27a3-b8a0-2b0b7388a335@gmx.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d017edb7-e2ab-72f8-aa6b-e6671d18f373@huawei.com>
Date:   Mon, 21 Nov 2022 11:49:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c3b20a4b-bb32-27a3-b8a0-2b0b7388a335@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/20 11:29, Qu Wenruo wrote:
> 
> 
> On 2022/11/20 11:11, Qu Wenruo wrote:
>>
>>
>> On 2022/11/19 14:53, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/11/19 14:43, Zhen Lei wrote:
>>>> When btrfs_debug_feature_attr_group fails to be created,
>>>> btrfs_feature_attr_group is not removed.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Wait for a minute, should we call sysfs_unmerge_group() first before calling sysfs_remove_group()?
>>
>> As the sysfs_remove_group() will only remove the btrfs_feature_attr_group, and kset_unregister() will only free btrfs_kset, without removing the added btrfs_static_feature_attr_group.
>>
>> I haven't yet find a function that will remove all children attrs in just one go, or did I miss something?
> 
> Oh, indeed I missed something.
> 
> The following call chain would properly handle every child of a kobj:
> 
> kset_unregister()
> |- kobject_del()
>    |- __kobject_del()
>       |- sysfs_remove_dir()
>          |- kernfs_remove()
>             |- __kernfs_remove()
>                |- do { kernfs_leftmost_descendant(); } while (pos != kn)
> 
> The final do {} while () loop will unlink each child kernel_node and free it.
> 
> This means, as long as we call kset_unregister(), we should be able to free every child of it.

OK, thanks.

> 
> 
> So with or without this patch, the error handling should be fine.
> 
> Although personally speaking, I'd prefer a more explicit cleanup (with extra sysfs_unmerge_group() call) as going through the above call chain is not that straightforward.

Yes, with sysfs_unmerge_group(), the code logic is clearer.

> 
> Thanks,
> Qu
> 
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Qu
>>>> ---
>>>>   fs/btrfs/sysfs.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>>> index 699b54b3acaae0b..947125f2ceaaf96 100644
>>>> --- a/fs/btrfs/sysfs.c
>>>> +++ b/fs/btrfs/sysfs.c
>>>> @@ -2322,7 +2322,7 @@ int __init btrfs_init_sysfs(void)
>>>>   #ifdef CONFIG_BTRFS_DEBUG
>>>>       ret = sysfs_create_group(&btrfs_kset->kobj, &btrfs_debug_feature_attr_group);
>>>>       if (ret)
>>>> -        goto out2;
>>>> +        goto out_remove_group;
>>>>   #endif
>>>>       return 0;
> .
> 

-- 
Regards,
  Zhen Lei
