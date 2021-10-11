Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA73B4289DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 11:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhJKJpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 05:45:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51370 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhJKJpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 05:45:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE10922042
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633945383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iRVpEcueLqGUJ8nfHpB26RW6gAKxhCjBGfgjNS9K2a0=;
        b=rzTgoArMS8CtvIqhBalaWlugy1Nuq2QkBwd1J2qH3nuGa0vAGbKujpWyR6SBtMsuBgvaDT
        YPdwuarJaq+0r4budMMTSQBDg+DQ74SxEqfcb8VjXlpbqYFQfPgi3Bj0tGpgGOZRhocz/8
        xnvJxopN6ayY37T4ygVLa1bShrpHVOI=
Received: from adam-pc.lan (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id CEA3CA3BB8
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 09:43:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: mkfs: make sure we can clean up all temporary chunks
Date:   Mon, 11 Oct 2021 17:42:57 +0800
Message-Id: <20211011094300.97504-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug report that with certain mkfs options, mkfs.btrfs may
fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
warning about multiple profiles:

  WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
  WARNING:   Metadata: single, raid1 

The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m dup
-d dup".

It turns out that, the old _recow_root() can not handle tree levels > 0,
while with newer free space tree creation timing, the free space tree
can reach level 1 or higher.

To fix the problem, Patch 2 will do the proper full tree re-CoW, with
extra transaction commitment to make sure all free space tree get
re-CoWed.

The 3rd patch will do the extra verification during mkfs-tests.

The first patch is just to fix a confusing parameter which also caused
u64 -> int width reduction and can be problematic in the future.

Qu Wenruo (3):
  btrfs-progs: rename @data parameter to @profile in extent allocation
    path
  btrfs-progs: mkfs: recow all tree blocks properly
  btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary
    chunks

 kernel-shared/extent-tree.c                 | 26 +++---
 mkfs/main.c                                 | 87 ++++++++++++++++++---
 tests/mkfs-tests/001-basic-profiles/test.sh | 10 ++-
 3 files changed, 97 insertions(+), 26 deletions(-)

-- 
2.33.0

