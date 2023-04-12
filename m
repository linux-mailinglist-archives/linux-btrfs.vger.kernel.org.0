Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329716E02C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDLXuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDLXuD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243505FDC;
        Wed, 12 Apr 2023 16:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A86ED63A37;
        Wed, 12 Apr 2023 23:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEA2C4339C;
        Wed, 12 Apr 2023 23:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343401;
        bh=p1tYPEfnATWPjvd7AC13MBfWqcoZVqQm2IhBMP36i+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJl+9wBir02bixZWP1LeE/r7pFEoqZyAo4aB41f47jBsBRr250DxwCkh2WLcHKa75
         2WNwdoV+tU6/5k4VfqL1xcHeIrGGNMQ5hFmCyPqFIFqHxtVnH0s7szaXrT+8046vp9
         p4FRhTnCyptZPluX0D6XAmbxjhyLfif7jAwR881fRmAV0hBWH8BZgUQOPnWp/wmGDQ
         VCaFyF3FQyAdqu1UczDL4IW7NFRC4/LMKpx8jBcKVFJrPhMdmm9w4kqsCnBKfLvUHQ
         nACmVGX3HfWgZWwSQ1FQuTfQftUN6J/V90Cop8wHkjyJFm0Crgu9I+vKgY7iGbsoM5
         O45rxpH+MbgFw==
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
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 05/11] cpu: Mark panic_smp_self_stop() __noreturn
Date:   Wed, 12 Apr 2023 16:49:35 -0700
Message-Id: <92d76ab5c8bf660f04fdcd3da1084519212de248.1681342859.git.jpoimboe@kernel.org>
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

In preparation for improving objtool's handling of weak noreturn
functions, mark panic_smp_self_stop() __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm/kernel/smp.c          | 2 +-
 arch/arm64/include/asm/smp.h   | 1 -
 arch/arm64/kernel/smp.c        | 2 +-
 arch/powerpc/kernel/setup_64.c | 2 +-
 include/linux/smp.h            | 2 +-
 kernel/panic.c                 | 2 +-
 tools/objtool/check.c          | 1 +
 7 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d6be4507d22d..f4a4ac028b6b 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -779,7 +779,7 @@ void smp_send_stop(void)
  * kdump fails. So split out the panic_smp_self_stop() and add
  * set_cpu_online(smp_processor_id(), false).
  */
-void panic_smp_self_stop(void)
+void __noreturn panic_smp_self_stop(void)
 {
 	pr_debug("CPU %u will stop doing anything useful since another CPU has paniced\n",
 	         smp_processor_id());
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 07f4ea1490f4..f2d26235bfb4 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -143,7 +143,6 @@ bool cpus_are_stuck_in_kernel(void);
 
 extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
-extern void panic_smp_self_stop(void);
 
 #endif /* ifndef __ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 07d156fddb5f..05fe797e4203 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -830,7 +830,7 @@ static void __noreturn local_cpu_stop(void)
  * that cpu_online_mask gets correctly updated and smp_send_stop() can skip
  * CPUs that have already stopped themselves.
  */
-void panic_smp_self_stop(void)
+void __noreturn panic_smp_self_stop(void)
 {
 	local_cpu_stop();
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b2e0d3ce4261..246201d0d879 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -480,7 +480,7 @@ void early_setup_secondary(void)
 
 #endif /* CONFIG_SMP */
 
-void panic_smp_self_stop(void)
+void __noreturn panic_smp_self_stop(void)
 {
 	hard_irq_disable();
 	spin_begin();
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a80ab58ae3f1..2a737b39cf0a 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -59,7 +59,7 @@ int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
  * Cpus stopping functions in panic. All have default weak definitions.
  * Architecture-dependent code may override them.
  */
-void panic_smp_self_stop(void);
+void __noreturn panic_smp_self_stop(void);
 void nmi_panic_self_stop(struct pt_regs *regs);
 void crash_smp_send_stop(void);
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 5cfea8302d23..5e4982db8dc9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -141,7 +141,7 @@ EXPORT_SYMBOL(panic_blink);
 /*
  * Stop ourself in panic -- architecture code may override this
  */
-void __weak panic_smp_self_stop(void)
+void __weak __noreturn panic_smp_self_stop(void)
 {
 	while (1)
 		cpu_relax();
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4e89342dd8fb..43946188cd2c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -218,6 +218,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"make_task_dead",
 		"panic",
+		"panic_smp_self_stop",
 		"rest_init",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
-- 
2.39.2

