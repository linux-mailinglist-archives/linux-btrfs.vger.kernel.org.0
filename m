Return-Path: <linux-btrfs+bounces-17084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A074B90814
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 13:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DE53B6A12
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2AF3043B2;
	Mon, 22 Sep 2025 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wlrNzb0c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQwBBojx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wlrNzb0c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQwBBojx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D523E32D
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541883; cv=none; b=a8d7sHB18pOGd8mdxLThei2lT9wP6iQaCMn4Ax9n7WzOxvzgvHAUjkbDadOfEk1lkmOot64AXTPaeiArigi8xK8kffYCGNhHTPaCVD7Oj8tdL8ZIMIz0KEv1CkyKvWwA6mHyxNaLC/8Gs4R6Crun42Hn/C7OXuR+EpA9Q2wBb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541883; c=relaxed/simple;
	bh=HVqzwqdSI+nEWOMzaRkWrSwKGk5H7+An3NpiO9HUvTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNqZN92tCPqVq4jXQVZ347dA47zVIlRHxqm0vDhzSRt+uc0ddkwig/MbErWizto4d5BWh+yAllGu5300rvaAemzzJMHK0l8wZ1VhbPY4Oz6Iv5i66mGKvqa6klTV/b1rRfyONRyM+p37g4y6N+pRzc3LBPI0I66i/fwem9lbndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wlrNzb0c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQwBBojx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wlrNzb0c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQwBBojx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BB9621DEC;
	Mon, 22 Sep 2025 11:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758541880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5R3kuafjHsLKv1rfwx8xPxMGQDGSrHpiW11b3lkGn0=;
	b=wlrNzb0ca4yIeZS3cFREsv4IUK1fW+98zymB6lcfZlvrRB7n/mscdtNRLSSqykNaE723Yq
	6hq8JjtyTnkfUSg1PlnCAkkITMPstNNUEloNBiRaTKTdic4wvYk8z+cCOfowMqTiQPY0gY
	LmidDI4RCnjzzAFFbw6MI9VqajuZYiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758541880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5R3kuafjHsLKv1rfwx8xPxMGQDGSrHpiW11b3lkGn0=;
	b=CQwBBojxAYUFO3+rh1Nb+rr0RvmJWj96F6az9gZ5n1q++xzWsLXh9DpJoE0Cpf0SxJwGKk
	M3+0dXewH3E/8lDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wlrNzb0c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CQwBBojx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758541880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5R3kuafjHsLKv1rfwx8xPxMGQDGSrHpiW11b3lkGn0=;
	b=wlrNzb0ca4yIeZS3cFREsv4IUK1fW+98zymB6lcfZlvrRB7n/mscdtNRLSSqykNaE723Yq
	6hq8JjtyTnkfUSg1PlnCAkkITMPstNNUEloNBiRaTKTdic4wvYk8z+cCOfowMqTiQPY0gY
	LmidDI4RCnjzzAFFbw6MI9VqajuZYiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758541880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5R3kuafjHsLKv1rfwx8xPxMGQDGSrHpiW11b3lkGn0=;
	b=CQwBBojxAYUFO3+rh1Nb+rr0RvmJWj96F6az9gZ5n1q++xzWsLXh9DpJoE0Cpf0SxJwGKk
	M3+0dXewH3E/8lDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A67A13A63;
	Mon, 22 Sep 2025 11:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2pbmFTg40WjwWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 22 Sep 2025 11:51:20 +0000
Date: Mon, 22 Sep 2025 13:51:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v4] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20250922115118.GP5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250922113310.29724-4-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922113310.29724-4-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6BB9621DEC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Mon, Sep 22, 2025 at 07:30:07PM +0800, Sun YangKai wrote:
> Trivial pattern for the auto freeing with goto -> return conversions
> if possible. No other function cleanup.
> 
> The following cases are considered trivial in this patch:
> 
> 1. Cases where there are no operations between btrfs_free_path() and the
>    function return.
> 2. Cases where only simple cleanup operations (such as kfree(), kvfree(),
>    clear_bit(), and fs_path_free()) are present between
>    btrfs_free_path() and the function return.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> 
> ---
> 
> Changelog:
> v1 -> v3:
> * Directly return 0 if info is NULL in send.c:get_inode_info()
> * Limit the scope of the conversion to only what is described
>   in the commit message.
> 
> v3 -> v4:
> * Fix missing conversions of BTRFS_PATH_AUTO_FREE
>   and tested with btrfs/quick group in xfstests

Thanks, for the update. Back then I removed the patch from linux-next as
it did not pass the full fstests run. I'm not sure if the quick group
would be enough. I'll do a test round, if it passes I'll add the patch
to for-next.

