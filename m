Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB222C44F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 13:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGXLWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 07:22:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgGXLWC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 07:22:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B7F6AC52;
        Fri, 24 Jul 2020 11:22:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D4BEDA791; Fri, 24 Jul 2020 13:21:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.8-rc7
Date:   Fri, 24 Jul 2020 13:21:32 +0200
Message-Id: <cover.1595587350.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've selected a few resouce leak fixes from recent patches, all are
stable material. The problems have been observed during testing or have
a reproducer.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit d77765911385b65fc82d74ab71b8983cddfe0b58:

  btrfs: wire up iter_file_splice_write (2020-07-09 19:57:58 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc6-tag

for you to fetch changes up to 48cfa61b58a1fee0bc49eef04f8ccf31493b7cdd:

  btrfs: fix mount failure caused by race with umount (2020-07-21 22:08:54 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix mount failure caused by race with umount

Filipe Manana (1):
      btrfs: fix double free on ulist after backref resolution failure

Qu Wenruo (1):
      btrfs: qgroup: fix data leak caused by race between writeback and truncate

Robbie Ko (1):
      btrfs: fix page leaks after failure to lock page for delalloc

 fs/btrfs/backref.c   |  1 +
 fs/btrfs/extent_io.c |  3 ++-
 fs/btrfs/inode.c     | 23 ++++++++++-------------
 fs/btrfs/volumes.c   |  8 ++++++++
 4 files changed, 21 insertions(+), 14 deletions(-)
