Return-Path: <linux-btrfs+bounces-12203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AAEA5CEF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 20:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCCA3BAEE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 19:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090B267B70;
	Tue, 11 Mar 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuXVHGAq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="64vG+Azm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UuXVHGAq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="64vG+Azm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248F26773E
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719808; cv=none; b=oS+rTViRVgpYTWcLQs7mMMS4THEGhMdITuH4AFr0IdAcHdCjlkPXdpVmyqxAiHmOPXDue4iJlefVSx1+TkLcLf+YdpHSj9OO0YTIBw5mUxnbK8foM4mRG3hs3k61bD95k6E6jtDD0v43S5B4fzjBc7IAMSUSFSmsWCqwAiecii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719808; c=relaxed/simple;
	bh=LMeZ0dYxXIPggpYNUf0uQxFb6W6UmsOw2MJJUeX+clw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG6rlSo6CmPYlWJKF1BTQjO8RwwSqFUcKJSDV7jLqI+CBBdRwokBXM+R1ydqMOYWbhyoKsIjKj+wTsHfMbvVubzGT/WVLdwpShEGyx/2lNGYGe2Y/8s2XaUHec5EBoFJ9o6At2Zt8y5jB4pbxpP8jRKL2MGWSDFLng6hxvzBUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuXVHGAq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=64vG+Azm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UuXVHGAq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=64vG+Azm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63D6B21182;
	Tue, 11 Mar 2025 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741719804;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6htpMg44YM94D1eDs3LC2wtiCyIhrguPN3NTDHsgvtY=;
	b=UuXVHGAqRd3QypK3Nh3u9Lww6QrIN2A3l4aQaOZR4uo5lbqUQI4UIszwx+6RLzCK4ScKRY
	6xGIFEeq4gtSxYc72vNZDJsVWMYtoAR3fnmIZJ9G6axV4+WXGaeks+OtxDm17TeSXV9GR2
	Pu2Lzlt5UaBtF03qKn53C74F3NIJjTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741719804;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6htpMg44YM94D1eDs3LC2wtiCyIhrguPN3NTDHsgvtY=;
	b=64vG+AzmgY0P2yvVp//QUdD+nDmAJDl/DHI1NiOH3Gd9V6g/kuXOPVMDPzNnuvSUI8dXoW
	qaZV6V55X4iBwTDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UuXVHGAq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=64vG+Azm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741719804;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6htpMg44YM94D1eDs3LC2wtiCyIhrguPN3NTDHsgvtY=;
	b=UuXVHGAqRd3QypK3Nh3u9Lww6QrIN2A3l4aQaOZR4uo5lbqUQI4UIszwx+6RLzCK4ScKRY
	6xGIFEeq4gtSxYc72vNZDJsVWMYtoAR3fnmIZJ9G6axV4+WXGaeks+OtxDm17TeSXV9GR2
	Pu2Lzlt5UaBtF03qKn53C74F3NIJjTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741719804;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6htpMg44YM94D1eDs3LC2wtiCyIhrguPN3NTDHsgvtY=;
	b=64vG+AzmgY0P2yvVp//QUdD+nDmAJDl/DHI1NiOH3Gd9V6g/kuXOPVMDPzNnuvSUI8dXoW
	qaZV6V55X4iBwTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 415AA132CB;
	Tue, 11 Mar 2025 19:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JNS1D/yI0Ge+LgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Mar 2025 19:03:24 +0000
Date: Tue, 11 Mar 2025 20:03:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 5/5] btrfs: codify pattern for adding block_group to
 bg_list
Message-ID: <20250311190323.GJ32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741636986.git.boris@bur.io>
 <fed44344453198ae28616293163619315cd1e6e4.1741636986.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fed44344453198ae28616293163619315cd1e6e4.1741636986.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 63D6B21182
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 10, 2025 at 01:07:05PM -0700, Boris Burkov wrote:
> Similar to mark_bg_unused and mark_bg_to_reclaim, we have a few places
> that use bg_list with refcounting, mostly for retrying failures to
> reclaim/delete unused.
> 
> These have custom logic for handling locking and refcounting the bg_list
> properly, but they actually all want to do the same thing, so pull that
> logic out into a helper. Unfortunately, mark_bg_unused does still need
> the NEW flag to avoid prematurely marking stuff unused (even if refcount
> is fine, we don't want to mess with bg creation), so it cannot use the
> new helper.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 54 +++++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e4071897c9a8..5b13e086c7a8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1455,6 +1455,31 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
>  	return ret == 0;
>  }
>  
> +/*
> + * Link the block_group to a list via bg_list.
> + *
> + * Use this rather than list_add_tail directly to ensure proper respect
> + * to locking and refcounting.
> + *
> + * @bg: the block_group to link to the list.
> + * @list: the list to link it to.
> + * Returns: true if the bg was linked with a refcount bump and false otherwise.

A minor thing, in the function comment the parameter descriptions are
below the first line. Fixed in for-next.

