Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1DC63A7FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 13:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiK1MQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiK1MQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 07:16:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB21DF2F;
        Mon, 28 Nov 2022 04:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F01E8B80D84;
        Mon, 28 Nov 2022 12:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3B5C433D7;
        Mon, 28 Nov 2022 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669637261;
        bh=nlOY7zSfhB7l9CHzXhnFvSsnJxZlXk2ZJ4sh66gZYoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQNCQjSZfiTJGtOoLcxaMC2+j+uihzS9Srew0kQN88m3aMjsBG0cQFcCk14UjMXuT
         W+2N1uWzsLmfwyAq5CCkCT77ST8CIYpiVuWVLlvUdstIXeUrOhKaF+uZ3EPQEEJJFO
         muqRr654gAiKXlfX3GM+DoT86fBk2nOcczcllmcnRKuRDJJQFN3+8a+awCz+BZ8ce/
         c2S92cJ9cz2iOrLFcNzxQmGr5YPKXey9856hYnbAsZowVKF3Cc4Q2B+WmtiCEpPqH3
         1Fk3gNq1V7roJZW3ZBxCRLS5TAi67gRYr2NWkzcbGFZ2JOYNKV5EGMMyfrH0VxFrEM
         /QZJ7g/5IwRow==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/4] btrfs: add a _require_btrfs_send_v2 helper
Date:   Mon, 28 Nov 2022 12:07:21 +0000
Message-Id: <28f1249372f13e5f73ba7f7c7478e80c6fc66474.1669636339.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669636339.git.fdmanana@suse.com>
References: <cover.1669636339.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a helper to check that both btrfs-progs and kernel support the v2 send
stream, so that we can have tests specific for send v2 stream.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index d27d3384..ee673a93 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -585,3 +585,17 @@ _require_btrfs_corrupt_block()
 {
 	_require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
 }
+
+_require_btrfs_send_v2()
+{
+	# Check first if btrfs-progs supports the v2 stream.
+	_require_btrfs_command send --compressed-data
+
+	# Now check the kernel support. If send_stream_version does not exists,
+	# then it's a kernel that only supports v1.
+	[ -f /sys/fs/btrfs/features/send_stream_version ] || \
+		_notrun "kernel does not support send stream v2"
+
+	[ $(cat /sys/fs/btrfs/features/send_stream_version) -gt 1 ] || \
+		_notrun "kernel does not support send stream v2"
+}
-- 
2.35.1

