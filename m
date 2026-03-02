Return-Path: <linux-btrfs+bounces-22135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNoAAL0+pWm36gUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22135-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 08:39:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E491D40CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 08:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 053C93004CAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAD3859D4;
	Mon,  2 Mar 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kua5aNVe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382A248F57;
	Mon,  2 Mar 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437173; cv=none; b=oh07UElQ6ZzuesZFrjbMFJaCYPExQCZBpqk48FaYX6r/VwFjmxvU5lluUh2ExRYvMjsg315KHZrG5CKsdxsjSgHnthqEr+fkZD5BuU3PNJW7GbJpZfRO/Tym1ssUqhHUcLGgoM4BHogwJJqetT/iM6sb6TuVXoK6iuANjFbYkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437173; c=relaxed/simple;
	bh=sRQsR35tocgGOPF+4BbdMojiyXXgifMPxfyFVJVZiCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JdUZaYf2+x57nP6B7XNbQ4MpqfLf0Kf7AHTOtABQZKmBfTq4MyOencfFX4CgvMdIFcDJKZQ0e6K3ZkqKwH5Q0d0LfvRH2FhyWB3XF8GqtaM2+f55sfycB5Ttzh8ssBcuBCJmxxsgoLb2WzOxjMMsDAMP3tqtYn3GspV59HD58x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kua5aNVe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s0B14b5FSBUEgAk+L55J5WroPPngMpauRKzhBytrof4=;
	t=1772437172; x=1773646772; b=kua5aNVeUbfaBQdD2ly34qoR7qoIxaf+n8cAomfOPVOX7WT
	8wvudIE1oLoXnebtkx4PUo7+vQKnIva+rUZwsHGVo9grqHvisKFaIWf0vpAXjH1N3bIjc7MkAzQup
	pjWwtLtQGLKbw2EQB9ELxSiHccM0TYUN8C90vV0q9LjUbEyzqVaD7i/fhAcetfyuCtM1zvD+WrmVH
	4HIUabu8/ELemD93y14rOhRYHoRXncLsiZzhAiGCh+TAQtZAjTL3+WOrhlfYrUGfBcPkJ7fvgfDnK
	UgaToZNc0SOaM54itPN2ofW/axjbnxh6RwyLhG7Z8WOSB53E4FcZaKhf8bqAelYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vwxrd-00000005zul-3cbJ;
	Mon, 02 Mar 2026 08:38:50 +0100
Message-ID: <3e3f46aca653cf99799111279fc554b4ca31f6b7.camel@sipsolutions.net>
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai
 Chen	 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin	 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens	 <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev	 <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Sven Schnelle
 <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson	 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov	 <anton.ivanov@cambridgegreys.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen	 <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>, Dan Williams <dan.j.williams@intel.com>,
 Chris Mason	 <clm@fb.com>, David Sterba <dsterba@suse.com>, Arnd Bergmann
 <arnd@arndb.de>,  Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
 Li Nan <linan122@huawei.com>, 	linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, 	linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, 	linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, 	linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-raid@vger.kernel.org
Date: Mon, 02 Mar 2026 08:38:47 +0100
In-Reply-To: <20260228043006.GA65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
	 <20260226151106.144735-4-hch@lst.de> <20260228043006.GA65277@quark>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22135-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 04E491D40CA
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 20:30 -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:15AM -0800, Christoph Hellwig wrote:
> > XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all th=
e
> > ifdef'ery doesn't do anything.  With our without this, the time travel
> > mode should work fine on CPUs that support AVX2, as the AVX2
> > implementation is forced in this case, and won't work otherwise.
>=20
[snip]

> I'm not following this change.  Previously, in TT_MODE_INFCPU mode,
> XOR_SELECT_TEMPLATE(NULL) returned &xor_block_avx, &xor_block_sse_pf64,
> or &xor_block_8regs, causing the benchmark to be skipped.  After this
> change, the benchmark starts being done on CPUs that don't support AVX.

Yeah the commit message is confusing - the change itself is really
trading one (potential?) issue (CPUs w/o AVX) against another old issue
(benchmark never terminates in TT_MODE_INFCPU).

However, since commit c055e3eae0f1 ("crypto: xor - use ktime for
template benchmarking") the latter issue doesn't even exist any more, so
it now works without it, though it doesn't really benchmark anything.
But that's fine too, nobody is going to be overly concerned about the
performance here, I think, and if so there's really no good way to fix
that other than providing a config option for an individual
implementation.

johannes

