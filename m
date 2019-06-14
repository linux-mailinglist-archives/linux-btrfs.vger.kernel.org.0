Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412BC450B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfFNAdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 20:33:55 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:36932 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNAdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 20:33:54 -0400
Received: by mail-pg1-f182.google.com with SMTP id 20so465869pgr.4;
        Thu, 13 Jun 2019 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=oTlzP5u+wueqk5xdHgpRxhOd00u8gJeBwCjbnHotl3k=;
        b=BzGNcoFmYi8gLKxOomEtTfMFNIXrqiP0F3yWFy2pIZq6bQXNBZWRXp+YK4O+W6BCr2
         03Dyfn+G4eBB3Qoewqaj5dXNOGEhd5+/AUaHayk9hntIRt+00rCIjkrtozgqiu4dUT67
         NXksTOoEBg/0aXehmbLZAvEY8gPuTmfpYZOeXwdZ+W6/stWG/qeXrkP4bwKa17v/HPEE
         9V8TlTDTfG5rKd2Vn0dcSpmSzCnPNzfTNv9ZSXQFSxQqYOM+tQkOTpS5CANKmgM1daZg
         LNz0VFzp3brsf7zVNzjCvQulg96AMDLT7OhuNOeL/OvusgvhPe3SUuC3odLuGzHJ91OK
         HOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=oTlzP5u+wueqk5xdHgpRxhOd00u8gJeBwCjbnHotl3k=;
        b=sWaeljdmZ/wx+PkuXrZ845qNKZwXUOs+PtyNPf2GXKVPIdpeu33Y4qee8WRMGXVAEw
         tWLdLMtytZcSvSwglMvAROF8CA5rCV89wUq4IhGkJ8QlHRpvRpemb68YB2e1+Z4CbYzi
         N6aqWul8Vgb6XLkR00btt4WLnrw7JK9JqZ/ZqyPtA8/EzcEWh2dBPkrh+/+BPxkQxe5q
         4Iaz/p9nRjEtlJQVMi50UkjmDzCIdhEed6ECH7l1EW39buBWwQn/iDdi7cyXaT/oowLX
         nldCy1YA57RXmwwQaOHZ/Mv8hZbc0McdfETvCgDdgQKBxyb67e35X3E3t82tyelVbvmB
         sDUg==
X-Gm-Message-State: APjAAAVQ+NBii9uloUaWJUaATdqgcZz0g6qb/no5fYJ6/mPDBm3QRgMO
        UG/FbEufC3TdRgCvmxyxHRg5xgkw
X-Google-Smtp-Source: APXvYqwdEJlBHl1J6iniMl+4x+IcJZNUmIQ5tWeT365a3MEshvfmKjso/WA0P3Jq5VOzRc4hZcCN1g==
X-Received: by 2002:a62:750c:: with SMTP id q12mr75920731pfc.59.1560472433969;
        Thu, 13 Jun 2019 17:33:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id l1sm894960pgj.67.2019.06.13.17.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 17:33:53 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCHSET btrfs/for-next] btrfs: fix cgroup writeback support
Date:   Thu, 13 Jun 2019 17:33:42 -0700
Message-Id: <20190614003350.1178444-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When writeback is executed asynchronously (e.g. for compression), bios
are bounced to and issued by worker pool shared by all cgroups.  This
leads to significant priority inversions when cgroup IO control is in
use - IOs for a low priority cgroup can tie down the workers forcing
higher priority IOs to wait behind them.

This patchset adds an bio punt mechanism to blkcg.  A bio tagged with
REQ_CGROUP_PUNT flag is bounced to the asynchronous issue context of
the associated blkcg on bio_submit().  As the bios are issued from
per-blkcg work items, there's no concern for priority inversions and
it doesn't require invasive changes to the filesystems.  The mechanism
should be generally useful for IO control support across different
filesystems.

btrfs async path is simplified and is updated to use REQ_CGROUP_PUNT
for submitting asynchronous bios.  It's also updated to always and
only account the original writeback bios against wbc so that cgroup
inode writeback ownership arbitration isn't confused by downstream
bios.

This patchset contains the following 8 patches.  The first three are
my blkcg patches to implement the needed mechanisms.  The latter five
are Chris Mason's btrfs cleanup and update patches.  Please let me
know how the patches should be routed.  Given that there currently
aren't other users, it's likely the easiest to route all through btrfs
tree.

 0001-blkcg-writeback-Add-wbc-no_wbc_acct.patch
 0002-blkcg-writeback-Implement-wbc_blkcg_css.patch
 0003-blkcg-implement-REQ_CGROUP_PUNT.patch
 0004-Btrfs-stop-using-btrfs_schedule_bio.patch
 0005-Btrfs-delete-the-entire-async-bio-submission-framewo.patch
 0006-Btrfs-only-associate-the-locked-page-with-one-async_.patch
 0007-Btrfs-use-REQ_CGROUP_PUNT-for-worker-thread-submitte.patch
 0008-Btrfs-extent_write_locked_range-should-attach-inode-.patch

0001-0003 implement wbc->no_wbc_acct, wbc_blkcg_css() and
REQ_CGROUP_PUNT.

0004-0006 are prep patches to simplify / improve async bio submission.

0007 makes btrfs use REQ_CGROUP_PUNT for async bios.

0008 fixes wbc writeback accounting for IOs issued through
extent_write_locked_range().

This patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-btrfs-cgroup-updates

Thanks, diffstat follows.

 block/blk-cgroup.c          |   54 +++++++++
 block/blk-core.c            |    3 
 fs/btrfs/compression.c      |   16 +-
 fs/btrfs/compression.h      |    3 
 fs/btrfs/ctree.h            |    1 
 fs/btrfs/disk-io.c          |   25 +---
 fs/btrfs/extent_io.c        |   15 +-
 fs/btrfs/inode.c            |   61 ++++++++--
 fs/btrfs/super.c            |    1 
 fs/btrfs/volumes.c          |  264 --------------------------------------------
 fs/btrfs/volumes.h          |   10 -
 fs/fs-writeback.c           |    2 
 include/linux/backing-dev.h |    1 
 include/linux/blk-cgroup.h  |   16 ++
 include/linux/blk_types.h   |   10 +
 include/linux/writeback.h   |   24 +++-
 16 files changed, 194 insertions(+), 312 deletions(-)

--
tejun

