Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17350C906
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiDWKLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiDWKLB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 06:11:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8EE1B2B0F;
        Sat, 23 Apr 2022 03:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46513CE1412;
        Sat, 23 Apr 2022 10:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3090BC385AC;
        Sat, 23 Apr 2022 10:07:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: Add support for user sub-page fault probing
Date:   Sat, 23 Apr 2022 11:07:50 +0100
Message-Id: <20220423100751.1870771-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423100751.1870771-1-catalin.marinas@arm.com>
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With MTE, even if the pte allows an access, a mismatched tag somewhere
within a page can still cause a fault. Select ARCH_HAS_SUBPAGE_FAULTS if
MTE is enabled and implement the probe_subpage_writeable() function.
Note that get_user() is sufficient for the writeable MTE check since the
same tag mismatch fault would be triggered by a read. The caller of
probe_subpage_writeable() will need to check the pte permissions
(put_user, GUP).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/mte.h     |  1 +
 arch/arm64/include/asm/uaccess.h | 15 +++++++++++++++
 arch/arm64/kernel/mte.c          | 30 ++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 57c4c995965f..290b88238103 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1871,6 +1871,7 @@ config ARM64_MTE
 	depends on AS_HAS_LSE_ATOMICS
 	# Required for tag checking in the uaccess routines
 	depends on ARM64_PAN
+	select ARCH_HAS_SUBPAGE_FAULTS
 	select ARCH_USES_HIGH_VMA_FLAGS
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index adcb937342f1..aa523591a44e 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -47,6 +47,7 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
+size_t mte_probe_user_range(const char __user *uaddr, size_t size);
 
 #else /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e8dce0cc5eaa..6677aa7e9993 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -460,4 +460,19 @@ static inline int __copy_from_user_flushcache(void *dst, const void __user *src,
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
+
+/*
+ * Return 0 on success, the number of bytes not probed otherwise.
+ */
+static inline size_t probe_subpage_writeable(const void __user *uaddr,
+					     size_t size)
+{
+	if (!system_supports_mte())
+		return 0;
+	return mte_probe_user_range(uaddr, size);
+}
+
+#endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
+
 #endif /* __ASM_UACCESS_H */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 78b3e0f8e997..35697a09926f 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/thread_info.h>
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include <linux/uio.h>
 
 #include <asm/barrier.h>
@@ -543,3 +544,32 @@ static int register_mte_tcf_preferred_sysctl(void)
 	return 0;
 }
 subsys_initcall(register_mte_tcf_preferred_sysctl);
+
+/*
+ * Return 0 on success, the number of bytes not probed otherwise.
+ */
+size_t mte_probe_user_range(const char __user *uaddr, size_t size)
+{
+	const char __user *end = uaddr + size;
+	int err = 0;
+	char val;
+
+	__raw_get_user(val, uaddr, err);
+	if (err)
+		return size;
+
+	uaddr = PTR_ALIGN(uaddr, MTE_GRANULE_SIZE);
+	while (uaddr < end) {
+		/*
+		 * A read is sufficient for mte, the caller should have probed
+		 * for the pte write permission if required.
+		 */
+		__raw_get_user(val, uaddr, err);
+		if (err)
+			return end - uaddr;
+		uaddr += MTE_GRANULE_SIZE;
+	}
+	(void)val;
+
+	return 0;
+}
