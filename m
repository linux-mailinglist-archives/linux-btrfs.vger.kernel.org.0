Return-Path: <linux-btrfs+bounces-19667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2108CB6E72
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF643018189
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A824A05D;
	Thu, 11 Dec 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q+FFMto5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsB5o7j4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q+FFMto5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsB5o7j4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A812DDA1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765477884; cv=none; b=oYiG2ZvzdPbCU6L6ylpDXaMX7Ss7fZbPMd0xDCrfs8h3mln3MeQ6Vw9tgQg0DvvKvBYLAWeHoqBEPE0m6LQELiXSbm4uHDj5Gz8HEhtSfqN7aZp7gEu0XYWNbZUDMlwvCCKjw+A0Fhf4boCGCOSWVZEYcOaaQXYJwicacknrNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765477884; c=relaxed/simple;
	bh=Jy1H0w6V/zxGb6J/vqAH56zHYqzEfqxwuyqIzIAnlnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN7pFsM5+lmjBv8Kt9TOc/opVS6geQfR141Zrsms4WYEjvrxpW16P4aysngB3vA/cDRooP/A2jUluXkB8hFkiG8kuusPbofiOPw0S+JhwLIoHK527P60y+dpBflsNS35CBZAbnTxBljre48aImXXDjKWXqaf9L22DY+vrDTVgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q+FFMto5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xsB5o7j4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q+FFMto5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xsB5o7j4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22FF533737;
	Thu, 11 Dec 2025 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765477881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=galyb477SFlsUv9QCGBbNPb9e0ypTGrYg1j9+oIkdHk=;
	b=Q+FFMto5r5sasl4XmKJtGLhHENyBvLqnYDN+QADD4+LZmO3z8GJWKW5InMFwqG1smtLiaP
	22MQa+QiEHPrHeRu5d9olHyRyhqhUdkxSN7PhAa2rXgOjYlFL2duXhg20V4uGBQ5aNqZLz
	TSo+eY3tGmMGWyVigcyX0bgjMcCJ3nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765477881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=galyb477SFlsUv9QCGBbNPb9e0ypTGrYg1j9+oIkdHk=;
	b=xsB5o7j4XulCoInb+XR9gJbRzyQZ6VtgF8t2BYpTycPVlh6/bxPe14o+gTEu6XX0hBA3AG
	YgRVBFPo1IxOJtDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765477881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=galyb477SFlsUv9QCGBbNPb9e0ypTGrYg1j9+oIkdHk=;
	b=Q+FFMto5r5sasl4XmKJtGLhHENyBvLqnYDN+QADD4+LZmO3z8GJWKW5InMFwqG1smtLiaP
	22MQa+QiEHPrHeRu5d9olHyRyhqhUdkxSN7PhAa2rXgOjYlFL2duXhg20V4uGBQ5aNqZLz
	TSo+eY3tGmMGWyVigcyX0bgjMcCJ3nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765477881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=galyb477SFlsUv9QCGBbNPb9e0ypTGrYg1j9+oIkdHk=;
	b=xsB5o7j4XulCoInb+XR9gJbRzyQZ6VtgF8t2BYpTycPVlh6/bxPe14o+gTEu6XX0hBA3AG
	YgRVBFPo1IxOJtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 175823EA63;
	Thu, 11 Dec 2025 18:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RPWDBfkNO2kaHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Dec 2025 18:31:21 +0000
Date: Thu, 11 Dec 2025 19:31:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: rename btrfs_create_block_group_cache to
 btrfs_create_block_group
Message-ID: <20251211183119.GL4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251210053932.149358-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210053932.149358-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.10)[-0.523];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.90

On Wed, Dec 10, 2025 at 06:39:32AM +0100, Johannes Thumshirn wrote:
> 'struct btrfs_block_group' used to be called 'struct
> btrfs_block_group_cache' but got renamed to btrfs_block_group with
> commit 32da5386d9a4 ("btrfs: rename btrfs_block_group_cache").
> 
> Rename btrfs_create_block_group_cache() to btrfs_create_block_group() to
> reflect that change.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

This seems to be the only one last left, everywhere else the 'cache' is
used in the identirier it's related to the bg cache.

