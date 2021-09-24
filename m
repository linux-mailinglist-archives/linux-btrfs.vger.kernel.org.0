Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFF4170D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbhIXL36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 07:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244406AbhIXL3v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 07:29:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FBB060F11
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Sep 2021 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632482898;
        bh=hY4UB4sDYaDIBttM4bMYOMqImM7TsHRHs+Osh1pD3Sw=;
        h=From:To:Subject:Date:From;
        b=BRmjD83l9HdfJ62miyd/3cFBhy3KQim9k1mPbsqb8XFlEkSMxduq3TUicJvvhhGG2
         uk/WGHh4147Y1DDkwFCee3SKtd4WEsiOb13eiPhSF7ONZ91RuQgKBW4cS5ZDJ+UGHv
         eJBrh7jyjaH/vuGSAKL3AlMBm/h3xKlBWWFDU3zhZnxNXaVVBAvwupDg5fHKK7onRl
         rHXx9qbu6ywt43/f2Oo43eAhX+uXlsYoCCEacDycR9jgPRRg56YNOMWsSn7A9b1/Zu
         krcqeW6q2l7kbrGTK5YAYaiIyvu6jV4R5HOjbociiW7/g0074evuSAcXCCHxJ+PwtX
         q8Pub6bagGlyg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: speedup bulk item insertions
Date:   Fri, 24 Sep 2021 12:28:12 +0100
Message-Id: <cover.1632482680.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset does some minor improvements to speedup bulk insertion of
items into a btree, which is used when logging directories, when running
delayed items for directories (fsync and transaction commits) and when
running the slow path (full sync) of an fsync. The last patch in the
series contains test results in its changelog.

Filipe Manana (3):
  btrfs: loop only once over data sizes array when inserting an item batch
  btrfs: unexport setup_items_for_insert()
  btrfs: use single bulk copy operations when logging directories

 fs/btrfs/ctree.c                     | 148 +++++++++++++++------------
 fs/btrfs/ctree.h                     |  45 ++++++--
 fs/btrfs/delayed-inode.c             |  41 ++++----
 fs/btrfs/file.c                      |   3 +-
 fs/btrfs/inode.c                     |   8 +-
 fs/btrfs/tests/extent-buffer-tests.c |   2 +-
 fs/btrfs/tests/inode-tests.c         |   4 +-
 fs/btrfs/tree-log.c                  |  52 +++++++---
 8 files changed, 188 insertions(+), 115 deletions(-)

-- 
2.33.0

