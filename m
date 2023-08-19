Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B68781A5F
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Aug 2023 17:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjHSPm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Aug 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHSPm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Aug 2023 11:42:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DA82AEA6;
        Sat, 19 Aug 2023 08:42:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 510822188D;
        Sat, 19 Aug 2023 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692459744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hdjUwg0QTww8oD/Zk8sJGckdbwLnJeGLbWqIsBGMqgo=;
        b=JaAjOiMWaIxvaFoZDo0u2wyYy5blBAreySaJPB26ja5pH5apMQwSdyF5yAI+cWNzdgaRaq
        iFG+YxL2XckXflWWSClrD3oj+vLiE+jaKCKzD1/1IkJSQxpgMkMa9lJCjOCbKEm13nKzVg
        fEwxTq6JwnsjTbE6e7jiuCfMVvuHLYM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3D9F52C142;
        Sat, 19 Aug 2023 15:42:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C89ADA87A; Sat, 19 Aug 2023 17:35:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.5-rc7
Date:   Sat, 19 Aug 2023 17:35:53 +0200
Message-ID: <cover.1692453407.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more short fixes sent recently but still seem important enough for
a late rc. Please pull, thanks.

* fix infinite loop in readdir(), could happen in a big directory when
  files get renamed during enumeration

* fix extent map handling of skipped pinned ranges

* fix a corner case when handling ordered extent length

* fix a potential crash when balance cancel races with pause

* verify correct uuid when starting scrub or device replace

----------------------------------------------------------------
The following changes since commit 92fb94b69c6accf1e49fff699640fa0ce03dc910:

  btrfs: set cache_block_group_error if we find an error (2023-08-10 17:16:45 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc6-tag

for you to fetch changes up to c962098ca4af146f2625ed64399926a098752c9c:

  btrfs: fix incorrect splitting in btrfs_drop_extent_map_range (2023-08-18 14:38:10 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: fix replace/scrub failure with metadata_uuid

Chris Mason (1):
      btrfs: only subtract from len_to_oe_boundary when it is tracking an extent

Filipe Manana (1):
      btrfs: fix infinite directory reads

Josef Bacik (1):
      btrfs: fix incorrect splitting in btrfs_drop_extent_map_range

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance

 fs/btrfs/ctree.h         |   1 +
 fs/btrfs/delayed-inode.c |   5 +-
 fs/btrfs/delayed-inode.h |   1 +
 fs/btrfs/extent_io.c     |  25 ++++++++-
 fs/btrfs/extent_map.c    |   6 +--
 fs/btrfs/inode.c         | 131 ++++++++++++++++++++++++++++-------------------
 fs/btrfs/scrub.c         |   3 +-
 fs/btrfs/volumes.c       |   3 +-
 8 files changed, 113 insertions(+), 62 deletions(-)
