Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891BF6E02C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjDLXuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDLXuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DED5B9E;
        Wed, 12 Apr 2023 16:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C3163A2B;
        Wed, 12 Apr 2023 23:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01467C4339E;
        Wed, 12 Apr 2023 23:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343400;
        bh=kvG3H+OIAWXFjmeScZQ5OyTT3agYgY+swBBAawU/vT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g84NhPx3el9/Dq7PrS4JqXMoHc27uH4b3pzoeRHPBrkmq9Ke3wgjwV3Xbopya1G+p
         31qfotzlyI+uEGs+fTX6jKNLxNocjJKs2G/bOGzUdMVb3Tl8zXPHB2dG+2UlrGJpro
         QUVYNKEKQ2g+2muE8ZnHNnTS28voWmZWUkGXVNXbyWtdo7U+0ms/Tnvm7qQ7S5zJHh
         ilgnHKbMZSPTuxKaEzIQ7gDLqnUNEjnc7FUoRRaY0pDqid55suJEjTuVu8sah/gpN8
         pdSFFkFHQg635J1Fhe8d/CW/94uzpOiRFXou+l840L9j3Qaagfd5rnfZISuWDRm66G
         aF/v5K3uzqxAQ==
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
Subject: [PATCH v2 04/11] arm64/cpu: Mark cpu_park_loop() and friends __noreturn
Date:   Wed, 12 Apr 2023 16:49:34 -0700
Message-Id: <55787d3193ea3e295ccbb097abfab0a10ae49d45.1681342859.git.jpoimboe@kernel.org>
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

In preparation for marking panic_smp_self_stop() __noreturn across the
kernel, first mark the arm64 implementation of cpu_park_loop() and
related functions __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/exception.h | 4 ++--
 arch/arm64/include/asm/smp.h       | 6 +++---
 arch/arm64/kernel/entry-common.c   | 2 +-
 arch/arm64/kernel/smp.c            | 8 +++++---
 arch/arm64/kernel/traps.c          | 3 +--
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 92963f98afec..e73af709cb7a 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -31,7 +31,7 @@ static inline unsigned long disr_to_esr(u64 disr)
 	return esr;
 }
 
-asmlinkage void handle_bad_stack(struct pt_regs *regs);
+asmlinkage void __noreturn handle_bad_stack(struct pt_regs *regs);
 
 asmlinkage void el1t_64_sync_handler(struct pt_regs *regs);
 asmlinkage void el1t_64_irq_handler(struct pt_regs *regs);
@@ -80,5 +80,5 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
 void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags);
 
-void panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far);
+void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far);
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 5733a31bab08..07f4ea1490f4 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -101,9 +101,9 @@ extern int __cpu_disable(void);
 
 extern void __cpu_die(unsigned int cpu);
 extern void __noreturn cpu_die(void);
-extern void cpu_die_early(void);
+extern void __noreturn cpu_die_early(void);
 
-static inline void cpu_park_loop(void)
+static inline void __noreturn cpu_park_loop(void)
 {
 	for (;;) {
 		wfe();
@@ -123,7 +123,7 @@ static inline void update_cpu_boot_status(int val)
  * which calls for a kernel panic. Update the boot status and park the calling
  * CPU.
  */
-static inline void cpu_panic_kernel(void)
+static inline void __noreturn cpu_panic_kernel(void)
 {
 	update_cpu_boot_status(CPU_PANIC_KERNEL);
 	cpu_park_loop();
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cce1167199e3..3af3c01c93a6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -840,7 +840,7 @@ UNHANDLED(el0t, 32, error)
 #endif /* CONFIG_COMPAT */
 
 #ifdef CONFIG_VMAP_STACK
-asmlinkage void noinstr handle_bad_stack(struct pt_regs *regs)
+asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
 	unsigned long far = read_sysreg(far_el1);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d5d09a18b4f8..07d156fddb5f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -398,7 +398,7 @@ static void __cpu_try_die(int cpu)
  * Kill the calling secondary CPU, early in bringup before it is turned
  * online.
  */
-void cpu_die_early(void)
+void __noreturn cpu_die_early(void)
 {
 	int cpu = smp_processor_id();
 
@@ -816,7 +816,7 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static void local_cpu_stop(void)
+static void __noreturn local_cpu_stop(void)
 {
 	set_cpu_online(smp_processor_id(), false);
 
@@ -839,7 +839,7 @@ void panic_smp_self_stop(void)
 static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 #endif
 
-static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 #ifdef CONFIG_KEXEC_CORE
 	crash_save_cpu(regs, cpu);
@@ -854,6 +854,8 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	/* just in case */
 	cpu_park_loop();
+#else
+	BUG();
 #endif
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4a79ba100799..4bb1b8f47298 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -863,7 +863,7 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr)
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
 
-void panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
+void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
@@ -905,7 +905,6 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
 	nmi_panic(regs, "Asynchronous SError Interrupt");
 
 	cpu_park_loop();
-	unreachable();
 }
 
 bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned long esr)
-- 
2.39.2

