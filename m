Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6849D6DB7AF
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDHAK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDHAKV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614841206E;
        Fri,  7 Apr 2023 17:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB03A654D3;
        Sat,  8 Apr 2023 00:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA00FC4339C;
        Sat,  8 Apr 2023 00:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912619;
        bh=ENervz53/wnYiq/jM6rz/PJ4Mr7rjEy1YUwRQmKVdYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vog0zB2xVU6rXZ83q4ZhYg9e8E2Kyx8CggkWT5YrDXlly3Ln0prP4ByeXsQDOItaG
         f20sOvdzcwGK2j7KRW/TP9s4Na6gnGV8k4wVDONN/bRwpITFPkN1CBbAl+4DL8e3Ri
         SarLCKieozC6Y0j7I9mqt+tDXQOkjT/NfMAEOAWEvemT8vi0Mh3ug38z3F3E7zUx/6
         Mxv6w9C3QRpFLMxg6xI577cybygJPyOu6BmW9PofP0r+DLAYx8cEVAcYHbiTStbr6b
         lqSFI2JVMtxdKDHrJ/M6UmDBZhIDAyNPgZOjEiNvFs2SfC5/bHKKIutcnsluLje0PZ
         IRHAlEf/rKw0g==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 03/11] x86/head: Mark *_start_kernel() __noreturn
Date:   Fri,  7 Apr 2023 17:09:56 -0700
Message-Id: <064f6f3473b39061aad3b9aa09f21b4fe724e5f9.1680912057.git.jpoimboe@kernel.org>
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

Fixes the following warning:

  vmlinux.o: warning: objtool: resume_play_dead+0x21: unreachable instruction

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/setup.h | 6 +++---
 arch/x86/kernel/head32.c     | 2 +-
 arch/x86/kernel/head64.c     | 4 ++--
 tools/objtool/check.c        | 2 ++
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f37cbff7354c..f3495623ac99 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -125,11 +125,11 @@ void clear_bss(void);
 
 #ifdef __i386__
 
-asmlinkage void __init i386_start_kernel(void);
+asmlinkage void __init __noreturn i386_start_kernel(void);
 
 #else
-asmlinkage void __init x86_64_start_kernel(char *real_mode);
-asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
+asmlinkage void __init __noreturn x86_64_start_kernel(char *real_mode);
+asmlinkage void __init __noreturn x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index ec6fefbfd3c0..10c27b4261eb 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -29,7 +29,7 @@ static void __init i386_default_early_setup(void)
 	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc;
 }
 
-asmlinkage __visible void __init i386_start_kernel(void)
+asmlinkage __visible void __init __noreturn i386_start_kernel(void)
 {
 	/* Make sure IDT is set up before any exception happens */
 	idt_setup_early_handler();
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 387e4b12e823..49f7629b17f7 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -471,7 +471,7 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_unmap_bootdata(real_mode_data);
 }
 
-asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
+asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode_data)
 {
 	/*
 	 * Build-time sanity checks on the kernel image and module
@@ -537,7 +537,7 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	x86_64_start_reservations(real_mode_data);
 }
 
-void __init x86_64_start_reservations(char *real_mode_data)
+void __init __noreturn x86_64_start_reservations(char *real_mode_data)
 {
 	/* version is always not zero if it is copied */
 	if (!boot_params.hdr.version)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a6f9a4aeb77b..4e89342dd8fb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -225,6 +225,8 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"start_kernel",
 		"stop_this_cpu",
 		"usercopy_abort",
+		"x86_64_start_kernel",
+		"x86_64_start_reservations",
 		"xen_cpu_bringup_again",
 		"xen_start_kernel",
 	};
-- 
2.39.2

