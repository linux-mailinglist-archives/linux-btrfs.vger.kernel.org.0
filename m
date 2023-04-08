Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B586DB790
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDHAKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjDHAKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2271206D;
        Fri,  7 Apr 2023 17:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C50F654D0;
        Sat,  8 Apr 2023 00:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A3BC433EF;
        Sat,  8 Apr 2023 00:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912618;
        bh=fL3vAWc8aFXEM7bh/5Oz9xwxKse3WRA1+kRJbl4ypFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdWdkv0H/8KsW4Q4vTQq9Ak2p8LHjLTEeVWOmVAitqZmBAn3oZHk1jn5FA6zYYQYT
         9z/RSqugv05WyKppeQNTONIlyFQXp5fM7uw/ivKhJBZgO+sNWdDgQ5kw/6qNwVk0IV
         9iBYiuejuI8nW6PCikzTTtIq8ytq7F2to4idl//bFYM1PpeFBw/VCXDjcahEiQTK6Y
         DEHViKpq4ND5K7s+XrE/H8ZK79vWPY8Yc6VIp+lHVV0EvSDytXwe7kGNppQ9xAJTJM
         RmSmmPD4YHsTtc5d7KsA85Zx9LaieVkS40BT0CqJ7XcH+bEsEq9RCIdpb5k4thvZNq
         0UN/474VUuXQQ==
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
        kernel test robot <lkp@intel.com>
Subject: [PATCH 02/11] init: Mark start_kernel() __noreturn
Date:   Fri,  7 Apr 2023 17:09:55 -0700
Message-Id: <cb5dab6038dfe5156f5d68424cf372f7eed1b934.1680912057.git.jpoimboe@kernel.org>
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

  vmlinux.o: warning: objtool: x86_64_start_reservations+0x28: unreachable instruction

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202302161142.K3ziREaj-lkp@intel.com/
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

