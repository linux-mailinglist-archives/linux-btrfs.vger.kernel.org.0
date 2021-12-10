Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26028470BFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbhLJUph (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 15:45:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44476 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbhLJUph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 15:45:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A67B5210F2;
        Fri, 10 Dec 2021 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639168920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vecIXNnU5/oP9s5Sp+k/IRk5aV3S4MzUZwpPNFkvqFY=;
        b=I4ZbOFJZ0YuMl7hfSsB4n+lQ4C2ELgN7pkz2XN89r/M3gYj7TrPFDI1qPNX8AWo6mWB5tx
        fHyO62MJIMsj5Spe7tm6KmSYPOQd03Fe22+PnDReQFqNYPDLFPU2jwfoPOO0l9WIXuulqj
        2tQsWwtl8eWjMeUV4iuPv89PtPyNRZs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9EED1A3B84;
        Fri, 10 Dec 2021 20:42:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E40ADA799; Fri, 10 Dec 2021 21:41:44 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.16-rc5
Date:   Fri, 10 Dec 2021 21:41:43 +0100
Message-Id: <cover.1638975228.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more regression fixes and stable patches, mostly one-liners.
Please pull, thanks.

Regression fixes:

- fix pointer/ERR_PTR mismatch returned from memdup_user

- reset dedicated zoned mode relocation block group to avoid using it
  and filling it without any recourse

Fixes:

- handle a case to FITRIM range (also to make fstests/generic/260 work)

- fix warning when extent buffer state and pages get out of sync after
  an IO error

- fix transaction abort when syncing due to missing mapping error set on
  metadata inode after inlining a compressed file

- fix transaction abort due to tree-log and zoned mode interacting in an
  unexpected way

- fix memory leak of additional extent data when qgroup reservation
  fails

- do proper handling of slot search call when deleting root refs

----------------------------------------------------------------
The following changes since commit daf87e953527b03c0bd4c0f41d704ba71186256d:

  btrfs: fix the memory leak caused in lzo_compress_pages() (2021-11-26 16:10:05 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc4-tag

for you to fetch changes up to 8289ed9f93bef2762f9184e136d994734b16d997:

  btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error handling (2021-12-08 15:45:27 +0100)

----------------------------------------------------------------
Dan Carpenter (1):
      btrfs: fix error pointer dereference in btrfs_ioctl_rm_dev_v2()

Johannes Thumshirn (2):
      btrfs: free exchange changeset on failures
      btrfs: zoned: clear data relocation bg on zone finish

Josef Bacik (3):
      btrfs: fail if fstrim_range->start == U64_MAX
      btrfs: clear extent buffer uptodate when we fail to write it
      btrfs: call mapping_set_error() on btree inode with a write error

Naohiro Aota (1):
      btrfs: fix re-dirty process of tree-log nodes

Qu Wenruo (1):
      btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error handling

 fs/btrfs/delalloc-space.c | 12 +++++++++---
 fs/btrfs/extent-tree.c    |  3 +++
 fs/btrfs/extent_io.c      | 14 ++++++++++++++
 fs/btrfs/ioctl.c          |  6 ++----
 fs/btrfs/root-tree.c      |  3 ++-
 fs/btrfs/tree-log.c       |  5 +++--
 fs/btrfs/zoned.c          |  2 ++
 7 files changed, 35 insertions(+), 10 deletions(-)
