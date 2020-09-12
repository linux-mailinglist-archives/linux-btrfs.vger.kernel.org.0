Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F0267B7E
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgILRCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 13:02:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgILRCl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 13:02:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1B24B02A;
        Sat, 12 Sep 2020 17:02:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6619DDA7C5; Sat, 12 Sep 2020 19:01:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.9-rc5
Date:   Sat, 12 Sep 2020 19:01:18 +0200
Message-Id: <cover.1599836573.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes:

- regression fix, crash after failed snapshot creation

- one more lockep fix, use nofs allocation when allocating missing
  device

- fix reloc tree leak on degraded mount

- make some extent buffer alignment checks less strict to mount
  filesystems created by btrfs-convert

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit f96d6960abbc52e26ad124e69e6815283d3e1674:

  btrfs: tree-checker: fix the error message for transid error (2020-08-27 14:16:05 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc4-tag

for you to fetch changes up to 2d892ccdc163a3d2e08c5ed1cea8b61bf7e4f531:

  btrfs: fix NULL pointer dereference after failure to create snapshot (2020-09-07 21:18:35 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix NULL pointer dereference after failure to create snapshot

Josef Bacik (2):
      btrfs: fix lockdep splat in add_missing_dev
      btrfs: free data reloc tree on failed mount

Qu Wenruo (1):
      btrfs: require only sector size alignment for parent eb bytenr

 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/extent-tree.c | 19 +++++++++----------
 fs/btrfs/print-tree.c  | 12 +++++++-----
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/volumes.c     | 10 ++++++++++
 5 files changed, 29 insertions(+), 15 deletions(-)
