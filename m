Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535566FF5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 14:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfGVMRh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 08:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:50532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfGVMRh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 08:17:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C621B034;
        Mon, 22 Jul 2019 12:17:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6697EDA882; Mon, 22 Jul 2019 14:18:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.3-rc2
Date:   Mon, 22 Jul 2019 14:18:08 +0200
Message-Id: <cover.1563797135.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following branch with fixes for leaks caused by recently
merged patches, one build fix and a fix to prevent mixing of
incompatible features. Thanks.

----------------------------------------------------------------
The following changes since commit e02d48eaaed77f6c36916a7aa65c451e1f9d9aab:

  btrfs: fix memory leak of path on error return path (2019-07-05 18:47:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc1-tag

for you to fetch changes up to 373c3b80e459cb57c34381b928588a3794eb5bbd:

  btrfs: don't leak extent_map in btrfs_get_io_geometry() (2019-07-17 17:03:36 +0200)

----------------------------------------------------------------
Johannes Thumshirn (2):
      btrfs: free checksum hash on in close_ctree
      btrfs: don't leak extent_map in btrfs_get_io_geometry()

Qu Wenruo (1):
      btrfs: inode: Don't compress if NODATASUM or NODATACOW set

YueHaibing (1):
      btrfs: Fix build error while LIBCRC32C is module

 fs/btrfs/Kconfig   |  1 +
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/inode.c   | 24 +++++++++++++++++++++++-
 fs/btrfs/volumes.c | 10 +++++++---
 4 files changed, 32 insertions(+), 4 deletions(-)
