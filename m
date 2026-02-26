Return-Path: <linux-btrfs+bounces-22004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMyoKHpmoGltjQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22004-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:27:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEA41A8B25
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5102930073C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F8423A74;
	Thu, 26 Feb 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vI141pgN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20E41C2EF;
	Thu, 26 Feb 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118730; cv=none; b=aor1k9SJ1kjLnBzxRPQ74qRclQ7Fg4fqWIioVIoG0ETU7AH9Llnui2TAzDCFv3rZwJ5qiHfqjb1jwIJ+WvRM9NeD6C+m5yFb92mf6QThmBLskEysfFXcsE/UWRS3eZswyAQMIhYRTx/hB7EUQXVCWgBVV1tyy6NKhjT2z8sd7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118730; c=relaxed/simple;
	bh=2NKiHY4+RTOzsyvk7dubB1vbqIXW9ibW87L0oYS8JSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0wN0rv6M0+saDOKgMbbew17IlwlWcfZcc0kt9lX1IfT+KbDGroXGMZzjt7BOrdGgTvc+FuZx6CE1YPgnVYH6RtCkVTLwlB3jtLBcq9ZEo6W83Xm2qVb05bmjmpLcZByV30YlV3zHCs1xZtrOYElU25hlxzzI9UiyTr8IzO32FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vI141pgN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9A9Yz8/Cuuvhtyv7lk9AujInuJ9yx6/sygljaE8NTzM=; b=vI141pgNfFpEqWZpBYCgwHWjeg
	N7kZDl9hta7v4qPUhdrGX/BZ7a4ncIqvhYtFKfBETR1Xcwo5DvbLGtIRtEQLbpahXiMa+da7PRgqx
	yx1b9JzOvZckot5AYVcghvmJzRWIZsB8no5NdEczx4Q9sx//cAUhaQmZqG1m1bZKp+mL0uEwHIez+
	AW1zpovXhPwhZvaYaf5tmKVaZMTVIlMYPN3KJ2wTMN3X5SkyfeCM3+e0pxPw95K4KofjMyND1LVK4
	9ZRIvun5OoQ5pKEdRmjN0vlYyFUpK4MinnYw4CuIxeg/sfiWDpk9muIJbg9CfMFW1GE8PcmQN5x+G
	apUYP0BQ==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1k-00000006QjI-3Ujl;
	Thu, 26 Feb 2026 15:11:44 +0000
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
Subject: [PATCH 22/25] async_xor: use xor_gen
Date: Thu, 26 Feb 2026 07:10:34 -0800
Message-ID: <20260226151106.144735-23-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-22004-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CEA41A8B25
X-Rspamd-Action: no action

Replace use of the loop around xor_blocks with the easier to use xor_gen
API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/async_tx/async_xor.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index 2c499654a36c..460960d45388 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -103,7 +103,6 @@ do_sync_xor_offs(struct page *dest, unsigned int offset,
 {
 	int i;
 	int xor_src_cnt = 0;
-	int src_off = 0;
 	void *dest_buf;
 	void **srcs;
 
@@ -117,23 +116,12 @@ do_sync_xor_offs(struct page *dest, unsigned int offset,
 		if (src_list[i])
 			srcs[xor_src_cnt++] = page_address(src_list[i]) +
 				(src_offs ? src_offs[i] : offset);
-	src_cnt = xor_src_cnt;
+
 	/* set destination address */
 	dest_buf = page_address(dest) + offset;
-
 	if (submit->flags & ASYNC_TX_XOR_ZERO_DST)
 		memset(dest_buf, 0, len);
-
-	while (src_cnt > 0) {
-		/* process up to 'MAX_XOR_BLOCKS' sources */
-		xor_src_cnt = min(src_cnt, MAX_XOR_BLOCKS);
-		xor_blocks(xor_src_cnt, len, dest_buf, &srcs[src_off]);
-
-		/* drop completed sources */
-		src_cnt -= xor_src_cnt;
-		src_off += xor_src_cnt;
-	}
-
+	xor_gen(dest_buf, srcs, xor_src_cnt, len);
 	async_tx_sync_epilog(submit);
 }
 
-- 
2.47.3


