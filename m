Return-Path: <linux-btrfs+bounces-18944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63175C572BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 12:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A31A34A751
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92333B97B;
	Thu, 13 Nov 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BcchcW6n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VP0PVcRo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k+o8lrDV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QQZystZa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8B2E3AF1
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033127; cv=none; b=Sse+pNOLQy3x+gHz6HgQCWk1K9mlnhU77N14bascmOm4a8kjDTeTVQYpRrYaK8i0l5RF4Yle3gyPklVuNcGQGwQ0rseWxmXysXs7Hnne0yo8aS5bpDM8xVOTuXAPprwPxVQE5n5BT1qP2PtT+4seLTQ3NqylX6CYXB6SKodqOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033127; c=relaxed/simple;
	bh=zJ/7WXTed2yCxzIMBLp/XGM1mdmPXOap1LSnEUyoj9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmF87s43ElKWgVh0Agt08vW5S6w1roI71Fd8x2xHRIlT7uPsUuDLpgT0Iw/JJriBSLRdZKx49fVhBN+bpDgOmeX9m5CcpSUKTREr5YmC+KhyJpluEUKGtwHKvEuZekfJKBW45jTDnvh2PBFGf6A3vfkMbl+1HBP2nSYMOmsM8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BcchcW6n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VP0PVcRo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k+o8lrDV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QQZystZa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4FEA1F388;
	Thu, 13 Nov 2025 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763033124;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu353YNxBkiqRkBJ1FFBBjYCeCnToRGzdWP8jji7cmI=;
	b=BcchcW6ngCIll4+e79fZVZcbq7qp2XLUJd4GgsM9I9XZscI+hf4LyXOtZePGb9Wjw+thps
	t+ITwRU8Z458yDijyzkcUYyElYdXv+QkRasK6c+rIqGRU2JQiq7TYCIY1P+sLZdYHX+QE1
	HU9BjzhTOItkeN+t2oyq0hay2DEpBeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763033124;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu353YNxBkiqRkBJ1FFBBjYCeCnToRGzdWP8jji7cmI=;
	b=VP0PVcRo9UUs5LdM7HVhTM59KBDR72W2zP7il/irXxkWcq6TgrFMuV7YWQnrTs5YgzRt9x
	IpLE21bFolUWUGDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k+o8lrDV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QQZystZa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763033123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu353YNxBkiqRkBJ1FFBBjYCeCnToRGzdWP8jji7cmI=;
	b=k+o8lrDVRdKYxsALH94wJgfcyXwLRX5ejV3aWIaLmsH+bulmF/Czo9wwtxt4Zl6H/gqS6z
	4WyML5AFMCH3OIKA+2p/X8W0g961RV2wKrfmiPeLP7/1b5GvM5lSGC5Lg0cX5A1wtbeKv0
	ydDjSLTnkbQklP8Mtn3UNaHeTIYt0fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763033123;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu353YNxBkiqRkBJ1FFBBjYCeCnToRGzdWP8jji7cmI=;
	b=QQZystZaXjwPID5zmz40eObH8FdVMcJjS92C1qHpRF4X+F316/vPz+gBqfvZc8oux8t3Yd
	GCdjMWSzONmBNPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB3333EA61;
	Thu, 13 Nov 2025 11:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p25uMSPAFWnNaAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 11:25:23 +0000
Date: Thu, 13 Nov 2025 12:25:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: David Sterba <dsterba@suse.com>, neelx@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] btrfs: simplify function protections with guards
Message-ID: <20251113112514.GN13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1762972845.git.foxido@foxido.dev>
 <c7abcfeb7e549bf5ad9861044c97b9a111d64370.1762972845.git.foxido@foxido.dev>
 <20251113084323.GG13846@twin.jikos.cz>
 <35e1977e-7cca-4ea3-9df8-0a2b43bc0f85@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e1977e-7cca-4ea3-9df8-0a2b43bc0f85@foxido.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E4FEA1F388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Nov 13, 2025 at 01:06:42PM +0300, Gladyshev Ilya wrote:
> On 11/13/25 11:43, David Sterba wrote:
> > On Wed, Nov 12, 2025 at 09:49:40PM +0300, Gladyshev Ilya wrote:
> >> Replaces cases like
> >>
> >> void foo() {
> >>      spin_lock(&lock);
> >>      ... some code ...
> >>      spin_unlock(&lock)
> >> }
> >>
> >> with
> >>
> >> void foo() {
> >>      guard(spinlock)(&lock);
> >>      ... some code ...
> >> }
> >>
> >> While it doesn't has any measurable impact,
> > 
> > There is impact, as Daniel mentioned elsewhere, this also adds the
> > variable on stack. It's measuable on the stack meter, one variable is
> > "nothing" but combined wherever the guards are used can add up. We don't
> > mind adding variables where needed, occasional cleanups and stack
> > reduction is done. Here it's a systematic stack use increase, not a
> > reason to reject the guards but still something I cannot just brush off
> I thought it would be optimized out by the compiler in the end, I will 
> probably recheck this

There are cases where compiler will optimize it out, IIRC when the lock
is embedded in a structure, and not when the pointer is dereferenced.

> >> it makes clear that whole
> >> function body is protected under lock and removes future errors with
> >> additional cleanup paths.
> > 
> > The pattern above is the one I find problematic the most, namely in
> > longer functions or evolved code. Using your example as starting point
> > a followup change adds code outside of the locked section:
> > 
> > void foo() {
> >      spin_lock(&lock);
> >      ... some code ...
> >      spin_unlock(&lock)
> > 
> >      new code;
> > }
> > 
> > with
> > 
> > void foo() {
> >      guard(spinlock)(&lock);
> >      ... some code ...
> > 
> >      new code;
> > }
> > 
> > This will lead to longer critical sections or even incorrect code
> > regarding locking when new code must not run under lock.
> > 
> > The fix is to convert it to scoped locking, with indentation and code
> > churn to unrelated code to the new one.
> > 
> > Suggestions like refactoring to make minimal helpers and functions is
> > another unecessary churn and breaks code reading flow.
> 
> What if something like C++ unique_lock existed? So code like this would 
> be possible:
> 
> void foo() {
>    GUARD = unique_lock(&spin);
> 
>    if (a)
>      // No unlocking required -> it will be done automatically
>      return;
> 
>    unlock(GUARD);
> 
>    ... unlocked code ...
> 
>    // Guard undestands that it's unlocked and does nothing
>    return;
> }
> 
> It has similar semantics to scoped_guard [however it has weaker 
> protection -- goto from locked section can bypass `unlock` and hold lock 
> until return], but it doesn't introduce diff noise correlated with 
> indentations.
> 
> Another approach is allowing scoped_guards to have different indentation 
> codestyle to avoid indentation of internal block [like goto labels for 
> example].
> 
> However both of this approaches has their own downsides and are pure 
> proposals

Thanks, it's good to have concrete examples to discuss. It feels like
we'd switch away from C and force patterns that are maybe common in
other languages like C++ that do things under the hood and it's fine
there as it's the mental programming model one has. This feels alien to
kernel C programming, namely for locking where the "hide things" is IMO
worse than "make things explicit".

There are cases where switching to guards would be reasonable because
the functions are short and simple but then it does not utilize the
semantics of automatic cleanup. In more complex functions it would mean
to make more structural changes to the code at the cost of churn and
merge conflicts of backported patches.

