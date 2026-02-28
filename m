Return-Path: <linux-btrfs+bounces-22097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PBGG7ByomkA3QQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22097-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 05:44:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174411C059D
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 05:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940DE30789C1
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995C364942;
	Sat, 28 Feb 2026 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuoEPD5d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F62C187;
	Sat, 28 Feb 2026 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772253839; cv=none; b=kzJLqA3IflFybZnFTfFzSjbdSlSjgbnakmVBy13DXYZYSWyD6+vEE8WLyvRCJUMwxUm9oVJVVlk0r9NuP2yACQeIyCXSeSwOM4kyOiZhBCzgwBtVH/Q5K+F/MMJR3nlHFYH9YACy0Uhpujn23jyiS5kiM1f2aToYU4d+Cmk8y2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772253839; c=relaxed/simple;
	bh=yQS8EYr1F4rANaBe7v+3inxmWJU0zVKQEOlUsxymw4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMBaBCEeVKmGiLKX8utILiZkGnDg3M9PnsKS/2BRE0S6KmHUwZvXWpbbRv6Ue4rFJ0trgE+Ohp3L/hXd4VfgS+kl5mv5pFqK8oPGFl83vjXA2XL+RwFUziplSXl5hCZM83xuqsJyQx/uDUqCj1BbK4jVQNKl7sFyvaxG5YmLmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuoEPD5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B7EC116D0;
	Sat, 28 Feb 2026 04:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253838;
	bh=yQS8EYr1F4rANaBe7v+3inxmWJU0zVKQEOlUsxymw4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuoEPD5dGKM2iOhSW+0my0D/f4VLvinBi2jt5Kbxbd81P1k+jWi0+KVciBAPrpL/g
	 r4r2NT2v38o9qtnIhfBxVgmjQSQJywLVObj3muDNlyHJqSESQCTZhmJe/6Rzsk2R9M
	 8ZnzLPFYGLtie7deDR1V8Pnkzre6yCwdaC1qBSQ9wNIL1XaAUgCSzSUwN7lW5l11mD
	 VW2gjQBqijiFVLqfxqw/TTKXHQthqIgVue3hQeJ64rdHrmcizqorwLbqqoBbwNSZH4
	 QorQ2T+BBBGPZMVwQBEeX4nOyWDWoKOqpyMPTJ5mdi+JknVW5oDrCxr9Qb4qEoWrJm
	 UhY0/KMibUBXA==
Date: Fri, 27 Feb 2026 20:43:55 -0800
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
Subject: Re: [PATCH 07/25] xor: split xor.h
Message-ID: <20260228044355.GD65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-8-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-22097-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 174411C059D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:10:19AM -0800, Christoph Hellwig wrote:
> Keep xor.h for the public API, and split the struct xor_block_template
> definition that is only needed by the xor.ko core and
> architecture-specific optimizations into a separate xor_impl.h header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/lib/xor-neon.c       |  1 +
>  arch/s390/lib/xor.c           |  2 +-
>  include/linux/raid/xor.h      | 22 +---------------------
>  include/linux/raid/xor_impl.h | 25 +++++++++++++++++++++++++
>  lib/raid/xor/xor-core.c       |  1 +
>  5 files changed, 29 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/raid/xor_impl.h

arch/arm64/lib/xor-neon.c needs to be updated to include xor_impl.h.

- Eric

