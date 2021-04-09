Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0306735A850
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhDIVWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 17:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhDIVWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 17:22:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA809C061762
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Apr 2021 14:22:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g66-20020a1c39450000b0290125d187ba22so3133792wma.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Apr 2021 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=yQcMlbX1xFRu62NN0xJ0pmiAEFfjaHa6VJpCeKlAU8E=;
        b=J0ddfIYWNYEc0+uHkPmsCO4q37WRoX6CNKbPkbfUdpe+cHkSa3wzSgujtyP5Do4Tbw
         0GIF4fWqjNjBrsDf97YAuV55unMKYSZCAUKszJl/pLcjYVuFNMUVLapcAYZ1Uye+s710
         2n519ZUqtnTQFUJnsIBOkXKsdwemps6rcLAhtEK+GS5RIyWUfaYNVPwwyuSNFNkA45vC
         VtlMpoTa+tU6ZTOqSPwiAS44ZaN46I1mRklZFezjFsBRGlQrO3toDauuuOvHi0VxIWXx
         hiCvn2Vi3NDAukps+aZVf0aIe0NELjtALfQQ3VGQx6uuRZ4w22ihp8jq0unXanSsKg9B
         mS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yQcMlbX1xFRu62NN0xJ0pmiAEFfjaHa6VJpCeKlAU8E=;
        b=bZ9ExD3UXW/ObuVTkpE7UKtp0bqpYVFqRgnv2srYI1uT2ZtZEVDylarc3ukvTqR4Te
         G7KiB99/1ypFfhCXmnH0/8iMUq0+0rYAXpxRbVAI0Ol1Av0H27oDaLndMWqgNwGSV8bD
         +EoVHjIDjSCmA5dCL6QD0uDAZwXvXE6ZGbkYo3GX6+Q7z51is+G7LiSn7nz70bC+0vnH
         flsm+oiE/rtUIwGR/7nb0h4WYixROd4NDHfbWlKywb95yNKBN4PC6n6aaPjqR2+pI+T5
         dngWYfTyBqlx6i7NmRAUBjiFDBZw6nPAUscXlW9rBFfDr0qOzPb7tusOMQfMGQJsfx12
         rVjA==
X-Gm-Message-State: AOAM533xd1AxTWNOaupPz9/0WsWWNk6YvoVETH3q7nGtUETPe2jEiAZp
        7FdDjzA+fxtuxHj3LWuj2ZlHPeln6DtQI1m8gkaG6s2tqctln7nN
X-Google-Smtp-Source: ABdhPJzOYispRQSW97VrAFCBbKdAXyHmycjE4ZpYlN84d3FMMUB2WsMLpbS7o7x9IQlC4R54y2beDq9fR/H53futIL0=
X-Received: by 2002:a05:600c:3650:: with SMTP id y16mr15592891wmq.182.1618003359376;
 Fri, 09 Apr 2021 14:22:39 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 9 Apr 2021 15:22:23 -0600
Message-ID: <CAJCQCtSWCgAFjmo9keNFRPJomQenQCQOHOZ-gyekoma0fKttxg@mail.gmail.com>
Subject: 5.12-rc6 splat, MAX_LOCKDEP_CHAIN_HLOCKS too low, Workqueue:
 btrfs-delalloc btrfs_work_helper
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Got this while building bolt in a podman container. I've got reproduce
steps and test files here
https://bugzilla.redhat.com/show_bug.cgi?id=1948054


[ 3229.119497] overlayfs: upper fs does not support xattr, falling
back to index=off and metacopy=off.
[ 3229.155339] overlayfs: upper fs does not support xattr, falling
back to index=off and metacopy=off.
[ 3238.380647] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[ 3238.380654] turning off the locking correctness validator.
[ 3238.380656] Please attach the output of /proc/lock_stat to the bug report
[ 3238.380657] CPU: 4 PID: 9115 Comm: kworker/u16:20 Not tainted
5.12.0-0.rc6.184.fc35.x86_64+debug #1
[ 3238.380660] Hardware name: Apple Inc.
MacBookPro8,2/Mac-94245A3940C91C80, BIOS
MBP81.88Z.0050.B00.1804101331 04/10/18
[ 3238.380663] Workqueue: btrfs-delalloc btrfs_work_helper
[ 3238.380670] Call Trace:
[ 3238.380674]  dump_stack+0x7f/0xa1
[ 3238.380680]  __lock_acquire.cold+0x1a9/0x2bf
[ 3238.380686]  ? __lock_acquire+0x3ac/0x1e10
[ 3238.380691]  lock_acquire+0xc4/0x3a0
[ 3238.380695]  ? percpu_counter_add_batch+0x45/0x60
[ 3238.380699]  ? lock_acquire+0xc4/0x3a0
[ 3238.380702]  ? lock_is_held_type+0xa7/0x120
[ 3238.380706]  ? __set_page_dirty_nobuffers+0x6b/0x1e0
[ 3238.380711]  _raw_spin_lock_irqsave+0x4d/0x90
[ 3238.380715]  ? percpu_counter_add_batch+0x45/0x60
[ 3238.380718]  percpu_counter_add_batch+0x45/0x60
[ 3238.380721]  account_page_dirtied+0x102/0x320
[ 3238.380724]  __set_page_dirty_nobuffers+0xa2/0x1e0
[ 3238.380727]  set_extent_buffer_dirty+0x63/0x80
[ 3238.380732]  btrfs_mark_buffer_dirty+0x60/0x80
[ 3238.380737]  copy_for_split+0x29e/0x360
[ 3238.380741]  split_leaf+0x1c2/0x5e0
[ 3238.380746]  btrfs_search_slot+0x99a/0x9f0
[ 3238.380751]  btrfs_insert_empty_items+0x58/0xa0
[ 3238.380754]  cow_file_range_inline.constprop.0+0x1cf/0x760
[ 3238.380758]  ? __local_bh_enable_ip+0x82/0xd0
[ 3238.380762]  ? zstd_put_workspace+0x82/0x160
[ 3238.380765]  ? __local_bh_enable_ip+0x82/0xd0
[ 3238.380769]  compress_file_range+0x471/0x830
[ 3238.380774]  async_cow_start+0x12/0x30
[ 3238.380777]  ? submit_compressed_extents+0x410/0x410
[ 3238.380779]  btrfs_work_helper+0x105/0x400
[ 3238.380782]  ? lock_is_held_type+0xa7/0x120
[ 3238.380786]  process_one_work+0x2b0/0x5e0
[ 3238.380791]  worker_thread+0x55/0x3c0
[ 3238.380793]  ? process_one_work+0x5e0/0x5e0
[ 3238.380796]  kthread+0x13a/0x150
[ 3238.380799]  ? __kthread_bind_mask+0x60/0x60
[ 3238.380801]  ret_from_fork+0x1f/0x30

The /proc/lock_stat is in the downstream bug as an attachment. There's
possibly three things going on here, the bogus overlayfs warning, the
lockdep bug, and the call trace with btrfs bits in it. No idea if they
are related.
