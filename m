Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433FE55B2AA
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jun 2022 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiFZPet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jun 2022 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZPes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jun 2022 11:34:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF3CBC89;
        Sun, 26 Jun 2022 08:34:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC4EA21D38;
        Sun, 26 Jun 2022 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656257685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=YBRdcRQGkGl7F8QD6nmHrqIMpqfMTq1AWLLsJs1w/ks=;
        b=kiiPHyfexzBf03MopxZNtsv2OA0OSML5Jz48jtnINyLK1IexmRrYhz/Ezx+OvfjPwDAKvR
        Z8srK1XFof5ErYlayP8thM65nBXB9BN7nRVNhX/ZZq87jrklHbj+RIuE5Wf1S6ppKEZewc
        GVhuwiHKERrriH/6y7vCk7yeSnm9wMY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2AF513AF9;
        Sun, 26 Jun 2022 15:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oZy3JpV8uGLtXQAAMHmgww
        (envelope-from <dsterba@suse.com>); Sun, 26 Jun 2022 15:34:45 +0000
Date:   Sun, 26 Jun 2022 17:30:05 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.19-rc4, part 2
Message-ID: <cover.1656256131.git.dsterba@suse.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes, they have been in testing branches for last weeks.
Please pull, thanks.

- zoned relocation fixes
  - fix critical section end for extent writeback, this could lead to
    out of order write
  - prevent writing to previous data relocation block group if space
    gets low

- reflink fixes
  - fix race between reflinking and ordered extent completion
  - proper error handling when block reserve migration fails
  - add missing inode iversion/mtime/ctime updates on each iteration
    when replacing extents

- fix deadlock when running fsync/fiemap/commit at the same time

- fix KCSAN report regarding pid tracking for read locks and data race,
  but that's a false alert

- minor documentation update and link to new site

----------------------------------------------------------------
The following changes since commit e3a4167c880cf889f66887a152799df4d609dd21:

  btrfs: add error messages to all unrecognized mount options (2022-06-07 17:29:50 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc3-tag

for you to fetch changes up to 037e127452b973f45b34c1e88a1af183e652e657:

  Documentation: update btrfs list of features and link to readthedocs.io (2022-06-21 14:47:19 +0200)

----------------------------------------------------------------
David Sterba (1):
      Documentation: update btrfs list of features and link to readthedocs.io

Filipe Manana (3):
      btrfs: fix race between reflinking and ordered extent completion
      btrfs: add missing inode updates on each iteration when replacing extents
      btrfs: do not BUG_ON() on failure to migrate space when replacing extents

Josef Bacik (1):
      btrfs: fix deadlock with fsync+fiemap+transaction commit

Naohiro Aota (2):
      btrfs: zoned: prevent allocation from previous data relocation BG
      btrfs: zoned: fix critical section of relocation inode writeback

Zygo Blaxell (1):
      btrfs: don't set lock_owner when locking extent buffer for reading

 Documentation/filesystems/btrfs.rst | 16 +++++--
 fs/btrfs/block-group.h              |  1 +
 fs/btrfs/ctree.h                    |  2 +
 fs/btrfs/extent-tree.c              | 20 +++++++-
 fs/btrfs/extent_io.c                |  3 +-
 fs/btrfs/file.c                     | 92 ++++++++++++++++++++++++++++++-------
 fs/btrfs/inode.c                    |  3 ++
 fs/btrfs/locking.c                  |  3 --
 fs/btrfs/reflink.c                  | 16 +++++--
 fs/btrfs/zoned.c                    | 27 +++++++++++
 fs/btrfs/zoned.h                    |  5 ++
 11 files changed, 158 insertions(+), 30 deletions(-)

