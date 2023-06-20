Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FD737431
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjFTSaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjFTSa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 14:30:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DAA1718;
        Tue, 20 Jun 2023 11:30:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C825218A0;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687285824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zq1z3U5IAtvjtp2bBDIsg7ir5yq0cMT3vnb9mvXSoKs=;
        b=U3Vbhk02KNcLM5Xhj3qZVUUzR1JV9gRsRUX0rF5lDpVZSMSSKLWbhz2wSoJq5U/OyrH8jk
        Aprjui7cGpC4TKljD8uoCJvlVQBC7BJRzBJ7jNEy+ZvemjWwNS9HJ+Rztw9Ksi2oyDhGJX
        Opfbhzdhh20OHWWSJbBYdWaOA8soSA4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4995A2C141;
        Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2852EDA7D7; Tue, 20 Jun 2023 20:24:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.4-rc8
Date:   Tue, 20 Jun 2023 20:24:01 +0200
Message-Id: <cover.1687283675.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

one more regression fix for an assertion failure that uncovered a nasty
problem with stripe calculations. This is caused by a u32 overflow when
there are enough devices. The fstests require 6 so this hasn't been
caught, I was able to hit it with 8.

The fix is minimal and only adds u64 casts, we'll clean that up later. I
did various additional tests to be sure. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit b50f2d048ecf1512ff85128ea4153bceb0e60590:

  btrfs: scrub: fix a return value overwrite in scrub_stripe() (2023-06-14 18:30:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag

for you to fetch changes up to a7299a18a179a9713651fce9ad00972a633c14a9:

  btrfs: fix u32 overflows when left shifting stripe_nr (2023-06-20 19:10:31 +0200)

----------------------------------------------------------------
Qu Wenruo (1):
      btrfs: fix u32 overflows when left shifting stripe_nr

 fs/btrfs/volumes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)
