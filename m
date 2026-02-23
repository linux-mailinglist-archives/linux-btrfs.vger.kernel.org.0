Return-Path: <linux-btrfs+bounces-21834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFpoDkM2nGnsBQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21834-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 12:13:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C706175549
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 12:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4FA7302195B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0FC361647;
	Mon, 23 Feb 2026 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBNhja7A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527A35CB8C
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845173; cv=none; b=Mar2oo+hT6cOZo3jTOodQTavi7CuEJBwK+LylChhDx47vFBe//KRgRPdrdrRk1lbJTeN9zDXU25rqSMReQORkWmo19lwMeiRx48aVXGs20nbWnP7DIpHjQEi1HbID/2yadcalUh3o4nqw6tpgcdxJnzSeiJnqpATxrH6YkXTM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845173; c=relaxed/simple;
	bh=0BfjSWGOzFBxkTvIMw0pWmUuVc4MaBwIhiGlL8FX7aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdCjaj8MnDbqFeGG2P1bwMglLaGj9Hf/A5yI89zoW57s9m+Y/O0aDqzKwyCLkH0nMVG9VKwNbGakzI2CVDCzNdqWi9dS3/xE5JBhzI2VFu1OGVfRvq7B7k7DkGVfcCWA6PRalcqnGasHXZQJmaBAjnzmHSFxUvB23emy0p+9yZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBNhja7A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4837584120eso29640685e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845170; x=1772449970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6n+oxOREuT+ZoDytgRh/Y9obuCsnXSbm2faHqHT5nEs=;
        b=DBNhja7ARe3RxQSiGr/SsB1zdk9FI2V7abLtmjoRQKVzxHsSCx5BOs43rpFio7Y+A4
         Di7OFMNCbsTnPoXlMTPwUoBstquTY5Ixn1awWFKnGr0a9EJP82LHTvf09pztLow5VruA
         GO9rcy2UCYRW9uKdQgez144y0Jodtw8rG36oxK3cLwzG5ZGEf8Jt+2mwxPPwOng360f2
         8IPNEX2Hndg/bpzrOjNC4Uz99Y0cMT/xGD8geMzPLEtgwyhwLH/4kWGrE22jVrjXQtH6
         twAESLOoOkLt75f8lRXEcbLhCPoIJFENh28zVxwxjFrocS3VKgq7dWKOeik77QjNP67h
         Osow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845170; x=1772449970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n+oxOREuT+ZoDytgRh/Y9obuCsnXSbm2faHqHT5nEs=;
        b=mNNZQ74/O1j78ZvE9sOKlGm7GEDvg7NVxTvGERkxi4b4fn5alDLaO+q5xOiFMauI97
         5Y1E1UVRmNg9fGHOan2kxlxUmXCrGTlytdgBc74w0OEotaf8lEoLUlEVzfng4SZQHHyE
         Tiz87EwrXntOOrbKymrPv8sZMFYVUVKIDHfFtIalQQ3AQnieJ1NQHUfcU2vFgd7raUn4
         m3AYWsWr9E5XyNX2eDJTYi03bVgBVwMXdmjpOP+BxwD/LPufh3p9TcJ+SouOAybi4lS4
         nDz6Lgxn8pyx+OGFcYdZbE20HBtA6YlfidzbeCsEzzmNNjlIvkTYC+eLFh7khd/674Jc
         kspg==
X-Forwarded-Encrypted: i=1; AJvYcCVrusgO0KSUlEg1qH86a6yeVmpjhzi97PMEaOcQ+yRuUvq2b2EAMogNRfclQoc0eq9JRwNBqG57IGq0QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4VHCe/+y4ehebWFKH0oOq+CNWRk9d5xEmPQUHxWcs+LbUJXI
	AZL9etxFWjjy8LiCNNYUbvca14JlTm+h90C3YkmghSoCDovQQA8l55Ar
X-Gm-Gg: AZuq6aJIJuTijz9VPk4PHyDq6acSyqx7gyzhTf0p5pn9Vlf2Se336MuCNe7cAWflW3Q
	qFxebr7nD/YdQmXMhBbyODDQYdUsGDoDODHqTkGNSo8F9j2P+0O5mTEagTXDz/nHqIez3rkFuBf
	HCQVI32xLiO0N+YoyPLefNHtci8NfNeUtRLce7bD8I2YNVoUrUro19YqkgdKHbloXCzr+tMkLzj
	qS23EzI9UGndsNWx5lDMtcC4v0vLSo6xyUHr58aHMA1nG9eIKed5o9hD22pmkpurpZYorimoNpj
	lD0O1BBqA0gk62u4Au81Pwp7k2shtIf865KfdxrQmVAeRvO778PLPme1MAsXz+ONFj8oKd6kVok
	9VsrSu6W6TkMSZIvbbVoaoT1njM8uO/nB0996Vjvc5gxiHj8fJFPkx4wuqggXly97nKenuVacFU
	6nb3ZB6PiXOXeaiJaSgn0Inj1Yvh+8LYY=
X-Received: by 2002:a05:600c:8b71:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-483a95c63ddmr134839155e9.13.1771845169900;
        Mon, 23 Feb 2026 03:12:49 -0800 (PST)
Received: from debian.local ([90.243.35.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31ff4d7sm271733245e9.15.2026.02.23.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:12:49 -0800 (PST)
Date: Mon, 23 Feb 2026 11:12:47 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, surenb@google.com, hao.li@linux.dev, leitao@debian.org,
	Liam.Howlett@oracle.com, zhao1.liu@intel.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] kswapd0: page allocation failure (bisected to
 "slab: add sheaves to most caches")
Message-ID: <aZw2LyOjxMc-c3dl@debian.local>
References: <aZt2-oS9lkmwT7Ch@debian.local>
 <aZwSreGj9-HHdD-j@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZwSreGj9-HHdD-j@hyeyoo>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21834-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C706175549
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 05:41:17PM +0900, Harry Yoo wrote:
> On Sun, Feb 22, 2026 at 09:36:58PM +0000, Chris Bainbridge wrote:
> > Hi,
> > 
> > The latest mainline kernel (v6.19-11831-ga95f71ad3e2e) has page
> > allocation failures when doing things like compiling a kernel. I can
> > also reproduce this with a stress test like
> > `stress-ng --vm 2 --vm-bytes 110% --verify -v`
> 
> Hi, thanks for the report!
> 
> > [  104.032925] kswapd0: page allocation failure: order:0, mode:0xc0c40(GFP_NOFS|__GFP_COMP|__GFP_NOMEMALLOC), nodemask=(null),cpuset=/,mems_allowed=0
> > [  104.033307] CPU: 4 UID: 0 PID: 156 Comm: kswapd0 Not tainted 6.19.0-rc5-00027-g40fd0acc45d0 #435 PREEMPT(voluntary) 
> > [  104.033312] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
> > [  104.033314] Call Trace:
> > [  104.033316]  <TASK>
> > [  104.033319]  dump_stack_lvl+0x6a/0x90
> > [  104.033328]  warn_alloc.cold+0x95/0x1af
> > [  104.033334]  ? zone_watermark_ok+0x80/0x80
> > [  104.033350]  __alloc_frozen_pages_noprof+0xec3/0x2470
> > [  104.033353]  ? __lock_acquire+0x489/0x2600
> > [  104.033359]  ? stack_access_ok+0x1c0/0x1c0
> > [  104.033367]  ? warn_alloc+0x1d0/0x1d0
> > [  104.033371]  ? __lock_acquire+0x489/0x2600
> > [  104.033375]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> > [  104.033379]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> > [  104.033382]  ? lockdep_hardirqs_on+0x78/0x100
> > [  104.033394]  allocate_slab+0x2b7/0x510
> > [  104.033399]  refill_objects+0x25d/0x380
> > [  104.033407]  __pcs_replace_empty_main+0x193/0x5f0
> > [  104.033412]  kmem_cache_alloc_noprof+0x5b6/0x6f0
> > [  104.033415]  ? alloc_extent_state+0x1b/0x210 [btrfs]
> > [  104.033479]  alloc_extent_state+0x1b/0x210 [btrfs]
> > [  104.033527]  btrfs_clear_extent_bit_changeset+0x2be/0x9c0 [btrfs]
> 
> Hmm while bisect points out the first bad commit is
> commit e47c897a2949 ("slab: add sheaves to most caches"),
> 
> I think the caller is supposed to specify __GFP_NOWARN if it doesn't
> care about allocation failure?
> 
> btrfs_clear_extent_bit_changeset() says:
> >         if (!prealloc) {
> >                 /*
> >                  * Don't care for allocation failure here because we might end
> >                  * up not needing the pre-allocated extent state at all, which
> >                  * is the case if we only have in the tree extent states that 
> >                  * cover our input range and don't cover too any other range.
> >                  * If we end up needing a new extent state we allocate it later.
> >                  */
> >                 prealloc = alloc_extent_state(mask);
> >         }
> 
> Oh wait, I see what's going on. bisection pointed out the commit
> because slab tries to refill sheaves with __GFP_NOMEMALLOC (and then
> falls back to slowpath if it fails).
> 
> Since failing to refill sheaves doesn't mean the allocation will fail,
> it should specify __GFP_NOWARN with __GFP_NOMEMALLOC as long as there's
> fallback method.
> 
> But for __prefill_sheaf_pfmemalloc(), it should specify __GPF_NOWARN on
> the first attempt only when gfp_pfmemalloc_allowed() returns true.

Is this fix sufficient to do the right thing? I tested it, and it does
appear to prevent logging of the allocation failures for my test case.

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index d0dd50f7d279..d2e1083848e8 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -641,7 +641,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 		 * cover our input range and don't cover too any other range.
 		 * If we end up needing a new extent state we allocate it later.
 		 */
-		prealloc = alloc_extent_state(mask);
+		prealloc = alloc_extent_state(mask | __GFP_NOWARN);
 	}
 
 	spin_lock(&tree->lock);

