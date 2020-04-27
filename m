Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0361BA54D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgD0NqQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 09:46:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0NqP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 09:46:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5345EABB2;
        Mon, 27 Apr 2020 13:46:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D9F3DA781; Mon, 27 Apr 2020 15:45:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.7-rc4
Date:   Mon, 27 Apr 2020 15:45:28 +0200
Message-Id: <cover.1587992189.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following branch with regression fixes and some stable
material. Thanks.

* regression fixes:
  * transaction leak when deleting unused block group
  * log cleanup after transaction abort

* fix block group leak when removing fails

* transaction leak if relocation recovery fails

* fix SPDX header

----------------------------------------------------------------
The following changes since commit aec7db3b13a07d515c15ada752a7287a44a79ea0:

  btrfs: fix setting last_trans for reloc roots (2020-04-17 15:20:08 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-rc3-tag

for you to fetch changes up to 1402d17dfd9657be0da8458b2079d03c2d61c86a:

  btrfs: fix transaction leak in btrfs_recover_relocation (2020-04-23 17:24:56 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix memory leak of transaction when deleting unused block group

Josef Bacik (1):
      btrfs: drop logs when we've aborted a transaction

Nishad Kamdar (1):
      btrfs: discard: Use the correct style for SPDX License Identifier

Xiyu Yang (2):
      btrfs: fix block group leak when removing fails
      btrfs: fix transaction leak in btrfs_recover_relocation

 fs/btrfs/block-group.c | 20 ++++++++++++++------
 fs/btrfs/discard.h     |  2 +-
 fs/btrfs/disk-io.c     | 36 ++++++++++++++++++++++++++++++++----
 fs/btrfs/relocation.c  |  1 +
 4 files changed, 48 insertions(+), 11 deletions(-)
