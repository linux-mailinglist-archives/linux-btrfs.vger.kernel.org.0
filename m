Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0498F62305C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiKIQpK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 11:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKIQpI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 11:45:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDDA26CE;
        Wed,  9 Nov 2022 08:45:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1EFE61965;
        Wed,  9 Nov 2022 16:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A985C433B5;
        Wed,  9 Nov 2022 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668012306;
        bh=s+wAfKA13O4jAHqnut4ePgTM90gidKgKQSE2wr/vBpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJx3RhbOjPJQVyd3cywVU5KFETRV6aggB1Z81xcgwFeSEV1lxwcNVq6CcUm0Im5N+
         WFJ9nRS5DL5Z4rlSw2B2knI5zj367IDIGFLtV9pumYqfs4eefqlnsOdnYZ33xC75OG
         lfpiDdUQ4ET5BON53QX+Siw+WVpE4BWu4wxcc/n3PWbhufzwDFTqwv4cx6F1mvRpJG
         g1QS7vt+nbzenotFRewJ/fQq27XZMe6CoAp6vlxm1mdEgT6zde8RofM+V+d5Opbr4M
         nofPBaSELrMhqcThtwPb9A/KWB6NXpnR8CZ6waMDuoFxyx+SpXBXnkTXv2lQt1au1W
         NvtHv2EviQ0mw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/3] btrfs/053: fix test failure when running with btrfs-progs v6.0+
Date:   Wed,  9 Nov 2022 16:44:57 +0000
Message-Id: <793a063833727ea80a1d0c6f13f531cff9581a1a.1668011940.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668011940.git.fdmanana@suse.com>
References: <cover.1668011940.git.fdmanana@suse.com>
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

In btrfs-progs v6.0 the --leafsize (-l) command line option was removed
from mkfs.btrfs, so btrfs/053 can fail with v6.0+ in case the scratch
device does not have a btrfs filesystem created before running the test,
in which case mounting the scratch device fails.

The change was introduced by the following btrfs-progs commit:

  f7a768d62498 ("btrfs-progs: mkfs: remove support for option --leafsize")

Change the test to use --nodesize (-n) instead, since it exists in both
old and new btrfs-progs versions. Also redirect mkfs output to the test's
log file and fail explicitly if mkfs failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/053 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/053 b/tests/btrfs/053
index fbd2e7d9..67239f10 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -44,7 +44,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
 rm -fr $send_files_dir
 mkdir $send_files_dir
 
-_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
+_scratch_mkfs "--nodesize $leaf_size" >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
 echo "hello world" > $SCRATCH_MNT/foobar
@@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 _scratch_unmount
 _check_scratch_fs
 
-_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
+_scratch_mkfs "--nodesize $leaf_size" >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
 _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-- 
2.35.1

