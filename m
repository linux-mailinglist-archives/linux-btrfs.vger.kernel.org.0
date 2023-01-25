Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4243C67B09B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 12:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjAYLH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 06:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjAYLHt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 06:07:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3844EFD;
        Wed, 25 Jan 2023 03:07:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2568614B5;
        Wed, 25 Jan 2023 11:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595EFC433EF;
        Wed, 25 Jan 2023 11:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674644866;
        bh=L8XTixrVtCzxClUEbNSHt2TV/A3T3CPgvgKiH449VHs=;
        h=From:To:Cc:Subject:Date:From;
        b=Qrq8A/27LGVku+Ap1nJ5SIaA7FLKVJdwLgrRTaxW/tStlTkuHIlTBSeD+1MHvgvnQ
         gAUQPwq6tnyE8FQZiMz/wH9iVNYzbebxfTI+5yF+JhUgqkF3seYSpdeOEIrRWFk6ey
         SMheLnJXgo5XYhAoS1a2o/kZOWVJkAjibcL6J0r7P53w8njv9KszhN++OwhB5XzYoU
         w571yHkUjT4h9W45763Yz1u/HcnbaBlizZh5pPitit2CzcVZgeXrDRm2Oaz08dw5GH
         BxCCaYBnpoqMp+LcaWtgMKuxrnfkLHA3ZO6LJF2/+KD6Z5PgBZOdj8Fz2nTQAPDqmF
         g4GnIFT5+VJPw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/299: update kernel commit hash and subject
Date:   Wed, 25 Jan 2023 11:07:39 +0000
Message-Id: <3ccaa4e5f43538891d312ba7e9e4b38d61434d35.1674644818.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
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

Test case btrfs/299 refers to a kernel patch with a subject of:

   "btrfs: fix logical_ino ioctl panic"

However when the patch was merged, the subject was renamed to:

   "btrfs: fix resolving backrefs for inline extent followed by prealloc"

So update the test with the correct subject and also add the commit's
hash from Linus' tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/299 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/299 b/tests/btrfs/299
index 42a08317..8ed23ac5 100755
--- a/tests/btrfs/299
+++ b/tests/btrfs/299
@@ -24,7 +24,8 @@ _require_scratch
 _require_xfs_io_command "falloc" "-k"
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_command inspect-internal logical-resolve
-_fixed_by_kernel_commit xxxxxxxx "btrfs: fix logical_ino ioctl panic"
+_fixed_by_kernel_commit 560840afc3e6 \
+	"btrfs: fix resolving backrefs for inline extent followed by prealloc"
 
 dump_tree() {
 	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV
-- 
2.35.1

