Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25E6DB79E
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDHAKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDHAKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF2812847;
        Fri,  7 Apr 2023 17:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8AE8654D1;
        Sat,  8 Apr 2023 00:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD14DC4339B;
        Sat,  8 Apr 2023 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912622;
        bh=eVYaPId8ce8d6PYbI3Mu03+6x8GX6n+SsMHo/vPZiic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMy4BGJS+3nARfaGn4u139NCqpnjuRoGFtNtmdQZvlBRCuM206vdzrt6yQloN36cq
         caKtVhCFRMm9Vc9F4CROupEXd9fgLheYWVpc3AaspK2gXeAFTRVKXPTOrO9DxsyQVF
         1XYeZaBYNkx6hv9w4QZjMICQJyItUpoAW+EjC5yjvwNtpLiqpW7UdEm5rnwboEdhiF
         DB6uJNFH9kdRklDNNZ+rzqwZf1Yeadk61ir4UxW23Fjl77FtKYGoGoIp1C7nga+Jf2
         NCt1lyBAayhV6dbHujffEStGK8vVXV3vGdl9AlfuN4K2vGYr0aXz4jNopnBJyhTpTJ
         fs32cLl1TbGFA==
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
Subject: [PATCH 08/11] x86/cpu: Mark {hlt,resume}_play_dead() __noreturn
Date:   Fri,  7 Apr 2023 17:10:01 -0700
Message-Id: <f28f2dd16f7dcc3951988aa34b47fdf081ae2f36.1680912057.git.jpoimboe@kernel.org>
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
 arch/x86/include/asm/smp.h | 2 +-
 arch/x86/kernel/smpboot.c  | 2 +-
 arch/x86/power/cpu.c       | 2 +-
 tools/objtool/check.c      | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e6d1d2810e38..47ce4c79a3b0 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -125,7 +125,7 @@ int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_disable(void);
 int common_cpu_die(unsigned int cpu);
 void native_cpu_die(unsigned int cpu);
-void hlt_play_dead(void);
+void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9013bb28255a..a6da3f94b7b6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1816,7 +1816,7 @@ static inline void mwait_play_dead(void)
 	}
 }
 
-void hlt_play_dead(void)
+void __noreturn hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)
 		wbinvd();
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 236447ee9beb..7a4d5e911415 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -288,7 +288,7 @@ EXPORT_SYMBOL(restore_processor_state);
 #endif
 
 #if defined(CONFIG_HIBERNATION) && defined(CONFIG_HOTPLUG_CPU)
-static void resume_play_dead(void)
+static void __noreturn resume_play_dead(void)
 {
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c5621dd866e1..a926da218c01 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -212,6 +212,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_task_dead",
 		"ex_handler_msr_mce",
 		"fortify_panic",
+		"hlt_play_dead",
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
@@ -222,6 +223,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"panic",
 		"panic_smp_self_stop",
 		"rest_init",
+		"resume_play_dead",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
-- 
2.39.2

