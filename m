Return-Path: <linux-btrfs+bounces-22201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HJqJI89p2kNgAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22201-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 20:59:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F11F6881
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 20:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A516730C0878
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BBA26E6FA;
	Tue,  3 Mar 2026 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHMra/+s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78863890E9;
	Tue,  3 Mar 2026 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567776; cv=none; b=UZf84atDxYdzOlZ62ATudKTjWCJLwCGWnz46FpQwU0DV01ji9DLG7HzuSOf145kxA3aqtgpEVpE+MRcLEh3ZTtdmfKGQRQrMP4/G0mcbOUmxsvybm13gCRShPrZ0jAy+D6QL0J9iMJt/d34RX8tO7WrJedTIVRXUNy9Rvbi2hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567776; c=relaxed/simple;
	bh=9sr6A1ZQ/OAOM0MyaKuNScWB7UA08hne7lVI9ssYSPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYoTYjaKU31rDK5RzhF2BbBUGjdBu104ZgDQWBpvi8jBNu2GchXWxU+YCU5vZbWNT8U4yymINOqPxIW6Q8MDM0GrGES+RGEhZ5WqhGnnQqQ9vD39/r5oDJbwHt3xKjnvWIhl7T/UxEwERsyF15UBwl+WplbBdYITXA5fV6wdMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHMra/+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1644C116C6;
	Tue,  3 Mar 2026 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772567774;
	bh=9sr6A1ZQ/OAOM0MyaKuNScWB7UA08hne7lVI9ssYSPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHMra/+se8TmXPAvXWkLhgpf0kETRB4dEaJCtUtlUTftYpe0ReqfitRfwD4MGq4+T
	 WuzDe+k5qMfwF8Pvg7plbRdHjZuWKh+IB7lEOogeIHeGkKvwd2/EpZagMr99KeT7V+
	 XN7WYkTp/J6gkuhSVqd3D55QMpvT59XaPLLtFxjhlFBUF5SPdV1HoakLZQKIIo/fdH
	 BGibgd4432V2o3DyL8VfocxjZKarY5SdEW/Gzxyc6CkyylsV/unCa5mrJJyTo1wkxn
	 QMVCX29BeW41faad8f8MgUVR1waChaWC40npYyOs3agb3dJecKXchWeHWLYBSYXFrd
	 nwEHrCxoK1HSw==
Date: Tue, 3 Mar 2026 11:55:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260303195517.GC2846@sol>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-2-hch@lst.de>
 <20260227142455.GG1282955@noisy.programming.kicks-ass.net>
 <20260303160050.GB7021@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303160050.GB7021@lst.de>
X-Rspamd-Queue-Id: F07F11F6881
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
	TAGGED_FROM(0.00)[bounces-22201-lists,linux-btrfs=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,linux-foundation.org,linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:00:50PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 27, 2026 at 03:24:55PM +0100, Peter Zijlstra wrote:
> > >  	unsigned long *p1, *p2, *p3, *p4;
> > >  
> > > +	WARN_ON_ONCE(in_interrupt());
> > 
> > Your changelog makes it sound like you want:
> > 
> > 	WARN_ON_ONCE(!in_task());
> > 
> > But perhaps something like so:
> > 
> > 	lockdep_assert_preempt_enabled();
> > 
> > Would do? That ensures we are in preemptible context, which is much the
> > same. That also ensures the cost of this assertion is only paid on debug
> > kernels.
> 
> No idea honestly.  The kernel FPU/vector helpers generally don't work
> from irq context, and I want to assert that.  Happy to do whatever
> version works best for that.

may_use_simd() is the "generic" way to check "can the FPU/vector/SIMD
registers be used".  However, what it does varies by architecture, and
it's kind of a questionable abstraction in the first place.  It's used
mostly by architecture-specific code.

If you union together the context restrictions from all the
architectures, I think you get: "For may_use_simd() to be guaranteed not
to return false due to the context, the caller needs to be running in
task context without hardirqs or softirqs disabled."

However, some architectures also incorporate a CPU feature check in
may_use_simd() as well, which makes it return false if some
CPU-dependent SIMD feature is not supported.

Because of that CPU feature check, I don't think
"WARN_ON_ONCE(!may_use_simd())" would actually be correct here.

How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
of the context restrictions correctly.  (Compared to in_task(), it
handles the cases where hardirqs or softirqs are disabled.)

Yes, it could be lockdep_assert_preemption_enabled(), but I'm not sure
"ensures the cost of this assertion is only paid on debug kernels" is
worth the cost of hiding this on production kernels.  The consequences
of using FPU/vector/SIMD registers when they can't be are very bad: some
random task's registers get corrupted.

- Eric

