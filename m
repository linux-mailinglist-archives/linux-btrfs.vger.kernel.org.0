Return-Path: <linux-btrfs+bounces-18795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B2C3F872
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CC624F104E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265DA303A2B;
	Fri,  7 Nov 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPGQdA5n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7WtihUZt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aPGQdA5n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7WtihUZt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA41CBEB9
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511899; cv=none; b=FI+xJh4kvKoo44lM4o8GcibSV5sMp/fYXyVi7s/OHbCMbjJMvu3xXTYWnM4MJk+poZ4GEbLpAbfYvMVJmn1rEEgCoV1k3/YraA22gSRfPPaN/6Zz1MKF0WVaR6QLOJGz/if9dUbNGzfAZ7rt1cZQpuz8pKy98vUINcx4UZClqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511899; c=relaxed/simple;
	bh=owb3tAQaMraJQp1Xr+/l1XKmUJ2IwC3FPPmyrLfoxkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilbps2c4z18gjmMVGbna+6gsbpVoQ1vxUzzEW9PHznzI0r60c+4Lid6VQmPrnKBXK4cEgX52krmrgp/dqiqmirljnKwWHHxyCaPYjnhP0/QNbwuUVLAPyMlKhnwvhnUhejpvA7r1HCd/Z0ea3xral+8aPXgHrAFV/IRllRtJgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aPGQdA5n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7WtihUZt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aPGQdA5n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7WtihUZt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D9C21F750;
	Fri,  7 Nov 2025 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762511889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGYcZhSQEOY9j7BYALJjvYH99iYO5KY+dQNmT5uF4fA=;
	b=aPGQdA5nqhQ53cKjT7chPbS1ksv0bB8UwG4FmCygRjwBUm5oAjrJAyEZpX2zzIdvlpLhSL
	I7lTDSNtr8F9f2z5ezutPxIneSSJy3B/gA7Ymsy/c62E6g4XWnPkrIi8ulT71UdZiTXgOz
	r+T6Qk1mJDrDEd5TQLYALfMDF1B4NmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762511889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGYcZhSQEOY9j7BYALJjvYH99iYO5KY+dQNmT5uF4fA=;
	b=7WtihUZtN6SzaMDsdRQ12W0MJK6ZcNKODalPTG09IJUNlt3JVN3AwUdQMVdRijFQKDI1TM
	7DWisfEprKlcmkCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aPGQdA5n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7WtihUZt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762511889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGYcZhSQEOY9j7BYALJjvYH99iYO5KY+dQNmT5uF4fA=;
	b=aPGQdA5nqhQ53cKjT7chPbS1ksv0bB8UwG4FmCygRjwBUm5oAjrJAyEZpX2zzIdvlpLhSL
	I7lTDSNtr8F9f2z5ezutPxIneSSJy3B/gA7Ymsy/c62E6g4XWnPkrIi8ulT71UdZiTXgOz
	r+T6Qk1mJDrDEd5TQLYALfMDF1B4NmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762511889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGYcZhSQEOY9j7BYALJjvYH99iYO5KY+dQNmT5uF4fA=;
	b=7WtihUZtN6SzaMDsdRQ12W0MJK6ZcNKODalPTG09IJUNlt3JVN3AwUdQMVdRijFQKDI1TM
	7DWisfEprKlcmkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61738132DD;
	Fri,  7 Nov 2025 10:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N5eYFxHMDWnBSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 07 Nov 2025 10:38:09 +0000
Date: Fri, 7 Nov 2025 11:38:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: use guard for btrfs_folio_state::lock
Message-ID: <20251107103804.GX13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <58baf1fc6d077aacc5db3b2bf42677fc3fbbb6a8.1762503411.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58baf1fc6d077aacc5db3b2bf42677fc3fbbb6a8.1762503411.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7D9C21F750
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Nov 07, 2025 at 06:47:03PM +1030, Qu Wenruo wrote:
> Most call sites are fine for a simple guard(), some call sites need
> scoped_guard().
> 
> For the scoped_guard() usage, it increase one indent for the code,
> personally speaking I like the extra indent to make the critical section
> more obvious, but I also understand not all call site can afford the
> extra indent.
> 
> Thankfully for subpage cases, it's completely fine.
> 
> Overall this makes code much shorter, and we can return without
> bothering manually unlocking, saving several temporary variables.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> We're still not yet determined if we should brace the new auto-cleanup
> scheme.
> 
> Now I'm completely on the boat of the scoped based auto-cleanup, even
> for the subpage code where the lock is already super straightforward.
> For more complex cases the benefit will be more obvious.
> 
> So far the only disadvantage is my old mindset, but I believe time will
> get it fixed.

I still don't like the guarded locks but maybe I can get used to it as
well. I don't think it' s mindset but rather years of pattern
recognition and learned quick code skimming that will be hurt, this can
get fixed by practice.

In your patch serving as an example I see potential problem with the use
of the pattern "guard() until the end of the function". Adding more code
after the guard will automatically add it to the locked section, with
explicit unlock it would be clear where's the boundary.

The scoped_lock() is closer to that pattern. What could happen is
switching from guard to scoped guard once code needs to be appended
outside of the locked section. This brings the unnecessary indentation
and future merge conflicts.

