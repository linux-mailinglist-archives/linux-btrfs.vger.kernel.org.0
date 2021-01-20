Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0C2FDCAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 23:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbhATWeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 17:34:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:52814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732759AbhATVw0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 16:52:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611179504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yb5iSGNOaTd/8KoTGFupnP8FcYrMmZ4F4N+E8HNT0pc=;
        b=nHFM7lokTH4GDEN35nIYTxRBahisnMk5BJOUeWOAYNLPAykUMH9pyVM5ZIFoQsQP1P8Uv4
        fAqogNkgbzgvPAecOzefWWLMRRsEkTnFi8ECGqzDRxLO/BpzdG4nU71hdcsxuf1nAYd4wm
        YAm3aLkhYVr33B+lGNluk6a5LM6If/4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDE9BAB9F;
        Wed, 20 Jan 2021 21:51:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5F36DA6E3; Wed, 20 Jan 2021 22:49:47 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.11-rc5
Date:   Wed, 20 Jan 2021 22:49:46 +0100
Message-Id: <cover.1611178630.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more one line fixes for various bugs, stable material.

- fix send when emitting clone operation from the same file and root

- fix double free on error when cleaning backrefs

- lockdep fix during relocation

- handle potential error during reloc when starting transaction

- skip running delayed refs during commit (leftover from code removal in
  this dev cycle)

Please pull thanks.

----------------------------------------------------------------
The following changes since commit e076ab2a2ca70a0270232067cd49f76cd92efe64:

  btrfs: shrink delalloc pages instead of full inodes (2021-01-08 16:36:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc4-tag

for you to fetch changes up to 34d1eb0e599875064955a74712f08ff14c8e3d5f:

  btrfs: don't clear ret in btrfs_start_dirty_block_groups (2021-01-18 16:00:11 +0100)

----------------------------------------------------------------
David Sterba (1):
      btrfs: no need to run delayed refs after commit_fs_roots during commit

Filipe Manana (1):
      btrfs: send: fix invalid clone operations when cloning from the same file and root

Josef Bacik (4):
      btrfs: don't get an EINTR during drop_snapshot for reloc
      btrfs: do not double free backref nodes on error
      btrfs: fix lockdep splat in btrfs_recover_relocation
      btrfs: don't clear ret in btrfs_start_dirty_block_groups

 fs/btrfs/backref.c     |  2 +-
 fs/btrfs/block-group.c |  3 ++-
 fs/btrfs/extent-tree.c | 10 +++++++++-
 fs/btrfs/send.c        | 15 +++++++++++++++
 fs/btrfs/transaction.c |  8 --------
 fs/btrfs/volumes.c     |  2 ++
 6 files changed, 29 insertions(+), 11 deletions(-)
