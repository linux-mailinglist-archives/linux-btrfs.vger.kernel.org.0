Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7846DB7A3
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDHAKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDHAKX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2E12079;
        Fri,  7 Apr 2023 17:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A65FD64D4F;
        Sat,  8 Apr 2023 00:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB62C433EF;
        Sat,  8 Apr 2023 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912621;
        bh=35Kr4V1gCXwWl/a9aoirKWVQHL2qZ8n8VvdR/pC7yWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVOlD6aaQoqrpAEF5eJGLGHhW4i3Kd8oLXdtD7DoqK3O86In16dewcqVT6toE//lU
         9hfVuhaXlV9AcwHtcnB5TLnHd8W96yVeqinIO13FkoALEe9z2dWq3b1URuck2T0mBe
         FNa+G4SYfjZNQ1CTDDdEL8jakrJNJHz1cmDiDclhgJxAcN9zfW1pSt3JhjBO0shUfi
         KIQ9gF4hZhZVy4gKr1qP3yXpUrIGosbCQFqEcd0MRIE1teYMjVlOaPQGuN7EYLCqLA
         i0S6VHlKUyy0u/aWGgtDKjDYuURxwlBKTrB1ONjw+EKwFHz9KhYoBgFMIgXUgnFzrZ
         owL+HagREDTOQ==
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
Subject: [PATCH 06/11] cpu: Mark panic_smp_self_stop() __noreturn
Date:   Fri,  7 Apr 2023 17:09:59 -0700
Message-Id: <fdbb80b87e4abcd0ae9536b7b92c997677af85c5.1680912057.git.jpoimboe@kernel.org>
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

panic_smp_self_stop() doesn't return.  Annotate it as such.

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
index a8714d62074e..3d0531f5e491 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -219,6 +219,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"make_task_dead",
 		"panic",
+		"panic_smp_self_stop",
 		"rest_init",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
-- 
2.39.2

