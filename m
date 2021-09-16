Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4740D76E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhIPKdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 06:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235590AbhIPKdh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 06:33:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D7CB6120F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631788337;
        bh=eCq48PchQihlhjoMVzTSE0wja7Zfi7uAAO+Yh/tOx4U=;
        h=From:To:Subject:Date:From;
        b=kwllYAwWmGF/3cvwSRU014Dwnkr5ebHpJRtvyI1flHzk5ErhcXZwXg72ehXxcEsWA
         XUm5G7/A4P6miyouyh1XBd48GrPTOsGsfdRPowAi+AAXyUXC4Llw/CkYa/jMwoHc4h
         dpm0VoYdl8lDlWO/gVzHMVJPLcl0T33iEXFyh+f2hQKE+s1WJ3S+YwwxJe1lKk15M2
         kDxeCZUu4vlTZ00H3O9Fj/7lHBq1+YqJFi9uNfosrZRYuI3gpm6jq4K3BUWAyDbNCF
         uDlBeZ1teQQ10i1uC6RjSW16yDv87zhwJbebyDCPQK1qcgLVAzfjs2oYOoxU68vY+Z
         mKVsN17FlqJlQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: rework directory logging to make it more efficient
Date:   Thu, 16 Sep 2021 11:32:09 +0100
Message-Id: <cover.1631787796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>


This patchset changes directory logging to make it more efficient, by doing
bulk inserts of directory items and avoiding tree searches on a item by item
basis when they can be avoided. These decrease the amount of time we spend
logging directory items and reduces lock contention on a log tree in case
there are other tasks logging other inodes. The last patch mentions test
results in its changelog, and the first 3 patches are just cleanups and
preparatory work. This is also ground work for future changes to directory
logging, but since these are already big enough, I'm sending these separately
to get into integration/linux-next sooner rather than later.


Filipe Manana (5):
  btrfs: remove root argument from btrfs_log_inode() and its callees
  btrfs: remove redundant log root assignment from log_dir_items()
  btrfs: factor out the copying loop of dir items from log_dir_items()
  btrfs: insert items in batches when logging a directory when possible
  btrfs: keep track of the last logged keys when logging a directory

 fs/btrfs/btrfs_inode.h |  39 ++--
 fs/btrfs/inode.c       |   6 +-
 fs/btrfs/tree-log.c    | 419 ++++++++++++++++++++++++++++++-----------
 fs/btrfs/tree-log.h    |   2 +
 4 files changed, 340 insertions(+), 126 deletions(-)

-- 
2.33.0

