Return-Path: <linux-btrfs+bounces-19146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE22DC6E9DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 52A562E021
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470D03612C5;
	Wed, 19 Nov 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1p5aJZDT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="678Eka+c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1p5aJZDT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="678Eka+c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0135FF7D
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556580; cv=none; b=ooXsBOoNjwRqV5560vBoMkSrPHiA59vjHs+DScsJk6wrBmhAZfPisuWq22/Vk1gh1/faXLQT9E4SePtkPYJkmmcBG1mghEvdWqGIwWCZwrvIt/yBXAIHMNijdiKUdsLIZL8lCPOTRjGW7iBe4gCPGhyIjhK6cey0vMl6unDjqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556580; c=relaxed/simple;
	bh=LnrT4S2LGOCSZgcyFtJSnMDe2XYbrXCGVue5h0wkiOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYf0qEuyDo1wsBcevqycN6iJi0fCtAHkvqjk1O7HUO3i4uXuRX1wz+yVlcflsuozbZ7VF65jPR/yFAV7IDDas4NQvRpqqNvTLVZtiwhbGHvZhwJQwtyOOGZxoEsDXipYxgE5db6J3pHwvJTUeF3BnTfKcqCy6B/mJd3f4RRWE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1p5aJZDT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=678Eka+c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1p5aJZDT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=678Eka+c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAC8F2121A;
	Wed, 19 Nov 2025 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763556576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2JpK0+/pZ8BzJwDoccOXVkgQIxa0bH1YUWk1K+yKA=;
	b=1p5aJZDTnjSOk5z8SVc3BszkQTFLf1jerNINLFzRv1xJFy1+PABK617c7ZTRvXafLEzpUB
	0ko18upmExN4CejgPFKAD+9PyNW9Uv0w9ipnyQ3irMjBa20n8+1aVlKBb8e5ylt4y8bkuy
	dMCaDMjKPpb1RxxCLOAsXwRqKGWFJB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763556576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2JpK0+/pZ8BzJwDoccOXVkgQIxa0bH1YUWk1K+yKA=;
	b=678Eka+csveIFYRFsM6PwnMbjRIqFNsK3jmWDh9xJ64JkLQ3oiRqxVnofAJMWqjTcbb1vj
	ikNwqWrH4rKuCQCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763556576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2JpK0+/pZ8BzJwDoccOXVkgQIxa0bH1YUWk1K+yKA=;
	b=1p5aJZDTnjSOk5z8SVc3BszkQTFLf1jerNINLFzRv1xJFy1+PABK617c7ZTRvXafLEzpUB
	0ko18upmExN4CejgPFKAD+9PyNW9Uv0w9ipnyQ3irMjBa20n8+1aVlKBb8e5ylt4y8bkuy
	dMCaDMjKPpb1RxxCLOAsXwRqKGWFJB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763556576;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2JpK0+/pZ8BzJwDoccOXVkgQIxa0bH1YUWk1K+yKA=;
	b=678Eka+csveIFYRFsM6PwnMbjRIqFNsK3jmWDh9xJ64JkLQ3oiRqxVnofAJMWqjTcbb1vj
	ikNwqWrH4rKuCQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FBB53EA61;
	Wed, 19 Nov 2025 12:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3zTNJuC8HWn/EgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Nov 2025 12:49:36 +0000
Date: Wed, 19 Nov 2025 13:49:31 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] btrfs: move inode_to_path higher in backref.c
Message-ID: <20251119124931.GH13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251118160845.3006733-1-neelx@suse.com>
 <20251118160845.3006733-6-neelx@suse.com>
 <CAL3q7H5AVVyeNxdXPJyGM9ys7WLncTWnwAciuEtThbWpzZGe2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5AVVyeNxdXPJyGM9ys7WLncTWnwAciuEtThbWpzZGe2Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[twin.jikos.cz:mid,suse.com:email,btrfs.readthedocs.io:url,imap1.dmz-prg2.suse.org:helo,toxicpanda.com:email,suse.cz:replyto];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,toxicpanda.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Nov 19, 2025 at 12:21:52PM +0000, Filipe Manana wrote:
> On Tue, Nov 18, 2025 at 4:16 PM Daniel Vacek <neelx@suse.com> wrote:
> >
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We have a prototype and then the definition lower below, we don't need
> > to do this, simply move the function to where the prototype is.
> 
> According to our development notes here:
> 
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html
> 
> Under the "Function declarations" section we have:
> 
> "avoid prototypes for static functions, order them in new code in a
> way that does not need it
> 
> but don’t move static functions just to get rid of the prototype"
> 
> So what's the motivation for moving the function?

Right, I thought the other fscrypt patches needed that for some reason
but after checking again they don't, I'll drop the patch. Thanks.

