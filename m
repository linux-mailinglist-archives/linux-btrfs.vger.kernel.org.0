Return-Path: <linux-btrfs+bounces-8862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD199AAA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 19:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD1C285EB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075D1C2327;
	Fri, 11 Oct 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ellwJaMb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6DU4PE39";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hO0HcxPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RopyGmoU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645557F9
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668769; cv=none; b=O62YkICg3xHatyluJGeQtT8V3prNcasun6ItNZWgbFboGZ9TC6uj0eeMuw8RQ3jQ5osEBtZI/l5NROSIP9kFsVqJnY/7yzxOzGWFwzy6m6E2gnUdlTwWnhrVD6cCT9IQ2sdYLnHHmpaPHl7hQbmbDuauQlEBxXX6LJo/GvYDZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668769; c=relaxed/simple;
	bh=tCGTskJnB/OZ9oGHEg2P3U3cpjf/VrWSIkp9mgNClXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx22OX8u0iwdjlZcy5BbRAoEyCCSwVII4b1pM8fQLW/RzElFfULAE9Eya3forgoC5hREV9RwE68S4Cm5Fj1ZfoBxl6AZkJLL9UUB7xssX2p6FIYbj4MqpMM1cTVlBfk/nSUWbhCz/2ZrycHA7HZzt+/2P4ISOGBwaB/7UGw2fps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ellwJaMb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6DU4PE39; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hO0HcxPJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RopyGmoU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 622962201D;
	Fri, 11 Oct 2024 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728668765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hE+tCYAjxfPKfrVUl6MCTQyycrwrgfIKv88IgNuB1NY=;
	b=ellwJaMbzr+DOJcw2GKpr5Cy932l8yqirJUitGlAMvHnaZ+yN6s4zX1Sfi3iAk5hGyaosu
	rZ63jBXLxILFnELKIG1PLz8VeCE8lSEbRUisP22Gc0Gu9svAIOgaoiPysHu+IZEpeaf3Wn
	sLVmpoj4Y7Bj7rZCqsFpVDbK2X0r8qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728668765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hE+tCYAjxfPKfrVUl6MCTQyycrwrgfIKv88IgNuB1NY=;
	b=6DU4PE39NzaUsnGfhBzFMDCbJqBitbz1+d/fLcHl1Bli4ziSV+z5qB+xdIMl18A++nvPDg
	X+oTOqj/UyLIy+BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728668764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hE+tCYAjxfPKfrVUl6MCTQyycrwrgfIKv88IgNuB1NY=;
	b=hO0HcxPJWSMKcr3StXeVnEwMcTAOeDsDDLlc5O3qQaIBQsXBHYr6TVDUOkYKPuxGgDG1bK
	rrkQbnBgmQOS3959nHCb1O/laRyI2nMBpfJ2f/eXW0ioGUDVXeSe7mVwTFpNJwlfA4ths1
	Xaxr6Zt1Bmxl0677E+ExRgVzoW3l9tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728668764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hE+tCYAjxfPKfrVUl6MCTQyycrwrgfIKv88IgNuB1NY=;
	b=RopyGmoUiMfT2t551X3aBUiaGstCKr+NBKogLemcYYV3qgd4DbAM6pocOT+lH4K7rbSOK8
	rj7531fm20/l/yBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4258913AB0;
	Fri, 11 Oct 2024 17:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tvz5D1xkCWeQUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Oct 2024 17:46:04 +0000
Date: Fri, 11 Oct 2024 19:46:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: try to search for data csums in commit root
Message-ID: <20241011174603.GA1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0a59693a70f542120a0302e9864e7f9b86e1cb4c.1728415983.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a59693a70f542120a0302e9864e7f9b86e1cb4c.1728415983.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid,bur.io:email];
	URIBL_BLOCKED(0.00)[lpc.events:url,twin.jikos.cz:mid,suse.cz:replyto,bur.io:email,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Oct 08, 2024 at 12:36:34PM -0700, Boris Burkov wrote:
> If you run a workload like:
> - a cgroup that does tons of data reading, with a harsh memory limit
> - a second cgroup that tries to write new files
> e.g.:
> https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh
> 
> then what quickly occurs is:
> - a high degree of contention on the csum root node eb rwsem
> - memory starved cgroup doing tons of reclaim on CPU.
> - many reader threads in the memory starved cgroup "holding" the sem
>   as readers, but not scheduling promptly. i.e., task __state == 0, but
>   not running on a cpu.
> - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> 
> This results in VERY long transactions. On my test system, that script
> produces 20-30s long transaction commits. This then results in
> seriously degraded performance for any cgroup using the filesystem (the
> victim cgroup in the script).
> 
> This reproducer is a bit silly, as the villanous cgroup is using almost
> all of its memory.max for kernel memory (specifically pagetables) but it
> sort of doesn't matter, as I am most interested in the btrfs locking
> behavior. It isn't an academic problem, as we see this exact problem in
> production at Meta with one cgroup over memory.max ruining btrfs
> performance for the whole system.
> 
> The underlying scheduling "problem" with global rwsems is sort of thorny
> and apparently well known. e.g.
> https://lpc.events/event/18/contributions/1883/
> 
> As a result, our main lever in the short term is just trying to reduce
> contention on our various rwsems. In the case of the csum tree, we can
> either redesign btree locking (hard...) or try to use the commit root
> when we can. Luckily, it seems likely that many reads are for old extents
> written many transactions ago, and that for those we *can* in fact
> search the commit root!
> 
> This change detects when we are trying to read an old extent (according
> to extent map generation) and then wires that through bio_ctrl to the
> btrfs_bio, which unfortunately isn't allocated yet when we have this
> information. When we go to lookup the csums in lookup_bio_sums we can
> check this condition on the btrfs_bio and do the commit root lookup
> accordingly.
> 
> With the fix, on that same test case, commit latencies no longer exceed
> ~400ms on my system.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - hold the commit_root_sem for the duration of the entire lookup, not
>   just per btrfs_search_slot. Note that we can't naively do the thing
>   where we release the lock every loop as that is exactly what we are
>   trying to avoid. Theoretically, we could re-grab the lock and fully
>   start over if the lock is write contended or something. I suspect the
>   rwsem fairness features will let the commit writer get it fast enough
>   anyway.

I'd rather let the locking primitives do the fairness, mutex spinning or
other optimizations, unless you'd find a good reason to add some try
locks or contention checks. But such things are hard to predict just
from the code, this depends on data, how many threads are involved.
Regrabbing could be left as an option when there is some corner case.

> 
> ---
>  fs/btrfs/bio.h       |  1 +
>  fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
>  fs/btrfs/file-item.c | 10 ++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e48612340745..159f6a4425a6 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -48,6 +48,7 @@ struct btrfs_bio {
>  			u8 *csum;
>  			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
>  			struct bvec_iter saved_iter;
> +			bool commit_root_csum;

Can you please find another way how to store this? Maybe the bio flags
have some bits free. Otherwise this adds 8 bytes to btrfs_bio, while
this structure should be optimized for size.  It's ok to use bool for
simplicity in the first versions when you're testing the locking.

