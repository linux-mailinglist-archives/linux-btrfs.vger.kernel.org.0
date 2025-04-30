Return-Path: <linux-btrfs+bounces-13554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42298AA4E99
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70FA1BC25E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62B61A238A;
	Wed, 30 Apr 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qiNfLOtI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="01axy9E7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="At2Qfy5I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cvK/ethV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D682899
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023441; cv=none; b=YoHK+JAP3oX1Lzx6JaWf55SQkCuqOnMmVncH+54oucW/jnBA+Tkw1FzI8JnQWF7lgYbKm8Ldsw5jgnKU7Ajfx20bZo/4TmJIyvwc8tRA5yLpqe20sEZOJPsHqYu950/M9NC4n3glVfFBpMzJxt34HEIo1i814sXO4vSPTXgtfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023441; c=relaxed/simple;
	bh=uGCjFiJVeo1YkQDJMFzsC86YJqbsXpgEX7C6JDDJ8qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPm/yJvUDrBMhQ+JTPUJHT5kG/8phb9No9sHEQpGCs9J9G0kpbUhCt0KcjEUstkwKp9qWKIL8SnJCDoTnl3xVnxhBjkb4c5y2guPt9f+EZi9saOozIp3Hi4aPG2oTehz8guM1ahuvX1laqUeGgzQrgkCsqUuTYukxC+hfgstM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qiNfLOtI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=01axy9E7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=At2Qfy5I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cvK/ethV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E16D82125C;
	Wed, 30 Apr 2025 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746023437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEz2491Cu6S6V84/IAh5C5+Iy+cR2rieQQ0mNFSn21M=;
	b=qiNfLOtIi0fRE3rDndYVE0mJ8/+6BbQ9Tdq1Clj3NRWL8OEAaqfIlAW6atjLFsk/qY/3Uw
	VW2ZWyYHaByC+AtvYmW74cGTfZX27LHrNndnkM/FgcoFL6D/pUJJWxIsfnfG43VnCIMxnl
	ZSx6YUVuPCronZL6CxphCTGaSbf0TXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746023437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEz2491Cu6S6V84/IAh5C5+Iy+cR2rieQQ0mNFSn21M=;
	b=01axy9E7QslbpA0lFiJNPfQIRqoDQT3tPsEEOyom6bdFJLbDqytQL3MlQyezOfVZpe/lg2
	0NIk8ZlkPRmUPEDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746023436;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEz2491Cu6S6V84/IAh5C5+Iy+cR2rieQQ0mNFSn21M=;
	b=At2Qfy5IblQJEut4iq9Z4idv+GgLeJ4fJNYDiq55PjLt8FWeaLkiTrVxkrpoDOoBS/Is1n
	9Wf4eJwMs4F4HWEG/NHcoabepYtGlBFJWQ8lTFwGoNY+pGA4xqwvS8iIk0r+ujrnGyK19c
	SlJi+ZY8U8uUbRg8kpaH5rqZlmf9geM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746023436;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEz2491Cu6S6V84/IAh5C5+Iy+cR2rieQQ0mNFSn21M=;
	b=cvK/ethVURXYP2BDpvBHh8K2LDpge7Ry1SnZFkhNuZGw3uQ623qMpmQFaHTaywlXrvKQgN
	Eq9QyMxUPX+f6OAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7505139E7;
	Wed, 30 Apr 2025 14:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sh6FLAw0Emg+CwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Apr 2025 14:30:36 +0000
Date: Wed, 30 Apr 2025 16:30:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: enable experimental large data folio support
Message-ID: <20250430143035.GJ9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <676154e5415d8d15499fb8c02b0eabbb1c6cef26.1745403878.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676154e5415d8d15499fb8c02b0eabbb1c6cef26.1745403878.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 23, 2025 at 07:54:42PM +0930, Qu Wenruo wrote:
> With all the preparation patches already merged, it's pretty easy to
> enable large data folios:
> 
> - Remove the ASSERT() on folio size in btrfs_end_repair_bio()
> 
> - Add a helper to properly set the max folio order
>   Currently due to several call sites are fetching the bitmap content
>   directly into an unsigned long, we can only support BITS_PER_LONG
>   blocks for each bitmap.
> 
> - Call the helper when reading/creating an inode
> 
> The support has the following limits:
> 
> - No large folios for data reloc inode
>   The relocation code still requires page sized folio.
>   But it's not that hot nor common compared to regular buffered ios.
> 
>   Will be improved in the future.
> 
> - Requires CONFIG_BTRFS_EXPERIMENTAL
> 
> Unfortunately I do not have a physical machine for performance test, but
> if everything goes like XFS/EXT4, it should mostly bring single digits
> percentage performance improvement in the real world.
> 
> Although I believe there are still quite some optimizations to be done,
> let's focus on testing the current large data folio support first.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This is behind the experimental build we could add it now. I'm not sure
if this would not interfere with the xarray conversion of extent
buffers, that we need to get stabilized and tested too.

We'd need to have a separate way to enable/disable the large folios when
the experimental config. A module parameter might work best and it would
be just for targeted testing, so off by default.

Alternatively we can postpone it to another development cycle and leave
it on by default (for experimental build).

