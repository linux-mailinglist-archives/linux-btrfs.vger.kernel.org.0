Return-Path: <linux-btrfs+bounces-22095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IIzL5pwommf3AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22095-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 05:35:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777DB1C04D8
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 05:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3E2C30576CB
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 04:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0B9361660;
	Sat, 28 Feb 2026 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvLMWT5Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3161155326;
	Sat, 28 Feb 2026 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772253327; cv=none; b=ZEvwRuLFawSSqNl52ClS3MzjQ5csyQiRVrzHO7Uz6IPAPIrFnBAjR9by3oP+a1maHE6Pro8Bu5OAjuA21/GQQxzTJl/Mmp4MIU08dtmOxic/AymIRORAMogirB32gqzY0nn1Y55FP6ey6bqPuQn7LXSIugQnBdKYGVvsto7laZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772253327; c=relaxed/simple;
	bh=7zmaVKtAh2Ji/dO9zQKMopZe2cxR3kulm8/sTdUvOcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXsB5Rbtl8PBt3AlmxENqyUrCGXrcl5iE9DLewYkp9RxO5RrWf80NCuM6S1q06Ntc+tpesUqJ04WA+yzAmV7s30pbQNQMkYDl4bQqolTBLxkRtrck0w6/k+54TtKCW2/TE1YOhlzHswSwIV/8S2jCscPioLFLvCgSQ3Ze4m5dwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvLMWT5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FD3C116D0;
	Sat, 28 Feb 2026 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253327;
	bh=7zmaVKtAh2Ji/dO9zQKMopZe2cxR3kulm8/sTdUvOcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvLMWT5QPfWf5fqwCu0b6jyf1JkY8VhTv+hzjbPZJIShl575Kc/hb2XB6K7qkymfN
	 qwBqh029UG4QDt1k4o+yWv6HUuKWpWsplNNhaICJZz2k0ORPmJLnhkHAyONmX7M+TQ
	 zDX6zjqvLirKpTtriXBUSdvtk9Yk8/30R2kYnR4XhUkO0qR3hMOqza11uJQ08QFz4S
	 oQboCK+Z7P0MYthrxKSIcy3roPsAHLbVtIrOmNmHcNMgysOz0VoIhFow1SEkkuFGuP
	 DaFupym5qTt9eY/XGsZgNFTL4RRcp5VoPtcdKHWNHmTzORlfM9TjONCOU+EFM4pkgz
	 p45HIHdqNKblg==
Date: Fri, 27 Feb 2026 20:35:23 -0800
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
Subject: Re: [PATCH 04/25] xor: move to lib/raid/
Message-ID: <20260228043523.GB65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-5-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22095-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 777DB1C04D8
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:10:16AM -0800, Christoph Hellwig wrote:
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0f2fb9610647..5be57adcd454 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -138,6 +138,7 @@ config TRACE_MMIO_ACCESS
>  
>  source "lib/crc/Kconfig"
>  source "lib/crypto/Kconfig"
> +source "lib/raid/Kconfig"

This adds lib/raid/ alongside the existing lib/raid6/ directory.  Is
that the intended final state, or is the intent for the code in
lib/raid6/ to eventually be moved to a subdirectory of lib/raid/
(alongside the "xor" subdirectory)?

> diff --git a/lib/raid/Kconfig b/lib/raid/Kconfig
> new file mode 100644
> index 000000000000..4b720f3454a2
> --- /dev/null
> +++ b/lib/raid/Kconfig
> @@ -0,0 +1,3 @@
> +
> +config XOR_BLOCKS
> +	tristate
> diff --git a/lib/raid/Makefile b/lib/raid/Makefile
> new file mode 100644
> index 000000000000..382f2d1694bd
> --- /dev/null
> +++ b/lib/raid/Makefile
> @@ -0,0 +1,2 @@
> +
> +obj-y				+= xor/

Probably should add an SPDX-License-Identifier to these new files.

- Eric

