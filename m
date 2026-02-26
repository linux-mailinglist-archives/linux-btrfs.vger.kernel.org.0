Return-Path: <linux-btrfs+bounces-21990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGRyL4VloGkejQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21990-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:23:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF291A89A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4A043177F09
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136940759C;
	Thu, 26 Feb 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVYvPTrC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EB3ED128;
	Thu, 26 Feb 2026 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118711; cv=none; b=oPFH1UkEe0UotqBRAHRe0lc009Z42uLTVoqG02hCjI0jdGVTJ27Oj20yvvcQeEgRUMVadkKQW91xYJokw5EqiyZXdWhqystq085/akoJJlShffGog0zrTQ7+jO3WKXYydTZyrt3GsW++u7npdi4JCDcqKA/lmMJNSiokBlP94zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118711; c=relaxed/simple;
	bh=rkU6xMpjHBvFoQf8bTQVv1BJaOUwen2u2axKl3/uPYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnUDRAdUpuKHpQV6Wb7cThEmZDDE61rRh2cPcrGZLzQWDqPp/slQ6u4m1dj6WZMeQeP5n46VJCkWZ9zmAFwKArukVj1rpymj75AwGHvYIHUWhlmqinTqUxXvkovmqXL7JHSEdDU/UdrrCFILt1JCo1Vz83RgqNnmRkCBT6NDWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RVYvPTrC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1N/WiUgWMSpYjlopJG9AbWnsi38DwWQVuDQYplZc2H8=; b=RVYvPTrC9VsHqGI+vAdX5WvLmo
	2/dUPA3s80/g4rfGsHuQGVL0XMDyIkHOjelmK0A2uCwAX43gM++Y7oomsb61j0pg8fshV8Z2OETvi
	lw/t7qLV+UG4b3FcZEqegNdMnRlvMUjVth/cix5BAjQlqDIaGMFTCzpiBvqRGGZPiVBPSzDopadsz
	KuoNLOf7BQWecY/Zsn2pCgY1zSZNuROTes1oAYq4+m/SSBaRimtIyzASOS0Fd54iX2OpFng+4TRwX
	wUPvn6HPPGT931iNBXQuFSAHhvPLzILiGTcklm7VjqCI23NSsIyy8mjyjwgj9IlP6i7+HgZ2unOTz
	+JKXrSog==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1S-00000006QGJ-1uEA;
	Thu, 26 Feb 2026 15:11:26 +0000
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
Subject: [PATCH 13/25] loongarch: move the XOR code to lib/raid/
Date: Thu, 26 Feb 2026 07:10:25 -0800
Message-ID: <20260226151106.144735-14-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-21990-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim,xen0n.name:email]
X-Rspamd-Queue-Id: 2CF291A89A4
X-Rspamd-Action: no action

Move the optimized XOR into lib/raid and include it it in xor.ko
instead of always building it into the main kernel image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/loongarch/include/asm/xor.h              | 24 ++----------
 arch/loongarch/include/asm/xor_simd.h         | 34 ----------------
 arch/loongarch/lib/Makefile                   |  2 -
 lib/raid/xor/Makefile                         |  2 +
 .../lib => lib/raid/xor/loongarch}/xor_simd.c |  0
 .../lib => lib/raid/xor/loongarch}/xor_simd.h |  0
 .../raid/xor/loongarch}/xor_simd_glue.c       | 39 +++++++++++--------
 .../raid/xor/loongarch}/xor_template.c        |  0
 8 files changed, 27 insertions(+), 74 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/xor_simd.h
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_simd.c (100%)
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_simd.h (100%)
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_simd_glue.c (64%)
 rename {arch/loongarch/lib => lib/raid/xor/loongarch}/xor_template.c (100%)

diff --git a/arch/loongarch/include/asm/xor.h b/arch/loongarch/include/asm/xor.h
index d17c0e3b047f..7e32f72f8b03 100644
--- a/arch/loongarch/include/asm/xor.h
+++ b/arch/loongarch/include/asm/xor.h
@@ -6,27 +6,6 @@
 #define _ASM_LOONGARCH_XOR_H
 
 #include <asm/cpu-features.h>
-#include <asm/xor_simd.h>
-
-#ifdef CONFIG_CPU_HAS_LSX
-static struct xor_block_template xor_block_lsx = {
-	.name = "lsx",
-	.do_2 = xor_lsx_2,
-	.do_3 = xor_lsx_3,
-	.do_4 = xor_lsx_4,
-	.do_5 = xor_lsx_5,
-};
-#endif /* CONFIG_CPU_HAS_LSX */
-
-#ifdef CONFIG_CPU_HAS_LASX
-static struct xor_block_template xor_block_lasx = {
-	.name = "lasx",
-	.do_2 = xor_lasx_2,
-	.do_3 = xor_lasx_3,
-	.do_4 = xor_lasx_4,
-	.do_5 = xor_lasx_5,
-};
-#endif /* CONFIG_CPU_HAS_LASX */
 
 /*
  * For grins, also test the generic routines.
@@ -38,6 +17,9 @@ static struct xor_block_template xor_block_lasx = {
  */
 #include <asm-generic/xor.h>
 
+extern struct xor_block_template xor_block_lsx;
+extern struct xor_block_template xor_block_lasx;
+
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
 {
diff --git a/arch/loongarch/include/asm/xor_simd.h b/arch/loongarch/include/asm/xor_simd.h
deleted file mode 100644
index 471b96332f38..000000000000
--- a/arch/loongarch/include/asm/xor_simd.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
- */
-#ifndef _ASM_LOONGARCH_XOR_SIMD_H
-#define _ASM_LOONGARCH_XOR_SIMD_H
-
-#ifdef CONFIG_CPU_HAS_LSX
-void xor_lsx_2(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2);
-void xor_lsx_3(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2, const unsigned long * __restrict p3);
-void xor_lsx_4(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4);
-void xor_lsx_5(unsigned long bytes, unsigned long * __restrict p1,
-	       const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	       const unsigned long * __restrict p4, const unsigned long * __restrict p5);
-#endif /* CONFIG_CPU_HAS_LSX */
-
-#ifdef CONFIG_CPU_HAS_LASX
-void xor_lasx_2(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2);
-void xor_lasx_3(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2, const unsigned long * __restrict p3);
-void xor_lasx_4(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	        const unsigned long * __restrict p4);
-void xor_lasx_5(unsigned long bytes, unsigned long * __restrict p1,
-	        const unsigned long * __restrict p2, const unsigned long * __restrict p3,
-	        const unsigned long * __restrict p4, const unsigned long * __restrict p5);
-#endif /* CONFIG_CPU_HAS_LASX */
-
-#endif /* _ASM_LOONGARCH_XOR_SIMD_H */
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index ccea3bbd4353..827a88529a42 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -8,6 +8,4 @@ lib-y	+= delay.o memset.o memcpy.o memmove.o \
 
 obj-$(CONFIG_ARCH_SUPPORTS_INT128) += tishift.o
 
-obj-$(CONFIG_CPU_HAS_LSX) += xor_simd.o xor_simd_glue.o
-
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 3c13851219e5..fafd131cef27 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -15,6 +15,8 @@ xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm/xor-neon.o arm/xor-neon-glue.o
 else
 xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm64/xor-neon.o arm64/xor-neon-glue.o
 endif
+xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd.o
+xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd_glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/arch/loongarch/lib/xor_simd.c b/lib/raid/xor/loongarch/xor_simd.c
similarity index 100%
rename from arch/loongarch/lib/xor_simd.c
rename to lib/raid/xor/loongarch/xor_simd.c
diff --git a/arch/loongarch/lib/xor_simd.h b/lib/raid/xor/loongarch/xor_simd.h
similarity index 100%
rename from arch/loongarch/lib/xor_simd.h
rename to lib/raid/xor/loongarch/xor_simd.h
diff --git a/arch/loongarch/lib/xor_simd_glue.c b/lib/raid/xor/loongarch/xor_simd_glue.c
similarity index 64%
rename from arch/loongarch/lib/xor_simd_glue.c
rename to lib/raid/xor/loongarch/xor_simd_glue.c
index 393f689dbcf6..11fa3b47ba83 100644
--- a/arch/loongarch/lib/xor_simd_glue.c
+++ b/lib/raid/xor/loongarch/xor_simd_glue.c
@@ -5,24 +5,23 @@
  * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
  */
 
-#include <linux/export.h>
 #include <linux/sched.h>
+#include <linux/raid/xor_impl.h>
 #include <asm/fpu.h>
-#include <asm/xor_simd.h>
+#include <asm/xor.h>
 #include "xor_simd.h"
 
 #define MAKE_XOR_GLUE_2(flavor)							\
-void xor_##flavor##_2(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_2(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2)			\
 {										\
 	kernel_fpu_begin();							\
 	__xor_##flavor##_2(bytes, p1, p2);					\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_2)
 
 #define MAKE_XOR_GLUE_3(flavor)							\
-void xor_##flavor##_3(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_3(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2,			\
 		      const unsigned long * __restrict p3)			\
 {										\
@@ -30,10 +29,9 @@ void xor_##flavor##_3(unsigned long bytes, unsigned long * __restrict p1,	\
 	__xor_##flavor##_3(bytes, p1, p2, p3);					\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_3)
 
 #define MAKE_XOR_GLUE_4(flavor)							\
-void xor_##flavor##_4(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_4(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2,			\
 		      const unsigned long * __restrict p3,			\
 		      const unsigned long * __restrict p4)			\
@@ -42,10 +40,9 @@ void xor_##flavor##_4(unsigned long bytes, unsigned long * __restrict p1,	\
 	__xor_##flavor##_4(bytes, p1, p2, p3, p4);				\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_4)
 
 #define MAKE_XOR_GLUE_5(flavor)							\
-void xor_##flavor##_5(unsigned long bytes, unsigned long * __restrict p1,	\
+static void xor_##flavor##_5(unsigned long bytes, unsigned long * __restrict p1,\
 		      const unsigned long * __restrict p2,			\
 		      const unsigned long * __restrict p3,			\
 		      const unsigned long * __restrict p4,			\
@@ -55,18 +52,26 @@ void xor_##flavor##_5(unsigned long bytes, unsigned long * __restrict p1,	\
 	__xor_##flavor##_5(bytes, p1, p2, p3, p4, p5);				\
 	kernel_fpu_end();							\
 }										\
-EXPORT_SYMBOL_GPL(xor_##flavor##_5)
 
-#define MAKE_XOR_GLUES(flavor)		\
-	MAKE_XOR_GLUE_2(flavor);	\
-	MAKE_XOR_GLUE_3(flavor);	\
-	MAKE_XOR_GLUE_4(flavor);	\
-	MAKE_XOR_GLUE_5(flavor)
+#define MAKE_XOR_GLUES(flavor)				\
+	MAKE_XOR_GLUE_2(flavor);			\
+	MAKE_XOR_GLUE_3(flavor);			\
+	MAKE_XOR_GLUE_4(flavor);			\
+	MAKE_XOR_GLUE_5(flavor);			\
+							\
+struct xor_block_template xor_block_##flavor = {	\
+	.name = __stringify(flavor),			\
+	.do_2 = xor_##flavor##_2,			\
+	.do_3 = xor_##flavor##_3,			\
+	.do_4 = xor_##flavor##_4,			\
+	.do_5 = xor_##flavor##_5,			\
+}
+
 
 #ifdef CONFIG_CPU_HAS_LSX
 MAKE_XOR_GLUES(lsx);
-#endif
+#endif /* CONFIG_CPU_HAS_LSX */
 
 #ifdef CONFIG_CPU_HAS_LASX
 MAKE_XOR_GLUES(lasx);
-#endif
+#endif /* CONFIG_CPU_HAS_LASX */
diff --git a/arch/loongarch/lib/xor_template.c b/lib/raid/xor/loongarch/xor_template.c
similarity index 100%
rename from arch/loongarch/lib/xor_template.c
rename to lib/raid/xor/loongarch/xor_template.c
-- 
2.47.3


