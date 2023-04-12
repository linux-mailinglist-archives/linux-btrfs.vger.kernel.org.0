Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0696E02BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDLXuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLXuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD861BF;
        Wed, 12 Apr 2023 16:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA05263A2B;
        Wed, 12 Apr 2023 23:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B8DC433A1;
        Wed, 12 Apr 2023 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343402;
        bh=aZ+Jm121CTQwCGer705wrEKwXxtRjeZahsDaZDvQjNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0A/KUNqTELcfzgzINIlbc454QKQa7T9qsKJcFdNUooOWCQP9O0Gs1LyEOCdbUEUB
         nVC7Kp3bo7jLolqmS9ZN2WPgyFSrIWNC1SuSkc9CSEIulsNpcmigxjBR0MpDCG9ccv
         N/vpnZhCk7SB7lSWPo6LFkb+ULm2b0jAB9nVAVHO5ztT80kIM5YXFGScxEGEbzD+6+
         T+zZQMAJsQaIkel2TFNTbP6yEgJD2rBx0sYyYNUpQsc1dBWzeTI6qalmzRXQk7m/Y/
         0RiNM4u/xxQLVEoytDmsfF3p2c85VDGEAX6gKvZ4PPzSgsC3ZQ/1/p7YZfzM056P3u
         WaUCwINX5Oi2Q==
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
Subject: [PATCH v2 07/11] objtool: Include weak functions in global_noreturns check
Date:   Wed, 12 Apr 2023 16:49:37 -0700
Message-Id: <ede3460d63f4a65d282c86f1175bd2662c2286ba.1681342859.git.jpoimboe@kernel.org>
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

If a global function doesn't return, and its prototype has the
__noreturn attribute, its weak counterpart must also not return so that
it matches the prototype and meets call site expectations.

To properly follow the compiled control flow at the call sites, change
the global_noreturns check to include both global and weak functions.

On the other hand, if a weak function isn't in global_noreturns, assume
the prototype doesn't have __noreturn.  Even if the weak function
doesn't return, call sites treat it like a returnable function.

Fixes the following warning:

  kernel/sched/build_policy.o: warning: objtool: do_idle() falls through to next function play_idle_precise()

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304090346.erhqxnlt-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ed42717463f9..94c16436d990 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -236,14 +236,14 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	if (!func)
 		return false;
 
-	if (func->bind == STB_WEAK)
-		return false;
-
-	if (func->bind == STB_GLOBAL)
+	if (func->bind == STB_GLOBAL || func->bind == STB_WEAK)
 		for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
 			if (!strcmp(func->name, global_noreturns[i]))
 				return true;
 
+	if (func->bind == STB_WEAK)
+		return false;
+
 	if (!func->len)
 		return false;
 
-- 
2.39.2

