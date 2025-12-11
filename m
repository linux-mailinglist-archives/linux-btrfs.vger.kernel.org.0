Return-Path: <linux-btrfs+bounces-19668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDA2CB6ECC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07B413001E1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5F3161AB;
	Thu, 11 Dec 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rXrF9IgS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ksrUwk/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rXrF9IgS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ksrUwk/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2130FC21
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478447; cv=none; b=vGUOd8G9c49EZEYYaVEcI6fCgSI+rHJEgqwbyI8EULhNidpnBSKc6Ioj/GdNr21P9D75r7Rlr0ZbHBphPnLyt1wirNkZ6ccEFMjojm/X73paIx/3GpXQHhymfGiMRLLqbWOrGqagylRhAoeq8ktAcLCAbiv2bfGBhe2E+32TUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478447; c=relaxed/simple;
	bh=ncD/mhQz6rMmw/S3cR1Kl0xHqdi84VrhFfNYQxREzPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsUQlGEpADXgR+jw/Xzqpw8GqMm1MSGLhnibXmVQHn3lXNejw4DbfrEKp81NBlqS010RR2GdTa9p71zmMf4y/3LGtnFvPxNkY7TksQ1jTnTVGBQSpx/u8Vn2LWGuc2qo7NAXZSM/3fJ0ozSpA8s37ffsAaFP0XeK5RELsUtqijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rXrF9IgS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ksrUwk/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rXrF9IgS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ksrUwk/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F11E33736;
	Thu, 11 Dec 2025 18:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765478444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeNiR3EQ7EWYupXIEkPtBVboBBiUwXQE7o9BREGnhaY=;
	b=rXrF9IgSKbMoPkVu+Ft/HOp4QnHU2Vk4pKHPrB+yNh/1of3d5ExgfHlRI3rPR73B6otZGJ
	NhO6iZQgG5K/Rl/HEWSvNg4awJOiMaoDLAqvTRNRYFRZK895GRIjMtVg+9CjZLRT/ci9I0
	7NEe26t/RJAoFVLjobBtgnx00IQTB7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765478444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeNiR3EQ7EWYupXIEkPtBVboBBiUwXQE7o9BREGnhaY=;
	b=3ksrUwk/V2YCeLAjb18jMwJ0mR+fdi3Zx3K87fvBeXTNxeUSpRR+Kj7aLc2HSmK837YKZs
	CnknrWp6ECFLu3Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765478444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeNiR3EQ7EWYupXIEkPtBVboBBiUwXQE7o9BREGnhaY=;
	b=rXrF9IgSKbMoPkVu+Ft/HOp4QnHU2Vk4pKHPrB+yNh/1of3d5ExgfHlRI3rPR73B6otZGJ
	NhO6iZQgG5K/Rl/HEWSvNg4awJOiMaoDLAqvTRNRYFRZK895GRIjMtVg+9CjZLRT/ci9I0
	7NEe26t/RJAoFVLjobBtgnx00IQTB7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765478444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeNiR3EQ7EWYupXIEkPtBVboBBiUwXQE7o9BREGnhaY=;
	b=3ksrUwk/V2YCeLAjb18jMwJ0mR+fdi3Zx3K87fvBeXTNxeUSpRR+Kj7aLc2HSmK837YKZs
	CnknrWp6ECFLu3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14D023EA63;
	Thu, 11 Dec 2025 18:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xq93BCwQO2lyJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Dec 2025 18:40:44 +0000
Date: Thu, 11 Dec 2025 19:40:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: minor cleanup related to bitmap operations
Message-ID: <20251211184034.GM4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1765354917.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765354917.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.18)[-0.888];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.98

On Wed, Dec 10, 2025 at 07:02:32PM +1030, Qu Wenruo wrote:
> This is the safer cleanup part extracted from the previous attempt:
> https://lore.kernel.org/linux-btrfs/cover.1763629982.git.wqu@suse.com/
> 
> The first patch is to concentrate the error handling of
> submit_one_sector() so we do not have two separate error handling.
> 
> The second patch is the convert for_each_set_bit() to a more efficient
> for_each_set_bitmap() so that we can benefit from functions which
> accept a range other than a single block.
> 
> Qu Wenruo (2):
>   btrfs: integrate the error handling of submit_one_sector()
>   btrfs: replace for_each_set_bit() with for_each_set_bitmap()

Reviewed-by: David Sterba <dsterba@suse.com>

