Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E38707EEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjERLKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 May 2023 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjERLKm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 May 2023 07:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639891990;
        Thu, 18 May 2023 04:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A0560FB6;
        Thu, 18 May 2023 11:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961DCC433EF;
        Thu, 18 May 2023 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684408145;
        bh=CrosyNiKN+VbYB0TAk9XjPn03zOR2tMCeI3pxXrP9YQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pxFVU8iJOJbOeOrapbaOe8m58gRT+3C/iazGfU/6OJxfUqj7Dw4WSXc0g3OjRCh9s
         DLMVATJHj9veUCCsaITEqfeVjozROrW5xqi9k0kfhYzTo48FiAT9UvBFVoxDlltNkD
         Tz95THDLqVYJbA06Nvi4JRTnWlgQ/joCKPrUWqUEV+lEnSxxuYSX+VvfRSh4AQKh8/
         XDC7fEy0c1RweiDXloq4/z0MsE7VDBfcZhFnlGMAu/76bJ8cUUnv0yddmOXgPOqckC
         uxM+9eTgGQdu9yUv3okmgetxxk2KWIs5LkFYLsVyivEDnxAqm+6VKTjZsYq/nQkRuA
         9RMAni7g16q7w==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/213: add _fixed_by_kernel_commit tag and remove from dangerous group
Date:   Thu, 18 May 2023 12:08:59 +0100
Message-Id: <85b3b1163e5ba55f1a253dc2eb74f570bec564fe.1684408127.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a _fixed_by_kernel_commit to identify the commit the fixed the issue
the test is trying to reproduce, which was:

  1dae7e0e58b4 "btrfs: reloc: clear DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance"

introduced in kernel 5.8-rc1. Also remove it from the dangerous group, as
the fix is from 2020 and it was backported to stable releases.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/213 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/213 b/tests/btrfs/213
index cca0b3cc..3ca63171 100755
--- a/tests/btrfs/213
+++ b/tests/btrfs/213
@@ -7,7 +7,7 @@
 # Test if canceling a running balance can lead to dead looping balance
 #
 . ./common/preamble
-_begin_fstest auto balance dangerous
+_begin_fstest auto balance
 
 # Override the default cleanup function.
 _cleanup()
@@ -25,6 +25,9 @@ _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command pwrite -D
 
+_fixed_by_kernel_commit 1dae7e0e58b4 \
+	"btrfs: reloc: clear DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance"
+
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 
-- 
2.34.1

