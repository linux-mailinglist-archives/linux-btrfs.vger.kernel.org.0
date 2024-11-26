Return-Path: <linux-btrfs+bounces-9914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4469D9A78
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C93281127
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46E1D63DD;
	Tue, 26 Nov 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uw3JcGtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="txW0f50f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uw3JcGtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="txW0f50f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749C1D5ADA
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635265; cv=none; b=PxP/9AtrFF+QuVEg2tc8t7TCuH/THutfSQCuHk1RUBHjoXzVpyUeVoT58bEHm/7Km2eBPi3kYMJp2Hf5sFE7qM9NeMLbNQfkxM0ifrJW1YEfgjeGkYISRTfARZGcccNlQLFgVhBjz+5kcRoqFfzSW7OPv1Mc9Lk0zheX6vebl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635265; c=relaxed/simple;
	bh=qQHBHUTx8iy2gcZzcpag6V0/ug4jElULbNtJHMIMEAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmfr2nNReFWNPzlNQeu3tW3M8ZWyzdppKfRU3kuXRFGnc7vFbHEEZJ5rm7lKt27TLezTWpXnJEYFXC8xQ/eI7OJ9akLNg2gNqx4Q6Qws6Kd8iK2EOta0nWIRZoUDPHWJm97EwJ2K4UaJ1LtV3EUZmisUsyr2gtZzyIPOz7lS77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uw3JcGtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=txW0f50f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uw3JcGtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=txW0f50f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11BFD1F74C;
	Tue, 26 Nov 2024 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732635262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htvqJQsnWykJZZmCxSpuIv5B9tObQ7mfaPuVlS7/Klg=;
	b=Uw3JcGtNOMbwHc0zFJktrB9zxRVSv33dDJZ45nIgOYASV1oaO11wm4Pjk5zfEwQyTHEhsT
	nVAZhLj4kVwqW/dQU574S+IDmDRtXPRy3XKVG1Bex0WVBDZOX6uTt3Imvbv0Gu7bNpy2cf
	9bBUCsO1sa4znRiIOT8U1IhIHAclIBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732635262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htvqJQsnWykJZZmCxSpuIv5B9tObQ7mfaPuVlS7/Klg=;
	b=txW0f50fWxgMJflWEYhmYDlim8MgL7VGDDWzTiP2sO0NaXrCuD3YDZyX3Wv7wQxOzx8iY6
	fjoXi9CTYLgMomDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732635262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htvqJQsnWykJZZmCxSpuIv5B9tObQ7mfaPuVlS7/Klg=;
	b=Uw3JcGtNOMbwHc0zFJktrB9zxRVSv33dDJZ45nIgOYASV1oaO11wm4Pjk5zfEwQyTHEhsT
	nVAZhLj4kVwqW/dQU574S+IDmDRtXPRy3XKVG1Bex0WVBDZOX6uTt3Imvbv0Gu7bNpy2cf
	9bBUCsO1sa4znRiIOT8U1IhIHAclIBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732635262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htvqJQsnWykJZZmCxSpuIv5B9tObQ7mfaPuVlS7/Klg=;
	b=txW0f50fWxgMJflWEYhmYDlim8MgL7VGDDWzTiP2sO0NaXrCuD3YDZyX3Wv7wQxOzx8iY6
	fjoXi9CTYLgMomDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0262C13890;
	Tue, 26 Nov 2024 15:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4zJhAH7qRWdrDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 15:34:22 +0000
Date: Tue, 26 Nov 2024 16:34:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add delayed ref self tests
Message-ID: <20241126153420.GG31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731614132.git.josef@toxicpanda.com>
 <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
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
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Nov 14, 2024 at 02:57:49PM -0500, Josef Bacik wrote:
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -142,6 +142,11 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
>  	fs_info->nodesize = nodesize;
>  	fs_info->sectorsize = sectorsize;
>  	fs_info->sectorsize_bits = ilog2(sectorsize);
> +
> +	/* CRC32C csum size. */
> +	fs_info->csum_size = 4;

While this is correct it would be cleaner to do btrfs_csum_type_size(BTRFS_CSUM_TYPE_CRC32)

