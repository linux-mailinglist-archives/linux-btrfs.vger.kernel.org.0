Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA53D6FC569
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjEILwY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjEILwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5330935B7;
        Tue,  9 May 2023 04:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9561564601;
        Tue,  9 May 2023 11:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A48C4339B;
        Tue,  9 May 2023 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683633140;
        bh=58A6LvltN2rVhtUMvkedw+tNCbvKp6WoTwCvXOI2cDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFV61BPaCPIs5FpayAkvqL5VesWuLw1GGixWijECI6/tQkYZNeKtwd2cXZHJxGGTV
         nKR9gjFLG1lzkMKwT3k+enX7HMTxva/azqbvUtpFiP66WMwbr3DtINV4VsRE5Mkasv
         ijaM6RZ6jcuDU/cHmvMk74w8mP4z7PzGT2sVJiCgApm41R2FxytfVVQq0lgMoNeccV
         3thudLQF9hkN6ED4o1/UbklYBpB2rxNYNTgMmTTJ7zm4F9Djq5AWPCj7WQFNvWYVl4
         bnRbTVnZdORrgSYbyvHqxtWad4bu91gtCry3h6DA4GYwBOxTnVqZPxr9zUZXoXRvxu
         HtWwwIAQG9S/A==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/3] groups: add logical_resolve group for btrfs
Date:   Tue,  9 May 2023 12:52:06 +0100
Message-Id: <a0924b8c782b146736555dc73305e15a9093f26c.1683632565.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683632565.git.fdmanana@suse.com>
References: <cover.1683632565.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a 'logical_resolve' group to identify tests that use the btrfs
logical-resolve command, which exercises btrfs' logical to ino ioctl.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 doc/group-names.txt | 1 +
 tests/btrfs/004     | 2 +-
 tests/btrfs/287     | 2 +-
 tests/btrfs/299     | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index 5fd8fe67..1c35a394 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -70,6 +70,7 @@ label			filesystem labelling
 limit			resource limits
 locks			file locking
 log			metadata logging
+logical_resolve		btrfs logical to ino ioctl (logical-resolve command)
 logprint		xfs_logprint functional tests
 long_rw			long-soak read write IO path exercisers
 metacopy		overlayfs metadata-only copy-up
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index aa37c45d..ea40dbf6 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -10,7 +10,7 @@
 # We check to end up back at the original file with the correct offset.
 #
 . ./common/preamble
-_begin_fstest auto rw metadata fiemap
+_begin_fstest auto rw metadata fiemap logical_resolve
 
 noise_pid=0
 
diff --git a/tests/btrfs/287 b/tests/btrfs/287
index a7e29e2b..a0b71c7e 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -7,7 +7,7 @@
 # Test btrfs' logical to inode ioctls (v1 and v2).
 #
 . ./common/preamble
-_begin_fstest auto quick snapshot clone punch
+_begin_fstest auto quick snapshot clone punch logical_resolve
 
 . ./common/filter
 . ./common/reflink
diff --git a/tests/btrfs/299 b/tests/btrfs/299
index 2ac05957..c4b1c7c5 100755
--- a/tests/btrfs/299
+++ b/tests/btrfs/299
@@ -15,7 +15,7 @@
 # resolution is still successful.
 #
 . ./common/preamble
-_begin_fstest auto quick preallocrw
+_begin_fstest auto quick preallocrw logical_resolve
 
 # real QA test starts here
 # Modify as appropriate.
-- 
2.35.1

