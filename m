Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2AD3D1FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405550AbfFKQPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 12:15:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405241AbfFKQPo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4009DADF0;
        Tue, 11 Jun 2019 16:15:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F936DA8F5; Tue, 11 Jun 2019 18:16:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.2-rc5
Date:   Tue, 11 Jun 2019 18:16:28 +0200
Message-Id: <cover.1560268545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

here's one regression fix to TRIM ioctl. The range cannot be used as
its meaning can be confusing regarding physical and logical addresses.
This confusion in code led to potential corruptions when the range
overlapped data.

The original patch made it to several stable kernels and was promptly
reverted, the version for master branch is different due to additional
changes but the change is effectively the same.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 06989c799f04810f6876900d4760c0edda369cf7:

  Btrfs: fix race updating log root item during fsync (2019-05-28 19:26:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc4-tag

for you to fetch changes up to 8103d10b71610aa65a65d6611cd3ad3f3bd7beeb:

  btrfs: Always trim all unallocated space in btrfs_trim_free_extents (2019-06-07 14:52:05 +0200)

----------------------------------------------------------------
Nikolay Borisov (1):
      btrfs: Always trim all unallocated space in btrfs_trim_free_extents

 fs/btrfs/extent-tree.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)
