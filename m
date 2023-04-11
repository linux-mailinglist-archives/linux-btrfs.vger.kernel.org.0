Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DAA6DE390
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDKSMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDKSMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 14:12:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CB11713;
        Tue, 11 Apr 2023 11:12:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6BD6E1F74A;
        Tue, 11 Apr 2023 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681236748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=P3X3oJy/OBZsq1k20V6/GD69j5FU6jGKXyMOSg/ZOsU=;
        b=BI9ihQRdzt8yyKGDgZ04jE1UIQbAUj30zHMUYwtUWGHz0dxM8xsB9QiQOL4pHBM1tAVdwH
        TUzFOzqA9UYJ9JEvR4AkymqGDqqkKn2tIugP0uexTLDBATJHPEPL+W/NZLH/uNM3jLq8yT
        YFgQVweyqxp/LUDfOxD+dbK7K2vc+pk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 59E932C141;
        Tue, 11 Apr 2023 18:12:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0CD5ADA7DE; Tue, 11 Apr 2023 20:12:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.3-rc7
Date:   Tue, 11 Apr 2023 20:12:23 +0200
Message-Id: <cover.1681236364.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
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

two more fixes that have some user visible effects. Please pull, thanks.

- fix fast checksum detection, this affects filesystems with non-crc32c
  checksum, calculation would not be offloaded to worker threads

- restore thread_pool mount option behaviour for endio workers, the
  new value for maximum active threads would not be set to the actual
  work queues

----------------------------------------------------------------
The following changes since commit 2280d425ba3599bdd85c41bd0ec8ba568f00c032:

  btrfs: ignore fiemap path cache when there are multiple paths for a node (2023-03-29 01:16:23 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.3-rc6-tag

for you to fetch changes up to 68d99ab0e9221ef54506f827576c5a914680eeaf:

  btrfs: fix fast csum implementation detection (2023-04-06 16:34:13 +0200)

----------------------------------------------------------------
Christoph Hellwig (2):
      btrfs: restore the thread_pool= behavior in remount for the end I/O workqueues
      btrfs: fix fast csum implementation detection

 fs/btrfs/disk-io.c | 14 ++++++++++++++
 fs/btrfs/super.c   |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)
