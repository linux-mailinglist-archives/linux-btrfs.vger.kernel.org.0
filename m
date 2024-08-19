Return-Path: <linux-btrfs+bounces-7322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860D95743B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E051F244BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66091D6DB6;
	Mon, 19 Aug 2024 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rleU10g8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dB8w5Dy0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KHJ/heMu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jRthdfQM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953A175D46
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094865; cv=none; b=tc8iaCxJD6E/lncqHU9/F+bC7s6jwXrtfOSy/ESBtnLWKG70H8pdubJ7vAmzuGPB/AQTY6O7aQ64cZH1ExTtqNYxs9ysU7bjiLtPYh14UyTdt9Mwsva94R7vgi8TnshqlWv+9Y4NAkpPWMdlKOFmsHcoOPcrOwzEpLy6n8suWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094865; c=relaxed/simple;
	bh=B7jNRMmNR5AtbULreTM40HPN5cim0VjGs5RXfPmup3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhas9ANDGkvwfcy7UXRoJLrJ327CajuFbG+ynKVWWXovC8LYefGIBzg03y0FNYLmymRGTN3AlXufENMQcRhemEitc4jIySzaUJdsjzhSqOHDrQidsgCpFOKIEdE1gJdeNkB7JGhiR9ZByD9/CR6qX0SPxcaWfeZxths6KxvJAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rleU10g8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dB8w5Dy0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KHJ/heMu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jRthdfQM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4CD02246E;
	Mon, 19 Aug 2024 19:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724094861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLactVjFhoFynkihGPXjyWInIUBVCHLu2HP7cENFQCw=;
	b=rleU10g8hFlCvcrz/WTpHqz4RtVPyjqIJSWPiOkKJ5w6K+d/+fNikRhmEoQEXQUtwCZTy8
	fJqjORYAnAD7IkO3W/ojynDoAbf23NUIUw6VgjKZgQJMCS2x/3WhGQk3G/llKJLM9fnjeh
	iKUoCnmntqcb7huFwTV7vM5xDUoDyvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724094861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLactVjFhoFynkihGPXjyWInIUBVCHLu2HP7cENFQCw=;
	b=dB8w5Dy0DxDW49xd0t7fpKvFwzaeMIiU/4KbjFbBDGYFpqtM7Npbnd/xJ+wCRiociZaBnP
	6dEiVtSO5EniZ8DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724094859;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLactVjFhoFynkihGPXjyWInIUBVCHLu2HP7cENFQCw=;
	b=KHJ/heMucsdFcxWsyYROB7OK/Ab2248EfKk7aGyTSfZBlhGJgNuo4+R68GN6nMetbB4+qA
	i0s0nro3vOagIfCROcMt1QBOgqEpH9WgN18eIXPiN7O+OOx5LX5k0KQESpEV1378u26sM6
	DsmwYhbZDwRRtx+0m7I/k/MFVg1pdNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724094859;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLactVjFhoFynkihGPXjyWInIUBVCHLu2HP7cENFQCw=;
	b=jRthdfQMVVAlkfveRydLXOEBwgWAlRS+ZRySE2FIWiT3HMxsp/YF60y+82uQQud1eq5Bd4
	wZ6H3RJM1XqpO0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C30751397F;
	Mon, 19 Aug 2024 19:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4/0gL4uZw2YFWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 19 Aug 2024 19:14:19 +0000
Date: Mon, 19 Aug 2024 21:14:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the nr_ret parameter from
 __extent_writepage_io()
Message-ID: <20240819191418.GL25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <248988e6643ee3c3d07e884385f503e9d8ebbcc7.1723598419.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248988e6643ee3c3d07e884385f503e9d8ebbcc7.1723598419.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Aug 14, 2024 at 10:50:21AM +0930, Qu Wenruo wrote:
> The parameter @nr_ret is used to tell the caller how many sectors have
> been submitted for IO.
> 
> Then callers check @nr_ret value to determine if we need to manually
> clear the PAGECACHE_TAG_DIRTY, as if we submitted no sector (e.g. all
> sectors are beyond i_size) there is no folio_clear_writeback() called thus
> PAGECACHE_TAG_DIRTY tag will not be cleared.
> 
> Remove this parameter by:
> 
> - Moving the btrfs_folio_clear_writeback() call into
>   __extent_writepage_io()
>   So that if we didn't submit any IO, then manually call
>   btrfs_folio_set_writeback() to clear PAGECACHE_TAG_DIRTY when
>   the page is no longer dirty.
> 
> - Use a bool to record if we have submitted any sector
>   Instead of an int.
> 
> - Use subpage compatible helpers to end folio writeback.
>   This brings no change to the behavior, just for the sake of consistency.
> 
>   As for the call site inside __extent_writepage(), we're always called
>   for the whole page, so the existing full page helper
>   folio_(start|end)_writeback() is totally fine.
> 
>   For the call site inside extent_write_locked_range(), although we can
>   have subpage range, folio_start_writeback() will only clear
>   PAGECACHE_TAG_DIRTY if the page is no longer dirty, and the full folio
>   will still be dirty if there is any subpage dirty range.
>   Only when the last dirty subpage sector is cleared, the
>   folio_start_writeback() will clear PAGECACHE_TAG_DIRTY.
> 
>   So no matter if we call the full page or subpage helper, the result
>   is still the same, then just use the subpage helpers for consistency.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

