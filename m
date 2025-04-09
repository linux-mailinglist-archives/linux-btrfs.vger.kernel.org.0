Return-Path: <linux-btrfs+bounces-12927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF604A82EBD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB08880AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160B277814;
	Wed,  9 Apr 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wRdQYYWT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AawqQuVV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wRdQYYWT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AawqQuVV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E326A0A2
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223432; cv=none; b=YbK7c61OAO0deGpAx5sEq3WT4ohmtUJAkueNODuUEuKEPh/hnkN77rvj9jAi9yh0g419UOeltBdbfDjd1zyZQN65Hs/kKlco2+s/CARVhjuG40xrbr7VjDJLHat81ffIliRdJp9SMWIyehxDAZHLhoQoau+8oF0V30u96R8VUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223432; c=relaxed/simple;
	bh=dIw9ear7k7FgFPlObhguloGq6LYTAnDz8kwUG/XebKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0xmFPJUMWRGugVC6YvtbCRCXzyrxJp0b8fMfU7BMCTnCSWcmYaQMCdYBoiiPIo05hSifwrWA/rxkdpj4bJpSQ9KgDPc8PfNW2vC4BV7Ewau3hv8mxZF8fux9mJM49z3ZAG0NqLy0+xDC8SpkQWkVsAD0SiGsugdaQfMa57tKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wRdQYYWT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AawqQuVV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wRdQYYWT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AawqQuVV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C14C1F38D;
	Wed,  9 Apr 2025 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744223428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYv9hBv5E6oJ0N8tZcRCr+KK/kU3VloQCZgZBgu79Xg=;
	b=wRdQYYWTCh/9dO6y8l2Jgar53B9lNeKRrIOY14H7Thh4/AMQDh+7YcKvK8BMpZAmONVqdy
	lE3o8jst9H/GXGK6trlMb2WBZwF2ABbXc+R9DC3rNHKlFOl1smQ2UWJzFcBa2u20nk1wU6
	9eas3uANvYUY7B6WkltrVgQOjuxNYfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744223428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYv9hBv5E6oJ0N8tZcRCr+KK/kU3VloQCZgZBgu79Xg=;
	b=AawqQuVVXcvclxwdw7G+0yrpD0iSiTzhLFDDw2nMOB5DRCfXiDsy/ofj2H6gaklaM4TBuF
	+qpl+T6wFGCrNgBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wRdQYYWT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AawqQuVV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744223428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYv9hBv5E6oJ0N8tZcRCr+KK/kU3VloQCZgZBgu79Xg=;
	b=wRdQYYWTCh/9dO6y8l2Jgar53B9lNeKRrIOY14H7Thh4/AMQDh+7YcKvK8BMpZAmONVqdy
	lE3o8jst9H/GXGK6trlMb2WBZwF2ABbXc+R9DC3rNHKlFOl1smQ2UWJzFcBa2u20nk1wU6
	9eas3uANvYUY7B6WkltrVgQOjuxNYfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744223428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYv9hBv5E6oJ0N8tZcRCr+KK/kU3VloQCZgZBgu79Xg=;
	b=AawqQuVVXcvclxwdw7G+0yrpD0iSiTzhLFDDw2nMOB5DRCfXiDsy/ofj2H6gaklaM4TBuF
	+qpl+T6wFGCrNgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C432137AC;
	Wed,  9 Apr 2025 18:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c1thBsS89mf4HAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 09 Apr 2025 18:30:28 +0000
Date: Wed, 9 Apr 2025 20:30:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: convert to spinlock guards in
 btrfs_update_ioctl_balance_args()
Message-ID: <20250409183022.GG13292@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250409125724.145597-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409125724.145597-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3C14C1F38D
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
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 09, 2025 at 06:57:22AM -0600, Yangtao Li wrote:
> To simplify handling, use the guard helper to let the compiler care for
> unlocking.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/ioctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 63aeacc54945..7cec105a4cb0 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3438,9 +3438,8 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
>  	memcpy(&bargs->meta, &bctl->meta, sizeof(bargs->meta));
>  	memcpy(&bargs->sys, &bctl->sys, sizeof(bargs->sys));
>  
> -	spin_lock(&fs_info->balance_lock);
> +	guard(spinlock)(&fs_info->balance_lock);

Please don't do the guard() conversions in fs/btrfs/, the explicit
locking is the preferred style. If other subsystems use the scoped
locking guards then let them do it.

I personally hate it as it totally disrupts the perception of visibly
demarcated critical sections. I don't see the benefit comparing saved
lines of code vs clear and understandable code.

We rarely have a clear case for the guards, I found a few where it
could be used but then this means we have 2 styles of locking, yet
another code pattern to learn.

