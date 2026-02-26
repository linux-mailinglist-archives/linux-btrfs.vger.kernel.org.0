Return-Path: <linux-btrfs+bounces-22009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B/GLexmoGkejQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22009-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:29:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC31A8BB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F9F53289859
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18F4423A60;
	Thu, 26 Feb 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0lLke88Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C2421F04;
	Thu, 26 Feb 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118739; cv=none; b=Po2iQX/FxA/1lxtEAKGi3HXa4MZyzbVPedg9jKO/WgOdKNhaPNbyU3GekdKBSV2zLsFA/MPAcaZoGxt8/IKkIPn0stybnaxXleKv5JoKQ58pwgiXTc2ZNJruTfYArKtvY+CThu2d5QQ5PXzHZ8I9K3u6vKmvZzPyxUbj64blBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118739; c=relaxed/simple;
	bh=r43Ot/Gf+AkJHCAymfFONDwegkg1nJgXhSbrXGuVbME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJsLytBnb+WHPrA0V+iFd3qAmPDK9+z4JGMXsJFRLMSSrqhvnnWgOlqKzRPQ2ZESTIYsMY7wcDghykfEPqObH7+QGtERTQ+qkp5e5PhypdT3sVHeOInIBRzlG7wxHV+jQ4je+gKUyd1YTqE+j2JSG5tCbRaZXH88cYmz6K/ej+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0lLke88Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dnAqm1mQgBL7YCaDnwjea9MVbvJi6fB59bRdgxzHRfQ=; b=0lLke88ZORd7FsP4CXpACuAHde
	G+oGLjzsBhaZHraeqqDivfxfZWCm4ROZxEFdgYr1SqqrHyaZMGKmnU0TC9tNkr4CT420xJEzxh9Lx
	K/RLoOseLaA94JEjz/WZ9ATki+rNhCPZRBNOnEn8lXDJCqZOClP5EWYyzrJC9gyWYIy3CnZitFvtH
	k3HWnv0fDpBhz5YMPmXsLWiQQkOdYZWJnJ8CX2ukw7Pg8kW8rslvn913bFW6BP4sSazhwrve1Ld2Q
	EOgMxPX5svvrd6cMQB6Uov1O9PUtVxtVdVUoj9XmVxFNfJaXZemUFGVQSO215kU+ZiD9757bDT/dH
	BXSJUfgQ==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1q-00000006Qsd-3Nhg;
	Thu, 26 Feb 2026 15:11:50 +0000
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
Subject: [PATCH 25/25] xor: use static_call for xor_gen
Date: Thu, 26 Feb 2026 07:10:37 -0800
Message-ID: <20260226151106.144735-26-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-22009-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 0ADC31A8BB7
X-Rspamd-Action: no action

Avoid the indirect call for xor_generation by using a static_call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/xor/xor-32regs.c |  2 +-
 lib/raid/xor/xor-core.c   | 29 ++++++++++++++---------------
 lib/raid/xor/xor_impl.h   |  4 ++++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/lib/raid/xor/xor-32regs.c b/lib/raid/xor/xor-32regs.c
index acb4a10d1e95..759a31f76414 100644
--- a/lib/raid/xor/xor-32regs.c
+++ b/lib/raid/xor/xor-32regs.c
@@ -209,7 +209,7 @@ xor_32regs_5(unsigned long bytes, unsigned long * __restrict p1,
 	} while (--lines > 0);
 }
 
-DO_XOR_BLOCKS(32regs, xor_32regs_2, xor_32regs_3, xor_32regs_4, xor_32regs_5);
+__DO_XOR_BLOCKS(32regs, xor_32regs_2, xor_32regs_3, xor_32regs_4, xor_32regs_5);
 
 struct xor_block_template xor_block_32regs = {
 	.name		= "32regs",
diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index f18dcc57004b..2ab03dd294bf 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -11,10 +11,14 @@
 #include <linux/raid/xor.h>
 #include <linux/jiffies.h>
 #include <linux/preempt.h>
+#include <linux/static_call.h>
 #include "xor_impl.h"
 
-/* The xor routine to use.  */
-static struct xor_block_template *active_template;
+/*
+ * Provide a temporary default until the fastest or forced implementation is
+ * picked.
+ */
+DEFINE_STATIC_CALL(xor_gen_impl, xor_gen_32regs);
 
 /**
  * xor_gen - generate RAID-style XOR information
@@ -32,13 +36,13 @@ static struct xor_block_template *active_template;
 void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
 {
 	WARN_ON_ONCE(in_interrupt());
-	active_template->xor_gen(dest, srcs, src_cnt, bytes);
+	static_call(xor_gen_impl)(dest, srcs, src_cnt, bytes);
 }
 EXPORT_SYMBOL(xor_gen);
 
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
-static int __initdata xor_forced = false;
+static struct xor_block_template *forced_template;
 
 /**
  * xor_register - register a XOR template
@@ -64,7 +68,7 @@ void __init xor_register(struct xor_block_template *tmpl)
  */
 void __init xor_force(struct xor_block_template *tmpl)
 {
-	active_template = tmpl;
+	forced_template = tmpl;
 }
 
 #define BENCH_SIZE	4096
@@ -106,7 +110,7 @@ static int __init calibrate_xor_blocks(void)
 	void *b1, *b2;
 	struct xor_block_template *f, *fastest;
 
-	if (xor_forced)
+	if (forced_template)
 		return 0;
 
 	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
@@ -123,7 +127,7 @@ static int __init calibrate_xor_blocks(void)
 		if (f->speed > fastest->speed)
 			fastest = f;
 	}
-	active_template = fastest;
+	static_call_update(xor_gen_impl, fastest->xor_gen);
 	pr_info("xor: using function: %s (%d MB/sec)\n",
 	       fastest->name, fastest->speed);
 
@@ -151,21 +155,16 @@ static int __init xor_init(void)
 	 * If this arch/cpu has a short-circuited selection, don't loop through
 	 * all the possible functions, just use the best one.
 	 */
-	if (active_template) {
+	if (forced_template) {
 		pr_info("xor: automatically using best checksumming function   %-10s\n",
-			active_template->name);
-		xor_forced = true;
+			forced_template->name);
+		static_call_update(xor_gen_impl, forced_template->xor_gen);
 		return 0;
 	}
 
 #ifdef MODULE
 	return calibrate_xor_blocks();
 #else
-	/*
-	 * Pick the first template as the temporary default until calibration
-	 * happens.
-	 */
-	active_template = template_list;
 	return 0;
 #endif
 }
diff --git a/lib/raid/xor/xor_impl.h b/lib/raid/xor/xor_impl.h
index 968dd07df627..f11910162b08 100644
--- a/lib/raid/xor/xor_impl.h
+++ b/lib/raid/xor/xor_impl.h
@@ -50,6 +50,10 @@ extern struct xor_block_template xor_block_32regs;
 extern struct xor_block_template xor_block_8regs_p;
 extern struct xor_block_template xor_block_32regs_p;
 
+/* default call until updated */
+void xor_gen_32regs(void *dest, void **srcs, unsigned int src_cnt,
+		unsigned int bytes);
+
 void __init xor_register(struct xor_block_template *tmpl);
 void __init xor_force(struct xor_block_template *tmpl);
 
-- 
2.47.3


