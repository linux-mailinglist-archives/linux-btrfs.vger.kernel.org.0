Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F86E02B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDLXuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLXuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4934B5B9E;
        Wed, 12 Apr 2023 16:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA38F63A2B;
        Wed, 12 Apr 2023 23:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9BBC433D2;
        Wed, 12 Apr 2023 23:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343399;
        bh=D1PxxQyGbxJncWR98elKYJag9U/gYQQR+2UhAcM/NEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHuMgxgjfEy4SierQZ2sxIiZlLB2lbs8Ibp0K1d1NFSccAR9RytMemYr5A7KsTWWm
         PZjyNvplQ3YRa1laix4/c5Sf0YIAJuXRgRmA69GbdwskdTzVtWKtDBQIGoCfbS+9lX
         cdR8EhzZor7Eea2kNQQxkddEnnqVH5DUQ11ksyibo7nR35T2GTD3/AUN9F2zRGmYjb
         WfHG8TPSI0DI4ZcilnfE5efKvVQHY/dly2+u0C/76BhHptk7MMZ+yOnuRZ+P2mihnS
         J59Xt1CkTd0dNo7v09y7iXIlq538V4KdcwmfbTHDnjZxCZw/8jdDl8WTcVGyeHx/aH
         j8FVZr8XCq2Qw==
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
Subject: [PATCH v2 02/11] init: Mark start_kernel() __noreturn
Date:   Wed, 12 Apr 2023 16:49:32 -0700
Message-Id: <7069acf026a195f26a88061227fba5a3b0337b9a.1681342859.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681342859.git.jpoimboe@kernel.org>
References: <cover.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that arch_call_rest_init() is __noreturn, mark its caller
start_kernel() __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/start_kernel.h | 2 +-
 init/main.c                  | 2 +-
 tools/objtool/check.c        | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
index 864921e54c92..a9806a44a605 100644
--- a/include/linux/start_kernel.h
+++ b/include/linux/start_kernel.h
@@ -8,7 +8,7 @@
 /* Define the prototype for start_kernel here, rather than cluttering
    up something else. */
 
-extern asmlinkage void __init start_kernel(void);
+extern asmlinkage void __init __noreturn start_kernel(void);
 extern void __init __noreturn arch_call_rest_init(void);
 extern void __ref __noreturn rest_init(void);
 
diff --git a/init/main.c b/init/main.c
index 161ed956d738..65aab4e9bb49 100644
--- a/init/main.c
+++ b/init/main.c
@@ -937,7 +937,7 @@ static void __init print_unknown_bootoptions(void)
 	memblock_free(unknown_options, len);
 }
 
-asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
+asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(void)
 {
 	char *command_line;
 	char *after_dashes;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e7442e7ad676..a6f9a4aeb77b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -222,6 +222,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
+		"start_kernel",
 		"stop_this_cpu",
 		"usercopy_abort",
 		"xen_cpu_bringup_again",
-- 
2.39.2

