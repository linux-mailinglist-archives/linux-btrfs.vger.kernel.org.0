Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3168C71B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 20:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBFT4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 14:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFT4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 14:56:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D3E2820C;
        Mon,  6 Feb 2023 11:55:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D607220D16;
        Mon,  6 Feb 2023 19:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675713357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WoGUoqh11J03jqDXORRp3VVpc0HyYHs8ixizU+1AjIg=;
        b=M42hB5zumOWl9cpsqx5uBkCjJFjng2WobTLQ1DLTFwWwEW2zYPioj4Xu7h5HVbMkGv0PkH
        C0tbgCFl8MnN6smX05aLc7OwsbmglfaEmDoTqSVWmIbLTledx+DpR35A8GtJNtWpebxGPb
        9p4DCs6UNSrK51JU/vITTJTRh9IdEko=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C1F242C141;
        Mon,  6 Feb 2023 19:55:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B736ADA701; Mon,  6 Feb 2023 20:50:10 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for v6.2-rc8
Date:   Mon,  6 Feb 2023 20:50:09 +0100
Message-Id: <cover.1675710734.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more short fixes. Please pull, thanks.

- explicitly initialize zlib work memory to fix a KCSAN warning

- limit number of send clones by maximum memory allocated

- limit device size extent in case it device shrink races with chunk
  allocation

- raid56 fixes
  - fix copy&paste error in RAID6 stripe recovery
  - make error bitmap update atomic

----------------------------------------------------------------
The following changes since commit b7adbf9ada3513d2092362c8eac5cddc5b651f5c:

  btrfs: fix race between quota rescan and disable leading to NULL pointer deref (2023-01-16 19:46:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag

for you to fetch changes up to a9ad4d87aa263de36895402b66115a3a4b88bf1c:

  btrfs: raid56: make error_bitmap update atomic (2023-01-27 14:57:10 +0100)

----------------------------------------------------------------
Alexander Potapenko (1):
      btrfs: zlib: zero-initialize zlib workspace

David Sterba (1):
      btrfs: send: limit number of clones and allocated memory size

Josef Bacik (1):
      btrfs: limit device extents to the device size

Qu Wenruo (1):
      btrfs: raid56: make error_bitmap update atomic

Tanmay Bhushan (1):
      btrfs: raid56: fix stripes if vertical errors are found

 fs/btrfs/raid56.c  | 14 +++++++++++---
 fs/btrfs/send.c    |  6 +++---
 fs/btrfs/volumes.c |  6 +++++-
 fs/btrfs/zlib.c    |  2 +-
 4 files changed, 20 insertions(+), 8 deletions(-)
