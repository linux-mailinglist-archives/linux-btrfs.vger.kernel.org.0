Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF504FFED7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 21:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiDMTO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiDMTNP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 15:13:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C29176E1F;
        Wed, 13 Apr 2022 12:08:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0C9A218EF;
        Wed, 13 Apr 2022 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649876930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9EyFhZgfXVFqDOsGJ8GGdwNni7OZbvbe647ljn8l0Kg=;
        b=crSSLVb7nuaM5pMQ9PmWBc+Yv5OTLyBrGq/yvmHYRW6kBmQpl9rH14sTEvCsnuU2T6OwUD
        cF6lo/Dcn/QQ04wcLreovJ8K6Pw90vXEQmSYKGJ2BWelryhwjnrvbBAWXsCtGuhrhj0lV7
        MVY22fkx0No8qug34GDhqIwqPtUEx/k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78A6413A91;
        Wed, 13 Apr 2022 19:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X2JiGsIfV2J8AgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Apr 2022 19:08:50 +0000
Message-ID: <c3577a83-9889-c741-bb74-051a6d9a0f61@suse.com>
Date:   Wed, 13 Apr 2022 22:08:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: zstd: use spin_lock in timer callback
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>
Cc:     dsterba@suse.cz, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, terrelln@fb.com
References: <20220411135136.GG15609@suse.cz>
 <20220411155540.36853-1-schspa@gmail.com>
 <09c2a9ce-3b04-ed94-1d62-0e5a072b9dac@suse.com>
 <CAMA88TpjDczKAGN3f+tcsa98rbM7EA0XgT3bHn8UjDqNJ_DeFQ@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <CAMA88TpjDczKAGN3f+tcsa98rbM7EA0XgT3bHn8UjDqNJ_DeFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.04.22 г. 19:03 ч., Schspa Shi wrote:
> Nikolay Borisov <nborisov@suse.com> writes:
> 
>> On 11.04.22 г. 18:55 ч., Schspa Shi wrote:
>>> This is an optimization for fix fee13fe96529 ("btrfs:
>>> correct zstd workspace manager lock to use spin_lock_bh()")
>>> The critical region for wsm.lock is only accessed by the process context and
>>> the softirq context.
>>> Because in the soft interrupt, the critical section will not be preempted by
>>> the
>>> soft interrupt again, there is no need to call spin_lock_bh(&wsm.lock) to turn
>>> off the soft interrupt, spin_lock(&wsm.lock) is enough for this situation.
>>> Changelog:
>>> v1 -> v2:
>>>       - Change the commit message to make it more readable.
>>> [1] https://lore.kernel.org/all/20220408181523.92322-1-schspa@gmail.com/
>>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>>
>> Has there been any measurable impact by this change? While it's correct it does mean that
>>   someone looking at the code would see that in one call site we use plain spinlock and in
>> another a _bh version and this is somewhat inconsistent.
>>
> Yes, it may seem a little confused. but it's allowed to save some
> little peace of CPU times.
> and "static inline void red_adaptative_timer(struct timer_list *t) in
> net/sched/sch_red.c"
> have similar usage.
> 
>> What's more I believe this is a noop since when softirqs are executing preemptible() would
>> be false due to preempt_count() being non-0 and in the bh-disabling code
>> in the spinlock we have:
>>
>>   /* First entry of a task into a BH disabled section? */
>>      1         if (!current->softirq_disable_cnt) {
>>    167                 if (preemptible()) {
>>      1                         local_lock(&softirq_ctrl.lock);
>>      2                         /* Required to meet the RCU bottomhalf requirements. */
>>      3                         rcu_read_lock();
>>      4                 } else {
>>      5                         DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
>>      6                 }
>>      7         }
>>
>>
>> In this case we'd hit the else branch.
> 
> We won't hit the else branch. because current->softirq_disable_cnt
> won't be zero in the origin case.
> 
> __do_softirq(void)
>          softirq_handle_begin(void)
>          __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
>                          current->softirq_disable_cnt will be > 0 at this time.

That's only relevant on CONFIG_PREEMPT_RT though, on usual kernels 
softirq_handle_being is empty. Furthermore, in case of the non-preempt 
rt if preemptible() always returns false this means that even in the 
__do_softirq path we'll never increment softirq_disable_cnt. So if 
anything this change is only beneficial (theoretically at that in 
preempt_rt scenarios).

>      ......
>          zstd_reclaim_timer_fn(struct timer_list *timer)
>                          spin_lock_bh(&wsm.lock);
>                          __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
>                          if (!current->softirq_disable_cnt) {
>                                                  // this if branch won't hit
>                                          }
> 
>          softirq_handle_end();
> 
> In this case, the "__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);"
> won't do anything useful it only
> increase softirq disable depth and decrease it in
> "__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);".
> 
> So it's safe to replace spin_lock_bh with spin_lock in a timer
> callback function.
> 
> 
> For the ksoftirqd, it's all the same.
> 
