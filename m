Return-Path: <linux-btrfs+bounces-17465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C315EBBE95B
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCAF3B7610
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C02D9EE1;
	Mon,  6 Oct 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b0VvG3CR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eNUlMqtP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b0VvG3CR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eNUlMqtP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCC2D9780
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766766; cv=none; b=G7hAQncn9ICXErKWspDBmNzjaUhprtQMe50EPm42/3y4konmcMwWakp+Ge2K2mEhgLjIQTsNAuygGgpbIIY2qaOCN7uRg7kPaMiGP+VCd+z/6M2G6E3W4a1YZxvm0htJ19pFRSBYo7a07Tdhnq3RVV/ofg9towGgz9WxXV8G7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766766; c=relaxed/simple;
	bh=UCtcz4BM/dYS/3QrJ2luvCuYKAgvRw2ZJGUlSmdLNSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqreLfbb4FSC3kN036yTw7ZkXVROOy/syIxl86eKrl9lTKzWmVO3Ufw1FohEHbLchtUmGcBmmtU4hjUslFsQy3db9+Au3evAZSQXty8NnKabo/n3wnqG/qEHT1CTIBUzC77m7Q2kEKjZNW8V4WXO3s8alpT1k9LFjF2T6Hwkp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b0VvG3CR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eNUlMqtP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b0VvG3CR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eNUlMqtP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D9141F451;
	Mon,  6 Oct 2025 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759766762;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLcfZHjAO66RJDxbKzGGoktyPs2gBHEvgJU/ulxjnrc=;
	b=b0VvG3CRemH27cSbFswY9EJ9gyEPQt7SQ6Sa3Czjj7hAR/2zsW+uUgEG6aDU/6mjFFZa15
	0xbBUbfj6P5ulUJ7GTl+S1+QDn9iz9IvLc0QIYVBEOBEvMWNOWKNeOukLtWmKjvuYufr9W
	rAAkF1zgBMJOMCX1cbYgVFl5X1Pf+bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759766762;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLcfZHjAO66RJDxbKzGGoktyPs2gBHEvgJU/ulxjnrc=;
	b=eNUlMqtPVfsYfY08Hcy5T/WPIXWokoADID4FGJ/IaCGaJ9xI6kpfrRkbPJuwEKFdWa5+1T
	c/Jr9X8FvIZl37Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=b0VvG3CR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eNUlMqtP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759766762;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLcfZHjAO66RJDxbKzGGoktyPs2gBHEvgJU/ulxjnrc=;
	b=b0VvG3CRemH27cSbFswY9EJ9gyEPQt7SQ6Sa3Czjj7hAR/2zsW+uUgEG6aDU/6mjFFZa15
	0xbBUbfj6P5ulUJ7GTl+S1+QDn9iz9IvLc0QIYVBEOBEvMWNOWKNeOukLtWmKjvuYufr9W
	rAAkF1zgBMJOMCX1cbYgVFl5X1Pf+bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759766762;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLcfZHjAO66RJDxbKzGGoktyPs2gBHEvgJU/ulxjnrc=;
	b=eNUlMqtPVfsYfY08Hcy5T/WPIXWokoADID4FGJ/IaCGaJ9xI6kpfrRkbPJuwEKFdWa5+1T
	c/Jr9X8FvIZl37Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A99013700;
	Mon,  6 Oct 2025 16:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id teHbGero42jfOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Oct 2025 16:06:02 +0000
Date: Mon, 6 Oct 2025 18:06:01 +0200
From: David Sterba <dsterba@suse.cz>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: dsterba@suse.cz, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <20251006160601.GA4412@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aN_Zeo7JH9nogwwq@kspp>
 <20251003143502.GJ4052@suse.cz>
 <b59ed01f-d9d5-4de8-8a12-1e506962b2d9@embeddedor.com>
 <20251003151509.GK4052@suse.cz>
 <10762d3f-361a-48b7-8e46-5e5b8a9887fb@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10762d3f-361a-48b7-8e46-5e5b8a9887fb@embeddedor.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7D9141F451
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Oct 03, 2025 at 04:21:17PM +0100, Gustavo A. R. Silva wrote:
> On 10/3/25 16:15, David Sterba wrote:
> > On Fri, Oct 03, 2025 at 03:51:24PM +0100, Gustavo A. R. Silva wrote:
> >>>>
> >>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> >>>> index 9230e5066fc6..2b7cf49a35bb 100644
> >>>> --- a/fs/btrfs/send.c
> >>>> +++ b/fs/btrfs/send.c
> >>>> @@ -178,7 +178,6 @@ struct send_ctx {
> >>>>    	u64 cur_inode_rdev;
> >>>>    	u64 cur_inode_last_extent;
> >>>>    	u64 cur_inode_next_write_offset;
> >>>> -	struct fs_path cur_inode_path;
> >>>>    	bool cur_inode_new;
> >>>>    	bool cur_inode_new_gen;
> >>>>    	bool cur_inode_deleted;
> >>>> @@ -305,6 +304,9 @@ struct send_ctx {
> >>>>    
> >>>>    	struct btrfs_lru_cache dir_created_cache;
> >>>>    	struct btrfs_lru_cache dir_utimes_cache;
> >>>> +
> >>>> +	/* Must be last --ends in a flexible-array member. */
> >>>                           ^^
> >>>
> >>> Is this an en dash?
> >>
> >> Not sure what you mean.
> > 
> > En dash is a punctuation mark not typically used in comments, nowadays
> > found in AI generated code/text. I was just curious.
> 
> Ah yes, I've been using this punctuation mark for this sorts of comments,

It's quite odd to see it formatted like that, it's confusing and looks
like a typo. The emdash "---" looks like the right punct. mark as it
separates extra information, if we'd want to delve into typographical
conventions.

