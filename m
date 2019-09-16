Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606E4B4055
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390404AbfIPSbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 14:31:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37869 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPSbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 14:31:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so434821pfo.4
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WTCu+B1CTdUoZ2//J2bs5oayu+nwJLF0PrfvHpM+uw=;
        b=MoU2rHLJu5pp93mDBRdsHY630c6xzwU2RjzgZvW1/lXswghS38WI5zDKKNI8w+28fV
         zJMm2KXm3K6tIxQFJyMCyMMJ2+Y6zkJkAz2MwUjXpA9clA+9wQ0RzLMYLC68Nu02KioI
         dUEjaphpGlIuhI+RpLprjV+MEkegIze1mVaYW38PsyWGf77oLdlc2b81pSSvUW3wOUaB
         mFaDdtdIvw8jyf/MDkfVmG08JphgoYgR9JH8jCUKsiifTQvMDA7UGLCdU8OFvmYwNmL8
         SoJafIrs2dwfEUFIt6L1VNsr9kQ571d1OMIElwran7KfhPLiex0qC3aF7/jjGc5k+QjG
         EZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WTCu+B1CTdUoZ2//J2bs5oayu+nwJLF0PrfvHpM+uw=;
        b=QBElkr3y52duqq6utxNGcFRIqG2Z14ckxpDENmCkldzeIQsNsRUyZqc/MfL6Y6aZuS
         XAbLZ06Ov9QcDElr0Qb9IMYxKH341JEtq7WaPGHKMZ84xD4wu5E3/fUnbsAqqCR/+hGx
         OtJIUJZRXa9N9qRQqLKKaLDpsIXFTgm69iuRJ5W7GwOOXlTw75rTZC1yasyL1ZSsMmdh
         jqUBgGbsjl9g5VNCMtY+R+XZhBA8ZuGL4Z3e9q1fqQZLCdCCFusE5UN79WWi7czCYT9f
         jLH21gfa30TrY62EyUlp0Fxmvgj4uLPTSBb8iDUp3OKyA/w15WLQHt+hIOwJ5WJ0S3Bz
         e3dQ==
X-Gm-Message-State: APjAAAUJFhdQPvdEBaT0BwjIWSqchJxG2uxaODX6a0YZIuFjkI4D0ThT
        moE0cLCldLwFf+oLBrEi5awgW5or69A=
X-Google-Smtp-Source: APXvYqxN92cRazqou1DPdbYLhjgNfAA47/ZauzzIR4DCm54FSxAAjr+1OctHF5fvEqiUkG8GOBDwPw==
X-Received: by 2002:a17:90a:284c:: with SMTP id p12mr582897pjf.87.1568658668745;
        Mon, 16 Sep 2019 11:31:08 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:d0da])
        by smtp.gmail.com with ESMTPSA id i7sm24231385pfd.126.2019.09.16.11.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:31:07 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/7] btrfs: workqueue fixes+cleanups
Date:   Mon, 16 Sep 2019 11:30:51 -0700
Message-Id: <cover.1568658527.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

This series fixes a few issues with Btrfs' use of workqueues.

The bulk of this series fixes multiple cases of the same bug: a work
item shouldn't be freed while it potentially depends on any other work
items. Currently, we've mostly been side-stepping this issue by having
different work functions for different work types (see commit
9e0af2376434 ("Btrfs: fix task hang under heavy compressed write").
However, there are cases where a work function can depend on itself,
usually through stacked filesystems (e.g., loop devices).

Patch 1 is a trivial cleanup.

Patches 2-5 fix all of the cases of this bug that I could find. Patch 2
is the ordered_free fix I previously sent [1], now with an updated title
and Josef's fix [2] folded in. Patch 3 fixes the deadlock reported with
my previous cleanup, and patches 4 and 5 fix similar issues.

With all of those fixed, patch 6 is my previous cleanup [3] to get rid
of the different work functions. Patch 7 is the same cleanup [4] as from
before.

Based on misc-next.

Thanks!

1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/
2: https://lore.kernel.org/linux-btrfs/20190821151803.cuyq2yzpdnwgwrmb@MacBook-Pro-91.local/
3: https://lore.kernel.org/linux-btrfs/afaf532af471dd1a8a1f4af9de570127529323b0.1565717248.git.osandov@fb.com/
4: https://lore.kernel.org/linux-btrfs/d4fa1870ffce027ada265a67f4e00d397b683241.1565717248.git.osandov@fb.com/

Omar Sandoval (7):
  btrfs: get rid of unnecessary memset() of work item
  btrfs: don't prematurely free work in run_ordered_work()
  btrfs: don't prematurely free work in end_workqueue_fn()
  btrfs: don't prematurely free work in reada_start_machine_worker()
  btrfs: don't prematurely free work in scrub_missing_raid56_worker()
  btrfs: get rid of unique workqueue helper functions
  btrfs: get rid of pointless wtag variable in async-thread.c

 fs/btrfs/async-thread.c      | 107 +++++++++++++++++------------------
 fs/btrfs/async-thread.h      |  33 +----------
 fs/btrfs/block-group.c       |   3 +-
 fs/btrfs/delayed-inode.c     |   4 +-
 fs/btrfs/disk-io.c           |  36 ++++--------
 fs/btrfs/inode.c             |  36 ++++--------
 fs/btrfs/ordered-data.c      |   1 -
 fs/btrfs/qgroup.c            |   3 -
 fs/btrfs/raid56.c            |   5 +-
 fs/btrfs/reada.c             |  13 ++---
 fs/btrfs/scrub.c             |  17 +++---
 fs/btrfs/volumes.c           |   3 +-
 include/trace/events/btrfs.h |   6 +-
 13 files changed, 97 insertions(+), 170 deletions(-)

-- 
2.23.0

