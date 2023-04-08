Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2BD6DB788
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjDHAKp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDHAKX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35712841;
        Fri,  7 Apr 2023 17:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F6E65552;
        Sat,  8 Apr 2023 00:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43311C4339C;
        Sat,  8 Apr 2023 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912621;
        bh=8Wpo0zdZjSmIBevJj4YHbI1z35ru0vEqHDShZ9RN6Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPH3LJbQUuUgStmeI351naBjZf2Xle7BGCsXSyYv664fqFiGn3/BUgOP1IPpRwQM/
         gaJT9+S/CmaeLo613fWQV0/0H8iEf74HRS5znCFEymCqTsmoK/4AEWXcJDoWu8p4HO
         Qol+GUA1uY8csEQd4SdYXXmX5vIkVmcj1Xt+xJ5Vy4DtDfD4Kfqfv97e5dyfQfLWhL
         1nS6wWvleWrP5H48QLwKTITjLoU9XKskv9Zyv21pC0KT5v3okaWLvCeKqtx2ecSqUk
         SMYtAK1QT5FYw76c1DZJF0kMRdBtXezSzTD72T0bCfFlU8WVyTQgUK0vDJArgMvrGM
         vT3+vmkNdBQwA==
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
Subject: [PATCH 07/11] cpu: Mark nmi_panic_self_stop() __noreturn
Date:   Fri,  7 Apr 2023 17:10:00 -0700
Message-Id: <b2792a3179b3bf857a140b55c9a073ec4531250e.1680912057.git.jpoimboe@kernel.org>
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

nmi_panic_self_stop() doesn't return.  Annotate it as such.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/reboot.h | 1 -
 arch/x86/kernel/reboot.c      | 2 +-
 include/linux/smp.h           | 2 +-
 kernel/panic.c                | 2 +-
 tools/objtool/check.c         | 1 +
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index bc5b4d788c08..9177b4354c3f 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -28,7 +28,6 @@ void __noreturn machine_real_restart(unsigned int type);
 void cpu_emergency_disable_virtualization(void);
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
-void nmi_panic_self_stop(struct pt_regs *regs);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
 void run_crash_ipi_callback(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index d03c551defcc..3adbe97015c1 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -920,7 +920,7 @@ void run_crash_ipi_callback(struct pt_regs *regs)
 }
 
 /* Override the weak function in kernel/panic.c */
-void nmi_panic_self_stop(struct pt_regs *regs)
+void __noreturn nmi_panic_self_stop(struct pt_regs *regs)
 {
 	while (1) {
 		/* If no CPU is preparing crash dump, we simply loop here. */
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 2a737b39cf0a..7b93504eed26 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -60,7 +60,7 @@ int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
  * Architecture-dependent code may override them.
  */
 void __noreturn panic_smp_self_stop(void);
-void nmi_panic_self_stop(struct pt_regs *regs);
+void __noreturn nmi_panic_self_stop(struct pt_regs *regs);
 void crash_smp_send_stop(void);
 
 /*
diff --git a/kernel/panic.c b/kernel/panic.c
index 5e4982db8dc9..886d2ebd0a0d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -151,7 +151,7 @@ void __weak __noreturn panic_smp_self_stop(void)
  * Stop ourselves in NMI context if another CPU has already panicked. Arch code
  * may override this to prepare for crash dumping, e.g. save regs info.
  */
-void __weak nmi_panic_self_stop(struct pt_regs *regs)
+void __weak __noreturn nmi_panic_self_stop(struct pt_regs *regs)
 {
 	panic_smp_self_stop();
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3d0531f5e491..c5621dd866e1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -218,6 +218,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"machine_real_restart",
 		"make_task_dead",
+		"nmi_panic_self_stop",
 		"panic",
 		"panic_smp_self_stop",
 		"rest_init",
-- 
2.39.2

