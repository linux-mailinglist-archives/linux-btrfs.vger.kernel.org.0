Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0930589F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhA0KjJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhA0Kfo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:35:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FC2720757
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611743703;
        bh=yTf6/NW29YKFPslKwiFzfhoLbbND4/VULt6z0MSza+s=;
        h=From:To:Subject:Date:From;
        b=PRVjSP/d58WuPzE31O/MyAneRe+AgvhZi19duoE1ByH2A9I4tLN+s/cWPSMsB9J9n
         YESA0rUTWDyN/HUYWwcUl1WMcrHhixyhlrq8BmZd8nu8p1ME/CQMo6Tq5NGyE0V5Bj
         Nn1/0NKR/mYkZHqUYt/g9adV0TSzHnYIW4xAHB8dqasTKxOHjiOiHyp4xgzFGlukvR
         Jj9HRRi81NWxbcWr0NMHA4yA7e4DAWV526I0PYlaGunNVLuC1S8AEprovFk5UBJz58
         KcAbuD1lNBawzTyFP3gfr2GbKaLTkmX1QldBlBvEQzj2O7YnqMwIxLHoQ1s0PN+ik6
         3Ahp9B3BJVy9g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: more performance improvements for dbench workloads
Date:   Wed, 27 Jan 2021 10:34:53 +0000
Message-Id: <cover.1611742865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following patchset brings one more batch of performance improvements
with dbench workloads, or anything that mixes file creation, file writes,
renames, unlinks, etc with fsync like dbench does. This patchset is mostly
based on avoiding logging directory inodes multiple times when not necessary,
falling back to transaction commits less frequently and often waiting less
time for transaction commits to complete. Performance results are listed in
the change log of the last patch, but in short, I've experienced a reduction
of maximum latency up to about -40% and throuhput gains up to about +6%.

Filipe Manana (7):
  btrfs: remove unnecessary directory inode item update when deleting dir entry
  btrfs: stop setting nbytes when filling inode item for logging
  btrfs: avoid logging new ancestor inodes when logging new inode
  btrfs: skip logging directories already logged when logging all parents
  btrfs: skip logging inodes already logged when logging new entries
  btrfs: remove unnecessary check_parent_dirs_for_sync()
  btrfs: make concurrent fsyncs wait less when waiting for a transaction commit

 fs/btrfs/file.c        |   1 +
 fs/btrfs/transaction.c |  39 +++++++--
 fs/btrfs/transaction.h |   2 +
 fs/btrfs/tree-log.c    | 195 ++++++++++++-----------------------------
 4 files changed, 92 insertions(+), 145 deletions(-)

-- 
2.28.0

