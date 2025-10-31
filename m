Return-Path: <linux-btrfs+bounces-18431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D0C230B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 03:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B26434D29C
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE56307AE1;
	Fri, 31 Oct 2025 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lb+kF1CX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXth92V5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lb+kF1CX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXth92V5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE41D6188
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878595; cv=none; b=KnpoN/azA8gCJ8PHQHsqYI0oYkcXQqDVyl8pz/GHSTxbm2Q1+5OOitTTyYK9X8l2LY/6MuqEHK2GnxoyuIh9gj8ikOH8Qdt/otQhCXj0K1PZjnx0NlsSG11ABKzeT5o9Aij1bMeRw+bwG90pbOYfrBpC7RcCsS1WxZP6xXAYOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878595; c=relaxed/simple;
	bh=cFSpEk854AwfKIMDT+zZuSOSoLAoLiSRON05BakEUc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ2DEynkLNCWgvFLIJ9jb8Gk4T0j977ATNzAGEe89D/l6bChhnhtgbTMFZYLNqG/n9ublDdpTEguNo2x3ERGj+43oI+kVwAdZMza6gXNF/Wu4H7NZNHaqxxsyOzhBjYCChtyik8YJ5mGXFzTsdwHzgTal3QJw2wM+VVuIkChQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lb+kF1CX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXth92V5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lb+kF1CX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXth92V5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 543A63369A;
	Fri, 31 Oct 2025 02:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761878588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=woUVivtPyoqNI76g98c0EyeE62na0RrSmYSAEdgqsWw=;
	b=lb+kF1CXy7do0ytkc/v/tVnuIsHRRhlMfHV5PVZgHmHJOtz4BMuyEh2HjcL02g+RKH3VY0
	/0bJqWd9OcZ1LdPMQRtDo1inLGErATH7mnWHkHzewQ3+grB28QiGKrlk6mQ0PbK3RYTcqx
	c9xZt0Ro2fnxtVtJg8lmKKKoUTNOa04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761878588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=woUVivtPyoqNI76g98c0EyeE62na0RrSmYSAEdgqsWw=;
	b=zXth92V54QRJIramBcoaDNvQtmwDqeMJskrF/rkVLQHrznnu1aDoYqtZmfav/2alafVWym
	XhXUXaN34MQvppCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761878588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=woUVivtPyoqNI76g98c0EyeE62na0RrSmYSAEdgqsWw=;
	b=lb+kF1CXy7do0ytkc/v/tVnuIsHRRhlMfHV5PVZgHmHJOtz4BMuyEh2HjcL02g+RKH3VY0
	/0bJqWd9OcZ1LdPMQRtDo1inLGErATH7mnWHkHzewQ3+grB28QiGKrlk6mQ0PbK3RYTcqx
	c9xZt0Ro2fnxtVtJg8lmKKKoUTNOa04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761878588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=woUVivtPyoqNI76g98c0EyeE62na0RrSmYSAEdgqsWw=;
	b=zXth92V54QRJIramBcoaDNvQtmwDqeMJskrF/rkVLQHrznnu1aDoYqtZmfav/2alafVWym
	XhXUXaN34MQvppCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3926213393;
	Fri, 31 Oct 2025 02:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YbdcDTwiBGkrXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 02:43:08 +0000
Date: Fri, 31 Oct 2025 03:43:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: docs: add notes about interruption to
 scrub/dev-replace
Message-ID: <20251031024303.GG13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f2e576ef61711fa84aeeee337cba5e54e0829c29.1761775676.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e576ef61711fa84aeeee337cba5e54e0829c29.1761775676.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Oct 30, 2025 at 08:37:57AM +1030, Qu Wenruo wrote:
> Since the kernel patch is queued for v6.19, add notes to scrub and
> dev-replace about the new behavior change.
> 
> For scrub it's not a huge deal as we can just resume using 'btrfs scrub
> resume' command.
> But for dev-replace one has to start from the beginning, thus it's
> recommended to disable pm during dev-replace.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

> --- a/Documentation/ch-scrub-intro.rst
> +++ b/Documentation/ch-scrub-intro.rst
> @@ -56,6 +56,14 @@ read-write mounted filesystem.
>     To avoid any writes from scrub, one has to run read-only scrub on read-only
>     filesystem.
>  
> +.. note::
> +   Scrub can be interrupted by various events after v6.19 kernel, including
> +   but not limited to power management suspension/hibernation, filesystem freezing,
> +   cgroup freezing (utilized by systemd for slice freezing) and pending signals.
> +
> +   The running scrub will be aborted after such interruption, and can be resumed
> +   by `btrfs scrub resume` command.

Commands are formatted as :command:`...`, the single backticks are used
for macros parameters, verbatim quoting is either a specific
macro or ``...`` as fallback.

