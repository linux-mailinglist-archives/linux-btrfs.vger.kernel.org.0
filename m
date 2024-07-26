Return-Path: <linux-btrfs+bounces-6735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7093D788
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E8283CA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743117C7D7;
	Fri, 26 Jul 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="abr/cNfI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ntnatWMF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="abr/cNfI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ntnatWMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507917BB1F
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014533; cv=none; b=miFxogmmJOJSe6JKBL84SYcwsQD3QNFp0VAjwfyEK3UESeXe1WOTQKXD8AlOy+7IyXZL0Vy10miS6uADrYYgcRdRTKcKRQs8Cwozkv7igFHbmS+L6kVfluwNN8EEeAe48rzD1wQ7R1sccH52+lILiUyz8mkhI1SgEPL3ckjraQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014533; c=relaxed/simple;
	bh=1QiidPIEYpX64KSErxoD+vpvuZmHBeixS6Efhs5jQ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp++E5MYYSGtw6G28CIVgaUrXnebP3eu+CoUfONDAIYgsO6XKW9HZhBN5pP3krd3Co8zddd7QrUqLKuFPaaHbtTCQdgRah5UHXggVteYE59qMQ0mCnAk3dWN/tunSRg2njQcTsvimkkNxU25466sLWNqGbsg0V+uTo11l78klgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=abr/cNfI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ntnatWMF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=abr/cNfI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ntnatWMF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C72731F8BE;
	Fri, 26 Jul 2024 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722014529;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qyQTb4yWcD4H+StppF7hvZhQMaR3FvAxFQ/0qPHekw=;
	b=abr/cNfI57APy0KeuC0kg6BBZzd69x0cG3U79i5ox0ev0ZccSzoI8A0ugoSttqCTv1bYh/
	DeP26Jxp7cxX/+dyPN8YtW8R/gZTAvioC50ie+B+Q5uoZETLRIuqFjkqPMKJdLqWU8LfRf
	CLc+t/Llg1E5ALNgjo6yIoqW11MeVzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722014529;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qyQTb4yWcD4H+StppF7hvZhQMaR3FvAxFQ/0qPHekw=;
	b=ntnatWMFYpU0npK0X2GqYJouKdj8eZKJt4xS8mewUapOQvgF+ABU/I7r7Pxiu3c4k8hmTq
	KgqpUiSM0TiyntDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="abr/cNfI";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ntnatWMF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722014529;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qyQTb4yWcD4H+StppF7hvZhQMaR3FvAxFQ/0qPHekw=;
	b=abr/cNfI57APy0KeuC0kg6BBZzd69x0cG3U79i5ox0ev0ZccSzoI8A0ugoSttqCTv1bYh/
	DeP26Jxp7cxX/+dyPN8YtW8R/gZTAvioC50ie+B+Q5uoZETLRIuqFjkqPMKJdLqWU8LfRf
	CLc+t/Llg1E5ALNgjo6yIoqW11MeVzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722014529;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qyQTb4yWcD4H+StppF7hvZhQMaR3FvAxFQ/0qPHekw=;
	b=ntnatWMFYpU0npK0X2GqYJouKdj8eZKJt4xS8mewUapOQvgF+ABU/I7r7Pxiu3c4k8hmTq
	KgqpUiSM0TiyntDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 901B11396E;
	Fri, 26 Jul 2024 17:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jj4KIkHbo2ZLTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 17:22:09 +0000
Date: Fri, 26 Jul 2024 19:22:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
	Mark Harmstone <maharmstone@meta.com>
Subject: Re: [PATCH 2/3] btrfs-progs: use libbtrfsutil for btrfs subvolume
 snapshot
Message-ID: <20240726172208.GN17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240628145807.1800474-1-maharmstone@fb.com>
 <20240628145807.1800474-3-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628145807.1800474-3-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: C72731F8BE

On Fri, Jun 28, 2024 at 03:56:48PM +0100, Mark Harmstone wrote:
> +	err = btrfs_util_create_snapshot(subvol, dstdir, flags, NULL, inherit);

btrfs_util_subvolume_snapshot()

> +	if (err) {
> +		error_btrfs_util(err);
>  		goto out;
>  	}
>  
>  	retval = 0;	/* success */
>  
> -	if (readonly)
> +	if (flags & BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY)
>  		pr_verbose(LOG_DEFAULT,
> -			   "Create readonly snapshot of '%s' in '%s/%s'\n",
> -			   subvol, dstdir, newname);
> +			   "Create readonly snapshot of '%s' in '%s'\n",
> +			   subvol, dstdir);
>  	else
>  		pr_verbose(LOG_DEFAULT,
> -			   "Create snapshot of '%s' in '%s/%s'\n",
> -			   subvol, dstdir, newname);
> +			   "Create snapshot of '%s' in '%s'\n",
> +			   subvol, dstdir);
>  
>  out:
> -	close(fddst);
> -	close(fd);
> -	free(inherit);
> -	free(dupname);
> -	free(dupdir);
> +	free(dstdir);
> +
> +	if (inherit)
> +		btrfs_util_destroy_qgroup_inherit(inherit);

btrfs_util_qgroup_inherit_destroy()

