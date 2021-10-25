Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5343A42E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhJYUQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbhJYUQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 16:16:18 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B5C07C9B4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 12:41:03 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r184so28751306ybc.10
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9MyOD93oaEUtvuFx7Rd/9T/zYI5NeWOnQEXoPk8/MU=;
        b=W2fSndLWqgTYx4Cakm0sBi330gCZgJjgCCAPwS1hBA5A71PEudaB4RfzYNecgQWMXX
         4syV8dLtgb2MHO8L7Z4c1CagHKCoiz1ncJkxYRXm03nqICFjuH1Go7LHpkhNVoziQ2rQ
         oH5tESgKJ0AGl0E8SlgpgLrFcxx/vfNL+a+IJegnwR7VzDt6LcCZftO+AFX9YdM0KS8S
         DFCZc6IuUSzpVnE4UOB2OggYtOLX2ADcYO+1D7ZKVU2kBoEFctLt8+ddaExy/9VtNMMy
         6gSpIHGJNS7kd9SxAKdlEq8o6LYw9EgAvMzN7utLOAlOyeR4Eu9es8IA6KJv8MA62PtH
         S10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9MyOD93oaEUtvuFx7Rd/9T/zYI5NeWOnQEXoPk8/MU=;
        b=RN4LQmfR9m6rgB4UDZMQNlKPmKjRvCZqgO2Mao0NEGuJcMHHKtM7LbxOpDt5Dg3Rwn
         kPoV2Kh8AScESXgCkp09YoSNz0GP2zW5k2DR0QUYHDOBx6GVPdi43iIeCUAhpuNGDFBe
         avjZeKdoTTOUsWscDcXGo38Cd6YEAoww79Qdd4HHW1mABSb2yRtnhG6cPc2Q+0ntNMav
         B0uGnHy0jaqVfnAz1n98fqaBGxsE5EldxYJYobTyJ301m3dk94pA0LgbI6QZ8bOHhnXn
         48Y54/H6vIR3ch8cbjMhDBniIUojGKjSrfSBbL2fNUGLOa8W2s+qq2j4Kh3L0M4pujpO
         +hQQ==
X-Gm-Message-State: AOAM533LU5qeIcJ+xwSIGxbCq56zbzp11WLszKp4Sw4pu4gLfs+F8hyM
        b77A7puqfZlmUvUADsG8Wkn5Ak88y8DcQpNeyKP3gg==
X-Google-Smtp-Source: ABdhPJwzhDoPwdlrSllp/fdDypqxLHgoXehfW7nRhnvc4Z+6xngzduLRBrVe+D+oSs16iXWeRn2V8V28WCV6JfsoopQ=
X-Received: by 2002:a25:42c8:: with SMTP id p191mr13672925yba.89.1635190862478;
 Mon, 25 Oct 2021 12:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com> <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
 <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
In-Reply-To: <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 Oct 2021 15:40:46 -0400
Message-ID: <CAJCQCtQ0_iAyC8Tc8OZyf2JGGnboXm8zk9itZaOLAoK=w1qdrg@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Got another sysrq+t here, while dnf is completely hung while 'dnf
install kernel-debuginfo' packages, for a long time without any call
traces or indication why it's stuck. ps aux shows it's running, but
consuming no meaningful cpu; top shows very high ~25% wa, the rest is
idle. Essentially no user or system process consumption.

https://bugzilla.redhat.com/attachment.cgi?id=1836995


Excerpts of items that are in D state:

[ 9595.270460] kernel: task:kworker/u8:7    state:D stack:    0 pid:
1296 ppid:     2 flags:0x00000008
[ 9595.280269] kernel: Workqueue: events_unbound
btrfs_async_reclaim_metadata_space
[ 9595.288593] kernel: Call trace:
[ 9595.292822] kernel:  __switch_to+0x160/0x1d4
[ 9595.298383] kernel:  __schedule+0x22c/0x5f0
[ 9595.303605] kernel:  schedule+0x54/0xdc
[ 9595.308644] kernel:  schedule_preempt_disabled+0x1c/0x30
[ 9595.314929] kernel:  __mutex_lock.constprop.0+0x184/0x544
[ 9595.321559] kernel:  __mutex_lock_slowpath+0x1c/0x30
[ 9595.327579] kernel:  mutex_lock+0x6c/0x80
[ 9595.332600] kernel:  btrfs_start_delalloc_roots+0x78/0x320
[ 9595.339303] kernel:  shrink_delalloc+0xf4/0x260
[ 9595.344883] kernel:  flush_space+0x110/0x2a0
[ 9595.350402] kernel:  btrfs_async_reclaim_metadata_space+0x130/0x350
[ 9595.357574] kernel:  process_one_work+0x1f0/0x4ac
[ 9595.363215] kernel:  worker_thread+0x188/0x504
[ 9595.368921] kernel:  kthread+0x110/0x114
[ 9595.373958] kernel:  ret_from_fork+0x10/0x18
[ 9595.379413] kernel: task:kworker/u8:9    state:D stack:    0 pid:
1300 ppid:     2 flags:0x00000008
[ 9595.389417] kernel: Workqueue: writeback wb_workfn (flush-btrfs-1)
[ 9595.396867] kernel: Call trace:
[ 9595.401256] kernel:  __switch_to+0x160/0x1d4
[ 9595.406688] kernel:  __schedule+0x22c/0x5f0
[ 9595.411998] kernel:  schedule+0x54/0xdc
[ 9595.417000] kernel:  inode_sleep_on_writeback+0x8c/0xb0
[ 9595.423152] kernel:  wb_writeback+0x174/0x3dc
[ 9595.428734] kernel:  wb_do_writeback+0x114/0x394
[ 9595.434404] kernel:  wb_workfn+0x80/0x2a0
[ 9595.439815] kernel:  process_one_work+0x1f0/0x4ac
[ 9595.445807] kernel:  worker_thread+0x260/0x504
[ 9595.451559] kernel:  kthread+0x110/0x114
[ 9595.456623] kernel:  ret_from_fork+0x10/0x18
[ 9595.461987] kernel: task:kworker/u8:13   state:D stack:    0 pid:
1304 ppid:     2 flags:0x00000008
[ 9595.472144] kernel: Workqueue: events_unbound
btrfs_preempt_reclaim_metadata_space
[ 9595.480865] kernel: Call trace:
[ 9595.485360] kernel:  __switch_to+0x160/0x1d4
[ 9595.491154] kernel:  __schedule+0x22c/0x5f0
[ 9595.496601] kernel:  schedule+0x54/0xdc
[ 9595.501702] kernel:  io_schedule+0x48/0x6c
[ 9595.507098] kernel:  wait_on_page_bit_common+0x15c/0x400
[ 9595.513421] kernel:  __lock_page+0x60/0x80
[ 9595.518791] kernel:  extent_write_cache_pages+0x29c/0x3cc
[ 9595.525199] kernel:  extent_writepages+0x44/0xb0
[ 9595.531110] kernel:  btrfs_writepages+0x1c/0x30
[ 9595.536813] kernel:  do_writepages+0x44/0xf0
[ 9595.542223] kernel:  __writeback_single_inode+0x48/0x400
[ 9595.548938] kernel:  writeback_single_inode+0xf4/0x240
[ 9595.555245] kernel:  sync_inode+0x1c/0x2c
[ 9595.560604] kernel:  start_delalloc_inodes+0x188/0x450
[ 9595.567634] kernel:  btrfs_start_delalloc_roots+0x194/0x320
[ 9595.574325] kernel:  shrink_delalloc+0xf4/0x260
[ 9595.580087] kernel:  flush_space+0x110/0x2a0
[ 9595.585381] kernel:  btrfs_preempt_reclaim_metadata_space+0x148/0x270
[ 9595.593048] kernel:  process_one_work+0x1f0/0x4ac
[ 9595.599040] kernel:  worker_thread+0x188/0x504
[ 9595.604515] kernel:  kthread+0x110/0x114
[ 9595.609959] kernel:  ret_from_fork+0x10/0x18

...

[ 9596.146831] kernel: task:dnf             state:D stack:    0
pid:14580 ppid: 14579 flags:0x00000000
[ 9596.156309] kernel: Call trace:
[ 9596.160424] kernel:  __switch_to+0x160/0x1d4
[ 9596.165512] kernel:  __schedule+0x22c/0x5f0
[ 9596.170758] kernel:  schedule+0x54/0xdc
[ 9596.175419] kernel:  wb_wait_for_completion+0x78/0xac
[ 9596.181577] kernel:  __writeback_inodes_sb_nr+0x80/0xa0
[ 9596.187695] kernel:  writeback_inodes_sb+0x58/0x70
[ 9596.193322] kernel:  sync_filesystem+0x50/0xc0
[ 9596.198714] kernel:  __arm64_sys_syncfs+0x54/0xb0
[ 9596.204163] kernel:  invoke_syscall+0x50/0x120
[ 9596.209724] kernel:  el0_svc_common+0x48/0x100
[ 9596.214986] kernel:  do_el0_svc+0x34/0xa0
[ 9596.220105] kernel:  el0_svc+0x2c/0x54
[ 9596.224755] kernel:  el0t_64_sync_handler+0xa4/0x130
[ 9596.230745] kernel:  el0t_64_sync+0x19c/0x1a0
