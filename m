Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF53F6DB78B
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjDHAKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjDHAK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91412075;
        Fri,  7 Apr 2023 17:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8773665567;
        Sat,  8 Apr 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C210C4339C;
        Sat,  8 Apr 2023 00:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912624;
        bh=4wzSu4ZL5pXMt0STVtv2MfvehTIjHZdMXLjpSpIERTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9adiUttP+IEdjEtk1kh4STKzQrhqcFlzpKq5pCfK6+iFq2Lv0p/u5oWdpCaMG2/X
         k8yI+yuayv9s+Fg18ULnRtNCzqnqGqSR01dF0oKEqGfhTYvvKs6x4H7lnahvi7gWe6
         k8zUCqUT0XDMkKQbdt1bArI0n5Z1dA5roEOQlRSIwHD3Rxcseyn7/NOWqShv7v3h7B
         L9Zn5VB9VhRdnDA+SuEueyhx1RW9mEu0vWUXFf9PaMwH3nRTfQbF9ch1ewRZFHQsrg
         eW1NjgBCqsoXI1S7Oe7xl/8EDNLZS6AkFiycG65ngyPE5TVyALJVHcMTHf071BU3sE
         ZHX7XfMAYWqPg==
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
Subject: [PATCH 11/11] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Date:   Fri,  7 Apr 2023 17:10:04 -0700
Message-Id: <8d21cbcef0e08053b36da2bc0a74ff65f5dabd43.1680912057.git.jpoimboe@kernel.org>
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
Link: https://lore.kernel.org/r/20230317160546.1497477-1-gpiccoli@igalia.com
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

