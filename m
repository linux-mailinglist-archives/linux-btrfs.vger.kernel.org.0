Return-Path: <linux-btrfs+bounces-13948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99FAB4585
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F48C467B8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F785299AB3;
	Mon, 12 May 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PRufWLCA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pqupywgq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PRufWLCA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pqupywgq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7C299A97
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747082133; cv=none; b=RYzg7uZihwTMNaagubiQIma1+g6ogshWUYcDZ56EfaOSeexo8yKiEYgh3TO7fluGPBr6np06mk0nTsCY8BoALQIx/B5EuT7Zyw9HscN60BjcNLCP/K6jqj+jvxLzOaIWn6yPUM14e+bBkis73Hkvu/CFikYM1rp+ewlNrmRVRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747082133; c=relaxed/simple;
	bh=NJ7pdE+kbjGiQMMf6k/sFNF46Wp3Fc4/Ua1VoNcWEgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeVtRIWJ9t7oeix5yPiWOYRyUZE2tlztCne8/DGzPF8lxYzMv0wGtlglkQ3KM6dDa6kr7ABkP9U1+bN5MyHdeP0mp08sVt91nuzJsV8uQRZ5mQzlu1qyWbgMqwnfTVR9hZxxk8dNoWKOu4QDhW9MZtYF1i8X2o2sTYZNFcHyNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PRufWLCA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pqupywgq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PRufWLCA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pqupywgq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6159921184;
	Mon, 12 May 2025 20:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747082130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewSN+1jSoOob9HvDLLzfCahYMjY3+oKsW8FyFS3m08o=;
	b=PRufWLCARIAeop3eWD8zxqctNLwF2v42QbGs6isFFk8MHZAlXqZk6k3PN5KZMxTzbMo3Re
	wftjQ5/qjR1WWHTaq6tLHFgtyP6esdOOMGlp6XjNHXhnoOVZfe6dnU8fhua0oz0mv/UxFz
	NJW2SmukAxesJQtsvKTlf6T2SfagBv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747082130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewSN+1jSoOob9HvDLLzfCahYMjY3+oKsW8FyFS3m08o=;
	b=PqupywgqEz76yvTKwH3xSEHiE2t1WY+ByqXrB3tQCwMyw+yb5RPLY98zaXeErlmsQNIYU7
	noTkktG3nHEjiRDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747082130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewSN+1jSoOob9HvDLLzfCahYMjY3+oKsW8FyFS3m08o=;
	b=PRufWLCARIAeop3eWD8zxqctNLwF2v42QbGs6isFFk8MHZAlXqZk6k3PN5KZMxTzbMo3Re
	wftjQ5/qjR1WWHTaq6tLHFgtyP6esdOOMGlp6XjNHXhnoOVZfe6dnU8fhua0oz0mv/UxFz
	NJW2SmukAxesJQtsvKTlf6T2SfagBv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747082130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewSN+1jSoOob9HvDLLzfCahYMjY3+oKsW8FyFS3m08o=;
	b=PqupywgqEz76yvTKwH3xSEHiE2t1WY+ByqXrB3tQCwMyw+yb5RPLY98zaXeErlmsQNIYU7
	noTkktG3nHEjiRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 403C51397F;
	Mon, 12 May 2025 20:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lVxD5JbImgrKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 20:35:30 +0000
Date: Mon, 12 May 2025 22:35:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fdmanana@kernel.org
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
Message-ID: <20250512203525.GY9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
 <20250512145939.GL9140@twin.jikos.cz>
 <CAPjX3Ff+XrWHJq_cBPUaK5memR3eMh-xpCeR7rk3uOa3yPE8Mg@mail.gmail.com>
 <20250512155256.GM9140@twin.jikos.cz>
 <20250512160909.GN9140@twin.jikos.cz>
 <CAPjX3Fdzs3K739Tpu4JGJO8MCjStp_ndNAjKjBq1weOH2Jcq1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Fdzs3K739Tpu4JGJO8MCjStp_ndNAjKjBq1weOH2Jcq1w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00

On Mon, May 12, 2025 at 07:14:04PM +0200, Daniel Vacek wrote:
> > Also this makes num_extent_folios() a bit dangerous when the eb->folios
> > change in the loop, not what I expected when the __pure attribute was
> > added. In case this introdues more subtle bugs we'll probably have to
> > revert it.
> 
> Yeah, the stack savings actually show the compiler does not cache the
> value implicitly on it's own and rather it's being re-fetched from the
> eb object each time.
> 
> If I understand correctly, you may have rather wanted the const
> function attribute and not the pure one. That could possibly work,
> though I'm not sure how portable that is [1].
> Pure means it has no side-effects, ie. it does not modify any memory
> like global variables or the object given by a pointer argument (in a
> sense the arg is struct foo const*).
> It is described similarly to const attribute but: "However, the caller
> may safely change the contents of the array between successive calls
> to the function (doing so disables the optimization)." [2]
> So any changes to the eb in the loop block effectively cancel the pure
> effect. Which is what we see here.

The __const would work and would be safe wrt changes to the eb->folios,
but as said it also disables the optimization, effectively calling the
function each time (and folio_order()).

An idea:

  for (int i = 0, max = num_extent_folios(); i < max; i++)

instead of the local variable. This still relies on valid eb->folios[0]
in case there are mixed NULL and valid pointers but I guess this is
either rare or completely wrong (in which case this could be verified by
assertion).

