Return-Path: <linux-btrfs+bounces-22055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM1oKNZKoWn7rwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22055-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 08:42:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7B01B40A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 08:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D637B30E6CA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9D36D4EC;
	Fri, 27 Feb 2026 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="olls9gHq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B323290CA;
	Fri, 27 Feb 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178034; cv=none; b=EG9OjANfqOQ/X5RsplimQjEXNRRHmUvdlUiO1b8QNmMyCdtxTMgf2QhfAbFQ5Zx218q3QyHAdtj/oCUZP8GDAEn/kbbW0921N1XfmmXF26+IJiPRiIXDUQT9UMtmzeTtMsjdfqwyYac9lWK5e4sC8CMjxjF5ZGcO2yf1grWVuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178034; c=relaxed/simple;
	bh=6TeB+wxnECTY0tW0ZKEAuaK+iy41tgHYSXrYQbS68lU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p2bBCehUPWRt0WmV+q9r40cU80XRtl3eWzk3mjO9qe8fi0g2KkIZdHQbN2GvF7yQqHMjAFX45nOcr79FVamfOk6ey2kmYszRkzOH2cF/CHEDWgx+CImXPuh5IHWaAWTNdQkV6sBhMrsz3Z/29UwIeuXyp7NDKVDbNZ8dsOiZ+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=olls9gHq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V6J0SL9RsbUQWhN8iu+ey8pLnEs4VtLYMczUYtzIoAc=;
	t=1772178033; x=1773387633; b=olls9gHq4SfXvD7rB7T8SpHOijo2QBHoX6MRNp3DUbo+0Im
	y+q06hN04UokGh0RMfdWm1bYFHKotymTHTa1+GjC7ZCe9l8+McnJ5AS76iQnFZdD3wIA5nOR/cg+k
	8mTWhwYPXLtuFofRu8uph/xh82gjsE6JsS8m7BbSPM0AW+jUdVwDOKgniqinilyZzKsJrQNNw0Y1V
	CqVnb2bf8xsLxTVcXNAnoiny1SFp+03CShFkZt4M+0+1i8G97TFjPLnTj58ZaSPJtdh/Lx9ZNj8ds
	mUhPCVLTDnmgVy1evl8fzWNhiXKjnq4cBZTCGmJtBl7XRJudvEpAWYezHg0MCAXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvsRx-00000003Eus-2oGQ;
	Fri, 27 Feb 2026 08:39:49 +0100
Message-ID: <4f69d30f952bc374e69f44786f662886c30058e9.camel@sipsolutions.net>
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Weinberger <richard@nod.at>, hch <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas	 <catalin.marinas@arm.com>, will <will@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin	 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens	 <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev	 <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Sven Schnelle
 <svens@linux.ibm.com>, davem <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>,  anton ivanov <anton.ivanov@cambridgegreys.com>,
 Thomas Gleixner <tglx@kernel.org>, mingo <mingo@redhat.com>,  bp
 <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, x86
 <x86@kernel.org>, hpa	 <hpa@zytor.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, dan j williams	 <dan.j.williams@intel.com>,
 Chris Mason <clm@fb.com>, David Sterba	 <dsterba@suse.com>, Arnd Bergmann
 <arnd@arndb.de>, Song Liu <song@kernel.org>,  Yu Kuai <yukuai@fnnas.com>,
 Li Nan <linan122@huawei.com>, linux-alpha <linux-alpha@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>,  loongarch
 <loongarch@lists.linux.dev>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-riscv	 <linux-riscv@lists.infradead.org>, linux-s390
 <linux-s390@vger.kernel.org>,  sparclinux <sparclinux@vger.kernel.org>,
 linux-um <linux-um@lists.infradead.org>, Linux Crypto Mailing List
 <linux-crypto@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 linux-arch	 <linux-arch@vger.kernel.org>, linux-raid
 <linux-raid@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 27 Feb 2026 08:39:47 +0100
In-Reply-To: <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
References: <20260226151106.144735-1-hch@lst.de>
	 <20260226151106.144735-4-hch@lst.de>
	 <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,cambridgegreys.com,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22055-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E7B01B40A1
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 22:45 +0100, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all th=
e
> > ifdef'ery doesn't do anything.  With our without this, the time travel
> > mode should work fine on CPUs that support AVX2, as the AVX2
> > implementation is forced in this case, and won't work otherwise.
>=20
> IIRC Johannes added XOR_SELECT_TEMPLATE() here to skip
> the template selection logic because it didn't work with time travel mode=
.
>=20
> Johannes, can you please test whether this change does not break
> time travel mode?

It does work, even if it reports nonsense (as you'd expect):

xor: measuring software checksum speed
   prefetch64-sse  : 12816000 MB/sec
   sse             : 12816000 MB/sec
xor: using function: prefetch64-sse (12816000 MB/sec)

I think it works now because the loop is using ktime and is bounded by
REPS, since commit c055e3eae0f1 ("crypto: xor - use ktime for template
benchmarking").

The RAID speed select still hangs, but we've gotten that removed via
Kconfig, so that's already handled. Perhaps raid6_choose_gen() should
use a similar algorithm? But for UML it doesn't really matter since
CONFIG_RAID6_PQ_BENCHMARK exists.


As far as AVX2 is concerned, yeah, I guess that was a bug, but evidently
nobody (who configured time-travel) ever cared - what _did_ matter
though in practice is that the boot not get stuck entirely... Two
completely separate issues.

johannes

