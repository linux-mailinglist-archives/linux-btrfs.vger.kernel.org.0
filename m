Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAAE214B32
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgGEIhp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 04:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEIhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jul 2020 04:37:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82E7C061794
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jul 2020 01:37:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t25so37213824lji.12
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jul 2020 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ginkel.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=OPpWpouD1FpzN/Nb9IHKt29OLde95VBopqBgA0FBD+o=;
        b=TjUtovg/SpI6edE3kzjQyjUhBUJ9rTi7SHk8jp2wzP5iY8QZpbJfHWs2gGb1FnpxtA
         7q7R7Z4qvHvmrK7uRdYjSdnKQ2lajcXlkFyTjeTEuZEGuS8zgHE6D7fa48lpc9hhm8EI
         xnxTkFPOdxjamlU4N6hhq7gN0xwkpncz2ZWzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OPpWpouD1FpzN/Nb9IHKt29OLde95VBopqBgA0FBD+o=;
        b=Kcz0/wIsxCbD4lEEIp11PiXPVVF/hXdqKJmeTY87PJUTfahjCs7z7QwDXwIs4YDgho
         IbyeVzX/4GKW3GCZA7KGsXmhSfPFBCdI3nS1VYTAq5cFfoq5gxlr+0lv/ds55mNjrzoB
         5044gZWGQL51iLTMs/TvhFkuV5EH/IDiOSQtMF3l+YTdHqEobalSkyuQP0XuHGaPxWkK
         IuZp7s4rxShC3+HypKmkmHTLgrPx6LELj7OtQnM20QtLL0MkghBSEILpvP/+Us7XlrCU
         Wa0M8nm0KH0s70iG8jNJcyvyfMdT6eQKQlZsFMEELgCWRa8XoKMyGgT/gUKxU23q0JTF
         fs2A==
X-Gm-Message-State: AOAM53120sYV365XQiFRsEYbAdjxMH7MtGgtx6QC6VDOMI+XZEVkqOhA
        0ErIIwHdp5lGnKAEsW1VscV5RKbb0w8CxX+m+nWPxzRJuMcThQ==
X-Google-Smtp-Source: ABdhPJyOvsIPTE8TanprhciyiF/OlRgoxLxZvNbX5uijEqH7zWy6ZGhRGfv9w7/FA2xsKCWyYuPNHp0bAwXcdmhwP6s=
X-Received: by 2002:a2e:8751:: with SMTP id q17mr18911224ljj.268.1593938262806;
 Sun, 05 Jul 2020 01:37:42 -0700 (PDT)
MIME-Version: 1.0
From:   Thilo-Alexander Ginkel <thilo@ginkel.com>
Date:   Sun, 5 Jul 2020 10:37:27 +0200
Message-ID: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
Subject: Growing number of "invalid tree nritems" errors
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

one of our servers just started producing loads of "BTRFS error
(device dm-0): invalid tree nritems" errors and eventually caught a
hung task (not sure if those are related):

[...]
[126990.493897] BTRFS error (device dm-0): invalid tree nritems,
bytenr=201179545600 nritems=0 expect >0
[127041.504620] BTRFS error (device dm-0): invalid tree nritems,
bytenr=204159336448 nritems=0 expect >0
[127106.733494] BTRFS error (device dm-0): invalid tree nritems,
bytenr=233554296832 nritems=0 expect >0
[127125.504302] BTRFS error (device dm-0): invalid tree nritems,
bytenr=233693298688 nritems=0 expect >0
[127254.512800] BTRFS error (device dm-0): invalid tree nritems,
bytenr=299654774784 nritems=0 expect >0
[127544.739078] BTRFS error (device dm-0): invalid tree nritems,
bytenr=435922501632 nritems=0 expect >0
[127544.739190] BTRFS error (device dm-0): invalid tree nritems,
bytenr=435922714624 nritems=0 expect >0
[...]
[129532.769484] INFO: task kcompactd0:64 blocked for more than 120 seconds.
[129532.769569]       Tainted: G            E    4.15.0-109-generic #110-Ubuntu
[129532.769651] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[129532.769749] kcompactd0      D    0    64      2 0x80000000
[129532.769751] Call Trace:
[129532.769756]  __schedule+0x24e/0x880
[129532.769758]  schedule+0x2c/0x80
[129532.769759]  io_schedule+0x16/0x40
[129532.769761]  __lock_page+0xff/0x140
[129532.769763]  ? page_cache_tree_insert+0xe0/0xe0
[129532.769765]  migrate_pages+0x91f/0xb80
[129532.769766]  ? __ClearPageMovable+0x10/0x10
[129532.769768]  ? isolate_freepages_block+0x3b0/0x3b0
[129532.769769]  compact_zone+0x681/0x950
[129532.769770]  kcompactd_do_work+0xfe/0x2a0
[129532.769772]  ? __switch_to_asm+0x35/0x70
[129532.769773]  ? __switch_to_asm+0x41/0x70
[129532.769774]  kcompactd+0x86/0x1c0
[129532.769775]  ? kcompactd+0x86/0x1c0
[129532.769778]  ? wait_woken+0x80/0x80
[129532.769780]  kthread+0x121/0x140
[129532.769781]  ? kcompactd_do_work+0x2a0/0x2a0
[129532.769782]  ? kthread_create_worker_on_cpu+0x70/0x70
[129532.769783]  ret_from_fork+0x35/0x40

I took the server offline and ran `btrfs check`, which did not bring
up any errors:

# btrfs check -p --check-data-csum /dev/mapper/luks
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks
UUID: b5872f47-c87e-47ac-b036-4f2725cf6dc6
[1/7] checking root items                      (0:00:20 elapsed,
12381226 items checked)
[2/7] checking extents                         (0:05:38 elapsed,
5163753 items checked)
[3/7] checking free space cache                (0:00:12 elapsed, 376
items checked)
[4/7] checking fs roots                        (0:41:33 elapsed,
5021296 items checked)
[5/7] checking csums against data              (0:05:35 elapsed,
3911047 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 28110
items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 292229652480 bytes used, no error found
total csum bytes: 200196548
total tree bytes: 84142292992
total fs tree bytes: 82578096128
total extent tree bytes: 1175896064
btree space waste bytes: 24570610642
file data blocks allocated: 245858725888
 referenced 202896068608

I will be running memtester to make sure the problems are not RAM-related.

Any ideas?

Thanks,
Thilo
