Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA8E5E3C
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJZRq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 13:46:58 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53488 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfJZRq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 13:46:57 -0400
Received: by mail-wm1-f41.google.com with SMTP id n7so5338023wmc.3
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Oct 2019 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fKiNBT4HulVIhF9KxOE8BKMFl3LyZ2DZjMDng8AGosM=;
        b=Cdk8TXdtXkXI3hX7S7f+TgSvBo1XgQT9AdhMuTvkoGVZV3JRKylGvl77ncwRJgcRUU
         w3fq6JrBMbZePJrmajc6RX8LPoY4oa1HwyLsUNNCNW9oFDoP85KNKJ4CJ39db6H6Reo4
         OmtvVnorKYlWK489KKWxv6TUpCPziu3dwcOwvwb8U7AT2fy+X6JCILK6NvsfjVdQPGEH
         0tWoIqVaxeFqF7mDj2ucDgh8PukEw6tuhwHQJhdl1ZpVllhxFhCLU31mWIQ+9052vkN1
         XUU8/zZ/N9JZ6ake/a4INebj0k1RqWh6WvIjNrWuAD43uu9R8wgUGXuDdpgblW1MFyCe
         MvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fKiNBT4HulVIhF9KxOE8BKMFl3LyZ2DZjMDng8AGosM=;
        b=F7fHf8EcNWTm0HnGG3WZD/Q+nNuHtUfZ92e41P+4dq+BzToAyI6a3MmOSHaWXl8/iM
         K2EGd7GDwbd3XSPdlDBjDYwDKRDxSH6RIqB5HvExj1faCoxRxgkXK0r2qmJ/3bk7XOA7
         IbGK8Nuz2+tHakE8Rq0qcrwtT43W/gTbncFSFG/sZllY3hBTnE3uz1my2CAAgs1yLnxw
         pG8u5v1vHq0waliA6cN2w5eWMDkD/kcFwdQp5me/GYFmGSG3CsfuKOGiZS/XQgyOdfAY
         nL2N9fP/727gx5sSrkLmTNvYHGsBmg1nWCtkwB0aWmc3qbpp4ZZKVCY+1Ic4GCyedrqq
         Bczg==
X-Gm-Message-State: APjAAAVwUBihGf8yYlSPP9potIdC5AawNB4oCzOHghgKJr32mFCXjazS
        cyJxqU4qBAHtE++0TV/QpKZyAQQdFVOG3YnpR9BqB8AMOan8oQ==
X-Google-Smtp-Source: APXvYqzazyVEcDAgfSy11JkZzQtHiN6A3hgfogD4u19s/v0Y53YtJxV9DhwhlzdoWefPiYbH1b2tYHIvlJgzazB3C0c=
X-Received: by 2002:a05:600c:2112:: with SMTP id u18mr8269456wml.177.1572112015454;
 Sat, 26 Oct 2019 10:46:55 -0700 (PDT)
MIME-Version: 1.0
From:   Atemu <atemu.main@gmail.com>
Date:   Sat, 26 Oct 2019 19:46:44 +0200
Message-ID: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
Subject: BUG: btrfs send: Kernel's memory usage rises until OOM kernel panic
 after sending ~37GiB
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi linux-btrfs,
after btrfs sending ~37GiB of a snapshot of one of my subvolumes,
btrfs send stalls (`pv` (which I'm piping it through) does not report
any significant throughput anymore) and shortly after, the Kernel's
memory usage starts to rise until it runs OOM and panics.

Here's the tail of dmesg I saved before such a Kernel panic:

https://gist.githubusercontent.com/Atemu/3af591b9fa02efee10303ccaac3b4a85/raw/f27c0c911f4a9839a6e59ed494ff5066c7754e07/btrfs%2520send%2520OOM%2520log

(I cancelled the first btrfs send in this example FYI, that's not part
of nor required for this bug.)

And here's a picture of the screen after the Kernel panic:

https://photos.app.goo.gl/cEj5TA9B5V8eRXsy9

(This was recorded a while back but I am able to repoduce the same bug
on archlinux-2019.10.01-x86_64.iso.)

The snapshot holds ~3.8TiB of data that has been compressed (ZSTD:3)
and heavily deduplicated down to ~1.9TiB.
For deduplication I used `bedup dedup` and `duperemove -x -r -h -A -b
32K ---skip-zeroes --dedupe-options=same,fiemap,noblock` and IIRC it
was mostly done around the time 4.19 and 4.20 were recent.

The Inode that btrfs reports as corrupt towards the end of the dmesg
is a 37GiB 7z archive (size correlates) and can be read without errors
on a live system where the bug hasn't been triggered yet. Since it
happens to be a 7z archive, I can even confirm its integrity with `7z
t`.
A scrub and `btrfs check --check-data-csum` don't detect any errors either.

Please tell me what other information I could provide that might be
useful/necessary for squashing this bug,
Atemu

PS: I could spin up a VM with device mapper snapshots of the drives,
destructive troubleshooting is possible if needed.
