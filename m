Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8434BA95
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhC1D4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Mar 2021 23:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhC1D4d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Mar 2021 23:56:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04205C0613B1
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 20:56:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g20so4893095wmk.3
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=RtfKCENKJZSuZxWoclJxmBmFSiYvzqBYl7k22yYRzi4=;
        b=c0gVvQNVY89jmoKVBAdnn2gmommk2y7oZ13y/Y6zFKNtg1YFzVnR4IoDbgr7e0nGBL
         d1Yhh6L3hzFGNIKPF486+lzhjyxEgE2HcLBJB1E53HfofMFUIwlXR6mB7jBGk291AkRe
         YjTiABMo8mvvKXSOWTu62+miXRlYaqEtiaBbZHY9NYbO8GNdB7VLVSIt5M8Wuy9IW4TR
         xVZUGbGH8GjBNudqVGnI2w9SyOV9yqFXdJ9D0LeQ22TM+QXoojFxen70LZjPhOhZue7b
         n2sEvZ+u/1Zpnq10fvEbsWv9iqhQVay+lOMqRBnJLl3wrmu7iMz1NpVRLnutd22fPzcd
         fWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RtfKCENKJZSuZxWoclJxmBmFSiYvzqBYl7k22yYRzi4=;
        b=hoM7xI2YzAM9jiiAT8qxvHB+VRsoEz4NqP+2XG7m2AFMj2K2gVo8ySojWeCIUxS1Pe
         SnrF3Jg91RhdQtb3voW3+2dYA/Wn6Uf1FDdQJubkN7UZRL8d0jexYaYsGJJwF9Fn7MYm
         iUyMMKN81EsbMmBE9gUhIrLuvvvVVZTiAjpXAIUguM0Di0ntzmmL4pt5OEmY8WSHZXlN
         snqEfLaALYs4CQr4lDhoMIZ/sPzdIHFttWZJW8A8fvJFJjfIVQWpJuctc8+NbAYbWh6Y
         yN9RcgUZDtVrjs4WbLAn4PuzdInlSNC8hnErCgect6wYRQzS5WDbEOQokhdlVy6KbQbL
         UrdQ==
X-Gm-Message-State: AOAM530C49ys/iZL2gcub+yzl6svBG4KOyQX6KSsUKVQuzPDMVQ5hlRd
        OKBX9IJlVnZgMGkAq1Mp6sD52qxLFIUMC/5BKK38FHZchGHeQVS7
X-Google-Smtp-Source: ABdhPJwzTdBSiuwCUOg/RXlcD+TdFjFYrjX1asIUK4mo0YNVd4vD+C0ob6/QvKG1kAud5wYvm17H9jLwXb6ehqj6wEE=
X-Received: by 2002:a05:600c:acf:: with SMTP id c15mr19576647wmr.124.1616903790208;
 Sat, 27 Mar 2021 20:56:30 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 27 Mar 2021 21:56:14 -0600
Message-ID: <CAJCQCtTv-xmDgRtoZFgmz=ny+SFYiTXqJS05VdRfkbST0L-ijQ@mail.gmail.com>
Subject: 5.12-rc4: rm directory hangs for > 1m on an idle system
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

5.12.0-0.rc4.175.fc35.x86_64+debug

/dev/sdb1 on /srv/extra type btrfs
(rw,relatime,seclabel,compress=zstd:1,space_cache=v2,subvolid=5,subvol=/)

The directories being deleted are on a separate drive (HDD) from /
(SSD). It's an unpacked Firefox source tarball, ~2.7G. I had two
separate copies, so the rm command was merely:

rm -rf firefox1 firefox2

And that command did not return to a prompt for over a minute, with no
disk activity all, on an otherwise idle laptop. sysrq+w shows nothing,
sysrq+t shows some things.


[ 9638.375968] kernel: task:rm              state:R  running task
stack:13176 pid: 2275 ppid:  1892 flags:0x00000000
[ 9638.375986] kernel: Call Trace:
[ 9638.375998] kernel:  ? __lock_acquire+0x3ac/0x1e10
[ 9638.376014] kernel:  ? __lock_acquire+0x3ac/0x1e10
[ 9638.376036] kernel:  ? lock_acquire+0xc2/0x3a0
[ 9638.376051] kernel:  ? lock_acquire+0xc2/0x3a0
[ 9638.376069] kernel:  ? lock_acquire+0xc2/0x3a0
[ 9638.376081] kernel:  ? lock_is_held_type+0xa7/0x120
[ 9638.376090] kernel:  ? rcu_read_lock_sched_held+0x3f/0x80
[ 9638.376099] kernel:  ? __btrfs_tree_lock+0x27/0x120
[ 9638.376111] kernel:  ? __clear_extent_bit+0x274/0x560
[ 9638.376120] kernel:  ? _raw_spin_lock_irqsave+0x67/0x90
[ 9638.376139] kernel:  ? __lock_acquire+0x3ac/0x1e10
[ 9638.376153] kernel:  ? lock_acquire+0xc2/0x3a0
[ 9638.376161] kernel:  ? __lock_acquire+0x3ac/0x1e10
[ 9638.376189] kernel:  ? lock_is_held_type+0xa7/0x120
[ 9638.376208] kernel:  ? release_extent_buffer+0xa3/0xe0
[ 9638.376224] kernel:  ? btrfs_update_root_times+0x2a/0x60
[ 9638.376237] kernel:  ? btrfs_insert_orphan_item+0x62/0x80
[ 9638.376246] kernel:  ? _atomic_dec_and_lock+0x31/0x50
[ 9638.376264] kernel:  ? btrfs_evict_inode+0x16b/0x4e0
[ 9638.376273] kernel:  ? btrfs_evict_inode+0x370/0x4e0
[ 9638.376293] kernel:  ? evict+0xcf/0x1d0
[ 9638.376305] kernel:  ? do_unlinkat+0x1b2/0x2c0
[ 9638.376329] kernel:  ? do_syscall_64+0x33/0x40
[ 9638.376338] kernel:  ? entry_SYSCALL_64_after_hwframe+0x44/0xae

The entire dmesg is here:
https://drive.google.com/file/d/1gyyp59Ju1aRIz3FCZU-kmu05-W1NN89A/view?usp=sharing

It isn't nearly as bad deleting one directory at once ~15s.

-- 
Chris Murphy
