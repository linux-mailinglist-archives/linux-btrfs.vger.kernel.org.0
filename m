Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91D21C87B
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jul 2020 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgGLKPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 06:15:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:58864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGLKPW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 06:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B931CAE41;
        Sun, 12 Jul 2020 10:15:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7FE3EDA732; Sun, 12 Jul 2020 12:14:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.8-rc5, part 2
Date:   Sun, 12 Jul 2020 12:14:58 +0200
Message-Id: <cover.1594548115.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull two refcounting fixes and one prepartory patch for upcoming
splice cleanup. Thanks.

- fix double put of block group with nodatacow

- fix missing block group put when remounting with discard=async

- explicitly set splice callback (no functional change), to ease
  integrating splice cleanup patches

----------------------------------------------------------------
The following changes since commit 0465337c5599bbe360cdcff452992a1a6b7ed2d4:

  btrfs: reset tree root pointer after error in init_tree_roots (2020-07-02 10:27:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.8-rc4-tag

for you to fetch changes up to d77765911385b65fc82d74ab71b8983cddfe0b58:

  btrfs: wire up iter_file_splice_write (2020-07-09 19:57:58 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      btrfs: wire up iter_file_splice_write

Josef Bacik (1):
      btrfs: fix double put of block group with nocow

Qu Wenruo (1):
      btrfs: discard: add missing put when grabbing block group from unused list

 fs/btrfs/discard.c | 1 +
 fs/btrfs/file.c    | 1 +
 fs/btrfs/inode.c   | 9 +--------
 3 files changed, 3 insertions(+), 8 deletions(-)
