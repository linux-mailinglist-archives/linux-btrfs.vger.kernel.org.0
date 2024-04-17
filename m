Return-Path: <linux-btrfs+bounces-4385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 773198A8E54
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 23:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A186B1C20C0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 21:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81C84D3F;
	Wed, 17 Apr 2024 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dOIkyQ96";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/QAY5Ze6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dOIkyQ96";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/QAY5Ze6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039C171A1
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390695; cv=none; b=CV+iLpkQwnaW8g1SiNuZK1LkyK45bTwrOIqHoK5dobm6LbzDjRyPQK4t9/F2hUvd6GI8u49/cwZnE6FmRI0Zo9b1dQL0vaMy0FBIYds9eTxFl+nkyBNI1J0uOUIfmwqIMQqARsi7EkJcEnaGRLZ+Tm+uQLNld4KoaC+e6LaFaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390695; c=relaxed/simple;
	bh=/Lowb2lSU/0JtuGJBqTkqSvE0LXMaf6S77J+Mc5a8Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca0wLTd7i6zn/OWjI+RSZhTpxhiSGeS1Jdc8QNY/00G3aoexJ/QsPyujewBth0yj0Jk6QMIFQUMSm77QRYl12oGuoxMEOqHyg7Jfv2XtlegJ6BqbhIhCm5awFMyRCWeCv522F4yjSBMVvwosNNn0KuTmx4oNJDLPz9nIg83lTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dOIkyQ96; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/QAY5Ze6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dOIkyQ96; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/QAY5Ze6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F25B5BD3B;
	Wed, 17 Apr 2024 21:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713390691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg71Wuegb1n/foB6UirlRzfj1UDTHZtXybxQ71PbLFE=;
	b=dOIkyQ96vGdIqSTtSgFn+e93wTVWLAWhjA4fOR7w/ZYWCXFf8kZDmZNaPe5fNLitLDVDuH
	yrAVy3fYmTBBAfxeesdeuoBvtsJVPTXFlWTOxqLXgTjUJCovOcs0bYP9pD5wy/hIRxB/gO
	ovCCl132XwOcE2GzUZaDCVL4/PfH760=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713390691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg71Wuegb1n/foB6UirlRzfj1UDTHZtXybxQ71PbLFE=;
	b=/QAY5Ze6uI5ug16Kldz1pBEIIvuMbOtZR+wu7AV7A32z38ATKLJJiEb9QM9Ass4VMfOCgn
	fSwsV/Wb62rkDkAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713390691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg71Wuegb1n/foB6UirlRzfj1UDTHZtXybxQ71PbLFE=;
	b=dOIkyQ96vGdIqSTtSgFn+e93wTVWLAWhjA4fOR7w/ZYWCXFf8kZDmZNaPe5fNLitLDVDuH
	yrAVy3fYmTBBAfxeesdeuoBvtsJVPTXFlWTOxqLXgTjUJCovOcs0bYP9pD5wy/hIRxB/gO
	ovCCl132XwOcE2GzUZaDCVL4/PfH760=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713390691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg71Wuegb1n/foB6UirlRzfj1UDTHZtXybxQ71PbLFE=;
	b=/QAY5Ze6uI5ug16Kldz1pBEIIvuMbOtZR+wu7AV7A32z38ATKLJJiEb9QM9Ass4VMfOCgn
	fSwsV/Wb62rkDkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8207C13957;
	Wed, 17 Apr 2024 21:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6oiIH2NEIGadYQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 17 Apr 2024 21:51:31 +0000
Date: Wed, 17 Apr 2024 23:44:01 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: cleanups and improvements around extent map
 release
Message-ID: <20240417214401.GV3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713302470.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713302470.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.98
X-Spam-Flag: NO

On Wed, Apr 17, 2024 at 12:03:30PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These make the folio release path release extent maps more often when they
> are not needed, as well as some cleanups. More details in the change logs.
> 
> Filipe Manana (5):
>   btrfs: rename some variables at try_release_extent_mapping()
>   btrfs: use btrfs_get_fs_generation() at try_release_extent_mapping()
>   btrfs: remove i_size restriction at try_release_extent_mapping()
>   btrfs: be better releasing extent maps at try_release_extent_mapping()
>   btrfs: make try_release_extent_mapping() return a bool

Reviewed-by: David Sterba <dsterba@suse.com>

