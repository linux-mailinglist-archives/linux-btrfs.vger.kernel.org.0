Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55944C49CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbiBYP5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 10:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiBYP5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 10:57:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112811DC98A;
        Fri, 25 Feb 2022 07:57:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BCB601F380;
        Fri, 25 Feb 2022 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645804619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5TiYyUbi82Jc4N9YQSVkhw89f6hPd1w+8UfjYmR5n30=;
        b=ciky6OZbxV5jgiFZqdsa1os2xNkmiaBS43SX3NNV6sd/cKloeiIL/KcG+DO3MMR7A/J75D
        shPjWZurivt8YVWKzD/ytM0LmGV4B+VDEJs6W+AcwMByq+jwcEqrX2dLV6s2KnDvCBJvJb
        s2qfa3/0NeIqszwtmt91eJycDggW0To=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B5019A3B88;
        Fri, 25 Feb 2022 15:56:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E72C1DA818; Fri, 25 Feb 2022 16:53:09 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.17-rc6
Date:   Fri, 25 Feb 2022 16:53:04 +0100
Message-Id: <cover.1645801545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a hopefully last batch of fixes for defrag that got broken in
5.16, all stable material. The remaining reported problem is excessive
IO with autodefrag due to various conditions in the defrag code not met
or missing.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 2e7be9db125a0bf940c5d65eb5c40d8700f738b5:

  btrfs: send: in case of IO error log it (2022-02-09 18:53:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.17-rc5-tag

for you to fetch changes up to 558732df2122092259ab4ef85594bee11dbb9104:

  btrfs: reduce extent threshold for autodefrag (2022-02-24 16:11:28 +0100)

----------------------------------------------------------------
Dāvis Mosāns (1):
      btrfs: prevent copying too big compressed lzo segment

Qu Wenruo (8):
      btrfs: defrag: allow defrag_one_cluster() to skip large extent which is not a target
      btrfs: defrag: don't try to merge regular extents with preallocated extents
      btrfs: defrag: don't defrag extents which are already at max capacity
      btrfs: defrag: remove an ambiguous condition for rejection
      btrfs: defrag: bring back the old file extent search behavior
      btrfs: defrag: don't use merged extent map for their generation check
      btrfs: autodefrag: only scan one inode once
      btrfs: reduce extent threshold for autodefrag

 fs/btrfs/ctree.h      |   2 +-
 fs/btrfs/extent_map.c |   2 +
 fs/btrfs/extent_map.h |   8 ++
 fs/btrfs/file.c       |  97 +++++++------------
 fs/btrfs/inode.c      |   4 +-
 fs/btrfs/ioctl.c      | 256 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/lzo.c        |  11 +++
 7 files changed, 296 insertions(+), 84 deletions(-)
