Return-Path: <linux-btrfs+bounces-5670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745AD905C16
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD01C21F20
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96B83A0D;
	Wed, 12 Jun 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5uJpJAt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5uv6eJ/5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QXtinJKz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VukKrRg2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365F3A29F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221113; cv=none; b=DySaZSuEryZhtYbsxiT9GUvZ5lw97Z5y0uqr1dpmB1jJvplnV1CKryk6+g+3GU5Rs+8MHVRkZUzxd3P5XZ52UXxeWzbsJ28cbwFu4KEEYrxI7cuX550z/a11cNo2QKsnIbWPwiXR+J1u6Mmavb5O9LTaMwf83Duf41E54HPZy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221113; c=relaxed/simple;
	bh=sjPQB5HCSyStssNGqFytAJomH4GHcT7578Q/dLPFMms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Paon1K4mYwf5ufONfTR+iG71783E57Sr5Mv2ugOt4oOeoYQbkiIBmYOtpzyoxEDSJE41tJsB1ngcgsN/f0KQqpXQMpNeLJLlNU0qkNJKPuCYI1HjGXT2msn2YIP9V1wza3EaA3wmUoq0Z1+3LPFrDNVe99mAXUgeIk5TU1YaEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5uJpJAt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5uv6eJ/5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QXtinJKz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VukKrRg2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E30A5C660;
	Wed, 12 Jun 2024 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jliwse1D5m2sQhcWw9f/UaRhzfuNyZsdpauCSgVAzqg=;
	b=a5uJpJAtN/lLe1Wrr1DJgfhQleRUcQF8TH3+pQfphn9q4p8/K3FnsQXNB6c/5SsYMRS2QS
	Z8QO5ZUWV2MKmzg5W36Sxj1PVZ2NJff/eWYipA1r8Kgsuu8tbqK/Zv93Ne9/zg4MNCLZ8u
	OjM5CTfNqjzk5lTrRgNGbLiJbaGOn8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jliwse1D5m2sQhcWw9f/UaRhzfuNyZsdpauCSgVAzqg=;
	b=5uv6eJ/5BtIQmaJmrpH9Kt5iETbZSSSl1wHvaW2fD40RX+4vA1u1HZe4KJExqgQoboRhGK
	guoSdcsWCdv8sbCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QXtinJKz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VukKrRg2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jliwse1D5m2sQhcWw9f/UaRhzfuNyZsdpauCSgVAzqg=;
	b=QXtinJKzF1SxfmEFreJ+J+XOLN8mqv3a18wB8lrD9yB5/2ZMNCfbbcS/R81QaJA+LaRg9d
	aPWmWkilpcEPXrFNy45FBGi+AAPul3xbry0H8r/H3BEKFjmSTxoS81hxzOQHMqkaJ49M/0
	L7KLL/Z2HdgSAx1d2UzB3Sk5DKqpGFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jliwse1D5m2sQhcWw9f/UaRhzfuNyZsdpauCSgVAzqg=;
	b=VukKrRg2R5R70ZPd5oPFOO/wftq0x3QeVNYojOkDLAd+7myc2qwh6k0OHSdngweRhuuG/o
	CEM+YoVQdCxO0qBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E0F9132FF;
	Wed, 12 Jun 2024 19:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A50NCzP5aWZ6HwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 19:38:27 +0000
Date: Wed, 12 Jun 2024 21:38:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: introduce new "rescue=ignoremetacsums" mount
 option
Message-ID: <20240612193821.GK18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718082585.git.wqu@suse.com>
 <f6b9b9037ee7912ed2081da9c4b05fd367c9e8f8.1718082585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b9b9037ee7912ed2081da9c4b05fd367c9e8f8.1718082585.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4E30A5C660
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jun 11, 2024 at 02:51:37PM +0930, Qu Wenruo wrote:
> This patch introduces "rescue=ignoremetacsums" to ignore metadata csums,
> meanwhile all the other metadata sanity checks are still kept as is.
> 
> This new mount option is mostly to allow the kernel to mount an
> interrupted checksum conversion (at the metadata csum overwrite stage).
> 
> And since the main part of metadata sanity checks is inside
> tree-checker, we shouldn't lose much safety, and the new mount option is
> rescue mount option it requires full read-only mount.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -367,6 +367,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
>  	u8 result[BTRFS_CSUM_SIZE];
>  	const u8 *header_csum;
>  	int ret = 0;
> +	bool ignore_csum = btrfs_test_opt(fs_info, IGNOREMETACSUMS);

const

> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c
> @@ -20,7 +20,7 @@ static const char fs_state_chars[] = {
>  	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
>  	[BTRFS_FS_STATE_DEV_REPLACING]		= 'R',
>  	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= 0,
> -	[BTRFS_FS_STATE_NO_CSUMS]		= 'C',
> +	[BTRFS_FS_STATE_NO_DATA_CSUMS]		= 'C',

There should be the status also when the metadata checksums are not
validated, the letters are arbitrary but should reflect the state if
possible, I'd suggest to use 'S' here.

What I'm missing is the sysfs.c update, all options supported by rescue
need to be listed in rescue_opts.

