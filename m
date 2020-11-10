Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE772ADB41
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgKJQHh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 11:07:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:50786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbgKJQHh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 11:07:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605024455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3e+3nDrdHe42lYq8N47pjMvAbKv/DdnTrRGXCyH/IA4=;
        b=RNOSyfWLDNXg5vBsPWFJ9M5iAXYU/iCqniUlT4fkteLZQh3Dx/yTSNzFD0bfkE1ZZjavX5
        j0rF87uhDN0lZPsd2ygQbFwQyipey16vzuQmiTgunc6RyhNQKkflKKw9VLlXWM6A5i6sUH
        qBXmp5gH9JV0Zb5Se/RVMpyiiq6alVM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2B69ABCC;
        Tue, 10 Nov 2020 16:07:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7719EDA7D7; Tue, 10 Nov 2020 17:05:54 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for v5.10-rc4
Date:   Tue, 10 Nov 2020 17:05:52 +0100
Message-Id: <cover.1605023716.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a handful of minor fixes and updates:

- handle missing device replace item on mount (syzbot report)

- fix space reservation calculation when finishing relocation

- fix memory leak on error path in ref-verify (debugging feature)

- fix potential overflow during defrag on 32bit arches

- minor code update to silence smatch warning

- minor error message updates

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit d5c8238849e7bae6063dfc16c08ed62cee7ee688:

  btrfs: convert data_seqcount to seqcount_mutex_t (2020-10-27 15:11:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.10-rc3-tag

for you to fetch changes up to 468600c6ec28613b756193c5f780aac062f1acdf:

  btrfs: ref-verify: fix memory leak in btrfs_ref_tree_mod (2020-11-05 13:03:39 +0100)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: dev-replace: fail mount if we don't have replace item with target device

Dan Carpenter (1):
      btrfs: clean up NULL checks in qgroup_unreserve_range()

David Sterba (1):
      btrfs: scrub: update message regarding read-only status

Dinghao Liu (1):
      btrfs: ref-verify: fix memory leak in btrfs_ref_tree_mod

Josef Bacik (2):
      btrfs: print the block rsv type when we fail our reservation
      btrfs: fix min reserved size calculation in merge_reloc_root

Matthew Wilcox (Oracle) (1):
      btrfs: fix potential overflow in cluster_pages_for_defrag on 32bit arch

 fs/btrfs/block-rsv.c   |  3 ++-
 fs/btrfs/dev-replace.c | 26 ++++++++++++++++++++++++--
 fs/btrfs/ioctl.c       | 10 ++++------
 fs/btrfs/qgroup.c      | 12 ++++--------
 fs/btrfs/ref-verify.c  |  1 +
 fs/btrfs/relocation.c  |  4 +++-
 fs/btrfs/scrub.c       |  5 +++--
 fs/btrfs/volumes.c     | 26 +++++++-------------------
 8 files changed, 48 insertions(+), 39 deletions(-)
