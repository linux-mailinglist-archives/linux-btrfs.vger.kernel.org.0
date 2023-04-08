Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBC6DB789
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDHAK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDHAKV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC4C1206F;
        Fri,  7 Apr 2023 17:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BDB064D4F;
        Sat,  8 Apr 2023 00:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D6CC433EF;
        Sat,  8 Apr 2023 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912620;
        bh=Y24E//AFgJa1BYqzIZQkT51HDOY1pbQOmULD9FbfvAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHa2zWGkNnPCMRm5l7XNKscXmiMhJV1YxIpVRbFAqdMBe7z/X2yG/UFRJQigvmnFe
         dzgvW+MBR216DGe/Cu7iofmfmGk1D/4G++oRoPy1Am9LU7Mcy7zPIbQy5sI5BHz3F4
         6Mqzz2sM59+tej9aHjLWwob+2cv0rxYcJO8YSJCBTWFFfE7GQ2bDtgLh3J9Y6XIWHb
         exDJ3DVS9kBlnFOJfX833qv7Kch3vUQkiEZAub5Ok9nPCH+X6iMHJNC5b/VAp+BTDF
         f7PqKWuQrT0MukhkYsVbpgtIHk+/922FxoWEI/DObimNdhnBwKdV+NLkpCAfd397HC
         1+mrwMAQNE8iA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 04/11] btrfs: Mark btrfs_assertfail() __noreturn
Date:   Fri,  7 Apr 2023 17:09:57 -0700
Message-Id: <b9278cfeebb773013cee73cd959d070f9aa14c58.1680912057.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680912057.git.jpoimboe@kernel.org>
References: <cover.1680912057.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes a bunch of warnings including:

  vmlinux.o: warning: objtool: select_reloc_root+0x314: unreachable instruction
  vmlinux.o: warning: objtool: finish_inode_if_needed+0x15b1: unreachable instruction
  vmlinux.o: warning: objtool: get_bio_sector_nr+0x259: unreachable instruction
  vmlinux.o: warning: objtool: raid_wait_read_end_io+0xc26: unreachable instruction
  vmlinux.o: warning: objtool: raid56_parity_alloc_scrub_rbio+0x37b: unreachable instruction
  ...

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302210709.IlXfgMpX-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 fs/btrfs/messages.c   | 2 +-
 fs/btrfs/messages.h   | 2 +-
 tools/objtool/check.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index fde5aaa6e7c9..310a05cf95ef 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -253,7 +253,7 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 #endif
 
 #ifdef CONFIG_BTRFS_ASSERT
-void __cold btrfs_assertfail(const char *expr, const char *file, int line)
+void __cold __noreturn btrfs_assertfail(const char *expr, const char *file, int line)
 {
 	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
 	BUG();
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 8c516ee58ff9..ac2d1982ba3d 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -160,7 +160,7 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_BTRFS_ASSERT
-void __cold btrfs_assertfail(const char *expr, const char *file, int line);
+void __cold __noreturn btrfs_assertfail(const char *expr, const char *file, int line);
 
 #define ASSERT(expr)						\
 	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4e89342dd8fb..a8714d62074e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -204,6 +204,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__ubsan_handle_builtin_unreachable",
 		"arch_call_rest_init",
 		"arch_cpu_idle_dead",
+		"btrfs_assertfail",
 		"cpu_bringup_and_idle",
 		"cpu_startup_entry",
 		"do_exit",
-- 
2.39.2

