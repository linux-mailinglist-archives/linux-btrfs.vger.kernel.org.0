Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB10592650
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiHNU2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Aug 2022 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNU2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 16:28:41 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE61EEC6;
        Sun, 14 Aug 2022 13:28:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 03F152B06045;
        Sun, 14 Aug 2022 16:28:35 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sun, 14 Aug 2022 16:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660508915; x=
        1660512515; bh=noD6ZKg7J5ic8Pq+qqF7vTpNYPmteA1xQX5iB6mWRjc=; b=x
        e9dxcc8zZTEq458wiOJyZC/JsRtbJo/HI7H3oFf0UPZLTBv5h1q6zbXpX/DhA8nc
        HVBc143YiGbbe9ncJLdSRbpm7eY8Uxqj+jTP5Hyis0eNW7bSmEXPSA5OGMBShvob
        HOPx3RxDzycuC59gJ+Zu8y5QrHhmb7XVwCuRYVYePSwDJxQrWFgwbubjWpzFbO/g
        nJEaWzyy5PTXHkf8+HKZfbcFQP6qPuUr1l/L1UVhz7IiwYlespAabSkFR+Cu1pX3
        2fDUmxGOuaQvcJ+kwLTHztiY5o3HPhNMFEsm/qkB07gYltjE/gSTcFIldTda+fZO
        RU9/Y/YxuV049S7hyd84w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660508915; x=1660512515; bh=noD6ZKg7J5ic8Pq+qqF7vTpNYPmt
        eA1xQX5iB6mWRjc=; b=kLG9CFwiH5wYAvsJcGdYfI1YHt8U7hM9olDfz9dRDl7a
        12qQW989Df8Znznsqj2ZHnLNR1TqWpg80vXiyyICcQeziDlwyjNrNmDbhjSAr28f
        cY65hFho/gsHLB854P4UzHgefXPI/MQnXjvVFSWDQOreyZ5Fc6Y2Fkxd3fneUFF2
        4JFY8SQXiW6lUWyNeDWPb/QN89RXgw2EGHxfOqUQm6zT2aNUUwUidv19Xgk8BiUL
        KUZdSbl/ZrLM4F3cVVbtZn8bhgCug2J08Uu1rhCUC/1KhR7r7NzS9iVe1olVUnLE
        W8Ysp24xv5o5Rb/uA414mepMsgzNIWwtlnjEz0f7jw==
X-ME-Sender: <xms:8lr5YvwjDRfqCD-ao9l8aeoOeCQk5u1WIvKeEqcM1LMxmT_7xbHPyw>
    <xme:8lr5YnTWMpu0qHic1IdYfwJuUzXscv8tGIN7qujEgRsJwE3nDhUd2hn-Wnup_Nxxi
    IaetbA02jRRdQWbmq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffv
    vefutgesthdtredtreertdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolh
    hishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhep
    feehleeiudegueelteffueehgeektefgtdevvedufffgjedvgeevleejhfdvfefhnecuff
    homhgrihhnpehgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hm
X-ME-Proxy: <xmx:8lr5YpXfoQOAgFHlIoyzivVMODrhQAKfMdpFSREQcMucQxyq7UO_OA>
    <xmx:8lr5Yph8C5MLTSj_sghpLlPjRA-iw3YU3Ao529e5e3SMVU2xcAWmaw>
    <xmx:8lr5YhBhONap-7UY11ME1W608oINMOWPBrAhym1woRqBumqNkjG5Pw>
    <xmx:81r5Yk7KRfWIbiTKVw69RTbqNLp0Cg_e3su5bf_pRyPwCijFFBMOiWiurTQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F09B1700082; Sun, 14 Aug 2022 16:28:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
In-Reply-To: <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
Date:   Sun, 14 Aug 2022 16:28:08 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Jens Axboe" <axboe@kernel.dk>,
        "Josef Bacik" <josef@toxicpanda.com>
Cc:     "Paolo Valente" <paolo.valente@linaro.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Jan Kara" <jack@suse.cz>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Fri, Aug 12, 2022, at 2:02 PM, Jens Axboe wrote:
> On 8/12/22 11:59 AM, Josef Bacik wrote:
>> On Fri, Aug 12, 2022 at 12:05 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>
>>>
>>>
>>> On Wed, Aug 10, 2022, at 3:34 PM, Chris Murphy wrote:
>>>> Booted with cgroup_disable=io, and confirmed cat
>>>> /sys/fs/cgroup/cgroup.controllers does not list io.
>>>
>>> The problem still reproduces with the cgroup IO controller disabled.
>>>
>>> On a whim, I decided to switch the IO scheduler from Fedora's default bfq for rotating drives to mq-deadline. The problem does not reproduce for 15+ hours, which is not 100% conclusive but probably 99% conclusive. I then switched live while running the workload to bfq on all eight drives, and within 10 minutes the system cratered, all new commands just hang. Load average goes to triple digits, i/o wait increasing, i/o pressure for the workload tasks to 100%, and IO completely stalls to zero. I was able to switch only two of the drive queues back to mq-deadline and then lost responsivness in that shell and had to issue sysrq+b...
>>>
>>> Before that I was able to extra sysrq+w and sysrq+t.
>>> https://drive.google.com/file/d/16hdQjyBnuzzQIhiQT6fQdE0nkRQJj7EI/view?usp=sharing
>>>
>>> I can't tell if this is a bfq bug, or if there's some negative interaction between bfq and scsi or megaraid_sas. Obviously it's rare because otherwise people would have been falling over this much sooner. But at this point there's strong correlation that it's bfq related and is a kernel regression that's been around since 5.12.0 through 5.18.0, and I suspect also 5.19.0 but it's being partly masked by other improvements.
>> 
>> This matches observations we've had internally (inside Facebook) as
>> well as my continual integration performance testing.  It should
>> probably be looked into by the BFQ guys as it was working previously.
>> Thanks,
>
> 5.12 has a few BFQ changes:
>
> Jan Kara:
>       bfq: Avoid false bfq queue merging
>       bfq: Use 'ttime' local variable
>       bfq: Use only idle IO periods for think time calculations
>
> Jia Cheng Hu
>       block, bfq: set next_rq to waker_bfqq->next_rq in waker injection
>
> Paolo Valente
>       block, bfq: use half slice_idle as a threshold to check short ttime
>       block, bfq: increase time window for waker detection
>       block, bfq: do not raise non-default weights
>       block, bfq: avoid spurious switches to soft_rt of interactive queues
>       block, bfq: do not expire a queue when it is the only busy one
>       block, bfq: replace mechanism for evaluating I/O intensity
>       block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
>       block, bfq: fix switch back from soft-rt weitgh-raising
>       block, bfq: save also weight-raised service on queue merging
>       block, bfq: save also injection state on queue merging
>       block, bfq: make waker-queue detection more robust
>
> Might be worth trying to revert those from 5.12 to see if they are
> causing the issue? Jan, Paolo - does this ring any bells?

git log --oneline --no-merges v5.11..c03c21ba6f4e > bisect.txt

I tried checking out a33df75c6328, which is right before the first bfq commit, but that kernel won't boot the hardware.

Next I checked out v5.12, then reverted these commits in order (that they were found in the bisect.txt file):

7684fbde4516 bfq: Use only idle IO periods for think time calculations
28c6def00919 bfq: Use 'ttime' local variable
41e76c85660c bfq: Avoid false bfq queue merging
>>>a5bf0a92e1b8 bfq: bfq_check_waker() should be static
71217df39dc6 block, bfq: make waker-queue detection more robust
5a5436b98d5c block, bfq: save also injection state on queue merging
e673914d52f9 block, bfq: save also weight-raised service on queue merging
d1f600fa4732 block, bfq: fix switch back from soft-rt weitgh-raising
7f1995c27b19 block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
eb2fd80f9d2c block, bfq: replace mechanism for evaluating I/O intensity
>>>1a23e06cdab2 bfq: don't duplicate code for different paths
2391d13ed484 block, bfq: do not expire a queue when it is the only busy one
3c337690d2eb block, bfq: avoid spurious switches to soft_rt of interactive queues
91b896f65d32 block, bfq: do not raise non-default weights
ab1fb47e33dc block, bfq: increase time window for waker detection
d4fc3640ff36 block, bfq: set next_rq to waker_bfqq->next_rq in waker injection
b5f74ecacc31 block, bfq: use half slice_idle as a threshold to check short ttime

The two commits prefixed by >>> above were not previously mentioned by Jens, but I reverted them anyway because they showed up in the git log command.

OK so, within 10 minutes the problem does happen still. This is block/bfq-iosched.c resulting from the above reverts, in case anyone wants to double check what I did:
https://drive.google.com/file/d/1ykU7MpmylJuXVobODWiiaLJk-XOiAjSt/view?usp=sharing



-- 
Chris Murphy
