Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A81958BDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfF0Uj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 16:39:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44145 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfF0Uj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 16:39:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id p144so2943227qke.11;
        Thu, 27 Jun 2019 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ybck1vLhDov0MKKyXsh2jg2LPJRwZCrCeuFa0yt4DYI=;
        b=ag2Gs+LKLeevpy56TTxF85ajtVkLQYNbia84gmoW0Xuzlw4/APmVDwv4Hy1Gkyq1XU
         LgNQ415ZKRlP3PBfVzD1RgBIF8JMG03sjAK1wB5Nr/9WWfYw07ArtOxAYbvySBUNmtaq
         GR0TPqUYsphdbw3IrJv7hg7XRHno0rimqodWnDvrm8/BU8mHzv2g44oaznOdxCgqJ2Je
         6rIr5FOdo8Mv9oJt+LRjoj014nnoGVp62H4Fg/qaRSXywxUoi+ux7HO2QUj5YDbGI/JZ
         ldQFlaqI9ZwBoZsXebY6TGjAJNrXqJtzyonUJQKmdVnDq41M8eNRbpcvcUAS4BEPGc2P
         2Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ybck1vLhDov0MKKyXsh2jg2LPJRwZCrCeuFa0yt4DYI=;
        b=WRXShxyPID1fRmDUJhgyJVJhm+zVzZ2T+dlrzTS27A/c5eoNeTI/Ayj/rTlM3KNgfm
         37vyZDBaF/pizSXdWJb+Nc+8o9//xtLYCge5F+vUFpV4yhxZTgTdcDjCoxmB2rQa1jvL
         C+zeXZ5R6zupZW/9ASsdWmPmjw9X1NqhHg7BswjK3lAzBtfyyEF28ALTFvtVQ3GsTr5A
         4Vf2kEIS17gfTX+/KFURNQXc/Q90ZQoOpVqmVzseTbwUYKOcFe2xuG+VKdlN0ej1MxLZ
         pUW7D/nIVJJYVynEtwL5pCCuZPN+idPs+JKm9RJDUWGo5xucWX3BSoKL+lSVM/5FZINf
         pEUg==
X-Gm-Message-State: APjAAAX36uDVNC8ruTajkplLl0nBl5h6RGTOZlodRbbVFsjPoB1j2Sgt
        ktInr0vy+1CBX8PHmks0SVOQluIF
X-Google-Smtp-Source: APXvYqxdspLa8CegnseSDgRCl+19jBVOk9zvGOA3kE9jB7Cc2EeAbkWGAOXU8jFOKdyHtNKYJRVPPw==
X-Received: by 2002:a37:b87:: with SMTP id 129mr5171858qkl.132.1561667995759;
        Thu, 27 Jun 2019 13:39:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5a51])
        by smtp.gmail.com with ESMTPSA id 123sm67372qkh.113.2019.06.27.13.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 13:39:55 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     jack@suse.cz, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCHSET for-5.3/block] block: add blkcg bio punt mechanism
Date:   Thu, 27 Jun 2019 13:39:47 -0700
Message-Id: <20190627203952.386785-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This patchset contains only the block part of the following

  [1] [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback support

with the following changes

 * wbc_account_io() is renamed to wbc_account_cgroup_owner() and
   wbc->no_account_io to wbc->no_cgroup_owner for clarity.

When writeback is executed asynchronously (e.g. for compression), bios
are bounced to and issued by worker pool shared by all cgroups.  This
leads to significant priority inversions when cgroup IO control is in
use - IOs for a low priority cgroup can tie down the workers forcing
higher priority IOs to wait behind them.

This patchset adds an bio punt mechanism to blkcg and updates btrfs to
issue async IOs through it.  A bio tagged with REQ_CGROUP_PUNT flag is
bounced to the asynchronous issue context of the associated blkcg on
bio_submit().  As the bios are issued from per-blkcg work items,
there's no concern for priority inversions and it doesn't require
invasive changes to the filesystems.  The mechanism should be
generally useful for IO control support across different filesystems.

This patchset contains the following 5 patches.

 0001-cgroup-blkcg-Prepare-some-symbols-for-module-and-CON.patch
 0002-blkcg-writeback-Rename-wbc_account_io-to-wbc_account.patch
 0003-blkcg-writeback-Add-wbc-no_cgroup_owner.patch
 0004-blkcg-writeback-Implement-wbc_blkcg_css.patch
 0005-blkcg-implement-REQ_CGROUP_PUNT.patch

The patches are also available in the following branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-punt

Thanks, diffstat follows.

 Documentation/admin-guide/cgroup-v2.rst |    2 -
 block/blk-cgroup.c                      |   54 ++++++++++++++++++++++++++++++++
 block/blk-core.c                        |    3 +
 fs/btrfs/extent_io.c                    |    4 +-
 fs/buffer.c                             |    2 -
 fs/ext4/page-io.c                       |    2 -
 fs/f2fs/data.c                          |    4 +-
 fs/fs-writeback.c                       |   13 ++++---
 fs/mpage.c                              |    2 -
 include/linux/backing-dev.h             |    1 
 include/linux/blk-cgroup.h              |   16 ++++++++-
 include/linux/blk_types.h               |   10 +++++
 include/linux/cgroup.h                  |    1 
 include/linux/writeback.h               |   41 ++++++++++++++++++++----
 14 files changed, 134 insertions(+), 21 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20190615182453.843275-1-tj@kernel.org

