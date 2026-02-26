Return-Path: <linux-btrfs+bounces-22005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEhSGqxnoGkejQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22005-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:33:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE11A8C4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 743B930F739C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82837421EF7;
	Thu, 26 Feb 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0fQ+ziN2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDA41C316;
	Thu, 26 Feb 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118734; cv=none; b=NctOUrQWv0ROtPynqFwvLtEBlmnXyxB5y5ARlk8ugX/ZSDnk9ineCQSKOPtxWEqW0ydQfeXgW87Jo9YRVOH7sL+BfH23pyYtVKfIGpUy4AQeZlCTFr6VAEUsyhPowezDlrHlGgykH9oSRULD9LM9aKV2DGAEtF+bW9K9ODGpjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118734; c=relaxed/simple;
	bh=u9mukUbtNW9HKp6dIQdhf9GxHzqPPxtyu3rwPxAQDqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRlkojyUKbTci0KVdJwMiGYTz6eGyzL13nV0HFD9o4VYeyE1jZZnyNm1vzuV0eiy2uwIYBZb2AUfJOXfTilDDLNKJn98hYmU11BNgt367CRKGhuGjsps0/aSwNa4Re4Q2bEz9U7YM4opTvqOFzmHfZOS4LIJjAsSCIrbohoXnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0fQ+ziN2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6wXlWATGkI9LtZmZKd6pDj/YsUZIAwbclFsmEmtMkgM=; b=0fQ+ziN29Gl2ARYY0VrJA/aEZQ
	7cG8oZI7alqaImdfkV2UmgKZ/COv6TD5KN1+RK+HU501lQUrsz7jVVQ2gabFIlNkDSsVU4B2igeal
	sSg6xBWvxeWNSjoiJNtsHKA/NEN9vKpt2zUvHZT4o510BZxcycI8EnwwXteY/JcLdEmVYNlvtClbT
	grfd3I00JP7CGRu+OjQDFjtzDfgz2m3n1ZsO6tyw+vJyYyGXxJqb3ueojrT3iE+t8PcqSquW0SB7E
	W33lXSx7ZZDlzJnNi8ogtXu0J3J1e0IXwhgdQMYt1f7rkwP1k2sZxFbju5lKdAk5Y3GosHgSe9mNI
	FJoj/GJw==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1i-00000006Qgq-3lP2;
	Thu, 26 Feb 2026 15:11:42 +0000
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
Subject: [PATCH 21/25] xor: add a better public API
Date: Thu, 26 Feb 2026 07:10:33 -0800
Message-ID: <20260226151106.144735-22-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22005-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 82BE11A8C4E
X-Rspamd-Action: no action

xor_blocks is very annoying to use, because it is limited to 4 + 1
sources / destinations, has an odd argument order and is completely
undocumented.

Lift the code that loops around it from btrfs and async_tx/async_xor into
common code under the name xor_gen and properly document it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/raid/xor.h |  3 +++
 lib/raid/xor/xor-core.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
index 02bda8d99534..4735a4e960f9 100644
--- a/include/linux/raid/xor.h
+++ b/include/linux/raid/xor.h
@@ -7,4 +7,7 @@
 extern void xor_blocks(unsigned int count, unsigned int bytes,
 	void *dest, void **srcs);
 
+void xor_gen(void *dest, void **srcss, unsigned int src_cnt,
+		unsigned int bytes);
+
 #endif /* _XOR_H */
diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index 8dda4055ad09..b7c29ca931ec 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -46,6 +46,34 @@ xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
 }
 EXPORT_SYMBOL(xor_blocks);
 
+/**
+ * xor_gen - generate RAID-style XOR information
+ * @dest:	destination vector
+ * @srcs:	source vectors
+ * @src_cnt:	number of source vectors
+ * @bytes:	length in bytes of each vector
+ *
+ * Performs bit-wise XOR operation into @dest for each of the @src_cnt vectors
+ * in @srcs for a length of @bytes bytes.
+ *
+ * Note: for typical RAID uses, @dest either needs to be zeroed, or filled with
+ * the first disk, which then needs to be removed from @srcs.
+ */
+void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
+{
+	unsigned int src_off = 0;
+
+	while (src_cnt > 0) {
+		unsigned int this_cnt = min(src_cnt, MAX_XOR_BLOCKS);
+
+		xor_blocks(this_cnt, bytes, dest, srcs + src_off);
+
+		src_cnt -= this_cnt;
+		src_off += this_cnt;
+	}
+}
+EXPORT_SYMBOL(xor_gen);
+
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
 static int __initdata xor_forced = false;
-- 
2.47.3


