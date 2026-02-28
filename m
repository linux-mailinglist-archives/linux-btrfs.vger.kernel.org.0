Return-Path: <linux-btrfs+bounces-22099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDvrKYeBommS3gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22099-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 06:47:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 527321C0770
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 06:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1DCB30AF5A1
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479933BBB4;
	Sat, 28 Feb 2026 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxnCfx5J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF3267B90;
	Sat, 28 Feb 2026 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772257640; cv=none; b=EqLqeUXZnZa8Ynk0kcazSnR3+oyD0L3qOiChSuK+2J6MuqpreTeXnwqcFAc+9tmB97L9C9G/Mpe1Xt2JBLpotcExKREmeYiJnCw0U65hdhnDkF3kjslEJ7FFeVjxEjZqdA/pFAn7Fdfa/zfOQ/7uHr/9pnaGtZIoFJRlAHUaZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772257640; c=relaxed/simple;
	bh=3fhtDiEfYQIsR8xe5v1xLPzjOApnwt1LgQea0fiE/sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3g7YYmSQm9GFVcyALJhpVvc8OvgQCFOp5TFm/wRdqsCmiNRDiYHJhIQDHzghxw1M4SjwYoHlEEWTUZb8ZRYHzjNsvLYDm6hNjLalKnqnBu6mpCJBs1B8oyblF/91fbhSika/eVuBYhHyUHWxPTjJfJY7rWdmH4ffayA/f9yCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxnCfx5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6374C116D0;
	Sat, 28 Feb 2026 05:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772257640;
	bh=3fhtDiEfYQIsR8xe5v1xLPzjOApnwt1LgQea0fiE/sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxnCfx5JDI332Qrr3aqcMLFE+Z8TXsT+uailOd+3AxcXf1coTOZ7vF5OtRVlFz27S
	 I+XE3qJMsOy/NaWilUmpaeuY7J3oz+cG4Um71U6OgQ7NcFA0HIvDDJfrudH5EPWD3S
	 jPn9xscU5HDErluyyxksFTvSuNR6X2vG6RGaNlRTZxMmerYr0sgLOhE7L00/8t5/MJ
	 uNCGKSSPUVI6ufs4uUbVSf5rsbRTL4oD2BooogSyg1zZ0YWLvakCTY7IPYd2SyPwrp
	 50+eB5Q59+IeVeLCa8yNWJbEZz5QSmLw3fDIRjKAzMjZdSuoZa7lO1W7LFFthLj2/W
	 ELDld1Q34kANQ==
Date: Fri, 27 Feb 2026 21:47:16 -0800
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
Subject: Re: [PATCH 16/25] sparc: move the XOR code to lib/raid/
Message-ID: <20260228054716.GF65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-17-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-17-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-22099-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email]
X-Rspamd-Queue-Id: 527321C0770
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:10:28AM -0800, Christoph Hellwig wrote:
> diff --git a/arch/sparc/lib/xor.S b/lib/raid/xor/sparc/xor-niagara.S
> similarity index 53%
> rename from arch/sparc/lib/xor.S
> rename to lib/raid/xor/sparc/xor-niagara.S
> index 35461e3b2a9b..f8749a212eb3 100644
> --- a/arch/sparc/lib/xor.S
> +++ b/lib/raid/xor/sparc/xor-niagara.S
> @@ -1,11 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * arch/sparc64/lib/xor.S
> - *
>   * High speed xor_block operation for RAID4/5 utilizing the
> - * UltraSparc Visual Instruction Set and Niagara store-init/twin-load.
> + * Niagara store-init/twin-load.
>   *
> - * Copyright (C) 1997, 1999 Jakub Jelinek (jj@ultra.linux.cz)
>   * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
>   */
>  
> @@ -16,343 +13,6 @@
>  #include <asm/dcu.h>
>  #include <asm/spitfire.h>
>  

<linux/export.h> can be removed from the two assembly files, since all
the invocations of EXPORT_SYMBOL() in them were removed.

Also, xor-niagara.S ended up without a .text directive at the beginning.
Probably it was unnecessary anyway.  However, this seems unintentional,
given that xor-vis.S still has it.

- Eric

