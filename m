Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465773BEAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjFWTEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 15:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWTE3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 15:04:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD71FE9;
        Fri, 23 Jun 2023 12:04:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B90301F88B;
        Fri, 23 Jun 2023 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687547066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4MmYwsBGJJnXZ3h7KxTBzFr25zuNofEdKLK6iBpVC6M=;
        b=ARARTjQMi5BQQoukSOODqJBp1sOmH+Cn3SGMPv/PH2CWMrjynWB701j68gwEdc2BWNdKJd
        zTYS2ZhvbM1H7wb2XHbfPNrEOrqr3QxVwf8qCsM8Mmlar0U/QVEPp1+E9DnuNfw04JaGWi
        mWYwMkhnhxZ9sX6+umfkvqSDqCrJvTY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A75F72C141;
        Fri, 23 Jun 2023 19:04:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 640ACDA85A; Fri, 23 Jun 2023 20:58:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.4-rc7, part 2
Date:   Fri, 23 Jun 2023 20:58:01 +0200
Message-Id: <cover.1687448378.git.dsterba@suse.com>
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

unfortunately the recent u32 overflow fix was not complete, there was
one conversion left, assertion not triggered by my tests but caught by
Qu's fstests case. The "cleanup for later" has been promoted to a proper
fix and wraps all uses of the stripe left shift so the diffstat has grown
but leaves no potentially problematic uses. We should have done it that
way before, sorry.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit a7299a18a179a9713651fce9ad00972a633c14a9:

  btrfs: fix u32 overflows when left shifting stripe_nr (2023-06-20 19:10:31 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag

for you to fetch changes up to cb091225a538005965b7c59c7c33ebe5358a5815:

  btrfs: fix remaining u32 overflows when left shifting stripe_nr (2023-06-22 17:03:55 +0200)

----------------------------------------------------------------
Qu Wenruo (1):
      btrfs: fix remaining u32 overflows when left shifting stripe_nr

 fs/btrfs/block-group.c  |  2 +-
 fs/btrfs/scrub.c        | 22 +++++++++++-----------
 fs/btrfs/tree-checker.c |  4 ++--
 fs/btrfs/volumes.c      | 29 +++++++++++++++--------------
 fs/btrfs/volumes.h      | 11 +++++++++++
 5 files changed, 40 insertions(+), 28 deletions(-)
