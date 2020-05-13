Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7851D06FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 08:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEMGQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 02:16:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgEMGQS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 02:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33F4CAF2A
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 06:16:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: REF_COWS bit rework
Date:   Wed, 13 May 2020 14:16:09 +0800
Message-Id: <20200513061611.111807-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This small patchset reworks the REF_COWS bit, by renaming it, and remove
that bit for data relocation root.

The basic idea of such rework is to reduce the confusion caused by the
name REF_COWS.
With the new bit called SHAREABLE, it should be clear that no user can
really create snapshot for data reloc tree, thus its tree blocks
shouldn't be shareable.

This would make data balance for reloc tree a little simpler.

Qu Wenruo (2):
  btrfs: Rename BTRFS_ROOT_REF_COWS to BTRFS_ROOT_SHAREABLE
  btrfs: Don't set SHAREABLE flag for data reloc tree

 fs/btrfs/backref.c     |  4 ++--
 fs/btrfs/backref.h     |  2 +-
 fs/btrfs/block-rsv.c   |  2 +-
 fs/btrfs/ctree.c       | 26 +++++++++++++-------------
 fs/btrfs/ctree.h       | 25 +++++++++++++++++++++++--
 fs/btrfs/disk-io.c     | 27 ++++++++++++++++++++-------
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 27 ++++++++++++++++-----------
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/relocation.c  | 42 +++++++++++++++++-------------------------
 fs/btrfs/transaction.c | 12 ++++++------
 fs/btrfs/tree-defrag.c |  2 +-
 13 files changed, 103 insertions(+), 72 deletions(-)

-- 
2.26.2

