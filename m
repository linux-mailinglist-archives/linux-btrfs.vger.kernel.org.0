Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C837A8AC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 19:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjITRos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjITRor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 13:44:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91377C6;
        Wed, 20 Sep 2023 10:44:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C4D321EFD;
        Wed, 20 Sep 2023 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695231880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CvCpha75ppGhrQPyy+zvoIVH54+vq874hW3LP3zJbWg=;
        b=dZXOGz3bYiXEUA0rHpQlTEVzuqxob7mvZleto6Ef50A3VjCG/fPK3tg3wzcgZI2x+HRJPB
        RODaszQA/za/ZCdKRJmQLZHjr6xGd8fKMpk5AQPdbVuL/Am+nkUYwDVq+tcCKTffpBKYOL
        WmLjSs8JFRK2fyo4Zri5/HIqvSgNtWY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3155D2C142;
        Wed, 20 Sep 2023 17:44:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 066EDDA9EB; Wed, 20 Sep 2023 19:38:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.6-rc3
Date:   Wed, 20 Sep 2023 19:38:03 +0200
Message-ID: <cover.1695229068.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more followup fixes to the directory listing. People have noticed
different behaviour compared to other filesystems after changes in 6.5.
This is now unified to more "logical" and expected behaviour while still
within POSIX. And a few more fixes for stable.

Please pull, thanks.

- directory listing fixes
  - change behaviour of readdir()/rewinddir() when new directory entries
    are created after opendir(), properly tracking the last entry
  - fix race in readdir when multiple threads can set the last entry
    index for a directory

- use exclusive lock when direct io might need to drop privs and call
  notify_change()

- don't clear uptodate bit on page after an error, this may lead to a
  deadlock in subpage mode

- fix waiting pattern when multiple readers block on Merkle tree data,
  switch to folios

----------------------------------------------------------------
The following changes since commit 5facccc9402301d67d48bef06159b91f7e41efc0:

  MAINTAINERS: remove links to obsolete btrfs.wiki.kernel.org (2023-09-08 14:21:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc2-tag

for you to fetch changes up to 8e7f82deb0c0386a03b62e30082574347f8b57d5:

  btrfs: fix race between reading a directory and adding entries to it (2023-09-14 23:24:42 +0200)

----------------------------------------------------------------
Bernd Schubert (1):
      btrfs: file_remove_privs needs an exclusive lock in direct io write

Filipe Manana (3):
      btrfs: set last dir index to the current last index when opening dir
      btrfs: refresh dir last index during a rewinddir(3) call
      btrfs: fix race between reading a directory and adding entries to it

Josef Bacik (1):
      btrfs: don't clear uptodate on write errors

Matthew Wilcox (Oracle) (1):
      btrfs: convert btrfs_read_merkle_tree_page() to use a folio

 fs/btrfs/extent_io.c |  9 +-------
 fs/btrfs/file.c      | 16 +++++++++++--
 fs/btrfs/inode.c     | 33 +++++++++++++++++++--------
 fs/btrfs/verity.c    | 64 +++++++++++++++++++++++++---------------------------
 4 files changed, 69 insertions(+), 53 deletions(-)
