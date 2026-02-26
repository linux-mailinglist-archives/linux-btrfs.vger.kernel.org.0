Return-Path: <linux-btrfs+bounces-22007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NoQGcJpoGk3jgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22007-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:41:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D77471A8F82
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AE5631CD464
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16D3F075E;
	Thu, 26 Feb 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LHLrvrFC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0A4218AE;
	Thu, 26 Feb 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118736; cv=none; b=ITiGH/aw8BEBTWIAlOHh1prDipmXaJd6hmLZlHfmX4m2EvVyoqdik13usX/SLBf5QD6FC86obqvRyIqy0WtMDcis1b1Z4WGfJ/TWlfNLmJVL4yIVLqfiAiciai7+paYNEfqBaiCl8esXB4QUFpC9HKbkTQoBxm5J+ht66NNanlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118736; c=relaxed/simple;
	bh=bFIC6Rt1zofGAV+4oWJMxgoyBXil8dFhaIdHOVSkwJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fes7YYscaZ+FrYc3uX30eOREDJW+XV04t5mRSpu5NKR0qQ6bQwUGOlm40GVH6QNILgkfL3/rIb8kVsaKI/klEOA8iDyXGrfWWtNCV4KLSgG7ITVp2zYAwECoQFkPxqrzhHZOrXMFmqRRSL8+NHj/kEZP6XSO7s3pi54tzqXiqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LHLrvrFC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H2vQZ0n6ApADqlHQBkKJl8JvR6Rc+huPC8RGmru6TyA=; b=LHLrvrFCzVjVz5RkC5jDTlCe2x
	d//6CIOE9389jvj/w6NOmURB01PgGNhWOBgmeKiKtSFbMP5rrCAZAr9YEUE2lwPOsXPNgPeeI/M2M
	E0oMEum9H693k56riJecn38wor/KaCckCM3+2h6W82zd1N4KfxStnUM3hMWy66N4Z5SpUeqd9F8Nk
	+a0yxJWzroAv1+3Lo22e73oWhiH3KkNxRkc5phnXBVNzQ92iQZZEOESrgV5lU+oUGU1DDjYNZDVi5
	oGEWno4kHtXiSUN4kVBKc0GxIabdPfhyVfzixmAEwRFHTnPKhTNESQI1UkYRdVnJaK/OfZBve2KV8
	aO3kYOwg==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1m-00000006Qm8-2Nf0;
	Thu, 26 Feb 2026 15:11:46 +0000
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
Subject: [PATCH 23/25] btrfs: use xor_gen
Date: Thu, 26 Feb 2026 07:10:35 -0800
Message-ID: <20260226151106.144735-24-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22007-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: D77471A8F82
X-Rspamd-Action: no action

Use the new xor_gen helper instead of open coding the loop around
xor_blocks.  This helper is very similar to the existing run_xor helper
in btrfs, except that the destination buffer is passed explicitly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b4511f560e92..dab07442f634 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -617,26 +617,6 @@ static void cache_rbio(struct btrfs_raid_bio *rbio)
 	spin_unlock(&table->cache_lock);
 }
 
-/*
- * helper function to run the xor_blocks api.  It is only
- * able to do MAX_XOR_BLOCKS at a time, so we need to
- * loop through.
- */
-static void run_xor(void **pages, int src_cnt, ssize_t len)
-{
-	int src_off = 0;
-	int xor_src_cnt = 0;
-	void *dest = pages[src_cnt];
-
-	while(src_cnt > 0) {
-		xor_src_cnt = min(src_cnt, MAX_XOR_BLOCKS);
-		xor_blocks(xor_src_cnt, len, dest, pages + src_off);
-
-		src_cnt -= xor_src_cnt;
-		src_off += xor_src_cnt;
-	}
-}
-
 /*
  * Returns true if the bio list inside this rbio covers an entire stripe (no
  * rmw required).
@@ -1434,7 +1414,8 @@ static void generate_pq_vertical_step(struct btrfs_raid_bio *rbio, unsigned int
 	} else {
 		/* raid5 */
 		memcpy(pointers[rbio->nr_data], pointers[0], step);
-		run_xor(pointers + 1, rbio->nr_data - 1, step);
+		xor_gen(pointers[rbio->nr_data], pointers + 1, rbio->nr_data - 1,
+				step);
 	}
 	for (stripe = stripe - 1; stripe >= 0; stripe--)
 		kunmap_local(pointers[stripe]);
@@ -2034,7 +2015,7 @@ static void recover_vertical_step(struct btrfs_raid_bio *rbio,
 		pointers[rbio->nr_data - 1] = p;
 
 		/* Xor in the rest */
-		run_xor(pointers, rbio->nr_data - 1, step);
+		xor_gen(p, pointers, rbio->nr_data - 1, step);
 	}
 
 cleanup:
@@ -2664,7 +2645,7 @@ static bool verify_one_parity_step(struct btrfs_raid_bio *rbio,
 	} else {
 		/* RAID5. */
 		memcpy(pointers[nr_data], pointers[0], step);
-		run_xor(pointers + 1, nr_data - 1, step);
+		xor_gen(pointers[nr_data], pointers + 1, nr_data - 1, step);
 	}
 
 	/* Check scrubbing parity and repair it. */
-- 
2.47.3


