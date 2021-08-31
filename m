Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4E3FCAFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhHaPq7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbhHaPq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 11:46:58 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E682C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 08:46:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bk29so20068566qkb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=e0ApdGVnQeYtNUC54CWTpvbk5m0NTufsurySGk7Feeo=;
        b=t9x7US5NPEk6EgVf7872onw6/+sluKi7CouqCpbJWAPVF5INeQzDoz0gAli5o5n1KA
         QYXtLaOh7lCS8Cy58qNfQHzJ1eEQghm3TN5zPR6dVKijl5FccE7XvF5fmUDhpl79z5VD
         dktz4Gh5lNtYWE5AXgOjJV+SPuhc3WO3AB3lAwTE0HiMHD4dt9OOQG/b0R9JIiK3P8mm
         WS+LUF7QQDjk2kzoHcjlxIjE8+jxSI0zFs2bQxNzVUCbTwdnsEjl2sXW8bywrcsc+ew3
         26W39hHPsdWqhDPnD+6zWzcejUeynuFpwGdXtUOyhylb2E30SZOcfvFEwYvZEu5M726q
         9EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=e0ApdGVnQeYtNUC54CWTpvbk5m0NTufsurySGk7Feeo=;
        b=TXkXSfEKZvj9J0VEUmRmUHMqqBYfuzGCtpJDd8KO4wdqs8b7ChVmbs/JO+pCqxv1Nm
         joa+I3nVs3qMmpqAGP7qqGCm5yBJmS4g4oC0XN+L0hHaPiv96qQCuqUkmpCglo7CeQI1
         H1T/GgRRWPw793s9+4GEAp9Ged3KbZi6qATxMxB63Jvmbl7rHqhy6Idk6Wlk3JJ5Qjdw
         hOffP0DnKnM2oAWoEqKqboeNiAkqfKIOI8Aswhk67Fu6KbWArK4yJok4Ibn7/myNuLVB
         P8nbJ2WBJ/mw/5fJDq/8oTLlQufrI9n8ffF8owtdDhVYalLXqBmO9Rp3rlwEs5Sl0eyN
         lxOQ==
X-Gm-Message-State: AOAM532zBbXiGlvjwGUey89KUTorhsnZ2aWm/NbWd3iXk7TvO7OhP28D
        Pi+PLA8T9MiCTrKNxz9pwP62zseG5+i+O739BckNHGQda28=
X-Google-Smtp-Source: ABdhPJzKSq+ARkcmx7P4HJzIGanXDY/y06NqZmJopXxxR6bUDUYGoOTeejFNQqFGz5q4UFebK+lnzNDGh/Q2bTqKHgE=
X-Received: by 2002:a05:620a:444b:: with SMTP id w11mr3666582qkp.479.1630424762226;
 Tue, 31 Aug 2021 08:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210831231322.7CEA.409509F4@e16-tech.com>
In-Reply-To: <20210831231322.7CEA.409509F4@e16-tech.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 31 Aug 2021 16:45:25 +0100
Message-ID: <CAL3q7H66zc=U65RnqtCZR9m1fncZK9W-hrp=-YKnavatH4V35A@mail.gmail.com>
Subject: Re: btrfs failed to pass xfstests generic/647
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 4:18 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> btrfs failed to pass xfstests generic/647.
>
> xfstests generic/647 is a test case just added
> Author: Andreas Gruenbacher <agruenba@redhat.com>
> Date:   Fri Aug 27 23:02:09 2021 +0200
>
> mmap-rw-fault of xfstests generic/647 seems dead waiting status.
>
> root        7171       1  0 19:52 ?        00:00:13 /bin/bash ./check
> root     3702051    7171  0 21:22 ?        00:00:00   /bin/bash /usr/hpc-=
bio/xfstests/tests/generic/647
> root     3702433 3702051  0 21:22 ?        00:00:00     /usr/hpc-bio/xfst=
ests/src/mmap-rw-fault /mnt/test/mmap-rw-fault.
>
> 'pstack 3702433 ' seems dead waiting too.
>
> we dump the sysrq output to the attachment file(sysrq.generic.647.txt)
>
> reproduce frequency: 100%
> btrfs version: a custom kernel ( 5.13 + most 5.14  + most 5.15)

Yes, it's known.
Though in your traces it's harder to see what's going on, the problem
is the same task attempting to double lock the same file range.
My single trace is much more clear:

[1198893.771117] RIP: 0033:0x7fa457222196
[1198893.771890] Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 44 00 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 e8 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 18 48 89
74 24
[1198893.775303] RSP: 002b:00007ffe7de2f5c8 EFLAGS: 00000246 ORIG_RAX:
00000000000000e8
[1198893.776506] RAX: ffffffffffffffda RBX: 0000556ae9835760 RCX:
00007fa457222196
[1198893.777564] RDX: 000000000000001d RSI: 0000556ae9854240 RDI:
0000000000000004
[1198893.778598] RBP: ffffffffffffffff R08: 0000000000000001 R09:
c670e0d2dd6a31a6
[1198893.779612] R10: 00000000ffffffff R11: 0000000000000246 R12:
0000000000000001
[1198893.780628] R13: 000000000000001d R14: 00007ffe7de2f7c8 R15:
00007ffe7de2f7e0
[1200069.074065] sysrq: Show Blocked State
[1200069.077608] task:mmap-rw-fault   state:D stack:    0 pid:1458360
ppid:1458205 flags:0x00004000
[1200069.083085] Call Trace:
[1200069.085262]  __schedule+0x3bb/0xd40
[1200069.087610]  ? lock_release+0x214/0x470
[1200069.090386]  schedule+0x45/0xe0
[1200069.092550]  wait_extent_bit.constprop.0+0x1c9/0x250 [btrfs]
[1200069.096529]  ? finish_wait+0x90/0x90
[1200069.098458]  lock_extent_bits+0x37/0x90 [btrfs]
[1200069.100615]  btrfs_lock_and_flush_ordered_range+0xa9/0x120 [btrfs]
[1200069.103435]  extent_readahead+0x34d/0x500 [btrfs]
[1200069.105158]  ? lock_release+0x214/0x470
[1200069.106445]  ? lock_acquire+0x1a0/0x3e0
[1200069.107769]  ? trace_hardirqs_on+0x1b/0xf0
[1200069.109044]  ? lock_release+0x214/0x470
[1200069.110208]  ? __add_to_page_cache_locked+0x325/0x470
[1200069.111842]  read_pages+0x91/0x280
[1200069.112921]  ? lru_cache_add+0x12d/0x200
[1200069.113786]  page_cache_ra_unbounded+0x1b2/0x230
[1200069.114832]  ? lock_release+0x214/0x470
[1200069.115782]  filemap_fault+0x909/0xf70
[1200069.116640]  ? lock_acquire+0x1a0/0x3e0
[1200069.117760]  ? lock_release+0x214/0x470
[1200069.118663]  __do_fault+0x36/0x150
[1200069.119370]  __handle_mm_fault+0x856/0x18f0
[1200069.120264]  handle_mm_fault+0x15b/0x430
[1200069.121010]  __get_user_pages+0x32b/0x850
[1200069.121838]  ? mempool_alloc+0x62/0x180
[1200069.122562]  get_user_pages_unlocked+0xcf/0x330
[1200069.123342]  internal_get_user_pages_fast+0xbc5/0xf00
[1200069.124234]  iov_iter_get_pages+0xd4/0x370
[1200069.124916]  bio_iov_iter_get_pages+0x8e/0x4d0
[1200069.125635]  ? lock_release+0x214/0x470
[1200069.126264]  iomap_dio_bio_actor+0x230/0x430
[1200069.126975]  iomap_apply+0x12a/0x4a0
[1200069.127632]  ? iomap_dio_rw+0x30/0x30
[1200069.128188]  __iomap_dio_rw+0x20f/0x5e0
[1200069.128752]  ? iomap_dio_rw+0x30/0x30
[1200069.129289]  ? up_write+0x18/0x160
[1200069.129790]  ? lock_acquire+0x1a0/0x3e0
[1200069.130352]  ? iomap_dio_rw+0xa/0x30
[1200069.130892]  iomap_dio_rw+0xa/0x30
[1200069.131471]  btrfs_file_read_iter+0x10a/0x140 [btrfs]
[1200069.132241]  new_sync_read+0x11b/0x1a0
[1200069.132801]  vfs_read+0x125/0x1b0
[1200069.133246]  ksys_pread64+0x68/0xa0
[1200069.133708]  do_syscall_64+0x33/0x80
[1200069.134181]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[1200069.134943] RIP: 0033:0x7fd1ddba38d6
[1200069.135734] RSP: 002b:00007ffd74e5d398 EFLAGS: 00000246 ORIG_RAX:
0000000000000011
[1200069.136760] RAX: ffffffffffffffda RBX: 0000000000001000 RCX:
00007fd1ddba38d6
[1200069.137684] RDX: 0000000000001000 RSI: 00007fd1ddbb8000 RDI:
0000000000000005
[1200069.138530] RBP: 0000000000001000 R08: 0000000000000005 R09:
0000000000000000
[1200069.139396] R10: 0000000000001000 R11: 0000000000000246 R12:
0000000000000005


>
> [10944.233340] task:mmap-rw-fault   state:D stack:    0 pid:3702433 ppid:=
3702051 flags:0x00000004
> [10944.241900] Call Trace:
> [10944.244339]  __schedule+0x296/0x760
> [10944.247815]  ? finish_wait+0x80/0x80
> [10944.251372]  schedule+0x3c/0xa0
> [10944.254521]  wait_extent_bit.constprop.69+0x13b/0x1c0 [btrfs]
> [10944.260249]  ? finish_wait+0x80/0x80
> [10944.263838]  lock_extent_bits+0x37/0x90 [btrfs]
> [10944.268367]  btrfs_lock_and_flush_ordered_range+0xa6/0x110 [btrfs]
> [10944.274538]  extent_readahead+0x1fd/0x410 [btrfs]
> [10944.279224]  ? xas_store+0x1ad/0x610
> [10944.282787]  ? xas_load+0x8/0x80
> [10944.285999]  ? xa_get_order+0x8a/0xe0
> [10944.289643]  ? __mod_memcg_lruvec_state+0x21/0x100
> [10944.294409]  ? __add_to_page_cache_locked+0x1d9/0x4d0
> [10944.299434]  read_pages+0x8f/0x310
> [10944.302818]  ? xas_load+0x8/0x80
> [10944.306028]  ? xa_load+0x6e/0x90
> [10944.309242]  page_cache_ra_unbounded+0x190/0x250
> [10944.313834]  filemap_fault+0x720/0xb30
> [10944.317567]  ? __alloc_pages_nodemask+0x190/0x370
> [10944.322249]  __do_fault+0x38/0xe0
> [10944.325550]  ? cgroup_throttle_swaprate+0x4c/0x160
> [10944.330319]  do_fault+0xa8/0x490
> [10944.333531]  ? kmem_cache_alloc+0x148/0x270
> [10944.337694]  __handle_mm_fault+0x5e8/0x7c0
> [10944.341768]  handle_mm_fault+0xd0/0x290
> [10944.345588]  exc_page_fault+0x272/0x500
> [10944.349407]  asm_exc_page_fault+0x1e/0x30
>
>
> [10945.459864] task:pstack          state:S stack:    0 pid:3707241 ppid:=
3706920 flags:0x00000000
> [10945.468421] Call Trace:
> [10945.470860]  __schedule+0x296/0x760
> [10945.474331]  schedule+0x3c/0xa0
> [10945.477457]  do_wait+0x1c3/0x220
> [10945.480671]  kernel_wait4+0xa6/0x140
> [10945.484234]  ? __list_del_entry+0x20/0x20
> [10945.488225]  __do_sys_wait4+0x83/0x90
> [10945.491879]  ? do_sigaction+0x9f/0x240
> [10945.495610]  ? _copy_to_user+0x2d/0x40
> [10945.499340]  ? __x64_sys_rt_sigaction+0x7a/0x100
> [10945.503932]  do_syscall_64+0x33/0x40
> [10945.507492]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/08/31
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
