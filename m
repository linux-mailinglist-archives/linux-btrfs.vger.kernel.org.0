Return-Path: <linux-btrfs+bounces-8394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F998C1F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7F41C23E5A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248701CB319;
	Tue,  1 Oct 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IGuiYNo3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDHlkgcI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iFyUYLBS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vyCIefVL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FF1C6F7A;
	Tue,  1 Oct 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797594; cv=none; b=RTdqavNjp10aKFxLuxfMuMH3yTJB20w9RwoMygbkx68Yrf0CMaaXzbbM6HhLLunn0wiNdXxJdCAJ2gNXS1jtbJUoQwgorbUmGMJkzvqOUlUz4E22PQ0fvjQyhPAgSVrPehdp2M9PoKCRwJgADwz1z3/6RS2Hn3Mr7QZnEy5ylRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797594; c=relaxed/simple;
	bh=3KN2AF9YfIhgOcUt3bUrdexS/PsSfycZ5mTRF5oGXPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCHzGiy5wtTZRCGx+q5Ea6z4P6dLUo4DvJYZ7Lx8DRGjlvJPlHgftfWADd6Lc/V+kv8bXy/jb80qDRE6o3x5NR9KMiOUWeqhWEOUApYJFrLwpjg0YRQWC9tQqLOiF+6aMh+IbVjLOOsGy2W0WuJG8AQHlwE0WVOPQST6Ge2VEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IGuiYNo3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDHlkgcI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iFyUYLBS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vyCIefVL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0ACB21AB8;
	Tue,  1 Oct 2024 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727797591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V49BQuQhLTHAs4GRDZAQda3MEDdXCavqQfTvSAUNYRI=;
	b=IGuiYNo3QqT1u85wD6rXh8lFiQN9G4f8Ger9BcV3eSTpxvt+mGrJyf97dtKvIbaTDYa8bd
	LSLg0yt7pOXlmssnC+UnoXl9GzGMYmPc3o1FOhkYHhnCrstZXqiNcb37X8qPzDBVWXXY5W
	EhJ4gdYjDCBKjZcDO8seEpOh8LYsFZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727797591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V49BQuQhLTHAs4GRDZAQda3MEDdXCavqQfTvSAUNYRI=;
	b=aDHlkgcI3xE43spHtXV9XtsWwSeUX12073siKA3AMlNOOLnaZ7TYSj7XjJpPUn8m5Kmg1+
	NDYzVBgOOJ9wUPCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727797590;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V49BQuQhLTHAs4GRDZAQda3MEDdXCavqQfTvSAUNYRI=;
	b=iFyUYLBS/JFrSopFfM/RxmJaGKlOUFmRV+Z1ldMqxf4m+G6mBYRcsRNGIlNQNTsC1pID6J
	53YTTqj7assrOd1yg2RWIWq01x1WU2bPgxLUVfDa9AYEW6eflRs6Mc8V0wIL+U1cjOLuoJ
	l4s7HUJrQPyVA6BAzOkVhD7dB6KEuWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727797590;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V49BQuQhLTHAs4GRDZAQda3MEDdXCavqQfTvSAUNYRI=;
	b=vyCIefVLM5vHYnvpAobAOQU1YsdqNGwaYETU0mAM0+whZsVMTNhxO6srijx1NLbI5Aqgxm
	jyptefH2a8e7XkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C316A13A73;
	Tue,  1 Oct 2024 15:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UtBhL1YZ/GZAOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 15:46:30 +0000
Date: Tue, 1 Oct 2024 17:46:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Youling Tang <youling.tang@linux.dev>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] btrfs: Remove unused page_to_{inode,fs_info} macros
Message-ID: <20241001154629.GG28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240924023135.3861974-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924023135.3861974-1-youling.tang@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Sep 24, 2024 at 10:31:35AM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> This macro is no longer used after the "btrfs: Cleaned up folio->page
> conversion" series patch [1] was applied, so remove it.
> 
> [1]: https://patchwork.kernel.org/project/linux-btrfs/cover/20240828182908.3735344-1-lizetao1@huawei.com/
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

Added to for-next thanks.

