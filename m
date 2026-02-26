Return-Path: <linux-btrfs+bounces-22000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Nx2GNZpoGk3jgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22000-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:42:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28A1A8FA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8B63029AF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0641C2EE;
	Thu, 26 Feb 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xnHX5/c6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD13F23D1;
	Thu, 26 Feb 2026 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118719; cv=none; b=tCKAFaD+5hM5GT0SWPKSiBLODGGGpK0Xw1ZKUQIRR2Ly4WcUaH94+8kApuOHs4L2Pq3/rKZarEkAbqzswQnxbr2hNkX4gpA00SBQJe2fEt8rbwjjJ7EVkE68X3JrI4+YcJW+ByHbb+kkLUlRWYIYqbQnUyPORvzMcDiaMS1eRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118719; c=relaxed/simple;
	bh=bSGYfU+NSLebUTI0qeINaGfAUS3aoaLS0g6HCxdQ4+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaKd5fp9XHba0+nMUiVSvpvSDXoOvmftaOal/UFMjuGJUiDvKTL+/S3ce6vHehoLqGU3uZx/6nrvg5K3Gs0dE574vmNYP/aKzOzS1KGh7bWdayfUnbECXVJT6fX6OVVwU67h2X5ZZgRcdeoVcxtNya7br17EQdIqHu405v4vBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xnHX5/c6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UZ1AI4WO/A62adxyb/Oc887TemGMIj0BXG02atwm4qQ=; b=xnHX5/c6BLaL+eGizbHcSes+Vt
	S1cd5vaUrpdJf9mzPQMBfkesh+HM48Hc5m2bZhcu1NPiT6ka3K208aaJLoVM2EBZGxoHBw4N+JXXs
	cLOtYlU12aYj5F9sRlJhDdkhkuFvUFg7sEueuEX2zq1e2RZmBOq8ALvupG6Og4YsX7SDz69wqZY33
	XH0k/6iK9vwqm0nbg1ZOTTIo1VmSMPZAkv54L49nDY20ur9kVMJIW5L0paC52VNiKXAqnk1+VecYe
	oX6eSviAc8mPByoDJIXmzSPqBp9C8YrKZgvPWIQbFe3QOax+bpSXTUgZWQOcg7nkOW9OmGI8RMV3h
	yCWa+bxw==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1O-00000006Q8M-09qg;
	Thu, 26 Feb 2026 15:11:22 +0000
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
Subject: [PATCH 10/25] alpha: move the XOR code to lib/raid/
Date: Thu, 26 Feb 2026 07:10:22 -0800
Message-ID: <20260226151106.144735-11-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-22000-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 8B28A1A8FA2
X-Rspamd-Action: no action

Move the optimized XOR code out of line into lib/raid.

Note that the giant inline assembly block might be better off as a
separate assembly source file now, but I'll leave that to the alpha
maintainers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/xor.h | 853 +----------------------------------
 lib/raid/xor/Makefile        |   2 +
 lib/raid/xor/alpha/xor.c     | 849 ++++++++++++++++++++++++++++++++++
 3 files changed, 855 insertions(+), 849 deletions(-)
 create mode 100644 lib/raid/xor/alpha/xor.c

diff --git a/arch/alpha/include/asm/xor.h b/arch/alpha/include/asm/xor.h
index 4c8085711df1..e517be577a09 100644
--- a/arch/alpha/include/asm/xor.h
+++ b/arch/alpha/include/asm/xor.h
@@ -1,856 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * include/asm-alpha/xor.h
- *
- * Optimized RAID-5 checksumming functions for alpha EV5 and EV6
- */
-
-extern void
-xor_alpha_2(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2);
-extern void
-xor_alpha_3(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2,
-	    const unsigned long * __restrict p3);
-extern void
-xor_alpha_4(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2,
-	    const unsigned long * __restrict p3,
-	    const unsigned long * __restrict p4);
-extern void
-xor_alpha_5(unsigned long bytes, unsigned long * __restrict p1,
-	    const unsigned long * __restrict p2,
-	    const unsigned long * __restrict p3,
-	    const unsigned long * __restrict p4,
-	    const unsigned long * __restrict p5);
-
-extern void
-xor_alpha_prefetch_2(unsigned long bytes, unsigned long * __restrict p1,
-		     const unsigned long * __restrict p2);
-extern void
-xor_alpha_prefetch_3(unsigned long bytes, unsigned long * __restrict p1,
-		     const unsigned long * __restrict p2,
-		     const unsigned long * __restrict p3);
-extern void
-xor_alpha_prefetch_4(unsigned long bytes, unsigned long * __restrict p1,
-		     const unsigned long * __restrict p2,
-		     const unsigned long * __restrict p3,
-		     const unsigned long * __restrict p4);
-extern void
-xor_alpha_prefetch_5(unsigned long bytes, unsigned long * __restrict p1,
-		     const unsigned long * __restrict p2,
-		     const unsigned long * __restrict p3,
-		     const unsigned long * __restrict p4,
-		     const unsigned long * __restrict p5);
 
-asm("								\n\
-	.text							\n\
-	.align 3						\n\
-	.ent xor_alpha_2					\n\
-xor_alpha_2:							\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-	.align 4						\n\
-2:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,8($17)						\n\
-	ldq $3,8($18)						\n\
-								\n\
-	ldq $4,16($17)						\n\
-	ldq $5,16($18)						\n\
-	ldq $6,24($17)						\n\
-	ldq $7,24($18)						\n\
-								\n\
-	ldq $19,32($17)						\n\
-	ldq $20,32($18)						\n\
-	ldq $21,40($17)						\n\
-	ldq $22,40($18)						\n\
-								\n\
-	ldq $23,48($17)						\n\
-	ldq $24,48($18)						\n\
-	ldq $25,56($17)						\n\
-	xor $0,$1,$0		# 7 cycles from $1 load		\n\
-								\n\
-	ldq $27,56($18)						\n\
-	xor $2,$3,$2						\n\
-	stq $0,0($17)						\n\
-	xor $4,$5,$4						\n\
-								\n\
-	stq $2,8($17)						\n\
-	xor $6,$7,$6						\n\
-	stq $4,16($17)						\n\
-	xor $19,$20,$19						\n\
-								\n\
-	stq $6,24($17)						\n\
-	xor $21,$22,$21						\n\
-	stq $19,32($17)						\n\
-	xor $23,$24,$23						\n\
-								\n\
-	stq $21,40($17)						\n\
-	xor $25,$27,$25						\n\
-	stq $23,48($17)						\n\
-	subq $16,1,$16						\n\
-								\n\
-	stq $25,56($17)						\n\
-	addq $17,64,$17						\n\
-	addq $18,64,$18						\n\
-	bgt $16,2b						\n\
-								\n\
-	ret							\n\
-	.end xor_alpha_2					\n\
-								\n\
-	.align 3						\n\
-	.ent xor_alpha_3					\n\
-xor_alpha_3:							\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-	.align 4						\n\
-3:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,0($19)						\n\
-	ldq $3,8($17)						\n\
-								\n\
-	ldq $4,8($18)						\n\
-	ldq $6,16($17)						\n\
-	ldq $7,16($18)						\n\
-	ldq $21,24($17)						\n\
-								\n\
-	ldq $22,24($18)						\n\
-	ldq $24,32($17)						\n\
-	ldq $25,32($18)						\n\
-	ldq $5,8($19)						\n\
-								\n\
-	ldq $20,16($19)						\n\
-	ldq $23,24($19)						\n\
-	ldq $27,32($19)						\n\
-	nop							\n\
-								\n\
-	xor $0,$1,$1		# 8 cycles from $0 load		\n\
-	xor $3,$4,$4		# 6 cycles from $4 load		\n\
-	xor $6,$7,$7		# 6 cycles from $7 load		\n\
-	xor $21,$22,$22		# 5 cycles from $22 load	\n\
-								\n\
-	xor $1,$2,$2		# 9 cycles from $2 load		\n\
-	xor $24,$25,$25		# 5 cycles from $25 load	\n\
-	stq $2,0($17)						\n\
-	xor $4,$5,$5		# 6 cycles from $5 load		\n\
-								\n\
-	stq $5,8($17)						\n\
-	xor $7,$20,$20		# 7 cycles from $20 load	\n\
-	stq $20,16($17)						\n\
-	xor $22,$23,$23		# 7 cycles from $23 load	\n\
-								\n\
-	stq $23,24($17)						\n\
-	xor $25,$27,$27		# 7 cycles from $27 load	\n\
-	stq $27,32($17)						\n\
-	nop							\n\
-								\n\
-	ldq $0,40($17)						\n\
-	ldq $1,40($18)						\n\
-	ldq $3,48($17)						\n\
-	ldq $4,48($18)						\n\
-								\n\
-	ldq $6,56($17)						\n\
-	ldq $7,56($18)						\n\
-	ldq $2,40($19)						\n\
-	ldq $5,48($19)						\n\
-								\n\
-	ldq $20,56($19)						\n\
-	xor $0,$1,$1		# 4 cycles from $1 load		\n\
-	xor $3,$4,$4		# 5 cycles from $4 load		\n\
-	xor $6,$7,$7		# 5 cycles from $7 load		\n\
-								\n\
-	xor $1,$2,$2		# 4 cycles from $2 load		\n\
-	xor $4,$5,$5		# 5 cycles from $5 load		\n\
-	stq $2,40($17)						\n\
-	xor $7,$20,$20		# 4 cycles from $20 load	\n\
-								\n\
-	stq $5,48($17)						\n\
-	subq $16,1,$16						\n\
-	stq $20,56($17)						\n\
-	addq $19,64,$19						\n\
-								\n\
-	addq $18,64,$18						\n\
-	addq $17,64,$17						\n\
-	bgt $16,3b						\n\
-	ret							\n\
-	.end xor_alpha_3					\n\
-								\n\
-	.align 3						\n\
-	.ent xor_alpha_4					\n\
-xor_alpha_4:							\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-	.align 4						\n\
-4:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,0($19)						\n\
-	ldq $3,0($20)						\n\
-								\n\
-	ldq $4,8($17)						\n\
-	ldq $5,8($18)						\n\
-	ldq $6,8($19)						\n\
-	ldq $7,8($20)						\n\
-								\n\
-	ldq $21,16($17)						\n\
-	ldq $22,16($18)						\n\
-	ldq $23,16($19)						\n\
-	ldq $24,16($20)						\n\
-								\n\
-	ldq $25,24($17)						\n\
-	xor $0,$1,$1		# 6 cycles from $1 load		\n\
-	ldq $27,24($18)						\n\
-	xor $2,$3,$3		# 6 cycles from $3 load		\n\
-								\n\
-	ldq $0,24($19)						\n\
-	xor $1,$3,$3						\n\
-	ldq $1,24($20)						\n\
-	xor $4,$5,$5		# 7 cycles from $5 load		\n\
-								\n\
-	stq $3,0($17)						\n\
-	xor $6,$7,$7						\n\
-	xor $21,$22,$22		# 7 cycles from $22 load	\n\
-	xor $5,$7,$7						\n\
-								\n\
-	stq $7,8($17)						\n\
-	xor $23,$24,$24		# 7 cycles from $24 load	\n\
-	ldq $2,32($17)						\n\
-	xor $22,$24,$24						\n\
-								\n\
-	ldq $3,32($18)						\n\
-	ldq $4,32($19)						\n\
-	ldq $5,32($20)						\n\
-	xor $25,$27,$27		# 8 cycles from $27 load	\n\
-								\n\
-	ldq $6,40($17)						\n\
-	ldq $7,40($18)						\n\
-	ldq $21,40($19)						\n\
-	ldq $22,40($20)						\n\
-								\n\
-	stq $24,16($17)						\n\
-	xor $0,$1,$1		# 9 cycles from $1 load		\n\
-	xor $2,$3,$3		# 5 cycles from $3 load		\n\
-	xor $27,$1,$1						\n\
-								\n\
-	stq $1,24($17)						\n\
-	xor $4,$5,$5		# 5 cycles from $5 load		\n\
-	ldq $23,48($17)						\n\
-	ldq $24,48($18)						\n\
-								\n\
-	ldq $25,48($19)						\n\
-	xor $3,$5,$5						\n\
-	ldq $27,48($20)						\n\
-	ldq $0,56($17)						\n\
-								\n\
-	ldq $1,56($18)						\n\
-	ldq $2,56($19)						\n\
-	xor $6,$7,$7		# 8 cycles from $6 load		\n\
-	ldq $3,56($20)						\n\
-								\n\
-	stq $5,32($17)						\n\
-	xor $21,$22,$22		# 8 cycles from $22 load	\n\
-	xor $7,$22,$22						\n\
-	xor $23,$24,$24		# 5 cycles from $24 load	\n\
-								\n\
-	stq $22,40($17)						\n\
-	xor $25,$27,$27		# 5 cycles from $27 load	\n\
-	xor $24,$27,$27						\n\
-	xor $0,$1,$1		# 5 cycles from $1 load		\n\
-								\n\
-	stq $27,48($17)						\n\
-	xor $2,$3,$3		# 4 cycles from $3 load		\n\
-	xor $1,$3,$3						\n\
-	subq $16,1,$16						\n\
-								\n\
-	stq $3,56($17)						\n\
-	addq $20,64,$20						\n\
-	addq $19,64,$19						\n\
-	addq $18,64,$18						\n\
-								\n\
-	addq $17,64,$17						\n\
-	bgt $16,4b						\n\
-	ret							\n\
-	.end xor_alpha_4					\n\
-								\n\
-	.align 3						\n\
-	.ent xor_alpha_5					\n\
-xor_alpha_5:							\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-	.align 4						\n\
-5:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,0($19)						\n\
-	ldq $3,0($20)						\n\
-								\n\
-	ldq $4,0($21)						\n\
-	ldq $5,8($17)						\n\
-	ldq $6,8($18)						\n\
-	ldq $7,8($19)						\n\
-								\n\
-	ldq $22,8($20)						\n\
-	ldq $23,8($21)						\n\
-	ldq $24,16($17)						\n\
-	ldq $25,16($18)						\n\
-								\n\
-	ldq $27,16($19)						\n\
-	xor $0,$1,$1		# 6 cycles from $1 load		\n\
-	ldq $28,16($20)						\n\
-	xor $2,$3,$3		# 6 cycles from $3 load		\n\
-								\n\
-	ldq $0,16($21)						\n\
-	xor $1,$3,$3						\n\
-	ldq $1,24($17)						\n\
-	xor $3,$4,$4		# 7 cycles from $4 load		\n\
-								\n\
-	stq $4,0($17)						\n\
-	xor $5,$6,$6		# 7 cycles from $6 load		\n\
-	xor $7,$22,$22		# 7 cycles from $22 load	\n\
-	xor $6,$23,$23		# 7 cycles from $23 load	\n\
-								\n\
-	ldq $2,24($18)						\n\
-	xor $22,$23,$23						\n\
-	ldq $3,24($19)						\n\
-	xor $24,$25,$25		# 8 cycles from $25 load	\n\
-								\n\
-	stq $23,8($17)						\n\
-	xor $25,$27,$27		# 8 cycles from $27 load	\n\
-	ldq $4,24($20)						\n\
-	xor $28,$0,$0		# 7 cycles from $0 load		\n\
-								\n\
-	ldq $5,24($21)						\n\
-	xor $27,$0,$0						\n\
-	ldq $6,32($17)						\n\
-	ldq $7,32($18)						\n\
-								\n\
-	stq $0,16($17)						\n\
-	xor $1,$2,$2		# 6 cycles from $2 load		\n\
-	ldq $22,32($19)						\n\
-	xor $3,$4,$4		# 4 cycles from $4 load		\n\
-								\n\
-	ldq $23,32($20)						\n\
-	xor $2,$4,$4						\n\
-	ldq $24,32($21)						\n\
-	ldq $25,40($17)						\n\
-								\n\
-	ldq $27,40($18)						\n\
-	ldq $28,40($19)						\n\
-	ldq $0,40($20)						\n\
-	xor $4,$5,$5		# 7 cycles from $5 load		\n\
-								\n\
-	stq $5,24($17)						\n\
-	xor $6,$7,$7		# 7 cycles from $7 load		\n\
-	ldq $1,40($21)						\n\
-	ldq $2,48($17)						\n\
-								\n\
-	ldq $3,48($18)						\n\
-	xor $7,$22,$22		# 7 cycles from $22 load	\n\
-	ldq $4,48($19)						\n\
-	xor $23,$24,$24		# 6 cycles from $24 load	\n\
-								\n\
-	ldq $5,48($20)						\n\
-	xor $22,$24,$24						\n\
-	ldq $6,48($21)						\n\
-	xor $25,$27,$27		# 7 cycles from $27 load	\n\
-								\n\
-	stq $24,32($17)						\n\
-	xor $27,$28,$28		# 8 cycles from $28 load	\n\
-	ldq $7,56($17)						\n\
-	xor $0,$1,$1		# 6 cycles from $1 load		\n\
-								\n\
-	ldq $22,56($18)						\n\
-	ldq $23,56($19)						\n\
-	ldq $24,56($20)						\n\
-	ldq $25,56($21)						\n\
-								\n\
-	xor $28,$1,$1						\n\
-	xor $2,$3,$3		# 9 cycles from $3 load		\n\
-	xor $3,$4,$4		# 9 cycles from $4 load		\n\
-	xor $5,$6,$6		# 8 cycles from $6 load		\n\
-								\n\
-	stq $1,40($17)						\n\
-	xor $4,$6,$6						\n\
-	xor $7,$22,$22		# 7 cycles from $22 load	\n\
-	xor $23,$24,$24		# 6 cycles from $24 load	\n\
-								\n\
-	stq $6,48($17)						\n\
-	xor $22,$24,$24						\n\
-	subq $16,1,$16						\n\
-	xor $24,$25,$25		# 8 cycles from $25 load	\n\
-								\n\
-	stq $25,56($17)						\n\
-	addq $21,64,$21						\n\
-	addq $20,64,$20						\n\
-	addq $19,64,$19						\n\
-								\n\
-	addq $18,64,$18						\n\
-	addq $17,64,$17						\n\
-	bgt $16,5b						\n\
-	ret							\n\
-	.end xor_alpha_5					\n\
-								\n\
-	.align 3						\n\
-	.ent xor_alpha_prefetch_2				\n\
-xor_alpha_prefetch_2:						\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-								\n\
-	ldq $31, 0($17)						\n\
-	ldq $31, 0($18)						\n\
-								\n\
-	ldq $31, 64($17)					\n\
-	ldq $31, 64($18)					\n\
-								\n\
-	ldq $31, 128($17)					\n\
-	ldq $31, 128($18)					\n\
-								\n\
-	ldq $31, 192($17)					\n\
-	ldq $31, 192($18)					\n\
-	.align 4						\n\
-2:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,8($17)						\n\
-	ldq $3,8($18)						\n\
-								\n\
-	ldq $4,16($17)						\n\
-	ldq $5,16($18)						\n\
-	ldq $6,24($17)						\n\
-	ldq $7,24($18)						\n\
-								\n\
-	ldq $19,32($17)						\n\
-	ldq $20,32($18)						\n\
-	ldq $21,40($17)						\n\
-	ldq $22,40($18)						\n\
-								\n\
-	ldq $23,48($17)						\n\
-	ldq $24,48($18)						\n\
-	ldq $25,56($17)						\n\
-	ldq $27,56($18)						\n\
-								\n\
-	ldq $31,256($17)					\n\
-	xor $0,$1,$0		# 8 cycles from $1 load		\n\
-	ldq $31,256($18)					\n\
-	xor $2,$3,$2						\n\
-								\n\
-	stq $0,0($17)						\n\
-	xor $4,$5,$4						\n\
-	stq $2,8($17)						\n\
-	xor $6,$7,$6						\n\
-								\n\
-	stq $4,16($17)						\n\
-	xor $19,$20,$19						\n\
-	stq $6,24($17)						\n\
-	xor $21,$22,$21						\n\
-								\n\
-	stq $19,32($17)						\n\
-	xor $23,$24,$23						\n\
-	stq $21,40($17)						\n\
-	xor $25,$27,$25						\n\
-								\n\
-	stq $23,48($17)						\n\
-	subq $16,1,$16						\n\
-	stq $25,56($17)						\n\
-	addq $17,64,$17						\n\
-								\n\
-	addq $18,64,$18						\n\
-	bgt $16,2b						\n\
-	ret							\n\
-	.end xor_alpha_prefetch_2				\n\
-								\n\
-	.align 3						\n\
-	.ent xor_alpha_prefetch_3				\n\
-xor_alpha_prefetch_3:						\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-								\n\
-	ldq $31, 0($17)						\n\
-	ldq $31, 0($18)						\n\
-	ldq $31, 0($19)						\n\
-								\n\
-	ldq $31, 64($17)					\n\
-	ldq $31, 64($18)					\n\
-	ldq $31, 64($19)					\n\
-								\n\
-	ldq $31, 128($17)					\n\
-	ldq $31, 128($18)					\n\
-	ldq $31, 128($19)					\n\
-								\n\
-	ldq $31, 192($17)					\n\
-	ldq $31, 192($18)					\n\
-	ldq $31, 192($19)					\n\
-	.align 4						\n\
-3:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,0($19)						\n\
-	ldq $3,8($17)						\n\
-								\n\
-	ldq $4,8($18)						\n\
-	ldq $6,16($17)						\n\
-	ldq $7,16($18)						\n\
-	ldq $21,24($17)						\n\
-								\n\
-	ldq $22,24($18)						\n\
-	ldq $24,32($17)						\n\
-	ldq $25,32($18)						\n\
-	ldq $5,8($19)						\n\
-								\n\
-	ldq $20,16($19)						\n\
-	ldq $23,24($19)						\n\
-	ldq $27,32($19)						\n\
-	nop							\n\
-								\n\
-	xor $0,$1,$1		# 8 cycles from $0 load		\n\
-	xor $3,$4,$4		# 7 cycles from $4 load		\n\
-	xor $6,$7,$7		# 6 cycles from $7 load		\n\
-	xor $21,$22,$22		# 5 cycles from $22 load	\n\
-								\n\
-	xor $1,$2,$2		# 9 cycles from $2 load		\n\
-	xor $24,$25,$25		# 5 cycles from $25 load	\n\
-	stq $2,0($17)						\n\
-	xor $4,$5,$5		# 6 cycles from $5 load		\n\
-								\n\
-	stq $5,8($17)						\n\
-	xor $7,$20,$20		# 7 cycles from $20 load	\n\
-	stq $20,16($17)						\n\
-	xor $22,$23,$23		# 7 cycles from $23 load	\n\
-								\n\
-	stq $23,24($17)						\n\
-	xor $25,$27,$27		# 7 cycles from $27 load	\n\
-	stq $27,32($17)						\n\
-	nop							\n\
-								\n\
-	ldq $0,40($17)						\n\
-	ldq $1,40($18)						\n\
-	ldq $3,48($17)						\n\
-	ldq $4,48($18)						\n\
-								\n\
-	ldq $6,56($17)						\n\
-	ldq $7,56($18)						\n\
-	ldq $2,40($19)						\n\
-	ldq $5,48($19)						\n\
-								\n\
-	ldq $20,56($19)						\n\
-	ldq $31,256($17)					\n\
-	ldq $31,256($18)					\n\
-	ldq $31,256($19)					\n\
-								\n\
-	xor $0,$1,$1		# 6 cycles from $1 load		\n\
-	xor $3,$4,$4		# 5 cycles from $4 load		\n\
-	xor $6,$7,$7		# 5 cycles from $7 load		\n\
-	xor $1,$2,$2		# 4 cycles from $2 load		\n\
-								\n\
-	xor $4,$5,$5		# 5 cycles from $5 load		\n\
-	xor $7,$20,$20		# 4 cycles from $20 load	\n\
-	stq $2,40($17)						\n\
-	subq $16,1,$16						\n\
-								\n\
-	stq $5,48($17)						\n\
-	addq $19,64,$19						\n\
-	stq $20,56($17)						\n\
-	addq $18,64,$18						\n\
-								\n\
-	addq $17,64,$17						\n\
-	bgt $16,3b						\n\
-	ret							\n\
-	.end xor_alpha_prefetch_3				\n\
-								\n\
-	.align 3						\n\
-	.ent xor_alpha_prefetch_4				\n\
-xor_alpha_prefetch_4:						\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-								\n\
-	ldq $31, 0($17)						\n\
-	ldq $31, 0($18)						\n\
-	ldq $31, 0($19)						\n\
-	ldq $31, 0($20)						\n\
-								\n\
-	ldq $31, 64($17)					\n\
-	ldq $31, 64($18)					\n\
-	ldq $31, 64($19)					\n\
-	ldq $31, 64($20)					\n\
-								\n\
-	ldq $31, 128($17)					\n\
-	ldq $31, 128($18)					\n\
-	ldq $31, 128($19)					\n\
-	ldq $31, 128($20)					\n\
-								\n\
-	ldq $31, 192($17)					\n\
-	ldq $31, 192($18)					\n\
-	ldq $31, 192($19)					\n\
-	ldq $31, 192($20)					\n\
-	.align 4						\n\
-4:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,0($19)						\n\
-	ldq $3,0($20)						\n\
-								\n\
-	ldq $4,8($17)						\n\
-	ldq $5,8($18)						\n\
-	ldq $6,8($19)						\n\
-	ldq $7,8($20)						\n\
-								\n\
-	ldq $21,16($17)						\n\
-	ldq $22,16($18)						\n\
-	ldq $23,16($19)						\n\
-	ldq $24,16($20)						\n\
-								\n\
-	ldq $25,24($17)						\n\
-	xor $0,$1,$1		# 6 cycles from $1 load		\n\
-	ldq $27,24($18)						\n\
-	xor $2,$3,$3		# 6 cycles from $3 load		\n\
-								\n\
-	ldq $0,24($19)						\n\
-	xor $1,$3,$3						\n\
-	ldq $1,24($20)						\n\
-	xor $4,$5,$5		# 7 cycles from $5 load		\n\
-								\n\
-	stq $3,0($17)						\n\
-	xor $6,$7,$7						\n\
-	xor $21,$22,$22		# 7 cycles from $22 load	\n\
-	xor $5,$7,$7						\n\
-								\n\
-	stq $7,8($17)						\n\
-	xor $23,$24,$24		# 7 cycles from $24 load	\n\
-	ldq $2,32($17)						\n\
-	xor $22,$24,$24						\n\
-								\n\
-	ldq $3,32($18)						\n\
-	ldq $4,32($19)						\n\
-	ldq $5,32($20)						\n\
-	xor $25,$27,$27		# 8 cycles from $27 load	\n\
-								\n\
-	ldq $6,40($17)						\n\
-	ldq $7,40($18)						\n\
-	ldq $21,40($19)						\n\
-	ldq $22,40($20)						\n\
-								\n\
-	stq $24,16($17)						\n\
-	xor $0,$1,$1		# 9 cycles from $1 load		\n\
-	xor $2,$3,$3		# 5 cycles from $3 load		\n\
-	xor $27,$1,$1						\n\
-								\n\
-	stq $1,24($17)						\n\
-	xor $4,$5,$5		# 5 cycles from $5 load		\n\
-	ldq $23,48($17)						\n\
-	xor $3,$5,$5						\n\
-								\n\
-	ldq $24,48($18)						\n\
-	ldq $25,48($19)						\n\
-	ldq $27,48($20)						\n\
-	ldq $0,56($17)						\n\
-								\n\
-	ldq $1,56($18)						\n\
-	ldq $2,56($19)						\n\
-	ldq $3,56($20)						\n\
-	xor $6,$7,$7		# 8 cycles from $6 load		\n\
-								\n\
-	ldq $31,256($17)					\n\
-	xor $21,$22,$22		# 8 cycles from $22 load	\n\
-	ldq $31,256($18)					\n\
-	xor $7,$22,$22						\n\
-								\n\
-	ldq $31,256($19)					\n\
-	xor $23,$24,$24		# 6 cycles from $24 load	\n\
-	ldq $31,256($20)					\n\
-	xor $25,$27,$27		# 6 cycles from $27 load	\n\
-								\n\
-	stq $5,32($17)						\n\
-	xor $24,$27,$27						\n\
-	xor $0,$1,$1		# 7 cycles from $1 load		\n\
-	xor $2,$3,$3		# 6 cycles from $3 load		\n\
-								\n\
-	stq $22,40($17)						\n\
-	xor $1,$3,$3						\n\
-	stq $27,48($17)						\n\
-	subq $16,1,$16						\n\
-								\n\
-	stq $3,56($17)						\n\
-	addq $20,64,$20						\n\
-	addq $19,64,$19						\n\
-	addq $18,64,$18						\n\
-								\n\
-	addq $17,64,$17						\n\
-	bgt $16,4b						\n\
-	ret							\n\
-	.end xor_alpha_prefetch_4				\n\
-								\n\
-	.align 3						\n\
-	.ent xor_alpha_prefetch_5				\n\
-xor_alpha_prefetch_5:						\n\
-	.prologue 0						\n\
-	srl $16, 6, $16						\n\
-								\n\
-	ldq $31, 0($17)						\n\
-	ldq $31, 0($18)						\n\
-	ldq $31, 0($19)						\n\
-	ldq $31, 0($20)						\n\
-	ldq $31, 0($21)						\n\
-								\n\
-	ldq $31, 64($17)					\n\
-	ldq $31, 64($18)					\n\
-	ldq $31, 64($19)					\n\
-	ldq $31, 64($20)					\n\
-	ldq $31, 64($21)					\n\
-								\n\
-	ldq $31, 128($17)					\n\
-	ldq $31, 128($18)					\n\
-	ldq $31, 128($19)					\n\
-	ldq $31, 128($20)					\n\
-	ldq $31, 128($21)					\n\
-								\n\
-	ldq $31, 192($17)					\n\
-	ldq $31, 192($18)					\n\
-	ldq $31, 192($19)					\n\
-	ldq $31, 192($20)					\n\
-	ldq $31, 192($21)					\n\
-	.align 4						\n\
-5:								\n\
-	ldq $0,0($17)						\n\
-	ldq $1,0($18)						\n\
-	ldq $2,0($19)						\n\
-	ldq $3,0($20)						\n\
-								\n\
-	ldq $4,0($21)						\n\
-	ldq $5,8($17)						\n\
-	ldq $6,8($18)						\n\
-	ldq $7,8($19)						\n\
-								\n\
-	ldq $22,8($20)						\n\
-	ldq $23,8($21)						\n\
-	ldq $24,16($17)						\n\
-	ldq $25,16($18)						\n\
-								\n\
-	ldq $27,16($19)						\n\
-	xor $0,$1,$1		# 6 cycles from $1 load		\n\
-	ldq $28,16($20)						\n\
-	xor $2,$3,$3		# 6 cycles from $3 load		\n\
-								\n\
-	ldq $0,16($21)						\n\
-	xor $1,$3,$3						\n\
-	ldq $1,24($17)						\n\
-	xor $3,$4,$4		# 7 cycles from $4 load		\n\
-								\n\
-	stq $4,0($17)						\n\
-	xor $5,$6,$6		# 7 cycles from $6 load		\n\
-	xor $7,$22,$22		# 7 cycles from $22 load	\n\
-	xor $6,$23,$23		# 7 cycles from $23 load	\n\
-								\n\
-	ldq $2,24($18)						\n\
-	xor $22,$23,$23						\n\
-	ldq $3,24($19)						\n\
-	xor $24,$25,$25		# 8 cycles from $25 load	\n\
-								\n\
-	stq $23,8($17)						\n\
-	xor $25,$27,$27		# 8 cycles from $27 load	\n\
-	ldq $4,24($20)						\n\
-	xor $28,$0,$0		# 7 cycles from $0 load		\n\
-								\n\
-	ldq $5,24($21)						\n\
-	xor $27,$0,$0						\n\
-	ldq $6,32($17)						\n\
-	ldq $7,32($18)						\n\
-								\n\
-	stq $0,16($17)						\n\
-	xor $1,$2,$2		# 6 cycles from $2 load		\n\
-	ldq $22,32($19)						\n\
-	xor $3,$4,$4		# 4 cycles from $4 load		\n\
-								\n\
-	ldq $23,32($20)						\n\
-	xor $2,$4,$4						\n\
-	ldq $24,32($21)						\n\
-	ldq $25,40($17)						\n\
-								\n\
-	ldq $27,40($18)						\n\
-	ldq $28,40($19)						\n\
-	ldq $0,40($20)						\n\
-	xor $4,$5,$5		# 7 cycles from $5 load		\n\
-								\n\
-	stq $5,24($17)						\n\
-	xor $6,$7,$7		# 7 cycles from $7 load		\n\
-	ldq $1,40($21)						\n\
-	ldq $2,48($17)						\n\
-								\n\
-	ldq $3,48($18)						\n\
-	xor $7,$22,$22		# 7 cycles from $22 load	\n\
-	ldq $4,48($19)						\n\
-	xor $23,$24,$24		# 6 cycles from $24 load	\n\
-								\n\
-	ldq $5,48($20)						\n\
-	xor $22,$24,$24						\n\
-	ldq $6,48($21)						\n\
-	xor $25,$27,$27		# 7 cycles from $27 load	\n\
-								\n\
-	stq $24,32($17)						\n\
-	xor $27,$28,$28		# 8 cycles from $28 load	\n\
-	ldq $7,56($17)						\n\
-	xor $0,$1,$1		# 6 cycles from $1 load		\n\
-								\n\
-	ldq $22,56($18)						\n\
-	ldq $23,56($19)						\n\
-	ldq $24,56($20)						\n\
-	ldq $25,56($21)						\n\
-								\n\
-	ldq $31,256($17)					\n\
-	xor $28,$1,$1						\n\
-	ldq $31,256($18)					\n\
-	xor $2,$3,$3		# 9 cycles from $3 load		\n\
-								\n\
-	ldq $31,256($19)					\n\
-	xor $3,$4,$4		# 9 cycles from $4 load		\n\
-	ldq $31,256($20)					\n\
-	xor $5,$6,$6		# 8 cycles from $6 load		\n\
-								\n\
-	stq $1,40($17)						\n\
-	xor $4,$6,$6						\n\
-	xor $7,$22,$22		# 7 cycles from $22 load	\n\
-	xor $23,$24,$24		# 6 cycles from $24 load	\n\
-								\n\
-	stq $6,48($17)						\n\
-	xor $22,$24,$24						\n\
-	ldq $31,256($21)					\n\
-	xor $24,$25,$25		# 8 cycles from $25 load	\n\
-								\n\
-	stq $25,56($17)						\n\
-	subq $16,1,$16						\n\
-	addq $21,64,$21						\n\
-	addq $20,64,$20						\n\
-								\n\
-	addq $19,64,$19						\n\
-	addq $18,64,$18						\n\
-	addq $17,64,$17						\n\
-	bgt $16,5b						\n\
-								\n\
-	ret							\n\
-	.end xor_alpha_prefetch_5				\n\
-");
-
-static struct xor_block_template xor_block_alpha = {
-	.name	= "alpha",
-	.do_2	= xor_alpha_2,
-	.do_3	= xor_alpha_3,
-	.do_4	= xor_alpha_4,
-	.do_5	= xor_alpha_5,
-};
-
-static struct xor_block_template xor_block_alpha_prefetch = {
-	.name	= "alpha prefetch",
-	.do_2	= xor_alpha_prefetch_2,
-	.do_3	= xor_alpha_prefetch_3,
-	.do_4	= xor_alpha_prefetch_4,
-	.do_5	= xor_alpha_prefetch_5,
-};
-
-/* For grins, also test the generic routines.  */
+#include <asm/special_insns.h>
 #include <asm-generic/xor.h>
 
+extern struct xor_block_template xor_block_alpha;
+extern struct xor_block_template xor_block_alpha_prefetch;
+
 /*
  * Force the use of alpha_prefetch if EV6, as it is significantly faster in the
  * cold cache case.
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 89a944c9f990..6d03c27c37c7 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -7,3 +7,5 @@ xor-y				+= xor-8regs.o
 xor-y				+= xor-32regs.o
 xor-y				+= xor-8regs-prefetch.o
 xor-y				+= xor-32regs-prefetch.o
+
+xor-$(CONFIG_ALPHA)		+= alpha/xor.o
diff --git a/lib/raid/xor/alpha/xor.c b/lib/raid/xor/alpha/xor.c
new file mode 100644
index 000000000000..0964ac420604
--- /dev/null
+++ b/lib/raid/xor/alpha/xor.c
@@ -0,0 +1,849 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Optimized XOR parity functions for alpha EV5 and EV6
+ */
+#include <linux/raid/xor_impl.h>
+#include <asm/xor.h>
+
+extern void
+xor_alpha_2(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2);
+extern void
+xor_alpha_3(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2,
+	    const unsigned long * __restrict p3);
+extern void
+xor_alpha_4(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2,
+	    const unsigned long * __restrict p3,
+	    const unsigned long * __restrict p4);
+extern void
+xor_alpha_5(unsigned long bytes, unsigned long * __restrict p1,
+	    const unsigned long * __restrict p2,
+	    const unsigned long * __restrict p3,
+	    const unsigned long * __restrict p4,
+	    const unsigned long * __restrict p5);
+
+extern void
+xor_alpha_prefetch_2(unsigned long bytes, unsigned long * __restrict p1,
+		     const unsigned long * __restrict p2);
+extern void
+xor_alpha_prefetch_3(unsigned long bytes, unsigned long * __restrict p1,
+		     const unsigned long * __restrict p2,
+		     const unsigned long * __restrict p3);
+extern void
+xor_alpha_prefetch_4(unsigned long bytes, unsigned long * __restrict p1,
+		     const unsigned long * __restrict p2,
+		     const unsigned long * __restrict p3,
+		     const unsigned long * __restrict p4);
+extern void
+xor_alpha_prefetch_5(unsigned long bytes, unsigned long * __restrict p1,
+		     const unsigned long * __restrict p2,
+		     const unsigned long * __restrict p3,
+		     const unsigned long * __restrict p4,
+		     const unsigned long * __restrict p5);
+
+asm("								\n\
+	.text							\n\
+	.align 3						\n\
+	.ent xor_alpha_2					\n\
+xor_alpha_2:							\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+	.align 4						\n\
+2:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,8($17)						\n\
+	ldq $3,8($18)						\n\
+								\n\
+	ldq $4,16($17)						\n\
+	ldq $5,16($18)						\n\
+	ldq $6,24($17)						\n\
+	ldq $7,24($18)						\n\
+								\n\
+	ldq $19,32($17)						\n\
+	ldq $20,32($18)						\n\
+	ldq $21,40($17)						\n\
+	ldq $22,40($18)						\n\
+								\n\
+	ldq $23,48($17)						\n\
+	ldq $24,48($18)						\n\
+	ldq $25,56($17)						\n\
+	xor $0,$1,$0		# 7 cycles from $1 load		\n\
+								\n\
+	ldq $27,56($18)						\n\
+	xor $2,$3,$2						\n\
+	stq $0,0($17)						\n\
+	xor $4,$5,$4						\n\
+								\n\
+	stq $2,8($17)						\n\
+	xor $6,$7,$6						\n\
+	stq $4,16($17)						\n\
+	xor $19,$20,$19						\n\
+								\n\
+	stq $6,24($17)						\n\
+	xor $21,$22,$21						\n\
+	stq $19,32($17)						\n\
+	xor $23,$24,$23						\n\
+								\n\
+	stq $21,40($17)						\n\
+	xor $25,$27,$25						\n\
+	stq $23,48($17)						\n\
+	subq $16,1,$16						\n\
+								\n\
+	stq $25,56($17)						\n\
+	addq $17,64,$17						\n\
+	addq $18,64,$18						\n\
+	bgt $16,2b						\n\
+								\n\
+	ret							\n\
+	.end xor_alpha_2					\n\
+								\n\
+	.align 3						\n\
+	.ent xor_alpha_3					\n\
+xor_alpha_3:							\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+	.align 4						\n\
+3:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,0($19)						\n\
+	ldq $3,8($17)						\n\
+								\n\
+	ldq $4,8($18)						\n\
+	ldq $6,16($17)						\n\
+	ldq $7,16($18)						\n\
+	ldq $21,24($17)						\n\
+								\n\
+	ldq $22,24($18)						\n\
+	ldq $24,32($17)						\n\
+	ldq $25,32($18)						\n\
+	ldq $5,8($19)						\n\
+								\n\
+	ldq $20,16($19)						\n\
+	ldq $23,24($19)						\n\
+	ldq $27,32($19)						\n\
+	nop							\n\
+								\n\
+	xor $0,$1,$1		# 8 cycles from $0 load		\n\
+	xor $3,$4,$4		# 6 cycles from $4 load		\n\
+	xor $6,$7,$7		# 6 cycles from $7 load		\n\
+	xor $21,$22,$22		# 5 cycles from $22 load	\n\
+								\n\
+	xor $1,$2,$2		# 9 cycles from $2 load		\n\
+	xor $24,$25,$25		# 5 cycles from $25 load	\n\
+	stq $2,0($17)						\n\
+	xor $4,$5,$5		# 6 cycles from $5 load		\n\
+								\n\
+	stq $5,8($17)						\n\
+	xor $7,$20,$20		# 7 cycles from $20 load	\n\
+	stq $20,16($17)						\n\
+	xor $22,$23,$23		# 7 cycles from $23 load	\n\
+								\n\
+	stq $23,24($17)						\n\
+	xor $25,$27,$27		# 7 cycles from $27 load	\n\
+	stq $27,32($17)						\n\
+	nop							\n\
+								\n\
+	ldq $0,40($17)						\n\
+	ldq $1,40($18)						\n\
+	ldq $3,48($17)						\n\
+	ldq $4,48($18)						\n\
+								\n\
+	ldq $6,56($17)						\n\
+	ldq $7,56($18)						\n\
+	ldq $2,40($19)						\n\
+	ldq $5,48($19)						\n\
+								\n\
+	ldq $20,56($19)						\n\
+	xor $0,$1,$1		# 4 cycles from $1 load		\n\
+	xor $3,$4,$4		# 5 cycles from $4 load		\n\
+	xor $6,$7,$7		# 5 cycles from $7 load		\n\
+								\n\
+	xor $1,$2,$2		# 4 cycles from $2 load		\n\
+	xor $4,$5,$5		# 5 cycles from $5 load		\n\
+	stq $2,40($17)						\n\
+	xor $7,$20,$20		# 4 cycles from $20 load	\n\
+								\n\
+	stq $5,48($17)						\n\
+	subq $16,1,$16						\n\
+	stq $20,56($17)						\n\
+	addq $19,64,$19						\n\
+								\n\
+	addq $18,64,$18						\n\
+	addq $17,64,$17						\n\
+	bgt $16,3b						\n\
+	ret							\n\
+	.end xor_alpha_3					\n\
+								\n\
+	.align 3						\n\
+	.ent xor_alpha_4					\n\
+xor_alpha_4:							\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+	.align 4						\n\
+4:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,0($19)						\n\
+	ldq $3,0($20)						\n\
+								\n\
+	ldq $4,8($17)						\n\
+	ldq $5,8($18)						\n\
+	ldq $6,8($19)						\n\
+	ldq $7,8($20)						\n\
+								\n\
+	ldq $21,16($17)						\n\
+	ldq $22,16($18)						\n\
+	ldq $23,16($19)						\n\
+	ldq $24,16($20)						\n\
+								\n\
+	ldq $25,24($17)						\n\
+	xor $0,$1,$1		# 6 cycles from $1 load		\n\
+	ldq $27,24($18)						\n\
+	xor $2,$3,$3		# 6 cycles from $3 load		\n\
+								\n\
+	ldq $0,24($19)						\n\
+	xor $1,$3,$3						\n\
+	ldq $1,24($20)						\n\
+	xor $4,$5,$5		# 7 cycles from $5 load		\n\
+								\n\
+	stq $3,0($17)						\n\
+	xor $6,$7,$7						\n\
+	xor $21,$22,$22		# 7 cycles from $22 load	\n\
+	xor $5,$7,$7						\n\
+								\n\
+	stq $7,8($17)						\n\
+	xor $23,$24,$24		# 7 cycles from $24 load	\n\
+	ldq $2,32($17)						\n\
+	xor $22,$24,$24						\n\
+								\n\
+	ldq $3,32($18)						\n\
+	ldq $4,32($19)						\n\
+	ldq $5,32($20)						\n\
+	xor $25,$27,$27		# 8 cycles from $27 load	\n\
+								\n\
+	ldq $6,40($17)						\n\
+	ldq $7,40($18)						\n\
+	ldq $21,40($19)						\n\
+	ldq $22,40($20)						\n\
+								\n\
+	stq $24,16($17)						\n\
+	xor $0,$1,$1		# 9 cycles from $1 load		\n\
+	xor $2,$3,$3		# 5 cycles from $3 load		\n\
+	xor $27,$1,$1						\n\
+								\n\
+	stq $1,24($17)						\n\
+	xor $4,$5,$5		# 5 cycles from $5 load		\n\
+	ldq $23,48($17)						\n\
+	ldq $24,48($18)						\n\
+								\n\
+	ldq $25,48($19)						\n\
+	xor $3,$5,$5						\n\
+	ldq $27,48($20)						\n\
+	ldq $0,56($17)						\n\
+								\n\
+	ldq $1,56($18)						\n\
+	ldq $2,56($19)						\n\
+	xor $6,$7,$7		# 8 cycles from $6 load		\n\
+	ldq $3,56($20)						\n\
+								\n\
+	stq $5,32($17)						\n\
+	xor $21,$22,$22		# 8 cycles from $22 load	\n\
+	xor $7,$22,$22						\n\
+	xor $23,$24,$24		# 5 cycles from $24 load	\n\
+								\n\
+	stq $22,40($17)						\n\
+	xor $25,$27,$27		# 5 cycles from $27 load	\n\
+	xor $24,$27,$27						\n\
+	xor $0,$1,$1		# 5 cycles from $1 load		\n\
+								\n\
+	stq $27,48($17)						\n\
+	xor $2,$3,$3		# 4 cycles from $3 load		\n\
+	xor $1,$3,$3						\n\
+	subq $16,1,$16						\n\
+								\n\
+	stq $3,56($17)						\n\
+	addq $20,64,$20						\n\
+	addq $19,64,$19						\n\
+	addq $18,64,$18						\n\
+								\n\
+	addq $17,64,$17						\n\
+	bgt $16,4b						\n\
+	ret							\n\
+	.end xor_alpha_4					\n\
+								\n\
+	.align 3						\n\
+	.ent xor_alpha_5					\n\
+xor_alpha_5:							\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+	.align 4						\n\
+5:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,0($19)						\n\
+	ldq $3,0($20)						\n\
+								\n\
+	ldq $4,0($21)						\n\
+	ldq $5,8($17)						\n\
+	ldq $6,8($18)						\n\
+	ldq $7,8($19)						\n\
+								\n\
+	ldq $22,8($20)						\n\
+	ldq $23,8($21)						\n\
+	ldq $24,16($17)						\n\
+	ldq $25,16($18)						\n\
+								\n\
+	ldq $27,16($19)						\n\
+	xor $0,$1,$1		# 6 cycles from $1 load		\n\
+	ldq $28,16($20)						\n\
+	xor $2,$3,$3		# 6 cycles from $3 load		\n\
+								\n\
+	ldq $0,16($21)						\n\
+	xor $1,$3,$3						\n\
+	ldq $1,24($17)						\n\
+	xor $3,$4,$4		# 7 cycles from $4 load		\n\
+								\n\
+	stq $4,0($17)						\n\
+	xor $5,$6,$6		# 7 cycles from $6 load		\n\
+	xor $7,$22,$22		# 7 cycles from $22 load	\n\
+	xor $6,$23,$23		# 7 cycles from $23 load	\n\
+								\n\
+	ldq $2,24($18)						\n\
+	xor $22,$23,$23						\n\
+	ldq $3,24($19)						\n\
+	xor $24,$25,$25		# 8 cycles from $25 load	\n\
+								\n\
+	stq $23,8($17)						\n\
+	xor $25,$27,$27		# 8 cycles from $27 load	\n\
+	ldq $4,24($20)						\n\
+	xor $28,$0,$0		# 7 cycles from $0 load		\n\
+								\n\
+	ldq $5,24($21)						\n\
+	xor $27,$0,$0						\n\
+	ldq $6,32($17)						\n\
+	ldq $7,32($18)						\n\
+								\n\
+	stq $0,16($17)						\n\
+	xor $1,$2,$2		# 6 cycles from $2 load		\n\
+	ldq $22,32($19)						\n\
+	xor $3,$4,$4		# 4 cycles from $4 load		\n\
+								\n\
+	ldq $23,32($20)						\n\
+	xor $2,$4,$4						\n\
+	ldq $24,32($21)						\n\
+	ldq $25,40($17)						\n\
+								\n\
+	ldq $27,40($18)						\n\
+	ldq $28,40($19)						\n\
+	ldq $0,40($20)						\n\
+	xor $4,$5,$5		# 7 cycles from $5 load		\n\
+								\n\
+	stq $5,24($17)						\n\
+	xor $6,$7,$7		# 7 cycles from $7 load		\n\
+	ldq $1,40($21)						\n\
+	ldq $2,48($17)						\n\
+								\n\
+	ldq $3,48($18)						\n\
+	xor $7,$22,$22		# 7 cycles from $22 load	\n\
+	ldq $4,48($19)						\n\
+	xor $23,$24,$24		# 6 cycles from $24 load	\n\
+								\n\
+	ldq $5,48($20)						\n\
+	xor $22,$24,$24						\n\
+	ldq $6,48($21)						\n\
+	xor $25,$27,$27		# 7 cycles from $27 load	\n\
+								\n\
+	stq $24,32($17)						\n\
+	xor $27,$28,$28		# 8 cycles from $28 load	\n\
+	ldq $7,56($17)						\n\
+	xor $0,$1,$1		# 6 cycles from $1 load		\n\
+								\n\
+	ldq $22,56($18)						\n\
+	ldq $23,56($19)						\n\
+	ldq $24,56($20)						\n\
+	ldq $25,56($21)						\n\
+								\n\
+	xor $28,$1,$1						\n\
+	xor $2,$3,$3		# 9 cycles from $3 load		\n\
+	xor $3,$4,$4		# 9 cycles from $4 load		\n\
+	xor $5,$6,$6		# 8 cycles from $6 load		\n\
+								\n\
+	stq $1,40($17)						\n\
+	xor $4,$6,$6						\n\
+	xor $7,$22,$22		# 7 cycles from $22 load	\n\
+	xor $23,$24,$24		# 6 cycles from $24 load	\n\
+								\n\
+	stq $6,48($17)						\n\
+	xor $22,$24,$24						\n\
+	subq $16,1,$16						\n\
+	xor $24,$25,$25		# 8 cycles from $25 load	\n\
+								\n\
+	stq $25,56($17)						\n\
+	addq $21,64,$21						\n\
+	addq $20,64,$20						\n\
+	addq $19,64,$19						\n\
+								\n\
+	addq $18,64,$18						\n\
+	addq $17,64,$17						\n\
+	bgt $16,5b						\n\
+	ret							\n\
+	.end xor_alpha_5					\n\
+								\n\
+	.align 3						\n\
+	.ent xor_alpha_prefetch_2				\n\
+xor_alpha_prefetch_2:						\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+								\n\
+	ldq $31, 0($17)						\n\
+	ldq $31, 0($18)						\n\
+								\n\
+	ldq $31, 64($17)					\n\
+	ldq $31, 64($18)					\n\
+								\n\
+	ldq $31, 128($17)					\n\
+	ldq $31, 128($18)					\n\
+								\n\
+	ldq $31, 192($17)					\n\
+	ldq $31, 192($18)					\n\
+	.align 4						\n\
+2:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,8($17)						\n\
+	ldq $3,8($18)						\n\
+								\n\
+	ldq $4,16($17)						\n\
+	ldq $5,16($18)						\n\
+	ldq $6,24($17)						\n\
+	ldq $7,24($18)						\n\
+								\n\
+	ldq $19,32($17)						\n\
+	ldq $20,32($18)						\n\
+	ldq $21,40($17)						\n\
+	ldq $22,40($18)						\n\
+								\n\
+	ldq $23,48($17)						\n\
+	ldq $24,48($18)						\n\
+	ldq $25,56($17)						\n\
+	ldq $27,56($18)						\n\
+								\n\
+	ldq $31,256($17)					\n\
+	xor $0,$1,$0		# 8 cycles from $1 load		\n\
+	ldq $31,256($18)					\n\
+	xor $2,$3,$2						\n\
+								\n\
+	stq $0,0($17)						\n\
+	xor $4,$5,$4						\n\
+	stq $2,8($17)						\n\
+	xor $6,$7,$6						\n\
+								\n\
+	stq $4,16($17)						\n\
+	xor $19,$20,$19						\n\
+	stq $6,24($17)						\n\
+	xor $21,$22,$21						\n\
+								\n\
+	stq $19,32($17)						\n\
+	xor $23,$24,$23						\n\
+	stq $21,40($17)						\n\
+	xor $25,$27,$25						\n\
+								\n\
+	stq $23,48($17)						\n\
+	subq $16,1,$16						\n\
+	stq $25,56($17)						\n\
+	addq $17,64,$17						\n\
+								\n\
+	addq $18,64,$18						\n\
+	bgt $16,2b						\n\
+	ret							\n\
+	.end xor_alpha_prefetch_2				\n\
+								\n\
+	.align 3						\n\
+	.ent xor_alpha_prefetch_3				\n\
+xor_alpha_prefetch_3:						\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+								\n\
+	ldq $31, 0($17)						\n\
+	ldq $31, 0($18)						\n\
+	ldq $31, 0($19)						\n\
+								\n\
+	ldq $31, 64($17)					\n\
+	ldq $31, 64($18)					\n\
+	ldq $31, 64($19)					\n\
+								\n\
+	ldq $31, 128($17)					\n\
+	ldq $31, 128($18)					\n\
+	ldq $31, 128($19)					\n\
+								\n\
+	ldq $31, 192($17)					\n\
+	ldq $31, 192($18)					\n\
+	ldq $31, 192($19)					\n\
+	.align 4						\n\
+3:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,0($19)						\n\
+	ldq $3,8($17)						\n\
+								\n\
+	ldq $4,8($18)						\n\
+	ldq $6,16($17)						\n\
+	ldq $7,16($18)						\n\
+	ldq $21,24($17)						\n\
+								\n\
+	ldq $22,24($18)						\n\
+	ldq $24,32($17)						\n\
+	ldq $25,32($18)						\n\
+	ldq $5,8($19)						\n\
+								\n\
+	ldq $20,16($19)						\n\
+	ldq $23,24($19)						\n\
+	ldq $27,32($19)						\n\
+	nop							\n\
+								\n\
+	xor $0,$1,$1		# 8 cycles from $0 load		\n\
+	xor $3,$4,$4		# 7 cycles from $4 load		\n\
+	xor $6,$7,$7		# 6 cycles from $7 load		\n\
+	xor $21,$22,$22		# 5 cycles from $22 load	\n\
+								\n\
+	xor $1,$2,$2		# 9 cycles from $2 load		\n\
+	xor $24,$25,$25		# 5 cycles from $25 load	\n\
+	stq $2,0($17)						\n\
+	xor $4,$5,$5		# 6 cycles from $5 load		\n\
+								\n\
+	stq $5,8($17)						\n\
+	xor $7,$20,$20		# 7 cycles from $20 load	\n\
+	stq $20,16($17)						\n\
+	xor $22,$23,$23		# 7 cycles from $23 load	\n\
+								\n\
+	stq $23,24($17)						\n\
+	xor $25,$27,$27		# 7 cycles from $27 load	\n\
+	stq $27,32($17)						\n\
+	nop							\n\
+								\n\
+	ldq $0,40($17)						\n\
+	ldq $1,40($18)						\n\
+	ldq $3,48($17)						\n\
+	ldq $4,48($18)						\n\
+								\n\
+	ldq $6,56($17)						\n\
+	ldq $7,56($18)						\n\
+	ldq $2,40($19)						\n\
+	ldq $5,48($19)						\n\
+								\n\
+	ldq $20,56($19)						\n\
+	ldq $31,256($17)					\n\
+	ldq $31,256($18)					\n\
+	ldq $31,256($19)					\n\
+								\n\
+	xor $0,$1,$1		# 6 cycles from $1 load		\n\
+	xor $3,$4,$4		# 5 cycles from $4 load		\n\
+	xor $6,$7,$7		# 5 cycles from $7 load		\n\
+	xor $1,$2,$2		# 4 cycles from $2 load		\n\
+								\n\
+	xor $4,$5,$5		# 5 cycles from $5 load		\n\
+	xor $7,$20,$20		# 4 cycles from $20 load	\n\
+	stq $2,40($17)						\n\
+	subq $16,1,$16						\n\
+								\n\
+	stq $5,48($17)						\n\
+	addq $19,64,$19						\n\
+	stq $20,56($17)						\n\
+	addq $18,64,$18						\n\
+								\n\
+	addq $17,64,$17						\n\
+	bgt $16,3b						\n\
+	ret							\n\
+	.end xor_alpha_prefetch_3				\n\
+								\n\
+	.align 3						\n\
+	.ent xor_alpha_prefetch_4				\n\
+xor_alpha_prefetch_4:						\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+								\n\
+	ldq $31, 0($17)						\n\
+	ldq $31, 0($18)						\n\
+	ldq $31, 0($19)						\n\
+	ldq $31, 0($20)						\n\
+								\n\
+	ldq $31, 64($17)					\n\
+	ldq $31, 64($18)					\n\
+	ldq $31, 64($19)					\n\
+	ldq $31, 64($20)					\n\
+								\n\
+	ldq $31, 128($17)					\n\
+	ldq $31, 128($18)					\n\
+	ldq $31, 128($19)					\n\
+	ldq $31, 128($20)					\n\
+								\n\
+	ldq $31, 192($17)					\n\
+	ldq $31, 192($18)					\n\
+	ldq $31, 192($19)					\n\
+	ldq $31, 192($20)					\n\
+	.align 4						\n\
+4:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,0($19)						\n\
+	ldq $3,0($20)						\n\
+								\n\
+	ldq $4,8($17)						\n\
+	ldq $5,8($18)						\n\
+	ldq $6,8($19)						\n\
+	ldq $7,8($20)						\n\
+								\n\
+	ldq $21,16($17)						\n\
+	ldq $22,16($18)						\n\
+	ldq $23,16($19)						\n\
+	ldq $24,16($20)						\n\
+								\n\
+	ldq $25,24($17)						\n\
+	xor $0,$1,$1		# 6 cycles from $1 load		\n\
+	ldq $27,24($18)						\n\
+	xor $2,$3,$3		# 6 cycles from $3 load		\n\
+								\n\
+	ldq $0,24($19)						\n\
+	xor $1,$3,$3						\n\
+	ldq $1,24($20)						\n\
+	xor $4,$5,$5		# 7 cycles from $5 load		\n\
+								\n\
+	stq $3,0($17)						\n\
+	xor $6,$7,$7						\n\
+	xor $21,$22,$22		# 7 cycles from $22 load	\n\
+	xor $5,$7,$7						\n\
+								\n\
+	stq $7,8($17)						\n\
+	xor $23,$24,$24		# 7 cycles from $24 load	\n\
+	ldq $2,32($17)						\n\
+	xor $22,$24,$24						\n\
+								\n\
+	ldq $3,32($18)						\n\
+	ldq $4,32($19)						\n\
+	ldq $5,32($20)						\n\
+	xor $25,$27,$27		# 8 cycles from $27 load	\n\
+								\n\
+	ldq $6,40($17)						\n\
+	ldq $7,40($18)						\n\
+	ldq $21,40($19)						\n\
+	ldq $22,40($20)						\n\
+								\n\
+	stq $24,16($17)						\n\
+	xor $0,$1,$1		# 9 cycles from $1 load		\n\
+	xor $2,$3,$3		# 5 cycles from $3 load		\n\
+	xor $27,$1,$1						\n\
+								\n\
+	stq $1,24($17)						\n\
+	xor $4,$5,$5		# 5 cycles from $5 load		\n\
+	ldq $23,48($17)						\n\
+	xor $3,$5,$5						\n\
+								\n\
+	ldq $24,48($18)						\n\
+	ldq $25,48($19)						\n\
+	ldq $27,48($20)						\n\
+	ldq $0,56($17)						\n\
+								\n\
+	ldq $1,56($18)						\n\
+	ldq $2,56($19)						\n\
+	ldq $3,56($20)						\n\
+	xor $6,$7,$7		# 8 cycles from $6 load		\n\
+								\n\
+	ldq $31,256($17)					\n\
+	xor $21,$22,$22		# 8 cycles from $22 load	\n\
+	ldq $31,256($18)					\n\
+	xor $7,$22,$22						\n\
+								\n\
+	ldq $31,256($19)					\n\
+	xor $23,$24,$24		# 6 cycles from $24 load	\n\
+	ldq $31,256($20)					\n\
+	xor $25,$27,$27		# 6 cycles from $27 load	\n\
+								\n\
+	stq $5,32($17)						\n\
+	xor $24,$27,$27						\n\
+	xor $0,$1,$1		# 7 cycles from $1 load		\n\
+	xor $2,$3,$3		# 6 cycles from $3 load		\n\
+								\n\
+	stq $22,40($17)						\n\
+	xor $1,$3,$3						\n\
+	stq $27,48($17)						\n\
+	subq $16,1,$16						\n\
+								\n\
+	stq $3,56($17)						\n\
+	addq $20,64,$20						\n\
+	addq $19,64,$19						\n\
+	addq $18,64,$18						\n\
+								\n\
+	addq $17,64,$17						\n\
+	bgt $16,4b						\n\
+	ret							\n\
+	.end xor_alpha_prefetch_4				\n\
+								\n\
+	.align 3						\n\
+	.ent xor_alpha_prefetch_5				\n\
+xor_alpha_prefetch_5:						\n\
+	.prologue 0						\n\
+	srl $16, 6, $16						\n\
+								\n\
+	ldq $31, 0($17)						\n\
+	ldq $31, 0($18)						\n\
+	ldq $31, 0($19)						\n\
+	ldq $31, 0($20)						\n\
+	ldq $31, 0($21)						\n\
+								\n\
+	ldq $31, 64($17)					\n\
+	ldq $31, 64($18)					\n\
+	ldq $31, 64($19)					\n\
+	ldq $31, 64($20)					\n\
+	ldq $31, 64($21)					\n\
+								\n\
+	ldq $31, 128($17)					\n\
+	ldq $31, 128($18)					\n\
+	ldq $31, 128($19)					\n\
+	ldq $31, 128($20)					\n\
+	ldq $31, 128($21)					\n\
+								\n\
+	ldq $31, 192($17)					\n\
+	ldq $31, 192($18)					\n\
+	ldq $31, 192($19)					\n\
+	ldq $31, 192($20)					\n\
+	ldq $31, 192($21)					\n\
+	.align 4						\n\
+5:								\n\
+	ldq $0,0($17)						\n\
+	ldq $1,0($18)						\n\
+	ldq $2,0($19)						\n\
+	ldq $3,0($20)						\n\
+								\n\
+	ldq $4,0($21)						\n\
+	ldq $5,8($17)						\n\
+	ldq $6,8($18)						\n\
+	ldq $7,8($19)						\n\
+								\n\
+	ldq $22,8($20)						\n\
+	ldq $23,8($21)						\n\
+	ldq $24,16($17)						\n\
+	ldq $25,16($18)						\n\
+								\n\
+	ldq $27,16($19)						\n\
+	xor $0,$1,$1		# 6 cycles from $1 load		\n\
+	ldq $28,16($20)						\n\
+	xor $2,$3,$3		# 6 cycles from $3 load		\n\
+								\n\
+	ldq $0,16($21)						\n\
+	xor $1,$3,$3						\n\
+	ldq $1,24($17)						\n\
+	xor $3,$4,$4		# 7 cycles from $4 load		\n\
+								\n\
+	stq $4,0($17)						\n\
+	xor $5,$6,$6		# 7 cycles from $6 load		\n\
+	xor $7,$22,$22		# 7 cycles from $22 load	\n\
+	xor $6,$23,$23		# 7 cycles from $23 load	\n\
+								\n\
+	ldq $2,24($18)						\n\
+	xor $22,$23,$23						\n\
+	ldq $3,24($19)						\n\
+	xor $24,$25,$25		# 8 cycles from $25 load	\n\
+								\n\
+	stq $23,8($17)						\n\
+	xor $25,$27,$27		# 8 cycles from $27 load	\n\
+	ldq $4,24($20)						\n\
+	xor $28,$0,$0		# 7 cycles from $0 load		\n\
+								\n\
+	ldq $5,24($21)						\n\
+	xor $27,$0,$0						\n\
+	ldq $6,32($17)						\n\
+	ldq $7,32($18)						\n\
+								\n\
+	stq $0,16($17)						\n\
+	xor $1,$2,$2		# 6 cycles from $2 load		\n\
+	ldq $22,32($19)						\n\
+	xor $3,$4,$4		# 4 cycles from $4 load		\n\
+								\n\
+	ldq $23,32($20)						\n\
+	xor $2,$4,$4						\n\
+	ldq $24,32($21)						\n\
+	ldq $25,40($17)						\n\
+								\n\
+	ldq $27,40($18)						\n\
+	ldq $28,40($19)						\n\
+	ldq $0,40($20)						\n\
+	xor $4,$5,$5		# 7 cycles from $5 load		\n\
+								\n\
+	stq $5,24($17)						\n\
+	xor $6,$7,$7		# 7 cycles from $7 load		\n\
+	ldq $1,40($21)						\n\
+	ldq $2,48($17)						\n\
+								\n\
+	ldq $3,48($18)						\n\
+	xor $7,$22,$22		# 7 cycles from $22 load	\n\
+	ldq $4,48($19)						\n\
+	xor $23,$24,$24		# 6 cycles from $24 load	\n\
+								\n\
+	ldq $5,48($20)						\n\
+	xor $22,$24,$24						\n\
+	ldq $6,48($21)						\n\
+	xor $25,$27,$27		# 7 cycles from $27 load	\n\
+								\n\
+	stq $24,32($17)						\n\
+	xor $27,$28,$28		# 8 cycles from $28 load	\n\
+	ldq $7,56($17)						\n\
+	xor $0,$1,$1		# 6 cycles from $1 load		\n\
+								\n\
+	ldq $22,56($18)						\n\
+	ldq $23,56($19)						\n\
+	ldq $24,56($20)						\n\
+	ldq $25,56($21)						\n\
+								\n\
+	ldq $31,256($17)					\n\
+	xor $28,$1,$1						\n\
+	ldq $31,256($18)					\n\
+	xor $2,$3,$3		# 9 cycles from $3 load		\n\
+								\n\
+	ldq $31,256($19)					\n\
+	xor $3,$4,$4		# 9 cycles from $4 load		\n\
+	ldq $31,256($20)					\n\
+	xor $5,$6,$6		# 8 cycles from $6 load		\n\
+								\n\
+	stq $1,40($17)						\n\
+	xor $4,$6,$6						\n\
+	xor $7,$22,$22		# 7 cycles from $22 load	\n\
+	xor $23,$24,$24		# 6 cycles from $24 load	\n\
+								\n\
+	stq $6,48($17)						\n\
+	xor $22,$24,$24						\n\
+	ldq $31,256($21)					\n\
+	xor $24,$25,$25		# 8 cycles from $25 load	\n\
+								\n\
+	stq $25,56($17)						\n\
+	subq $16,1,$16						\n\
+	addq $21,64,$21						\n\
+	addq $20,64,$20						\n\
+								\n\
+	addq $19,64,$19						\n\
+	addq $18,64,$18						\n\
+	addq $17,64,$17						\n\
+	bgt $16,5b						\n\
+								\n\
+	ret							\n\
+	.end xor_alpha_prefetch_5				\n\
+");
+
+struct xor_block_template xor_block_alpha = {
+	.name	= "alpha",
+	.do_2	= xor_alpha_2,
+	.do_3	= xor_alpha_3,
+	.do_4	= xor_alpha_4,
+	.do_5	= xor_alpha_5,
+};
+
+struct xor_block_template xor_block_alpha_prefetch = {
+	.name	= "alpha prefetch",
+	.do_2	= xor_alpha_prefetch_2,
+	.do_3	= xor_alpha_prefetch_3,
+	.do_4	= xor_alpha_prefetch_4,
+	.do_5	= xor_alpha_prefetch_5,
+};
-- 
2.47.3


