Return-Path: <linux-btrfs+bounces-21993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KChrMG5poGm+jQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21993-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:40:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8521A8E93
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF3AC31E2081
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB240FDA4;
	Thu, 26 Feb 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gnGa0wLP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606583ED127;
	Thu, 26 Feb 2026 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118714; cv=none; b=HE0twK1KVUckBbCpP4vCFxBng1gvtLYHCUj/uODNKYjaoIuh7pnHbygJv8yDcCBuQLEVH25YBNLSzxyh6KzCNcHUkRbo6V3dVT/RRmdDdBO6AIFlNZPk8KfHOS0EfFWTCziJlorRoQYL5RmQNY1Obod9RlNff+XbCmNGaHLCw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118714; c=relaxed/simple;
	bh=ugHhCn8K+zeD26eFJSJ69L8iIPvQM/xCwBj0pGf6ets=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcMbKwgrHMVLtmqKkUpdYmxC2szd2v09+sCkM9ePg4xgq0RhJtAGziHd9YDtfhtzZLt3KCKBiqhaUeQrwoK17VXSywJJSUMQdLZu+RYYO3K++hMRufmW9n8WMjaxCplJFX3qLVjJ7ihbyjNmCR4bunrCxsE1yniPmqbjbgKumpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gnGa0wLP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ry2shtzl2BSBD299Iewxm9iaU+3NWMfzJH2Uml5DqNo=; b=gnGa0wLPI6wVx3kQ08+Q4uDnu1
	jZGGCd7cML1XJI27YEEtpc053OllePBGCM/MUVd9DStH2pUt/Re8e6HUtHjPuc8saeH5LI24tx1hh
	iT4gbkXf6jpNisPEBWTRTXAQx1Fovzgp7PwOFcjpusbexi8K/9USh6Tez7AUZa2xTSshJ6shXhJ92
	BgWYtOvc+Rfu0EK1U5xEayrXBCDXWFpi/lxJ6jli4KVP675zPa5IQ2b/TujlmwQFIWMfGpppPW4s0
	lxBP5DC1RIpZjD7svrm9f4x1EXAL4zropdUE8Z7f5RdL3jkiSjQC0zDbA/BJBpf9gWOXWJY3KxQV5
	KyyyBakw==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1P-00000006QAd-2YwI;
	Thu, 26 Feb 2026 15:11:23 +0000
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
Subject: [PATCH 11/25] arm: move the XOR code to lib/raid/
Date: Thu, 26 Feb 2026 07:10:23 -0800
Message-ID: <20260226151106.144735-12-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-21993-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,infradead.org:dkim]
X-Rspamd-Queue-Id: 1B8521A8E93
X-Rspamd-Action: no action

Move the optimized XOR into lib/raid and include it it in the main
xor.ko instead of building a separate module for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/xor.h                    | 190 +-----------------
 arch/arm/lib/Makefile                         |   5 -
 lib/raid/xor/Makefile                         |   8 +
 lib/raid/xor/arm/xor-neon-glue.c              |  58 ++++++
 {arch/arm/lib => lib/raid/xor/arm}/xor-neon.c |  10 +-
 lib/raid/xor/arm/xor.c                        | 136 +++++++++++++
 6 files changed, 205 insertions(+), 202 deletions(-)
 create mode 100644 lib/raid/xor/arm/xor-neon-glue.c
 rename {arch/arm/lib => lib/raid/xor/arm}/xor-neon.c (74%)
 create mode 100644 lib/raid/xor/arm/xor.c

diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
index b2dcd49186e2..989c55872ef6 100644
--- a/arch/arm/include/asm/xor.h
+++ b/arch/arm/include/asm/xor.h
@@ -1,198 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/xor.h
- *
  *  Copyright (C) 2001 Russell King
  */
 #include <asm-generic/xor.h>
-#include <asm/hwcap.h>
 #include <asm/neon.h>
 
-#define __XOR(a1, a2) a1 ^= a2
-
-#define GET_BLOCK_2(dst) \
-	__asm__("ldmia	%0, {%1, %2}" \
-		: "=r" (dst), "=r" (a1), "=r" (a2) \
-		: "0" (dst))
-
-#define GET_BLOCK_4(dst) \
-	__asm__("ldmia	%0, {%1, %2, %3, %4}" \
-		: "=r" (dst), "=r" (a1), "=r" (a2), "=r" (a3), "=r" (a4) \
-		: "0" (dst))
-
-#define XOR_BLOCK_2(src) \
-	__asm__("ldmia	%0!, {%1, %2}" \
-		: "=r" (src), "=r" (b1), "=r" (b2) \
-		: "0" (src)); \
-	__XOR(a1, b1); __XOR(a2, b2);
-
-#define XOR_BLOCK_4(src) \
-	__asm__("ldmia	%0!, {%1, %2, %3, %4}" \
-		: "=r" (src), "=r" (b1), "=r" (b2), "=r" (b3), "=r" (b4) \
-		: "0" (src)); \
-	__XOR(a1, b1); __XOR(a2, b2); __XOR(a3, b3); __XOR(a4, b4)
-
-#define PUT_BLOCK_2(dst) \
-	__asm__ __volatile__("stmia	%0!, {%2, %3}" \
-		: "=r" (dst) \
-		: "0" (dst), "r" (a1), "r" (a2))
-
-#define PUT_BLOCK_4(dst) \
-	__asm__ __volatile__("stmia	%0!, {%2, %3, %4, %5}" \
-		: "=r" (dst) \
-		: "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4))
-
-static void
-xor_arm4regs_2(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 4;
-	register unsigned int a1 __asm__("r4");
-	register unsigned int a2 __asm__("r5");
-	register unsigned int a3 __asm__("r6");
-	register unsigned int a4 __asm__("r10");
-	register unsigned int b1 __asm__("r8");
-	register unsigned int b2 __asm__("r9");
-	register unsigned int b3 __asm__("ip");
-	register unsigned int b4 __asm__("lr");
-
-	do {
-		GET_BLOCK_4(p1);
-		XOR_BLOCK_4(p2);
-		PUT_BLOCK_4(p1);
-	} while (--lines);
-}
-
-static void
-xor_arm4regs_3(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 4;
-	register unsigned int a1 __asm__("r4");
-	register unsigned int a2 __asm__("r5");
-	register unsigned int a3 __asm__("r6");
-	register unsigned int a4 __asm__("r10");
-	register unsigned int b1 __asm__("r8");
-	register unsigned int b2 __asm__("r9");
-	register unsigned int b3 __asm__("ip");
-	register unsigned int b4 __asm__("lr");
-
-	do {
-		GET_BLOCK_4(p1);
-		XOR_BLOCK_4(p2);
-		XOR_BLOCK_4(p3);
-		PUT_BLOCK_4(p1);
-	} while (--lines);
-}
-
-static void
-xor_arm4regs_4(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 2;
-	register unsigned int a1 __asm__("r8");
-	register unsigned int a2 __asm__("r9");
-	register unsigned int b1 __asm__("ip");
-	register unsigned int b2 __asm__("lr");
-
-	do {
-		GET_BLOCK_2(p1);
-		XOR_BLOCK_2(p2);
-		XOR_BLOCK_2(p3);
-		XOR_BLOCK_2(p4);
-		PUT_BLOCK_2(p1);
-	} while (--lines);
-}
-
-static void
-xor_arm4regs_5(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2,
-	       const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4,
-	       const unsigned long * __restrict p5)
-{
-	unsigned int lines = bytes / sizeof(unsigned long) / 2;
-	register unsigned int a1 __asm__("r8");
-	register unsigned int a2 __asm__("r9");
-	register unsigned int b1 __asm__("ip");
-	register unsigned int b2 __asm__("lr");
-
-	do {
-		GET_BLOCK_2(p1);
-		XOR_BLOCK_2(p2);
-		XOR_BLOCK_2(p3);
-		XOR_BLOCK_2(p4);
-		XOR_BLOCK_2(p5);
-		PUT_BLOCK_2(p1);
-	} while (--lines);
-}
-
-static struct xor_block_template xor_block_arm4regs = {
-	.name	= "arm4regs",
-	.do_2	= xor_arm4regs_2,
-	.do_3	= xor_arm4regs_3,
-	.do_4	= xor_arm4regs_4,
-	.do_5	= xor_arm4regs_5,
-};
-
-#ifdef CONFIG_KERNEL_MODE_NEON
-
-extern struct xor_block_template const xor_block_neon_inner;
-
-static void
-xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_2(bytes, p1, p2);
-	kernel_neon_end();
-}
-
-static void
-xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_3(bytes, p1, p2, p3);
-	kernel_neon_end();
-}
-
-static void
-xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
-	kernel_neon_end();
-}
-
-static void
-xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4,
-	   const unsigned long * __restrict p5)
-{
-	kernel_neon_begin();
-	xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
-	kernel_neon_end();
-}
-
-static struct xor_block_template xor_block_neon = {
-	.name	= "neon",
-	.do_2	= xor_neon_2,
-	.do_3	= xor_neon_3,
-	.do_4	= xor_neon_4,
-	.do_5	= xor_neon_5
-};
-
-#endif /* CONFIG_KERNEL_MODE_NEON */
+extern struct xor_block_template xor_block_arm4regs;
+extern struct xor_block_template xor_block_neon;
 
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 0ca5aae1bcc3..9295055cdfc9 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -39,9 +39,4 @@ endif
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
-ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
-  obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
-endif
-
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 6d03c27c37c7..fb760edae54b 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -9,3 +9,11 @@ xor-y				+= xor-8regs-prefetch.o
 xor-y				+= xor-32regs-prefetch.o
 
 xor-$(CONFIG_ALPHA)		+= alpha/xor.o
+xor-$(CONFIG_ARM)		+= arm/xor.o
+ifeq ($(CONFIG_ARM),y)
+xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm/xor-neon.o arm/xor-neon-glue.o
+endif
+
+
+CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_arm/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
diff --git a/lib/raid/xor/arm/xor-neon-glue.c b/lib/raid/xor/arm/xor-neon-glue.c
new file mode 100644
index 000000000000..c7b162b383a2
--- /dev/null
+++ b/lib/raid/xor/arm/xor-neon-glue.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2001 Russell King
+ */
+#include <linux/raid/xor_impl.h>
+#include <asm/xor.h>
+
+extern struct xor_block_template const xor_block_neon_inner;
+
+static void
+xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_2(bytes, p1, p2);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_3(bytes, p1, p2, p3);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4,
+	   const unsigned long * __restrict p5)
+{
+	kernel_neon_begin();
+	xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
+	kernel_neon_end();
+}
+
+struct xor_block_template xor_block_neon = {
+	.name	= "neon",
+	.do_2	= xor_neon_2,
+	.do_3	= xor_neon_3,
+	.do_4	= xor_neon_4,
+	.do_5	= xor_neon_5
+};
diff --git a/arch/arm/lib/xor-neon.c b/lib/raid/xor/arm/xor-neon.c
similarity index 74%
rename from arch/arm/lib/xor-neon.c
rename to lib/raid/xor/arm/xor-neon.c
index b5be50567991..c9d4378b0f0e 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/lib/raid/xor/arm/xor-neon.c
@@ -1,16 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/arch/arm/lib/xor-neon.c
- *
  * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <linux/raid/xor.h>
 #include <linux/raid/xor_impl.h>
-#include <linux/module.h>
-
-MODULE_DESCRIPTION("NEON accelerated XOR implementation");
-MODULE_LICENSE("GPL");
 
 #ifndef __ARM_NEON__
 #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
@@ -27,7 +20,7 @@ MODULE_LICENSE("GPL");
 #endif
 
 #define NO_TEMPLATE
-#include "../../../lib/raid/xor/xor-8regs.c"
+#include "../xor-8regs.c"
 
 struct xor_block_template const xor_block_neon_inner = {
 	.name	= "__inner_neon__",
@@ -36,4 +29,3 @@ struct xor_block_template const xor_block_neon_inner = {
 	.do_4	= xor_8regs_4,
 	.do_5	= xor_8regs_5,
 };
-EXPORT_SYMBOL(xor_block_neon_inner);
diff --git a/lib/raid/xor/arm/xor.c b/lib/raid/xor/arm/xor.c
new file mode 100644
index 000000000000..2263341dbbcd
--- /dev/null
+++ b/lib/raid/xor/arm/xor.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2001 Russell King
+ */
+#include <linux/raid/xor_impl.h>
+#include <asm/xor.h>
+
+#define __XOR(a1, a2) a1 ^= a2
+
+#define GET_BLOCK_2(dst) \
+	__asm__("ldmia	%0, {%1, %2}" \
+		: "=r" (dst), "=r" (a1), "=r" (a2) \
+		: "0" (dst))
+
+#define GET_BLOCK_4(dst) \
+	__asm__("ldmia	%0, {%1, %2, %3, %4}" \
+		: "=r" (dst), "=r" (a1), "=r" (a2), "=r" (a3), "=r" (a4) \
+		: "0" (dst))
+
+#define XOR_BLOCK_2(src) \
+	__asm__("ldmia	%0!, {%1, %2}" \
+		: "=r" (src), "=r" (b1), "=r" (b2) \
+		: "0" (src)); \
+	__XOR(a1, b1); __XOR(a2, b2);
+
+#define XOR_BLOCK_4(src) \
+	__asm__("ldmia	%0!, {%1, %2, %3, %4}" \
+		: "=r" (src), "=r" (b1), "=r" (b2), "=r" (b3), "=r" (b4) \
+		: "0" (src)); \
+	__XOR(a1, b1); __XOR(a2, b2); __XOR(a3, b3); __XOR(a4, b4)
+
+#define PUT_BLOCK_2(dst) \
+	__asm__ __volatile__("stmia	%0!, {%2, %3}" \
+		: "=r" (dst) \
+		: "0" (dst), "r" (a1), "r" (a2))
+
+#define PUT_BLOCK_4(dst) \
+	__asm__ __volatile__("stmia	%0!, {%2, %3, %4, %5}" \
+		: "=r" (dst) \
+		: "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4))
+
+static void
+xor_arm4regs_2(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 4;
+	register unsigned int a1 __asm__("r4");
+	register unsigned int a2 __asm__("r5");
+	register unsigned int a3 __asm__("r6");
+	register unsigned int a4 __asm__("r10");
+	register unsigned int b1 __asm__("r8");
+	register unsigned int b2 __asm__("r9");
+	register unsigned int b3 __asm__("ip");
+	register unsigned int b4 __asm__("lr");
+
+	do {
+		GET_BLOCK_4(p1);
+		XOR_BLOCK_4(p2);
+		PUT_BLOCK_4(p1);
+	} while (--lines);
+}
+
+static void
+xor_arm4regs_3(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 4;
+	register unsigned int a1 __asm__("r4");
+	register unsigned int a2 __asm__("r5");
+	register unsigned int a3 __asm__("r6");
+	register unsigned int a4 __asm__("r10");
+	register unsigned int b1 __asm__("r8");
+	register unsigned int b2 __asm__("r9");
+	register unsigned int b3 __asm__("ip");
+	register unsigned int b4 __asm__("lr");
+
+	do {
+		GET_BLOCK_4(p1);
+		XOR_BLOCK_4(p2);
+		XOR_BLOCK_4(p3);
+		PUT_BLOCK_4(p1);
+	} while (--lines);
+}
+
+static void
+xor_arm4regs_4(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 2;
+	register unsigned int a1 __asm__("r8");
+	register unsigned int a2 __asm__("r9");
+	register unsigned int b1 __asm__("ip");
+	register unsigned int b2 __asm__("lr");
+
+	do {
+		GET_BLOCK_2(p1);
+		XOR_BLOCK_2(p2);
+		XOR_BLOCK_2(p3);
+		XOR_BLOCK_2(p4);
+		PUT_BLOCK_2(p1);
+	} while (--lines);
+}
+
+static void
+xor_arm4regs_5(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4,
+	       const unsigned long * __restrict p5)
+{
+	unsigned int lines = bytes / sizeof(unsigned long) / 2;
+	register unsigned int a1 __asm__("r8");
+	register unsigned int a2 __asm__("r9");
+	register unsigned int b1 __asm__("ip");
+	register unsigned int b2 __asm__("lr");
+
+	do {
+		GET_BLOCK_2(p1);
+		XOR_BLOCK_2(p2);
+		XOR_BLOCK_2(p3);
+		XOR_BLOCK_2(p4);
+		XOR_BLOCK_2(p5);
+		PUT_BLOCK_2(p1);
+	} while (--lines);
+}
+
+struct xor_block_template xor_block_arm4regs = {
+	.name	= "arm4regs",
+	.do_2	= xor_arm4regs_2,
+	.do_3	= xor_arm4regs_3,
+	.do_4	= xor_arm4regs_4,
+	.do_5	= xor_arm4regs_5,
+};
-- 
2.47.3


