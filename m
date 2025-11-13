Return-Path: <linux-btrfs+bounces-18940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66635C56D33
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6088A3520C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDEE30E852;
	Thu, 13 Nov 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSqtGXgs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NC+iYqC1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSqtGXgs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NC+iYqC1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD02DAFD7
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029569; cv=none; b=fYuDvoTmAkJxEBJkgAqqhKVp2cUQYGVP9EJ3lAKN87IcG96qHBMiYGGMu7cxR/d4UN2eMrkrfexSGFv9zjpTM2/d/mQ+hnp4FXsuRrpPSs0fRmRmrbh6Wath7six+07AOCC1YVJc2K/6s+9l6f4Eqf68kmBYcGJY1sHAqAkm5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029569; c=relaxed/simple;
	bh=H+v08NeGNJt+0w5wOVM1c5BUo4UEQ55w9ckWNFJWrm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeYfnI2xN6WVPtrBsXMQmcu3HTjcs4YndbmkJn7xs8g218GEwPH+ksP8HYqyKiT8ilMYXsKRIUKfcZuR0NkdDE8iAPRvBqam8p3lMrh0bvJDYwSjxq3moLjpWP4vhftsgt28pu/DS4i49lTMUk3RAU1u4i68yqGhe2mkkBEHQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSqtGXgs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NC+iYqC1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSqtGXgs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NC+iYqC1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1406F1F388;
	Thu, 13 Nov 2025 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763029566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2t5NE3oMuOwaFVINZlsJ/Kb/GkJvgKo+bXCemDeNLx8=;
	b=VSqtGXgsrU/9kXnCeHBKfImG+I+t7Ybb1Nsd7xhkwwtCPNDW60cWuEKEr3rBxtK65TVNWx
	7SK81MplvwCOFBswflFJ0RHJcUsGmuqDvN9fzPrRzcEXEs04iiIw7Mpio50kCSAo2khqYv
	ENduUfFGQpsBXZ8BjNjRGwsk/TqzyRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763029566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2t5NE3oMuOwaFVINZlsJ/Kb/GkJvgKo+bXCemDeNLx8=;
	b=NC+iYqC1HiWKIC4q2Y+IGGZBQ3hFNAFU1Pb3zc4CmoRMMbU27v+XGqkqDT1/Iu6MAbZw3P
	yab2mUUhtS5H6oBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VSqtGXgs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NC+iYqC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763029566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2t5NE3oMuOwaFVINZlsJ/Kb/GkJvgKo+bXCemDeNLx8=;
	b=VSqtGXgsrU/9kXnCeHBKfImG+I+t7Ybb1Nsd7xhkwwtCPNDW60cWuEKEr3rBxtK65TVNWx
	7SK81MplvwCOFBswflFJ0RHJcUsGmuqDvN9fzPrRzcEXEs04iiIw7Mpio50kCSAo2khqYv
	ENduUfFGQpsBXZ8BjNjRGwsk/TqzyRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763029566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2t5NE3oMuOwaFVINZlsJ/Kb/GkJvgKo+bXCemDeNLx8=;
	b=NC+iYqC1HiWKIC4q2Y+IGGZBQ3hFNAFU1Pb3zc4CmoRMMbU27v+XGqkqDT1/Iu6MAbZw3P
	yab2mUUhtS5H6oBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE4F03EA61;
	Thu, 13 Nov 2025 10:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TvcBOj2yFWnCLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 10:26:05 +0000
Date: Thu, 13 Nov 2025 11:25:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v6 2/8] btrfs: disable verity on encrypted inodes
Message-ID: <20251113102556.GK13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-3-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112193611.2536093-3-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1406F1F388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Nov 12, 2025 at 08:36:02PM +0100, Daniel Vacek wrote:
> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> Right now there isn't a way to encrypt things that aren't either
> filenames in directories or data on blocks on disk with extent
> encryption, so for now, disable verity usage with encryption on btrfs.

Maybe mention that fscrypt + fsverity is possible and could be
implemented in the future.

