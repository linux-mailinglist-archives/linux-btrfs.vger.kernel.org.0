Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889441A79A
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2019 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfEKKvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 May 2019 06:51:00 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43319 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfEKKvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 May 2019 06:51:00 -0400
Received: by mail-wr1-f44.google.com with SMTP id r4so10310805wro.10
        for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2019 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3U/pkGYCjdRcVmd1CC+MPf0JfkszzAoYSq5IUJjnekw=;
        b=B5o9WZPWvz5a31qHpWWOlWRufEh8RUOfoavgy76VFz9dnMDLAzG3hRj3lVOxAfDs9A
         NEo0/ysRBlZM0O7KPjiN5CNnBxf3NiXvvsadvfbEM93tMspgV2pfP66SNsFGYBv4z7yU
         I9TQELS+AteZjibacRxk7A7pmLPAukGPTFQey1AvmXO08+jeebevD+3TXQOB0KgZnjo8
         2AHSMYgcoHKUtJzxM7LclkClMmVufhYOTp2s7MM0NFr0h6twSpSzqyrs41MDYJd1xKHM
         kaJSvc9B49V8y8x5Q6PZCliNZ66n1NWhEu9vkq0PVnMBNZMa9ZJlaGc1K2AisUIingnt
         cQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3U/pkGYCjdRcVmd1CC+MPf0JfkszzAoYSq5IUJjnekw=;
        b=ddXhT+rAmsHwMCRrye8GnhbPCzICzG2mBDZiuX2EKeuvMQuqjS9I2/UxmBhujiXmYd
         YfBlT8ZMaVeFFKGoNVUZU/oYUk+EZvB67AvdW378uubiTntz/xNHOI7BDFBt2E6KxuJg
         HVGRvXyklc7PTUxBu6L65QzXIrWLrv5zKsavfM3NImsYlktb+tWPeJFZkbZfweLm09q1
         rzyxYnJc+HChdaCzrsxYEey8VbUW9jteUBXCxlN+kaOKoLnRpdAMoZLnOoghc45QFTp+
         Zd0whM4Cm2oir+FRtceTNkwJ/9EJg2EOBPyhj/Ob3gTXKIdmGpXFxelSpHyq2ovNJQyO
         6BMg==
X-Gm-Message-State: APjAAAXfmDsOqUOR8Rfr4mGPJ2VLFnOjcv7ggFZwlog4TM6MTBMO9AU8
        D+qMYeOqCr5ZzfJjGrXSpTbqVKGlNI70kVtgG5zOX0F/
X-Google-Smtp-Source: APXvYqyxeqTRMn+QkVtPzh/bSZv4FkVbBG51Yjx361jUCq1yswbyzxknW9SmBTCZu+fpmRazj78hdfpBVnlrO5d+UOc=
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr10758160wrk.293.1557571852664;
 Sat, 11 May 2019 03:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEsQD1WgqZBZ2YEsEZKKH6X6PSxZGKbMgSVrzkEjVVDFrg@mail.gmail.com>
 <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
In-Reply-To: <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Sat, 11 May 2019 05:50:41 -0500
Message-ID: <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
Subject: Re: reading/writing btrfs volume regularly freezes system
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It happened again, and I managed to get a backtrace.

[362108.290770]  ? _raw_spin_unlock+0x12/0x23
[362108.290776]  ? nlmsvc_retry_blocked+0x1d3/0x1e3 [lockd]
[362108.290782]  ? grace_ender+0xe/0xe [lockd]
[362108.290787]  lockd+0xcd/0x129 [lockd]
[362108.290794]  kthread+0x115/0x11d
[362108.290798]  ? kthread_park+0x76/0x76
[362108.290801]  ret_from_fork+0x35/0x40
[362108.290806] nfsd            S    0  2307      2 0x80000000
[362108.290809] Call Trace:
[362108.290813]  ? __schedule+0x59d/0x5f1
[362108.290816]  ? preempt_count_add+0x8a/0x9c
[362108.290820]  schedule+0x6a/0x85
[362108.290825]  schedule_timeout+0x2f7/0x33c
[362108.290829]  ? collect_expired_timers+0x97/0x97
[362108.290842]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.290855]  svc_recv+0x291/0x7da [sunrpc]
[362108.290860]  ? __mutex_unlock_slowpath.isra.6+0x1e8/0x20a
[362108.290871]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.290881]  nfsd+0xe7/0x150 [nfsd]
[362108.290887]  kthread+0x115/0x11d
[362108.290891]  ? kthread_park+0x76/0x76
[362108.290895]  ret_from_fork+0x35/0x40
[362108.290898] nfsd            D    0  2308      2 0x80000000
[362108.290901] Call Trace:
[362108.290906]  ? __schedule+0x59d/0x5f1
[362108.290910]  schedule+0x6a/0x85
[362108.290916]  btrfs_tree_read_lock+0xbb/0xf1
[362108.290921]  ? wait_woken+0x6d/0x6d
[362108.290924]  btrfs_read_lock_root_node+0x1d/0x3b
[362108.290928]  btrfs_search_slot+0x181/0x812
[362108.290934]  ? crc32c+0x66/0x90
[362108.290938]  btrfs_lookup_dir_item+0x7c/0xc4
[362108.290942]  btrfs_lookup_dentry+0xae/0x443
[362108.290946]  ? preempt_count_add+0x7d/0x9c
[362108.290950]  ? d_alloc_parallel+0x44b/0x4a3
[362108.290955]  ? btrfs_getattr+0xaa/0xdf
[362108.290958]  btrfs_lookup+0xe/0x2c
[362108.290963]  __lookup_slow+0xec/0x148
[362108.290967]  lookup_one_len+0x61/0x7c
[362108.290978]  nfsd_lookup_dentry+0x226/0x31e [nfsd]
[362108.290993]  ? write_bytes_to_xdr_buf+0x39/0xc5 [sunrpc]
[362108.291005]  nfsd_lookup+0x62/0x123 [nfsd]
[362108.291020]  ? nfsd4_encode_operation+0xf0/0x18e [nfsd]
[362108.291033]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
[362108.291045]  nfsd_dispatch+0xb9/0x16e [nfsd]
[362108.291060]  svc_process+0x524/0x6e2 [sunrpc]
[362108.291067]  ? __mutex_unlock_slowpath.isra.6+0x1e8/0x20a
[362108.291078]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.291087]  nfsd+0xf9/0x150 [nfsd]
[362108.291093]  kthread+0x115/0x11d
[362108.291097]  ? kthread_park+0x76/0x76
[362108.291100]  ret_from_fork+0x35/0x40
[362108.291104] nfsd            D    0  2309      2 0x80000000
[362108.291107] Call Trace:
[362108.291112]  ? __schedule+0x59d/0x5f1
[362108.291117]  schedule+0x6a/0x85
[362108.291121]  btrfs_tree_read_lock+0xbb/0xf1
[362108.291126]  ? wait_woken+0x6d/0x6d
[362108.291129]  btrfs_read_lock_root_node+0x1d/0x3b
[362108.291133]  btrfs_search_slot+0x181/0x812
[362108.291137]  ? crc32c+0x66/0x90
[362108.291140]  btrfs_lookup_dir_item+0x7c/0xc4
[362108.291144]  btrfs_lookup_dentry+0xae/0x443
[362108.291148]  ? preempt_count_add+0x7d/0x9c
[362108.291152]  ? d_alloc_parallel+0x44b/0x4a3
[362108.291156]  ? btrfs_getattr+0xaa/0xdf
[362108.291159]  btrfs_lookup+0xe/0x2c
[362108.291171]  __lookup_slow+0xec/0x148
[362108.291175]  lookup_one_len+0x61/0x7c
[362108.291186]  nfsd_lookup_dentry+0x226/0x31e [nfsd]
[362108.291201]  ? write_bytes_to_xdr_buf+0x39/0xc5 [sunrpc]
[362108.291212]  nfsd_lookup+0x62/0x123 [nfsd]
[362108.291225]  ? nfsd4_encode_operation+0xf0/0x18e [nfsd]
[362108.291238]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
[362108.291250]  nfsd_dispatch+0xb9/0x16e [nfsd]
[362108.291265]  svc_process+0x524/0x6e2 [sunrpc]
[362108.291271]  ? __mutex_unlock_slowpath.isra.6+0x1e8/0x20a
[362108.291281]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.291291]  nfsd+0xf9/0x150 [nfsd]
[362108.291297]  kthread+0x115/0x11d
[362108.291301]  ? kthread_park+0x76/0x76
[362108.291304]  ret_from_fork+0x35/0x40
[362108.291308] nfsd            D    0  2310      2 0x80000000
[362108.291311] Call Trace:
[362108.291316]  ? __schedule+0x59d/0x5f1
[362108.291320]  schedule+0x6a/0x85
[362108.291325]  rwsem_down_write_failed+0x1af/0x210
[362108.291330]  call_rwsem_down_write_failed+0x13/0x20
[362108.291335]  down_write+0x20/0x2e
[362108.291346]  nfsd_lookup_dentry+0x209/0x31e [nfsd]
[362108.291360]  ? write_bytes_to_xdr_buf+0x39/0xc5 [sunrpc]
[362108.291371]  nfsd_lookup+0x62/0x123 [nfsd]
[362108.291385]  ? nfsd4_encode_operation+0xf0/0x18e [nfsd]
[362108.291397]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
[362108.291409]  nfsd_dispatch+0xb9/0x16e [nfsd]
[362108.291423]  svc_process+0x524/0x6e2 [sunrpc]
[362108.291428]  ? __mutex_unlock_slowpath.isra.6+0x1e8/0x20a
[362108.291439]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.291448]  nfsd+0xf9/0x150 [nfsd]
[362108.291454]  kthread+0x115/0x11d
[362108.291458]  ? kthread_park+0x76/0x76
[362108.291461]  ret_from_fork+0x35/0x40
[362108.291465] nfsd            D    0  2311      2 0x80000000
[362108.291468] Call Trace:
[362108.291473]  ? __schedule+0x59d/0x5f1
[362108.291477]  schedule+0x6a/0x85
[362108.291482]  rwsem_down_write_failed+0x1af/0x210
[362108.291487]  call_rwsem_down_write_failed+0x13/0x20
[362108.291492]  down_write+0x20/0x2e
[362108.291502]  nfsd_lookup_dentry+0x209/0x31e [nfsd]
[362108.291516]  ? write_bytes_to_xdr_buf+0x39/0xc5 [sunrpc]
[362108.291527]  nfsd_lookup+0x62/0x123 [nfsd]
[362108.291540]  ? nfsd4_encode_operation+0xf0/0x18e [nfsd]
[362108.291553]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
[362108.291564]  nfsd_dispatch+0xb9/0x16e [nfsd]
[362108.291578]  svc_process+0x524/0x6e2 [sunrpc]
[362108.291590]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.291599]  nfsd+0xf9/0x150 [nfsd]
[362108.291605]  kthread+0x115/0x11d
[362108.291609]  ? kthread_park+0x76/0x76
[362108.291612]  ret_from_fork+0x35/0x40
[362108.291616] nfsd            D    0  2312      2 0x80000000
[362108.291619] Call Trace:
[362108.291623]  ? __schedule+0x59d/0x5f1
[362108.291627]  schedule+0x6a/0x85
[362108.291632]  rwsem_down_write_failed+0x1af/0x210
[362108.291637]  call_rwsem_down_write_failed+0x13/0x20
[362108.291642]  down_write+0x20/0x2e
[362108.291652]  nfsd_lookup_dentry+0x209/0x31e [nfsd]
[362108.291666]  ? write_bytes_to_xdr_buf+0x39/0xc5 [sunrpc]
[362108.291677]  nfsd_lookup+0x62/0x123 [nfsd]
[362108.291690]  ? nfsd4_encode_operation+0xf0/0x18e [nfsd]
[362108.291702]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
[362108.291714]  nfsd_dispatch+0xb9/0x16e [nfsd]
[362108.291728]  svc_process+0x524/0x6e2 [sunrpc]
[362108.291739]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.291749]  nfsd+0xf9/0x150 [nfsd]
[362108.291755]  kthread+0x115/0x11d
[362108.291759]  ? kthread_park+0x76/0x76
[362108.291762]  ret_from_fork+0x35/0x40
[362108.291766] nfsd            D    0  2313      2 0x80000000
[362108.291769] Call Trace:
[362108.291773]  ? __schedule+0x59d/0x5f1
[362108.291777]  schedule+0x6a/0x85
[362108.291782]  btrfs_tree_read_lock+0xbb/0xf1
[362108.291787]  ? wait_woken+0x6d/0x6d
[362108.291790]  btrfs_read_lock_root_node+0x1d/0x3b
[362108.291794]  btrfs_search_slot+0x181/0x812
[362108.291798]  ? crc32c+0x66/0x90
[362108.291801]  btrfs_lookup_dir_item+0x7c/0xc4
[362108.291805]  btrfs_lookup_dentry+0xae/0x443
[362108.291808]  ? preempt_count_add+0x7d/0x9c
[362108.291813]  ? d_alloc_parallel+0x44b/0x4a3
[362108.291817]  ? btrfs_getattr+0xaa/0xdf
[362108.291820]  btrfs_lookup+0xe/0x2c
[362108.291825]  __lookup_slow+0xec/0x148
[362108.291829]  lookup_one_len+0x61/0x7c
[362108.291840]  nfsd_lookup_dentry+0x226/0x31e [nfsd]
[362108.291853]  ? write_bytes_to_xdr_buf+0x39/0xc5 [sunrpc]
[362108.291864]  nfsd_lookup+0x62/0x123 [nfsd]
[362108.291877]  ? nfsd4_encode_operation+0xf0/0x18e [nfsd]
[362108.291890]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
[362108.291901]  nfsd_dispatch+0xb9/0x16e [nfsd]
[362108.291915]  svc_process+0x524/0x6e2 [sunrpc]
[362108.291926]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.291936]  nfsd+0xf9/0x150 [nfsd]
[362108.291941]  kthread+0x115/0x11d
[362108.291946]  ? kthread_park+0x76/0x76
[362108.291949]  ret_from_fork+0x35/0x40
[362108.291953] nfsd            D    0  2314      2 0x80000000
[362108.291955] Call Trace:
[362108.291960]  ? __schedule+0x59d/0x5f1
[362108.291964]  schedule+0x6a/0x85
[362108.291969]  btrfs_tree_read_lock+0xbb/0xf1
[362108.291973]  ? wait_woken+0x6d/0x6d
[362108.291978]  find_parent_nodes+0x91d/0x12b8
[362108.291985]  ? btrfs_find_all_roots_safe+0x9c/0x107
[362108.291988]  btrfs_find_all_roots_safe+0x9c/0x107
[362108.291992]  btrfs_find_all_roots+0x57/0x75
[362108.291997]  btrfs_qgroup_trace_extent_post+0x37/0x7c
[362108.292002]  btrfs_add_delayed_tree_ref+0x305/0x32b
[362108.292007]  ? btrfs_issue_discard+0x6c/0x11e
[362108.292010]  btrfs_inc_extent_ref+0x73/0xe1
[362108.292014]  ? add_pinned_bytes+0x38/0x38
[362108.292018]  __btrfs_mod_ref+0x1e0/0x20e
[362108.292023]  update_ref_for_cow+0x16c/0x28b
[362108.292027]  __btrfs_cow_block+0x217/0x4b1
[362108.292031]  btrfs_cow_block+0x107/0x17f
[362108.292035]  btrfs_search_slot+0x31b/0x812
[362108.292040]  btrfs_insert_empty_items+0x53/0x96
[362108.292044]  insert_with_overflow+0x44/0xfb
[362108.292048]  btrfs_insert_dir_item+0xd8/0x205
[362108.292052]  btrfs_add_link+0x11a/0x36f
[362108.292057]  ? __btrfs_release_delayed_node+0x165/0x1bb
[362108.292061]  btrfs_add_nondir+0x1d/0x28
[362108.292064]  btrfs_create+0x154/0x1d0
[362108.292070]  vfs_create+0xbf/0xef
[362108.292082]  do_nfsd_create+0x2be/0x41d [nfsd]
[362108.292096]  nfsd4_open+0x223/0x578 [nfsd]
[362108.292109]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
[362108.292121]  nfsd_dispatch+0xb9/0x16e [nfsd]
[362108.292134]  svc_process+0x524/0x6e2 [sunrpc]
[362108.292146]  ? nfsd_destroy+0x5f/0x5f [nfsd]
[362108.292155]  nfsd+0xf9/0x150 [nfsd]
[362108.292161]  kthread+0x115/0x11d
[362108.292174]  ? kthread_park+0x76/0x76
[362108.292177]  ret_from_fork+0x35/0x40
[362108.292182] anvil           S    0  2347   2296 0x00000100
[362108.292184] Call Trace:
[362108.292189]  ? __schedule+0x59d/0x5f1
[362108.292194]  schedule+0x6a/0x85
[362108.292197]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.292200]  ? _raw_spin_lock_irq+0x14/0x30
[362108.292202]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.292207]  ? ep_scan_ready_list.constprop.3+0x187/0x1bb
[362108.292212]  ep_poll+0x21b/0x31f
[362108.292217]  ? wake_up_q+0x4d/0x4d
[362108.292221]  do_epoll_wait+0x92/0xb2
[362108.292226]  __x64_sys_epoll_wait+0x1a/0x1d
[362108.292229]  do_syscall_64+0x7e/0x133
[362108.292233]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292235] RIP: 0033:0x7fa7b34ac7ab
[362108.292240] Code: Bad RIP value.
[362108.292241] RSP: 002b:00007ffe34927d10 EFLAGS: 00000246 ORIG_RAX:
00000000000000e8
[362108.292245] RAX: ffffffffffffffda RBX: 0000557846d908c0 RCX:
00007fa7b34ac7ab
[362108.292247] RDX: 0000000000000007 RSI: 0000557846d91e90 RDI:
000000000000000c
[362108.292249] RBP: 0000557846d89f50 R08: 00000000ffffffd0 R09:
1999999999999998
[362108.292251] R10: 00000000ffffffff R11: 0000000000000246 R12:
00000000ffffffff
[362108.292253] R13: 0000000000000054 R14: 000000000000000c R15:
0000000000000000
[362108.292256] log             S    0  2348   2296 0x00000100
[362108.292260] Call Trace:
[362108.292264]  ? __schedule+0x59d/0x5f1
[362108.292269]  schedule+0x6a/0x85
[362108.292271]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.292277]  ? __seccomp_filter+0x3e/0x1f2
[362108.292281]  ep_poll+0x21b/0x31f
[362108.292286]  ? wake_up_q+0x4d/0x4d
[362108.292290]  do_epoll_wait+0x92/0xb2
[362108.292295]  __x64_sys_epoll_wait+0x1a/0x1d
[362108.292298]  do_syscall_64+0x7e/0x133
[362108.292302]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292304] RIP: 0033:0x7f32e91647ab
[362108.292308] Code: Bad RIP value.
[362108.292309] RSP: 002b:00007ffdba3b1180 EFLAGS: 00000246 ORIG_RAX:
00000000000000e8
[362108.292313] RAX: ffffffffffffffda RBX: 0000559d73277da0 RCX:
00007f32e91647ab
[362108.292315] RDX: 000000000000001b RSI: 0000559d73277e10 RDI:
0000000000000023
[362108.292316] RBP: 0000559d73271f30 R08: 0000559d73279a50 R09:
0000559d73279a00
[362108.292318] R10: 00000000ffffffff R11: 0000000000000246 R12:
00000000ffffffff
[362108.292320] R13: 0000000000000144 R14: 000000000000000c R15:
0000000000000000
[362108.292324] config          S    0  2349   2296 0x00000100
[362108.292326] Call Trace:
[362108.292331]  ? __schedule+0x59d/0x5f1
[362108.292335]  schedule+0x6a/0x85
[362108.292338]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.292343]  ? __seccomp_filter+0x3e/0x1f2
[362108.292348]  ep_poll+0x21b/0x31f
[362108.292351]  ? _raw_spin_unlock+0x12/0x23
[362108.292355]  ? wake_up_q+0x4d/0x4d
[362108.292359]  do_epoll_wait+0x92/0xb2
[362108.292364]  __x64_sys_epoll_wait+0x1a/0x1d
[362108.292367]  do_syscall_64+0x7e/0x133
[362108.292371]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292373] RIP: 0033:0x7fc472a707ab
[362108.292377] Code: Bad RIP value.
[362108.292378] RSP: 002b:00007ffc28445540 EFLAGS: 00000246 ORIG_RAX:
00000000000000e8
[362108.292381] RAX: ffffffffffffffda RBX: 000055df0fbc8720 RCX:
00007fc472a707ab
[362108.292383] RDX: 0000000000000004 RSI: 000055df0fb469a0 RDI:
000000000000000a
[362108.292385] RBP: 000055df0fb00ec0 R08: 000055df0fb47530 R09:
000055df0fb474e0
[362108.292386] R10: 00000000ffffffff R11: 0000000000000246 R12:
00000000ffffffff
[362108.292388] R13: 0000000000000030 R14: 000000000000000c R15:
0000000000000000
[362108.292392] clamd           S    0  2357      1 0x00000000
[362108.292394] Call Trace:
[362108.292399]  ? __schedule+0x59d/0x5f1
[362108.292404]  ? hrtimer_try_to_cancel+0x29/0x119
[362108.292408]  schedule+0x6a/0x85
[362108.292410]  schedule_hrtimeout_range_clock+0xb0/0xf4
[362108.292414]  ? hrtimer_init+0xf4/0xf4
[362108.292419]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.292423]  do_sys_poll+0x383/0x42b
[362108.292428]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.292433]  ? __wake_up_common_lock+0x8b/0xd0
[362108.292440]  ? merge_state+0x95/0x10a
[362108.292442]  ? preempt_count_add+0x8a/0x9c
[362108.292445]  ? _raw_spin_lock+0x13/0x2f
[362108.292447]  ? _raw_spin_unlock+0x12/0x23
[362108.292451]  ? block_rsv_release_bytes+0x96/0x2a2
[362108.292456]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.292460]  ? btrfs_buffered_write+0x554/0x5ff
[362108.292464]  ? preempt_count_add+0x8a/0x9c
[362108.292466]  ? _raw_spin_lock+0x13/0x2f
[362108.292469]  ? _raw_spin_unlock+0x12/0x23
[362108.292472]  ? btrfs_file_write_iter+0x419/0x49c
[362108.292476]  ? _copy_to_user+0x22/0x28
[362108.292480]  ? read_null+0x8/0x8
[362108.292484]  ? timespec64_add_safe+0x36/0x82
[362108.292488]  __se_sys_poll+0x5a/0xd6
[362108.292492]  do_syscall_64+0x7e/0x133
[362108.292495]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292497] RIP: 0033:0x7f305a4080a3
[362108.292502] Code: Bad RIP value.
[362108.292503] RSP: 002b:00007ffc419b38a0 EFLAGS: 00000293 ORIG_RAX:
0000000000000007
[362108.292506] RAX: ffffffffffffffda RBX: ffffffffffffffff RCX:
00007f305a4080a3
[362108.292508] RDX: 00000000000927c0 RSI: 0000000000000001 RDI:
000055dd3d819a80
[362108.292510] RBP: 00007ffc419b39d0 R08: 0000000000000000 R09:
00007ffc419b2b40
[362108.292511] R10: 00007f305a497e80 R11: 0000000000000293 R12:
000055dd3bb4d350
[362108.292513] R13: 00007ffc419b4540 R14: 0000000000000000 R15:
0000000000000000
[362108.292516] clamd           S    0  2358      1 0x00000000
[362108.292519] Call Trace:
[362108.292524]  ? __schedule+0x59d/0x5f1
[362108.292529]  schedule+0x6a/0x85
[362108.292531]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.292534]  ? preempt_count_add+0x8a/0x9c
[362108.292537]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.292539]  ? preempt_count_add+0x8a/0x9c
[362108.292542]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.292546]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.292550]  do_sys_poll+0x383/0x42b
[362108.292558]  ? intel_pstate_update_util+0x20/0x3b4
[362108.292562]  ? __update_load_avg_cfs_rq+0xf1/0x182
[362108.292566]  ? enqueue_entity+0x535/0x684
[362108.292569]  ? select_task_rq_fair+0xb33/0xb45
[362108.292573]  ? enqueue_task_fair+0xc2/0x5fd
[362108.292577]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.292581]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.292585]  ? pollwake+0x5b/0x75
[362108.292588]  ? wake_up_q+0x4d/0x4d
[362108.292592]  ? __wake_up_common+0xaa/0x126
[362108.292595]  ? preempt_count_add+0x7d/0x9c
[362108.292600]  ? __mnt_drop_write+0x25/0x37
[362108.292603]  ? file_update_time+0xd6/0xfa
[362108.292606]  ? __sb_end_write+0x4b/0x5d
[362108.292610]  ? pipe_write+0x357/0x369
[362108.292616]  ? vfs_write+0x121/0x16b
[362108.292620]  __se_sys_poll+0x5a/0xd6
[362108.292623]  do_syscall_64+0x7e/0x133
[362108.292627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292629] RIP: 0033:0x7f305a4080a3
[362108.292633] Code: Bad RIP value.
[362108.292634] RSP: 002b:00007f302c21e8d0 EFLAGS: 00000293 ORIG_RAX:
0000000000000007
[362108.292637] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f305a4080a3
[362108.292639] RDX: 00000000ffffffff RSI: 0000000000000002 RDI:
00007f3024000b20
[362108.292640] RBP: 00007f302c21ea00 R08: 0000000000000000 R09:
00007f30240008d0
[362108.292642] R10: 00007f3024000080 R11: 0000000000000293 R12:
00007ffc419b395e
[362108.292644] R13: 00007ffc419b395f R14: 0000000000802000 R15:
00007ffc419b3960
[362108.292647] /usr/sbin/amavi S    0  2359      1 0x00000100
[362108.292650] Call Trace:
[362108.292655]  ? __schedule+0x59d/0x5f1
[362108.292659]  ? hrtimer_try_to_cancel+0x29/0x119
[362108.292663]  schedule+0x6a/0x85
[362108.292665]  schedule_hrtimeout_range_clock+0xb0/0xf4
[362108.292683]  ? hrtimer_init+0xf4/0xf4
[362108.292684]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.292685]  do_select+0x5f1/0x643
[362108.292688]  ? __switch_to_asm+0x34/0x70
[362108.292688]  ? __switch_to_asm+0x40/0x70
[362108.292689]  ? __switch_to_asm+0x34/0x70
[362108.292690]  ? __switch_to_asm+0x40/0x70
[362108.292691]  ? __switch_to_asm+0x34/0x70
[362108.292692]  ? __switch_to_asm+0x40/0x70
[362108.292693]  ? __switch_to_asm+0x34/0x70
[362108.292694]  ? __switch_to_asm+0x40/0x70
[362108.292694]  ? __switch_to_asm+0x34/0x70
[362108.292696]  ? __switch_to_asm+0x40/0x70
[362108.292696]  ? __switch_to_asm+0x34/0x70
[362108.292697]  ? __switch_to_asm+0x40/0x70
[362108.292698]  ? __switch_to_asm+0x34/0x70
[362108.292699]  ? __switch_to_asm+0x40/0x70
[362108.292700]  ? __switch_to_asm+0x34/0x70
[362108.292701]  ? __switch_to_asm+0x40/0x70
[362108.292702]  ? __switch_to_asm+0x34/0x70
[362108.292703]  ? __switch_to_asm+0x40/0x70
[362108.292704]  ? __switch_to_asm+0x34/0x70
[362108.292704]  ? __switch_to_asm+0x40/0x70
[362108.292705]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.292706]  ? finish_task_switch+0x181/0x269
[362108.292708]  ? __schedule+0x5a5/0x5f1
[362108.292709]  ? __alloc_pages_nodemask+0x14c/0xca7
[362108.292710]  ? preempt_schedule_irq+0x59/0x7e
[362108.292712]  ? apic_timer_interrupt+0xa/0x20
[362108.292714]  ? ___bpf_prog_run+0x15/0xe22
[362108.292715]  ? ___bpf_prog_run+0xe19/0xe22
[362108.292717]  ? __bpf_prog_run32+0x39/0x59
[362108.292718]  core_sys_select+0x196/0x248
[362108.292720]  ? seccomp_run_filters+0xf5/0x134
[362108.292722]  ? apic_timer_interrupt+0xa/0x20
[362108.292723]  ? __seccomp_filter+0x3e/0x1f2
[362108.292724]  ? group_send_sig_info+0x31/0x59
[362108.292725]  ? kill_pid_info+0x51/0x69
[362108.292726]  ? timespec64_add_safe+0x36/0x82
[362108.292728]  kern_select+0x97/0xcf
[362108.292729]  __x64_sys_select+0x20/0x23
[362108.292730]  do_syscall_64+0x7e/0x133
[362108.292731]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292732] RIP: 0033:0x7f4cbcf53e9b
[362108.292734] Code: Bad RIP value.
[362108.292734] RSP: 002b:00007ffffa950a40 EFLAGS: 00000246 ORIG_RAX:
0000000000000017
[362108.292735] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f4cbcf53e9b
[362108.292736] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[362108.292737] RBP: 000055e3abb31580 R08: 00007ffffa950ac0 R09:
0000000000000080
[362108.292737] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffffa950af8
[362108.292738] R13: 00007ffffa950ad0 R14: 0000000000000000 R15:
0000000000000000
[362108.292740] /usr/sbin/amavi S    0  2361   2359 0x00000100
[362108.292741] Call Trace:
[362108.292743]  ? __schedule+0x59d/0x5f1
[362108.292744]  schedule+0x6a/0x85
[362108.292745]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.292746]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.292748]  ? add_wait_queue+0x15/0x3e
[362108.292749]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.292750]  ? tcp_poll+0x3a/0x1fe
[362108.292752]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.292753]  do_select+0x5f1/0x643
[362108.292756]  ? uncompress_inline+0x13a/0x13a
[362108.292758]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.292759]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.292760]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.292761]  ? __alloc_pages_nodemask+0x14c/0xca7
[362108.292763]  ? mem_cgroup_event_ratelimit.isra.10+0x36/0x86
[362108.292765]  ? memcg_check_events+0x2a/0x172
[362108.292767]  ? mem_cgroup_commit_charge+0xaa/0x10d
[362108.292768]  ? ___bpf_prog_run+0xe19/0xe22
[362108.292769]  ? __bpf_prog_run32+0x39/0x59
[362108.292770]  ? _raw_spin_unlock+0x12/0x23
[362108.292771]  core_sys_select+0x196/0x248
[362108.292774]  ? __seccomp_filter+0x3e/0x1f2
[362108.292775]  ? handle_mm_fault+0x176/0x1c7
[362108.292777]  kern_select+0x97/0xcf
[362108.292778]  __x64_sys_select+0x20/0x23
[362108.292779]  do_syscall_64+0x7e/0x133
[362108.292781]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292781] RIP: 0033:0x7f4cbcf53e9b
[362108.292783] Code: Bad RIP value.
[362108.292783] RSP: 002b:00007ffffa950a40 EFLAGS: 00000246 ORIG_RAX:
0000000000000017
[362108.292784] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f4cbcf53e9b
[362108.292785] RDX: 0000000000000000 RSI: 000055e3ad3b5530 RDI:
0000000000000008
[362108.292785] RBP: 000055e3abb31580 R08: 0000000000000000 R09:
0000000000000080
[362108.292786] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffffa950af8
[362108.292787] R13: 00007ffffa950ad0 R14: 0000000000000001 R15:
000055e3ad3b5530
[362108.292788] /usr/sbin/amavi S    0  2362   2359 0x00000100
[362108.292789] Call Trace:
[362108.292791]  ? __schedule+0x59d/0x5f1
[362108.292793]  schedule+0x6a/0x85
[362108.292795]  locks_lock_inode_wait+0xf6/0x124
[362108.292797]  ? wait_woken+0x6d/0x6d
[362108.292798]  __se_sys_flock+0x10f/0x136
[362108.292799]  do_syscall_64+0x7e/0x133
[362108.292800]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292801] RIP: 0033:0x7f4cbcf4cf67
[362108.292803] Code: Bad RIP value.
[362108.292803] RSP: 002b:00007ffffa950b08 EFLAGS: 00000202 ORIG_RAX:
0000000000000049
[362108.292804] RAX: ffffffffffffffda RBX: 000055e3abb31570 RCX:
00007f4cbcf4cf67
[362108.292805] RDX: 000055e3a803c8e0 RSI: 0000000000000002 RDI:
0000000000000007
[362108.292806] RBP: 000055e3a900e748 R08: 0000000000000000 R09:
000055e3ad505e30
[362108.292806] R10: 0000000000000000 R11: 0000000000000202 R12:
00007f4cbd615b60
[362108.292807] R13: 00007f4cbd614f78 R14: 000055e3abb31568 R15:
0000000000000002
[362108.292808] apache2         S    0  2371   2251 0x00000100
[362108.292810] Call Trace:
[362108.292811]  ? __schedule+0x59d/0x5f1
[362108.292813]  ? __radix_tree_lookup+0x6a/0xa3
[362108.292814]  schedule+0x6a/0x85
[362108.292816]  do_semtimedop+0x7d0/0x975
[362108.292818]  ? inet_recvmsg+0xb6/0xe5
[362108.292820]  ? seccomp_run_filters+0xf5/0x134
[362108.292822]  ? __inode_wait_for_writeback+0x76/0xc9
[362108.292824]  ? __seccomp_filter+0x3e/0x1f2
[362108.292825]  ? __vfs_read+0x101/0x139
[362108.292827]  ? syscall_trace_enter+0x16c/0x216
[362108.292828]  do_syscall_64+0x7e/0x133
[362108.292829]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292830] RIP: 0033:0x7f9082fa171b
[362108.292831] Code: Bad RIP value.
[362108.292832] RSP: 002b:00007fff57fd1f90 EFLAGS: 00000246 ORIG_RAX:
0000000000000041
[362108.292833] RAX: ffffffffffffffda RBX: 0000559c133a9a98 RCX:
00007f9082fa171b
[362108.292833] RDX: 0000000000000001 RSI: 00007f9083efed6c RDI:
0000000000010000
[362108.292834] RBP: 00007f9083efed6c R08: 0000559c135536d8 R09:
0000000000000000
[362108.292835] R10: 0000559c135544c8 R11: 0000000000000246 R12:
00007fff57fd2020
[362108.292835] R13: 0000559c13556180 R14: 0000559c132ec848 R15:
0000000000000000
[362108.292836] apache2         S    0  2724   2251 0x00000100
[362108.292837] Call Trace:
[362108.292839]  ? __schedule+0x59d/0x5f1
[362108.292841]  ? __radix_tree_lookup+0x6a/0xa3
[362108.292842]  schedule+0x6a/0x85
[362108.292844]  do_semtimedop+0x7d0/0x975
[362108.292846]  ? inet_recvmsg+0xb6/0xe5
[362108.292847]  ? seccomp_run_filters+0xf5/0x134
[362108.292849]  ? __inode_wait_for_writeback+0x76/0xc9
[362108.292851]  ? __seccomp_filter+0x3e/0x1f2
[362108.292852]  ? __vfs_read+0x101/0x139
[362108.292853]  ? syscall_trace_enter+0x16c/0x216
[362108.292855]  do_syscall_64+0x7e/0x133
[362108.292856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292857] RIP: 0033:0x7f9082fa171b
[362108.292858] Code: Bad RIP value.
[362108.292859] RSP: 002b:00007fff57fd1f90 EFLAGS: 00000246 ORIG_RAX:
0000000000000041
[362108.292860] RAX: ffffffffffffffda RBX: 0000559c133a9a98 RCX:
00007f9082fa171b
[362108.292860] RDX: 0000000000000001 RSI: 00007f9083efed6c RDI:
0000000000010000
[362108.292861] RBP: 00007f9083efed6c R08: 0000559c135536d8 R09:
0000000000000000
[362108.292861] R10: 0000559c135544c8 R11: 0000000000000246 R12:
00007fff57fd2020
[362108.292862] R13: 0000559c13556180 R14: 0000559c132ec848 R15:
0000000000000000
[362108.292864] apache2         S    0  2725   2251 0x00000100
[362108.292865] Call Trace:
[362108.292867]  ? __schedule+0x59d/0x5f1
[362108.292868]  ? __radix_tree_lookup+0x6a/0xa3
[362108.292869]  schedule+0x6a/0x85
[362108.292871]  do_semtimedop+0x7d0/0x975
[362108.292873]  ? inet_recvmsg+0xb6/0xe5
[362108.292874]  ? seccomp_run_filters+0xf5/0x134
[362108.292876]  ? __inode_wait_for_writeback+0x76/0xc9
[362108.292878]  ? __seccomp_filter+0x3e/0x1f2
[362108.292879]  ? __vfs_read+0x101/0x139
[362108.292881]  ? syscall_trace_enter+0x16c/0x216
[362108.292882]  do_syscall_64+0x7e/0x133
[362108.292883]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292884] RIP: 0033:0x7f9082fa171b
[362108.292885] Code: Bad RIP value.
[362108.292886] RSP: 002b:00007fff57fd1f90 EFLAGS: 00000246 ORIG_RAX:
0000000000000041
[362108.292887] RAX: ffffffffffffffda RBX: 0000559c133a9a98 RCX:
00007f9082fa171b
[362108.292887] RDX: 0000000000000001 RSI: 00007f9083efed6c RDI:
0000000000010000
[362108.292888] RBP: 00007f9083efed6c R08: 0000559c135536d8 R09:
0000000000000000
[362108.292888] R10: 0000559c135544c8 R11: 0000000000000246 R12:
00007fff57fd2020
[362108.292889] R13: 0000559c13556180 R14: 0000559c132ec848 R15:
0000000000000000
[362108.292890] apache2         S    0  2726   2251 0x00000100
[362108.292891] Call Trace:
[362108.292894]  ? __schedule+0x59d/0x5f1
[362108.292895]  ? __radix_tree_lookup+0x6a/0xa3
[362108.292896]  schedule+0x6a/0x85
[362108.292898]  do_semtimedop+0x7d0/0x975
[362108.292900]  ? inet_recvmsg+0xb6/0xe5
[362108.292902]  ? seccomp_run_filters+0xf5/0x134
[362108.292903]  ? __inode_wait_for_writeback+0x76/0xc9
[362108.292905]  ? __seccomp_filter+0x3e/0x1f2
[362108.292906]  ? __vfs_read+0x101/0x139
[362108.292908]  ? syscall_trace_enter+0x16c/0x216
[362108.292909]  do_syscall_64+0x7e/0x133
[362108.292910]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.292911] RIP: 0033:0x7f9082fa171b
[362108.292912] Code: Bad RIP value.
[362108.292913] RSP: 002b:00007fff57fd1f90 EFLAGS: 00000246 ORIG_RAX:
0000000000000041
[362108.292914] RAX: ffffffffffffffda RBX: 0000559c133a9a98 RCX:
00007f9082fa171b
[362108.292914] RDX: 0000000000000001 RSI: 00007f9083efed6c RDI:
0000000000010000
[362108.292915] RBP: 00007f9083efed6c R08: 0000559c135536d8 R09:
0000000000000000
[362108.292916] R10: 0000559c135544c8 R11: 0000000000000246 R12:
00007fff57fd2020
[362108.292917] R13: 0000559c13556180 R14: 0000559c132ec848 R15:
0000000000000000
[362108.292918] kworker/7:2     I    0  1161      2 0x80000000
[362108.292921] Workqueue:            (null) (events_freezable_power_)
[362108.292922] Call Trace:
[362108.292924]  ? __schedule+0x59d/0x5f1
[362108.292926]  ? cancel_delayed_work_sync+0xf/0xf
[362108.292927]  schedule+0x6a/0x85
[362108.292929]  worker_thread+0x24e/0x297
[362108.292930]  kthread+0x115/0x11d
[362108.292932]  ? kthread_park+0x76/0x76
[362108.292933]  ret_from_fork+0x35/0x40
[362108.292935] kworker/6:1     I    0  3373      2 0x80000000
[362108.292938] Workqueue:            (null) (mm_percpu_wq)
[362108.292939] Call Trace:
[362108.292940]  ? __schedule+0x59d/0x5f1
[362108.292941]  ? cancel_delayed_work_sync+0xf/0xf
[362108.292942]  schedule+0x6a/0x85
[362108.292944]  worker_thread+0x24e/0x297
[362108.292945]  kthread+0x115/0x11d
[362108.292947]  ? kthread_park+0x76/0x76
[362108.292948]  ret_from_fork+0x35/0x40
[362108.292949] kworker/1:2     I    0   832      2 0x80000000
[362108.292952] Workqueue:            (null) (mm_percpu_wq)
[362108.292953] Call Trace:
[362108.292955]  ? __schedule+0x59d/0x5f1
[362108.292956]  ? cancel_delayed_work_sync+0xf/0xf
[362108.292957]  schedule+0x6a/0x85
[362108.292958]  worker_thread+0x24e/0x297
[362108.292960]  kthread+0x115/0x11d
[362108.292961]  ? kthread_park+0x76/0x76
[362108.292962]  ret_from_fork+0x35/0x40
[362108.292964] kworker/0:2     I    0  3008      2 0x80000000
[362108.292967] Workqueue:            (null) (events_power_efficient)
[362108.292968] Call Trace:
[362108.292970]  ? __schedule+0x59d/0x5f1
[362108.292971]  ? cancel_delayed_work_sync+0xf/0xf
[362108.292972]  schedule+0x6a/0x85
[362108.292973]  worker_thread+0x24e/0x297
[362108.292975]  kthread+0x115/0x11d
[362108.292976]  ? kthread_park+0x76/0x76
[362108.292977]  ret_from_fork+0x35/0x40
[362108.292979] kworker/6:2     I    0  7996      2 0x80000000
[362108.292982] Workqueue:            (null) (cgroup_destroy)
[362108.292983] Call Trace:
[362108.292985]  ? __schedule+0x59d/0x5f1
[362108.292986]  ? cancel_delayed_work_sync+0xf/0xf
[362108.292988]  schedule+0x6a/0x85
[362108.292989]  worker_thread+0x24e/0x297
[362108.292990]  kthread+0x115/0x11d
[362108.292992]  ? kthread_park+0x76/0x76
[362108.292993]  ret_from_fork+0x35/0x40
[362108.292995] kworker/u17:0   I    0  9115      2 0x80000000
[362108.292998] Workqueue:            (null) (btrfs-worker-high)
[362108.292999] Call Trace:
[362108.293001]  ? __schedule+0x59d/0x5f1
[362108.293002]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293004]  schedule+0x6a/0x85
[362108.293005]  worker_thread+0x24e/0x297
[362108.293006]  kthread+0x115/0x11d
[362108.293008]  ? kthread_park+0x76/0x76
[362108.293009]  ret_from_fork+0x35/0x40
[362108.293010] kworker/4:2     I    0 12354      2 0x80000000
[362108.293013] Workqueue:            (null) (events_freezable_power_)
[362108.293015] Call Trace:
[362108.293016]  ? __schedule+0x59d/0x5f1
[362108.293017]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293019]  schedule+0x6a/0x85
[362108.293020]  worker_thread+0x24e/0x297
[362108.293022]  kthread+0x115/0x11d
[362108.293023]  ? kthread_park+0x76/0x76
[362108.293024]  ret_from_fork+0x35/0x40
[362108.293026] kworker/3:2     I    0 13247      2 0x80000000
[362108.293029] Workqueue:            (null) (events_freezable_power_)
[362108.293029] Call Trace:
[362108.293031]  ? __schedule+0x59d/0x5f1
[362108.293032]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293034]  schedule+0x6a/0x85
[362108.293035]  worker_thread+0x24e/0x297
[362108.293036]  kthread+0x115/0x11d
[362108.293038]  ? kthread_park+0x76/0x76
[362108.293039]  ret_from_fork+0x35/0x40
[362108.293041] kworker/1:0     I    0 16200      2 0x80000000
[362108.293044] Workqueue:            (null) (cgroup_destroy)
[362108.293045] Call Trace:
[362108.293047]  ? __schedule+0x59d/0x5f1
[362108.293048]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293049]  schedule+0x6a/0x85
[362108.293050]  worker_thread+0x24e/0x297
[362108.293052]  kthread+0x115/0x11d
[362108.293053]  ? kthread_park+0x76/0x76
[362108.293054]  ret_from_fork+0x35/0x40
[362108.293056] systemd-helper  S    0 18170      1 0x00000000
[362108.293058] Call Trace:
[362108.293059]  ? __schedule+0x59d/0x5f1
[362108.293061]  schedule+0x6a/0x85
[362108.293062]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.293063]  ? preempt_count_add+0x8a/0x9c
[362108.293064]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.293066]  ? add_wait_queue+0x15/0x3e
[362108.293066]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293068]  ? unix_poll+0x87/0x96
[362108.293070]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.293071]  do_sys_poll+0x383/0x42b
[362108.293073]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293074]  ? ep_poll_callback+0x188/0x1fd
[362108.293077]  ? __wake_up_common+0xaa/0x126
[362108.293078]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293079]  ? __wake_up_common_lock+0x8b/0xd0
[362108.293081]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293083]  ? ___sys_sendmsg+0x206/0x230
[362108.293085]  ? mem_cgroup_commit_charge+0xaa/0x10d
[362108.293086]  ? __lru_cache_add+0x74/0x87
[362108.293088]  ? _raw_spin_unlock+0x12/0x23
[362108.293088]  ? __handle_mm_fault+0x955/0xeb4
[362108.293090]  ? __sys_sendmsg+0x5e/0x94
[362108.293092]  __se_sys_poll+0x5a/0xd6
[362108.293094]  do_syscall_64+0x7e/0x133
[362108.293095]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293095] RIP: 0033:0x7f9f90195058
[362108.293097] Code: Bad RIP value.
[362108.293097] RSP: 002b:00007ffe1d98fa40 EFLAGS: 00000246 ORIG_RAX:
0000000000000007
[362108.293099] RAX: ffffffffffffffda RBX: 0000564ba5378420 RCX:
00007f9f90195058
[362108.293099] RDX: 00000000ffffffff RSI: 0000000000000001 RDI:
00007ffe1d98fa90
[362108.293100] RBP: 0000000000000006 R08: 0000000000000000 R09:
00007ffe1d9bd080
[362108.293100] R10: 0000000011f5d60a R11: 0000000000000246 R12:
0000000000000006
[362108.293101] R13: 0000000000000004 R14: 00000000ffffffff R15:
00007ffe1d98fa90
[362108.293103] snapperd        S    0 18174      1 0x00000000
[362108.293104] Call Trace:
[362108.293106]  ? __schedule+0x59d/0x5f1
[362108.293107]  schedule+0x6a/0x85
[362108.293109]  futex_wait_queue_me+0xc1/0x106
[362108.293110]  futex_wait+0xdb/0x1ea
[362108.293111]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293112]  ? try_to_wake_up+0x34f/0x375
[362108.293113]  ? get_futex_key+0x94/0x2c2
[362108.293115]  do_futex+0xdb/0x904
[362108.293117]  __se_sys_futex+0x13e/0x163
[362108.293119]  do_syscall_64+0x7e/0x133
[362108.293120]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293121] RIP: 0033:0x7ff6797acd7c
[362108.293123] Code: Bad RIP value.
[362108.293123] RSP: 002b:00007ffc9c00b700 EFLAGS: 00000246 ORIG_RAX:
00000000000000ca
[362108.293124] RAX: ffffffffffffffda RBX: 000055ff308f7bd0 RCX:
00007ff6797acd7c
[362108.293125] RDX: 0000000000000000 RSI: 0000000000000080 RDI:
000055ff308f7bf8
[362108.293125] RBP: 0000000000000000 R08: 0000000000000000 R09:
000055ff321deb00
[362108.293126] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[362108.293127] R13: 000055ff308f7ba8 R14: 0000000000000000 R15:
000055ff308f7bf8
[362108.293128] snapperd        D    0 18178      1 0x00000000
[362108.293129] Call Trace:
[362108.293131]  ? __schedule+0x59d/0x5f1
[362108.293133]  ? terminate_walk+0x20/0x7e
[362108.293134]  schedule+0x6a/0x85
[362108.293136]  btrfs_tree_read_lock+0xbb/0xf1
[362108.293138]  ? wait_woken+0x6d/0x6d
[362108.293140]  btrfs_read_lock_root_node+0x1d/0x3b
[362108.293141]  btrfs_search_slot+0x181/0x812
[362108.293142]  ? cp_new_stat+0x150/0x17f
[362108.293144]  btrfs_listxattr+0x9b/0x25b
[362108.293147]  ? __se_sys_newfstat+0x41/0x64
[362108.293148]  listxattr+0x5d/0xb4
[362108.293149]  __se_sys_flistxattr+0x3e/0x5a
[362108.293151]  do_syscall_64+0x7e/0x133
[362108.293152]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293152] RIP: 0033:0x7ff678598fe7
[362108.293154] Code: Bad RIP value.
[362108.293154] RSP: 002b:00007ff675f3db98 EFLAGS: 00000202 ORIG_RAX:
00000000000000c4
[362108.293155] RAX: ffffffffffffffda RBX: 00007ff675f3e2c8 RCX:
00007ff678598fe7
[362108.293156] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000006
[362108.293156] RBP: 00007ff675f3dfc8 R08: 0000000000000000 R09:
0000000000000400
[362108.293157] R10: 0000000000000000 R11: 0000000000000202 R12:
00007ff675f3e2c8
[362108.293158] R13: 00007ff670007d28 R14: 00007ff670007d30 R15:
00007ff67000bdb0
[362108.293159] kworker/2:2     I    0 20398      2 0x80000000
[362108.293166] Workqueue:            (null) (events_freezable_power_)
[362108.293167] Call Trace:
[362108.293169]  ? __schedule+0x59d/0x5f1
[362108.293171]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293172]  schedule+0x6a/0x85
[362108.293173]  worker_thread+0x24e/0x297
[362108.293174]  kthread+0x115/0x11d
[362108.293176]  ? kthread_park+0x76/0x76
[362108.293177]  ret_from_fork+0x35/0x40
[362108.293179] kworker/u17:1   I    0 20546      2 0x80000000
[362108.293182] Workqueue:            (null) (btrfs-worker-high)
[362108.293183] Call Trace:
[362108.293185]  ? __schedule+0x59d/0x5f1
[362108.293187]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293188]  schedule+0x6a/0x85
[362108.293189]  worker_thread+0x24e/0x297
[362108.293190]  kthread+0x115/0x11d
[362108.293192]  ? kthread_park+0x76/0x76
[362108.293193]  ret_from_fork+0x35/0x40
[362108.293195] kworker/u16:0   I    0 20920      2 0x80000000
[362108.293198] Workqueue:            (null) (bond1)
[362108.293199] Call Trace:
[362108.293200]  ? __schedule+0x59d/0x5f1
[362108.293202]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293203]  schedule+0x6a/0x85
[362108.293204]  worker_thread+0x24e/0x297
[362108.293205]  kthread+0x115/0x11d
[362108.293207]  ? kthread_park+0x76/0x76
[362108.293208]  ret_from_fork+0x35/0x40
[362108.293209] kworker/u16:2   I    0 20995      2 0x80000000
[362108.293212] Workqueue:            (null) (events_unbound)
[362108.293213] Call Trace:
[362108.293214]  ? __schedule+0x59d/0x5f1
[362108.293216]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293217]  schedule+0x6a/0x85
[362108.293218]  worker_thread+0x24e/0x297
[362108.293220]  kthread+0x115/0x11d
[362108.293221]  ? kthread_park+0x76/0x76
[362108.293222]  ret_from_fork+0x35/0x40
[362108.293224] sshd            S    0 20997   2260 0x00000000
[362108.293225] Call Trace:
[362108.293227]  ? __schedule+0x59d/0x5f1
[362108.293229]  schedule+0x6a/0x85
[362108.293230]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.293231]  ? preempt_count_add+0x8a/0x9c
[362108.293232]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.293233]  ? add_wait_queue+0x15/0x3e
[362108.293235]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293236]  ? unix_poll+0x87/0x96
[362108.293237]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.293238]  do_sys_poll+0x383/0x42b
[362108.293241]  ? __kmalloc_reserve.isra.7+0x2d/0x6f
[362108.293242]  ? __alloc_skb+0xb3/0x192
[362108.293244]  ? __follow_mount_rcu+0x5b/0xc5
[362108.293245]  ? lookup_fast+0xff/0x297
[362108.293247]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293248]  ? cdev_put+0x1e/0x1e
[362108.293249]  ? dput.part.4+0x29/0xfd
[362108.293251]  ? mntput_no_expire+0x11/0x185
[362108.293253]  ? terminate_walk+0x20/0x7e
[362108.293254]  ? path_openat+0xb78/0xc1b
[362108.293255]  ? do_filp_open+0x88/0xae
[362108.293256]  ? sock_write_iter+0x83/0xae
[362108.293258]  ? preempt_count_add+0x7d/0x9c
[362108.293259]  ? __fd_install+0xa5/0xbe
[362108.293260]  __se_sys_poll+0x5a/0xd6
[362108.293262]  ? filp_close+0x62/0x69
[362108.293263]  do_syscall_64+0x7e/0x133
[362108.293264]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293265] RIP: 0033:0x7efddf36b058
[362108.293266] Code: Bad RIP value.
[362108.293267] RSP: 002b:00007ffe28b572f0 EFLAGS: 00000246 ORIG_RAX:
0000000000000007
[362108.293268] RAX: ffffffffffffffda RBX: 00005642588e01a0 RCX:
00007efddf36b058
[362108.293269] RDX: 00000000ffffffff RSI: 0000000000000001 RDI:
00007ffe28b57338
[362108.293270] RBP: 00007ffe28b57338 R08: 00005642590868b0 R09:
0000564259086870
[362108.293270] R10: 0000000000000000 R11: 0000000000000246 R12:
0000564259079880
[362108.293271] R13: 0000000000000000 R14: 0000000000005207 R15:
0000000000000014
[362108.293272] kworker/u16:5   I    0 20998      2 0x80000000
[362108.293275] Workqueue:            (null) (btrfs-endio-write)
[362108.293276] Call Trace:
[362108.293278]  ? __schedule+0x59d/0x5f1
[362108.293279]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293280]  schedule+0x6a/0x85
[362108.293281]  worker_thread+0x24e/0x297
[362108.293283]  kthread+0x115/0x11d
[362108.293285]  ? kthread_park+0x76/0x76
[362108.293286]  ret_from_fork+0x35/0x40
[362108.293287] systemd         S    0 21001      1 0x00000000
[362108.293289] Call Trace:
[362108.293290]  ? __schedule+0x59d/0x5f1
[362108.293292]  schedule+0x6a/0x85
[362108.293293]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.293294]  ? _raw_spin_lock_irq+0x14/0x30
[362108.293295]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293296]  ? ep_scan_ready_list.constprop.3+0x187/0x1bb
[362108.293298]  ep_poll+0x21b/0x31f
[362108.293300]  ? wake_up_q+0x4d/0x4d
[362108.293302]  do_epoll_wait+0x92/0xb2
[362108.293303]  __x64_sys_epoll_wait+0x1a/0x1d
[362108.293304]  do_syscall_64+0x7e/0x133
[362108.293306]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293306] RIP: 0033:0x7f7439e817ab
[362108.293308] Code: Bad RIP value.
[362108.293308] RSP: 002b:00007ffc3b1119f0 EFLAGS: 00000246 ORIG_RAX:
00000000000000e8
[362108.293309] RAX: ffffffffffffffda RBX: 00005569bced2490 RCX:
00007f7439e817ab
[362108.293310] RDX: 0000000000000010 RSI: 00007ffc3b111a40 RDI:
0000000000000004
[362108.293311] RBP: 00007ffc3b111bf0 R08: 0000000000000010 R09:
00007ffc3b119080
[362108.293311] R10: 00000000ffffffff R11: 0000000000000246 R12:
00007ffc3b111a40
[362108.293312] R13: 0000000000000001 R14: ffffffffffffffff R15:
0000000000000000
[362108.293313] (sd-pam)        S    0 21002  21001 0x00000000
[362108.293314] Call Trace:
[362108.293317]  ? __schedule+0x59d/0x5f1
[362108.293318]  schedule+0x6a/0x85
[362108.293319]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.293320]  ? __handle_mm_fault+0xbc3/0xeb4
[362108.293324]  ? recalc_sigpending+0x17/0x42
[362108.293325]  ? dequeue_signal+0x177/0x19d
[362108.293327]  do_sigtimedwait.isra.7+0x13e/0x1f5
[362108.293329]  __se_sys_rt_sigtimedwait+0x84/0xcb
[362108.293331]  ? __do_page_fault+0x36d/0x3ff
[362108.293332]  do_syscall_64+0x7e/0x133
[362108.293334]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293335] RIP: 0033:0x7fa707a9f72b
[362108.293336] Code: Bad RIP value.
[362108.293337] RSP: 002b:00007ffc1ffe6820 EFLAGS: 00000246 ORIG_RAX:
0000000000000080
[362108.293337] RAX: ffffffffffffffda RBX: 00007ffc1ffe6801 RCX:
00007fa707a9f72b
[362108.293338] RDX: 0000000000000000 RSI: 00007ffc1ffe6860 RDI:
00007ffc1ffe69f8
[362108.293339] RBP: 00007ffc1ffe6860 R08: 0000000000000000 R09:
0000562ff7984700
[362108.293340] R10: 0000000000000008 R11: 0000000000000246 R12:
00007ffc1ffe6958
[362108.293340] R13: 0000000000005209 R14: 00007ffc1ffe6958 R15:
0000000000008000
[362108.293342] kworker/5:2     I    0 21006      2 0x80000000
[362108.293345] Workqueue:            (null) (cgroup_destroy)
[362108.293346] Call Trace:
[362108.293347]  ? __schedule+0x59d/0x5f1
[362108.293349]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293350]  schedule+0x6a/0x85
[362108.293351]  worker_thread+0x24e/0x297
[362108.293353]  kthread+0x115/0x11d
[362108.293354]  ? kthread_park+0x76/0x76
[362108.293355]  ret_from_fork+0x35/0x40
[362108.293357] sshd            S    0 21007  20997 0x00000000
[362108.293358] Call Trace:
[362108.293360]  ? __schedule+0x59d/0x5f1
[362108.293361]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293362]  schedule+0x6a/0x85
[362108.293363]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.293364]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.293367]  ? pty_stop+0x70/0x70
[362108.293368]  ? n_tty_poll+0x17c/0x18d
[362108.293370]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.293371]  do_select+0x5f1/0x643
[362108.293374]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293375]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293377]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293378]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293379]  ? preempt_count_add+0x8a/0x9c
[362108.293381]  ? get_nohz_timer_target+0x1b/0xea
[362108.293382]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293383]  ? mod_timer+0x287/0x2af
[362108.293384]  ? sk_reset_timer+0x14/0x27
[362108.293386]  ? tcp_schedule_loss_probe+0x102/0x10a
[362108.293388]  ? tcp_write_xmit+0x9be/0xcd8
[362108.293390]  ? _copy_from_iter_full+0x1dc/0x1ed
[362108.293391]  ? __tcp_push_pending_frames+0x30/0x95
[362108.293392]  core_sys_select+0x196/0x248
[362108.293395]  ? sock_write_iter+0x83/0xae
[362108.293397]  kern_select+0x97/0xcf
[362108.293398]  ? _copy_to_user+0x22/0x28
[362108.293400]  ? put_timespec64+0x3c/0x61
[362108.293401]  __x64_sys_select+0x20/0x23
[362108.293402]  do_syscall_64+0x7e/0x133
[362108.293404]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293404] RIP: 0033:0x7efddf36de9b
[362108.293406] Code: Bad RIP value.
[362108.293407] RSP: 002b:00007ffe28b57260 EFLAGS: 00000246 ORIG_RAX:
0000000000000017
[362108.293408] RAX: ffffffffffffffda RBX: 000056425907b4d0 RCX:
00007efddf36de9b
[362108.293408] RDX: 00005642590797b0 RSI: 0000564259074e00 RDI:
000000000000000d
[362108.293409] RBP: 0000000000000000 R08: 0000000000000000 R09:
00007ffe28bb1080
[362108.293409] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[362108.293410] R13: 0000000000000003 R14: 0000000000000003 R15:
00005642588e0a20
[362108.293412] bash            S    0 21008  21007 0x00000000
[362108.293413] Call Trace:
[362108.293415]  ? __schedule+0x59d/0x5f1
[362108.293416]  ? __tty_check_change+0xdd/0x118
[362108.293418]  ? __radix_tree_lookup+0x6a/0xa3
[362108.293419]  schedule+0x6a/0x85
[362108.293420]  do_wait+0x1d5/0x237
[362108.293422]  kernel_wait4+0xbe/0x111
[362108.293424]  ? task_stopped_code+0x3a/0x3a
[362108.293425]  __se_sys_wait4+0x3c/0x8b
[362108.293427]  ? __do_page_fault+0x36d/0x3ff
[362108.293427]  ? preempt_count_add+0x8a/0x9c
[362108.293429]  ? recalc_sigpending+0x17/0x42
[362108.293430]  ? __set_current_blocked+0x3d/0x55
[362108.293431]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293432]  ? sigprocmask+0x6e/0x8a
[362108.293433]  ? _copy_to_user+0x22/0x28
[362108.293434]  ? __se_sys_rt_sigprocmask+0x93/0xbb
[362108.293435]  do_syscall_64+0x7e/0x133
[362108.293436]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293437] RIP: 0033:0x7f86d8cba21b
[362108.293439] Code: Bad RIP value.
[362108.293439] RSP: 002b:00007fff7ec6caf0 EFLAGS: 00000246 ORIG_RAX:
000000000000003d
[362108.293441] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f86d8cba21b
[362108.293441] RDX: 000000000000000a RSI: 00007fff7ec6cb30 RDI:
00000000ffffffff
[362108.293442] RBP: 000000000000000a R08: 0000000000000000 R09:
00005651dfba3280
[362108.293442] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[362108.293443] R13: 00000000ffffffff R14: 0000000000000000 R15:
0000000000000001
[362108.293445] su              S    0 21065  21008 0x00000000
[362108.293446] Call Trace:
[362108.293448]  ? __schedule+0x59d/0x5f1
[362108.293449]  schedule+0x6a/0x85
[362108.293450]  do_wait+0x1d5/0x237
[362108.293452]  kernel_wait4+0xbe/0x111
[362108.293453]  ? task_stopped_code+0x3a/0x3a
[362108.293454]  __se_sys_wait4+0x3c/0x8b
[362108.293455]  ? _raw_spin_lock_irq+0x14/0x30
[362108.293456]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293457]  ? do_sigaction+0xb6/0x18c
[362108.293458]  ? preempt_count_add+0x8a/0x9c
[362108.293460]  ? recalc_sigpending+0x17/0x42
[362108.293461]  ? __set_current_blocked+0x3d/0x55
[362108.293462]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293462]  ? sigprocmask+0x6e/0x8a
[362108.293464]  ? __se_sys_rt_sigprocmask+0x72/0xbb
[362108.293465]  do_syscall_64+0x7e/0x133
[362108.293466]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293467] RIP: 0033:0x7f09e1fd721b
[362108.293468] Code: Bad RIP value.
[362108.293468] RSP: 002b:00007ffdfa21c640 EFLAGS: 00000246 ORIG_RAX:
000000000000003d
[362108.293469] RAX: ffffffffffffffda RBX: 00007ffdfa21c690 RCX:
00007f09e1fd721b
[362108.293470] RDX: 0000000000000002 RSI: 00007ffdfa21c68c RDI:
00000000ffffffff
[362108.293471] RBP: 00007ffdfa21c68c R08: 0000000000000000 R09:
00007f09e28f4b80
[362108.293471] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffdfa21c908
[362108.293472] R13: 00000000ffffffff R14: 0000000000000000 R15:
0000000000000000
[362108.293473] bash            S    0 21066  21065 0x00000000
[362108.293474] Call Trace:
[362108.293477]  ? __schedule+0x59d/0x5f1
[362108.293478]  ? preempt_count_add+0x8a/0x9c
[362108.293479]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.293480]  schedule+0x6a/0x85
[362108.293481]  do_wait+0x1d5/0x237
[362108.293482]  kernel_wait4+0xbe/0x111
[362108.293484]  ? task_stopped_code+0x3a/0x3a
[362108.293485]  __se_sys_wait4+0x3c/0x8b
[362108.293486]  ? __do_page_fault+0x36d/0x3ff
[362108.293487]  ? preempt_count_add+0x8a/0x9c
[362108.293488]  ? recalc_sigpending+0x17/0x42
[362108.293489]  ? __set_current_blocked+0x3d/0x55
[362108.293490]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293491]  ? sigprocmask+0x6e/0x8a
[362108.293492]  ? _copy_to_user+0x22/0x28
[362108.293494]  ? __se_sys_rt_sigprocmask+0x93/0xbb
[362108.293495]  do_syscall_64+0x7e/0x133
[362108.293496]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293496] RIP: 0033:0x7f7e4cb5821b
[362108.293498] Code: Bad RIP value.
[362108.293499] RSP: 002b:00007ffc82f3aec0 EFLAGS: 00000246 ORIG_RAX:
000000000000003d
[362108.293500] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f7e4cb5821b
[362108.293500] RDX: 000000000000000a RSI: 00007ffc82f3af00 RDI:
00000000ffffffff
[362108.293501] RBP: 000000000000000a R08: 0000000000000000 R09:
0000558b380e7230
[362108.293501] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[362108.293502] R13: 00000000ffffffff R14: 0000000000000000 R15:
0000000000000000
[362108.293503] ls              D    0 21079  21066 0x00000000
[362108.293504] Call Trace:
[362108.293506]  ? __schedule+0x59d/0x5f1
[362108.293508]  schedule+0x6a/0x85
[362108.293510]  rwsem_down_read_failed_killable+0x17c/0x1d9
[362108.293511]  ? _raw_spin_unlock+0x12/0x23
[362108.293513]  call_rwsem_down_read_failed_killable+0x14/0x30
[362108.293515]  down_read_killable+0x13/0x36
[362108.293516]  iterate_dir+0x59/0x131
[362108.293518]  ksys_getdents64+0x8f/0x104
[362108.293520]  ? filldir+0xef/0xef
[362108.293521]  __x64_sys_getdents64+0x16/0x19
[362108.293522]  do_syscall_64+0x7e/0x133
[362108.293523]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293524] RIP: 0033:0x7f4d00d1dadb
[362108.293525] Code: Bad RIP value.
[362108.293526] RSP: 002b:00007ffc7a066140 EFLAGS: 00000246 ORIG_RAX:
00000000000000d9
[362108.293527] RAX: ffffffffffffffda RBX: 000055766371c130 RCX:
00007f4d00d1dadb
[362108.293528] RDX: 0000000000008000 RSI: 000055766371c160 RDI:
0000000000000003
[362108.293528] RBP: 000055766371c160 R08: 0000000000000003 R09:
0000557663714010
[362108.293529] R10: ffffffffffffff6d R11: 0000000000000246 R12:
ffffffffffffff80
[362108.293530] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
[362108.293531] kworker/3:1     I    0 21087      2 0x80000000
[362108.293534] Workqueue:            (null) (events)
[362108.293535] Call Trace:
[362108.293537]  ? __schedule+0x59d/0x5f1
[362108.293538]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293539]  schedule+0x6a/0x85
[362108.293540]  worker_thread+0x24e/0x297
[362108.293542]  kthread+0x115/0x11d
[362108.293544]  ? kthread_park+0x76/0x76
[362108.293545]  ret_from_fork+0x35/0x40
[362108.293546] kworker/2:1     I    0 21156      2 0x80000000
[362108.293549] Workqueue:            (null) (mm_percpu_wq)
[362108.293550] Call Trace:
[362108.293552]  ? __schedule+0x59d/0x5f1
[362108.293553]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293554]  schedule+0x6a/0x85
[362108.293555]  worker_thread+0x24e/0x297
[362108.293557]  kthread+0x115/0x11d
[362108.293558]  ? kthread_park+0x76/0x76
[362108.293559]  ret_from_fork+0x35/0x40
[362108.293561] kworker/4:0     I    0 21230      2 0x80000000
[362108.293564] Workqueue:            (null) (mm_percpu_wq)
[362108.293565] Call Trace:
[362108.293567]  ? __schedule+0x59d/0x5f1
[362108.293568]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293569]  schedule+0x6a/0x85
[362108.293570]  worker_thread+0x24e/0x297
[362108.293572]  kthread+0x115/0x11d
[362108.293573]  ? kthread_park+0x76/0x76
[362108.293574]  ret_from_fork+0x35/0x40
[362108.293576] kworker/0:0     I    0 21237      2 0x80000000
[362108.293579] Workqueue:            (null) (events_power_efficient)
[362108.293580] Call Trace:
[362108.293582]  ? __schedule+0x59d/0x5f1
[362108.293583]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293584]  schedule+0x6a/0x85
[362108.293586]  worker_thread+0x24e/0x297
[362108.293588]  kthread+0x115/0x11d
[362108.293589]  ? kthread_park+0x76/0x76
[362108.293590]  ret_from_fork+0x35/0x40
[362108.293592] kworker/2:0     I    0 21346      2 0x80000000
[362108.293595] Workqueue:            (null) (mm_percpu_wq)
[362108.293596] Call Trace:
[362108.293597]  ? __schedule+0x59d/0x5f1
[362108.293599]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293600]  schedule+0x6a/0x85
[362108.293601]  worker_thread+0x24e/0x297
[362108.293603]  kthread+0x115/0x11d
[362108.293604]  ? kthread_park+0x76/0x76
[362108.293605]  ret_from_fork+0x35/0x40
[362108.293607] kworker/3:0     I    0 21347      2 0x80000000
[362108.293610] Workqueue:            (null) (mm_percpu_wq)
[362108.293611] Call Trace:
[362108.293612]  ? __schedule+0x59d/0x5f1
[362108.293613]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293615]  schedule+0x6a/0x85
[362108.293616]  worker_thread+0x24e/0x297
[362108.293618]  kthread+0x115/0x11d
[362108.293619]  ? kthread_park+0x76/0x76
[362108.293620]  ret_from_fork+0x35/0x40
[362108.293622] kworker/u17:2   I    0 21361      2 0x80000000
[362108.293625] Workqueue:            (null) (btrfs-worker-high)
[362108.293626] Call Trace:
[362108.293628]  ? __schedule+0x59d/0x5f1
[362108.293629]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293630]  schedule+0x6a/0x85
[362108.293631]  worker_thread+0x24e/0x297
[362108.293633]  kthread+0x115/0x11d
[362108.293635]  ? kthread_park+0x76/0x76
[362108.293636]  ret_from_fork+0x35/0x40
[362108.293638] sshd            S    0 21421   2260 0x00000000
[362108.293639] Call Trace:
[362108.293641]  ? __schedule+0x59d/0x5f1
[362108.293642]  schedule+0x6a/0x85
[362108.293643]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.293645]  ? preempt_count_add+0x8a/0x9c
[362108.293645]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.293647]  ? add_wait_queue+0x15/0x3e
[362108.293648]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293649]  ? unix_poll+0x87/0x96
[362108.293650]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.293652]  do_sys_poll+0x383/0x42b
[362108.293654]  ? __kmalloc_reserve.isra.7+0x2d/0x6f
[362108.293655]  ? __alloc_skb+0xb3/0x192
[362108.293657]  ? __follow_mount_rcu+0x5b/0xc5
[362108.293659]  ? lookup_fast+0xff/0x297
[362108.293660]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293661]  ? cdev_put+0x1e/0x1e
[362108.293663]  ? dput.part.4+0x29/0xfd
[362108.293664]  ? mntput_no_expire+0x11/0x185
[362108.293665]  ? terminate_walk+0x20/0x7e
[362108.293666]  ? path_openat+0xb78/0xc1b
[362108.293668]  ? do_filp_open+0x88/0xae
[362108.293669]  ? sock_write_iter+0x83/0xae
[362108.293671]  ? preempt_count_add+0x7d/0x9c
[362108.293672]  ? __fd_install+0xa5/0xbe
[362108.293673]  __se_sys_poll+0x5a/0xd6
[362108.293674]  ? filp_close+0x62/0x69
[362108.293676]  do_syscall_64+0x7e/0x133
[362108.293677]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293678] RIP: 0033:0x7f4bff3cf058
[362108.293680] Code: Bad RIP value.
[362108.293680] RSP: 002b:00007fff1cb24cb0 EFLAGS: 00000246 ORIG_RAX:
0000000000000007
[362108.293681] RAX: ffffffffffffffda RBX: 00005575e56bc1a0 RCX:
00007f4bff3cf058
[362108.293682] RDX: 00000000ffffffff RSI: 0000000000000001 RDI:
00007fff1cb24cf8
[362108.293682] RBP: 00007fff1cb24cf8 R08: 00005575e7659900 R09:
00005575e76598c0
[362108.293683] R10: 0000000000000000 R11: 0000000000000246 R12:
00005575e764f620
[362108.293683] R13: 0000000000000000 R14: 00000000000053ae R15:
0000000000000014
[362108.293685] sshd            S    0 21423  21421 0x00000000
[362108.293686] Call Trace:
[362108.293688]  ? __schedule+0x59d/0x5f1
[362108.293689]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293690]  schedule+0x6a/0x85
[362108.293691]  schedule_hrtimeout_range_clock+0x48/0xf4
[362108.293692]  ? _raw_spin_lock_irqsave+0x17/0x36
[362108.293694]  ? pty_stop+0x70/0x70
[362108.293695]  ? n_tty_poll+0x17c/0x18d
[362108.293696]  poll_schedule_timeout.constprop.3+0x43/0x5c
[362108.293697]  do_select+0x5f1/0x643
[362108.293700]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293701]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293702]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293704]  ? compat_poll_select_copy_remaining+0x11d/0x11d
[362108.293705]  ? preempt_count_add+0x8a/0x9c
[362108.293706]  ? get_nohz_timer_target+0x1b/0xea
[362108.293708]  ? internal_add_timer+0x27/0x34
[362108.293708]  ? _raw_spin_unlock_irqrestore+0x14/0x25
[362108.293709]  ? mod_timer+0x287/0x2af
[362108.293711]  ? sk_reset_timer+0x14/0x27
[362108.293712]  ? tcp_schedule_loss_probe+0x102/0x10a
[362108.293713]  ? tcp_write_xmit+0x9be/0xcd8
[362108.293714]  ? _copy_from_iter_full+0x1dc/0x1ed
[362108.293715]  ? __tcp_push_pending_frames+0x30/0x95
[362108.293717]  core_sys_select+0x196/0x248
[362108.293718]  ? sock_write_iter+0x83/0xae
[362108.293720]  kern_select+0x97/0xcf
[362108.293722]  ? _copy_to_user+0x22/0x28
[362108.293724]  ? put_timespec64+0x3c/0x61
[362108.293725]  __x64_sys_select+0x20/0x23
[362108.293726]  do_syscall_64+0x7e/0x133
[362108.293727]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293728] RIP: 0033:0x7f4bff3d1e9b
[362108.293730] Code: Bad RIP value.
[362108.293730] RSP: 002b:00007fff1cb24c20 EFLAGS: 00000246 ORIG_RAX:
0000000000000017
[362108.293731] RAX: ffffffffffffffda RBX: 00005575e764e770 RCX:
00007f4bff3d1e9b
[362108.293732] RDX: 00005575e764c9b0 RSI: 00005575e7648110 RDI:
000000000000000d
[362108.293732] RBP: 0000000000000000 R08: 0000000000000000 R09:
00007fff1cbc8080
[362108.293733] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[362108.293734] R13: 0000000000000003 R14: 0000000000000003 R15:
00005575e56bca20
[362108.293735] bash            S    0 21424  21423 0x00000000
[362108.293736] Call Trace:
[362108.293738]  ? __schedule+0x59d/0x5f1
[362108.293739]  ? __tty_check_change+0xdd/0x118
[362108.293741]  ? __radix_tree_lookup+0x6a/0xa3
[362108.293742]  schedule+0x6a/0x85
[362108.293743]  do_wait+0x1d5/0x237
[362108.293744]  kernel_wait4+0xbe/0x111
[362108.293746]  ? task_stopped_code+0x3a/0x3a
[362108.293747]  __se_sys_wait4+0x3c/0x8b
[362108.293748]  ? __do_page_fault+0x36d/0x3ff
[362108.293749]  ? preempt_count_add+0x8a/0x9c
[362108.293751]  ? recalc_sigpending+0x17/0x42
[362108.293752]  ? __set_current_blocked+0x3d/0x55
[362108.293753]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293753]  ? sigprocmask+0x6e/0x8a
[362108.293755]  ? _copy_to_user+0x22/0x28
[362108.293756]  ? __se_sys_rt_sigprocmask+0x93/0xbb
[362108.293757]  do_syscall_64+0x7e/0x133
[362108.293758]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293759] RIP: 0033:0x7f116010d21b
[362108.293760] Code: Bad RIP value.
[362108.293761] RSP: 002b:00007fff0dc8e940 EFLAGS: 00000246 ORIG_RAX:
000000000000003d
[362108.293762] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f116010d21b
[362108.293762] RDX: 000000000000000a RSI: 00007fff0dc8e980 RDI:
00000000ffffffff
[362108.293763] RBP: 000000000000000a R08: 0000000000000000 R09:
00005577f1e973f0
[362108.293764] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[362108.293765] R13: 00000000ffffffff R14: 0000000000000000 R15:
0000000000000000
[362108.293766] su              S    0 21427  21424 0x00000000
[362108.293767] Call Trace:
[362108.293769]  ? __schedule+0x59d/0x5f1
[362108.293770]  schedule+0x6a/0x85
[362108.293771]  do_wait+0x1d5/0x237
[362108.293773]  kernel_wait4+0xbe/0x111
[362108.293774]  ? task_stopped_code+0x3a/0x3a
[362108.293775]  __se_sys_wait4+0x3c/0x8b
[362108.293776]  ? _raw_spin_lock_irq+0x14/0x30
[362108.293777]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293778]  ? do_sigaction+0xb6/0x18c
[362108.293779]  ? preempt_count_add+0x8a/0x9c
[362108.293780]  ? recalc_sigpending+0x17/0x42
[362108.293782]  ? __set_current_blocked+0x3d/0x55
[362108.293783]  ? _raw_spin_unlock_irq+0x13/0x24
[362108.293783]  ? sigprocmask+0x6e/0x8a
[362108.293784]  ? __se_sys_rt_sigprocmask+0x72/0xbb
[362108.293785]  do_syscall_64+0x7e/0x133
[362108.293786]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293787] RIP: 0033:0x7f9c3cd9721b
[362108.293789] Code: Bad RIP value.
[362108.293789] RSP: 002b:00007ffea71ad750 EFLAGS: 00000246 ORIG_RAX:
000000000000003d
[362108.293790] RAX: ffffffffffffffda RBX: 00007ffea71ad7a0 RCX:
00007f9c3cd9721b
[362108.293791] RDX: 0000000000000002 RSI: 00007ffea71ad79c RDI:
00000000ffffffff
[362108.293791] RBP: 00007ffea71ad79c R08: 0000000000000000 R09:
00007f9c3d6b4b80
[362108.293792] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffea71ada18
[362108.293793] R13: 00000000ffffffff R14: 0000000000000000 R15:
0000000000000000
[362108.293794] bash            R  running task        0 21434  21427 0x800=
00000
[362108.293795] Call Trace:
[362108.293797]  sched_show_task+0xea/0x11c
[362108.293799]  show_state_filter+0x91/0xa5
[362108.293802]  sysrq_handle_showstate+0xc/0x11
[362108.293804]  __handle_sysrq+0x86/0x107
[362108.293806]  write_sysrq_trigger+0x2b/0x30
[362108.293808]  proc_reg_write+0x3e/0x5c
[362108.293809]  ? proc_reg_poll+0x55/0x55
[362108.293811]  __vfs_write+0x33/0x141
[362108.293812]  ? handle_mm_fault+0x176/0x1c7
[362108.293814]  vfs_write+0xc8/0x16b
[362108.293816]  ksys_write+0x5d/0xab
[362108.293817]  do_syscall_64+0x7e/0x133
[362108.293819]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[362108.293819] RIP: 0033:0x7f6ba3c63a08
[362108.293820] Code: 00 90 48 83 ec 38 64 48 8b 04 25 28 00 00 00 48
89 44 24 28 31 c0 48 8d 05 d5 5c 2d 00 8b 00 85 c0 75 27 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 60 48 8b 4c 24 28 64 48 33 0c 25 28 00
00 00
[362108.293821] RSP: 002b:00007ffc3305df70 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[362108.293822] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
00007f6ba3c63a08
[362108.293822] RDX: 0000000000000002 RSI: 0000563a722ce800 RDI:
0000000000000001
[362108.293823] RBP: 0000563a722ce800 R08: 000000000000000a R09:
00007f6ba438e740
[362108.293824] R10: fffffffffffffd8e R11: 0000000000000246 R12:
00007f6ba3f35760
[362108.293824] R13: 0000000000000002 R14: 00007f6ba3f30760 R15:
0000000000000002
[362108.293826] kworker/0:1     I    0 21445      2 0x80000000
[362108.293829] Workqueue:            (null) (events_power_efficient)
[362108.293830] Call Trace:
[362108.293832]  ? __schedule+0x59d/0x5f1
[362108.293833]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293834]  schedule+0x6a/0x85
[362108.293836]  worker_thread+0x24e/0x297
[362108.293838]  kthread+0x115/0x11d
[362108.293839]  ? kthread_park+0x76/0x76
[362108.293840]  ret_from_fork+0x35/0x40
[362108.293842] kworker/4:1     I    0 21452      2 0x80000000
[362108.293845] Workqueue:            (null) (mm_percpu_wq)
[362108.293846] Call Trace:
[362108.293848]  ? __schedule+0x59d/0x5f1
[362108.293849]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293850]  schedule+0x6a/0x85
[362108.293851]  worker_thread+0x24e/0x297
[362108.293853]  kthread+0x115/0x11d
[362108.293855]  ? kthread_park+0x76/0x76
[362108.293856]  ret_from_fork+0x35/0x40
[362108.293858] kworker/u16:1   I    0 21454      2 0x80000000
[362108.293861] Workqueue:            (null) (btrfs-endio-write)
[362108.293861] Call Trace:
[362108.293863]  ? __schedule+0x59d/0x5f1
[362108.293865]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293866]  schedule+0x6a/0x85
[362108.293867]  worker_thread+0x24e/0x297
[362108.293869]  kthread+0x115/0x11d
[362108.293870]  ? kthread_park+0x76/0x76
[362108.293871]  ret_from_fork+0x35/0x40
[362108.293873] kworker/u16:3   I    0 21455      2 0x80000000
[362108.293876] Workqueue:            (null) (btrfs-endio-write)
[362108.293877] Call Trace:
[362108.293879]  ? __schedule+0x59d/0x5f1
[362108.293880]  ? cancel_delayed_work_sync+0xf/0xf
[362108.293881]  schedule+0x6a/0x85
[362108.293883]  worker_thread+0x24e/0x297
[362108.293884]  kthread+0x115/0x11d
[362108.293886]  ? kthread_park+0x76/0x76
[362108.293887]  ret_from_fork+0x35/0x40
[362108.293889] Showing busy workqueues and worker pools:

root@gentooserver /usr/src/linux/scripts # ./faddr2line ../vmlinux
btrfs_commit_transaction+0x219/0x7ac
btrfs_commit_transaction+0x219/0x7ac:
btrfs_commit_transaction at ??:?

On Wed, Apr 24, 2019 at 3:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/4/23 =E4=B8=8A=E5=8D=884:37, Nathan Dehnel wrote:
> > I have a raid10 volume that frequently locks up when I try to write to
> > it or delete things. Any command that touches it will hang (and can't
> > be killed) and I have to start a new ssh session to get into the
> > computer again. Nothing fixes it besides a reboot, and the volume will
> > fail to unmount while the computer is shutting down.
> >
> > [  302.360912] sysrq: SysRq : Show Blocked State
> > [  302.360951]   task                        PC stack   pid father
> > [  302.360987] btrfs-transacti D    0  2187      2 0x80000000
> > [  302.360993] Call Trace:
> > [  302.361007]  ? __schedule+0x59d/0x5f1
> > [  302.361012]  schedule+0x6a/0x85
> > [  302.361019]  btrfs_commit_transaction+0x219/0x7ac
>
> Btrfs is waiting other transaction to be committed.
>
> At that freeze, would you check which thread is taking CPU time?
>
> Are you utilizing backgroup balance or qgroup?
> If you have tons of snapshots, they may hugely slow down qgroup.
> Or you just have a running balance with qgroup enabled, it will almost
> hang your system.
>
> It's going to be fixed in v5.2. While during 4.19 to v5.1 we have a lot
> of optimizations to make balance + qgroup much faster.
>
> Thanks,
> Qu
>
>
>
> > [  302.361027]  ? wait_woken+0x6d/0x6d
> > [  302.361031]  transaction_kthread+0xc9/0x135
> > [  302.361036]  ? btrfs_cleanup_transaction+0x4c7/0x4c7
> > [  302.361041]  kthread+0x115/0x11d
> > [  302.361046]  ? kthread_park+0x76/0x76
> > [  302.361050]  ret_from_fork+0x35/0x40
> > [  302.361064] nfsd            D    0  2292      2 0x80000000
> > [  302.361067] Call Trace:
> > [  302.361072]  ? __schedule+0x59d/0x5f1
> > [  302.361077]  schedule+0x6a/0x85
> > [  302.361120]  wait_current_trans+0x9b/0xd8
> > [  302.361126]  ? wait_woken+0x6d/0x6d
> > [  302.361131]  start_transaction+0x1ae/0x38e
> > [  302.361135]  btrfs_create+0x59/0x1d0
> > [  302.361142]  vfs_create+0xbf/0xef
> > [  302.361160]  do_nfsd_create+0x2be/0x41d [nfsd]
> > [  302.361214]  nfsd4_open+0x223/0x578 [nfsd]
> > [  302.361229]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
> > [  302.361240]  nfsd_dispatch+0xb9/0x16e [nfsd]
> > [  302.361258]  svc_process+0x524/0x6e2 [sunrpc]
> > [  302.361270]  ? nfsd_destroy+0x5f/0x5f [nfsd]
> > [  302.361278]  nfsd+0xf9/0x150 [nfsd]
> > [  302.361284]  kthread+0x115/0x11d
> > [  302.361289]  ? kthread_park+0x76/0x76
> > [  302.361292]  ret_from_fork+0x35/0x40
> > [  302.361297] nfsd            D    0  2293      2 0x80000000
> > [  302.361300] Call Trace:
> > [  302.361305]  ? __schedule+0x59d/0x5f1
> > [  302.361309]  schedule+0x6a/0x85
> > [  302.361314]  rwsem_down_write_failed+0x1af/0x210
> > [  302.361325]  ? nfsd_permission+0xa3/0xe8 [nfsd]
> > [  302.361330]  call_rwsem_down_write_failed+0x13/0x20
> > [  302.361335]  down_write+0x20/0x2e
> > [  302.361345]  nfsd_unlink+0xb1/0x16b [nfsd]
> > [  302.361359]  nfsd4_remove+0x4e/0x10a [nfsd]
> > [  302.361371]  nfsd4_proc_compound+0x44a/0x562 [nfsd]
> > [  302.361381]  nfsd_dispatch+0xb9/0x16e [nfsd]
> > [  302.361395]  svc_process+0x524/0x6e2 [sunrpc]
> > [  302.361401]  ? __mutex_unlock_slowpath.isra.6+0x1e8/0x20a
> > [  302.361410]  ? nfsd_destroy+0x5f/0x5f [nfsd]
> > [  302.361419]  nfsd+0xf9/0x150 [nfsd]
> > [  302.361424]  kthread+0x115/0x11d
> > [  302.361428]  ? kthread_park+0x76/0x76
> > [  302.361434]  ret_from_fork+0x35/0x40
> > [  302.361441] rm              D    0  2388   2334 0x00000004
> > [  302.361444] Call Trace:
> > [  302.361449]  ? __schedule+0x59d/0x5f1
> > [  302.361453]  schedule+0x6a/0x85
> > [  302.361457]  wait_current_trans+0x9b/0xd8
> > [  302.361462]  ? wait_woken+0x6d/0x6d
> > [  302.361466]  start_transaction+0x1ae/0x38e
> > [  302.361471]  btrfs_start_transaction_fallback_global_rsv+0x32/0x127
> > [  302.361475]  btrfs_unlink+0x30/0xc0
> > [  302.361478]  vfs_unlink+0xd2/0x147
> > [  302.361482]  do_unlinkat+0x112/0x223
> > [  302.361488]  do_syscall_64+0x7e/0x133
> > [  302.361492]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  302.361496] RIP: 0033:0x7f681509b5d7
> > [  302.361504] Code: Bad RIP value.
> > [  302.361506] RSP: 002b:00007fffb1aed668 EFLAGS: 00000202 ORIG_RAX:
> > 0000000000000107
> > [  302.361510] RAX: ffffffffffffffda RBX: 000055672760c6c0 RCX: 00007f6=
81509b5d7
> > [  302.361512] RDX: 0000000000000000 RSI: 000055672760b490 RDI: 0000000=
0ffffff9c
> > [  302.361514] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000=
000000000
> > [  302.361516] R10: fffffffffffff12b R11: 0000000000000202 R12: 00007ff=
fb1aed848
> > [  302.361518] R13: 000055672760b400 R14: 0000000000000002 R15: 0000000=
000000000
> >
>
