Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B05AE4BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiIFJu1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiIFJuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 05:50:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F87858C
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 02:49:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lz22so1066482ejb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Sep 2022 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=oao2eanIO+0ZaEYkDA8iPFUpxGnonh4X6mc942fm8R4=;
        b=d2NE3aJ/RSQUgLsWYJl2sqB7Z1JaC7wGi3diVySoKCPD5ZAjja+SR6EoNlqgH1wOc9
         pyu4wABTErZsruJ9x0qnTz9PQlyEPZNuanv9f5/KevrYQyhqBRtAtsefAuVO1amc7mOb
         mt1kUZDuEi2PrFTxfPM8XakVj5bHTRR3eVj0g2OszjIz9+b647K/rGWIOvL7LpzIK42/
         heFOwiXuzQK+1R8plnGC+tVW5WZYGTYIl/uG/qOxnCxB6O6wjRFhfy2nu/eJeUflRADV
         st5cowZ6zUNAJkTV36Tw8dpgPUy0tSaCmzTfTxILs4wM3keaLJ+NxUXOlqB1YHVXQlvt
         R4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oao2eanIO+0ZaEYkDA8iPFUpxGnonh4X6mc942fm8R4=;
        b=IRh5IDNuQlTBouAMmtEpifyAi1w17ZLKYihv5qlLR5y6IJKyQ4zzmqoynwFvFnH8XH
         WJtuYwNZtIwvUZhQ41U1mlAXUodG++4GBWJA1M17qSxgU/WMN+9WRmoVZ7xp9IgZu8hX
         oA5hNRjSy4KcOIZqoqqSFJyeVj/5OIKlWJHqYykc/WXX/pmT82sLDlE8Tep5s1yF3bgf
         SC1jZwjvloNUDOCRJNVtFiUIYR103QWCfU6krUVqMrw8bmgWdIlyZt7T/yLmEwlCnixs
         OCwFyKYUeM+zYZDIU6kEb8OQqqxFlJ+pyX2CfiT15Ox6cFG2uXTRC8zh01NOv2VTfRjm
         8bMA==
X-Gm-Message-State: ACgBeo0gHFnF8VO8+ZYvsEC9dBiI6SfasXg/S+ms2yXI9yslXtfbtzFC
        f/dwaiFV1xWzYAIT1gfAxe9xaA==
X-Google-Smtp-Source: AA6agR7FwnltaiAu7qfbGeW00HD6BDekEPUWp54MdUv7bEf3ywr7Mhgm1DpRaNsxCGrq5NadBoKkiQ==
X-Received: by 2002:a17:907:a053:b0:741:698d:4e40 with SMTP id gz19-20020a170907a05300b00741698d4e40mr29433518ejc.616.1662457785641;
        Tue, 06 Sep 2022 02:49:45 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709067c1300b00730b61d8a5esm6329618ejo.61.2022.09.06.02.49.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 02:49:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: stalling IO regression since linux 5.12, through 5.18
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ee48bdc1-1020-78ca-a90e-ef958171a05f@huaweicloud.com>
Date:   Tue, 6 Sep 2022 11:49:43 +0200
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Chris Murphy <lists@colorremedies.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A67D5D9-EB63-4B0C-BC51-4A4CDBC2077E@linaro.org>
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
 <ee48bdc1-1020-78ca-a90e-ef958171a05f@huaweicloud.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> Il giorno 1 set 2022, alle ore 10:19, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> =E5=9C=A8 2022/09/01 16:03, Jan Kara =E5=86=99=E9=81=93:
>> On Thu 01-09-22 15:02:03, Yu Kuai wrote:
>>> Hi, Chris
>>>=20
>>> =E5=9C=A8 2022/08/20 15:00, Ming Lei =E5=86=99=E9=81=93:
>>>> On Fri, Aug 19, 2022 at 03:20:25PM -0400, Chris Murphy wrote:
>>>>>=20
>>>>>=20
>>>>> On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
>>>>>> On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
>>>>>>>> On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
>>>>>>>>> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>>>>>>>>>=20
>>>>>>>>>> OK, can you post the blk-mq debugfs log after you trigger it =
on v5.17?
>>>>>>>=20
>>>>>>> Same boot, 3rd log. But the load is above 300 so I kinda need to =
sysrq+b soon.
>>>>>>>=20
>>>>>>> =
https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=
=3Dsharing
>>>>>>>=20
>>>>>>=20
>>>>>> Also please test the following one too:
>>>>>>=20
>>>>>>=20
>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>>> index 5ee62b95f3e5..d01c64be08e2 100644
>>>>>> --- a/block/blk-mq.c
>>>>>> +++ b/block/blk-mq.c
>>>>>> @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct =
blk_mq_hw_ctx
>>>>>> *hctx, struct list_head *list,
>>>>>>   		if (!needs_restart ||
>>>>>>   		    (no_tag && =
list_empty_careful(&hctx->dispatch_wait.entry)))
>>>>>>   			blk_mq_run_hw_queue(hctx, true);
>>>>>> -		else if (needs_restart && needs_resource)
>>>>>> +		else if (needs_restart && (needs_resource ||
>>>>>> +					=
blk_mq_is_shared_tags(hctx->flags)))
>>>>>>   			blk_mq_delay_run_hw_queue(hctx, =
BLK_MQ_RESOURCE_DELAY);
>>>>>>=20
>>>>>>   		blk_mq_update_dispatch_busy(hctx, true);
>>>>>>=20
>>>>>=20
>>>>>=20
>>>>> With just this patch on top of 5.17.0, it still hangs. I've =
captured block debugfs log:
>>>>> =
https://drive.google.com/file/d/1ic4YHxoL9RrCdy_5FNdGfh_q_J3d_Ft0/view?usp=
=3Dsharing
>>>>=20
>>>> The log is similar with before, and the only difference is RESTART =
not
>>>> set.
>>>>=20
>>>> Also follows another patch merged to v5.18 and it fixes io stall =
too, feel free to test it:
>>>>=20
>>>> 8f5fea65b06d blk-mq: avoid extending delays of active hctx from =
blk_mq_delay_run_hw_queues
>>>=20
>>> Have you tried this patch?
>>>=20
>>> We meet a similar problem in our test, and I'm pretty sure about the
>>> situation at the scene,
>>>=20
>>> Our test environment=EF=BC=9Anvme with bfq ioscheduler,
>>>=20
>>> How io is stalled:
>>>=20
>>> 1. hctx1 dispatch rq from bfq in service queue, bfqq becomes empty,
>>> dispatch somehow fails and rq is inserted to hctx1->dispatch, new =
run
>>> work is queued.
>>>=20
>>> 2. other hctx tries to dispatch rq, however, in service bfqq is
>>> empty, bfq_dispatch_request return NULL, thus
>>> blk_mq_delay_run_hw_queues is called.
>>>=20
>>> 3. for the problem described in above patch=EF=BC=8Crun work from =
"hctx1"
>>> can be stalled.
>>>=20
>>> Above patch should fix this io stall, however, it seems to me bfq do
>>> have some problems that in service bfqq doesn't expire under =
following
>>> situation:
>>>=20
>>> 1. dispatched rqs don't complete
>>> 2. no new rq is issued to bfq
>> And I guess:
>> 3. there are requests queued in other bfqqs
>> ?
>=20
> Yes, of course, other bfqqs still have requests, but current
> implementation have flaws that even if other bfqqs doesn't have
> requests, bfq_asymmetric_scenario() can still return true because
> num_groups_with_pending_reqs > 0. We tried to fix this, however, there
> seems to be some misunderstanding with Paolo, and it's not applied to
> mainline yet...
>=20

I think this is an unsolved performance issue (being solved patiently
by Yu Kuai), but not a functional flaw.  The solution of this issue
would probably solve this stall, but not the essential problem:
refcounting gets broken if reqs disappear for bfq without any
notification.

Thanks,
Paolo

> Thanks,
> Kuai
>> Otherwise I don't see a point in expiring current bfqq because =
there's
>> nothing bfq could do anyway. But under normal circumstances the =
request
>> completion should not take so long so I don't think it would be =
really
>> worth it to implement some special mechanism for this in bfq.
>> 								Honza

