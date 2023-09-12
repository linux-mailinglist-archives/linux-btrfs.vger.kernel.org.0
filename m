Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A950F79D7B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjILRiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 13:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbjILRiH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 13:38:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A929910F4;
        Tue, 12 Sep 2023 10:38:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F278821836;
        Tue, 12 Sep 2023 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694540281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Pi00Nw/gtevQBXUum3NcskH2HntmqVQ/Kt0syO9NAz8=;
        b=L0UDzcBVVpvJOovOkNYOi9fAnAm6eLktUPztKp51o6Skp00BkoIpl9HRn5KO1PGnTzm0Gt
        u+w95qp2jgdFjnmIh0G/cDaTQc9e9Hi7EfD/BrV22BLQ4B0A/5ILiHRltRArNWDs1FEJ9k
        01Bib5NVjuprUq0Dlu1uoI+toJANhlU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DF8012C142;
        Tue, 12 Sep 2023 17:38:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E7CEDA7D7; Tue, 12 Sep 2023 19:31:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.6-rc2
Date:   Tue, 12 Sep 2023 19:31:21 +0200
Message-ID: <cover.1694467872.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

first batch of fixes for 6.6. Please pull, thanks.

- several fixes for handling directory item (inserting, removing,
  iteration, error handling)

- fix transaction commit stalls when auto relocation is running and
  blocks other tasks that want to commit

- fix a build error when DEBUG is enabled

- fix lockdep warning in inode number lookup ioctl

- fix race when finishing block group creation

- remove link to obsolete wiki in several files

----------------------------------------------------------------
The following changes since commit c02d35d89b317994bd713ba82e160c5e7f22d9c8:

  btrfs: zoned: skip splitting and logical rewriting on pre-alloc write (2023-08-22 14:19:59 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc1-tag

for you to fetch changes up to 5facccc9402301d67d48bef06159b91f7e41efc0:

  MAINTAINERS: remove links to obsolete btrfs.wiki.kernel.org (2023-09-08 14:21:27 +0200)

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      MAINTAINERS: remove links to obsolete btrfs.wiki.kernel.org

Filipe Manana (6):
      btrfs: fix race between finishing block group creation and its item update
      btrfs: release path before inode lookup during the ino lookup ioctl
      btrfs: fix lockdep splat and potential deadlock after failure running delayed items
      btrfs: improve error message after failure to add delayed dir index item
      btrfs: remove BUG() after failure to insert delayed dir index item
      btrfs: assert delayed node locked when removing delayed item

Josef Bacik (2):
      btrfs: do not block starts waiting on previous transaction commit
      btrfs: check for BTRFS_FS_ERROR in pending ordered assert

Qu Wenruo (1):
      btrfs: fix a compilation error if DEBUG is defined in btree_dirty_folio

 Documentation/filesystems/btrfs.rst |   1 -
 MAINTAINERS                         |   1 -
 fs/btrfs/Kconfig                    |   2 +-
 fs/btrfs/block-group.c              |  12 ++++-
 fs/btrfs/delayed-inode.c            | 104 ++++++++++++++++++++++++------------
 fs/btrfs/disk-io.c                  |  22 ++++----
 fs/btrfs/ioctl.c                    |   8 ++-
 fs/btrfs/locking.h                  |   2 +-
 fs/btrfs/ordered-data.c             |   2 +-
 fs/btrfs/transaction.c              |  39 ++++++++------
 fs/btrfs/transaction.h              |   1 +
 11 files changed, 128 insertions(+), 66 deletions(-)
