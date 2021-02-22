Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC5321D44
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhBVQmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 11:42:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:45924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbhBVQlf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 11:41:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614012049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m/Ixz4/s3VVRK6cnUgv7BhdGdeoOGFYn46SKs00TT/0=;
        b=AS0FvMk3X74uy/RTEJw5hCeicJeRhU/IrAoYGwoL/3dgga6lDf3nUrsphggREMSHJZko30
        giLnywGV1LSRdt9Ql0D4Ql33BHd0vBU7OJ5U4Yw2c1hSDJHsg4YRHDEj3D40xR93UX8Udg
        55QGZHiFwC7DJ7UO3lDYRWRJIutLlEI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 249DBAFF6;
        Mon, 22 Feb 2021 16:40:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/6] Qgroup/delayed node related fixes
Date:   Mon, 22 Feb 2021 18:40:41 +0200
Message-Id: <20210222164047.978768-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series contains a couple of fixes and code simplifications around qgroup
and delayed node interation. The first 3 patches fix 2 separate issues - one
possible underflow when freeing qgroup-reserved space and the other one is a
deadlock. Next 3 patches build on the fixes to clean up and simplify qgroup's
flushing code.

Nikolay Borisov (6):
  btrfs: Free correct amount of space in btrfs_delayed_inode_reserve_metadata
  btrfs: Export qgroup_reserve_meta
  btrfs: Don't flush from btrfs_delayed_inode_reserve_metadata
  btrfs: Cleanup try_flush_qgroup
  btrfs: Remove btrfs_inode from btrfs_delayed_inode_reserve_metadata
  btrfs: Simplify code flow in btrfs_delayed_inode_reserve_metadata

 fs/btrfs/delayed-inode.c | 32 +++++++-------------------------
 fs/btrfs/inode.c         |  2 +-
 fs/btrfs/qgroup.c        | 39 +++++++++------------------------------
 fs/btrfs/qgroup.h        |  3 +++
 4 files changed, 20 insertions(+), 56 deletions(-)

--
2.25.1

