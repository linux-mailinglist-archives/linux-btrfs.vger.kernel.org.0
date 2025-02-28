Return-Path: <linux-btrfs+bounces-11935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A494A4989A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 12:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7C43B9FDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8C261586;
	Fri, 28 Feb 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pnCtn6Eq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QrOcRN9T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xC37DqWs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qwmQjKt2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA635261560
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743664; cv=none; b=jL2YmOU4+2ZhDwo3NoBb0HRtRV/2+Yp6IB3vhvGsXkiaTnqM7Eld5Haagb6Q4MZVul5KndntQF2Cj9ArMzePzIgUkTT8DtMvf3ZpM0YwZXvXsU6+i/uJ6v+mSFo9bLyiHisIdvT62WbzyEM9UdvvveuGPT3BurnG6+zrZnuPiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743664; c=relaxed/simple;
	bh=qo9ZPdhKoTocPjRxCIsuqQ2U6ujnRo63n1swBCz0SfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5gJK6663E3TzBE5UUh8Pvgp3CNIg8BVx8wTVO4TKV6MT+thnu3SZL640cQiOWwfODxC0Ited15kwx2kZPMqM9OZVe8JmRgNls0cr4XsGFHSEdPcvndb8XwyXZm9QMUwHduAtpWdXw8h+IYTLqtue8kdCngLSLC+yWZexsRUNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pnCtn6Eq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QrOcRN9T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xC37DqWs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qwmQjKt2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA19E21166;
	Fri, 28 Feb 2025 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740743661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXkIZEqU4O6ZtxXcZiaXKZZOpolVx8aKF7GO4iI10xc=;
	b=pnCtn6EqHVRNqhHD8WxHKd9uHQdBFTuHCRypee28C/9fsT3Ak07hFwcf+IoldF33mNm8al
	oefFDGPgc+0IdX1J3B3IVjxsMDeggqFBA10bidcBkp6DG/pRFdTHedVm+rWJTTSkD5qQmp
	DmG18rysA8Z2gNpZeconuk7csTP9yV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740743661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXkIZEqU4O6ZtxXcZiaXKZZOpolVx8aKF7GO4iI10xc=;
	b=QrOcRN9TsIyxtajdItFKfPga9IZ4kkp8cL1FWHpE1QKTozQcXoCzPttn8OjB0RuDxMNsg/
	uZdDtTh/4oskBSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740743660;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXkIZEqU4O6ZtxXcZiaXKZZOpolVx8aKF7GO4iI10xc=;
	b=xC37DqWs/TueR4U1sKOXG/x4datFVnNA/K9IAEBBZc8T4jZ3cx6VtWx5zRWBaM2XRc4Fe5
	JmZ5J8wIbecddc+DFngLplouOzyzKvdyaZywAUd9kjc7SFjzdi0xs4bBp70ql73YegmXwj
	vMffXGFmV5uF9+ibEzohP1+EfofCWB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740743660;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXkIZEqU4O6ZtxXcZiaXKZZOpolVx8aKF7GO4iI10xc=;
	b=qwmQjKt26on1gzUeRh0Y9OR/0HudmaXljJSZZ9Oz7IIQOFiU2KT7kzu3bHQG6ELQOGpycr
	MH4g8iui0E0ZWEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F23C1344A;
	Fri, 28 Feb 2025 11:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IYOJuyjwWd4fwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 11:54:20 +0000
Date: Fri, 28 Feb 2025 12:54:15 +0100
From: David Sterba <dsterba@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Filipe Manana <fdmanana@kernel.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250228115415.GD5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <67bb1448.500a0220.af3ac.9928SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAL3q7H7ODnoeo3ac1pahD9NdujiGA=zoG79arAgrJVDUu9j7hg@mail.gmail.com>
 <20250227175221.GA1124788@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227175221.GA1124788@frogsfrogsfrogs>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Feb 27, 2025 at 09:52:21AM -0800, Darrick J. Wong wrote:
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/140.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad'  to see
> > the entire diff)
> > btrfs/141 1s ... [failed, exit status 1]- output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad)
> >     --- tests/btrfs/141.out 2024-06-04 12:18:50.084308982 +0100
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad
> 
> ...which I never saw because I don't have SCRATCH_DEV_POOL set up. :(
> 
> I traced it to this code:
> 
> 	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> 		exec $XFS_IO_PROG \
> 			-c "pread -b $size $offset $size" $file) ]]; do
> 		:
> 	done
> 
> If memory serves, btrfs' raid rotoring is based on the global pid
> number, right?  If so, then this is broken with the new run_privatens
> isolation (i.e. the commit you referenced) because the pids that the
> test program sees are private to that namespace.
> 
> IOWS, the subprocesses created in the loop test might appear to have
> pids 3 -> 4 -> 5, but those could very well be 100, 200, 300 in the
> global namespace, in which case all reads go to the same mirror
> (assuming nr_mirrors==2 as it does in btrfs/140).
> 
> A really shitty hack around that is this:
> 
> 	for ((i = 0; i < (nr_mirrors * 4); i++)); do
> 		$XFS_IO_PROG -c "pread -b $size $offset $size" $file
> 	done >> $seqres.full
> 
> but now we're just hoping that reading 8x actually manages to hit both
> mirrors at some point in this test.  But that doesn't work reliably in
> btrfs/141 even if I turn it up from 4 to 11.
> 
> Is there *any* other way to trigger read from a specific mirror?

Yes, but it's still in the experimental build. There's another
algorithm to pick the mirror based on the load so we're departing from
the pid based selection in the long run.

We can skip the tests that depend on the pids which seem to be even more
unpredictable with the namespaces. This will reduce the test coverage in
non-developer builds but the test is not something critical I guess.

