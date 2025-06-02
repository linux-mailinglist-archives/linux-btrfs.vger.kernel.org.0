Return-Path: <linux-btrfs+bounces-14393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A992DACBB06
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 20:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDF163B00
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4247080E;
	Mon,  2 Jun 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqhMbZVd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wyT6WL2B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqhMbZVd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wyT6WL2B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1A211C
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888257; cv=none; b=OENogB6cAS9jvfWdOKB6UhZXXE8kdxtgrXyBohZn1Prt1mPihxjJfHwIsEzyjs14QHU43DfAwpNiRIrs0RnFzI2lkxJNa/7552XU4SR/2Tn48BJdin0TPaimnYt+EECH2f0IgKNfb3dXQTNUkPt5Pp8quK34HpcuqAo0Q0f1Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888257; c=relaxed/simple;
	bh=KZ6PZu/YqkyaIurw/lnXnBu9CJk+OsiM/uVNariVODA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEOY+fO0GXDS+u08zasyVLsD9RIe+f2JiQyb9kQkQLjmSHioiWPda5CmNFmUvKWG4n/wzMnfRaPvkvIf7J4ttx20OiKWDloWdJHC6OSJCfzaD3bperKA1fHpgse+5W9gBKjscOuemmrky3sr7l4npW7HsEixaDtXuunnavQukwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqhMbZVd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wyT6WL2B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqhMbZVd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wyT6WL2B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44EB61F799;
	Mon,  2 Jun 2025 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748888254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrwqvzmkyFMsVBS1VjVEBj4x7Zrhba4KrKNEkCMHsIE=;
	b=rqhMbZVdXJA+rCjiyOWUVlakjWnBlDQvNbGul3GcMvc22ks3kyRvVwrXK0PHDlBOtQl6DK
	n7Mh6v3Oklfvd5H5DkkYDj3wpHv7QiUb1rCUw5TsfUmQRmT9Zsmx0WpFZDRmyX2kU8ausm
	uX9OVFbfN3rCIOeNr5AyZBGMp30O2+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748888254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrwqvzmkyFMsVBS1VjVEBj4x7Zrhba4KrKNEkCMHsIE=;
	b=wyT6WL2B6nr7M2/bJyh68HvOdqAxG2x2g3ppup7p11jj8UtojGNsQjM+OAw1depR3o5lQk
	JX6Y5mG5NxDsZpDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748888254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrwqvzmkyFMsVBS1VjVEBj4x7Zrhba4KrKNEkCMHsIE=;
	b=rqhMbZVdXJA+rCjiyOWUVlakjWnBlDQvNbGul3GcMvc22ks3kyRvVwrXK0PHDlBOtQl6DK
	n7Mh6v3Oklfvd5H5DkkYDj3wpHv7QiUb1rCUw5TsfUmQRmT9Zsmx0WpFZDRmyX2kU8ausm
	uX9OVFbfN3rCIOeNr5AyZBGMp30O2+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748888254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrwqvzmkyFMsVBS1VjVEBj4x7Zrhba4KrKNEkCMHsIE=;
	b=wyT6WL2B6nr7M2/bJyh68HvOdqAxG2x2g3ppup7p11jj8UtojGNsQjM+OAw1depR3o5lQk
	JX6Y5mG5NxDsZpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27968136C7;
	Mon,  2 Jun 2025 18:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JS79CL7qPWhvMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Jun 2025 18:17:34 +0000
Date: Mon, 2 Jun 2025 20:17:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: rename btrfs_subpage structure
Message-ID: <20250602181728.GG4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748824641.git.wqu@suse.com>
 <6b4186ddd82e23e4bb30b8736a9f1cde8ba1a0d5.1748824641.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4186ddd82e23e4bb30b8736a9f1cde8ba1a0d5.1748824641.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Jun 02, 2025 at 10:08:53AM +0930, Qu Wenruo wrote:
> With the incoming large data folios support, the structure name
> btrfs_subpage is no longer correct, as for we can have multiple blocks
> inside a large folio, and the block size is still page size.
> 
> So to follow the schema of iomap, rename btrfs_subpage to
> btrfs_folio_state, along with involved enums.
> 
> There are still exported functions with "btrfs_subpage_" prefix, and I
> believe for metadata the name "subpage" will stay forever as we will
> never allocate a folio larger than nodesize anyway.
> 
> The full cleanup of the word "subpage" will happen in much smaller steps
> in the future.

That's a good plan. We still have some mentions of 'page' in the context
of folios too, so we'll be clening that up for some time.

