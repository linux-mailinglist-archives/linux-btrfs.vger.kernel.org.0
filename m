Return-Path: <linux-btrfs+bounces-22183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGrzMZUIp2k7bgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22183-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:13:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57A1F368F
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C54C030F36F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16E495503;
	Tue,  3 Mar 2026 16:06:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF93BA24E;
	Tue,  3 Mar 2026 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553999; cv=none; b=L2yiDhjojtoXMWuFUoXL2k0lRaY1jIfiSROFgNnSUNaubDasAncWiCiyX+qXGIlCyViJVXkJI+9YssSnMpPw4+vS9snfqW1SIfPdlM6Hs83jddT84W2fPEEvb4SYkNuDOA/1WNlij7/R6FrTcVHLUxuX0uUN2/r5evUHcD9cmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553999; c=relaxed/simple;
	bh=/wMqUr1oFFcSH02CIxEVS3SedbzLJllF9I0IKdIbhro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TefRmdxfLf5NdIiR15XEcmPGeZS/vkIPtPU+eoi0dQTcxBlYM6i8Vf73LklRK7GEZwGI/ZFBU4cKXZJCc/tsLBp+vF7+Vrz9FNMspsQqknbH0sFgz/qcL4EDzLofAWf9ceoFjgWz8hQzy/d1hEDCojtNpya1hCsVuNlyjPKcM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B41BF68BFE; Tue,  3 Mar 2026 17:06:34 +0100 (CET)
Date: Tue, 3 Mar 2026 17:06:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
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
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 20/25] xor: make xor.ko self-contained in lib/raid/
Message-ID: <20260303160634.GG7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-21-hch@lst.de> <20260228064249.GG65277@quark>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228064249.GG65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Queue-Id: 5D57A1F368F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22183-lists,linux-btrfs=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,linux-foundation.org,linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:42:49PM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:32AM -0800, Christoph Hellwig wrote:
> > diff --git a/arch/um/include/asm/xor.h b/lib/raid/xor/um/xor_arch.h
> > similarity index 61%
> > rename from arch/um/include/asm/xor.h
> > rename to lib/raid/xor/um/xor_arch.h
> > index c9ddedc19301..c75cd9caf792 100644
> > --- a/arch/um/include/asm/xor.h
> > +++ b/lib/raid/xor/um/xor_arch.h
> > @@ -1,7 +1,4 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _ASM_UM_XOR_H
> > -#define _ASM_UM_XOR_H
> > -
> >  #ifdef CONFIG_64BIT
> >  #undef CONFIG_X86_32
> >  #else
> >  #define CONFIG_X86_32 1
> >  #endif
> 
> Due to this change, the above code that sets CONFIG_X86_32 to the
> opposite of CONFIG_64BIT is no longer included in xor-sse.c, which uses
> CONFIG_X86_32.  So if the above code actually did anything, this change
> would have broken it for xor-sse.c.  However, based on
> arch/x86/um/Kconfig, CONFIG_X86_32 is always the opposite of
> CONFIG_64BIT, so the above code actually has no effect.  Does that sound
> right?

This whole thing looked weird to me.  I'll try to do a more extensive
cleanup pass on the um mess ahead of the rest of the series.


