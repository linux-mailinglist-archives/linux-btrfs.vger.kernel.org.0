Return-Path: <linux-btrfs+bounces-12062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D3A55510
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 19:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01C9167D57
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24C25D54C;
	Thu,  6 Mar 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="acK5SQ4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YUU10x8k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="acK5SQ4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YUU10x8k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC58136341
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285987; cv=none; b=aOJijicf4OYBSqYr2pa7/bXETwKJXX8FIUud1gTNpeaBM/SJH+LheO+5goKP0cd6p1KnpI+PerIOiRuz8RM5xcbNW929PHeHhA+FEbP6Bltt4fG3D5DVBGe5GIVLQuJqip+BaZHg8baSqSL1iHrH0E/AY4FDxRWGye46MRfYLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285987; c=relaxed/simple;
	bh=FjuA7U1R5CUDWbwzAs22TlLee/QNUTY6LoKyI16Iey4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNNGHq7lqJywN8S3t+BnLjOpSnSKFqO8BsdtqoLRHEHJBX5aeMsMkjg/ifyl9xKikRx+/zrmHQgubjKVhDnLoKQQoXsMknW+8JI7RSURUkI+VgutOOtSd9vmzxXgFBiHEFSZQ4m3CZL0hQjqEPuIm6B4PR+zjU/z8zFMQhT7v/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=acK5SQ4d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YUU10x8k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=acK5SQ4d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YUU10x8k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 163E71F385;
	Thu,  6 Mar 2025 18:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741285983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15NLIZs2R9VxvNoQFLWmA38+bK+zun6amVzpMFNxYvY=;
	b=acK5SQ4dNpBxPzNNGn8gelvkzTHneCfPMnsXx+NOxt4Lu7Ps7eH7iyZ+6Ixmp4xRp4cbQq
	4FvbofayRpHUimgESGU57KBJ+LcV4jx/0cX188Iq/KfRDQW+YANBJAQPFiB6FFi3oEWmn/
	9BskWj6RkAIdhfOAUPdwbdX9sGAx314=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741285983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15NLIZs2R9VxvNoQFLWmA38+bK+zun6amVzpMFNxYvY=;
	b=YUU10x8kdj0k5djDpZA9blYGfqoMWe5o+1bsxGun/wm6JDOm8xzf4BUbnHAVG54a4KAPwH
	KWyJO4gXKAxeXWDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=acK5SQ4d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YUU10x8k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741285983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15NLIZs2R9VxvNoQFLWmA38+bK+zun6amVzpMFNxYvY=;
	b=acK5SQ4dNpBxPzNNGn8gelvkzTHneCfPMnsXx+NOxt4Lu7Ps7eH7iyZ+6Ixmp4xRp4cbQq
	4FvbofayRpHUimgESGU57KBJ+LcV4jx/0cX188Iq/KfRDQW+YANBJAQPFiB6FFi3oEWmn/
	9BskWj6RkAIdhfOAUPdwbdX9sGAx314=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741285983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15NLIZs2R9VxvNoQFLWmA38+bK+zun6amVzpMFNxYvY=;
	b=YUU10x8kdj0k5djDpZA9blYGfqoMWe5o+1bsxGun/wm6JDOm8xzf4BUbnHAVG54a4KAPwH
	KWyJO4gXKAxeXWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF8E313676;
	Thu,  6 Mar 2025 18:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vA1HOl7qyWctTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Mar 2025 18:33:02 +0000
Date: Thu, 6 Mar 2025 19:33:01 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: send: a couple trivial cleanups
Message-ID: <20250306183301.GL5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741283556.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741283556.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 163E71F385
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Mar 06, 2025 at 05:55:52PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Simple cleanups, reduce code, details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: send: remove unnecessary inode lookup at send_encoded_inline_extent()
>   btrfs: send: simplify return logic from send_encoded_extent()

Reviewed-by: David Sterba <dsterba@suse.com>

