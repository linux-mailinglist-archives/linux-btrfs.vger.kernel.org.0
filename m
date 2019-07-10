Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683CE64CCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfGJT2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 15:28:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45169 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJT2X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 15:28:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so1691304plr.12;
        Wed, 10 Jul 2019 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CpMUxXYROfvhBoXBWchsYgi/GL+ZYe3ofBF371/+9jo=;
        b=lx/oCtKy/5MvXaUgXoDIwJYizVVpoBeqjISK7vsQbdLE33zb2r4sqotNdJ/koXxU9H
         XFtrW9Xsjo/gN6EGemAuOVexvQLGsKEIzEaiqwapR1wPqRdowaFWfy7M0WTh2tb8AbCA
         FwuanQXmwF8Eyfu+wZ67Re5mLHttjACgYbqyXcmrimB1ViHg3jTrdIw5GywewC0mYCWH
         VW4gfgyZczGbUOtfx6zlKC7AoG7ROSVVaZG0URMfZfTQwNn3MrGnkbX56j168SIntrnC
         djmemCFMHjVZh4eeaTwhxJachILWcG1U/LTloCRiMoyJWAEwVunTL6LolAgj+1QxepDO
         spgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CpMUxXYROfvhBoXBWchsYgi/GL+ZYe3ofBF371/+9jo=;
        b=nkgiW4Xwe17IlysrFXXgv1eqKwxAeAP3cHf0k6hFQxrvBoeYBsvYG+NWvTdf/EWUWx
         N9n58SMyy55sJ6vUxKXyOihRmeS5VLZh/eoTC83v7fb2qAAyIOZjOsJWXB2xAedcg7+A
         3AxZwH7ipEuCrzVTck+rPtVJDYM5kteMjw4kDEiMo77lWENR+zdKgzQ/0/1f4lmuAtph
         m6IwkSDLVYbulaOWjdQDBk3yUtmZME6b4N8/q5X/CtfOkzs8/bF6PgWliq8u2IxdtD+m
         lLDBulKVyKUIT6PDT5qlV2gKTsGj3AeFreVEaFshSnNI9OmyQoVd+cnh64HxwQPW3K5x
         fScg==
X-Gm-Message-State: APjAAAWv5lO8hovBg5ynbvgAJkY2QgLy/bhBbtzAUcgQzTm6739/FAlz
        RAPeAA6xnPjB0IRzZNYHV0EK1xV/C/Q=
X-Google-Smtp-Source: APXvYqyVo7fUxbfdp2PB/TDEcvULVtT5PZytfZiXey3deyz+uJlP8ejxl60X+h7N1jJfUHuGiUnP/w==
X-Received: by 2002:a17:902:b68f:: with SMTP id c15mr40153806pls.104.1562786902275;
        Wed, 10 Jul 2019 12:28:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id f64sm3103555pfa.115.2019.07.10.12.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:28:21 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     josef@toxicpanda.com, clm@fb.com, dsterba@suse.com
Cc:     axboe@kernel.dk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCHSET v3 btrfs/for-next] btrfs: fix cgroup writeback support
Date:   Wed, 10 Jul 2019 12:28:13 -0700
Message-Id: <20190710192818.1069475-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This patchset contains only the btrfs part of the following patchset.

  [1] [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback support

The block part has already been applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/ for-linus

with some naming changes.  This patchset has been updated accordingly.

When writeback is executed asynchronously (e.g. for compression), bios
are bounced to and issued by worker pool shared by all cgroups.  This
leads to significant priority inversions when cgroup IO control is in
use - IOs for a low priority cgroup can tie down the workers forcing
higher priority IOs to wait behind them.

This patchset updates btrfs to issue async IOs through the new bio
punt mechanism.  A bio tagged with REQ_CGROUP_PUNT flag is bounced to
the asynchronous issue context of the associated blkcg on
bio_submit().  As the bios are issued from per-blkcg work items,
there's no concern for priority inversions and it doesn't require
invasive changes to the filesystems.

This patchset contains the following 5 patches.

 0001-Btrfs-stop-using-btrfs_schedule_bio.patch
 0002-Btrfs-delete-the-entire-async-bio-submission-framewo.patch
 0003-Btrfs-only-associate-the-locked-page-with-one-async_.patch
 0004-Btrfs-use-REQ_CGROUP_PUNT-for-worker-thread-submitte.patch
 0005-Btrfs-extent_write_locked_range-should-attach-inode-.patch

The patches are also available in the following branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-btrfs-cgroup-updates-v3

Thanks, diffstat follows.

 fs/btrfs/compression.c |   16 ++
 fs/btrfs/compression.h |    3 
 fs/btrfs/ctree.h       |    1 
 fs/btrfs/disk-io.c     |   25 +---
 fs/btrfs/extent_io.c   |   15 +-
 fs/btrfs/inode.c       |   62 +++++++++--
 fs/btrfs/super.c       |    1 
 fs/btrfs/volumes.c     |  264 -------------------------------------------------
 fs/btrfs/volumes.h     |   10 -
 9 files changed, 90 insertions(+), 307 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20190615182453.843275-1-tj@kernel.org

