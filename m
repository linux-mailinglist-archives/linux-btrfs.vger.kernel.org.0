Return-Path: <linux-btrfs+bounces-21986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCR8IeZooGm+jQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21986-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:38:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5C1A8D9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 960CD31A8C29
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F63EFD1D;
	Thu, 26 Feb 2026 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URePQ71d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039F3ED113;
	Thu, 26 Feb 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118702; cv=none; b=nJ1c6QOvUi134OSRrK1gzj5nfybXAM18++f3PSk/52mi2nlB/9TCvdI4XSTFXPs51htSozAQtY/X1i8dBYdrNYKHPQAEmsiUS3f1bwiOcRav0c9gKOMm+kNASVU2JckblOpMfxNmQnb5jdqhf5Omxm9De+DqNVqyBe42vuLUVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118702; c=relaxed/simple;
	bh=kkLhTX8SNEP6fadb6HiDEIQ5D5FAdu8ib06EqlKUntA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSubBXv63i6EtDuy+RkMvKz3svYnQByii05nqBwlhQGhUgN+DSvGTCNWhfmONS8YZWe0J4lzMMtn8yN0o9T7G/V5Z/onICM2NxzM7RAr0bRH+SBwfIp0h9I+oY7pHPvs+92MvK80J5vXXFH1G7a1oStET1gy+iaT5x/VKfbjPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=URePQ71d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uWVTxVXofLMNGO7crXJ27khW3O1RifHdgil+Iut8nqA=; b=URePQ71dMeGUGa1CdsTZ/NWEcU
	kN7dqnbo+IzYt3fKmhdSuC1u4M2JlRpUp43VemPG2p9a8/X3pJTAmS286DayguZoIDqV7DNCh1Lr9
	04AkA3PabrFV1Mog+67HBx1F6PkOEbIO+WDokW7MRWklmqx8pINKSn+zvu12BeHbdB6aRWzLtLyUP
	e3qCRYeMLvojSKA7IgpEyu4XiRAzp1GCOh1K3OUjqgd5L4kg7pFHo07P+HGRtUew16mP0ZWekmYbW
	OYdfZGW8Aw+NzDr5qC2Au5lsmLuRDqKVA6UIwN941qa5z0Y+Vb7w41AVKv0i/1x6e12Sp4p1TR0Jb
	vNeljVKA==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1F-00000006PyU-0jJQ;
	Thu, 26 Feb 2026 15:11:13 +0000
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
Subject: [PATCH 04/25] xor: move to lib/raid/
Date: Thu, 26 Feb 2026 07:10:16 -0800
Message-ID: <20260226151106.144735-5-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-21986-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim]
X-Rspamd-Queue-Id: 25A5C1A8D9F
X-Rspamd-Action: no action

Move the RAID XOR code to lib/raid/ as it has nothing to do with the
crypto API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/Kconfig                          | 2 --
 crypto/Makefile                         | 1 -
 lib/Kconfig                             | 1 +
 lib/Makefile                            | 2 +-
 lib/raid/Kconfig                        | 3 +++
 lib/raid/Makefile                       | 2 ++
 lib/raid/xor/Makefile                   | 5 +++++
 crypto/xor.c => lib/raid/xor/xor-core.c | 0
 8 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 lib/raid/Kconfig
 create mode 100644 lib/raid/Makefile
 create mode 100644 lib/raid/xor/Makefile
 rename crypto/xor.c => lib/raid/xor/xor-core.c (100%)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e2b4106ac961..5cdb1b25ae87 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -2,8 +2,6 @@
 #
 # Generic algorithms support
 #
-config XOR_BLOCKS
-	tristate
 
 #
 # async_tx api: hardware offloaded memory transfer/transform support
diff --git a/crypto/Makefile b/crypto/Makefile
index 04e269117589..795c2eea51fe 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -196,7 +196,6 @@ obj-$(CONFIG_CRYPTO_ECRDSA) += ecrdsa_generic.o
 #
 # generic algorithms and the async_tx api
 #
-obj-$(CONFIG_XOR_BLOCKS) += xor.o
 obj-$(CONFIG_ASYNC_CORE) += async_tx/
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += asymmetric_keys/
 crypto_simd-y := simd.o
diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb9610647..5be57adcd454 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -138,6 +138,7 @@ config TRACE_MMIO_ACCESS
 
 source "lib/crc/Kconfig"
 source "lib/crypto/Kconfig"
+source "lib/raid/Kconfig"
 
 config XXHASH
 	tristate
diff --git a/lib/Makefile b/lib/Makefile
index 1b9ee167517f..84da412a044f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -120,7 +120,7 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
 CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
-obj-y += math/ crc/ crypto/ tests/ vdso/
+obj-y += math/ crc/ crypto/ tests/ vdso/ raid/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
diff --git a/lib/raid/Kconfig b/lib/raid/Kconfig
new file mode 100644
index 000000000000..4b720f3454a2
--- /dev/null
+++ b/lib/raid/Kconfig
@@ -0,0 +1,3 @@
+
+config XOR_BLOCKS
+	tristate
diff --git a/lib/raid/Makefile b/lib/raid/Makefile
new file mode 100644
index 000000000000..382f2d1694bd
--- /dev/null
+++ b/lib/raid/Makefile
@@ -0,0 +1,2 @@
+
+obj-y				+= xor/
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
new file mode 100644
index 000000000000..7bca0ce8e90a
--- /dev/null
+++ b/lib/raid/xor/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_XOR_BLOCKS)	+= xor.o
+
+xor-y				+= xor-core.o
diff --git a/crypto/xor.c b/lib/raid/xor/xor-core.c
similarity index 100%
rename from crypto/xor.c
rename to lib/raid/xor/xor-core.c
-- 
2.47.3


