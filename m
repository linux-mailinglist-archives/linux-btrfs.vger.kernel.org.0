Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF49412FBB0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 18:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgACRni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 12:43:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:60850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgACRni (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 12:43:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C44E2B1AD;
        Fri,  3 Jan 2020 17:43:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0071BDA795; Fri,  3 Jan 2020 18:43:27 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.5-rc5
Date:   Fri,  3 Jan 2020 18:43:16 +0100
Message-Id: <cover.1578072747.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few fixes for btrfs:

* blkcg accounting problem with compression that could stall writes

* setting up blkcg bio for compression crashes due to NULL bdev pointer

* fix possible infinite loop in writeback for nocow files (here possible
  means almost impossible, 13 things that need to happen to trigger it)

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit fbd542971aa1e9ec33212afe1d9b4f1106cd85a1:

  btrfs: send: remove WARN_ON for readonly mount (2019-12-13 14:10:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.5-rc4-tag

for you to fetch changes up to de7999afedff02c6631feab3ea726a0e8f8c3d40:

  Btrfs: fix infinite loop during nocow writeback due to race (2019-12-30 16:13:20 +0100)

----------------------------------------------------------------
Dennis Zhou (2):
      btrfs: punt all bios created in btrfs_submit_compressed_write()
      btrfs: fix compressed write bio blkcg attribution

Filipe Manana (1):
      Btrfs: fix infinite loop during nocow writeback due to race

 fs/btrfs/compression.c | 7 ++++++-
 fs/btrfs/inode.c       | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)
