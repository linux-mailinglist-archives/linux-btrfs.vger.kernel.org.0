Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A85BE6C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiITNLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 09:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiITNLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 09:11:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B550C40BE6;
        Tue, 20 Sep 2022 06:11:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 76F2B21BA8;
        Tue, 20 Sep 2022 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663679473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Y+ch7kEqZlULY1OYrz7X2bciTsqw1ZdG1rZNdAu3Huo=;
        b=HAjDQBX35fnUAby92zS4m61T4ua3yWkbc1vsZtNQ2abeHuh4iEhmfGFBBgX7JhmdQBoJ2Q
        dHR7kpL0dUIJi+nuVOcBZk0e2iS9AubLQ9DCQFc4EXv/qSP20/wpmC0vUIZ6vSZ0J2oVH7
        qXrZqhiW0RU4MbGd/6Drx+T+OMw70Fw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 698932C141;
        Tue, 20 Sep 2022 13:11:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BFF8DDA8C5; Tue, 20 Sep 2022 15:05:43 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.0-rc7
Date:   Tue, 20 Sep 2022 15:05:42 +0200
Message-Id: <cover.1663677070.git.dsterba@suse.com>
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

a few more fixes, also for stable backports. Please pull, thanks.

- two fixes for hangs in the umount sequence where threads depend on
  each other and the work must be finished in the right order

- in zoned mode, wait for flushing all block group metadata IO before
  finishing the zone

----------------------------------------------------------------
The following changes since commit 5da431b71d4b9be3c8cf6786eff9e2d41a5f9f65:

  btrfs: fix the max chunk size and stripe length calculation (2022-09-06 17:49:58 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.0-rc6-tag

for you to fetch changes up to 2dd7e7bc02829eded71be2342a93dc035f5223f9:

  btrfs: zoned: wait for extent buffer IOs before finishing a zone (2022-09-13 14:05:18 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix hang during unmount when stopping block group reclaim worker
      btrfs: fix hang during unmount when stopping a space reclaim worker

Naohiro Aota (1):
      btrfs: zoned: wait for extent buffer IOs before finishing a zone

 fs/btrfs/disk-io.c | 42 ++++++++++++++++++++++++++++++++++++------
 fs/btrfs/zoned.c   | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 8 deletions(-)
