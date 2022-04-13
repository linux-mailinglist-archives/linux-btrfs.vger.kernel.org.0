Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271AD4FFAD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiDMQFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMQFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 12:05:39 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38ED580EF;
        Wed, 13 Apr 2022 09:03:17 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i34so1022804vsv.6;
        Wed, 13 Apr 2022 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AfVBOcs8TbWmDB0JA6H2aLSdPzU05jThWpLa6v2Z6KI=;
        b=Ck/2Ng2+EQritbp1vgGqN5aG+YGHPGy3A5Z9PvraSx669ZdalePtKkEv6aCHMi0SJo
         1h4aCwm7tzYMQOHHq/qAh9d1Qa13Aio/3mktyCdYZgAZmTUEMO6knyDxWtlFpeduuUPO
         sWhmLXcfFHt7dS9ZamX9lmws9V8rGZL9b07z+cRxxk3Ervw6RPnQwTS5DMw/3313qa5k
         pvEwSz+vq1NeCPuqrN83KgqrQk7BuI4XKZJo3Nca/Mp/xJKxma5fLSb4AlrZ+7Wo+bCb
         F9K1O/UaVyG9NJ5NBi0O1RQpos4ip3FN6McGtLxbIeVv3pZokC5Eml36f1gznCa2/JVv
         qVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AfVBOcs8TbWmDB0JA6H2aLSdPzU05jThWpLa6v2Z6KI=;
        b=3kQeyXO3I5RW0o+9KdoV93YrOjWRuooYZi2m0vu0vMffGPcHOX9KUzGjOyflfz93TG
         k8r3RSPgZaKmpYJP7QEQAW69q4yJjKChgkkbAp+jmPaEd/xErthGGxgHBBe4rG7nsbb+
         omRGAIERLvN8vThmT/PontWIB5xLIiwnR4ytQOIgKsGM61wFMXI05hl/tREbuZ6RRTBE
         Gopu3SMO3nIVb3SEt06ssnP1YkCir38eW+VAaPzJLIqSg3eRv7gPfnXCfg5O0PPjwMsp
         gmiuRTZSKwvDagN4Ugoi1+v4rtyCuH/a4/od9Kc6BT/D6BYeKdz0qYFEsdl8CPaCfLPw
         ehFg==
X-Gm-Message-State: AOAM533QSf6MEbIOqIrrFl9z5AwDD7J6K1puY3GA+5A33quymYsIyPwz
        Ved6mK1qu75clF0j8D6tB7gU+9+hDBuCFa9XqbAtrHFW0wBhfg==
X-Google-Smtp-Source: ABdhPJwMbHZ6SDpA+RhfmpicqxV0i4BNxl7r/8BKma92g74kjhX6w46FuCPd62AbR3+pGoWXuCLC5AbD/RgdVN9hV3E=
X-Received: by 2002:a67:a44d:0:b0:320:601b:2a08 with SMTP id
 p13-20020a67a44d000000b00320601b2a08mr13581695vsh.70.1649865796922; Wed, 13
 Apr 2022 09:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220411135136.GG15609@suse.cz> <20220411155540.36853-1-schspa@gmail.com>
 <09c2a9ce-3b04-ed94-1d62-0e5a072b9dac@suse.com>
In-Reply-To: <09c2a9ce-3b04-ed94-1d62-0e5a072b9dac@suse.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Thu, 14 Apr 2022 00:03:05 +0800
Message-ID: <CAMA88TpjDczKAGN3f+tcsa98rbM7EA0XgT3bHn8UjDqNJ_DeFQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: zstd: use spin_lock in timer callback
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, terrelln@fb.com
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

> On 11.04.22 =D0=B3. 18:55 =D1=87., Schspa Shi wrote:
>> This is an optimization for fix fee13fe96529 ("btrfs:
>> correct zstd workspace manager lock to use spin_lock_bh()")
>> The critical region for wsm.lock is only accessed by the process context=
 and
>> the softirq context.
>> Because in the soft interrupt, the critical section will not be preempte=
d by
>> the
>> soft interrupt again, there is no need to call spin_lock_bh(&wsm.lock) t=
o turn
>> off the soft interrupt, spin_lock(&wsm.lock) is enough for this situatio=
n.
>> Changelog:
>> v1 -> v2:
>>      - Change the commit message to make it more readable.
>> [1] https://lore.kernel.org/all/20220408181523.92322-1-schspa@gmail.com/
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> Has there been any measurable impact by this change? While it's correct i=
t does mean that
>  someone looking at the code would see that in one call site we use plain=
 spinlock and in
> another a _bh version and this is somewhat inconsistent.
>
Yes, it may seem a little confused. but it's allowed to save some
little peace of CPU times.
and "static inline void red_adaptative_timer(struct timer_list *t) in
net/sched/sch_red.c"
have similar usage.

> What's more I believe this is a noop since when softirqs are executing pr=
eemptible() would
> be false due to preempt_count() being non-0 and in the bh-disabling code
> in the spinlock we have:
>
>  /* First entry of a task into a BH disabled section? */
>     1         if (!current->softirq_disable_cnt) {
>   167                 if (preemptible()) {
>     1                         local_lock(&softirq_ctrl.lock);
>     2                         /* Required to meet the RCU bottomhalf requ=
irements. */
>     3                         rcu_read_lock();
>     4                 } else {
>     5                         DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_c=
trl.cnt));
>     6                 }
>     7         }
>
>
> In this case we'd hit the else branch.

We won't hit the else branch. because current->softirq_disable_cnt
won't be zero in the origin case.

__do_softirq(void)
        softirq_handle_begin(void)
        __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
                        current->softirq_disable_cnt will be > 0 at this ti=
me.
    ......
        zstd_reclaim_timer_fn(struct timer_list *timer)
                        spin_lock_bh(&wsm.lock);
                        __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
                        if (!current->softirq_disable_cnt) {
                                                // this if branch won't hit
                                        }

        softirq_handle_end();

In this case, the "__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);"
won't do anything useful it only
increase softirq disable depth and decrease it in
"__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);".

So it's safe to replace spin_lock_bh with spin_lock in a timer
callback function.


For the ksoftirqd, it's all the same.
