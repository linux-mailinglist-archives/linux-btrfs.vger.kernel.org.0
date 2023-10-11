Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547557C4F75
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjJKJ6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJKJ6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 05:58:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D292;
        Wed, 11 Oct 2023 02:58:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1E4A2185A;
        Wed, 11 Oct 2023 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697018283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HQSmUUZBVJ5b3nmvq9M/KUYK0ZtWlkHNQyINWl6ibRs=;
        b=ABHH5ajJOzu6q8ejrCXPkUSA+7x9SDRDT+ANigH7IirOeLHojRHg/9IgPgnpkmrxkkzCuX
        GKSoKr2DPrl0XdirALGAiOkNy/yclpR59ghenohuge4Nx7H/qAIdunAhlagyO7yTWGjOD4
        LdBFE83Y/vxceNz5RcbznuPTMuJRuzE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7DFD12C671;
        Wed, 11 Oct 2023 09:58:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C29DDA8C5; Wed, 11 Oct 2023 11:51:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.6-rc6
Date:   Wed, 11 Oct 2023 11:51:10 +0200
Message-ID: <cover.1697017675.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a revert of recent mount option parsing fix, this breaks mounts with
security options. The second patch is the flexible array annotation.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit e36f94914021e58ee88a8856c7fdf35adf9c7ee1:

  btrfs: error out when reallocating block for defrag using a stale transaction (2023-10-04 01:04:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc5-tag

for you to fetch changes up to 75f5f60bf7ee075ed4a29637ce390898b4c36811:

  btrfs: add __counted_by for struct btrfs_delayed_item and use struct_size() (2023-10-11 11:37:19 +0200)

----------------------------------------------------------------
David Sterba (1):
      Revert "btrfs: reject unknown mount options early"

Gustavo A. R. Silva (1):
      btrfs: add __counted_by for struct btrfs_delayed_item and use struct_size()

 fs/btrfs/delayed-inode.c | 2 +-
 fs/btrfs/delayed-inode.h | 2 +-
 fs/btrfs/super.c         | 4 ----
 3 files changed, 2 insertions(+), 6 deletions(-)
