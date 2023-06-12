Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361E472CD15
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjFLRnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjFLRm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 13:42:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93DC134;
        Mon, 12 Jun 2023 10:42:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6554D1FED7;
        Mon, 12 Jun 2023 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686591773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=99vpEICvigx+ygrbi3e1Y9v/VVIDBGDRM8e8/FJz9R8=;
        b=BZXzq5Qhbp6aRXCV/eA7ajSTktm2ipNYObNXw9AEiiPPRWP0QEgColE7D00gA/RqsyL3WO
        rF/EZ/OoGqAV0wxL7p8Pt/w9iXp8HMsHlVmi1pXQwcyhGWRekVgY0og/yAPZbLYhbhIdbQ
        ZX1keMRDJxxyp0wXy8jZHQ3F1G7yXhg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 54C3C2C141;
        Mon, 12 Jun 2023 17:42:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE1C4DA9B5; Mon, 12 Jun 2023 19:36:35 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.4-rc7
Date:   Mon, 12 Jun 2023 19:36:33 +0200
Message-Id: <cover.1686588386.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes and regression fixes. This pull request got a bit
delayed due to testing and there are at least two more fixes I'd like to
get merged to 6.4-rc7, expected to be sent in time.

Please pull, thanks.

- in subpage mode, fix crash when repairing metadata at the and of a
  stripe

- properly enable async discard when remounting from read-only to
  read-write

- scrub regression fixes:
  - respect read-only scrub when attempting to do a repair
  - fix reporting of found errors, the stats don't get properly
    accounted after a stripe repair

----------------------------------------------------------------
The following changes since commit b675df0257bb717082f592626da3ddfc5bdc2b6b:

  btrfs: zoned: fix dev-replace after the scrub rework (2023-06-01 15:12:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc6-tag

for you to fetch changes up to 79b8ee702c918f1936e17cc53e14bec388ce1045:

  btrfs: scrub: also report errors hit during the initial read (2023-06-08 14:34:01 +0200)

----------------------------------------------------------------
Chris Mason (1):
      btrfs: properly enable async discard when switching from RO->RW

Qu Wenruo (3):
      btrfs: subpage: fix a crash in metadata repair path
      btrfs: scrub: respect the read-only flag during repair
      btrfs: scrub: also report errors hit during the initial read

 fs/btrfs/disk-io.c |  9 +++++----
 fs/btrfs/scrub.c   | 26 +++++++++++++++++++-------
 fs/btrfs/super.c   |  6 ++++++
 3 files changed, 30 insertions(+), 11 deletions(-)
