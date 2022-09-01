Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6CB5A91F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiIAITY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiIAITX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 04:19:23 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418BD2917;
        Thu,  1 Sep 2022 01:19:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJDS11vrczKHQ5;
        Thu,  1 Sep 2022 16:17:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inMEaxBjFgPfAA--.12124S3;
        Thu, 01 Sep 2022 16:19:18 +0800 (CST)
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Chris Murphy <lists@colorremedies.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590>
 <0f731b0a-fbd5-4e7b-a3df-0ed63360c1e0@www.fastmail.com>
 <YwCGlyDMhWubqKoL@T590>
 <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
 <20220901080336.glpv4i3hyae2zkpk@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ee48bdc1-1020-78ca-a90e-ef958171a05f@huaweicloud.com>
Date:   Thu, 1 Sep 2022 16:19:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220901080336.glpv4i3hyae2zkpk@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inMEaxBjFgPfAA--.12124S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4UtFyrCFykuFWrGFWruFg_yoWrJFyUpF
        Wrta1Yyan8tr10y34Iy3Wjqr15twn0kr98WF1rtw43JrnFgr98Kr4IqrWY9Fn5Zrs5Cr47
        tryjyFyxWr15Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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

在 2022/09/01 16:03, Jan Kara 写道:
> On Thu 01-09-22 15:02:03, Yu Kuai wrote:
>> Hi, Chris
>>
>> 在 2022/08/20 15:00, Ming Lei 写道:
>>> On Fri, Aug 19, 2022 at 03:20:25PM -0400, Chris Murphy wrote:
>>>>
>>>>
>>>> On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
>>>>> On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
>>>>>>
>>>>>>
>>>>>> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
>>>>>>> On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
>>>>>>>> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>>>>>>>>
>>>>>>>>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
>>>>>>
>>>>>> Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.
>>>>>>
>>>>>> https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing
>>>>>>
>>>>>
>>>>> Also please test the following one too:
>>>>>
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index 5ee62b95f3e5..d01c64be08e2 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx
>>>>> *hctx, struct list_head *list,
>>>>>    		if (!needs_restart ||
>>>>>    		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
>>>>>    			blk_mq_run_hw_queue(hctx, true);
>>>>> -		else if (needs_restart && needs_resource)
>>>>> +		else if (needs_restart && (needs_resource ||
>>>>> +					blk_mq_is_shared_tags(hctx->flags)))
>>>>>    			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
>>>>>
>>>>>    		blk_mq_update_dispatch_busy(hctx, true);
>>>>>
>>>>
>>>>
>>>> With just this patch on top of 5.17.0, it still hangs. I've captured block debugfs log:
>>>> https://drive.google.com/file/d/1ic4YHxoL9RrCdy_5FNdGfh_q_J3d_Ft0/view?usp=sharing
>>>
>>> The log is similar with before, and the only difference is RESTART not
>>> set.
>>>
>>> Also follows another patch merged to v5.18 and it fixes io stall too, feel free to test it:
>>>
>>> 8f5fea65b06d blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues
>>
>> Have you tried this patch?
>>
>> We meet a similar problem in our test, and I'm pretty sure about the
>> situation at the scene,
>>
>> Our test environment：nvme with bfq ioscheduler,
>>
>> How io is stalled:
>>
>> 1. hctx1 dispatch rq from bfq in service queue, bfqq becomes empty,
>> dispatch somehow fails and rq is inserted to hctx1->dispatch, new run
>> work is queued.
>>
>> 2. other hctx tries to dispatch rq, however, in service bfqq is
>> empty, bfq_dispatch_request return NULL, thus
>> blk_mq_delay_run_hw_queues is called.
>>
>> 3. for the problem described in above patch，run work from "hctx1"
>> can be stalled.
>>
>> Above patch should fix this io stall, however, it seems to me bfq do
>> have some problems that in service bfqq doesn't expire under following
>> situation:
>>
>> 1. dispatched rqs don't complete
>> 2. no new rq is issued to bfq
> 
> And I guess:
> 3. there are requests queued in other bfqqs
> ?

Yes, of course, other bfqqs still have requests, but current
implementation have flaws that even if other bfqqs doesn't have
requests, bfq_asymmetric_scenario() can still return true because
num_groups_with_pending_reqs > 0. We tried to fix this, however, there
seems to be some misunderstanding with Paolo, and it's not applied to
mainline yet...

Thanks,
Kuai
> 
> Otherwise I don't see a point in expiring current bfqq because there's
> nothing bfq could do anyway. But under normal circumstances the request
> completion should not take so long so I don't think it would be really
> worth it to implement some special mechanism for this in bfq.
> 
> 								Honza
> 

