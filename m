Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0758C216DB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 15:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGGN1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 09:27:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGN1d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 09:27:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39F9EAC23;
        Tue,  7 Jul 2020 13:27:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A118DA818; Tue,  7 Jul 2020 15:27:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.8-rc5
Date:   Tue,  7 Jul 2020 15:27:12 +0200
Message-Id: <cover.1594127892.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following fixes, thanks.

- regression fix of a leak in global block reserve accounting

- fix a (hard to hit) race of readahead vs releasepage that could lead
  to crash

- convert all remaining uses of comment fall through annotations to the
  pseudo keyword

- fix crash when mounting a fuzzed image with -o recovery

----------------------------------------------------------------
The following changes since commit b091f7fede97cc64f7aaad3eeb37965aebee3082:

  btrfs: use kfree() in btrfs_ioctl_get_subvol_info() (2020-06-16 19:24:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc4-tag

for you to fetch changes up to 0465337c5599bbe360cdcff452992a1a6b7ed2d4:

  btrfs: reset tree root pointer after error in init_tree_roots (2020-07-02 10:27:12 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix fatal extent_buffer readahead vs releasepage race

Filipe Manana (1):
      btrfs: fix reclaim_size counter leak after stealing from global reserve

Josef Bacik (1):
      btrfs: reset tree root pointer after error in init_tree_roots

Marcos Paulo de Souza (1):
      btrfs: convert comments to fallthrough annotations

 fs/btrfs/ctree.c      |  2 +-
 fs/btrfs/disk-io.c    |  6 ++++--
 fs/btrfs/extent_io.c  | 40 ++++++++++++++++++++++++----------------
 fs/btrfs/ref-verify.c |  2 +-
 fs/btrfs/space-info.c |  2 +-
 fs/btrfs/super.c      |  6 +++---
 fs/btrfs/volumes.h    |  2 +-
 7 files changed, 35 insertions(+), 25 deletions(-)
