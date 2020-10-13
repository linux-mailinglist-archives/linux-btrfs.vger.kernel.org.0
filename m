Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB65D28D06A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbgJMOjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388823AbgJMOjl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 10:39:41 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF2FC0613D0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:39:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so20953790ilt.13
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t8E8HmlL/BHH9EyBKDMPQRltWFEhVkkZZ5XBcH9v72M=;
        b=nlLakMA/zcBcBIXGiRh8oyRGWmrQWFF+2Cv9kUdU6P6n37T/2EdNmJ8FGlkTStbwQM
         55iogURp6Q2PEZqnXxTD5wxtRVk3bzwUCVfVFyFXsVtaO6maulos9+Ytq1O8MQQ+k4lL
         mUy42KLNgVDBnw4ENYIoAkv9KwKdHKC0JTKB6ilRqOEMkwXFD6VouXsI2ok0Oii+5t3K
         bEpbeeMLfLNUBAkBrOksbMy6uBY+3YNA+xdElu3WQnMBFF39sS03huBnC5E/q7Jn9+hQ
         M361lDlH+Se9ibreWd1+zWpp3UMYtDY2IA72EPKMjuns8crgEPaJ8YwVAzeT4NPgihWN
         2kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t8E8HmlL/BHH9EyBKDMPQRltWFEhVkkZZ5XBcH9v72M=;
        b=GZwSmOeExC51FyIoDORC0KFPNyxeljtbs08obzn85JHvwk1UxvYtWo/PVQBaoCOTsz
         TKA+qHEFXKNv4fXbK20ZM32NwdQhQeLp7JwlSnr3XQxsSmO9Y+n0VwZ4iurZbvJOI5es
         uMZsHmjRqOeDcWdgwm+rsp/EN4XROu1cIYLCpUbWOhdtiaacwFC4Je6H1iJidPh9oLy0
         u512/sZAryLiOGP27cJVjsUiQ1JnYg+CIFQpSIRMNRqo8Ryv5+FfildGZAffY1BnWklO
         3dkycd4PQ/pWtkJkLAnSc1ryDZrQrYB4pXBtjR+nvYIfCZOpHv7LEZqQmHudhRUPkZg/
         Cu4w==
X-Gm-Message-State: AOAM532HoTV6OtyB9hrlq6y/y8LiZOvL223DPYcCxDbpw0ew8sR3KQzD
        vmnyg2cLqu7zPA+OXizNwHNsdu/ZiWU6Lw==
X-Google-Smtp-Source: ABdhPJyPjHpGQUOlQg3BExgFVDGjhzFfQzdkqq5VnW8Ij1KmQGTKum9Ap0ViFv8xVtZ4PExgbbgCBQ==
X-Received: by 2002:a92:4142:: with SMTP id o63mr242951ila.138.1602599978635;
        Tue, 13 Oct 2020 07:39:38 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1096? ([2620:10d:c091:480::1:d057])
        by smtp.gmail.com with ESMTPSA id m2sm54104ion.44.2020.10.13.07.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 07:39:36 -0700 (PDT)
Subject: Re: [PATCH 2/4] btrfs: fix readahead hang and use-after-free after
 removing a device
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1602499587.git.fdmanana@suse.com>
 <c81e38d12592d32432aa13c2221c0dd95df4d2c4.1602499588.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e8519d5e-209d-dd91-730c-5d072d9481fd@toxicpanda.com>
Date:   Tue, 13 Oct 2020 10:39:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c81e38d12592d32432aa13c2221c0dd95df4d2c4.1602499588.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/12/20 6:55 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Very sporadically I had test case btrfs/069 from fstests hanging (for
> years, it is not a recent regression), with the following traces in
> dmesg/syslog:
> 
> [162301.160628] BTRFS info (device sdc): dev_replace from /dev/sdd (devid 2) to /dev/sdg started
> [162301.181196] BTRFS info (device sdc): scrub: finished on devid 4 with status: 0
> [162301.287162] BTRFS info (device sdc): dev_replace from /dev/sdd (devid 2) to /dev/sdg finished
> [162513.513792] INFO: task btrfs-transacti:1356167 blocked for more than 120 seconds.
> [162513.514318]       Not tainted 5.9.0-rc6-btrfs-next-69 #1
> [162513.514522] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [162513.514747] task:btrfs-transacti state:D stack:    0 pid:1356167 ppid:     2 flags:0x00004000
> [162513.514751] Call Trace:
> [162513.514761]  __schedule+0x5ce/0xd00
> [162513.514765]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [162513.514771]  schedule+0x46/0xf0
> [162513.514844]  wait_current_trans+0xde/0x140 [btrfs]
> [162513.514850]  ? finish_wait+0x90/0x90
> [162513.514864]  start_transaction+0x37c/0x5f0 [btrfs]
> [162513.514879]  transaction_kthread+0xa4/0x170 [btrfs]
> [162513.514891]  ? btrfs_cleanup_transaction+0x660/0x660 [btrfs]
> [162513.514894]  kthread+0x153/0x170
> [162513.514897]  ? kthread_stop+0x2c0/0x2c0
> [162513.514902]  ret_from_fork+0x22/0x30
> [162513.514916] INFO: task fsstress:1356184 blocked for more than 120 seconds.
> [162513.515192]       Not tainted 5.9.0-rc6-btrfs-next-69 #1
> [162513.515431] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [162513.515680] task:fsstress        state:D stack:    0 pid:1356184 ppid:1356177 flags:0x00004000
> [162513.515682] Call Trace:
> [162513.515688]  __schedule+0x5ce/0xd00
> [162513.515691]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [162513.515697]  schedule+0x46/0xf0
> [162513.515712]  wait_current_trans+0xde/0x140 [btrfs]
> [162513.515716]  ? finish_wait+0x90/0x90
> [162513.515729]  start_transaction+0x37c/0x5f0 [btrfs]
> [162513.515743]  btrfs_attach_transaction_barrier+0x1f/0x50 [btrfs]
> [162513.515753]  btrfs_sync_fs+0x61/0x1c0 [btrfs]
> [162513.515758]  ? __ia32_sys_fdatasync+0x20/0x20
> [162513.515761]  iterate_supers+0x87/0xf0
> [162513.515765]  ksys_sync+0x60/0xb0
> [162513.515768]  __do_sys_sync+0xa/0x10
> [162513.515771]  do_syscall_64+0x33/0x80
> [162513.515774]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [162513.515781] RIP: 0033:0x7f5238f50bd7
> [162513.515782] Code: Bad RIP value.
> [162513.515784] RSP: 002b:00007fff67b978e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
> [162513.515786] RAX: ffffffffffffffda RBX: 000055b1fad2c560 RCX: 00007f5238f50bd7
> [162513.515788] RDX: 00000000ffffffff RSI: 000000000daf0e74 RDI: 000000000000003a
> [162513.515789] RBP: 0000000000000032 R08: 000000000000000a R09: 00007f5239019be0
> [162513.515791] R10: fffffffffffff24f R11: 0000000000000206 R12: 000000000000003a
> [162513.515792] R13: 00007fff67b97950 R14: 00007fff67b97906 R15: 000055b1fad1a340
> [162513.515804] INFO: task fsstress:1356185 blocked for more than 120 seconds.
> [162513.516064]       Not tainted 5.9.0-rc6-btrfs-next-69 #1
> [162513.516329] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [162513.516617] task:fsstress        state:D stack:    0 pid:1356185 ppid:1356177 flags:0x00000000
> [162513.516620] Call Trace:
> [162513.516625]  __schedule+0x5ce/0xd00
> [162513.516628]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [162513.516634]  schedule+0x46/0xf0
> [162513.516647]  wait_current_trans+0xde/0x140 [btrfs]
> [162513.516650]  ? finish_wait+0x90/0x90
> [162513.516662]  start_transaction+0x4d7/0x5f0 [btrfs]
> [162513.516679]  btrfs_setxattr_trans+0x3c/0x100 [btrfs]
> [162513.516686]  __vfs_setxattr+0x66/0x80
> [162513.516691]  __vfs_setxattr_noperm+0x70/0x200
> [162513.516697]  vfs_setxattr+0x6b/0x120
> [162513.516703]  setxattr+0x125/0x240
> [162513.516709]  ? lock_acquire+0xb1/0x480
> [162513.516712]  ? mnt_want_write+0x20/0x50
> [162513.516721]  ? rcu_read_lock_any_held+0x8e/0xb0
> [162513.516723]  ? preempt_count_add+0x49/0xa0
> [162513.516725]  ? __sb_start_write+0x19b/0x290
> [162513.516727]  ? preempt_count_add+0x49/0xa0
> [162513.516732]  path_setxattr+0xba/0xd0
> [162513.516739]  __x64_sys_setxattr+0x27/0x30
> [162513.516741]  do_syscall_64+0x33/0x80
> [162513.516743]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [162513.516745] RIP: 0033:0x7f5238f56d5a
> [162513.516746] Code: Bad RIP value.
> [162513.516748] RSP: 002b:00007fff67b97868 EFLAGS: 00000202 ORIG_RAX: 00000000000000bc
> [162513.516750] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5238f56d5a
> [162513.516751] RDX: 000055b1fbb0d5a0 RSI: 00007fff67b978a0 RDI: 000055b1fbb0d470
> [162513.516753] RBP: 000055b1fbb0d5a0 R08: 0000000000000001 R09: 00007fff67b97700
> [162513.516754] R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000004
> [162513.516756] R13: 0000000000000024 R14: 0000000000000001 R15: 00007fff67b978a0
> [162513.516767] INFO: task fsstress:1356196 blocked for more than 120 seconds.
> [162513.517064]       Not tainted 5.9.0-rc6-btrfs-next-69 #1
> [162513.517365] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [162513.517763] task:fsstress        state:D stack:    0 pid:1356196 ppid:1356177 flags:0x00004000
> [162513.517780] Call Trace:
> [162513.517786]  __schedule+0x5ce/0xd00
> [162513.517789]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [162513.517796]  schedule+0x46/0xf0
> [162513.517810]  wait_current_trans+0xde/0x140 [btrfs]
> [162513.517814]  ? finish_wait+0x90/0x90
> [162513.517829]  start_transaction+0x37c/0x5f0 [btrfs]
> [162513.517845]  btrfs_attach_transaction_barrier+0x1f/0x50 [btrfs]
> [162513.517857]  btrfs_sync_fs+0x61/0x1c0 [btrfs]
> [162513.517862]  ? __ia32_sys_fdatasync+0x20/0x20
> [162513.517865]  iterate_supers+0x87/0xf0
> [162513.517869]  ksys_sync+0x60/0xb0
> [162513.517872]  __do_sys_sync+0xa/0x10
> [162513.517875]  do_syscall_64+0x33/0x80
> [162513.517878]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [162513.517881] RIP: 0033:0x7f5238f50bd7
> [162513.517883] Code: Bad RIP value.
> [162513.517885] RSP: 002b:00007fff67b978e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
> [162513.517887] RAX: ffffffffffffffda RBX: 000055b1fad2c560 RCX: 00007f5238f50bd7
> [162513.517889] RDX: 0000000000000000 RSI: 000000007660add2 RDI: 0000000000000053
> [162513.517891] RBP: 0000000000000032 R08: 0000000000000067 R09: 00007f5239019be0
> [162513.517893] R10: fffffffffffff24f R11: 0000000000000206 R12: 0000000000000053
> [162513.517895] R13: 00007fff67b97950 R14: 00007fff67b97906 R15: 000055b1fad1a340
> [162513.517908] INFO: task fsstress:1356197 blocked for more than 120 seconds.
> [162513.518298]       Not tainted 5.9.0-rc6-btrfs-next-69 #1
> [162513.518672] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [162513.519157] task:fsstress        state:D stack:    0 pid:1356197 ppid:1356177 flags:0x00000000
> [162513.519160] Call Trace:
> [162513.519165]  __schedule+0x5ce/0xd00
> [162513.519168]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [162513.519174]  schedule+0x46/0xf0
> [162513.519190]  wait_current_trans+0xde/0x140 [btrfs]
> [162513.519193]  ? finish_wait+0x90/0x90
> [162513.519206]  start_transaction+0x4d7/0x5f0 [btrfs]
> [162513.519222]  btrfs_create+0x57/0x200 [btrfs]
> [162513.519230]  lookup_open+0x522/0x650
> [162513.519246]  path_openat+0x2b8/0xa50
> [162513.519270]  do_filp_open+0x91/0x100
> [162513.519275]  ? find_held_lock+0x32/0x90
> [162513.519280]  ? lock_acquired+0x33b/0x470
> [162513.519285]  ? do_raw_spin_unlock+0x4b/0xc0
> [162513.519287]  ? _raw_spin_unlock+0x29/0x40
> [162513.519295]  do_sys_openat2+0x20d/0x2d0
> [162513.519300]  do_sys_open+0x44/0x80
> [162513.519304]  do_syscall_64+0x33/0x80
> [162513.519307]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [162513.519309] RIP: 0033:0x7f5238f4a903
> [162513.519310] Code: Bad RIP value.
> [162513.519312] RSP: 002b:00007fff67b97758 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> [162513.519314] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f5238f4a903
> [162513.519316] RDX: 0000000000000000 RSI: 00000000000001b6 RDI: 000055b1fbb0d470
> [162513.519317] RBP: 00007fff67b978c0 R08: 0000000000000001 R09: 0000000000000002
> [162513.519319] R10: 00007fff67b974f7 R11: 0000000000000246 R12: 0000000000000013
> [162513.519320] R13: 00000000000001b6 R14: 00007fff67b97906 R15: 000055b1fad1c620
> [162513.519332] INFO: task btrfs:1356211 blocked for more than 120 seconds.
> [162513.519727]       Not tainted 5.9.0-rc6-btrfs-next-69 #1
> [162513.520115] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [162513.520508] task:btrfs           state:D stack:    0 pid:1356211 ppid:1356178 flags:0x00004002
> [162513.520511] Call Trace:
> [162513.520516]  __schedule+0x5ce/0xd00
> [162513.520519]  ? _raw_spin_unlock_irqrestore+0x3c/0x60
> [162513.520525]  schedule+0x46/0xf0
> [162513.520544]  btrfs_scrub_pause+0x11f/0x180 [btrfs]
> [162513.520548]  ? finish_wait+0x90/0x90
> [162513.520562]  btrfs_commit_transaction+0x45a/0xc30 [btrfs]
> [162513.520574]  ? start_transaction+0xe0/0x5f0 [btrfs]
> [162513.520596]  btrfs_dev_replace_finishing+0x6d8/0x711 [btrfs]
> [162513.520619]  btrfs_dev_replace_by_ioctl.cold+0x1cc/0x1fd [btrfs]
> [162513.520639]  btrfs_ioctl+0x2a25/0x36f0 [btrfs]
> [162513.520643]  ? do_sigaction+0xf3/0x240
> [162513.520645]  ? find_held_lock+0x32/0x90
> [162513.520648]  ? do_sigaction+0xf3/0x240
> [162513.520651]  ? lock_acquired+0x33b/0x470
> [162513.520655]  ? _raw_spin_unlock_irq+0x24/0x50
> [162513.520657]  ? lockdep_hardirqs_on+0x7d/0x100
> [162513.520660]  ? _raw_spin_unlock_irq+0x35/0x50
> [162513.520662]  ? do_sigaction+0xf3/0x240
> [162513.520671]  ? __x64_sys_ioctl+0x83/0xb0
> [162513.520672]  __x64_sys_ioctl+0x83/0xb0
> [162513.520677]  do_syscall_64+0x33/0x80
> [162513.520679]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [162513.520681] RIP: 0033:0x7fc3cd307d87
> [162513.520682] Code: Bad RIP value.
> [162513.520684] RSP: 002b:00007ffe30a56bb8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [162513.520686] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc3cd307d87
> [162513.520687] RDX: 00007ffe30a57a30 RSI: 00000000ca289435 RDI: 0000000000000003
> [162513.520689] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [162513.520690] R10: 0000000000000008 R11: 0000000000000202 R12: 0000000000000003
> [162513.520692] R13: 0000557323a212e0 R14: 00007ffe30a5a520 R15: 0000000000000001
> [162513.520703]
>                  Showing all locks held in the system:
> [162513.520712] 1 lock held by khungtaskd/54:
> [162513.520713]  #0: ffffffffb40a91a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x197
> [162513.520728] 1 lock held by in:imklog/596:
> [162513.520729]  #0: ffff8f3f0d781400 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/0x60
> [162513.520782] 1 lock held by btrfs-transacti/1356167:
> [162513.520784]  #0: ffff8f3d810cc848 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: transaction_kthread+0x4a/0x170 [btrfs]
> [162513.520798] 1 lock held by btrfs/1356190:
> [162513.520800]  #0: ffff8f3d57644470 (sb_writers#15){.+.+}-{0:0}, at: mnt_want_write_file+0x22/0x60
> [162513.520805] 1 lock held by fsstress/1356184:
> [162513.520806]  #0: ffff8f3d576440e8 (&type->s_umount_key#62){++++}-{3:3}, at: iterate_supers+0x6f/0xf0
> [162513.520811] 3 locks held by fsstress/1356185:
> [162513.520812]  #0: ffff8f3d57644470 (sb_writers#15){.+.+}-{0:0}, at: mnt_want_write+0x20/0x50
> [162513.520815]  #1: ffff8f3d80a650b8 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: vfs_setxattr+0x50/0x120
> [162513.520820]  #2: ffff8f3d57644690 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x40e/0x5f0 [btrfs]
> [162513.520833] 1 lock held by fsstress/1356196:
> [162513.520834]  #0: ffff8f3d576440e8 (&type->s_umount_key#62){++++}-{3:3}, at: iterate_supers+0x6f/0xf0
> [162513.520838] 3 locks held by fsstress/1356197:
> [162513.520839]  #0: ffff8f3d57644470 (sb_writers#15){.+.+}-{0:0}, at: mnt_want_write+0x20/0x50
> [162513.520843]  #1: ffff8f3d506465e8 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: path_openat+0x2a7/0xa50
> [162513.520846]  #2: ffff8f3d57644690 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x40e/0x5f0 [btrfs]
> [162513.520858] 2 locks held by btrfs/1356211:
> [162513.520859]  #0: ffff8f3d810cde30 (&fs_info->dev_replace.lock_finishing_cancel_unmount){+.+.}-{3:3}, at: btrfs_dev_replace_finishing+0x52/0x711 [btrfs]
> [162513.520877]  #1: ffff8f3d57644690 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x40e/0x5f0 [btrfs]
> 
> This was weird because the stack traces show that a transaction commit,
> triggered by a device replace operation, is blocking trying to pause any
> running scrubs but there are no stack traces of blocked tasks doing a
> scrub.
> 
> After poking around with drgn, I noticed there was a scrub task that was
> constantly running and blocking for shorts periods of time:
> 
>    >>> t = find_task(prog, 1356190)
>    >>> prog.stack_trace(t)
>    #0  __schedule+0x5ce/0xcfc
>    #1  schedule+0x46/0xe4
>    #2  schedule_timeout+0x1df/0x475
>    #3  btrfs_reada_wait+0xda/0x132
>    #4  scrub_stripe+0x2a8/0x112f
>    #5  scrub_chunk+0xcd/0x134
>    #6  scrub_enumerate_chunks+0x29e/0x5ee
>    #7  btrfs_scrub_dev+0x2d5/0x91b
>    #8  btrfs_ioctl+0x7f5/0x36e7
>    #9  __x64_sys_ioctl+0x83/0xb0
>    #10 do_syscall_64+0x33/0x77
>    #11 entry_SYSCALL_64+0x7c/0x156
> 
> Which corresponds to:
> 
> int btrfs_reada_wait(void *handle)
> {
>      struct reada_control *rc = handle;
>      struct btrfs_fs_info *fs_info = rc->fs_info;
> 
>      while (atomic_read(&rc->elems)) {
>          if (!atomic_read(&fs_info->reada_works_cnt))
>              reada_start_machine(fs_info);
>          wait_event_timeout(rc->wait, atomic_read(&rc->elems) == 0,
>                            (HZ + 9) / 10);
>      }
> (...)
> 
> So the counter "rc->elems" was set to 1 and never decreased to 0, causing
> the scrub task to loop forever in that function. Then I used the following
> script for drgn to check the readahead requests:
> 
>    $ cat dump_reada.py
>    import sys
>    import drgn
>    from drgn import NULL, Object, cast, container_of, execscript, \
>        reinterpret, sizeof
>    from drgn.helpers.linux import *
> 
>    mnt_path = b"/home/fdmanana/btrfs-tests/scratch_1"
> 
>    mnt = None
>    for mnt in for_each_mount(prog, dst = mnt_path):
>        pass
> 
>    if mnt is None:
>        sys.stderr.write(f'Error: mount point {mnt_path} not found\n')
>        sys.exit(1)
> 
>    fs_info = cast('struct btrfs_fs_info *', mnt.mnt.mnt_sb.s_fs_info)
> 
>    def dump_re(re):
>        nzones = re.nzones.value_()
>        print(f're at {hex(re.value_())}')
>        print(f'\t logical {re.logical.value_()}')
>        print(f'\t refcnt {re.refcnt.value_()}')
>        print(f'\t nzones {nzones}')
>        for i in range(nzones):
>            dev = re.zones[i].device
>            name = dev.name.str.string_()
>            print(f'\t\t dev id {dev.devid.value_()} name {name}')
>        print()
> 
>    for _, e in radix_tree_for_each(fs_info.reada_tree):
>        re = cast('struct reada_extent *', e)
>        dump_re(re)
> 
>    $ drgn dump_reada.py
>    re at 0xffff8f3da9d25ad8
>            logical 38928384
>            refcnt 1
>            nzones 1
>                   dev id 0 name b'/dev/sdd'
>    $
> 
> So there was one readahead extent with a single zone corresponding to the
> source device of that last device replace operation logged in dmesg/syslog.
> Also the ID of that zone's device was 0 which is a special value set in
> the source device of a device replace operation when the operation finishes
> (constant BTRFS_DEV_REPLACE_DEVID set at btrfs_dev_replace_finishing()),
> confirming again that device /dev/sdd was the source of a device replace
> operation.
> 
> Normally there should be as many zones in the readahead extent as there are
> devices, and I wasn't expecting the extent to be in a block group with a
> 'single' profile, so I went and confirmed with the following drgn script
> that there weren't any single profile block groups:
> 
>    $ cat dump_block_groups.py
>    import sys
>    import drgn
>    from drgn import NULL, Object, cast, container_of, execscript, \
>        reinterpret, sizeof
>    from drgn.helpers.linux import *
> 
>    mnt_path = b"/home/fdmanana/btrfs-tests/scratch_1"
> 
>    mnt = None
>    for mnt in for_each_mount(prog, dst = mnt_path):
>        pass
> 
>    if mnt is None:
>        sys.stderr.write(f'Error: mount point {mnt_path} not found\n')
>        sys.exit(1)
> 
>    fs_info = cast('struct btrfs_fs_info *', mnt.mnt.mnt_sb.s_fs_info)
> 
>    BTRFS_BLOCK_GROUP_DATA = (1 << 0)
>    BTRFS_BLOCK_GROUP_SYSTEM = (1 << 1)
>    BTRFS_BLOCK_GROUP_METADATA = (1 << 2)
>    BTRFS_BLOCK_GROUP_RAID0 = (1 << 3)
>    BTRFS_BLOCK_GROUP_RAID1 = (1 << 4)
>    BTRFS_BLOCK_GROUP_DUP = (1 << 5)
>    BTRFS_BLOCK_GROUP_RAID10 = (1 << 6)
>    BTRFS_BLOCK_GROUP_RAID5 = (1 << 7)
>    BTRFS_BLOCK_GROUP_RAID6 = (1 << 8)
>    BTRFS_BLOCK_GROUP_RAID1C3 = (1 << 9)
>    BTRFS_BLOCK_GROUP_RAID1C4 = (1 << 10)
> 
>    def bg_flags_string(bg):
>        flags = bg.flags.value_()
>        ret = ''
>        if flags & BTRFS_BLOCK_GROUP_DATA:
>            ret = 'data'
>        if flags & BTRFS_BLOCK_GROUP_METADATA:
>            if len(ret) > 0:
>                ret += '|'
>            ret += 'meta'
>        if flags & BTRFS_BLOCK_GROUP_SYSTEM:
>            if len(ret) > 0:
>                ret += '|'
>            ret += 'system'
>        if flags & BTRFS_BLOCK_GROUP_RAID0:
>            ret += ' raid0'
>        elif flags & BTRFS_BLOCK_GROUP_RAID1:
>            ret += ' raid1'
>        elif flags & BTRFS_BLOCK_GROUP_DUP:
>            ret += ' dup'
>        elif flags & BTRFS_BLOCK_GROUP_RAID10:
>            ret += ' raid10'
>        elif flags & BTRFS_BLOCK_GROUP_RAID5:
>            ret += ' raid5'
>        elif flags & BTRFS_BLOCK_GROUP_RAID6:
>            ret += ' raid6'
>        elif flags & BTRFS_BLOCK_GROUP_RAID1C3:
>            ret += ' raid1c3'
>        elif flags & BTRFS_BLOCK_GROUP_RAID1C4:
>            ret += ' raid1c4'
>        else:
>            ret += ' single'
> 
>        return ret
> 
>    def dump_bg(bg):
>        print()
>        print(f'block group at {hex(bg.value_())}')
>        print(f'\t start {bg.start.value_()} length {bg.length.value_()}')
>        print(f'\t flags {bg.flags.value_()} - {bg_flags_string(bg)}')
> 
>    bg_root = fs_info.block_group_cache_tree.address_of_()
>    for bg in rbtree_inorder_for_each_entry('struct btrfs_block_group', bg_root, 'cache_node'):
>        dump_bg(bg)
> 
>    $ drgn dump_block_groups.py
> 
>    block group at 0xffff8f3d673b0400
>           start 22020096 length 16777216
>           flags 258 - system raid6
> 
>    block group at 0xffff8f3d53ddb400
>           start 38797312 length 536870912
>           flags 260 - meta raid6
> 
>    block group at 0xffff8f3d5f4d9c00
>           start 575668224 length 2147483648
>           flags 257 - data raid6
> 
>    block group at 0xffff8f3d08189000
>           start 2723151872 length 67108864
>           flags 258 - system raid6
> 
>    block group at 0xffff8f3db70ff000
>           start 2790260736 length 1073741824
>           flags 260 - meta raid6
> 
>    block group at 0xffff8f3d5f4dd800
>           start 3864002560 length 67108864
>           flags 258 - system raid6
> 
>    block group at 0xffff8f3d67037000
>           start 3931111424 length 2147483648
>           flags 257 - data raid6
>    $
> 
> So there were only 2 reasons left for having a readahead extent with a
> single zone: reada_find_zone(), called when creating a readahead extent,
> returned NULL either because we failed to find the corresponding block
> group or because a memory allocation failed. With some additional and
> custom tracing I figured out that on every further ocurrence of the
> problem the block group had just been deleted when we were looping to
> create the zones for the readahead extent (at reada_find_extent()), so we
> ended up with only one zone in the readahead extent, corresponding to a
> device that ends up getting replaced.
> 
> So after figuring that out it became obvious why the hang happens:
> 
> 1) Task A starts a scrub on any device of the filesystem, except for
>     device /dev/sdd;
> 
> 2) Task B starts a device replace with /dev/sdd as the source device;
> 
> 3) Task A calls btrfs_reada_add() from scrub_stripe() and it is currently
>     starting to scrub a stripe from block group X. This call to
>     btrfs_reada_add() is the one for the extent tree. When btrfs_reada_add()
>     calls reada_add_block(), it passes the logical address of the extent
>     tree's root node as its 'logical' argument - a value of 38928384;
> 
> 4) Task A then enters reada_find_extent(), called from reada_add_block().
>     It finds there isn't any existing readahead extent for the logical
>     address 38928384, so it proceeds to the path of creating a new one.
> 
>     It calls btrfs_map_block() to find out which stripes exist for the block
>     group X. On the first iteration of the for loop that iterates over the
>     stripes, it finds the stripe for device /dev/sdd, so it creates one
>     zone for that device and adds it to the readahead extent. Before getting
>     into the second iteration of the loop, the cleanup kthread deletes block
>     group X because it was empty. So in the iterations for the remaining
>     stripes it does not add more zones to the readahead extent, because the
>     calls to reada_find_zone() returned NULL because they couldn't find
>     block group X anymore.
> 
>     As a result the new readahead extent has a single zone, corresponding to
>     the device /dev/sdd;
> 
> 4) Before task A returns to btrfs_reada_add() and queues the readahead job
>     for the readahead work queue, task B finishes the device replace and at
>     btrfs_dev_replace_finishing() swaps the device /dev/sdd with the new
>     device /dev/sdg;
> 
> 5) Task A returns to reada_add_block(), which increments the counter
>     "->elems" of the reada_control structure allocated at btrfs_reada_add().
> 
>     Then it returns back to btrfs_reada_add() and calls
>     reada_start_machine(). This queues a job in the readahead work queue to
>     run the function reada_start_machine_worker(), which calls
>     __reada_start_machine().
> 
>     At __reada_start_machine() we take the device list mutex and for each
>     device found in the current device list, we call
>     reada_start_machine_dev() to start the readahead work. However at this
>     point the device /dev/sdd was already freed and is not in the device
>     list anymore.
> 
>     This means the corresponding readahead for the extent at 38928384 is
>     never started, and therefore the "->elems" counter of the reada_control
>     structure allocated at btrfs_reada_add() never goes down to 0, causing
>     the call to btrfs_reada_wait(), done by the scrub task, to wait forever.
> 
> Note that the readahead request can be made either after the device replace
> started or before it started, however in pratice it is very unlikely that a
> device replace is able to start after a readahead request is made and is
> able to complete before the readahead request completes - maybe only on a
> very small and nearly empty filesystem.
> 
> This hang however is not the only problem we can have with readahead and
> device removals. When the readahead extent has other zones other than the
> one corresponding to the device that is being removed (either by a device
> replace or a device remove operation), we risk having a use-after-free on
> the device when dropping the last reference of the readahead extent.
> 
> For example if we create a readahead extent with two zones, one for the
> device /dev/sdd and one for the device /dev/sde:
> 
> 1) Before the readahead worker starts, the device /dev/sdd is removed,
>     and the corresponding btrfs_device structure is freed. However the
>     readahead extent still has the zone pointing to the device structure;
> 
> 2) When the readahead worker starts, it only finds device /dev/sde in the
>     current device list of the filesystem;
> 
> 3) It starts the readahead work, at reada_start_machine_dev(), using the
>     device /dev/sde;
> 
> 4) Then when it finishes reading the extent from device /dev/sde, it calls
>     __readahead_hook() which ends up dropping the last reference on the
>     readahead extent through the last call to reada_extent_put();
> 
> 5) At reada_extent_put() it iterates over each zone of the readahead extent
>     and attempts to delete an element from the device's 'reada_extents'
>     radix tree, resulting in a use-after-free, as the device pointer of the
>     zone for /dev/sdd is now stale. We can also access the device after
>     dropping the last reference of a zone, through reada_zone_release(),
>     also called by reada_extent_put().
> 
> And a device remove suffers the same problem, however since it shrinks the
> device size down to zero before removing the device, it is very unlikely to
> still have readahead requests not completed by the time we free the device,
> the only possibility is if the device has a very little space allocated.
> 
> While the hang problem is exclusive to scrub, since it is currently the
> only user of btrfs_reada_add() and btrfs_reada_wait(), the use-after-free
> problem affects any path that triggers readhead, which includes
> btree_readahead_hook() and __readahead_hook() (a readahead worker can
> trigger readahed for the children of a node) for example - any path that
> ends up calling reada_add_block() can trigger the use-after-free after a
> device is removed.
> 
> So fix this by waiting for any readahead requests for a device to complete
> before removing a device, ensuring that while waiting for existing ones no
> new ones can be made.
> 
> This problem has been around for a very long time - the readahead code was
> added in 2011, device remove exists since 2008 and device replace was
> introduced in 2013, hard to pick a specific commit for a git Fixes tag.
> 
> CC: stable@vger.kernel.org # 4.4+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Love the use of drgn!

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
