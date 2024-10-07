Return-Path: <linux-btrfs+bounces-8598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4DF993A92
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 00:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349601F23828
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 22:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD718EFE4;
	Mon,  7 Oct 2024 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGbjgupJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEmjGDkB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGbjgupJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEmjGDkB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0F18BC19;
	Mon,  7 Oct 2024 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728341648; cv=none; b=jXcxokJHAGdnGE13JwgMOsVyJsR6kLHmjxuQUJcySGHARTR4ENKWeZWC9T6z3jZexBKZarJkewE0lgqr9xsCmHv4S1wn/8FwwtoWvJ/gBHe8W+kR9m9ilp509gAe6V+1eSCZUOq+1OLUalbSsCdbjyEYQ8sP+m+oFq1pJJb2W+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728341648; c=relaxed/simple;
	bh=OPR/oeuYLYneNcWr3CEI9fDuszQ2QBtYST+cZLwRrzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQiRU8VrNkET1+c4sNQbhEu+7hWxfQwHoYX5Mhp4dHbHhH/tUuzlZqlAv/FzKIPvsDzdOXBqGOWlVJ6IlYMpS/TikIoQ0SP02zbIQNkHHeVzxIJeDNSNEQ7pUQVr6PaLbFcpHdwmR2Efw+Pwk9Ndhun27/W6EItIr8841BOqA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGbjgupJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEmjGDkB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGbjgupJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEmjGDkB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D277A1F80F;
	Mon,  7 Oct 2024 22:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728341638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rcZAVGEIqtnVqf1ivflEos2FtMzfvnMQBzpNwOaRycs=;
	b=GGbjgupJwibybKnHgFtrbFTlllukRe7j4/oB7N3CP2u1MezMWT6GjUOhEk0+dKdnr/gK6/
	U1QBSKQhQEEIL3rPKOykTqO7bsGDob6CI7QwkgytYRHCBasdCuL8k+ny9QifU989nBQ3zd
	FY8BcPlkAOhT/kgb61HSIcsR9rvrCW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728341638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rcZAVGEIqtnVqf1ivflEos2FtMzfvnMQBzpNwOaRycs=;
	b=HEmjGDkBBS6UueDuzALocJg2sT8MVoKkwh9bw3doOs6bGHpxeoatbpAKlfuYeCykbHOnf+
	8VI1anvoN+y7uICQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728341638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rcZAVGEIqtnVqf1ivflEos2FtMzfvnMQBzpNwOaRycs=;
	b=GGbjgupJwibybKnHgFtrbFTlllukRe7j4/oB7N3CP2u1MezMWT6GjUOhEk0+dKdnr/gK6/
	U1QBSKQhQEEIL3rPKOykTqO7bsGDob6CI7QwkgytYRHCBasdCuL8k+ny9QifU989nBQ3zd
	FY8BcPlkAOhT/kgb61HSIcsR9rvrCW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728341638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rcZAVGEIqtnVqf1ivflEos2FtMzfvnMQBzpNwOaRycs=;
	b=HEmjGDkBBS6UueDuzALocJg2sT8MVoKkwh9bw3doOs6bGHpxeoatbpAKlfuYeCykbHOnf+
	8VI1anvoN+y7uICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABFFF132BD;
	Mon,  7 Oct 2024 22:53:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CYWWKIZmBGdCDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Oct 2024 22:53:58 +0000
Date: Tue, 8 Oct 2024 00:53:53 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/322: add git commit ID
Message-ID: <20241007225353.GA2833@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2126c43fff7fc7b421c3ed692f1eabbf10d8e534.1728302503.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2126c43fff7fc7b421c3ed692f1eabbf10d8e534.1728302503.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
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
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 07, 2024 at 01:02:16PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The corresponding btrfs kernel patch was merged into Linus' tree and
> included in kernel 6.12-rc2, so update the test with the commit ID.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

