Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07120602A76
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 13:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJRLoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiJRLoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 07:44:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2C87F243;
        Tue, 18 Oct 2022 04:43:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15B5E33E13;
        Tue, 18 Oct 2022 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666093434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xv0Xp2ACTMx4siFVEh8QVq7BeiWFDXEEpOE6xSyDW7o=;
        b=hM6XsVvougQYY83slRsBbkN2GH4F8MDI0HIGaZntqheYBlkCmvGUeJI/5ifxeAbJQ6maoA
        tGXi+QtTaiJH20W6/mh6pWiXthiO1ulsHRh8CCTa9+gfr8hGO2a4xzV66/oh/h+hIci59w
        HUf6W+14XPq50Ho/1DPW+gQp+FuVPus=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 09AFF2C141;
        Tue, 18 Oct 2022 11:43:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82574DA79D; Tue, 18 Oct 2022 13:43:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.1-rc2
Date:   Tue, 18 Oct 2022 13:43:44 +0200
Message-Id: <cover.1666091548.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following fixes, thanks.

- fiemap fixes:
  - add missing path cache update
  - fix processing of delayed data and tree refs during backref walking,
    this could lead to reporting incorrect extent sharing

- fix extent range locking under heavy contention to avoid deadlocks

- make it possible to test send v3 in debugging mode

- update links in MAINTAINERS

----------------------------------------------------------------
The following changes since commit cbddcc4fa3443fe8cfb2ff8e210deb1f6a0eea38:

  btrfs: set generation before calling btrfs_clean_tree_block in btrfs_init_new_buffer (2022-09-29 17:08:31 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc1-tag

for you to fetch changes up to 4efb365a3f04d0bee7833f168b0b00a15edefeac:

  MAINTAINERS: update btrfs website links and files (2022-10-14 13:54:21 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: send: allow protocol version 3 with CONFIG_BTRFS_DEBUG

David Sterba (3):
      btrfs: send: update command for protocol version check
      btrfs: delete stale comments after merge conflict resolution
      MAINTAINERS: update btrfs website links and files

Filipe Manana (4):
      btrfs: add missing path cache update during fiemap
      btrfs: fix processing of delayed data refs during backref walking
      btrfs: fix processing of delayed tree block refs during backref walking
      btrfs: ignore fiemap path cache if we have multiple leaves for a data extent

Josef Bacik (1):
      btrfs: unlock locked extent area if we have contention

 MAINTAINERS               |  6 ++--
 fs/btrfs/backref.c        | 84 ++++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/backref.h        |  1 +
 fs/btrfs/block-group.c    |  2 --
 fs/btrfs/extent-io-tree.c | 15 +++++----
 fs/btrfs/send.c           |  5 ++-
 fs/btrfs/send.h           |  5 +++
 7 files changed, 91 insertions(+), 27 deletions(-)
