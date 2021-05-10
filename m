Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83CE3798C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 23:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhEJVJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 17:09:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJVJt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 17:09:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620680923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A5d2F22+cngMvgo1hy8w3rwA1C6Z1jkhtvJ7fdhHbvs=;
        b=afI4UukHa2az4+3gb3Qu1qiehbQ/MusnXaTmBVV2prQbe5gpOF0m7VfCVNkM63Twker07W
        EqQ6/qrGlVD5ZPhGL8wqsSmdSAUGxiplLrF8mI17kBxMueVIjP9LF6CuwHezsc3AIK6F0D
        a92dfoePoA90NFzi2p5FdcnXj6f/xKo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78B5FAC6B;
        Mon, 10 May 2021 21:08:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E083DB228; Mon, 10 May 2021 23:06:14 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.13-rc2
Date:   Mon, 10 May 2021 23:06:13 +0200
Message-Id: <cover.1620679798.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

first batch of various fixes, here's a list of notable ones:

- fix unmountable seed device after fstrim

- fix silent data loss in zoned mode due to ordered extent splitting

- fix race leading to unpersisted data and metadata on fsync

- fix deadlock when cloning inline extents and using qgroups

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 18bb8bbf13c1839b43c9e09e76d397b753989af2:

  btrfs: zoned: automatically reclaim zones (2021-04-20 20:46:31 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc1-tag

for you to fetch changes up to 77364faf21b4105ee5adbb4844fdfb461334d249:

  btrfs: initialize return variable in cleanup_free_space_cache_v1 (2021-05-04 18:05:15 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: fix unmountable seed device after fstrim

Filipe Manana (4):
      btrfs: zoned: fix silent data loss after failure splitting ordered extent
      btrfs: do not consider send context as valid when trying to flush qgroups
      btrfs: fix race leading to unpersisted data and metadata on fsync
      btrfs: fix deadlock when cloning inline extents and using qgroups

Naohiro Aota (1):
      btrfs: zoned: sanity check zone type

Tom Rix (1):
      btrfs: initialize return variable in cleanup_free_space_cache_v1

 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/extent-tree.c      |  6 +++++-
 fs/btrfs/file.c             | 35 +++++++++++++++++++++++++----------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            |  4 ++--
 fs/btrfs/ioctl.c            |  2 +-
 fs/btrfs/ordered-data.c     |  2 +-
 fs/btrfs/qgroup.c           | 16 ++++++++++------
 fs/btrfs/send.c             |  4 ++--
 fs/btrfs/tree-log.c         |  3 ++-
 fs/btrfs/zoned.c            |  5 +++++
 11 files changed, 55 insertions(+), 26 deletions(-)
