Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6007869379F
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 14:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBLNki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 08:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLNkh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 08:40:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D211E9D;
        Sun, 12 Feb 2023 05:40:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5E6038A08;
        Sun, 12 Feb 2023 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676209233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9SlRZmWVPVtFPPifa6t4TaDcwDSrTcZa60wLhlbzX5w=;
        b=KmRKvfDt5eawC4chl43eBNVJPUJprBU/oyndVQD6JWUO6eTe+YZTdG8VOIgwIP/e1EsbVD
        WG/7yXO7SBjlt+2yI9kMCTi956Wn8A493ag1nJVkQ3ispqb2daCSqv7N4KTaKMQ+kSKbzN
        4zblJ0IPkevY/5OdwmOqFbJJZbKbBVk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A386B2C141;
        Sun, 12 Feb 2023 13:40:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AF554DA7E5; Sun, 12 Feb 2023 14:34:43 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.2-rc8, part 2
Date:   Sun, 12 Feb 2023 14:34:42 +0100
Message-Id: <cover.1676207493.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes for bugs that have some user visible impact (user and
syzbot reports). Please pull, thanks.

- one more fix for a tree-log 'write time corruption' report, update
  the last dir index directly and don't keep in the log context

- do VFS-level inode lock around FIEMAP to prevent a deadlock with
  concurrent fsync, the extent-level lock is not sufficient

- don't cache a single-device filesystem device to avoid cases when a
  loop device is reformatted and the entry gets stale

----------------------------------------------------------------
The following changes since commit a9ad4d87aa263de36895402b66115a3a4b88bf1c:

  btrfs: raid56: make error_bitmap update atomic (2023-01-27 14:57:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag

for you to fetch changes up to 5f58d783fd7823b2c2d5954d1126e702f94bfc4c:

  btrfs: free device in btrfs_close_devices for a single device filesystem (2023-02-09 17:02:51 +0100)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: free device in btrfs_close_devices for a single device filesystem

Filipe Manana (2):
      btrfs: simplify update of last_dir_index_offset when logging a directory
      btrfs: lock the inode in shared mode before starting fiemap

 fs/btrfs/extent_io.c |  2 ++
 fs/btrfs/tree-log.c  | 23 +++++++++++++++++------
 fs/btrfs/tree-log.h  |  2 --
 fs/btrfs/volumes.c   | 16 +++++++++++++++-
 4 files changed, 34 insertions(+), 9 deletions(-)
