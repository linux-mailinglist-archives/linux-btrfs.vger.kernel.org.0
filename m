Return-Path: <linux-btrfs+bounces-18931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D809C565C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 09:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5E423547B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE83314D1;
	Thu, 13 Nov 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="28UpjGxI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fCwvDxXs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="28UpjGxI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fCwvDxXs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39026ED2A
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023414; cv=none; b=N3TbHDQP4TSNX0jB/3Wg16yeic6sxZKOWrjlD4/3bwgkDaD/GE+b4h8zL0cINUaUJJlGT1FsX5rGYqFMI0JCPNgsF2VDoZwIXUG9cI+NXzSFCf4QgAqVdhmdDhD6cKFfl86SgBz9in2AuPMPIifeiCFFTtp6JTzbubkyHnSFDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023414; c=relaxed/simple;
	bh=28neeG2ErjkY0DX2FoS+VymEHWQ5p9qfY5EgIrYu6aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdhB4frDRp70wiIVZxLX5+HHmaBVM+EVqK+xyALaGCwyZmCWYWUMbGGhWqg8GIaWnZ/y9WzdGPmX13Q1wd8mgy5kJKq4x2PcG/TvmdcQEcV8ufAQOXii4CP2qrvtAsUsFwHssSgPRp0sqNHu+g4TVP+f66XqE5/z5UGlIJMa3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=28UpjGxI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fCwvDxXs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=28UpjGxI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fCwvDxXs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6819921260;
	Thu, 13 Nov 2025 08:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763023404;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDcByKmIF4iYqqE7IaQMq0mNRy+yiBe/DafPN2SOx18=;
	b=28UpjGxIHX+f1pgefQ+N7BrAqjJebN3/PdwCC19y4cAWZawvwbXzwuOb6oZutgf+e0owl2
	LkJRuoLBMuyhP/SL2G7HGrSyEux+vTdnBeFw/lJHf+cOIIQ5Uwac2MOpM2HtJKzxS9ElWM
	xaVNEyHrDcFfs/rWSMXH+TtVkZWy07g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763023404;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDcByKmIF4iYqqE7IaQMq0mNRy+yiBe/DafPN2SOx18=;
	b=fCwvDxXseE2jTZ+6cy9kg9Uy6lDfMsF9jgzmVQQoKoaS3+VzIf0nytBMRedvkUytu3C2OA
	JIW9h6Wswi3tcyAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=28UpjGxI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fCwvDxXs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763023404;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDcByKmIF4iYqqE7IaQMq0mNRy+yiBe/DafPN2SOx18=;
	b=28UpjGxIHX+f1pgefQ+N7BrAqjJebN3/PdwCC19y4cAWZawvwbXzwuOb6oZutgf+e0owl2
	LkJRuoLBMuyhP/SL2G7HGrSyEux+vTdnBeFw/lJHf+cOIIQ5Uwac2MOpM2HtJKzxS9ElWM
	xaVNEyHrDcFfs/rWSMXH+TtVkZWy07g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763023404;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDcByKmIF4iYqqE7IaQMq0mNRy+yiBe/DafPN2SOx18=;
	b=fCwvDxXseE2jTZ+6cy9kg9Uy6lDfMsF9jgzmVQQoKoaS3+VzIf0nytBMRedvkUytu3C2OA
	JIW9h6Wswi3tcyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41E6E3EA61;
	Thu, 13 Nov 2025 08:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1CHpDyyaFWl5RQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 08:43:24 +0000
Date: Thu, 13 Nov 2025 09:43:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] btrfs: simplify function protections with guards
Message-ID: <20251113084323.GG13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1762972845.git.foxido@foxido.dev>
 <c7abcfeb7e549bf5ad9861044c97b9a111d64370.1762972845.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7abcfeb7e549bf5ad9861044c97b9a111d64370.1762972845.git.foxido@foxido.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6819921260
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Nov 12, 2025 at 09:49:40PM +0300, Gladyshev Ilya wrote:
> Replaces cases like
> 
> void foo() {
>     spin_lock(&lock);
>     ... some code ...
>     spin_unlock(&lock)
> }
> 
> with
> 
> void foo() {
>     guard(spinlock)(&lock);
>     ... some code ...
> }
> 
> While it doesn't has any measurable impact,

There is impact, as Daniel mentioned elsewhere, this also adds the
variable on stack. It's measuable on the stack meter, one variable is
"nothing" but combined wherever the guards are used can add up. We don't
mind adding variables where needed, occasional cleanups and stack
reduction is done. Here it's a systematic stack use increase, not a
reason to reject the guards but still something I cannot just brush off.

> it makes clear that whole
> function body is protected under lock and removes future errors with
> additional cleanup paths.

The pattern above is the one I find problematic the most, namely in
longer functions or evolved code. Using your example as starting point
a followup change adds code outside of the locked section:

void foo() {
    spin_lock(&lock);
    ... some code ...
    spin_unlock(&lock)

    new code;
}

with

void foo() {
    guard(spinlock)(&lock);
    ... some code ...

    new code;
}

This will lead to longer critical sections or even incorrect code
regarding locking when new code must not run under lock.

The fix is to convert it to scoped locking, with indentation and code
churn to unrelated code to the new one.

Suggestions like refactoring to make minimal helpers and functions is
another unecessary churn and breaks code reading flow.

