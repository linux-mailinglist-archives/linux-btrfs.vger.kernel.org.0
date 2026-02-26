Return-Path: <linux-btrfs+bounces-21987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EvLFstkoGnrjAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21987-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:20:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 109911A881D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CF41316115E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823973EFD3F;
	Thu, 26 Feb 2026 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XHbUM+ZF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C973EF0A0;
	Thu, 26 Feb 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118702; cv=none; b=ocxmZdDrLf25trCxnmUgrb8EDPDlwLjOsiG62gAQWTGqwH8uwN+Jw+Yz7qp4gw4ndGwMPtxhuxGFSR2/0pv75Enx8Z36FSpfIF7pHRFTMVq+m5ttw1qasICJQ5Ri9kCfgt6466QME1u6CKIDrwiJDWnPnktYUx/0qrKKATx/mJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118702; c=relaxed/simple;
	bh=ucRKHPDE/xcnhmxgvd/baT2POj8Ub38LL1UlGOSqF2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUEQQhLQ2fNk4U7gD024fJ8Q3QOxNjaHicqgVAlbi03LU+T6UfnAM9JMvKkT5hXTjLpFtgIXT+9vZZwDObO/Jfi+6Crkggx1KupWuxSnQ8+dA/7dv/9xJ+lB8ASh3WcRwSyOX/4FGKhWDbUV6yR0rkuCagh8Q0hE5aBU4bHc3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XHbUM+ZF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FL7hvoLUY2bMRMbRRlVqvQioL9cWbtICIXJOfzPCsUY=; b=XHbUM+ZF+eSP9evvU2lA+aZ1n3
	oz9Ng/VTFMX+nIIw8M9JfeIbbm/2EAGZ1foNiPO3rtUPgy84qdU4C7ALpzMghcKlS95XJhtfKcObZ
	eeFwy3AFprG1+qG+QK0PIBGjEfeem7EvlPDk+zHeUhI1+7EF0IPebPg2GYmD4xerBWnUrLcAkdu9H
	/h8OSjql+qMzW8g+6thcycmaSQfviqz2Ri8qZHzFsfQF7sQw3TwibkFR1SzYW2fXgx/ilethOTI1A
	/G3wb0GF3L+x3N/Jf8Cpz/jE8ElaXqGDVufZG4psAPNN2O6qnihnpFs5RGBiEcy7ODOCl5qyYgr1y
	8l7lootg==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1B-00000006Pxy-2BGc;
	Thu, 26 Feb 2026 15:11:09 +0000
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
Subject: [PATCH 01/25] xor: assert that xor_blocks is not called from interrupt context
Date: Thu, 26 Feb 2026 07:10:13 -0800
Message-ID: <20260226151106.144735-2-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-21987-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 109911A881D
X-Rspamd-Action: no action

Most of the optimized xor_blocks versions require FPU/vector registers,
which generally are not supported in interrupt context.

Both callers already are in user context, so enforce this at the highest
level.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/xor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/xor.c b/crypto/xor.c
index f39621a57bb3..864f3604e867 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -28,6 +28,8 @@ xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
 {
 	unsigned long *p1, *p2, *p3, *p4;
 
+	WARN_ON_ONCE(in_interrupt());
+
 	p1 = (unsigned long *) srcs[0];
 	if (src_count == 1) {
 		active_template->do_2(bytes, dest, p1);
-- 
2.47.3


