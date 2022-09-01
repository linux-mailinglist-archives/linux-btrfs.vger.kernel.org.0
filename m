Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B392B5A8F17
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiIAHDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiIAHDG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 03:03:06 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32732125369;
        Thu,  1 Sep 2022 00:02:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MJBky3fZSz6T57F;
        Thu,  1 Sep 2022 15:00:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inPrWBBjs6fcAA--.6039S3;
        Thu, 01 Sep 2022 15:02:05 +0800 (CST)
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Ming Lei <ming.lei@redhat.com>,
        Chris Murphy <lists@colorremedies.com>, Jan Kara <jack@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590>
 <0f731b0a-fbd5-4e7b-a3df-0ed63360c1e0@www.fastmail.com>
 <YwCGlyDMhWubqKoL@T590>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
Date:   Thu, 1 Sep 2022 15:02:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YwCGlyDMhWubqKoL@T590>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inPrWBBjs6fcAA--.6039S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw45CF4UJF1UZw1DJF1UKFg_yoW5XFyfpF
        Z7tanYkanIqr10kryI9a18tr1rtws8Gr98WFyFy343JrnF9r90gF4IqrWYkrykXrs5Cr42
        yFWjyFyxWr15Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Chris

ÔÚ 2022/08/20 15:00, Ming Lei Ð´µÀ:
> On Fri, Aug 19, 2022 at 03:20:25PM -0400, Chris Murphy wrote:
>>
>>
>> On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
>>> On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
>>>>
>>>>
>>>> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
>>>>> On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
>>>>>> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>>>>>>
>>>>>>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
>>>>
>>>> Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.
>>>>
>>>> https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing
>>>>
>>>
>>> Also please test the following one too:
>>>
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 5ee62b95f3e5..d01c64be08e2 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx
>>> *hctx, struct list_head *list,
>>>   		if (!needs_restart ||
>>>   		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
>>>   			blk_mq_run_hw_queue(hctx, true);
>>> -		else if (needs_restart && needs_resource)
>>> +		else if (needs_restart && (needs_resource ||
>>> +					blk_mq_is_shared_tags(hctx->flags)))
>>>   			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
>>>
>>>   		blk_mq_update_dispatch_busy(hctx, true);
>>>
>>
>>
>> With just this patch on top of 5.17.0, it still hangs. I've captured block debugfs log:
>> https://drive.google.com/file/d/1ic4YHxoL9RrCdy_5FNdGfh_q_J3d_Ft0/view?usp=sharing
> 
> The log is similar with before, and the only difference is RESTART not
> set.
> 
> Also follows another patch merged to v5.18 and it fixes io stall too, feel free to test it:
> 
> 8f5fea65b06d blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues

Have you tried this patch?

We meet a similar problem in our test, and I'm pretty sure about the
situation at the scene,

Our test environment£ºnvme with bfq ioscheduler,

How io is stalled:

1. hctx1 dispatch rq from bfq in service queue, bfqq becomes empty,
dispatch somehow fails and rq is inserted to hctx1->dispatch, new run
work is queued.

2. other hctx tries to dispatch rq, however, in service bfqq is
empty, bfq_dispatch_request return NULL, thus
blk_mq_delay_run_hw_queues is called.

3. for the problem described in above patch£¬run work from "hctx1"
can be stalled.

Above patch should fix this io stall, however, it seems to me bfq do
have some problems that in service bfqq doesn't expire under following
situation:

1. dispatched rqs don't complete
2. no new rq is issued to bfq

Thanks,
Kuai
> 
> 
> 
> Thanks,
> Ming
> 
> .
> 

