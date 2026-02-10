Return-Path: <linux-btrfs+bounces-21615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK0mCsSAi2m+UwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21615-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:02:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA8711E7B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E9B303A919
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962EF2C11D3;
	Tue, 10 Feb 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pog0lWN+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Gt9G2mE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pog0lWN+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Gt9G2mE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE781F03EF
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750138; cv=none; b=S5tO3VWVU3ja0MuZBUXULsRPWmSa+DwP0mStLPTC1VSxBtif4cGTXcM/0aRuinJmvpoHKQWd9OBH912mkX/YrM+nu3U2083AI9qHWi0umugN8V5GikhKpzudD7Q9pIQpIJpM9bo/+3rte20C4r80AhwUZ9J/jAz6+fwhgfjtR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750138; c=relaxed/simple;
	bh=1Oi/r8YfrUJbjH1JuXmeRfrkHsssAvliUlJW6/rT9fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hneBEiyAVec+8Oezdc3Igd1Xr83JLQaosisssZUcIpvt+27gFa3H7OabYJlCYR2hKykrExs7Gf/pFAm6nj4BgN0MSqhg6I+SUwVpIq3mHuq0gAKVSSw1NwqU7VvUWnVFpnhw+f/F45MRyWsUTe0ZiNqzkRozn5Jrla1DksoU9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pog0lWN+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Gt9G2mE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pog0lWN+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Gt9G2mE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A6725BD79;
	Tue, 10 Feb 2026 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlQlzFyaacBp2toE//GuofuRLxQ/mmvvwBiNcF9Mw24=;
	b=Pog0lWN+kM/lbJIuNa0iOgxnXivyyNKpWqGfYsAGJn+wBfVOrNcQuzXly+yRbc47xTVLPt
	Sq9Yix/u5xXqabi5WRlBrGC4L99zVS6R6UbgFgWx9Hf5h3Jb8aDvtYVVv7okPI5nAJqKje
	ONn1ORp81bM13W/E9mvT4YXyfhh2Cws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlQlzFyaacBp2toE//GuofuRLxQ/mmvvwBiNcF9Mw24=;
	b=8Gt9G2mE33z+ZrCg/yrHPdUV3FDvfh7LwC36jvgxAdrqpljTEeLfNO7k1RiJ+ctPht9h/8
	M7pXvebYsy3DdTAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlQlzFyaacBp2toE//GuofuRLxQ/mmvvwBiNcF9Mw24=;
	b=Pog0lWN+kM/lbJIuNa0iOgxnXivyyNKpWqGfYsAGJn+wBfVOrNcQuzXly+yRbc47xTVLPt
	Sq9Yix/u5xXqabi5WRlBrGC4L99zVS6R6UbgFgWx9Hf5h3Jb8aDvtYVVv7okPI5nAJqKje
	ONn1ORp81bM13W/E9mvT4YXyfhh2Cws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlQlzFyaacBp2toE//GuofuRLxQ/mmvvwBiNcF9Mw24=;
	b=8Gt9G2mE33z+ZrCg/yrHPdUV3FDvfh7LwC36jvgxAdrqpljTEeLfNO7k1RiJ+ctPht9h/8
	M7pXvebYsy3DdTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E40553EA62;
	Tue, 10 Feb 2026 19:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gvd6N7aAi2nlKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 10 Feb 2026 19:02:14 +0000
Date: Tue, 10 Feb 2026 20:01:58 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: pass literal booleans to functions that take
 boolean arguments
Message-ID: <20260210190158.GD26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f496fae02aeb1d929e4b77525bd578bed8a110f9.1770727364.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f496fae02aeb1d929e4b77525bd578bed8a110f9.1770727364.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21615-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,twin.jikos.cz:mid,suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: 7DA8711E7B7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:44:00PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have several functions with parameters defined as booleans but then we
> have callers passing integers, 0 or 1, instead of false and true. While
> this isn't a bug since 0 and 1 are converted to false and true, it is odd
> and less readable. Change the callers to pass true and false literals
> instead.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

