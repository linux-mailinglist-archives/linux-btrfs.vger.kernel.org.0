Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1286C742C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 00:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjCWXiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 19:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCWXh7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 19:37:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF722DE7D;
        Thu, 23 Mar 2023 16:37:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8255F338EC;
        Thu, 23 Mar 2023 23:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679614672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zBpz1dvx7Y466ilipp+W4Pn3BrJM32TOneNWpMSXPBo=;
        b=cTLqC7Woa5G+OmlykmaZ4deu+5XzO+N3zhbCt+GMxY0qe+fZucFT2GSvjW5x8DdI34n0R2
        aVC9UyerBH14x18HpSZnwTan7F7VeHIhAgixz5FQmEL5j8VrxcTwpqePvXoLjjOrYrb/Zp
        s/2udI4k9TGmbKNalQf1AoUtP77vnzc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6BE062C141;
        Thu, 23 Mar 2023 23:37:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DF7DDA7DE; Fri, 24 Mar 2023 00:31:41 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.3-rc4
Date:   Fri, 24 Mar 2023 00:31:40 +0100
Message-Id: <cover.1679610326.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes, the zoned accounting fix is spread across a few
patches, preparatory and the actual fixes. Please pull, thanks.

- zoned mode
  - fix accounting of unusable zone space
  - fix zone activation condition for DUP profile
  - preparatory patches

- improved error handling of missing chunks

- fix compiler warning

----------------------------------------------------------------
The following changes since commit 675dfe1223a69e270b3d52cb0211c8a501455cec:

  btrfs: fix block group item corruption after inserting new block group (2023-03-08 01:14:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc3-tag

for you to fetch changes up to e15acc25880cf048dba9df94d76ed7e7e10040e6:

  btrfs: zoned: drop space_info->active_total_bytes (2023-03-15 20:51:07 +0100)

----------------------------------------------------------------
Josef Bacik (2):
      btrfs: rename BTRFS_FS_NO_OVERCOMMIT to BTRFS_FS_ACTIVE_ZONE_TRACKING
      btrfs: use temporary variable for space_info in btrfs_update_block_group

Naohiro Aota (3):
      btrfs: zoned: fix btrfs_can_activate_zone() to support DUP profile
      btrfs: zoned: count fresh BG region as zone unusable
      btrfs: zoned: drop space_info->active_total_bytes

Qu Wenruo (1):
      btrfs: handle missing chunk mapping more gracefully

Sweet Tea Dorminy (1):
      btrfs: fix compiler warning on SPARC/PA-RISC handling fscrypt_setup_filename

 fs/btrfs/block-group.c      | 28 ++++++++++++----------------
 fs/btrfs/free-space-cache.c |  8 +++++++-
 fs/btrfs/fs.h               |  7 ++-----
 fs/btrfs/inode.c            |  7 ++++++-
 fs/btrfs/space-info.c       | 42 ++++++++++--------------------------------
 fs/btrfs/space-info.h       |  2 --
 fs/btrfs/volumes.c          |  3 ++-
 fs/btrfs/zoned.c            | 45 ++++++++++++++++++++++++++++++++-------------
 8 files changed, 71 insertions(+), 71 deletions(-)
