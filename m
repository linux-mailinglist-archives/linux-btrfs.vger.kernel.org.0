Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA64FC6D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 23:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350209AbiDKViG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 17:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiDKViF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 17:38:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8733376;
        Mon, 11 Apr 2022 14:35:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DF44B21602;
        Mon, 11 Apr 2022 21:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649712947;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=R28uIVDq4qAGeIwTtENJyrG9YUAQBJ+HFp4P3OulMU8=;
        b=j9vSkizSx+tA64WhgaS9lAFKYq0GPLni6gmAQIy6inli8F9Mo6Bz90QqlF/5n4K4ZEKlU7
        0IdDc/gmY4rY1Q/z3i3mmxFN9GAgBncnOUQEkw9TWv3ZJMW5ixs/EvJfU+wvq1mvh1+eRo
        sF07OXaOOQLPar/tVdHuBMXigPiaoEM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D480AA3B89;
        Mon, 11 Apr 2022 21:35:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57086DA7F7; Mon, 11 Apr 2022 23:31:43 +0200 (CEST)
Date:   Mon, 11 Apr 2022 23:31:43 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.18-rc3
Message-ID: <cover.1649705056.git.dsterba@suse.com>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more code fixes and a warning fixes. There's one feature ioctl
removal patch slated for 5.18 that did not make it to the main pull
request.  It's just a one-liner and the ioctl has a v2 that's in use for
a long time, no point to postpone it to 5.19.

Please pull, thanks.

- fixes:
  - add back cgroup attribution for compressed writes
  - add super block write start/end annotations to asynchronous balance
  - fix root reference count on an error handling path
  - in zoned mode, activate zone at the chunk allocation time to avoid
    ENOSPC due to timing issues
  - fix delayed allocation accounting for direct IO

- remove balance v1 ioctl, superseded by v2 in 2012

- warning fixes:
  - simplify assertion condition in zoned check
  - remove an unused variable

----------------------------------------------------------------
The following changes since commit 60021bd754c6ca0addc6817994f20290a321d8d6:

  btrfs: prevent subvol with swapfile from being deleted (2022-03-24 17:50:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc2-tag

for you to fetch changes up to acee08aaf6d158d03668dc82b0a0eef41100531b:

  btrfs: fix btrfs_submit_compressed_write cgroup attribution (2022-04-06 00:50:51 +0200)

----------------------------------------------------------------
Dennis Zhou (1):
      btrfs: fix btrfs_submit_compressed_write cgroup attribution

Haowen Bai (1):
      btrfs: zoned: remove redundant condition in btrfs_run_delalloc_range

Jia-Ju Bai (1):
      btrfs: fix root ref counts in error handling in btrfs_get_root_ref

Naohiro Aota (4):
      btrfs: release correct delalloc amount in direct IO write path
      btrfs: mark resumed async balance as writing
      btrfs: return allocated block group from do_chunk_alloc()
      btrfs: zoned: activate block group only for extent allocation

Nathan Chancellor (1):
      btrfs: remove unused variable in btrfs_{start,write}_dirty_block_groups()

Nikolay Borisov (1):
      btrfs: remove support of balance v1 ioctl

 fs/btrfs/block-group.c | 40 +++++++++++++++++++++++++++-------------
 fs/btrfs/block-group.h |  4 ++++
 fs/btrfs/compression.c |  8 ++++++++
 fs/btrfs/disk-io.c     |  5 +++--
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/inode.c       |  9 ++++-----
 fs/btrfs/ioctl.c       |  2 --
 fs/btrfs/volumes.c     |  2 ++
 8 files changed, 49 insertions(+), 23 deletions(-)

