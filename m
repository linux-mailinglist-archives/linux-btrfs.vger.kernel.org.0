Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595C362BDCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 13:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbiKPM3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 07:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiKPM2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 07:28:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A46C00;
        Wed, 16 Nov 2022 04:27:08 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1ooAV80JrC-00ChQs; Wed, 16
 Nov 2022 13:26:52 +0100
Message-ID: <7b2ac1a3-4556-1a37-8442-6b7a51b2dc84@gmx.com>
Date:   Wed, 16 Nov 2022 20:26:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/3] btrfs: add might_sleep() to some places in
 update_qgroup_limit_item()
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com, wqu@suse.com
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
 <20221115171709.3774614-2-chenxiaosong2@huawei.com>
 <9b47b291-b1a0-ac0c-2049-b7de6545c26b@gmx.com>
 <e058c1b9-7f57-11da-6ad1-6387604813c5@huawei.com>
 <3918175e-dddd-2a55-32c4-c07de78ff4cb@gmx.com>
 <20221116122440.GN5824@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221116122440.GN5824@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6tbCdH+7KgUB7+/d7Dd/K+e2XPQPlo7x3eubLzLl1+f0iDniRvG
 iB1n8D0xAKlIorr3HdYjLQPBJfJcFntOlZW1sQ906XpLRcYTjCIGXh22v1ns7kEGCrBiD0F
 jAXKZrgwRNA2QTMZyfi9lJDIReRhJvOsAwrh4DHeKPmhZdHl62UnhrdaHYoJmUwmMsT19p8
 0Je7eX6N3PRbhdnxzvP1Q==
UI-OutboundReport: notjunk:1;M01:P0:/Igt7b7tEYs=;7SSw3lK/XhJAAsRb8y4dFUVx6dW
 F9YtIcz4FX3zziQ0S9x8lQmnIGVMYvyx3B+ZNEtQIX1LIVU53xkadzipPzu2H790Krxvzc52n
 6aqnhVvr+oAVBqbOAk9mcVy7BTz9NQSym8rO0V6VCGnfg4AmWPqKB8eLYVEtgKdR4w2Wyw3eY
 keF8xCF9C0vzbwfU2lOBtsK+Ylk7pMPJasCsUr2jQDOucWfsEgpoWwaU6cvYj24PEbFyBjgjj
 Vhgig3l3XygdiSB4Eqm/qLxws5HcgQMbejsdEEwFXjlJK2SAePw14cZPlXnYEqZWn9NWPPM3n
 Ub7SneXWEjpXyGCivPU3GGMUyg5mkLKfdsKdMzLMFSSRkCrwJhXZ6XaouHqzyMas465JBhsIP
 BPKuPj6Y8Bfhl+zxAwPZGnrvopcUfQKJ7RHTfA+JIZ75oYU+xhTVuCtyhJMnY3g8AWOkQsQVm
 FARuKkoFtRgRGjsm2CxIQwjrCkrlPbIKWnTPT0buCoSMqUdXfjmxPjBosYc29izMPHZC2kurP
 YSpzSM3RGUDCfzy3v2+wq5UAmDSZECTIMT6uhOZ8t/xZm6aD1Fb/YAfgm3Dd1FUk/xLkzgaww
 JcmcsjRhm5j1ANTpSchwLtb3SSqqaa7+Z/vM0yiuolX+Xnq2TYkxJy3E/sQ/mYFUZYvTRXXUm
 Etidz4NP0caxqx+IjgUcayYX4U5q4L/Vj7JC7bOl6MtqR75P/L8O4wovwH1FBOAPnv2vIvGtY
 FtEsj7YOaBwVjVhDDAl8iULxqbBugqCcoe4fQt2fFDemXqDMBcXdo/XWkmJyTgjHn1vNQqiwK
 51iWgeUuqNRXK/k0OnokPjXFIcBROMrZ5oILMNd29SpOX++EgjyMatwI7Nw01xJS17BW9yw6/
 IRnbVrTzXB2JtMPRSCtgFLqWqb3j+6re6NmGGvp7FB6rTA8T7mc2Z+xxBpAS9p5kug4yTD3ak
 q//4y9YPmb3JyTIkCxirEpWoXlk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 20:24, David Sterba wrote:
> On Wed, Nov 16, 2022 at 04:43:50PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/11/16 16:09, ChenXiaoSong wrote:
>>> 在 2022/11/16 6:48, Qu Wenruo 写道:
>>>> Looks good.
>>>>
>>>> We may want to add more in other locations, but this is really a good
>>>> start.
>>>>
>>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> If I just add might_sleep() in btrfs_alloc_path() and
>>> btrfs_search_slot(), is it reasonable?
>>
>> Adding it to btrfs_search_slot() is definitely correct.
>>
>> But why for btrfs_alloc_path()? Wouldn't kmem_cache_zalloc() itself
>> already do the might_sleep_if() somewhere?
>>
>> I just looked the call chain, and indeed it is doing the check already:
>>
>> btrfs_alloc_path()
>> |- kmem_cache_zalloc()
>>      |- kmem_cache_alloc()
>>         |- __kmem_cache_alloc_lru()
>>            |- slab_alloc()
>>               |- slab_alloc_node()
>>                  |- slab_pre_alloc_hook()
>>                     |- might_alloc()
>>                        |- might_sleep_if()
> 
> The call chaing is unconditional so the check will always happen but the
> condition itself in might_sleep_if does not recognize GFP_NOFS:
> 
>   34 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>   35 {
>   36         return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
>   37 }
> 
> #define GFP_NOFS        (__GFP_RECLAIM | __GFP_IO)
> 
> And I think the qgroup limit was exactly a spin lock over btrfs_path_alloc so
> it did not help. An might_sleep() inside btrfs_path_alloc() is a very minimal
> but reliable check we could add, the paths are used in many places so it would
> increase the coverage.

OK, then it makes sense now for btrfs_alloc_path().

But I still believe this looks like a bug in gfpflags_allow_blocking()...

Thanks,
Qu
