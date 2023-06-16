Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF02973357F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jun 2023 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFPQNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jun 2023 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFPQNP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jun 2023 12:13:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563FB359E;
        Fri, 16 Jun 2023 09:13:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1452E1F749;
        Fri, 16 Jun 2023 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686931991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jUV5F1onpuE9Pjbo2RijvzWbMPt3gaxg5d/KUkj0P+8=;
        b=sOzikArASRrYdLe+jB0KB4ALjRmDLQZmCCB5IIdiWg1gIZur1LuC/362ReBG2/qGIX7L0N
        STBcSunZ9K+8CkHNHGL1QHsXCb0tzGwvUVSvbGCeDBHMmv4RA7X5F3HuSncmY7kPqOZI8E
        nIFyP54vVtCNk9Il3McecKq7z2vrC+A=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F13C52C141;
        Fri, 16 Jun 2023 16:13:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42F56DA7D7; Fri, 16 Jun 2023 18:06:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes 6.4-rc7, part 2
Date:   Fri, 16 Jun 2023 18:06:50 +0200
Message-Id: <cover.1686930269.git.dsterba@suse.com>
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

here's the second part, two fixes for NOCOW files, a regression fix in
scrub and an assertion fix. Please pull, thanks.

- NOCOW fixes:
  - keep length of iomap direct io request in case of a failure
  - properly pass mode of extent reference checking, this can break
    some cases for swapfile

- fix error value confusion when scrubbing a stripe

- convert assertion to a proper error handling when loading global
  roots, reported by syzbot

----------------------------------------------------------------
The following changes since commit 79b8ee702c918f1936e17cc53e14bec388ce1045:

  btrfs: scrub: also report errors hit during the initial read (2023-06-08 14:34:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc6-tag

for you to fetch changes up to b50f2d048ecf1512ff85128ea4153bceb0e60590:

  btrfs: scrub: fix a return value overwrite in scrub_stripe() (2023-06-14 18:30:30 +0200)

----------------------------------------------------------------
Chris Mason (1):
      btrfs: can_nocow_file_extent should pass down args->strict from callers

Christoph Hellwig (1):
      btrfs: fix iomap_begin length for nocow writes

Qu Wenruo (2):
      btrfs: do not ASSERT() on duplicated global roots
      btrfs: scrub: fix a return value overwrite in scrub_stripe()

 fs/btrfs/disk-io.c | 10 ++++++++--
 fs/btrfs/inode.c   | 20 +++++++++++++-------
 fs/btrfs/scrub.c   |  2 +-
 3 files changed, 22 insertions(+), 10 deletions(-)
