Return-Path: <linux-btrfs+bounces-22101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDjjBJGOomk04AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22101-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:43:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A932F1C09CB
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A7C7308CBDF
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D60346FB0;
	Sat, 28 Feb 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YClOM9Wk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43A22157B;
	Sat, 28 Feb 2026 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772260973; cv=none; b=DD0BsBK/X7ndaBvHidKZBvhs28v6clIjCGFw4qKlw6oAZEkrqCfR2NO3isNrj11c0pvbLJuHWzZnFtEr1SjrjXgob0e35EHTh/ZGJXje4pDjdYYyJ9lvN8JTV5hrwCc/R7V6PGn4/x2wE8j4JUbUjcB0RAMt04jJG1ETYcSQHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772260973; c=relaxed/simple;
	bh=RjXh+3ODcjpkGCclxlZLerhUTxAgrS3+Qw6tdSUsizg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuOxS9guKFDIlOM8yfkdMCyosDarWSmBWAw43uxnCVGJsA59jOGTpbafM/SSfBhyVhUs5/x67/KrKCaj0RVILGRsZUflscWcwliWdUg8Ymvj+N3YNFlqO2HwicRik5iCO2bGT0M1gBspmBXLGRt/Q/4cVL6ML9GaCPoCbGrNTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YClOM9Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FCCC116D0;
	Sat, 28 Feb 2026 06:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772260973;
	bh=RjXh+3ODcjpkGCclxlZLerhUTxAgrS3+Qw6tdSUsizg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YClOM9Wk3/7+pE7QyV7s9mlYuDllppl2YGLrTn0xkJ5pU3h4NtzzqxpXAgzhRI9N2
	 JuGJGprSvbiCiYCR4+DPFVLVUesA+9zY/ql1wKLu6GOJbDRJOE72dBApORguyRvSk0
	 Ip+z80iLf2XB3ZIQqPYK3ZEA4iixYi0/FOhgYq24wKd6cZqPgSNMaeZpzPpmIg/H3w
	 0n7sJMgccYUbEkKSe7BVVGr7K1ToaaAdi9JBbH+YWUnyRyLa4C5j5ZLWu0XZjJO8MA
	 f7GJPwidtEPGlIQhpocckRINXMDZxErl0fKAfQbViWFT5IVTuMqtgP4lHaU8x4cpN/
	 +BKrl6+TlJfNA==
Date: Fri, 27 Feb 2026 22:42:49 -0800
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
Subject: Re: [PATCH 20/25] xor: make xor.ko self-contained in lib/raid/
Message-ID: <20260228064249.GG65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-21-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-21-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-22101-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A932F1C09CB
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:10:32AM -0800, Christoph Hellwig wrote:
> diff --git a/arch/um/include/asm/xor.h b/lib/raid/xor/um/xor_arch.h
> similarity index 61%
> rename from arch/um/include/asm/xor.h
> rename to lib/raid/xor/um/xor_arch.h
> index c9ddedc19301..c75cd9caf792 100644
> --- a/arch/um/include/asm/xor.h
> +++ b/lib/raid/xor/um/xor_arch.h
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_UM_XOR_H
> -#define _ASM_UM_XOR_H
> -
>  #ifdef CONFIG_64BIT
>  #undef CONFIG_X86_32
>  #else
>  #define CONFIG_X86_32 1
>  #endif

Due to this change, the above code that sets CONFIG_X86_32 to the
opposite of CONFIG_64BIT is no longer included in xor-sse.c, which uses
CONFIG_X86_32.  So if the above code actually did anything, this change
would have broken it for xor-sse.c.  However, based on
arch/x86/um/Kconfig, CONFIG_X86_32 is always the opposite of
CONFIG_64BIT, so the above code actually has no effect.  Does that sound
right?

- Eric

