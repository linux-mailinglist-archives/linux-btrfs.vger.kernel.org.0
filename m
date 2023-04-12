Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D066E02D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDLXuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjDLXuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9726A47;
        Wed, 12 Apr 2023 16:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C2C263A3A;
        Wed, 12 Apr 2023 23:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5F3C433A0;
        Wed, 12 Apr 2023 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343403;
        bh=iZ5lUm1A5LpIA61E8JammGz5l3tFmx4jgPYIuFkcqac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAqSd4xnkXdo1AGfTwyObxtOaaHvtIUcM8i8W30SvuILvPWF7zWyNy8Y/mp/fU11i
         XI1yzw7Dxyh2PrADTJOzC7K1pgQYF/5yWjaqC/CeKhXoUOWG45vqhpxQqYzFnP+FMV
         aa2U3PcqCl9ZKxK4Hcz7/8SSUofyIlDykIYPILkBN9KpxiJZJQ1ZLNncjBWLr3UrN0
         DpI4aGjrhWhLLVbotT3v+CaXDOJeXx8JSbFqnyvAK8cGGKJzDp/Zm6wTdYlqoSXT0h
         Lxsw1XTGkT38/nLkvAzhi0w77Dw8AXOJsU1L20c0C2moKT2bOJd1uvctXbcO8fDjIC
         und7bHiiucFBA==
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
Subject: [PATCH v2 09/11] x86/cpu: Mark {hlt,resume}_play_dead() __noreturn
Date:   Wed, 12 Apr 2023 16:49:39 -0700
Message-Id: <ce1407c4bf88b1334fe40413126343792a77ca50.1681342859.git.jpoimboe@kernel.org>
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

Fixes the following warning:

  vmlinux.o: warning: objtool: resume_play_dead+0x21: unreachable instruction

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202301071838.6MpuHVQP-lkp@intel.com/
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
index 0b3522d66ddf..a42a2af99ea2 100644
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

