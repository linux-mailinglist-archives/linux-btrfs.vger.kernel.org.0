Return-Path: <linux-btrfs+bounces-8864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3F799AD16
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 21:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27ED9282E3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 19:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2D1D0E0F;
	Fri, 11 Oct 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Bdt/19IO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6BqPEkY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8081D0F5D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676132; cv=none; b=lDFbQSLvY/3ayVYhdVFQPCdh37OU+sMZS4KjaPXxirDETJvjLAvOwzM6pthqPgEbexfQmWISCEIQ8EViWWqfBr36mOWywH0W/8kz78Uxk2a32LHjmvICnAX/mv5qyowaFQrcW+JOULRZ1IqddByVr8KyxSqhf0lh4ry/na4/LLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676132; c=relaxed/simple;
	bh=9EV9X+dC7S1Jqb9Y7IstWe0ZdQzIKaPbhbmCCsikc1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElymAkLuBxcSqk7q5UQC35ZKE4C024FOKKT8m4rjKLPMh77bPj6O3RxoNRJ92vPNALwxhrcco6Oiqu/DOhdF3O3FGPUH5+dwcElNJKD59EEyp/AyD8JcvvPn5t+xl+GCOzrpxztvQYCyN4N36yrVNom7bdEQHcfZtRnYptdO/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Bdt/19IO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6BqPEkY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 116331380205;
	Fri, 11 Oct 2024 15:48:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 11 Oct 2024 15:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1728676128; x=1728762528; bh=f0l6EAXqtT
	lN16i/14ZR6Fp86c3HwFzcLJZTQEURv9o=; b=Bdt/19IObEkUwekzaO/wsVRito
	uqC9MD7nQhr9IBR1yvAEAet5XMHLN2pgh/XMJaV1CO6RNefji2/vlvFAo9FY6L/P
	aV+ceerBNvWLxxF7xEV89WScEOv+QuI8XA4bXojn+zZJ7yx2UtgP5Jq9YMoeKufJ
	O/nnktUut4/4VTHHFKSJyrONaTzyTlCZSoYV2rIIGg07vwbj4vMYVnFlCW1vyjYt
	ftxGJb0VfKRuAV/fHd9pSe3PUtADju822YoEM1Ok5cWdBqktGdauC1pkLK7nADD4
	nKJip48rwliSnaoRV8FEknW66xxRfae+UAUqyRA/l7D0qW7HTEziuEkBctoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728676128; x=1728762528; bh=f0l6EAXqtTlN16i/14ZR6Fp86c3H
	wFzcLJZTQEURv9o=; b=K6BqPEkYJmr/h2E5k7+U79v9MvbU2Ae3G02opc3Lfgv+
	PDdCXXbWZzIKibX/ZPGrfgtwLgEG6t3uZcP8ggIiEe95CreB7cWHLDVbysxyn/sj
	Pf1/6TomF3nT1bXLFKnLD3GUJ7zelBiac8f+Sbc6nK7YDHXcrFgLSeK1GBsgh5SZ
	JR8Jn+1xQR2HkpfYHJ7DCucb0/CdQPrfIrFcAxQXRlhTo8UnlF/xMMwX1LQ6+208
	U8lAgZH7eL6zaXLpaIerDbgHjoboG70pc/xKTPmyLRt9lt5K+dR8MAfHebpV0BFA
	dKZtvJUBcQUnjaTRFnfAedUatakFHrlMO2XpdBC9TQ==
X-ME-Sender: <xms:H4EJZ3Ij-QNWiAk4zXEq7e-khx-ObMGSi0BO2C_Y8Beriat4aKEZdQ>
    <xme:H4EJZ7Kf-lc2zUpWap0TMNsy5RaFHLqkrvH4__1RKSdx3F41Zw00GLlpz-tfpUTNw
    -Tgf9YX8nGhoUDPRHc>
X-ME-Received: <xmr:H4EJZ_tCqCz1GKz_MhZbnJ1uLUrlViPQLTFuejm92DYgARSlJYIf661pTt8t5G7-6E5dH1LTb9VxQn7KZDs7MnKHG14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepieetieeggfekkeduiedtiefggfelueevleehteeuvefgvdel
    kefhledukeeihedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhhunhdrshhhpd
    hlphgtrdgvvhgvnhhtshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtiidprhgt
    phhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:H4EJZwZzGd781reyKCmjaX_8z611r_w4zsDtf7vbXrMS3A5rs6DU2w>
    <xmx:H4EJZ-Yh-efSnTMhkmG3vhMhYaCk88AU9tASWwQ0RYhoGrlLcGc4Zw>
    <xmx:H4EJZ0Cvds7lHPneo0hJob0FpFinYBXtwPNeF4gDrkkprMO5Z-6XDQ>
    <xmx:H4EJZ8avmQvRlm78I_UV8J6zZcs87fHicrP65DDnXormpZkxcB1vug>
    <xmx:IIEJZ-G8DU7FhFdpRuOVTdbrW0X0gIDuk5j_wVmXfD53--tX5qqPzcKM>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 15:48:47 -0400 (EDT)
Date: Fri, 11 Oct 2024 12:48:31 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: try to search for data csums in commit root
Message-ID: <20241011194831.GA2832667@zen.localdomain>
References: <0a59693a70f542120a0302e9864e7f9b86e1cb4c.1728415983.git.boris@bur.io>
 <20241011174603.GA1609@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011174603.GA1609@twin.jikos.cz>

On Fri, Oct 11, 2024 at 07:46:03PM +0200, David Sterba wrote:
> On Tue, Oct 08, 2024 at 12:36:34PM -0700, Boris Burkov wrote:
> > If you run a workload like:
> > - a cgroup that does tons of data reading, with a harsh memory limit
> > - a second cgroup that tries to write new files
> > e.g.:
> > https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh
> > 
> > then what quickly occurs is:
> > - a high degree of contention on the csum root node eb rwsem
> > - memory starved cgroup doing tons of reclaim on CPU.
> > - many reader threads in the memory starved cgroup "holding" the sem
> >   as readers, but not scheduling promptly. i.e., task __state == 0, but
> >   not running on a cpu.
> > - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> > 
> > This results in VERY long transactions. On my test system, that script
> > produces 20-30s long transaction commits. This then results in
> > seriously degraded performance for any cgroup using the filesystem (the
> > victim cgroup in the script).
> > 
> > This reproducer is a bit silly, as the villanous cgroup is using almost
> > all of its memory.max for kernel memory (specifically pagetables) but it
> > sort of doesn't matter, as I am most interested in the btrfs locking
> > behavior. It isn't an academic problem, as we see this exact problem in
> > production at Meta with one cgroup over memory.max ruining btrfs
> > performance for the whole system.
> > 
> > The underlying scheduling "problem" with global rwsems is sort of thorny
> > and apparently well known. e.g.
> > https://lpc.events/event/18/contributions/1883/
> > 
> > As a result, our main lever in the short term is just trying to reduce
> > contention on our various rwsems. In the case of the csum tree, we can
> > either redesign btree locking (hard...) or try to use the commit root
> > when we can. Luckily, it seems likely that many reads are for old extents
> > written many transactions ago, and that for those we *can* in fact
> > search the commit root!
> > 
> > This change detects when we are trying to read an old extent (according
> > to extent map generation) and then wires that through bio_ctrl to the
> > btrfs_bio, which unfortunately isn't allocated yet when we have this
> > information. When we go to lookup the csums in lookup_bio_sums we can
> > check this condition on the btrfs_bio and do the commit root lookup
> > accordingly.
> > 
> > With the fix, on that same test case, commit latencies no longer exceed
> > ~400ms on my system.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v2:
> > - hold the commit_root_sem for the duration of the entire lookup, not
> >   just per btrfs_search_slot. Note that we can't naively do the thing
> >   where we release the lock every loop as that is exactly what we are
> >   trying to avoid. Theoretically, we could re-grab the lock and fully
> >   start over if the lock is write contended or something. I suspect the
> >   rwsem fairness features will let the commit writer get it fast enough
> >   anyway.
> 
> I'd rather let the locking primitives do the fairness, mutex spinning or
> other optimizations, unless you'd find a good reason to add some try
> locks or contention checks. But such things are hard to predict just
> from the code, this depends on data, how many threads are involved.
> Regrabbing could be left as an option when there is some corner case.
> 

Agreed.

> > 
> > ---
> >  fs/btrfs/bio.h       |  1 +
> >  fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
> >  fs/btrfs/file-item.c | 10 ++++++++++
> >  3 files changed, 32 insertions(+)
> > 
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index e48612340745..159f6a4425a6 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -48,6 +48,7 @@ struct btrfs_bio {
> >  			u8 *csum;
> >  			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
> >  			struct bvec_iter saved_iter;
> > +			bool commit_root_csum;
> 
> Can you please find another way how to store this? Maybe the bio flags
> have some bits free. Otherwise this adds 8 bytes to btrfs_bio, while
> this structure should be optimized for size.  It's ok to use bool for
> simplicity in the first versions when you're testing the locking.

Ooh, good point!

I started looking into it some more and it's tricky but I have a few
ideas, curious what you think:

1. Export the btrfs_bio_ctrl and optionally wire it through the
   callstack. For data reads it is still live on the stack, we just can't
   be sure that containerof will work in general. Or just wire the bool
   through the calls. This is pretty "trivial" but also ugly.
2. We already allocate an io context in multi-device scenarios. we could
   allocate a smaller one for single. That doesn't seem that different
   than adding a flags to btrfs_bio.
3. Figure out how to stuff it into struct btrfs_bio. For example, I
   think we aren't using btrfs_bio->private until later, so we could put
   a to-be-overwritten submit control struct in there.
4. Figure out how to stuff it into struct bio. This would be your
   bi_flags idea. However, I'm confused how to do that safely. Doesn't
   the block layer own those bits? It seems aggressive for me to try
   to use them. bio has a bi_private as well, which might be unset in
   the context we care about.

I'm leaning towards option 3: taking advantage of the yet unset
btrfs_bio->private

Thanks for the review,
Boris

