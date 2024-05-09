Return-Path: <linux-btrfs+bounces-4872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D458C1341
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253A41F21741
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF618F49;
	Thu,  9 May 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uXKIdwIi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FX6VbX7+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uXKIdwIi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FX6VbX7+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A571A2C0C
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273629; cv=none; b=Ph69nyskyPde2sW3OeWfGhloa3fGAON/y69yf5XOxo7770gsTpX5Vh13Z+x19nmGU4Y0Kk+FzfFWeZzcuGQO3V0aQ9NF29ycuzVIkgLLFV4mt/rz9tUSToftlDFn6UgO2OJ4nYv/RRCjie9mA7yI2Y7hk7GcebObR7km01nw7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273629; c=relaxed/simple;
	bh=uDi7zf9dx1dn/KMhf9dDUQilzDvLgwCjygKAWzHdlMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/rG1TFG3WaOzRZW0kJpIYqbTmkTU9mjbt8gSuD+aWmsHzo4/GhvHZI6IrDZhjocsYhK19D0P1/BAIur/y0GShyXNSe9hzXvc6Hvaog/6Sh3TDZJ5d/k1h0oS76thb9QMjbq7uQPxWLuZRWGoKidUy/B3aPHwaywzExRl8B5dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uXKIdwIi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FX6VbX7+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uXKIdwIi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FX6VbX7+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 815E7389B4;
	Thu,  9 May 2024 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715273624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxlwS3CAfAd5ogT53ugiVkYW+S6LJyTQ3ZtshlV3m3s=;
	b=uXKIdwIiO/BXzsN+P7DVynOeSRYa6D6PC3Js/f4kiMZGtMmp9HkmGUV1APR+0ZRSmwvu0q
	gxd1dyQKyTOpJy0UhETHxG6w97Cv/HyMHsc1k9WEJrLha+BaTaGFSyjPoH3uTFYZrEhotL
	PQNSYNTdo/Vrk+s7fJ0SxMduoXV39tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715273624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxlwS3CAfAd5ogT53ugiVkYW+S6LJyTQ3ZtshlV3m3s=;
	b=FX6VbX7+TD/X2kqg4jYTqtem+hugj/7zVQUh6tuSNKuLARCeES2bwdzLNOsRLpwl3XCe8Y
	yNq59LtCOjYYkbBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715273624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxlwS3CAfAd5ogT53ugiVkYW+S6LJyTQ3ZtshlV3m3s=;
	b=uXKIdwIiO/BXzsN+P7DVynOeSRYa6D6PC3Js/f4kiMZGtMmp9HkmGUV1APR+0ZRSmwvu0q
	gxd1dyQKyTOpJy0UhETHxG6w97Cv/HyMHsc1k9WEJrLha+BaTaGFSyjPoH3uTFYZrEhotL
	PQNSYNTdo/Vrk+s7fJ0SxMduoXV39tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715273624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxlwS3CAfAd5ogT53ugiVkYW+S6LJyTQ3ZtshlV3m3s=;
	b=FX6VbX7+TD/X2kqg4jYTqtem+hugj/7zVQUh6tuSNKuLARCeES2bwdzLNOsRLpwl3XCe8Y
	yNq59LtCOjYYkbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 739F013A24;
	Thu,  9 May 2024 16:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5kYMHJj/PGbSKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 16:53:44 +0000
Date: Thu, 9 May 2024 18:53:37 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: make btrfs_get_dev_zone() static
Message-ID: <20240509165337.GK13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5609a1191a2bba44aef148a56b67c313b7713a41.1715167141.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5609a1191a2bba44aef148a56b67c313b7713a41.1715167141.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 08, 2024 at 12:20:17PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's not used outside zoned.c, so make it static.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

