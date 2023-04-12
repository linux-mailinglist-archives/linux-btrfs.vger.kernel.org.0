Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E06E02CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDLXuP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLXuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D365FE0;
        Wed, 12 Apr 2023 16:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49220637C0;
        Wed, 12 Apr 2023 23:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D50FC433A0;
        Wed, 12 Apr 2023 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343401;
        bh=L2F/xi1PSFrTTzo1OeYf2miT5FskQWydRqNTuOMsSLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArojZA5AfgAYVbdaA5nwlw1jG/yfs7yE/sO2HSAuyTZEe77gdqFpGN47dnNspN74/
         VcTpa7jgqv8zZzS/CHw1vpHCY+2GSHJSuOHUc30VRMachOFY7doNABFbs0hls1q7iS
         Ze/T13uUDjWRYi4BMmUC0uMf4zhQBQOfvNxbqo4YfDeLZtBNOYyZ7dXNxO9YvOZuEQ
         qTscX90D+zeiYmsdx7ASI3Rq2qundmiuKkZlU75v4cf59pDh79i9oGnP4TWR4l+qjP
         4UgqNdkVjgNX+3VFbDwt3UCqQ9muhKJX1VimTryc2E07Iz88sOpSF9iv4cYASuGuNm
         g/6yJmytZD91w==
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
Subject: [PATCH v2 06/11] cpu: Mark nmi_panic_self_stop() __noreturn
Date:   Wed, 12 Apr 2023 16:49:36 -0700
Message-Id: <316fc6dfab5a8c4e024c7185484a1ee5fb0afb79.1681342859.git.jpoimboe@kernel.org>
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
functions, mark nmi_panic_self_stop() __noreturn.

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
index 43946188cd2c..ed42717463f9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -217,6 +217,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"machine_real_restart",
 		"make_task_dead",
+		"nmi_panic_self_stop",
 		"panic",
 		"panic_smp_self_stop",
 		"rest_init",
-- 
2.39.2

