Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37A6162F5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 13:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKBMqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiKBMqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 08:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386F2A409
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 05:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B696F61940
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 12:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A4C433B5
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667393201;
        bh=eUlRg65Zj+a3o09SpmUJW1yhWDPLRY7GxHov8GzHG8Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MqdNOIDGxsQl3lWBlAdBmPvMVs7UDKhuRZw3A2hfw4kCaPCiYI8ONL98Jw6nsyPw/
         8Q6x/r5NELSYm3fALYy5Uc+igVBGdRVZWyLjbkJCmHLhftRrp8xUiUIEE4nvUVzCPW
         Q+73fGoMitsmkyWA0RT8HLf6+L1L0JEExmRKpZeVEoP+hO06orGtSLKSBA99JUPR5u
         5b9HdFzxy1HBlXK640MV4ukh3HQXcn2UP0pZci1XmXynm7eJDD81M4I7wiVuBhJKnB
         OjN/LOHWm3K4KagaJO+fAqlOiSA2JmatO7+MbndBdp7wZC2NhryPI6W07Jxk+xzbN9
         RoOh2Abdv0JfQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix nowait buffered write returning -ENOSPC
Date:   Wed,  2 Nov 2022 12:46:35 +0000
Message-Id: <4a8c46c2152ba9ab49e8002b66441354611c7c39.1667392727.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667392727.git.fdmanana@suse.com>
References: <cover.1667392727.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we are doing a buffered write in NOWAIT context and we can't reserve
metadata space due to -ENOSPC, then we should return -EAGAIN so that we
retry the write in a context allowed to block and do metadata reservation
with flushing, which might succeed this time due to the allowed flushing.

Returning -ENOSPC while in NOWAIT context simply makes some writes fail
with -ENOSPC when they would likely succeed after switching from NOWAIT
context to blocking context. That is unexpected behaviour and even fio
complains about it with a warning like this:

  fio: io_u error on file /mnt/sdi/task_0.0.0: No space left on device: write offset=1535705088, buflen=65536
  fio: pid=592630, err=28/file:io_u.c:1846, func=io_u error, error=No space left on device

The fio's job config is this:

   [global]
   bs=64K
   ioengine=io_uring
   iodepth=1
   size=2236962133
   nr_files=1
   filesize=2236962133
   direct=0
   runtime=10
   fallocate=posix
   io_size=2236962133
   group_reporting
   time_based

   [task_0]
   rw=randwrite
   directory=/mnt/sdi
   numjobs=4

So fix this by returning -EAGAIN if we are in NOWAIT context and the
metadata reservation failed with -ENOSPC.

Fixes: 304e45acdb8f ("btrfs: plumb NOWAIT through the write path")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b7855f794ba6..75d4d0bc9d8f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1286,6 +1286,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 						write_bytes);
 			else
 				btrfs_check_nocow_unlock(BTRFS_I(inode));
+
+			if (nowait && ret == -ENOSPC)
+				ret = -EAGAIN;
 			break;
 		}
 
-- 
2.35.1

