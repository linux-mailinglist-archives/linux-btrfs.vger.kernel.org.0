Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3623950197A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbiDNREp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiDNRDn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 13:03:43 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3ED972BD;
        Thu, 14 Apr 2022 09:40:03 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k17so5054764vsq.0;
        Thu, 14 Apr 2022 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NUpVA5eYOb2M8t4G0qrVj0JSOzxiO0fCAejkOocIXao=;
        b=Gpc5QjXr+gtvBrwu7vWEx+QgDTN+050AGC7nmF62hwXczPBWzSoA9w+knrsKgpTcgk
         8oa3CY/ypOG50jZJ572CW7fZW/rm647lLzGc9pwMBpmScXddg/wDSXYF60ScPb6tOdo3
         tiWaBYP/19QHNemVehQ+q3FbXzHyQBS7oSlDwg8C89KYWJo7Ct4lEu9vnzd/UDSCWV+j
         Gz8njvyp8lJTmOQyjvlOrfjbhWAb7KaN5ye2exn60ZWWIt3yk6MGxnlZ59N9BIPf7ETO
         ejvwjhrl7fQh62xrW7q24AZtsJc2pbNRYblgKWT1uiyH7/05ialXUCpzQBxn5XwHHnSw
         kNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NUpVA5eYOb2M8t4G0qrVj0JSOzxiO0fCAejkOocIXao=;
        b=w+vrgJWrrkK9lDSXoCY7RSXIBzKcIRzgEhW1HeObqfzv5kqnKTlUAdWruNY46231cC
         3Aby9JXpr8gsI1iGWO5jfV9qlXlYvnC0SJUFyBrwDXqah8l2vckW1g8p7vGwFeH+vHTp
         lNlT8sE80InOAzcer/x5MNyWyRMW4siBuroVdXOGKgP7ZRSWS9/JksWv70pPO1h8joC7
         qeY1duzxGHUuD26EHH1u/Z3BCDV19jV6UsrMuWQOOXRZpSe+lB6tiAAzRO9tluk6Ntr2
         xKaVIj6h1RCInsxNs7XQgWZH1uaUWTXzakctMSl6d9ME8SNy7cDoVUtlMJY7u7s0tSAK
         3SZA==
X-Gm-Message-State: AOAM532SZHcEOvyTEkGBEGj9kx8CEhAHa/GzVVkgW4CRFPyTC8pNGLFi
        cAsGdCqScsxR6REXLUm6Ciq+j5tiv9iC9TH9Pq0FIw+bt8gRMQ==
X-Google-Smtp-Source: ABdhPJwlTQ30MpDobYUv402hkhofITTJDYdzziScW5eD+bv9NrbvfnClwP7ariZr7LHydPMeaASPDSZ0j6vywLPfbMM=
X-Received: by 2002:a67:a44d:0:b0:320:601b:2a08 with SMTP id
 p13-20020a67a44d000000b00320601b2a08mr1644691vsh.70.1649954402542; Thu, 14
 Apr 2022 09:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220411135136.GG15609@suse.cz> <20220411155540.36853-1-schspa@gmail.com>
 <09c2a9ce-3b04-ed94-1d62-0e5a072b9dac@suse.com> <CAMA88TpjDczKAGN3f+tcsa98rbM7EA0XgT3bHn8UjDqNJ_DeFQ@mail.gmail.com>
 <c3577a83-9889-c741-bb74-051a6d9a0f61@suse.com>
In-Reply-To: <c3577a83-9889-c741-bb74-051a6d9a0f61@suse.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 15 Apr 2022 00:39:49 +0800
Message-ID: <CAMA88ToGtzgmS2820NO3_Di+OnAti7_BS4c8qS+L+xhKST7jOQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: zstd: use spin_lock in timer callback
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, clm@fb.com, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay Borisov <nborisov@suse.com> writes:

> On 13.04.22 =D0=B3. 19:03 =D1=87., Schspa Shi wrote:
>> Nikolay Borisov <nborisov@suse.com> writes:
>>
>>> On 11.04.22 =D0=B3. 18:55 =D1=87., Schspa Shi wrote:
>>>> This is an optimization for fix fee13fe96529 ("btrfs:
>>>> correct zstd workspace manager lock to use spin_lock_bh()")
>>>> The critical region for wsm.lock is only accessed by the process conte=
xt and
>>>> the softirq context.
>>>> Because in the soft interrupt, the critical section will not be preemp=
ted by
>>>> the
>>>> soft interrupt again, there is no need to call spin_lock_bh(&wsm.lock)=
 to turn
>>>> off the soft interrupt, spin_lock(&wsm.lock) is enough for this situat=
ion.
>>>> Changelog:
>>>> v1 -> v2:
>>>>       - Change the commit message to make it more readable.
>>>> [1] https://lore.kernel.org/all/20220408181523.92322-1-schspa@gmail.co=
m/
>>>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>>>
>>> Has there been any measurable impact by this change? While it's correct=
 it does mean that
>>>   someone looking at the code would see that in one call site we use pl=
ain spinlock and in
>>> another a _bh version and this is somewhat inconsistent.
>>>
>> Yes, it may seem a little confused. but it's allowed to save some
>> little peace of CPU times.
>> and "static inline void red_adaptative_timer(struct timer_list *t) in
>> net/sched/sch_red.c"
>> have similar usage.
>>
>>> What's more I believe this is a noop since when softirqs are executing =
preemptible() would
>>> be false due to preempt_count() being non-0 and in the bh-disabling cod=
e
>>> in the spinlock we have:
>>>
>>>   /* First entry of a task into a BH disabled section? */
>>>      1         if (!current->softirq_disable_cnt) {
>>>    167                 if (preemptible()) {
>>>      1                         local_lock(&softirq_ctrl.lock);
>>>      2                         /* Required to meet the RCU bottomhalf r=
equirements. */
>>>      3                         rcu_read_lock();
>>>      4                 } else {
>>>      5                         DEBUG_LOCKS_WARN_ON(this_cpu_read(softir=
q_ctrl.cnt));
>>>      6                 }
>>>      7         }
>>>
>>>
>>> In this case we'd hit the else branch.
>> We won't hit the else branch. because current->softirq_disable_cnt
>> won't be zero in the origin case.
>> __do_softirq(void)
>>          softirq_handle_begin(void)
>>          __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
>>                          current->softirq_disable_cnt will be > 0 at thi=
s time.
>
> That's only relevant on CONFIG_PREEMPT_RT though, on usual kernels
> softirq_handle_being is empty. Furthermore, in case of the non-preempt
> rt if preemptible() always returns false this means that even in the
> __do_softirq path we'll never increment softirq_disable_cnt. So if
> anything this change is only beneficial (theoretically at that in preempt=
_rt
> scenarios).
>
For either case, __local_bh_disable_ip will add preempt count or something =
else.
for CONFIG_PREEMPT_RT we have discussed, it will be OK and some beneficial.

In the case of CONFIG_TRACE_IRQFLAGS:

#ifdef CONFIG_TRACE_IRQFLAGS
void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
{
        unsigned long flags;

        WARN_ON_ONCE(in_hardirq());

        raw_local_irq_save(flags);
        /*
         * The preempt tracer hooks into preempt_count_add and will break
         * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
         * is set and before current->softirq_enabled is cleared.
         * We must manually increment preempt_count here and manually
         * call the trace_preempt_off later.
         */
        __preempt_count_add(cnt);
        /*
         * Were softirqs turned off above:
         */
        if (softirq_count() =3D=3D (cnt & SOFTIRQ_MASK))
                lockdep_softirqs_off(ip);
        raw_local_irq_restore(flags);

        if (preempt_count() =3D=3D cnt) {
#ifdef CONFIG_DEBUG_PREEMPT
                current->preempt_disable_ip =3D get_lock_parent_ip();
#endif
                trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
        }
}
EXPORT_SYMBOL(__local_bh_disable_ip);
#endif /* CONFIG_TRACE_IRQFLAGS */

There is also __preempt_count_add(cnt), local IRQ disable. which
reduces the system's
corresponding speed.

In another case (usual kernels):

#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
#else
static __always_inline void __local_bh_disable_ip(unsigned long ip,
unsigned int cnt)
{
        preempt_count_add(cnt);
        barrier();
}
#endif

There is preempt_count_add(cnt), and it's useless in the timer's callback.

In summary:
There is a benefit for all the cases to replace spin_lock_bh with spin_lock=
 in
timer's callback.

>>      ......
>>          zstd_reclaim_timer_fn(struct timer_list *timer)
>>                          spin_lock_bh(&wsm.lock);
>>                          __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET)=
;
>>                          if (!current->softirq_disable_cnt) {
>>                                                  // this if branch won't=
 hit
>>                                          }
>>          softirq_handle_end();
>> In this case, the "__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);"
>> won't do anything useful it only
>> increase softirq disable depth and decrease it in
>> "__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);".
>> So it's safe to replace spin_lock_bh with spin_lock in a timer
>> callback function.
>>
>> For the ksoftirqd, it's all the same.
>>
