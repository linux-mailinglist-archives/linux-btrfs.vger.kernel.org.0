Return-Path: <linux-btrfs+bounces-8902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF399D432
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478811C22308
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF51AC447;
	Mon, 14 Oct 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1jb+RlwT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9lbWHF40";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1jb+RlwT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9lbWHF40"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06C175B1
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921940; cv=none; b=K1HgGfwaPPi3U5HCOT1Qv9CONwiqxmdxraq8XpZf/ZTsShVPSRgbjilnApRK4y1IiyUW7Hqed+EtmgWpt7D8Ou7kGSoLY0S0ypnpHGw+rbtt5MH73k9yXanqfYbzvoOt0CVWd4ShOGWmJLRSi4UB9hxhiNuAksAOPNu52RZqlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921940; c=relaxed/simple;
	bh=TPJR17FkPoHyD4aI/nJgGAW8kDKiT+Z4NHeEUl21JIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jICFh4lpZEP3Pimw28UstcVhiTLkhArkE71vEThKG1CCz/sJ9VLcuEsHFtev0deyQ5LXGIVeGRSVVYhzqINAqLXMzpISYZyVT8pDBFxlV5aSqRc580p60S+WrgEYbK4KMuuq0ZhhR4ILoltS+mGCEQ3IGYQ/AyJAjxZFlLaXMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1jb+RlwT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9lbWHF40; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1jb+RlwT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9lbWHF40; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8285621C78;
	Mon, 14 Oct 2024 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728921936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37Qq1ysQsHrmYseaw8jhlCLy9kklU/GUSZ9JdFY6RL0=;
	b=1jb+RlwTROmZiNDq62rt0Pu7uZjtSwfxupzIZqCzvQ7sQjoXSStBnCSiQ4MOfyzMvozIu9
	Q+oi/sxuG90//NXK8MgNVUhdQ38sMkuz8Ud+wy1bqowFjpTd3+o6X8VN0MTgFgcz7lLlJ4
	55QfsM5GCMpypJp5IGGn6S/vfzb0UQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728921936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37Qq1ysQsHrmYseaw8jhlCLy9kklU/GUSZ9JdFY6RL0=;
	b=9lbWHF40tr6DRP55aydNzLkdgeuXP7tgodWum7VitdX3pvOaayME4OC3T5wqbUgsX7YCM/
	8ddfqMFXH8NYFCDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728921936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37Qq1ysQsHrmYseaw8jhlCLy9kklU/GUSZ9JdFY6RL0=;
	b=1jb+RlwTROmZiNDq62rt0Pu7uZjtSwfxupzIZqCzvQ7sQjoXSStBnCSiQ4MOfyzMvozIu9
	Q+oi/sxuG90//NXK8MgNVUhdQ38sMkuz8Ud+wy1bqowFjpTd3+o6X8VN0MTgFgcz7lLlJ4
	55QfsM5GCMpypJp5IGGn6S/vfzb0UQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728921936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37Qq1ysQsHrmYseaw8jhlCLy9kklU/GUSZ9JdFY6RL0=;
	b=9lbWHF40tr6DRP55aydNzLkdgeuXP7tgodWum7VitdX3pvOaayME4OC3T5wqbUgsX7YCM/
	8ddfqMFXH8NYFCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6266713A51;
	Mon, 14 Oct 2024 16:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 52J2F1BBDWcsBwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Oct 2024 16:05:36 +0000
Date: Mon, 14 Oct 2024 18:05:31 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: clear force-compress on remount when compress
 mount option is given
Message-ID: <20241014160531.GE1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4d68f9e1e230dba0dfa70fb664540a962e0ae055.1728920737.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d68f9e1e230dba0dfa70fb664540a962e0ae055.1728920737.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 14, 2024 at 04:46:30PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After the migration to use fs context for processing mount options we had
> a slight change in the semantics for remounting a filesystem that was
> mounted with compress-force. Before we could clear compress-force by
> passing only "-o compress[=algo]" during a remount, but after that change
> that does not work anymore, force-compress is still present and one needs
> to pass "-o compress-force=no,compress[=algo]" to the mount command.
> 
> Example, when running on a kernel 6.8+:
> 
>   $ mount -o compress-force=zlib:9 /dev/sdi /mnt/sdi
>   $ mount | grep sdi
>   /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress-force=zlib:9,discard=async,space_cache=v2,subvolid=5,subvol=/)
> 
>   $ mount -o remount,compress=zlib:5 /mnt/sdi
>   $ mount | grep $sdi
>   /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress-force=zlib:5,discard=async,space_cache=v2,subvolid=5,subvol=/)
> 
> On a 6.7 kernel (or older):
> 
>   $ mount -o compress-force=zlib:9 /dev/sdi /mnt/sdi
>   $ mount | grep sdi
>   /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress-force=zlib:9,discard=async,space_cache=v2,subvolid=5,subvol=/)
> 
>   $ mount -o remount,compress=zlib:5 /mnt/sdi
>   $ mount | grep sdi
>   /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress=zlib:5,discard=async,space_cache=v2,subvolid=5,subvol=/)
> 
> So update btrfs_parse_param() to clear "compress-force" when "compress" is
> given, providing the same semantics as kernel 6.7 and older.
> 
> Reported-by: Roman Mamedov <rm@romanrm.net>
> Link: https://lore.kernel.org/linux-btrfs/20241014182416.13d0f8b0@nvm/
> CC: stable@vger.kernel.org # 6.8+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

