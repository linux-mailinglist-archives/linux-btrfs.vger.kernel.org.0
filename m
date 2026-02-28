Return-Path: <linux-btrfs+bounces-22102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGllCWWQomlq4AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22102-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:51:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71821C0A95
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE453096A5E
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361033B6C5;
	Sat, 28 Feb 2026 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTFfr8oc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F20368961;
	Sat, 28 Feb 2026 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261442; cv=none; b=ZOT8Qt11kjrKs5yFcxfb6wlkhUQW8MKwDso7iwOkpIz8bQqjokKEnrAuodEnmqDJSFVVSCQl4YIUnYsTD5FlkL9w2Ky9IwnWofF486X1FVp2GkNAfSPKW4NdL7WJKSjiGS1g+QVxpyTLXUyHUTbSdm1pjhXzi4dLkMKel02H5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261442; c=relaxed/simple;
	bh=vPTEPlrxe6ytedqa6Me+M+hZkV+rGO8rrN4LIEvszKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBrb+OIC5dybyKqJX7IwTQa46uEC/cVSYw2SLS6BACPM9zeIeHWE1q8ZTjOH3b6lzAHeFwincqCKqHdwE3YGtSEgbnyDnK65y1UL6A9q7vnralb5jb7OohtkYF/07hXMdX0RsxUq72N8MwBK3e0/5rVSIKR3F8FjljNH5LvUg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTFfr8oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F92C116D0;
	Sat, 28 Feb 2026 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772261441;
	bh=vPTEPlrxe6ytedqa6Me+M+hZkV+rGO8rrN4LIEvszKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTFfr8ocKEvs3vXYRewYWPSFe2kL3EkPqlXMH9SFlbuxla7B1++TfbbR29cAr/T69
	 8RlajaFDOInAOiN+ZK7veFCGRmxjx3J7bE/ObG1rUVu/wJzBNzB68455fQxxkndpm2
	 Tm8vLFnkUPRX5ZN0PkWUIEMTd4tfYl/XR8pSy9Z/UPR0Qpq83+piDFPoy0+TgckjTx
	 fIBVNpnimUABvVb4nGDJC3hmwuwMOJKdRSInNWdlSTmxsPRa6fXgS00DoHU0JgsDRW
	 lp50vbyxlZIuxosoVMrxCRj/2aCgMhGTMqw6gfvTpMznmcYFwDNIHqHcgooJXMIogZ
	 UhhsWMu+jeEcw==
Date: Fri, 27 Feb 2026 22:50:38 -0800
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
Subject: Re: [PATCH 21/25] xor: add a better public API
Message-ID: <20260228065038.GH65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-22-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-22-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-22102-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: B71821C0A95
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:10:33AM -0800, Christoph Hellwig wrote:
> xor_blocks is very annoying to use, because it is limited to 4 + 1
> sources / destinations, has an odd argument order and is completely
> undocumented.
> 
> Lift the code that loops around it from btrfs and async_tx/async_xor into
> common code under the name xor_gen and properly document it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/raid/xor.h |  3 +++
>  lib/raid/xor/xor-core.c  | 28 ++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
> index 02bda8d99534..4735a4e960f9 100644
> --- a/include/linux/raid/xor.h
> +++ b/include/linux/raid/xor.h
> @@ -7,4 +7,7 @@
>  extern void xor_blocks(unsigned int count, unsigned int bytes,
>  	void *dest, void **srcs);
>  
> +void xor_gen(void *dest, void **srcss, unsigned int src_cnt,
> +		unsigned int bytes);

srcss => srcs

Ideally the source vectors would be 'const' as well.

> +/**
> + * xor_gen - generate RAID-style XOR information
> + * @dest:	destination vector
> + * @srcs:	source vectors
> + * @src_cnt:	number of source vectors
> + * @bytes:	length in bytes of each vector
> + *
> + * Performs bit-wise XOR operation into @dest for each of the @src_cnt vectors
> + * in @srcs for a length of @bytes bytes.
> + *
> + * Note: for typical RAID uses, @dest either needs to be zeroed, or filled with
> + * the first disk, which then needs to be removed from @srcs.
> + */
> +void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
> +{
> +	unsigned int src_off = 0;
> +
> +	while (src_cnt > 0) {
> +		unsigned int this_cnt = min(src_cnt, MAX_XOR_BLOCKS);
> +
> +		xor_blocks(this_cnt, bytes, dest, srcs + src_off);
> +
> +		src_cnt -= this_cnt;
> +		src_off += this_cnt;
> +	}
> +}
> +EXPORT_SYMBOL(xor_gen);

The alignment requirements on the vectors should be documented, as
should which values of bytes are accepted.  It looks like, at the very
least, the vectors have to be 32-byte aligned and the length has to be a
nonzero multiple of 512 bytes.  But I didn't check every implementation.

Also, the requirement on the calling context (e.g. !is_interrupt())
should be documented as well.

- Eric

