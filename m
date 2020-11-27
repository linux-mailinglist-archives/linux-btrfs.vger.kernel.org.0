Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA62C68D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 16:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgK0Pht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 10:37:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:56398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgK0Pht (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 10:37:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606491467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bxvw8MtB2t8qh4fGfO0043SaXu/WwWkrv15MzKmm9p0=;
        b=KvXxwYihMsUXTlBN0byPiqXp+JrwAP2qiDi/mz45v9TLcSBY3uEn+QIq84GMM4GaLkUm04
        FY0PS9dQt0jJwpJARO+FAz2iHpHf4JnGz1DII5um+V9b+DaCU/b+10HIdi1KEy2VUMx+Av
        A8G9Ed71Z59CCVzC01YvX/4+1Sfjjzo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35EC6ABD7;
        Fri, 27 Nov 2020 15:37:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36481DA7D9; Fri, 27 Nov 2020 16:36:17 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.10-rc6
Date:   Fri, 27 Nov 2020 16:36:15 +0100
Message-Id: <cover.1606490199.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few fixes for various warnings that accumulated over past two weeks.

- tree-checker: add missing return values for some errors

- lockdep fixes
  - when reading qgroup config and starting quota rescan
  - reverse order of quota ioctl lock and VFS freeze lock

- avoid accessing potentially stale fs info during device scan,
  reported by syzbot

- add scope NOFS protection around qgroup relation changes

- check for running transaction before flushing qgroups

- fix tracking of new delalloc ranges for some cases

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 468600c6ec28613b756193c5f780aac062f1acdf:

  btrfs: ref-verify: fix memory leak in btrfs_ref_tree_mod (2020-11-05 13:03:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-rc5-tag

for you to fetch changes up to a855fbe69229078cd8aecd8974fb996a5ca651e6:

  btrfs: fix lockdep splat when enabling and disabling qgroups (2020-11-23 21:16:43 +0100)

----------------------------------------------------------------
Daniel Xu (1):
      btrfs: tree-checker: add missing return after error in root_item

David Sterba (1):
      btrfs: tree-checker: add missing returns after data_ref alignment checks

Filipe Manana (4):
      btrfs: fix missing delalloc new bit for new delalloc ranges
      btrfs: fix lockdep splat when reading qgroup config on mount
      btrfs: do nofs allocations when adding and removing qgroup relations
      btrfs: fix lockdep splat when enabling and disabling qgroups

Johannes Thumshirn (1):
      btrfs: don't access possibly stale fs_info data for printing duplicate device

Qu Wenruo (1):
      btrfs: qgroup: don't commit transaction when we already hold the handle

 fs/btrfs/ctree.h             |  5 ++-
 fs/btrfs/file.c              | 57 ----------------------------
 fs/btrfs/inode.c             | 58 +++++++++++++++++++++++++++++
 fs/btrfs/qgroup.c            | 88 +++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/tests/inode-tests.c | 12 ++++--
 fs/btrfs/tree-checker.c      |  3 ++
 fs/btrfs/volumes.c           |  8 +++-
 7 files changed, 158 insertions(+), 73 deletions(-)
