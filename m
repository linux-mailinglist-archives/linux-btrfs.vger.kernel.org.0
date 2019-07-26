Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CCD76F39
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 18:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfGZQlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 12:41:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbfGZQlw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 12:41:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31E5FAF27;
        Fri, 26 Jul 2019 16:41:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99A62DA811; Fri, 26 Jul 2019 18:42:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.3-rc2
Date:   Fri, 26 Jul 2019 18:42:24 +0200
Message-Id: <cover.1564158940.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull two regression fixes:

* hangs caused by a missing barrier in the locking code

* memory leaks of extent_state due to bad handling of a cached pointer

Thanks.

----------------------------------------------------------------
The following changes since commit 373c3b80e459cb57c34381b928588a3794eb5bbd:

  btrfs: don't leak extent_map in btrfs_get_io_geometry() (2019-07-17 17:03:36 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.3-rc1-tag

for you to fetch changes up to a3b46b86ca76d7f9d487e6a0b594fd1984e0796e:

  btrfs: fix extent_state leak in btrfs_lock_and_flush_ordered_range (2019-07-26 12:21:22 +0200)

----------------------------------------------------------------
Naohiro Aota (1):
      btrfs: fix extent_state leak in btrfs_lock_and_flush_ordered_range

Nikolay Borisov (1):
      btrfs: Fix deadlock caused by missing memory barrier

 fs/btrfs/locking.c      |  9 ++++++---
 fs/btrfs/ordered-data.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)
