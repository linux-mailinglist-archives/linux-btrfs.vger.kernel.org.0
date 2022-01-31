Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22C54A477F
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jan 2022 13:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351059AbiAaMs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 07:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbiAaMsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 07:48:25 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9246C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 04:48:25 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e8so11219984ilm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 04:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=7Y2ZTT3h64LUd0bybOlB8MdiSEFKNhwKIb5d+EMEgoc=;
        b=p5B0kWifT9hExrLsKu/qZiDMc05U92+19JItW+fvikeWq8EWMKs5bND9rKTwOMwz/K
         +6PdhRqjmrU+jJX0mzdnL3ID42EyU+T6BuGepyuBPXAcbLb0LhLBvoHCUNY2v+svJsZT
         F1/xUB+PI2HHs/DXDAqbqnEikvNE8wPrISzxv24rS+sawoQ7u5pUBk+uzGlah0mTuTXK
         8KYHa9Gpmgl+0DY14DDJTQTJi2l+nTGwagQPnc/6HzP0oheUUWz8H0m2S8EUmnFGlHeS
         xSV9j+KrgimWH/f5tBDt2lE7o1T0/s/Cyf0+kw2GJUx/ILrm0VWpcoMlFPzzpqHgQn19
         012Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7Y2ZTT3h64LUd0bybOlB8MdiSEFKNhwKIb5d+EMEgoc=;
        b=1w4oKN2b68flHUtEVQNCHg7wES38/fLza6q9l1gBbXWKnAN6Y3X6W83o+QYKti3FRn
         GJyZDwZPN629NGpyqxArH7KkOOJwe9nnvqORV+rDPdBBDTk+SIF2butSwv1fi2Dpflmb
         s4wS/5GLEObSkLrVoPeHaB7LjHvkLHllgtT1x6tWZUQYc4bWWuG1IeerIA5E2XECfENu
         055dcE2O/rOFkR3DszvmEmpH6jL55Xy1Z3dzOZQzQslGL1DsTMobmH+Xa+U8qJXqYfvF
         MwEZWvsDqdL3MJN2Dk/OteiGuA9YCLi9B80jLJEyMkoGwfFzASl/uXdBs7bQ791n/8qr
         dw7w==
X-Gm-Message-State: AOAM532nmCkQRGgRWbdqrsryLAP3SVRJrViuUw4snv+98CehEkuGdpNK
        Uwd8qQ+2panxR/ItRFwq3E1whlG0sdIw0bTn864NmnQ8yq0yfQ==
X-Google-Smtp-Source: ABdhPJwSdLWNNop6scYOzaxsMRjiNNtljcmJeU08HHIFzP8H6SKTFYbAQjzpzGuHUqMO3zKgQW6KGxHruz0F/s80qSE=
X-Received: by 2002:a05:6e02:1d17:: with SMTP id i23mr11679090ila.185.1643633304681;
 Mon, 31 Jan 2022 04:48:24 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 31 Jan 2022 13:48:13 +0100
Message-ID: <CAA85sZtjs9Bk5zqu7sPOF+44e4n8z1FYh5nX2pRMF=c+ehFbxw@mail.gmail.com>
Subject: RCU deadlocks while defraging
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On one of my machines i keep running in to this when doing "btrfs fi
def -r -v /"

Last file that caused this was:
ls -la /usr/src/linux-test/arch/microblaze/include/asm/cputable.h
-rw-r--r-- 1 root root 1 21 feb  2016
/usr/src/linux-test/arch/microblaze/include/asm/cputable.h

Leftover from a old git commit i assume, since it was empty...  will
check with git later on

Any clues?

[  131.057810] rcu: INFO: rcu_preempt self-detected stall on CPU
[  131.063665] rcu: 4-....: (21192 ticks this GP)
idle=2ab/1/0x4000000000000000 softirq=13633/13635 fqs=5250
[  131.073509] (t=21000 jiffies g=32185 q=242)
[  131.073518] NMI backtrace for cpu 4
[  131.073522] CPU: 4 PID: 1137 Comm: btrfs Not tainted 5.16.4 #306
[  131.073530] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.4 01/29/2021
[  131.073535] Call Trace:
[  131.073542]  <IRQ>
[  131.073548]  dump_stack_lvl+0x34/0x44
[  131.073565]  nmi_cpu_backtrace.cold+0x30/0x70
[  131.073576]  ? lapic_can_unplug_cpu+0x80/0x80
[  131.073585]  nmi_trigger_cpumask_backtrace+0xb7/0xd0
[  131.073597]  rcu_dump_cpu_stacks+0xc8/0xf0
[  131.073608]  rcu_sched_clock_irq.cold+0x60/0x2f2
[  131.073621]  ? update_load_avg+0x77/0x570
[  131.073631]  ? kvm_set_tsc_khz+0x190/0x190
[  131.073641]  ? raw_notifier_call_chain+0x3f/0x50
[  131.073651]  ? timekeeping_update+0xd9/0x120
[  131.073659]  ? __cgroup_account_cputime_field+0x58/0x80
[  131.073670]  update_process_times+0x8e/0xc0
[  131.073681]  tick_sched_handle+0x2f/0x40
[  131.073690]  tick_sched_timer+0x7f/0xa0
[  131.073698]  ? can_stop_idle_tick+0xd0/0xd0
[  131.073706]  __hrtimer_run_queues+0x125/0x2c0
[  131.073718]  hrtimer_interrupt+0x101/0x210
[  131.073726]  __sysvec_apic_timer_interrupt+0x7a/0x160
[  131.073736]  sysvec_apic_timer_interrupt+0x9d/0xd0
[  131.073745]  </IRQ>
[  131.073748]  <TASK>
[  131.073751]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  131.073764] RIP: 0010:memcg_slab_free_hook+0x7/0x180
[  131.073777] Code: ff ff ff ff 48 c1 e8 0c 48 0f bd f0 83 c6 01 e8
df 1c fe ff 48 89 ee 4c 89 e7 5d 41 5c e9 21 dd 05 00 90 0f 1f 44 00
00 85 d2 <0f> 8e 61 01 00 00 8d 42 ff 41 57 41 56 41 55 49 89 f5 41 54
4c 8d
[  131.073784] RSP: 0018:ffffb070c1bcba38 EFLAGS: 00000202
[  131.073792] RAX: ffff939438218201 RBX: ffff9394382182a0 RCX: d88221389493ffff
[  131.073798] RDX: 0000000000000001 RSI: ffffb070c1bcba50 RDI: ffff9392c018a100
[  131.073803] RBP: fffffac7c9e08600 R08: 0000000000000000 R09: 0000000000000000
[  131.073808] R10: 0000000000000000 R11: 000000668c3dc000 R12: 0000000000000000
[  131.073813] R13: ffffffffa74085a3 R14: ffff9392c018a100 R15: ffff9394382182a0
[  131.073818]  ? btrfs_get_extent+0x403/0x810
[  131.073833]  kmem_cache_free+0x262/0x2b0
[  131.073845]  btrfs_get_extent+0x403/0x810
[  131.073857]  defrag_lookup_extent+0x101/0x140
[  131.073867]  defrag_collect_targets+0x50/0x270
[  131.073877]  btrfs_defrag_file+0x241/0xdf0
[  131.073885]  ? make_kuid+0xa/0x10
[  131.073892]  ? generic_permission+0x22/0x200
[  131.073902]  ? make_kuid+0xa/0x10
[  131.073908]  ? generic_permission+0x22/0x200
[  131.073920]  ? cap_inode_killpriv+0x20/0x20
[  131.073930]  ? security_capable+0x31/0x50
[  131.073939]  btrfs_ioctl_defrag+0xf0/0x170
[  131.073950]  btrfs_ioctl+0x1c9d/0x2e50
[  131.073960]  ? __check_object_size+0x12e/0x140
[  131.073971]  ? do_sys_openat2+0x7c/0x150
[  131.073978]  ? kmem_cache_free+0x262/0x2b0
[  131.073989]  ? __x64_sys_ioctl+0x7d/0xb0
[  131.073996]  __x64_sys_ioctl+0x7d/0xb0
[  131.074004]  do_syscall_64+0x3b/0x90
[  131.074015]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  131.074026] RIP: 0033:0x7f815a8c37b7
[  131.074034] Code: d8 49 39 c4 72 d8 49 8d 3c 1c e8 34 ff ff ff 85
c0 79 9f 5b 49 c7 c4 ff ff ff ff 5d 4c 89 e0 41 5c c3 90 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 49 16 0f 00 f7 d8 64 89
01 48
[  131.074039] RSP: 002b:00007fff1c0a4c48 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  131.074048] RAX: ffffffffffffffda RBX: 00007fff1c0a5800 RCX: 00007f815a8c37b7
[  131.074053] RDX: 000055cb5ef66060 RSI: 0000000040309410 RDI: 0000000000000009
[  131.074058] RBP: 000055cb5f426330 R08: 0000000000000000 R09: 00007f815a9713e0
[  131.074063] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
[  131.074067] R13: 00007fff1c0a4c80 R14: 000000000000000a R15: 0000000000000000
[  131.074076]  </TASK>
