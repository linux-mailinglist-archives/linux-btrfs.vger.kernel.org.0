Return-Path: <linux-btrfs+bounces-4975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EC8C59B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59838B20A42
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63217F37C;
	Tue, 14 May 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJYQYjMZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCT98qrb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n9hY5fmB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQyXyCu8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D022E644
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703981; cv=none; b=Bv/3ZeBEeWjelCmw411mhMsTN09lKAXH6diy/pGA392PmXLl/8Eo0VNI0Z7oMaQ9zXklZlNrsxuENDHWVKhvsGmgFXE9SYKP32TCHMQUGu6dETD5/i2lgJlYTSuStqQU3ScxexYWh0ODzZUpXLcJDy/RupzcJBp6Z9ZvxveDESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703981; c=relaxed/simple;
	bh=VMVTMm3GDxlBgm443G5rUfc4P2uzAjJUi0MGH+3tlXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA0ac/mwC0DkR3F4i6smKxUW6R8f92/5QoXh9gErNjqnBKWlPu3ZKh3UCXZMM1ofbwntJ9nYtPTS2q4W5mtqOlHB+JsHa+BY1SjkXxh5F2rKNgHRQNvXoK6vprbdvtDGIIW1BFgyLfu3rp7hoqkZqwYeD53NexJwYslfaUfpb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJYQYjMZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCT98qrb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n9hY5fmB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQyXyCu8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 096823EA51;
	Tue, 14 May 2024 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715703978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVJzq2Gu+d5Qyo6hmbX0GcZnY4Q/3v6zdie0WX1hgW8=;
	b=iJYQYjMZx6vAlLi6+zOGq7Aw9H5AUiJjn/5wXz6lBxabjgNSLA3o9uFBbF/zn/4GbX9BUQ
	dekHA+RJ5YriPhLKyDIq7pGJ87nbH45HAfbEPON7GUo6gP3O51sT8fswonkPTWVWStzqZN
	ZbvF7kBlY0RYIKynmH0XPIS7q5+S70c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715703978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVJzq2Gu+d5Qyo6hmbX0GcZnY4Q/3v6zdie0WX1hgW8=;
	b=OCT98qrbydXuAWi1H2xTtTp3iOqF1OyIIB0aaHLe0JKmYi9EAWYu+f75zqxlGkm2E8k9IC
	RoqI8eXjGK28ITBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715703977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVJzq2Gu+d5Qyo6hmbX0GcZnY4Q/3v6zdie0WX1hgW8=;
	b=n9hY5fmBqUY5y8W2EW/Aq4x+XfjB/KsDgjCt9rPwBeVHzBwyNTaBvkQx/2XgVLVInNtKOw
	enu7KWTl3ihhrp7Ns/+kIHj7f+0dTfu53KJPW7Lp4emWyfDnpmxiAt/IRteCzGtc3YwAV/
	oE0w/yeG3f3mpSypXqEgb7SXbLGOqb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715703977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVJzq2Gu+d5Qyo6hmbX0GcZnY4Q/3v6zdie0WX1hgW8=;
	b=EQyXyCu8WjrYsu/wcszioy1j53X7sURldOR+/6ZitjaO3V/DJ7sCkZjBvniuKLzC5Jp7lB
	0cOuRkuWKE5XIaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2D831372E;
	Tue, 14 May 2024 16:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q/4YO6iQQ2ZAXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 16:26:16 +0000
Date: Tue, 14 May 2024 18:18:55 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix function name in comment for
 btrfs_remove_ordered_extent()
Message-ID: <20240514161855.GI4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4a9fa14f2211dfc080061f65c2b95b718aa608fa.1715689538.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9fa14f2211dfc080061f65c2b95b718aa608fa.1715689538.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, May 14, 2024 at 03:26:23PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Due to a refactoring introduced by commit 53d9981ca20e ("btrfs: split
> btrfs_alloc_ordered_extent to allocation and insertion helpers"), the
> function btrfs_alloc_ordered_extent() was renamed to
> alloc_ordered_extent(), so the comment at btrfs_remove_ordered_extent()
> is no longer very accurate. Update the comment to refer to the new
> name "alloc_ordered_extent()".
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

