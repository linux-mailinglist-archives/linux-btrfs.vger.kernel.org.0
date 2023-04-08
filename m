Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3056DB784
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDHAKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDHAKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A71206E;
        Fri,  7 Apr 2023 17:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD6F864D4F;
        Sat,  8 Apr 2023 00:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7D0C4339E;
        Sat,  8 Apr 2023 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912618;
        bh=Uj8qvA6tVwYHkeOEw6EH1HkVaBQz5yNjYfFgoQ2l3Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThOJu1eGVnufhV91YqV30QvYAYrKapqdIjQF/yQ+6AIGAsbM7dykiuh31HMVENA/m
         xQct/+xrweOjQZ93bCYxxqHRZgKpQeMZEhCmjmZlVeHAtVoDm9MNsXn+7A7ewO7X3s
         /GarU95zI9RNOuGH3XDfWjYHerrcek+QvfgyZE+PH82Lp+gKRgRw5J+oXQEcrnsKpd
         /TAm5rdI30s2xPl824l9x3FDrCoeDysbmki1vml2Nqhl/gt/SJhsts7zMBO1JWfwFA
         07fti7QcsprbBpB6rCKD34L+PL1Mn0a2bf4gA3mhaBBGg+hsQqoLdr/zAJ6sztrhzm
         XFWL7kQdGlZVQ==
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
Subject: [PATCH 01/11] init: Mark [arch_call_]rest_init() __noreturn
Date:   Fri,  7 Apr 2023 17:09:54 -0700
Message-Id: <b24a972397061a67d46ff5a98657e352040f427a.1680912057.git.jpoimboe@kernel.org>
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

  init/main.o: warning: objtool: start_kernel+0x4ad: unreachable instruction

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/s390/kernel/setup.c     | 2 +-
 include/linux/start_kernel.h | 4 ++--
 init/main.c                  | 4 ++--
 tools/objtool/check.c        | 2 ++
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 8ec5cdf9dadc..4259b6c50516 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -396,7 +396,7 @@ int __init arch_early_irq_init(void)
 	return 0;
 }
 
-void __init arch_call_rest_init(void)
+void __init __noreturn arch_call_rest_init(void)
 {
 	unsigned long stack;
 
diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
index 8b369a41c03c..864921e54c92 100644
--- a/include/linux/start_kernel.h
+++ b/include/linux/start_kernel.h
@@ -9,7 +9,7 @@
    up something else. */
 
 extern asmlinkage void __init start_kernel(void);
-extern void __init arch_call_rest_init(void);
-extern void __ref rest_init(void);
+extern void __init __noreturn arch_call_rest_init(void);
+extern void __ref __noreturn rest_init(void);
 
 #endif /* _LINUX_START_KERNEL_H */
diff --git a/init/main.c b/init/main.c
index 4425d1783d5c..161ed956d738 100644
--- a/init/main.c
+++ b/init/main.c
@@ -683,7 +683,7 @@ static void __init setup_command_line(char *command_line)
 
 static __initdata DECLARE_COMPLETION(kthreadd_done);
 
-noinline void __ref rest_init(void)
+noinline void __ref __noreturn rest_init(void)
 {
 	struct task_struct *tsk;
 	int pid;
@@ -889,7 +889,7 @@ static int __init early_randomize_kstack_offset(char *buf)
 early_param("randomize_kstack_offset", early_randomize_kstack_offset);
 #endif
 
-void __init __weak arch_call_rest_init(void)
+void __init __weak __noreturn arch_call_rest_init(void)
 {
 	rest_init();
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cae6ac6ff246..e7442e7ad676 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -202,6 +202,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__reiserfs_panic",
 		"__stack_chk_fail",
 		"__ubsan_handle_builtin_unreachable",
+		"arch_call_rest_init",
 		"arch_cpu_idle_dead",
 		"cpu_bringup_and_idle",
 		"cpu_startup_entry",
@@ -217,6 +218,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"make_task_dead",
 		"panic",
+		"rest_init",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
-- 
2.39.2

