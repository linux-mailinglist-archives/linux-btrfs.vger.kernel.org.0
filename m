Return-Path: <linux-btrfs+bounces-21985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NgGD05koGnrjAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21985-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:18:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D66801A8733
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D36EC313C438
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4735A3EDADF;
	Thu, 26 Feb 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QR03zetW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D1389E06;
	Thu, 26 Feb 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118700; cv=none; b=qe3jqpA9Ia228fYj4Y1ywe9D/1Se4cUaptYhnSTyxjpyE2Ah7eYDliB24ZEq/CXC2YdpLyIcoBvFhG1ZO4SQYls+f8W56zATYzcW6zBldcYFo0gN5uYBSZRs9DJnkaha4GkKRKjwnndzG9d7Q5qSdqWcab1AFEHXdgXRPkT3RkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118700; c=relaxed/simple;
	bh=TUaqwSYTvclS+sWK53n6TjxnxsuKNTYDMRO6+RyQ5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THeOhadWniRYMByxSKXfbv2VbseEALi5AiKO28v+FaoVyjYoGlqfEvCisZT+2MLqg1gbUlmd4mBV5ZOI9wbC8bres1HO0HLezh5ORNWEb2e45hyTXCU9hQhFXi+ZHuXaWBKHfpZ68el9T/VadPh3/8GY4oU2MQ7dnV1vxMCnDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QR03zetW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qP+8VdwzX18rY5bvgdY1sWuLjPIGZuDXB9vEoLM33a0=; b=QR03zetWTad5XyZ1Gw4pLwB3nJ
	bBW2z8/AfBzf6ywTsDIo41OiCTtpsjYjgepK9QsrzsI7cElVXtM7rURrehCLHg7n3dJp3pEEuguPs
	IV28EsbN9NXPibalVzcYNCMt7WUj5amt2cLL/uhfFZSbZasPO8mE2vPJU0F6TCesV+k682eK7OpEb
	0s0PEhS0Lb4d7H7xxKtb1UPzv/QjIpRm5y7UyO6jsg8yFhe2aE6J9EjqkFmDdqerweEN4NKLgisiM
	Kabaz6sDQQzQIMT6aHsvYmfsxULpzWH25hK5F1NxFrVLPKvob/3mX0qd2TgoR9ypObigmjPl/bDFb
	OUEtcJnA==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1A-00000006Pxh-0z8F;
	Thu, 26 Feb 2026 15:11:08 +0000
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
Subject: cleanup the RAID5 XOR library
Date: Thu, 26 Feb 2026 07:10:12 -0800
Message-ID: <20260226151106.144735-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-21985-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,infradead.org:dkim,lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D66801A8733
X-Rspamd-Action: no action

Hi all,

the XOR library used for the RAID5 parity is a bit of a mess right now.
The main file sits in crypto/ despite not being cryptography and not
using the crypto API, with the generic implementations sitting in
include/asm-generic and the arch implementations sitting in an asm/
header in theory.  The latter doesn't work for many cases, so
architectures often build the code directly into the core kernel, or
create another module for the architecture code.

Changes this to a single module in lib/ that also contains the
architecture optimizations, similar to the library work Eric Biggers
has done for the CRC and crypto libraries later.  After that it changes
to better calling conventions that allow for smarter architecture
implementations (although none is contained here yet), and uses
static_call to avoid indirection function call overhead.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git xor-improvements

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements

Diffstat:
 arch/arm64/include/asm/xor.h              |   73 --
 arch/loongarch/include/asm/xor.h          |   68 --
 arch/loongarch/include/asm/xor_simd.h     |   34 -
 arch/loongarch/lib/xor_simd_glue.c        |   72 --
 arch/powerpc/include/asm/xor.h            |   47 -
 arch/powerpc/include/asm/xor_altivec.h    |   22 
 arch/powerpc/lib/xor_vmx.h                |   22 
 arch/powerpc/lib/xor_vmx_glue.c           |   63 --
 arch/riscv/include/asm/xor.h              |   68 --
 arch/s390/include/asm/xor.h               |   21 
 arch/sparc/include/asm/xor.h              |    9 
 arch/sparc/include/asm/xor_64.h           |   79 ---
 arch/um/include/asm/xor.h                 |   24 
 arch/x86/include/asm/xor_64.h             |   28 -
 b/arch/alpha/Kconfig                      |    1 
 b/arch/arm/Kconfig                        |    1 
 b/arch/arm/lib/Makefile                   |    5 
 b/arch/arm64/Kconfig                      |    1 
 b/arch/arm64/lib/Makefile                 |    6 
 b/arch/loongarch/Kconfig                  |    1 
 b/arch/loongarch/lib/Makefile             |    2 
 b/arch/powerpc/Kconfig                    |    1 
 b/arch/powerpc/lib/Makefile               |    5 
 b/arch/riscv/Kconfig                      |    1 
 b/arch/riscv/lib/Makefile                 |    1 
 b/arch/s390/Kconfig                       |    1 
 b/arch/s390/lib/Makefile                  |    2 
 b/arch/sparc/Kconfig                      |    1 
 b/arch/sparc/include/asm/asm-prototypes.h |    1 
 b/arch/sparc/lib/Makefile                 |    2 
 b/arch/um/Kconfig                         |    1 
 b/arch/x86/Kconfig                        |    1 
 b/crypto/Kconfig                          |    2 
 b/crypto/Makefile                         |    1 
 b/crypto/async_tx/async_xor.c             |   16 
 b/fs/btrfs/raid56.c                       |   27 -
 b/include/asm-generic/Kbuild              |    1 
 b/include/linux/raid/xor.h                |   28 -
 b/lib/Kconfig                             |    1 
 b/lib/Makefile                            |    2 
 b/lib/raid/Kconfig                        |    7 
 b/lib/raid/Makefile                       |    2 
 b/lib/raid/xor/Makefile                   |   50 ++
 b/lib/raid/xor/alpha/xor.c                |   46 -
 b/lib/raid/xor/alpha/xor_arch.h           |   22 
 b/lib/raid/xor/arm/xor-neon-glue.c        |   19 
 b/lib/raid/xor/arm/xor-neon.c             |   22 
 b/lib/raid/xor/arm/xor.c                  |  105 ----
 b/lib/raid/xor/arm/xor_arch.h             |   22 
 b/lib/raid/xor/arm64/xor-neon-glue.c      |   26 +
 b/lib/raid/xor/arm64/xor-neon.c           |   94 +--
 b/lib/raid/xor/arm64/xor-neon.h           |    6 
 b/lib/raid/xor/arm64/xor_arch.h           |   21 
 b/lib/raid/xor/loongarch/xor_arch.h       |   33 +
 b/lib/raid/xor/loongarch/xor_simd_glue.c  |   37 +
 b/lib/raid/xor/powerpc/xor_arch.h         |   22 
 b/lib/raid/xor/powerpc/xor_vmx.c          |   40 -
 b/lib/raid/xor/powerpc/xor_vmx.h          |   10 
 b/lib/raid/xor/powerpc/xor_vmx_glue.c     |   28 +
 b/lib/raid/xor/riscv/xor-glue.c           |   25 +
 b/lib/raid/xor/riscv/xor_arch.h           |   17 
 b/lib/raid/xor/s390/xor.c                 |   15 
 b/lib/raid/xor/s390/xor_arch.h            |   13 
 b/lib/raid/xor/sparc/xor-niagara-glue.c   |   33 +
 b/lib/raid/xor/sparc/xor-niagara.S        |  346 --------------
 b/lib/raid/xor/sparc/xor-sparc32.c        |   32 -
 b/lib/raid/xor/sparc/xor-vis-glue.c       |   34 +
 b/lib/raid/xor/sparc/xor-vis.S            |  348 ++++++++++++++
 b/lib/raid/xor/sparc/xor_arch.h           |   35 +
 b/lib/raid/xor/um/xor_arch.h              |    9 
 b/lib/raid/xor/x86/xor-avx.c              |   52 --
 b/lib/raid/xor/x86/xor-mmx.c              |  120 +---
 b/lib/raid/xor/x86/xor-sse.c              |  105 +---
 b/lib/raid/xor/x86/xor_arch.h             |   36 +
 b/lib/raid/xor/xor-32regs-prefetch.c      |  267 ++++++++++
 b/lib/raid/xor/xor-32regs.c               |  217 ++++++++
 b/lib/raid/xor/xor-8regs-prefetch.c       |  146 +++++
 b/lib/raid/xor/xor-8regs.c                |  103 ++++
 b/lib/raid/xor/xor-core.c                 |  187 +++++++
 b/lib/raid/xor/xor_impl.h                 |   60 ++
 crypto/xor.c                              |  174 -------
 include/asm-generic/xor.h                 |  738 ------------------------------
 82 files changed, 2033 insertions(+), 2433 deletions(-)

