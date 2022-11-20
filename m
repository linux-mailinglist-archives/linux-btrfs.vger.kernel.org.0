Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9E63125F
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Nov 2022 04:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKTDMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Nov 2022 22:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTDMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Nov 2022 22:12:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91888186;
        Sat, 19 Nov 2022 19:12:10 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbBk-1pFlzb1bXy-00sdaF; Sun, 20
 Nov 2022 04:11:54 +0100
Message-ID: <afa7552c-d673-b387-d516-38024f417137@gmx.com>
Date:   Sun, 20 Nov 2022 11:11:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: fix a resource leak in btrfs_init_sysfs()
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221119064348.1743-1-thunder.leizhen@huawei.com>
 <a076e281-022f-1f49-b70d-513272ca86cf@gmx.com>
In-Reply-To: <a076e281-022f-1f49-b70d-513272ca86cf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OzsYxUUl21+RCryxApEBMGbein91I8wCT8pwHTNWT3gbH2NsobF
 g0cPHzHNNdXbGGkwXw4ydtzEqh+8McTFvvZI4Jx9Xa6xwdaoJfVRbce1Njx574h8z4x18Qm
 Sj8LnpBHSS2gDc+mm9izCfivAlx3LrwCmoa82syacGgydjMgEsEEjkC/UQKWKWqKH1npHpe
 XSAKI2kNlgra4V42aTsLw==
UI-OutboundReport: notjunk:1;M01:P0:7r/f6XYEd6c=;2rKfUYHNomsPBGzs0xo/RNrnK9D
 5Yr0x5SbfYe8yvY2+2iIIInhLnKvjdjSZw9x1MPxaI8c4MGRMh5WFwyv8Obw+hqsBQTJ2BZAG
 jJekXDH9ZGXBTAP2QbErSBjNIfOLbi++rjs+ClSON5rnW7qqMuezM+dHe3EbxKpta97y7JI5r
 ujiesIih7xYTfXMxU52aNjvMT+3Gp/lZxOC4rL8Qa3zZza+UkMj3xsf+vQU8NwsoGec+SBhsR
 Ry+5ZNnhxOiKmu9qDqBdySmXLs8tgzC0XZY7AGmK4omeC6peWCjqXhcSbRQs+isaneJWLer/P
 KqRrhMiYmLbRISMrpKbIYsJqpefHYLLRGWztpMxjzKSk8e8DKw4E4j0Zm+o4VwnY7brjYCll/
 Jk/7WVDx/xtecrJtHFBpgNV0ywaE6TFbm4gJnhmUu3RWFR413lAWqn+BY7kqyP5vXAcBKx/s9
 l01QWA19ZWnn37WmO/Yfb7QNf2kqW49hnQzBsqz+rY2TW96VvrIGHqo8ipbRBzZLJHo3xZV98
 Afo3bWYjFs++Odvg0WaltwMGQwUeo27KfqdsFj0kNDc+DWaV/iES4oyhlVXcYC/soWDn14C1e
 RA7fDAyiSmTWtspsfX3QRBblbs/BVye2Ag4mW5qIFtAX+1mXbVgURxgXmcHJ4oZFa+S2j7Fye
 j5tjQdSLpp1jbUGw/Fak40qPq2l146MsgGfLaH02icaCyFUisQkGLVBgq9Tvn3G6AOokhVrt1
 H1rjHhbOAG+vk954jRqu8Sl2vMMnfo3G4n/XeQ9bsYK9eLuEsTD8REqpkR/+ocbZfbmJglW+f
 qISgcEHoHeNZBoJUEVUSq0mRR1PmxcBgHkifw56d2459r/GuLfC1lwNnQYr+W7vRd1+iYLFeG
 mT4yDbXMhzRc1CjhkkuZJsRjwP4e7aySSSBIG9oXP14o1JXudxI8T9mqtig6bL5AImgAX7jYq
 qyMNeYTsfcbLe+FeNcnt//xn8i8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/19 14:53, Qu Wenruo wrote:
> 
> 
> On 2022/11/19 14:43, Zhen Lei wrote:
>> When btrfs_debug_feature_attr_group fails to be created,
>> btrfs_feature_attr_group is not removed.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Wait for a minute, should we call sysfs_unmerge_group() first before 
calling sysfs_remove_group()?

As the sysfs_remove_group() will only remove the 
btrfs_feature_attr_group, and kset_unregister() will only free 
btrfs_kset, without removing the added btrfs_static_feature_attr_group.

I haven't yet find a function that will remove all children attrs in 
just one go, or did I miss something?

Thanks,
Qu
> 
> Thanks,
> Qu
>> ---
>>   fs/btrfs/sysfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 699b54b3acaae0b..947125f2ceaaf96 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -2322,7 +2322,7 @@ int __init btrfs_init_sysfs(void)
>>   #ifdef CONFIG_BTRFS_DEBUG
>>       ret = sysfs_create_group(&btrfs_kset->kobj, 
>> &btrfs_debug_feature_attr_group);
>>       if (ret)
>> -        goto out2;
>> +        goto out_remove_group;
>>   #endif
>>       return 0;
