Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30E62B56C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 09:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiKPIoW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbiKPIoU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 03:44:20 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3F18E20;
        Wed, 16 Nov 2022 00:44:18 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MO9z7-1obnSn1Yin-00OZhV; Wed, 16
 Nov 2022 09:43:57 +0100
Message-ID: <3918175e-dddd-2a55-32c4-c07de78ff4cb@gmx.com>
Date:   Wed, 16 Nov 2022 16:43:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com, wqu@suse.com
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
 <20221115171709.3774614-2-chenxiaosong2@huawei.com>
 <9b47b291-b1a0-ac0c-2049-b7de6545c26b@gmx.com>
 <e058c1b9-7f57-11da-6ad1-6387604813c5@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4 1/3] btrfs: add might_sleep() to some places in
 update_qgroup_limit_item()
In-Reply-To: <e058c1b9-7f57-11da-6ad1-6387604813c5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ygu7CYbFO6+vdJjE1V6fAgvNgZJssK4orDu/r87w4bh0tG16AxM
 ahoBvFF4VuMRJ8UMpqOgbuTnkXwgHggYdMlgquDddBvhd+a2y/SzFRt2WNjTT4eWjXVqhX6
 rHDAYmFeiNwvIxhjsWmWA8GJLVcdJYq0rf28ASeNVJ4vz8eTVjOeEjHIFll38z685hK6Kao
 Cld5i47eca/ilYOZkrIDg==
UI-OutboundReport: notjunk:1;M01:P0:yl5IKU26nSk=;t2ZS1JTZvg0o8wbVvP7cFuAUDHT
 CsrVKfIUpOWeFl9RJ5pGWgW39EbW4r0E1EIKZBSiyXz7Or67USf98662KuRoDGuJBg+hEC8y7
 PO29D238btctRcKQjRbFhvwme6xBsuToH30a80VRQQMnFh+Ua2noBEZuBy3J5NPFUmVee57vk
 D3OlD2R3CtrhLwPtX4V7q65+5wyV7m42KMvzizZKPlt+nBQN1HDQuO8MCzJ53bvX2s0bQHjvI
 FN5jReq0VeZXTd8e0KPGkR6wnvrtQxwyVvTHPgdGLmCbYyYqNGrYi3JziyocgHQAeAgA8cDSJ
 gcWEcfKKhAbvDCWEnzw+Jq/MhEiqR/ghr1wOUBwYD/sG2sgyfQnQHBT4pll5QTqrTH9+GyHe2
 5evYrRFfFiqQ1rPO4d+ZwKdxegKz8vNUTVP8kiW3RwEV5MfYwWCOtUMhtP1/BR7qZZ8BhMksE
 6k4zdi7DQL3GW+wqsY4KlkHdknjG4hhfDQEIiioxtQKVdpo4tqoBRW24SDX+A2vCHm4VNwa6b
 K2kFFeKRLxG+KY+ADNmQyzT11E8bcxQr3tcxlHhZOtZkBo48uO7Qkf4iSHZmIPqnn7/P84yC2
 X/2YOpOYyLYIczNyh24MmaAcaxwIzlxBxW/dBZBlcYTNDFtGdgkjfv9apIxVRSDMAwHUDwJ7X
 6ZIhlKNWHmSIkrzLd3J32dYiEupBW/YivgZOA7FY4PXKGkSNGveqQxcZCeDDZmV23Yk50KpjZ
 pXHHukRlK1UO2IAIYySnSUEk9sSGZGR2gJ0kmd38/dfdd7rluwWCEdkJPE+bBvIl80oj/e6H2
 Xwb1FLnYOmNfX7D7ZVFoCy6dE1zgfmetBneZcwcvrdJ5Ds9WFsJbsGFvA3MrTp/4SIRsbdk7m
 IxKPTu4V4wwAM10uuP5gikyDLdNy1QhTummJE43zIcDueTJDPpL8jBosp+CT7Wd/pBFCB3RdV
 f1p2OIZJLd733YqMpYznQ/Ukboo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 16:09, ChenXiaoSong wrote:
> 在 2022/11/16 6:48, Qu Wenruo 写道:
>> Looks good.
>>
>> We may want to add more in other locations, but this is really a good 
>> start.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
> 
> If I just add might_sleep() in btrfs_alloc_path() and 
> btrfs_search_slot(), is it reasonable?

Adding it to btrfs_search_slot() is definitely correct.

But why for btrfs_alloc_path()? Wouldn't kmem_cache_zalloc() itself 
already do the might_sleep_if() somewhere?

I just looked the call chain, and indeed it is doing the check already:

btrfs_alloc_path()
|- kmem_cache_zalloc()
    |- kmem_cache_alloc()
       |- __kmem_cache_alloc_lru()
          |- slab_alloc()
             |- slab_alloc_node()
                |- slab_pre_alloc_hook()
                   |- might_alloc()
                      |- might_sleep_if()

Thanks,
Qu

> 
> Or just add might_sleep() to one place in update_qgroup_limit_item() ?
