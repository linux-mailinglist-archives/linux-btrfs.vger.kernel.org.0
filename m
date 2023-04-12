Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7B6E02D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDLXuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDLXuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543C7280;
        Wed, 12 Apr 2023 16:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82D026375F;
        Wed, 12 Apr 2023 23:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C0C4339C;
        Wed, 12 Apr 2023 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343404;
        bh=fv7dp6bnjJALXLewb9lTFvUBDPbaWCiPUy0hgG3NFLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGpI28UrR5Zv3CYWpQ0VUGjdfUzVFojUtUlbbKFI5Bwyx+iXrsuGIp8s4v1k8SoJI
         nONptSfN0QUqyQ8t2DgvmD7tYUwACn4ZT+b7jSmj1NfXtuJ8T3FSAnKA98Hso7t2V9
         ppJawnoz8YeoM/ykNlsVPlkBpo8jB/1URJXGVgpbc2KwjMzX5FAIFDvqcNM6aHI2z8
         osGmvarU93OQGE9PYaYzIBCAyoH2DpmhKPNQfBlUT/XZlZPOx9y6OEpB6Y0xGjMqpG
         CitYIh2s2Aag3+xNbvuJ51BhWD7tsF+vSHN/8bqdL1tgYkPGAAazNtDdNH6j4Dto4e
         4f/PLPj1QPGag==
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
Subject: [PATCH v2 11/11] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Date:   Wed, 12 Apr 2023 16:49:41 -0700
Message-Id: <32453a703dfcf0d007b473c9acbf70718222b74b.1681342859.git.jpoimboe@kernel.org>
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

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

Annotate the function prototype and definition as noreturn to prevent
objtool warnings like:

vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction

Also, as per Josh's suggestion, add it to the global_noreturns list.
As a comparison, an objdump output without the annotation:

[...]
1b63:  mov    $0x1,%esi
1b68:  xor    %edi,%edi
1b6a:  callq  ffffffff8102f680 <hv_ghcb_terminate>
1b6f:  jmpq   ffffffff82f217ec <hyperv_init+0x9c> # unreachable
1b74:  cmpq   $0xffffffffffffffff,-0x702a24(%rip)
[...]

Now, after adding the __noreturn to the function prototype:

[...]
17df:  callq  ffffffff8102f6d0 <hv_ghcb_negotiate_protocol>
17e4:  test   %al,%al
17e6:  je     ffffffff82f21bb9 <hyperv_init+0x469>
[...]  <many insns>
1bb9:  mov    $0x1,%esi
1bbe:  xor    %edi,%edi
1bc0:  callq  ffffffff8102f680 <hv_ghcb_terminate>
1bc5:  nopw   %cs:0x0(%rax,%rax,1) # end of function

Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/9698eff1-9680-4f0a-94de-590eaa923e94@app.fastmail.com/
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/hyperv/ivm.c           | 2 +-
 arch/x86/include/asm/mshyperv.h | 2 +-
 tools/objtool/check.c           | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1dbcbd9da74d..4f79dc76042d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -127,7 +127,7 @@ static enum es_result hv_ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
 		return ES_OK;
 }
 
-void hv_ghcb_terminate(unsigned int set, unsigned int reason)
+void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4c4c0ec3b62e..09c26e658bcc 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -212,7 +212,7 @@ int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
 void hv_ghcb_msr_write(u64 msr, u64 value);
 void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
-void hv_ghcb_terminate(unsigned int set, unsigned int reason);
+void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8586d4c36600..e23d12041be0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -213,6 +213,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"ex_handler_msr_mce",
 		"fortify_panic",
 		"hlt_play_dead",
+		"hv_ghcb_terminate",
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
-- 
2.39.2

