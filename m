Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5F54BDE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiFNWug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354776AbiFNWue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:50:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA9A51304
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:50:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1167D21BEF
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655247032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0PfdeR0t8yALKjCLm6yoKlI9/gzWinOK4dTedZZ3t4w=;
        b=Q3TZUHJEGqYBqDl9pFcPU8lXFs2W242yOt/QVLe1bwdiWQv5oLHNG8jVUux2WeBtnVL8jP
        gouVuKD6hbVb1OTRDjxaoFonJSB1KNmQ1B4RBsJgeauQQOGjFyEKoAIOMwhVzpyaXkrnZQ
        x7S6xZQbF81P1LqClNaXIPcUm9GO7Oc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CF65139EC
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JldZDrcQqWKVbgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH DRAFT 0/4] btrfs: introduce the WRITE_INTENT_BITMAP compat RO flag and extra per-dev reserved space for it
Date:   Wed, 15 Jun 2022 06:50:10 +0800
Message-Id: <cover.1655246405.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series of patches will mainly introduce two new compat RO flags:

- EXTRA_SUPER_RESERVED
  This will add a new btrfs_super_block member, reserved_bytes, to tell
  btrfs exactly how many bytes are reserved at the beginning of each
  device.

  By default, with this compat RO specified, mkfs.btrfs will reserved
  2MiB instead of the original 1MiB.
  So that extra 1MiB can be used by other features.

  In theory, EXTRA_SUPER_RESERVED doesn't require any extra space to be
  reserved, thus we can even keep the old 1MiB reservation but just make
  it explicit in the super block.

- WRITE_INTENT_BITMAP
  Currently it's still just a place holder.
  It will utilize the extra 1MiB space as a per-device write-intent
  bitmap.
  The idea will be the same as md-bitmap, but only for RAID56
  profiles for now.

  At mount time, even for RO mount, we will do a mandatory scrub for the
  ranges involved in the bitmap, to close the RAID56 write-hole.


  If this compat RO is set while not enough reserved space or without
  EXTRA_SUPER_RESERVED compat RO, we may want to reject the mount and
  provide a way to mount without write intent bitmap.
  But that would be implemented when the feature is really implemented.

The first 2 patches patches are just cleanup and add extra warning when
the existing 1MiB reservation is not properly respected.

More heavy-lifting work will be done in btrfs-progs.

Qu Wenruo (4):
  btrfs: introduce BTRFS_DEFAULT_RESERVED macro
  btrfs: warn about dev extents that are inside the reserved range
  btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
  btrfs: introduce a new experimental compat RO flag,
    WRITE_INTENT_BITMAP

 fs/btrfs/ctree.h           | 30 +++++++++++++++++++++++---
 fs/btrfs/disk-io.c         | 29 +++++++++++++++++++++++++
 fs/btrfs/extent-tree.c     |  6 +++---
 fs/btrfs/super.c           | 10 ++++-----
 fs/btrfs/sysfs.c           |  2 ++
 fs/btrfs/volumes.c         | 43 ++++++++++++++++++++++++++++++++------
 fs/btrfs/zoned.c           |  8 +++++++
 include/uapi/linux/btrfs.h | 17 +++++++++++++++
 8 files changed, 128 insertions(+), 17 deletions(-)

-- 
2.36.1

