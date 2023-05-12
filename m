Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74AE701115
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjELV14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbjELV1w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 17:27:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF836A58;
        Fri, 12 May 2023 14:27:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E1A2F1F8D6;
        Fri, 12 May 2023 21:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683926863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mBHwPznEFSzQGbwFQrUkHu8Z9VxtkTwVQ1Xh8bzIlow=;
        b=CcJfyTzWn5uqgv4h6zXH5xyWn+tISKrtWLRMzabq+JI17FXXnAVCbDVr7YoIgykA6PtiVL
        f92SCfJU3Yhy9g1ar9B7lVlyjKiCrMDByEhIfIAX2hYtby0Fg+d3cHp20SK3yW6gYwJHtf
        d4323K0i0uz4eZhmqEgfQ9JaijAsDhw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CDD832C152;
        Fri, 12 May 2023 21:27:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 436F6DA7A0; Fri, 12 May 2023 23:21:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.4-rc2, part 2
Date:   Fri, 12 May 2023 23:21:43 +0200
Message-Id: <cover.1683909716.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes for stable trees. Please pull, thanks.

- fix incorrect number of bitmap entries for space cache if loading is
  interrupted by some error

- fix backref walking, this breaks a mode of LOGICAL_INO_V2 ioctl that
  is used in deduplication tools

- zoned mode fixes
  - properly finish zone reserved for relocation
  - correctly calculate super block zone end on ZNS
  - properly initialize new extent buffer for redirty

- make mount option clear_cache work with block-group-tree, to rebuild
  free-space-tree instead of temporarily disabling it that would lead to
  a forced read-only mount

- fix alignment check for offset when printing extent item

----------------------------------------------------------------
The following changes since commit d246331b78cbef86237f9c22389205bc9b4e1cc1:

  btrfs: don't free qgroup space unless specified (2023-05-03 16:37:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc1-tag

for you to fetch changes up to 1d6a4fc85717677e00fefffd847a50fc5928ce69:

  btrfs: make clear_cache mount option to rebuild FST without disabling it (2023-05-10 14:51:27 +0200)

----------------------------------------------------------------
Anastasia Belova (1):
      btrfs: print-tree: parent bytenr must be aligned to sector size

Christoph Hellwig (1):
      btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add

Filipe Manana (2):
      btrfs: fix space cache inconsistency after error loading it from disk
      btrfs: fix backref walking not returning all inode refs

Naohiro Aota (2):
      btrfs: zoned: zone finish data relocation BG with last IO
      btrfs: zoned: fix full zone super block reading on ZNS

Qu Wenruo (1):
      btrfs: make clear_cache mount option to rebuild FST without disabling it

 fs/btrfs/backref.c          | 19 +++++++++--------
 fs/btrfs/backref.h          |  6 ++++++
 fs/btrfs/disk-io.c          | 25 ++++++++++++++++-------
 fs/btrfs/free-space-cache.c |  7 ++++---
 fs/btrfs/free-space-tree.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/free-space-tree.h  |  3 ++-
 fs/btrfs/inode.c            |  3 +++
 fs/btrfs/print-tree.c       |  6 +++---
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/super.c            |  3 +--
 fs/btrfs/zoned.c            | 11 +++++-----
 11 files changed, 102 insertions(+), 33 deletions(-)
