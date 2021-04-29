Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A06136F0A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhD2TmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhD2Tl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 15:41:58 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D5C06138B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 12:41:10 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 66so28867740qkf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/orzsSXkdr8ycOUD/1o7fyJ5Xyf/zPqGDHw8f2QxF8E=;
        b=d88vel4YE6cC/PonK2QB+n8bbKKHrr5Sm1bEOp6lx/hDMuqiS3snZDDhDZIMyY1ujr
         0pHbHDZ0DjSEBDOijUtFf8jGZYgDDGunslDAHfeYPfAzObe1nZPw6x8temfi3q3sPrKB
         1W44W57hv495QN+f3cXbROYtnpRiG19uN8mNFPlfiDAxm+HiLkHx/GIUSysdAbLWlzUQ
         9VohaOLo2RCI0UDA17CBtBnHCdbIJ1rIFdThrG933Tcb/ItqWMNzqjXEEKKHQmP1oUlm
         RbgRTcu66U1OpHP8GFmYGwvE0ipGtVvM2qh/59ZXxe69u5Z7BCSoKe3rCF78mYdflUl3
         /8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/orzsSXkdr8ycOUD/1o7fyJ5Xyf/zPqGDHw8f2QxF8E=;
        b=HMUOvZUSuWzwQj5VtsnCVUa3tBlxBGXAg94aAom60tdqEYGJZArGSGijnWe18zWTvg
         HoOns/po9y59yNJw2F2+DI0yk3D0VcjtvYACgYAGsB/28/6kwYOsQthCbKVS65I7tnHQ
         geLTDR3EUAz0xYSZ1qLgvrj5PMVPYB2RN/4JVeQRPV6G8sFKVqb00W9KpparOeso3oUK
         e21Rz3XFhmfTSFwojAKEc3gwLaKUypQSASBOLflHAG4QpyHGuBFP9oDfwXzt5kexQ+cs
         JI5HtQo8n99FZGsNovuIe9AATzSEms5tGWsVGkA4SDh1Cs+TUAmjU8eGZkv5p3ZmBiDg
         yCAw==
X-Gm-Message-State: AOAM532u94KiRowcT6jL9jroFGJKqp1V8ndYNn/kwG0cwLeYm2Y7m5TV
        MqP2M5mxe/fbNk1cgA++YI8p+Q==
X-Google-Smtp-Source: ABdhPJwGygKjz8v1B5wBtTOjz56qTM8VxPGhweHX3OV6vQNkkhc3CrZxxZwiznAzsJQ1YBNFQjzk9Q==
X-Received: by 2002:a37:ae02:: with SMTP id x2mr1342337qke.335.1619725269252;
        Thu, 29 Apr 2021 12:41:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::11c3? ([2620:10d:c091:480::1:df9a])
        by smtp.gmail.com with ESMTPSA id m16sm2778774qkm.100.2021.04.29.12.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 12:41:08 -0700 (PDT)
Subject: Re: [PATCH] btrfs: avoid RCU stalls while running delayed iputs
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <c979946e8341274a0a45cfe9166cf6e4bea25a3e.1619707886.git.josef@toxicpanda.com>
 <20210429192547.GY7604@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4ad410ac-0739-0867-2d3b-a10eda7f7ea8@toxicpanda.com>
Date:   Thu, 29 Apr 2021 15:41:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429192547.GY7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/29/21 3:25 PM, David Sterba wrote:
> On Thu, Apr 29, 2021 at 10:51:34AM -0400, Josef Bacik wrote:
>> Generally a delayed iput is added when we might do the final iput, so
>> usually we'll end up sleeping while processing the delayed iputs
>> naturally.  However there's no guarantee of this, especially for small
>> files.  In production we noticed 5 instances of RCU stalls while testing
>> a kernel release overnight across 1000 machines, so this is relatively
>> common
>>
>> host count: 5
>> rcu: INFO: rcu_sched self-detected stall on CPU
>>   rcu: \x091-....: (20998 ticks this GP) idle=59e/1/0x4000000000000002 softirq=12333372/12333372 fqs=3208
>>   \x09(t=21031 jiffies g=27810193 q=41075) NMI backtrace for cpu 1
>>   CPU: 1 PID: 1713 Comm: btrfs-cleaner Kdump: loaded Not tainted 5.6.13-0_fbk12_rc1_5520_gec92bffc1ec9 #1
>>   "Hardware name: Quanta Tioga Pass Single Side 01-0030993006\x5cx0d/Tioga Pass Single Side, BIOS F08_3A24 05/13/2020"
>>   Call Trace: <IRQ> dump_stack+0x50/0x70 nmi_cpu_backtrace.cold.6+0x30/0x65
>>   ? lapic_can_unplug_cpu.cold.30+0x40/0x40 nmi_trigger_cpumask_backtrace+0xba/0xca
>>   rcu_dump_cpu_stacks+0x99/0xc7 rcu_sched_clock_irq.cold.90+0x1b2/0x3a3
>>   ? trigger_load_balance+0x5c/0x200 ? tick_sched_do_timer+0x60/0x60
>>   ? tick_sched_do_timer+0x60/0x60 update_process_times+0x24/0x50
>>   tick_sched_timer+0x37/0x70 __hrtimer_run_queues+0xfe/0x270
>>   hrtimer_interrupt+0xf4/0x210 smp_apic_timer_interrupt+0x5e/0x120
>>   apic_timer_interrupt+0xf/0x20 </IRQ>
>>   RIP: 0010:queued_spin_lock_slowpath+0x17d/0x1b0
>>   RSP: 0018:ffffc9000da5fe48 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
>>   RAX: 0000000000000000 RBX: ffff889fa81d0cd8 RCX: 0000000000000029
>>   RDX: ffff889fff86c0c0 RSI: 0000000000080000 RDI: ffff88bfc2da7200
>>   RBP: ffff888f2dcdd768 R08: 0000000001040000 R09: 0000000000000000
>>   R10: 0000000000000001 R11: ffffffff82a55560 R12: ffff88bfc2da7200
>>   R13: 0000000000000000 R14: ffff88bff6c2a360 R15: ffffffff814bd870
>>   ? kzalloc.constprop.57+0x30/0x30 list_lru_add+0x5a/0x100
>>   inode_lru_list_add+0x20/0x40 iput+0x1c1/0x1f0 run_delayed_iput_locked+0x46/0x90
>>   btrfs_run_delayed_iputs+0x3f/0x60 cleaner_kthread+0xf2/0x120 kthread+0x10b/0x130
> 
> This got mangled, please resend or paste the correct version so I can
> replace it.
> 

Sorry that's actually what it looks like from our coalescing tool, I'll reformat 
it and resend in a bit.  Thanks,

Josef
