Return-Path: <linux-btrfs+bounces-11451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE16A34E8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 20:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB9A3AB111
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8389D245B1B;
	Thu, 13 Feb 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ryFoMO7E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XotlPYGq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZ3f0A5F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjD5KLKN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CE1FFC59
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475526; cv=none; b=M5yH8XeGzu+7FEfvc+s3ZcweGABoEL3ndTs4wvSCFIeeDwaD1Rq5vJM9qQvOlLE1w3OVndME9VL0L9B7nIUdycSajUtWdMR+vUXXmfV4kkPf12zafcgNqHqvqx+24Llx1/coG6KfD40ggyGN/GIsgiodma9/kJG1msueJ+iXrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475526; c=relaxed/simple;
	bh=R5R7AZGdY/pwRQTTcY6sUtN0cZ6OqfP2XEt3zl5DRSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7Hv0YADptVAAYWmJnNPgUlNZNjq8nonT2q9lVEmxvMxigF5IQ7iacZrL3go9Iy9BoHzvt+Xt/quoicfC+iyF0oTFZEuYYp6FWH0KLBIUzRrzQFDxMGMBfPtuaLchZQOVsoYxRNFwxa2BAN9Uwhz2ZIE6tywis1m7S9uz1kfl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ryFoMO7E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XotlPYGq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZ3f0A5F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjD5KLKN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD2AC1F8C2;
	Thu, 13 Feb 2025 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739475523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVmkWRuj7YvH5H0lj9oo4Ke6IXoSpsxbRILhEqV1vIk=;
	b=ryFoMO7EXllOidjW7HMMk4FgmgGFlBQOd2LQhaUDI54GJBp/hps8CF3UXanqxs5yUVHOOJ
	IS4rs1fPBPpV4j/cm/v5G7insV0txT654rjQzBxs0SItHoFLj/42bWZA4N4z5eDxSsTUux
	2hR0j6DlNfu8Ue7hi1izJ6UADHYokfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739475523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVmkWRuj7YvH5H0lj9oo4Ke6IXoSpsxbRILhEqV1vIk=;
	b=XotlPYGqBIPUHjU8oqXCkRsfkfHLtF7nHVTdQyY9dSjSNEY6qq4mYK+dGle3SLUgpyoVvJ
	i0EQ2gQnJ50Q1cCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739475521;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVmkWRuj7YvH5H0lj9oo4Ke6IXoSpsxbRILhEqV1vIk=;
	b=JZ3f0A5FLdh0806oR77WvM9RP40jrqgAEQtz4oGO4pu3Hl2bMwtQ10fjukaxHKFwCUGWO6
	gJEFnLHiE9eTyv6o4NiMycTeWRoRzLnrdTPNJ/859MaG/b1N3tcx3ljT0dBz6fuRIdBrVD
	G5ZwNNasU8tUYFw98mKIPnu0ylzpty0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739475521;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVmkWRuj7YvH5H0lj9oo4Ke6IXoSpsxbRILhEqV1vIk=;
	b=gjD5KLKNMKjslqGmCI+g5T4EesAYBIVFLWZEqXpdvjVh4VBd6qkTk2lJ5b2eMJMJtbwUsD
	CDqgbOn9PsjLVPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A36D013874;
	Thu, 13 Feb 2025 19:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 98ZFJ0FKrmeNUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Feb 2025 19:38:41 +0000
Date: Thu, 13 Feb 2025 20:38:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Boris Burkov <boris@bur.io>, Daniel Vacek <neelx@suse.com>,
	Filipe Manana <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250213193840.GC5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
 <20250127201717.GT5777@twin.jikos.cz>
 <20250129225822.GA216421@zen.localdomain>
 <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>
 <20250131193855.GA1197694@zen.localdomain>
 <4a42d804-ab7b-4734-a99f-c80ae354e93b@meta.com>
 <20250210223408.GS5777@suse.cz>
 <62d31fb6-27c7-48ba-9e0e-c9155ff5fe6f@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d31fb6-27c7-48ba-9e0e-c9155ff5fe6f@meta.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Feb 13, 2025 at 05:47:00PM +0000, Mark Harmstone wrote:
> On 10/2/25 22:34, David Sterba wrote:
> > > 
> > On Wed, Feb 05, 2025 at 03:08:59PM +0000, Mark Harmstone wrote:
> >> On 31/1/25 19:38, Boris Burkov wrote:
> >>> My understanding is that the motivation is to enable non-blocking mode
> >>> for io_uring operations, but I'll let Mark reply in detail.
> >>
> >> That's right. io_uring operates in two passes: the first in non-blocking
> >> mode, then if it receives EAGAIN again in a work thread in blocking mode.
> >>
> >> As part of my work to get btrfs receive to use io_uring, I want to add
> >> an io_uring interface for subvol creation. There's two things preventing
> >> a non-blocking version: this, and the fact we need a
> >> btrfs_try_start_transaction() (which should be relatively straightforward).
> > 
> >>>>>>> Even if we were to grab a new integer a billion
> >>>>>>> times a second, it would take 584 years to wrap around.
> >>>>>>
> >>>>>> Good to know, but I would not use that as an argument.  This may hold if
> >>>>>> you predict based on contemporary hardware. New technologies can bring
> >>>>>> an order of magnitude improvement, eg. like NVMe brought compared to SSD
> >>>>>> technology.
> >>>>>
> >>>>> I eagerly look forward to my 40GHz processor :)
> >>>>
> >>>> You never know about unexpected break-throughs. So fingers crossed.
> >>>> Though I'd be surprised.
> >>
> >> More like 40THz, and somebody finding a way to increase the speed of
> >> light... There's four or five orders of magnitude to go before 64-bit
> >> wraparound would become a problem here.
> > 
> > Thinking about the margins again, there is probably enough that we don't
> > have to care. I'd still keep the upper limit check as for any random
> > event like fuzzing, bitflips and such.
> > 
> > The use case for nonblocking io_uring makes sense and justifies the
> > optimization. As mentioned, there are other factors slowing down the
> > inode creation and number allocation so it's "fingers crossed* safe.
> 
> Thanks David. Am I okay to push this patch to for-next then?

Yes, but please send an updated version first, we need the reasoning for
the choice and that it's still safe regarding amount of time to reach
the maximum. Basically the objections and answers from this thread
summarized.

