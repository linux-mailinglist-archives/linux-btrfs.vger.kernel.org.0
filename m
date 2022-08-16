Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C1595EF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiHPPZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiHPPZ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 11:25:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B8D38A0;
        Tue, 16 Aug 2022 08:25:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 153CD1FE6C;
        Tue, 16 Aug 2022 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660663525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncy2NIOvh+ZpdU4NuJ/E1ysROFUkTZq4pOGvSv79QFc=;
        b=spgci90No15kGB3tM9JMpKdAAbKEaCfPNRC4Oy5nXsXzDvNKtwOJv/FxHg27QH91BfI5tY
        bDg68rLt6QwoocW9BqZEVzqGfS3ZDxPikFEr595KILWHtUWiDiy2Iq0flCUsFRR9Jj8Cwj
        5u5k5ij3qFS22ijqEvr674lzUdVlcyI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92F5C1345B;
        Tue, 16 Aug 2022 15:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AewjIeS2+2LKHwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 16 Aug 2022 15:25:24 +0000
Message-ID: <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
Date:   Tue, 16 Aug 2022 18:25:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.08.22 г. 17:22 ч., Chris Murphy wrote:
> 
> 
> On Sun, Aug 14, 2022, at 4:28 PM, Chris Murphy wrote:
>> On Fri, Aug 12, 2022, at 2:02 PM, Jens Axboe wrote:
>>> Might be worth trying to revert those from 5.12 to see if they are
>>> causing the issue? Jan, Paolo - does this ring any bells?
>>
>> git log --oneline --no-merges v5.11..c03c21ba6f4e > bisect.txt
>>
>> I tried checking out a33df75c6328, which is right before the first bfq
>> commit, but that kernel won't boot the hardware.
>>
>> Next I checked out v5.12, then reverted these commits in order (that
>> they were found in the bisect.txt file):
>>
>> 7684fbde4516 bfq: Use only idle IO periods for think time calculations
>> 28c6def00919 bfq: Use 'ttime' local variable
>> 41e76c85660c bfq: Avoid false bfq queue merging
>>>>> a5bf0a92e1b8 bfq: bfq_check_waker() should be static
>> 71217df39dc6 block, bfq: make waker-queue detection more robust
>> 5a5436b98d5c block, bfq: save also injection state on queue merging
>> e673914d52f9 block, bfq: save also weight-raised service on queue merging
>> d1f600fa4732 block, bfq: fix switch back from soft-rt weitgh-raising
>> 7f1995c27b19 block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
>> eb2fd80f9d2c block, bfq: replace mechanism for evaluating I/O intensity
>>>>> 1a23e06cdab2 bfq: don't duplicate code for different paths
>> 2391d13ed484 block, bfq: do not expire a queue when it is the only busy
>> one
>> 3c337690d2eb block, bfq: avoid spurious switches to soft_rt of
>> interactive queues
>> 91b896f65d32 block, bfq: do not raise non-default weights
>> ab1fb47e33dc block, bfq: increase time window for waker detection
>> d4fc3640ff36 block, bfq: set next_rq to waker_bfqq->next_rq in waker
>> injection
>> b5f74ecacc31 block, bfq: use half slice_idle as a threshold to check
>> short ttime
>>
>> The two commits prefixed by >>> above were not previously mentioned by
>> Jens, but I reverted them anyway because they showed up in the git log
>> command.
>>
>> OK so, within 10 minutes the problem does happen still. This is
>> block/bfq-iosched.c resulting from the above reverts, in case anyone
>> wants to double check what I did:
>> https://drive.google.com/file/d/1ykU7MpmylJuXVobODWiiaLJk-XOiAjSt/view?usp=sharing
> 
> Any suggestions for further testing? I could try go down farther in the bisect.txt list. The problem is if the hardware falls over on an unbootable kernel, I have to bug someone with LOM access. That's a limited resource.
> 
> 

How about changing the scheduler either mq-deadline or noop, just to see 
if this is also reproducible with a different scheduler. I guess noop 
would imply the blk cgroup controller is going to be disabled
