Return-Path: <linux-btrfs+bounces-18139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E585BFA033
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 06:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93CB1A01FF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 04:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2042D94B0;
	Wed, 22 Oct 2025 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQ5x01A0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e1kaYcY6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IW2Rabz7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5Wjnd93"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C72D8DC3
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109128; cv=none; b=qRLcd4j6ldZOD27osyBUlcNnln9MeR+kiOV43f5/6UstXQ/T8HAv0vRMWeYk/uJC3DTS7JiQOUiJm8HhbOMik1dW+cqb5ESAq6icDDuY+FwFYzlIp6ggPIMPw1iy7i0HNkGs4L42+DDjF2jNtxUIiQOKGuFE8r/ulAWjhJxNPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109128; c=relaxed/simple;
	bh=GwZRTyV3LJjRQsPSUnI6Ml7U5P2VvNEuHtlNoZ/gtM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeVvz/nqFsqXJ3gVlfv4fnWwNsTul6WnNNhsXLjbeLFM6hAvxM6MlQH3MyAUkaEKf2B9kdUV+2yO79e2QOOdOoVNnaG+iwx1XjAhbbmX4MOJVX73ziENWcJXj5wE+v/YUPM4CT1uPTO+7ehffHcvXVEqKAG2qfzxdKpZntL5QQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQ5x01A0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e1kaYcY6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IW2Rabz7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5Wjnd93; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2654E21188;
	Wed, 22 Oct 2025 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761108756;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28vbRyFSWSTK1Yy3wQjvkq43dTJO8HT7bPrC0ODAUlw=;
	b=BQ5x01A0W4+S9QFDF0bAMVQ4sKy/pTjKRrwV90DOUjHyDWFzA9tDheQ1eMDs9FBEK3aIEd
	ycqbE48UnaOiR1QMEb9HyrMdN7fNRZmQuyU1MNkArqiwTYOWOHMZHWtMWbSfa1Mp7iOlAv
	eGgNZFZuM4w9t5Xu7iI8BPMDa1INH1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761108756;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28vbRyFSWSTK1Yy3wQjvkq43dTJO8HT7bPrC0ODAUlw=;
	b=e1kaYcY6gyg8hpCHbjExOb/YO45YJqatBFbKJBpTOCRTJJsrDpEQcOp3ujLIJK1mZDQn1S
	uCzlDfs6y6w+d0Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761108752;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28vbRyFSWSTK1Yy3wQjvkq43dTJO8HT7bPrC0ODAUlw=;
	b=IW2Rabz7jPmaJSA+7YFHj9b6eHPCs/Snn0a/B4jxcBP0P8dKWxmyNnnw1ViF/64mO1WPQ5
	2+GuDjLs5ofnUh7zBbBk52Uv4A7j8Q6C5pfuB0zMqfpyU03aZHrzwQy/Wvu+RRYOQmVg+c
	q+aknZdv3J0KVSPM3xiX7wwm9zpB2AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761108752;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28vbRyFSWSTK1Yy3wQjvkq43dTJO8HT7bPrC0ODAUlw=;
	b=q5Wjnd93knCr1X9WZF0Wt0i3kE07JKKxYFzOwNLhyDWxSKCYfKwVH3fJzrfsxLx2xTJa/a
	1UdsWjdcuobWQRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0D5913995;
	Wed, 22 Oct 2025 04:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AFeGOg9j+GgJBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 04:52:31 +0000
Date: Wed, 22 Oct 2025 06:52:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc2
Message-ID: <20251022045230.GO13776@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1760633129.git.dsterba@suse.com>
 <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
 <87plaieexu.fsf@prevas.dk>
 <CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,prevas.dk:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Sun, Oct 19, 2025 at 03:17:32PM -1000, Linus Torvalds wrote:
> On Sun, 19 Oct 2025 at 11:53, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >
> > I think this has come up before [*]. Doesn't -fms-extensions allow one
> > to do
> 
> I clearly have some goldfish genes, because I had completely forgotten
> about that whole similar conversation.
> 
> Yeah, so now we've had at least two use-cases for that thing, although
> from that older discussion we'd apparently need both
> 
>   -fms-extensions
> 
> and
> 
>   -Wno-microsoft-anon-tag
> 
> to also make clang happy about it.
> 
> But yeah, if all versions of gcc and clang that we support do accept
> this thing, maybe we should just bite the bullet and do it, because
> it's just universally useful to be able to define a common helper
> structure and then use it in other structures without naming it. Kind
> of standard "inheritance" syntax, and very useful for that "I have two
> or more parts to this object".
> 
> Want to take that up and see if the btrfs people like the end result?

No objections from me. The other effect of enabling the extensions seems
to be useful wrt the other references in
https://lore.kernel.org/all/20251020142228.1819871-2-linux@rasmusvillemoes.dk/

