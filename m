Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1CA622AD7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 12:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiKILoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 06:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiKILoD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 06:44:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A72E11806;
        Wed,  9 Nov 2022 03:43:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E0961A22;
        Wed,  9 Nov 2022 11:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8847AC433D6;
        Wed,  9 Nov 2022 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667994225;
        bh=qBbngR9xj0bXu/su2pMcrG/L+urCliVi+jLqjt+8MhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYQ/PN7X+WjW8RAu11RPC/E3pDzoofb0GjSDBQirH0HFYOHT0//ApC6cuqMidxGoZ
         VMqGfW0AI0I6bN00P1E0QY1tIls0/jY/Jdp0/dNXvnXm2FyargLG7cwkeh0fe1Le4S
         TZmnwjDnazJRP6CDqMxlqZIR/XEEZIhXQfCOZia+5ktFms/lt1nCDwr4g9NzEQwiQL
         VCX/NLfkDlHdDI+e41RXprwN1RfxRYIlRrH4lNTf/oTjpyXze7RaDhYPnYZWz8Aeh7
         kDSr3mQymQ/o+dN9MeNhZfDYRrkclH75QEQWOVDMfBvAoxpuUWo7/hTi6CKiVZdu1U
         vIlSNv9GlIRTA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/3] btrfs/053: fix test failure when running with btrfs-progs v6.0+
Date:   Wed,  9 Nov 2022 11:43:35 +0000
Message-Id: <a97dca4502e29bdd56f711060416a5992dcaea73.1667993961.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667993961.git.fdmanana@suse.com>
References: <cover.1667993961.git.fdmanana@suse.com>
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

In btrfs-progs v6.0 the --leafsize (-l) command line option was removed,
so btrfs/053 always fails with v6.0+.

The change was introduced by the following btrfs-progs commit:

  f7a768d62498 ("btrfs-progs: mkfs: remove support for option --leafsize")

Change the test to use --nodesize (-n) instead, since it exists in both
old and new btrfs-progs versions.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/053 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/053 b/tests/btrfs/053
index fbd2e7d9..c0446257 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -44,7 +44,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
 rm -fr $send_files_dir
 mkdir $send_files_dir
 
-_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
+_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1
 _scratch_mount
 
 echo "hello world" > $SCRATCH_MNT/foobar
@@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 _scratch_unmount
 _check_scratch_fs
 
-_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
+_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1
 _scratch_mount
 
 _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-- 
2.35.1

