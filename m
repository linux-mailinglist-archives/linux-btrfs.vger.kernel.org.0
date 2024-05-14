Return-Path: <linux-btrfs+bounces-4973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B722D8C5958
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D871F243E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D9917F381;
	Tue, 14 May 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3BdO52I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubEzPvEB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3BdO52I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubEzPvEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158617F36D
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702753; cv=none; b=KvzPtbWEyb0PPBOdPoA9/WGAmv0lL2dHluGitdHJ08BBNCJAbIDjNEY+cK258Fuo/Ae2uNIN8cYC8S2xVCiyDz2/SeVnNxARM57vZwrUWdv28xzw6bDlpp4D1VJiaLPIz/9Ka2XIbW4GrAOCZ3HNHWFiPfnNw6u1i4iNTqtMbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702753; c=relaxed/simple;
	bh=kESBhzeW6jYlevvlr/jTBe7fzjrSE3rQdc+68XnH9BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZlrB3On0GtTGSJyT83miQ3JXIKtKD7PIJBnHWPZ/qQDZaHy6jhq7Eu36iUEI0aPaaMbDNs9CDcTyTr7wA+XIkvm6UPs9NJz2rGyh5HlUeXp4QZiU3zxMchtGYlfNhZyMGVX+UVi+e43wYMvdfUuv/UVHZCxO23mauDNm6tKmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3BdO52I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubEzPvEB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3BdO52I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubEzPvEB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 169393F04E;
	Tue, 14 May 2024 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715702750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxrtfXfNiMxDMaBOTijLm9lKEqhUKUiPvfGEGWXDnVI=;
	b=r3BdO52IaWBYuZxMzDMh4v2sfmJTFvJlBP+e69fo/qelC0jo6TQ5pCFurgCc7kPTYWc2Yd
	2C7yp5FegOtocWmN9kWK4GUR+qmtg+5NSmgzieV/Tj50LmZM05vumY3lXqkOMGWrMxIgQO
	GiOX0uLu6lhpB1ia4KwJquYVHU5sRO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715702750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxrtfXfNiMxDMaBOTijLm9lKEqhUKUiPvfGEGWXDnVI=;
	b=ubEzPvEBSi65PEwAO7vtCNHfq7zOFTe0f1LmoBoNkSD60nn3tdeqtOmwfOnCK7PuNp4xx1
	guOYaZgFmhp6JJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715702750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxrtfXfNiMxDMaBOTijLm9lKEqhUKUiPvfGEGWXDnVI=;
	b=r3BdO52IaWBYuZxMzDMh4v2sfmJTFvJlBP+e69fo/qelC0jo6TQ5pCFurgCc7kPTYWc2Yd
	2C7yp5FegOtocWmN9kWK4GUR+qmtg+5NSmgzieV/Tj50LmZM05vumY3lXqkOMGWrMxIgQO
	GiOX0uLu6lhpB1ia4KwJquYVHU5sRO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715702750;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxrtfXfNiMxDMaBOTijLm9lKEqhUKUiPvfGEGWXDnVI=;
	b=ubEzPvEBSi65PEwAO7vtCNHfq7zOFTe0f1LmoBoNkSD60nn3tdeqtOmwfOnCK7PuNp4xx1
	guOYaZgFmhp6JJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F37C0137C3;
	Tue, 14 May 2024 16:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Udc+O92LQ2Z1WAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 16:05:49 +0000
Date: Tue, 14 May 2024 17:58:32 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 10/10] btrfs: use a regular rb_root instead of cached
 rb_root for extent_map_tree
Message-ID: <20240514155832.GG4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715362104.git.fdmanana@suse.com>
 <37b63a8da723a934b72c5fe00b49922fcec5f5c7.1715362104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b63a8da723a934b72c5fe00b49922fcec5f5c7.1715362104.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.98
X-Spam-Flag: NO

On Fri, May 10, 2024 at 06:32:58PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are currently using a cached rb_root (struct rb_root_cached) for the
> rb root of struct extent_map_tree. This does't offer much of an advantage
> here because:

Good catch, this one escaped me, we need the RB tree tracking so I did not
consider it, the cached pointer was hidden.

