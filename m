Return-Path: <linux-btrfs+bounces-22094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB29E3tvomlq3AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22094-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 05:30:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCC1C0485
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 05:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81E5330768C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 04:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A8362130;
	Sat, 28 Feb 2026 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyh0YCjc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0D33C502;
	Sat, 28 Feb 2026 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772253010; cv=none; b=m462VCxZ+e2KTSGfN4uWd5rp1nzv6rEFl8wKVbwJFtRDJFRUDYetZiS7PB3waZSQdpLeRVvkbJEyJS+lUuqrrP+udfvt+qRd6whJXV0qq0QvurFIpB06aHxc+vamsiHeQbnItIinCXJBWQVqGwRaBrtvTQd7hPhHWRukJcj8ZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772253010; c=relaxed/simple;
	bh=NxIyVYtgLysk+spkHOyEoka9HT1s3BaoNbqWwqQmPXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUvS67CHw80Mks59p1LuE/sx/g2hqWl4+f9JjCWSRaD0v6Wp9z/DKnKG0n6SQwCe3gu+uZymT4yM1GIxLPPDaZ0cPRXjKUOL9gdctunNNIec/fgxGLRckRXEI4xVd9/m30MRd2wYNRcuOGt3rEJvTPIhCL6KXO154j0dHWXiUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyh0YCjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B3C116D0;
	Sat, 28 Feb 2026 04:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253010;
	bh=NxIyVYtgLysk+spkHOyEoka9HT1s3BaoNbqWwqQmPXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fyh0YCjcPmsVmzz5h+F1Yy8gWejjphUUrGeKnqhIxGQ+qjYtEztmeP1kaQL7ddsRN
	 jdkA6zr3qARSLzOxvszanCJtbGe6MxgPdM+Z6+dhb7aZQXTNmMRzbGAktPG2fY5fUl
	 TBJYgxI6xb9qhwF67ngcAYU9OKtc/uqzcX+3yEYAKMVGlX0rGBTQLNzUCfh3Qw8tog
	 0VEAgqbQJ3xpTSjCyP3w5YgI628hkJaD1By1DZb0TabsJZRA6BOO4+elbK3T8jYutF
	 xqGj5SaKcx64Foh0YOFWYjXkw2x5ciOjaB0TEjg5I3513gVMPITkGZ7CF1NbrQ8JTi
	 72nJ1I+TSmVTQ==
Date: Fri, 27 Feb 2026 20:30:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
Message-ID: <20260228043006.GA65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-4-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22094-lists,linux-btrfs=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECBCC1C0485
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:10:15AM -0800, Christoph Hellwig wrote:
> XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all the
> ifdef'ery doesn't do anything.  With our without this, the time travel
> mode should work fine on CPUs that support AVX2, as the AVX2
> implementation is forced in this case, and won't work otherwise.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/um/include/asm/xor.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
> index 647fae200c5d..c9ddedc19301 100644
> --- a/arch/um/include/asm/xor.h
> +++ b/arch/um/include/asm/xor.h
> @@ -4,21 +4,11 @@
>  
>  #ifdef CONFIG_64BIT
>  #undef CONFIG_X86_32
> -#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_sse_pf64))
>  #else
>  #define CONFIG_X86_32 1
> -#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_8regs))
>  #endif
>  
>  #include <asm/cpufeature.h>
>  #include <../../x86/include/asm/xor.h>
> -#include <linux/time-internal.h>
> -
> -#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
> -#undef XOR_SELECT_TEMPLATE
> -/* pick an arbitrary one - measuring isn't possible with inf-cpu */
> -#define XOR_SELECT_TEMPLATE(x)	\
> -	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x)
> -#endif

I'm not following this change.  Previously, in TT_MODE_INFCPU mode,
XOR_SELECT_TEMPLATE(NULL) returned &xor_block_avx, &xor_block_sse_pf64,
or &xor_block_8regs, causing the benchmark to be skipped.  After this
change, the benchmark starts being done on CPUs that don't support AVX.

- Eric

