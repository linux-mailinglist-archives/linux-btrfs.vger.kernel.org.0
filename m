Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51094417B01
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 20:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbhIXS1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbhIXS1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 14:27:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE321C061613
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Sep 2021 11:26:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y28so43417529lfb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Sep 2021 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1s34Yqgb4ItEzSJ7Owz/ybF6gtvrc1C9hGd3WAquWp0=;
        b=BGwHbdU/eqPQjpdOrhpUm9O0kcR+8xJygPrDbfTww30htHLZKuDWkb0JouMzyI7+gd
         XBL+JIfe6Sa+gM1x8uy6Fu0ANIuTsewyJes93fbcmEdotSO+YJngnyEr2uwYM/73RzAm
         cdavK21D+q345og/fFkhQRTDqkuyBrlBQHbOe5jXDwLi5Eh0ual4+yQEAAUCC+bk8XiJ
         bzkd6GFto4ZpL4fsgn1BSk7ry6kDIlUMucDEbJfwnmE47Ilg5fJxIeS4fVshxeHtEFlm
         8cpI1nWjLhF/xjdL5mIEyRZg1YFx6+adWV6WhxJS1cNuQ1ZK9DzF/xmMRTjQTM62Cg12
         7CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1s34Yqgb4ItEzSJ7Owz/ybF6gtvrc1C9hGd3WAquWp0=;
        b=l9CgLb3fKBjl3Be87d+EkLZ6yZYV+nUo3pWFjs3NwlCJP2IXHStKPtO89uyVyeCICy
         i7cVFSBpP+CD6KoRFz2Vi5i3337w3yB/6qAYrW+4B18WI5Ba+rsheaHF92JUisE9odoL
         7FrJBkw3Jf6qqcHkMlcYcP6Y4VH4GnFOonaHNHrtI6T5vaUWm4gc8pIU6S7rN8EpbHz/
         OSBRop/P2WY1wEUxEisLNs0cyJot8BaKfMpHMSXXfPYp/chIUi/ZKhvM7d8Jw3vFYjAV
         x90oEpwSNS1Mzzu0yS3bcDi0AKXq/jZ9c/g/rtPKB4N3xJIzEdjst+LQ3K0VgTZfRgfd
         S5Dg==
X-Gm-Message-State: AOAM533IBwtQ6DJfLw4Zin5X8i3SHRtEN2NpUlIKfAu1YDCbLkyL4rR8
        MTDkA5HnHIUnlH/IFoDB4SQLeAtJLTwcHkV6AzraMMZ7fZU=
X-Google-Smtp-Source: ABdhPJzw5I8/XDqLBM77CdKSAJX1RWwswvYHcvVjsqhtPowK0TE422uVFs7nfa7K9hSAAV7f2RscnMMud5fBisOWau4=
X-Received: by 2002:ac2:4ecc:: with SMTP id p12mr10747479lfr.375.1632507969907;
 Fri, 24 Sep 2021 11:26:09 -0700 (PDT)
MIME-Version: 1.0
From:   Sven Oehme <oehmes@gmail.com>
Date:   Fri, 24 Sep 2021 12:25:59 -0600
Message-ID: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
Subject: Host managed SMR drive issue
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

i am running into issues with Host Managed SMR drive testing. when i
try to copy or move a file to the btrfs filesystem it just hangs. i
tried multiple 5.12,5.13 as well as 5.14 all the way to 5.14.6 but the
issue still persists.

here is the setup :

I am using btrfs-progs-v5.14.1
device is a  Host Managed WDC  20TB SMR drive with firmware level C421
its connected via a HBA 9400-8i Tri-Mode Storage Adapter , latest 20.0 FW
I am using the /dev/sd device direct  , no lvm or device mapper or
anything else in between

after a few seconds, sometimes minutes data rate to the drive drops to
0 and 1 or 2 cores on my system show 100% IO wait time, but no longer
make any progress

the process in question has the following stack :

[ 2168.589160] task:mv              state:D stack:    0 pid: 3814
ppid:  3679 flags:0x00004000
[ 2168.589162] Call Trace:
[ 2168.589163]  __schedule+0x2fa/0x910
[ 2168.589166]  schedule+0x4f/0xc0
[ 2168.589168]  schedule_timeout+0x8a/0x140
[ 2168.589171]  ? __bpf_trace_tick_stop+0x10/0x10
[ 2168.589173]  io_schedule_timeout+0x51/0x80
[ 2168.589176]  balance_dirty_pages+0x2fa/0xe30
[ 2168.589179]  ? __mod_lruvec_state+0x3a/0x50
[ 2168.589182]  balance_dirty_pages_ratelimited+0x2f9/0x3c0
[ 2168.589185]  btrfs_buffered_write+0x58e/0x7e0 [btrfs]
[ 2168.589226]  btrfs_file_write_iter+0x138/0x3e0 [btrfs]
[ 2168.589260]  ? ext4_file_read_iter+0x5b/0x180
[ 2168.589262]  new_sync_write+0x114/0x1a0
[ 2168.589265]  vfs_write+0x1c5/0x260
[ 2168.589267]  ksys_write+0x67/0xe0
[ 2168.589270]  __x64_sys_write+0x1a/0x20
[ 2168.589272]  do_syscall_64+0x40/0xb0
[ 2168.589275]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2168.589277] RIP: 0033:0x7ffff7e91c27
[ 2168.589278] RSP: 002b:00007fffffffdc48 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 2168.589280] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ffff7e91c27
[ 2168.589281] RDX: 0000000000020000 RSI: 00007ffff79bd000 RDI: 0000000000000004
[ 2168.589282] RBP: 00007ffff79bd000 R08: 0000000000000000 R09: 0000000000000000
[ 2168.589283] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000004
[ 2168.589284] R13: 0000000000000004 R14: 00007ffff79bd000 R15: 0000000000020000

and shows up under runnable tasks :

[ 2168.593562] runnable tasks:
[ 2168.593562]  S            task   PID         tree-key  switches
prio     wait-time             sum-exec        sum-sleep
[ 2168.593563] -------------------------------------------------------------------------------------------------------------
[ 2168.593565]  S        cpuhp/13    92     88923.802487        19
120         0.000000         0.292061         0.000000 2 0 /
[ 2168.593571]  S  idle_inject/13    93       -11.997255         3
49         0.000000         0.005480         0.000000 2 0 /
[ 2168.593577]  S    migration/13    94       814.287531       551
0         0.000000      1015.550514         0.000000 2 0 /
[ 2168.593582]  S    ksoftirqd/13    95     88762.317130        44
120         0.000000         1.940252         0.000000 2 0 /
[ 2168.593588]  I    kworker/13:0    96        -9.031157         5
120         0.000000         0.017423         0.000000 2 0 /
[ 2168.593593]  I   kworker/13:0H    97      3570.961886         5
100         0.000000         0.034345         0.000000 2 0 /
[ 2168.593603]  I    kworker/13:1   400    101650.731913       578
120         0.000000        10.110898         0.000000 2 0 /
[ 2168.593611]  I   kworker/13:1H  1015    101649.600698        65
100         0.000000         1.443300         0.000000 2 0 /
[ 2168.593618]  S           loop3  1994     99133.655903        70
100         0.000000         1.137468         0.000000 2 0 /
[ 2168.593625]  S           snapd  3161        15.296181       166
120         0.000000        90.296991         0.000000 2 0
/system.slice/snapd.service
[ 2168.593631]  S           snapd  3198        10.047573        49
120         0.000000         5.646247         0.000000 2 0
/system.slice/snapd.service
[ 2168.593639]  S            java  2446       970.743682       301
120         0.000000       101.648659         0.000000 2 0
/system.slice/stor_tomcat.service
[ 2168.593645]  S C1 CompilerThre  2573      1033.157689      3636
120         0.000000       615.256247         0.000000 2 0
/system.slice/stor_tomcat.service
[ 2168.593654]  D              mv  3814      2263.816953    186734
120         0.000000     30087.917319         0.000000 2 0 /user.slice

any idea what is going on and how to fix this ?

thx.
