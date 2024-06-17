Return-Path: <linux-btrfs+bounces-5765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172190BB5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 21:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD291F22864
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428E188CAB;
	Mon, 17 Jun 2024 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWZUJPpw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMubW+Pn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWZUJPpw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMubW+Pn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD96186E34;
	Mon, 17 Jun 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653699; cv=none; b=UKh4zohRUwnIuBELyfOhfvl4J5fo3tsbPz6b89X9lToesw28smASfJNjrbNZFIdwnXTZeZTkLSwFmW/we0a+n53pQNczzKe63OmJKeJFXj82hP1SFW7zPRa/v/gpGwS8RsLxa9qOK/FTMyCE65tQB3x50cr34Y+NnHkfrZ9/Q40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653699; c=relaxed/simple;
	bh=cWEv+/aq2qIT04s3Anw3tQPT0CQqWzi4O6WCFDbDX+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je63NvgAnvKMnXOIe0FWAuhfEOlM4G7CECtQiaCGxhISyJ59Gq9S/mLAfKg1EN1lZclMMVxujWDgM7w37TSlZi5zw6QHKehmmqb6QTaj/XPXdA1n2algcU04N5Odup83r86Gq4VAfjRYVxRQ5Yo7lDm0C8OgFyUW/uG1YPikQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWZUJPpw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMubW+Pn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWZUJPpw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMubW+Pn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39B2B1F385;
	Mon, 17 Jun 2024 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718653690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmu/IqaHkmBza4ueEU8PiHhV32prglYqu3JvEiANzik=;
	b=dWZUJPpw9sG2V5Ey7a7tkp4Nrkr09a/hNbvVZabRAqgzEcdWbySA8/RJqog4Gc+kXrAVNi
	fh6hejwq3uYlXiqqLfFysJuIiFMhL1qeHWSCf028ldnMYs74//Fd+SHR/4IxuSB3Oigb02
	e59gXZZQW/rHFdOiI6mE2luItEizqAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718653690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmu/IqaHkmBza4ueEU8PiHhV32prglYqu3JvEiANzik=;
	b=tMubW+PnTpKW2RD5xeQjU70ohuegnfx4l/CgUfVXIBiG/3OEJilsQN00WQgZ4+afUgQvVV
	iQTwwATaSrVCVlBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718653690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmu/IqaHkmBza4ueEU8PiHhV32prglYqu3JvEiANzik=;
	b=dWZUJPpw9sG2V5Ey7a7tkp4Nrkr09a/hNbvVZabRAqgzEcdWbySA8/RJqog4Gc+kXrAVNi
	fh6hejwq3uYlXiqqLfFysJuIiFMhL1qeHWSCf028ldnMYs74//Fd+SHR/4IxuSB3Oigb02
	e59gXZZQW/rHFdOiI6mE2luItEizqAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718653690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmu/IqaHkmBza4ueEU8PiHhV32prglYqu3JvEiANzik=;
	b=tMubW+PnTpKW2RD5xeQjU70ohuegnfx4l/CgUfVXIBiG/3OEJilsQN00WQgZ4+afUgQvVV
	iQTwwATaSrVCVlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AE1413AAA;
	Mon, 17 Jun 2024 19:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ORxLCvqScGbeNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Jun 2024 19:48:10 +0000
Date: Mon, 17 Jun 2024 21:48:09 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/74[3,8]: add git commit ID for the fixes
Message-ID: <20240617194808.GI25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85c32250ac781bf925d1f26b0c6933dace05b3d1.1718643112.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c32250ac781bf925d1f26b0c6933dace05b3d1.1718643112.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]

On Mon, Jun 17, 2024 at 05:52:14PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The corresponding fixes landed in kernels 6.10-rc1 and 6.10-rc3, so update
> the tests to point the commit IDs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

