Return-Path: <linux-btrfs+bounces-21635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iImYFM7QjGk1tgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21635-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 19:56:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B61126F84
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 19:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C154B3019467
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D38352F92;
	Wed, 11 Feb 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="AbemfsGF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fp5Je+Lj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432334575A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836166; cv=none; b=fDWT6+AmgsZl06kVK8wBktStkZ2FcllPzbPR2pql2fOeRei85X0iAdAv/DALQ/+lGCRyydW561z8OOpy7NzISW3Ql5D8k09dBxGuRFkqa/Bd3+0LGLCZLkU3RPSTxGOoNS7dcQQ+rCZX1DRMU+a4lAOWIaFwKYBRuwARUgMKFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836166; c=relaxed/simple;
	bh=jRjrRp9z3U1N8s3JZdC5AyXHAZgsmY9WvQkRdIddQCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4FC1e6iIDnhuM6SOw82kUEFVZqao4REg+U0LdY1BHB5pHUKZpz8IYxntKod6lb2XtjL/YJ0T+HKwlkkVJvVeXdus/GCFjjegtsUmYX6FZRf+Ka4wYwyMnz4YK6Fgiupv7U+Ssvpj2nls+oJuNifKO1DuujhivJkynfPE6VYhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=AbemfsGF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fp5Je+Lj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A8C9CEC05BF;
	Wed, 11 Feb 2026 13:56:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 11 Feb 2026 13:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770836163; x=1770922563; bh=3Lpf3EVj6h
	NRcFc9k5uQqt7C13uRbdnt3rts03dSmWc=; b=AbemfsGFZxKQpbb2bCEvskHdmJ
	2J4R7W4bVsjgOkZpOZwaNR7MyenCTyYfphr17SONNQtnzcm7nitlWCO3T6rLLzsa
	pPBHbI/SP5PHBQqX1uJJA6iflfpiiuXASHoUGqW+1VlebtO1Rix3/kjS6DiavrA3
	gCKlK7ldIlI71SQ7ZlFP69tCvTdB8s3TbU8lIWAoCL+Ip/8bROrvxZ5d9DVG8Ryx
	Y6Gbx7P6jit8vXMdit+CtTZrX7WFJEgGIxa73n2lX2j5jn4MDYEO6LftiePXSg7k
	Hb52Jj8Wt782ruTpZl2t4w7pZZODSv9/T2dyKHqBw8yU/a0T2BCbX9aJeIFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770836163; x=1770922563; bh=3Lpf3EVj6hNRcFc9k5uQqt7C13uRbdnt3rt
	s03dSmWc=; b=Fp5Je+LjsAhqlh+Ffom3OOKueHDLNY4HVPimBIb1LR8MIQSANO0
	wMEyYYO/TRlDk7DXZ1Ro47J1teT5kAME+udQWjFCfzJWigEYzqb5KXMvhCquiDjB
	oQeLilwja4uBoiCb3vTwMCudv9YYDBEIHwRvVP21s3BCIHcWm5dOxxGKV4FAeBam
	ccDu/QU+tEWqUWrRNOcTpzedwHmVujVSUf0ONIRRNXecFeXyNScN4/5iZ3rO3MzV
	XUL7j/ysLhv0LUjeqlX0qSPFIs3b6RKcd4OtV1g1Z92/DlG/Zp6jMR/V/f+WRPw3
	++3eSDNtpCi6phYjgs2e3/TSj0gYjGVEjvw==
X-ME-Sender: <xms:w9CMaXEIkrW1Ci6RP8zmSB-kkV5V4Nwa4licL4xbuNk6dWVC8aWB0w>
    <xme:w9CMabwVwfoRRea3luSkbCisiYpGyIlbdAuQh6qH91jB04t2PIOBCrmSBb9Er5-dx
    sjXWU1FWedIWnvpOWi641xs2LwEdClycKOMmGhGywwdx5YHHBz1cg>
X-ME-Received: <xmr:w9CMaWgxi4PmOD_x5jwxeZedLRuv75Q-0j3Rzrpi6yXA3VWyhGa_z8EMQP0FeW9Tq1GQl5OTxc1bhjUr1V2Yt-gsXYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepleffgeevgeetueegledtueeluddtudekhefhudeuhe
    egfeevieehteevieejueetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehf
    sgdrtghomh
X-ME-Proxy: <xmx:w9CMaez8UbU-gbGMl0o-cxlNHiAuK58NM8vim676L44OC8CAYrPgQA>
    <xmx:w9CMaRI0Fhl29nXSP7gwa3AefcQw1IN984BK0MMknmF9NUQY_qOyfA>
    <xmx:w9CMadTYZUhanuYZ69xWKGj2Lk6rHsYTq6o0g6lSCmMckYmrI3TQeQ>
    <xmx:w9CMaRrUbn0j7YEfznWZPvI1CMn7cszstjzN5mN3gnteUFhK7qvGPQ>
    <xmx:w9CMaaDsMBEygaesrnChlbLvtsMq-7470t7JXW-Y0bj26q_FF4ukcJEA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 13:56:02 -0500 (EST)
Date: Wed, 11 Feb 2026 10:55:13 -0800
From: Boris Burkov <boris@bur.io>
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs: check squota parent usage on membership change
Message-ID: <20260211185513.GA1496181@zen.localdomain>
References: <cover.1764796022.git.boris@bur.io>
 <5d170d19ba8d0494c77a638293cc66ecb8a66967.1764796022.git.boris@bur.io>
 <20260208185947.1191113-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208185947.1191113-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21635-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zen.localdomain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 08B61126F84
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 10:59:01AM -0800, Chris Mason wrote:
> Boris Burkov <boris@bur.io> wrote:
> > We could have detected the quick inherit bug more directly if we had
> > an extra warning about squota hierarchy consistency while modifying the
> > hierarchy. In squotas, the parent usage always simply adds up to the sum of
> > its children, so we can just check for that when changing membership and
> > detect more accounting bugs.
> 
> Hi everyone,
> 
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
> 
> https://github.com/masoncl/review-prompts
> 
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
> 
> commit 9c46bcda5f347febdbb4d117fb21a37ffcec5fa4
> Author: Boris Burkov <boris@bur.io>
> 
> btrfs: check squota parent usage on membership change
> 
> This commit adds a diagnostic check to detect squota hierarchy
> consistency issues when modifying qgroup membership. The check verifies
> that parent usage equals the sum of its children's usage.
> 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 206587820fec0..3a74759b59ee4 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -346,6 +346,42 @@ int btrfs_verify_qgroup_counts(const struct btrfs_fs_info *fs_info, u64 qgroupid
> >  }
> >  #endif
> >
> > +static bool squota_check_parent_usage(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *parent)
> > +{
> > +	u64 excl_sum = 0;
> > +	u64 rfer_sum = 0;
> > +	u64 excl_cmpr_sum = 0;
> > +	u64 rfer_cmpr_sum = 0;
> > +	struct btrfs_qgroup_list *glist;
> > +	int nr_members = 0;
> > +	bool mismatch;
> > +
> > +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
> > +		return false;
> > +	if (btrfs_qgroup_level(parent->qgroupid) == 0)
> > +		return false;
> > +
> > +	/* Eligible parent qgroup. Squota; level > 0; empty members list. */
> > +	list_for_each_entry(glist, &parent->members, next_member) {
> > +		excl_sum += glist->member->excl;
> > +		rfer_sum += glist->member->rfer;
> > +		excl_cmpr_sum += glist->member->excl_cmpr;
> > +		rfer_cmpr_sum += glist->member->rfer_cmpr;
> > +		nr_members++;
> > +	}
> > +	mismatch = (parent->excl != excl_sum || parent->rfer != rfer_sum ||
> > +		    parent->excl_cmpr != excl_cmpr_sum || parent->rfer_cmpr != excl_cmpr_sum);
>                                                                             ^^^^^^^^^^^^^^^^
> 
> Is parent->rfer_cmpr being compared to the wrong variable? The code
> compares parent->rfer_cmpr to excl_cmpr_sum, but rfer_cmpr_sum was
> calculated above and never used. Should this be comparing
> parent->rfer_cmpr != rfer_cmpr_sum instead?
> 

I believe this is correct, but "irrelevant" because rfer == excl in
squota. (and rfer_cmpr == excl_cmpr == 0)

But might as well clean it up, as it is needlessly messy. I'll send the patch.

Thanks,
Boris

> > +
> > +	WARN(mismatch,
> > +	     "parent squota qgroup %hu/%llu has mismatched usage from its %d members. "
> > +	     "%llu %llu %llu %llu vs %llu %llu %llu %llu\n",
> > +	     btrfs_qgroup_level(parent->qgroupid),
> > +	     btrfs_qgroup_subvolid(parent->qgroupid), nr_members, parent->excl,
> > +	     parent->rfer, parent->excl_cmpr, parent->rfer_cmpr, excl_sum,
> > +	     rfer_sum, excl_cmpr_sum, rfer_cmpr_sum);
> > +	return mismatch;
> > +}
> 
> [ ... ]
> 
> 

