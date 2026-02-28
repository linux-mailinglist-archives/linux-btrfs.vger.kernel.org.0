Return-Path: <linux-btrfs+bounces-22104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOw3JSeSommX4AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22104-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:58:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8501C0B35
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CF13089577
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76433F363;
	Sat, 28 Feb 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZJvSmvp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7DA932;
	Sat, 28 Feb 2026 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261894; cv=none; b=fFH3olv2N9orNWYzKHereaaZHaznXrpzlsoGNtkHv9M6pdQ6QaOPMlbaCAG3arjiXxT6/ts1DFpMHod/iuhFXjBCrdEWCT5TG89vrQ0/kNjpfHk8Ol1bLKw4UGITn28OZp41jR+zsmS8qV2jAIVrLf8h2UhLDoFazo9DddN7Ho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261894; c=relaxed/simple;
	bh=OZ08akKAa75pF5HX8BdM2b9T1B4d2lEE9VTD0Yyikqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvzG8AK3Ks2LQjdu3FkuSDT55SpdbEr9et6MFKLiSEyP2CeJtxVUdNY/lmPoYIf1Sy1Gs6ML7Pn0Ux8vtGlKVduMjtk37fzDANMZW/sRmFPpMblMdb4YNxIrhRF85Qm/p112ui3YTvIESQgSnB7+TjCzW2TSLWzhUAUgd+nw3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZJvSmvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B51C116D0;
	Sat, 28 Feb 2026 06:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772261893;
	bh=OZ08akKAa75pF5HX8BdM2b9T1B4d2lEE9VTD0Yyikqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZJvSmvpEC6sHP/zivxpALj3tLGejpdvAPR0eMYRI+scB+s1IF4OeEtX5WKMQOtse
	 Y2O4u4bOc8GI/JkEy6r4u1efjOMWWhLBmlfPczD6cmniYI2bymYIkCjhEhIGubJ4gY
	 U9xKn5Z26jVbpiN+tbnYvysYm7bGRQ8U3XJJKW5Mpnhlp7/c6eic5HbKU4NYZzTh4Y
	 eWJy6kT6Z+zFjYDjttC40gAqyP1FxjjNb1CXpDAIZpiSYLp4Vl3s7MEe9JtyMARKCq
	 OsKaO4PPgfcbgTDw33LPxpOolodGKsdhIykRymhYri+JeNTEZUGQdgg0r4NRhV+/z9
	 uLwVU5xseRMgQ==
Date: Fri, 27 Feb 2026 22:58:10 -0800
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
Subject: Re: [PATCH 24/25] xor: pass the entire operation to the low-level ops
Message-ID: <20260228065810.GJ65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-25-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-25-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22104-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F8501C0B35
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:10:36AM -0800, Christoph Hellwig wrote:
> +#define __DO_XOR_BLOCKS(_name, _handle1, _handle2, _handle3, _handle4)	\
> +void								\
> +xor_gen_##_name(void *dest, void **srcs, unsigned int src_cnt,		\
> +		unsigned int bytes)					\
> +{									\
> +	unsigned int src_off = 0;					\
> +									\
> +	while (src_cnt > 0) {						\
> +		unsigned int this_cnt = min(src_cnt, 4);		\
> +		unsigned long *p1 = (unsigned long *)srcs[src_off];	\
> +		unsigned long *p2 = (unsigned long *)srcs[src_off + 1];	\
> +		unsigned long *p3 = (unsigned long *)srcs[src_off + 2];	\
> +		unsigned long *p4 = (unsigned long *)srcs[src_off + 3];	\

This reads out of bounds if src_cnt isn't a multiple of 4.

- Eric

