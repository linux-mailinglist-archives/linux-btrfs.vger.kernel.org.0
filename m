Return-Path: <linux-btrfs+bounces-21997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAy+HLNpoGm+jQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21997-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:41:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 151551A8F43
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F249131F9BB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84D41325C;
	Thu, 26 Feb 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4aoRs2mL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD83ED133;
	Thu, 26 Feb 2026 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118716; cv=none; b=tWPRJH/sg5xxvTfSKYMQ3/T6a3+EZmFsw1d55NwXrRt3A2e2AVERZfw/xEugxSTiGp0r2MJbEFfTx1DggnATSs6PlzMXCw1jP4dOyAosN3gXNqskMzwsxwoHAVAeMiRdgQ7uRP/bb8ulDR4hi9jCPmyqJ1qL6xG4EC02W7LIsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118716; c=relaxed/simple;
	bh=1rbZjmYEfEuqKNPXrS9Qd3W+l5Ph8gegf7Ph77YfY7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvjQi4o8hVHap9nnsnVpKmlltOLW+Mz6bXOn72wD9bWPc+x919UVX3PlKME/nlxjRPU53eb2Shpg2IfQcImzgrY4plw3IgHeXGxqAUUF0zz+yIR0YqTm/82SXILUSICZ2K+e7g1G7K55ajTtLb4jCcn/oppmVz7Qr8E5npo8rNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4aoRs2mL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vwKqUvKDtSm4UWQCjM0gAMoI+iHppoMDTf59idSkcFk=; b=4aoRs2mLG63dZ2rnHao9M4bup8
	NhK+Fll40nxMI6XwhNwq5YU3yBKmR1ldJdg2IDg8ldeYRyzGjFSTwteEB4MVHQqpuJorvVU0bMIuK
	Gbga/cPpDR723dwaz/6vJLsaqSafK4BkomOdDsJvXXMA9rZRxf43OGDfcKiHgBsB/FoyN2r+njPu/
	SyFb0azgzHm243fwrSciZ4S0Csx8Muh2jmpemFl+5R7xdgicCkUC7NatVRx4GOUmxooC3Kw5zQYI5
	QCPvzOiQsJw23bX3On9763+eKd48xBiD76mENrzjPRE/sWQArv58RqhgskdcOReAqLUFLNVsL2eut
	J3UCbAxg==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1V-00000006QLl-0jhv;
	Thu, 26 Feb 2026 15:11:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 15/25] riscv: move the XOR code to lib/raid/
Date: Thu, 26 Feb 2026 07:10:27 -0800
Message-ID: <20260226151106.144735-16-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226151106.144735-1-hch@lst.de>
References: <20260226151106.144735-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-21997-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 151551A8F43
X-Rspamd-Action: no action

Move the optimized XOR into lib/raid and include it it in xor.ko
instead of always building it into the main kernel image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/xor.h                 | 54 +------------------
 arch/riscv/lib/Makefile                      |  1 -
 lib/raid/xor/Makefile                        |  1 +
 lib/raid/xor/riscv/xor-glue.c                | 56 ++++++++++++++++++++
 {arch/riscv/lib => lib/raid/xor/riscv}/xor.S |  0
 5 files changed, 59 insertions(+), 53 deletions(-)
 create mode 100644 lib/raid/xor/riscv/xor-glue.c
 rename {arch/riscv/lib => lib/raid/xor/riscv}/xor.S (100%)

diff --git a/arch/riscv/include/asm/xor.h b/arch/riscv/include/asm/xor.h
index ed5f27903efc..614d9209d078 100644
--- a/arch/riscv/include/asm/xor.h
+++ b/arch/riscv/include/asm/xor.h
@@ -2,60 +2,10 @@
 /*
  * Copyright (C) 2021 SiFive
  */
-
-#include <linux/hardirq.h>
-#include <asm-generic/xor.h>
-#ifdef CONFIG_RISCV_ISA_V
 #include <asm/vector.h>
-#include <asm/switch_to.h>
-#include <asm/asm-prototypes.h>
-
-static void xor_vector_2(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2)
-{
-	kernel_vector_begin();
-	xor_regs_2_(bytes, p1, p2);
-	kernel_vector_end();
-}
-
-static void xor_vector_3(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2,
-			 const unsigned long *__restrict p3)
-{
-	kernel_vector_begin();
-	xor_regs_3_(bytes, p1, p2, p3);
-	kernel_vector_end();
-}
-
-static void xor_vector_4(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2,
-			 const unsigned long *__restrict p3,
-			 const unsigned long *__restrict p4)
-{
-	kernel_vector_begin();
-	xor_regs_4_(bytes, p1, p2, p3, p4);
-	kernel_vector_end();
-}
-
-static void xor_vector_5(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2,
-			 const unsigned long *__restrict p3,
-			 const unsigned long *__restrict p4,
-			 const unsigned long *__restrict p5)
-{
-	kernel_vector_begin();
-	xor_regs_5_(bytes, p1, p2, p3, p4, p5);
-	kernel_vector_end();
-}
+#include <asm-generic/xor.h>
 
-static struct xor_block_template xor_block_rvv = {
-	.name = "rvv",
-	.do_2 = xor_vector_2,
-	.do_3 = xor_vector_3,
-	.do_4 = xor_vector_4,
-	.do_5 = xor_vector_5
-};
-#endif /* CONFIG_RISCV_ISA_V */
+extern struct xor_block_template xor_block_rvv;
 
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index bbc031124974..e220c35764eb 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -16,5 +16,4 @@ lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
-lib-$(CONFIG_RISCV_ISA_V)	+= xor.o
 lib-$(CONFIG_RISCV_ISA_V)	+= riscv_v_helpers.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 3df9e04a1a9b..c939fad43735 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -18,6 +18,7 @@ endif
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd.o
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd_glue.o
 xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
+xor-$(CONFIG_RISCV_ISA_V)	+= riscv/xor.o riscv/xor-glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/lib/raid/xor/riscv/xor-glue.c b/lib/raid/xor/riscv/xor-glue.c
new file mode 100644
index 000000000000..11666a4b6b68
--- /dev/null
+++ b/lib/raid/xor/riscv/xor-glue.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SiFive
+ */
+
+#include <linux/raid/xor_impl.h>
+#include <asm/vector.h>
+#include <asm/switch_to.h>
+#include <asm/asm-prototypes.h>
+#include <asm/xor.h>
+
+static void xor_vector_2(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2)
+{
+	kernel_vector_begin();
+	xor_regs_2_(bytes, p1, p2);
+	kernel_vector_end();
+}
+
+static void xor_vector_3(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2,
+			 const unsigned long *__restrict p3)
+{
+	kernel_vector_begin();
+	xor_regs_3_(bytes, p1, p2, p3);
+	kernel_vector_end();
+}
+
+static void xor_vector_4(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2,
+			 const unsigned long *__restrict p3,
+			 const unsigned long *__restrict p4)
+{
+	kernel_vector_begin();
+	xor_regs_4_(bytes, p1, p2, p3, p4);
+	kernel_vector_end();
+}
+
+static void xor_vector_5(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2,
+			 const unsigned long *__restrict p3,
+			 const unsigned long *__restrict p4,
+			 const unsigned long *__restrict p5)
+{
+	kernel_vector_begin();
+	xor_regs_5_(bytes, p1, p2, p3, p4, p5);
+	kernel_vector_end();
+}
+
+struct xor_block_template xor_block_rvv = {
+	.name = "rvv",
+	.do_2 = xor_vector_2,
+	.do_3 = xor_vector_3,
+	.do_4 = xor_vector_4,
+	.do_5 = xor_vector_5
+};
diff --git a/arch/riscv/lib/xor.S b/lib/raid/xor/riscv/xor.S
similarity index 100%
rename from arch/riscv/lib/xor.S
rename to lib/raid/xor/riscv/xor.S
-- 
2.47.3


