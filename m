Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C06E02BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDLXuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDLXuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B016591;
        Wed, 12 Apr 2023 16:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9207863A39;
        Wed, 12 Apr 2023 23:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82751C4339E;
        Wed, 12 Apr 2023 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343403;
        bh=WcmvupRwpbJp5sb6WicMjnYrCS9HnOD5+y3zwejbCrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqy+Mp3YRnhT9iW1USJg1dD69mNFG2C8uDFMjUW5P3BR1YEeAr+flscDtxvNO+Mzm
         11Yu1m6xYIF5eYDdRj7IiC01nPMZ3MrqNmOFETBeeU01Jz0Fcyskxv4VHwb9BOsDFD
         pBV8zfvsJ70mIUgLvy9L6k8jF4T2f1pmmCV9/w4Q3GjYKzQapktCO2kxehM83nYTfa
         mnDer59waswZniXNhspDEMgR23R2wToN9q6ulxb4/bAvpDuVtFsM5eRxKbkWZ/R3uo
         OTk39AWvvkEo3FwnLIE9yUCvovKwa08+gKVr1JQ221ZIZiNDdhSiaCE4lwmG4m3F2J
         0EmRNgyssWneQ==
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 08/11] btrfs: Mark btrfs_assertfail() __noreturn
Date:   Wed, 12 Apr 2023 16:49:38 -0700
Message-Id: <960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681342859.git.jpoimboe@kernel.org>
References: <cover.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 94c16436d990..0b3522d66ddf 100644
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

