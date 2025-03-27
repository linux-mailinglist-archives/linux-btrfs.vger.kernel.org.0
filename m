Return-Path: <linux-btrfs+bounces-12617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA6A7374B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9743917C9AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D94218845;
	Thu, 27 Mar 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPiIuju2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRha0hIp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GX4c4SMx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/rMTKti"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518A21772D
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094038; cv=none; b=KahKyuG4/jKVygn5SJSGSVEdB2jLgRRZ976ivSYltNPNpulb1ztp/tmr7Q0AN8j478jbMUv6MCqYhkVMY5RFG3ESoUIcqXpXHnGVMrCvoScbThdqFn3pf8hKWZ+oQLDJMbOZBGLzczKhEDMqoMmgDCKw/XwELwv5N1vjWjdpp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094038; c=relaxed/simple;
	bh=DssOTLSU9TvVd/mitWvxMi9XblAqcRuLrYwM3amyqRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugpiicSYkTrRuwUfxiVmJNAZMFxmCgCkuAbDIpkzCp7zfyj3bHn/oHy3pffMK4u9ddnRTayGu+DRh0dMkuQYSgnmpRFo+LGiCfvlk6dMhOshya+YjdTZluofdA6xVbqajwKLzdufQdZmb2UFC4iKL5csydqwMWVMaQgxQ9OSILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPiIuju2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRha0hIp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GX4c4SMx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/rMTKti; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC5F41F456;
	Thu, 27 Mar 2025 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743094035;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s85Dp0ahrXbhxU0NWMAlikd1ZByabHMk7dlCf01/RTM=;
	b=zPiIuju2ZoPgocBCrn1yPByKk01stU5VYBxhhf0JDPBeyfLTRm0vGNQYa6V1YQh4um3wdr
	WPwzMTe3jmzgE4dVWT0/kZVkARDIB5KnEmEYpfb+5NwKL6hJSdY85VYrWR5XkbnBv6pRWH
	nLzk4ZS5C+ples0h6hDh16cAbCsY1co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743094035;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s85Dp0ahrXbhxU0NWMAlikd1ZByabHMk7dlCf01/RTM=;
	b=eRha0hIpbUd5IVfQ5ZUdgG0Ef8ZBaP42hseXS2yw8c99+hqv2KHqUarrs6JRaBBSO9U9cL
	oTiZ/5MaQGx45UAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743094034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s85Dp0ahrXbhxU0NWMAlikd1ZByabHMk7dlCf01/RTM=;
	b=GX4c4SMxQ7Yx7v1ZPegYJm/ECT4hwBjuNT9vg6pWHXxdRufJQugrcFhsy374fiOZkm4zrj
	9iZ5iKWerJjpGe1lGtBVKQMSU9KvMjE/3rVdEZpjEnrwC7aOtajmsjg70p4qNwGEfLp+b0
	Gl3l/+4LumFG1hjBmOVnaQQwikQ0aOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743094034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s85Dp0ahrXbhxU0NWMAlikd1ZByabHMk7dlCf01/RTM=;
	b=S/rMTKtiEzAyTfKA6OGT5zYYQPVkXKbXdP/H3rq9vPJdCRVCDQmhN8dncFR1DpeYAz3UIO
	NvYlX9DeQFVaObDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3EAF139D4;
	Thu, 27 Mar 2025 16:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9/s1MxKB5WdXDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 16:47:14 +0000
Date: Thu, 27 Mar 2025 17:47:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: refactor btrfs_buffered_write() for the
 incoming large data folios
Message-ID: <20250327164713.GV32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742443383.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742443383.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 20, 2025 at 04:04:07PM +1030, Qu Wenruo wrote:
> The function btrfs_buffered_write() is implementing all the complex
> heavy-lifting work inside a huge while () loop, which makes later large
> data folios work much harder.
> 
> The first patch is a patch that already submitted to the mailing list
> recently, but all later reworks depends on that patch, thus it is
> included in the series.
> 
> The core of the whole series is to introduce a helper function,
> copy_one_range() to do the buffer copy into one single folio.
> 
> Patch 2 is a preparation that moves the error cleanup into the main loop,
> so we do not have dedicated out-of-loop cleanup.
> 
> Patch 3 is another preparation that extract the space reservation code
> into a helper, make the final refactor patch a little more smaller.
> 
> And patch 4 is the main dish, with all the refactoring happening inside
> it.
> 
> Qu Wenruo (4):
>   btrfs: remove force_page_uptodate variable from btrfs_buffered_write()
>   btrfs: cleanup the reserved space inside the loop of
>     btrfs_buffered_write()
>   btrfs: extract the space reservation code from btrfs_buffered_write()
>   btrfs: extract the main loop of btrfs_buffered_write() into a helper

I'm looking at the committed patches in for-next and there are still too
many whitespace and formatting issues, atop those pointed out in the
mail discussion. It's probably because the code moved and inherited the
formatting but this is one of the oportunities to fix it in the final
version.

I fixed what I saw, but plase try to reformat the code according to the
best pratices. No big deal if something slips, I'd rather you focus on
the code than on formattig but in this patchset it looked like a
systematic error.

In case of factoring out code and moving it around I suggest to do it in
two steps, first move the code, make sure it's correct etc, commit, and
then open the changed code in editor in diff mode. If you're using
fugitive.vim the command ":Gdiff HEAD^" clearly shows the changed code
and doing the styling and formatting pass is quite easy.

