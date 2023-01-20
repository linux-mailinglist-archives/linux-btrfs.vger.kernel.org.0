Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883A2675AE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 18:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjATRPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 12:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjATRPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 12:15:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9595028D1C;
        Fri, 20 Jan 2023 09:15:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3A76122C64;
        Fri, 20 Jan 2023 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674234916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MFJCoGeSrihfzrkCuQjN/qpy9mLOBCjJnrpNLhgD4Lg=;
        b=jxbLdOZdQCnhWstLnBGQQX60A7hITEXelnnm24CPb+MYHl+MrG3vxfuHOn1q654eduLQBG
        2TcAfNdw2Ri5qKiqJfFWMXB9kXw8F7TvVPQirxRbFhN/DjlGP6RBsJVKULvXPiE8TNKNdn
        kxhL5fKkdfP5/1g6JCnW0hjuEN8NvRU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 313282C141;
        Fri, 20 Jan 2023 17:15:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E4A8DA7DE; Fri, 20 Jan 2023 18:09:37 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.2-rc5, part 2
Date:   Fri, 20 Jan 2023 18:09:36 +0100
Message-Id: <cover.1674232757.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are two more fixes and an update that's not a fix but replaces use
of write_one_page which is going to be removed (similar updates to other
filesystems go via other trees).

Please pull, thanks.

- fix potential out-of-bounds access to leaf data when seeking in an
  inline file

- fix potential crash in quota when rescan races with disable

- reimplement super block signature scratching by marking page/folio
  dirty and syncing block device, allow removing write_one_page

----------------------------------------------------------------
The following changes since commit 09e44868f1e03c7825ca4283256abedc95e249a3:

  btrfs: do not abort transaction on failure to update log root (2023-01-12 15:43:31 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc4-tag

for you to fetch changes up to b7adbf9ada3513d2092362c8eac5cddc5b651f5c:

  btrfs: fix race between quota rescan and disable leading to NULL pointer deref (2023-01-16 19:46:54 +0100)

----------------------------------------------------------------
Christoph Hellwig (2):
      btrfs: factor out scratching of one regular super block
      btrfs: stop using write_one_page in btrfs_scratch_superblock

Filipe Manana (2):
      btrfs: fix invalid leaf access due to inline extent during lseek
      btrfs: fix race between quota rescan and disable leading to NULL pointer deref

 fs/btrfs/file.c    | 13 ++++++++++---
 fs/btrfs/qgroup.c  | 25 +++++++++++++++++--------
 fs/btrfs/volumes.c | 50 +++++++++++++++++++++++++-------------------------
 3 files changed, 52 insertions(+), 36 deletions(-)
