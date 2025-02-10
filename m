Return-Path: <linux-btrfs+bounces-11367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C9A2FD2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 23:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670B9168AB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7D25334A;
	Mon, 10 Feb 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TERmrjl9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VduTJSKC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TERmrjl9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VduTJSKC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA7250BEF
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226854; cv=none; b=Z+D4xlSjzUpmqdRfKrgMlizTOuvL8dowwyg/lflPVq+Lc+t+AfDzTnoYKCLP99y6hZel0eInolA2Ahza9Y8ppjOCKkQleQePgJ4WBT2KUHo2353ZOAAIVnOwHEsPhgz63KtVUrKrQ5tRW396nph07v/qgmHEjTXjQTWYMCGLqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226854; c=relaxed/simple;
	bh=qFk0Ni+F6hL1lSgz138DfK2KwzPntnOS7XiwLg9wew4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt8MdvB7s0S6tP+BjWvY/KSf3hR5MAno7lRRyIlf/GgM1MLgEUQtUvn0yDby623Hj4CE5r+QuAzfepJCOq5Vk3tU/j3yMIjCdSww+qV9Va92ry6mqMdkezUG7Pf88xkVrMo9qNh58gV94QNSRwUvwAuTSwSUj+xQ2xxIBDjffzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TERmrjl9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VduTJSKC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TERmrjl9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VduTJSKC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0490121137;
	Mon, 10 Feb 2025 22:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739226850;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwN0MODN5OZtnmq8YtZc7BAe2FTAhSRJZrl2+XvnjsM=;
	b=TERmrjl9aWKILN+t4AnRUFyL7BDnxIImPI31LnmG13WfSMFOQZIvh//JDS3MhAw6Pss8D3
	3HzEX551Y4ugazU6DA42kydvlPugPy+T11KSAe4QG/39fjgczppqpF2JGs/UjZvC8EZjM/
	EEhoYv0q0IvbRXzU9gfXeOQhR9X1HSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739226850;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwN0MODN5OZtnmq8YtZc7BAe2FTAhSRJZrl2+XvnjsM=;
	b=VduTJSKCbXCOYXVGKnaDbpaBEW4MVs2ZXrc4mSK9DJOzNQH3EdKh4cYzt3dPvIhP2XF5Eo
	J43jS3eahMhex7AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739226850;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwN0MODN5OZtnmq8YtZc7BAe2FTAhSRJZrl2+XvnjsM=;
	b=TERmrjl9aWKILN+t4AnRUFyL7BDnxIImPI31LnmG13WfSMFOQZIvh//JDS3MhAw6Pss8D3
	3HzEX551Y4ugazU6DA42kydvlPugPy+T11KSAe4QG/39fjgczppqpF2JGs/UjZvC8EZjM/
	EEhoYv0q0IvbRXzU9gfXeOQhR9X1HSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739226850;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwN0MODN5OZtnmq8YtZc7BAe2FTAhSRJZrl2+XvnjsM=;
	b=VduTJSKCbXCOYXVGKnaDbpaBEW4MVs2ZXrc4mSK9DJOzNQH3EdKh4cYzt3dPvIhP2XF5Eo
	J43jS3eahMhex7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D92C813707;
	Mon, 10 Feb 2025 22:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rsiCNOF+qmeLNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Feb 2025 22:34:09 +0000
Date: Mon, 10 Feb 2025 23:34:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Boris Burkov <boris@bur.io>, Daniel Vacek <neelx@suse.com>,
	Filipe Manana <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250210223408.GS5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz>
 <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
 <20250127201717.GT5777@twin.jikos.cz>
 <20250129225822.GA216421@zen.localdomain>
 <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>
 <20250131193855.GA1197694@zen.localdomain>
 <4a42d804-ab7b-4734-a99f-c80ae354e93b@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a42d804-ab7b-4734-a99f-c80ae354e93b@meta.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Feb 05, 2025 at 03:08:59PM +0000, Mark Harmstone wrote:
> On 31/1/25 19:38, Boris Burkov wrote:
> > My understanding is that the motivation is to enable non-blocking mode
> > for io_uring operations, but I'll let Mark reply in detail.
> 
> That's right. io_uring operates in two passes: the first in non-blocking 
> mode, then if it receives EAGAIN again in a work thread in blocking mode.
> 
> As part of my work to get btrfs receive to use io_uring, I want to add 
> an io_uring interface for subvol creation. There's two things preventing 
> a non-blocking version: this, and the fact we need a 
> btrfs_try_start_transaction() (which should be relatively straightforward).

> >>>>> Even if we were to grab a new integer a billion
> >>>>> times a second, it would take 584 years to wrap around.
> >>>>
> >>>> Good to know, but I would not use that as an argument.  This may hold if
> >>>> you predict based on contemporary hardware. New technologies can bring
> >>>> an order of magnitude improvement, eg. like NVMe brought compared to SSD
> >>>> technology.
> >>>
> >>> I eagerly look forward to my 40GHz processor :)
> >>
> >> You never know about unexpected break-throughs. So fingers crossed.
> >> Though I'd be surprised.
> 
> More like 40THz, and somebody finding a way to increase the speed of 
> light... There's four or five orders of magnitude to go before 64-bit 
> wraparound would become a problem here.

Thinking about the margins again, there is probably enough that we don't
have to care. I'd still keep the upper limit check as for any random
event like fuzzing, bitflips and such.

The use case for nonblocking io_uring makes sense and justifies the
optimization. As mentioned, there are other factors slowing down the
inode creation and number allocation so it's "fingers crossed* safe.

