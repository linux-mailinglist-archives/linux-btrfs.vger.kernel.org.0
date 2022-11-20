Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB445631269
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Nov 2022 04:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKTD37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Nov 2022 22:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTD36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Nov 2022 22:29:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA4A84F2;
        Sat, 19 Nov 2022 19:29:56 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1oQDvc2yq2-00XgKj; Sun, 20
 Nov 2022 04:29:39 +0100
Message-ID: <c3b20a4b-bb32-27a3-b8a0-2b0b7388a335@gmx.com>
Date:   Sun, 20 Nov 2022 11:29:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221119064348.1743-1-thunder.leizhen@huawei.com>
 <a076e281-022f-1f49-b70d-513272ca86cf@gmx.com>
 <afa7552c-d673-b387-d516-38024f417137@gmx.com>
Subject: Re: [PATCH] btrfs: fix a resource leak in btrfs_init_sysfs()
In-Reply-To: <afa7552c-d673-b387-d516-38024f417137@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:peYgk61waf+VkBJbgjRYywGVxY6naSA36SrGEthY9KtoB8Hhgei
 v6IqLpGLaz2HV2WE3aC6Tda7HAEFGs8PGXG0uhDj3iK9DTev1Vw+ArZu5iZmdEVnnC+/ZT+
 8bmfuypQamM+RSW5BMpxBibjniXfFg8ojxIfUsBdsgVY+xh6Eykb+ceOwA9SOFz5rOnRcyw
 1+Ckortf4X8exrcmMhZmg==
UI-OutboundReport: notjunk:1;M01:P0:MWY7dzMXIVQ=;BAmXKM0Z3xEwOow3rQUnusnhXit
 Vs8CghbkI9q/sPsJXEPaDZi1CZ7IT0zq/+UN8CrkXTnJovG7tbOtdZURsNwouRZtPiOym95bc
 yK1e99zF7Ree7/HPid862w0nfkm4HBXMrhY4NWzZhj3JlJR18/0KH/hJCSIlQgsibHfTUK5Ib
 gHAYgTy7iPnr69fNRSKvnJexhAQkxY8PU0JMym1EELtyWPZF1wqpb4mW+4tCRsqXeRPO0Vd6s
 YN5cpPTw8n0ztJntbDcoCIJiamKAwAZKMZa0GB7V6G0JYNmCeXX1+EEso2LhQA3dXd/fiEO4c
 qVgI2DsHFpVqc/On9TmaKv8/YyC50nl8tpN5bb66tvCMVukQSqffu84C9dWiAGwYIhq33YGgh
 2eP/SC/b9GH5UJUubFO4/bKdMHGiF6F0hYYyocxGbI/dnd27NCOKoGZZV/wl+11RLoGNeiOC5
 WSkdr62gFM89JARwUxZm7iItMKtmdf/h6ySVkQWoH4YQ8vaEpVSj2bpwLx2j0FFM+gFMJatuE
 x5uwMTKDDHvpVQeC9ATQ2mcvQdLXC7/3JeeRk54AkaJULuKDzDmf/i9g54KrCPrELLMKjacuw
 dDbYHdrZdNRbOXpGeHKBO1Wv5v7NlsodOndMpnuRhQzoyTVUepGaM8feYiQaIR0Bpig/qhC3E
 Ycy6IciBmyEJLaLQL1jrCA6o+Yzx7nKt+G2FrsgX+s8BRyDYeUwLgxubAtlOont3zdoRrvPXS
 9dVRXMgBX3AUUQBWWjg1FxIdEMzN4zygtlgSkb7puVpMxNuo+LadzztJafmNnDRFGbvhHZzPE
 NODy83ag9Y+K15U1C3WKa8xC5VsZDT2PswYiMKj7giPrp2vdRBAQWR6mXdnISzPp8/GeVtzPV
 gM+JkxRS4fr2xr2fkEn8Kt0REFwnG6y0gK3niz2QdZyvhJbK3ro6sUTXTW9mgyX387DUHd48k
 Z6h2jQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/20 11:11, Qu Wenruo wrote:
> 
> 
> On 2022/11/19 14:53, Qu Wenruo wrote:
>>
>>
>> On 2022/11/19 14:43, Zhen Lei wrote:
>>> When btrfs_debug_feature_attr_group fails to be created,
>>> btrfs_feature_attr_group is not removed.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Wait for a minute, should we call sysfs_unmerge_group() first before 
> calling sysfs_remove_group()?
> 
> As the sysfs_remove_group() will only remove the 
> btrfs_feature_attr_group, and kset_unregister() will only free 
> btrfs_kset, without removing the added btrfs_static_feature_attr_group.
> 
> I haven't yet find a function that will remove all children attrs in 
> just one go, or did I miss something?

Oh, indeed I missed something.

The following call chain would properly handle every child of a kobj:

kset_unregister()
|- kobject_del()
    |- __kobject_del()
       |- sysfs_remove_dir()
          |- kernfs_remove()
             |- __kernfs_remove()
                |- do { kernfs_leftmost_descendant(); } while (pos != kn)

The final do {} while () loop will unlink each child kernel_node and 
free it.

This means, as long as we call kset_unregister(), we should be able to 
free every child of it.


So with or without this patch, the error handling should be fine.

Although personally speaking, I'd prefer a more explicit cleanup (with 
extra sysfs_unmerge_group() call) as going through the above call chain 
is not that straightforward.

Thanks,
Qu

> 
> Thanks,
> Qu
>>
>> Thanks,
>> Qu
>>> ---
>>>   fs/btrfs/sysfs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>> index 699b54b3acaae0b..947125f2ceaaf96 100644
>>> --- a/fs/btrfs/sysfs.c
>>> +++ b/fs/btrfs/sysfs.c
>>> @@ -2322,7 +2322,7 @@ int __init btrfs_init_sysfs(void)
>>>   #ifdef CONFIG_BTRFS_DEBUG
>>>       ret = sysfs_create_group(&btrfs_kset->kobj, 
>>> &btrfs_debug_feature_attr_group);
>>>       if (ret)
>>> -        goto out2;
>>> +        goto out_remove_group;
>>>   #endif
>>>       return 0;
