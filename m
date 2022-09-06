Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD25AE4A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 11:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiIFJqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiIFJqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 05:46:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418973934
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 02:45:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dc5so2046862ejb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Sep 2022 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=VtLdd7vkvDTE4ZQfVBsC4VxzNjo0K0INFc86CHoi1Co=;
        b=mDh9NxcPOaUlXnZU9kI6p49EzyANeI/LZ/y/fSYtsOIvabWsGS3h3W73ZJoc6x9ssj
         wF/MwocRBvfg9Ld/ylStXfB9bX2roLVCzU/XGTDAEVE95ZqQj82bKJlynZe4a0OGqfkn
         jzneNXhMPz2+h7fS7RP9+OLMaMh2doQOn26aAbPbVdRTrgf/R3lAPetQeRY74o+BwzCA
         cNvWkYPTZ5tZf0mRBkX7vcX4BrLDvOfFZpmMNC8pH6tulrg+3KlJbnmcHc3UBPSHdqR9
         W2+hq9eEmZ0faXJCBHCuVfjXjhr9vDGLGA0l8tdMdqINkIX7CG6ayVTUCxxOtIYscUIW
         8SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VtLdd7vkvDTE4ZQfVBsC4VxzNjo0K0INFc86CHoi1Co=;
        b=B8/xDf/SYxiYHrC8E+ab/jjg2M/MxRmJhMaIQvJv9NFESPpEcZ3gI2dmZMmUf8cob2
         jtIFiOYolGmQFtmsA0lw1iQSVeRrgtfm8Xsau3I8KzVXAdSwCzFW6ezPJOJ4sQbp6BkQ
         mknN0Adenb/sbbde9kBS1CI4n4Dg+/+9Ljli0BirBq5SOn1/faaawVzMcfbpFtJwzpF3
         Y6gcTmlAW4ndhiJhc6v6I9YS8IuyhiKnGjIs8DVgaatoM2iNhMfwd8hqEMS03bJgaVZP
         4N0Dt+lXFzf+3nmMdCTKUfZnQaU4hezzc2brH7Q3tSEkLfjyjwivMEH/K+Q73FhQQfxN
         dvCw==
X-Gm-Message-State: ACgBeo0agDGfEBfBcj1ADH+PsjObY9zLJpD6gmgVbZTuZKeynNDSFE45
        yQLEiNcWmmoxJ6mx87P4HJKW5Q==
X-Google-Smtp-Source: AA6agR6kYrPMIegCZ/MD9J95k2Z6B0Ycf9T8Cat6OfFamb+zoIbBd/kPLFPHo3yGBug8Z1F/Da++sA==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr1145411ejc.769.1662457557672;
        Tue, 06 Sep 2022 02:45:57 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906300a00b00738795e7d9bsm6273344ejz.2.2022.09.06.02.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 02:45:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: stalling IO regression since linux 5.12, through 5.18
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
Date:   Tue, 6 Sep 2022 11:45:54 +0200
Cc:     Ming Lei <ming.lei@redhat.com>,
        Chris Murphy <lists@colorremedies.com>,
        Jan Kara <jack@suse.cz>, Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69523E26-6A87-4C8A-A5CD-D37A28018109@linaro.org>
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
 <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
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



> Il giorno 1 set 2022, alle ore 09:02, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> Hi, Chris
>=20
> =E5=9C=A8 2022/08/20 15:00, Ming Lei =E5=86=99=E9=81=93:
>> On Fri, Aug 19, 2022 at 03:20:25PM -0400, Chris Murphy wrote:
>>>=20
>>>=20
>>> On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
>>>> On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
>>>>>=20
>>>>>=20
>>>>> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
>>>>>> On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
>>>>>>> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>>>>>>>=20
>>>>>>>> OK, can you post the blk-mq debugfs log after you trigger it on =
v5.17?
>>>>>=20
>>>>> Same boot, 3rd log. But the load is above 300 so I kinda need to =
sysrq+b soon.
>>>>>=20
>>>>> =
https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=
=3Dsharing
>>>>>=20
>>>>=20
>>>> Also please test the following one too:
>>>>=20
>>>>=20
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 5ee62b95f3e5..d01c64be08e2 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct =
blk_mq_hw_ctx
>>>> *hctx, struct list_head *list,
>>>>  		if (!needs_restart ||
>>>>  		    (no_tag && =
list_empty_careful(&hctx->dispatch_wait.entry)))
>>>>  			blk_mq_run_hw_queue(hctx, true);
>>>> -		else if (needs_restart && needs_resource)
>>>> +		else if (needs_restart && (needs_resource ||
>>>> +					=
blk_mq_is_shared_tags(hctx->flags)))
>>>>  			blk_mq_delay_run_hw_queue(hctx, =
BLK_MQ_RESOURCE_DELAY);
>>>>=20
>>>>  		blk_mq_update_dispatch_busy(hctx, true);
>>>>=20
>>>=20
>>>=20
>>> With just this patch on top of 5.17.0, it still hangs. I've captured =
block debugfs log:
>>> =
https://drive.google.com/file/d/1ic4YHxoL9RrCdy_5FNdGfh_q_J3d_Ft0/view?usp=
=3Dsharing
>> The log is similar with before, and the only difference is RESTART =
not
>> set.
>> Also follows another patch merged to v5.18 and it fixes io stall too, =
feel free to test it:
>> 8f5fea65b06d blk-mq: avoid extending delays of active hctx from =
blk_mq_delay_run_hw_queues
>=20
> Have you tried this patch?
>=20
> We meet a similar problem in our test, and I'm pretty sure about the
> situation at the scene,
>=20
> Our test environment=EF=BC=9Anvme with bfq ioscheduler,
>=20
> How io is stalled:
>=20
> 1. hctx1 dispatch rq from bfq in service queue, bfqq becomes empty,
> dispatch somehow fails and rq is inserted to hctx1->dispatch, new run
> work is queued.
>=20
> 2. other hctx tries to dispatch rq, however, in service bfqq is
> empty, bfq_dispatch_request return NULL, thus
> blk_mq_delay_run_hw_queues is called.
>=20
> 3. for the problem described in above patch=EF=BC=8Crun work from =
"hctx1"
> can be stalled.
>=20
> Above patch should fix this io stall, however, it seems to me bfq do
> have some problems that in service bfqq doesn't expire under following
> situation:
>=20
> 1. dispatched rqs don't complete
> 2. no new rq is issued to bfq
>=20

There may be one more important problem: is bfq_finish_requeue_request
eventually invoked for the failed rq?  If it is not, then a memory
leak follows, because recounting gets unavoidably unbalanced.

In contrast, if bfq_finish_requeue_request is correctly invoked, then
no stall should occur.

Thanks,
Paolo

> Thanks,
> Kuai
>> Thanks,
>> Ming
>> .

