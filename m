Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800CF429701
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 20:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhJKSmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 14:42:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45610 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhJKSmg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 14:42:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 221CE1FEF3;
        Mon, 11 Oct 2021 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633977635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lZ6QMfPa6t/5PnKqtBHmODh84xoR9xhwwIwrrZmVwP0=;
        b=Uw0UCUvOoiAON6+YUq9lKHFEwiZ3Ndy5zcff7lWhtVSma5GD2fza2KBlzVJ7GboTit/6WR
        08LWtAhJ1JT8tHDLTjXu5TQHaSUEVmPGdTAfOgGWYUf4E0xKU3Au22AX76vaMMptZ7cjnu
        AnSHQiPRbal3Jr1UkccE0+b5XXutbws=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1A6CFA3B87;
        Mon, 11 Oct 2021 18:40:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2830DA781; Mon, 11 Oct 2021 20:40:11 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.15-rc6
Date:   Mon, 11 Oct 2021 20:40:10 +0200
Message-Id: <cover.1633976241.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more error handling fixes, stemming from code inspection, error
injection or fuzzing. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 0619b7901473c380abc05d45cf9c70bee0707db3:

  btrfs: prevent __btrfs_dump_space_info() to underflow its free space (2021-09-17 19:29:54 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc5-tag

for you to fetch changes up to 4afb912f439c4bc4e6a4f3e7547f2e69e354108f:

  btrfs: fix abort logic in btrfs_replace_file_extents (2021-10-07 22:08:06 +0200)

----------------------------------------------------------------
Filipe Manana (5):
      btrfs: deal with errors when checking if a dir entry exists during log replay
      btrfs: deal with errors when replaying dir entry during log replay
      btrfs: deal with errors when adding inode reference during log replay
      btrfs: unify lookup return value when dir entry is missing
      btrfs: check for error when looking up inode during dir entry replay

Josef Bacik (2):
      btrfs: update refs for any root except tree log roots
      btrfs: fix abort logic in btrfs_replace_file_extents

Qu Wenruo (1):
      btrfs: unlock newly allocated extent buffer after error

 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/dir-item.c    | 48 +++++++++++++++++++++++-------
 fs/btrfs/extent-tree.c |  1 +
 fs/btrfs/file.c        | 19 ++++++------
 fs/btrfs/tree-log.c    | 79 ++++++++++++++++++++++++++++++--------------------
 5 files changed, 97 insertions(+), 52 deletions(-)
