Return-Path: <linux-btrfs+bounces-14392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A705EACBB00
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 20:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC695188560C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455C1129E6E;
	Mon,  2 Jun 2025 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pemwS8j5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8IyGryka";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2OzHrfCt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ygnxQLcz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014CC2C9
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888156; cv=none; b=VPRfN0R5xZo74Uv5h178LXcR+iVLWG0KKHZ6SFyi0J1nuPA8Ay2EEPOzzqS1ISgq/EIprgUGFSoQrYmniuQhRPlR8kY6oWzWznsrCCw03plIZ5yHte30AeEbue/WlL6jOrZ20ikMLEgXnjTQpjGo0i/1CEq5bnLQJQe0SIM1XnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888156; c=relaxed/simple;
	bh=Rnc6uaIpQfJ+4YTfJ7ILQZrfkmeIkKBdBJDI6hadhOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJizDrFRZEIl1gQ/G7O/tA2VvFJlDftWplaG8bZ/XTY+NIyWjgSeHsnAeYD0XGtBYwPNSmxcfirKtVjhwLYBKdUjIUOuyVdVXTKqIt87LnWEYl4KYK9rq+OmUqty1hudfPlJCmmfpxqSNxcFGK2yw6CyvH/1Ng1a2Hqbup3Go7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pemwS8j5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8IyGryka; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2OzHrfCt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ygnxQLcz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D33422119E;
	Mon,  2 Jun 2025 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748888153;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+BlVLP8bljGfFO5M9oIC6EJCl0wyBQLVQB9j598AZg=;
	b=pemwS8j5yEkN5gRjHKDEOHTvhYVRyQfgyNlaf2ji1hNOvPThNbjkSso+j+pU59Cwbm+mZB
	mgnNTttXCAFebkLk7SGq/0lNa9MCZDEmDHMXNBUTiOINX7hjckzoPx+4SURt8jNdNZPcOJ
	T6JdaNq12sQ3tvz7JKr4N7l6HG7+Ftw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748888153;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+BlVLP8bljGfFO5M9oIC6EJCl0wyBQLVQB9j598AZg=;
	b=8IyGrykafASV/B8kXSR17o3cdpYma4XS9TkKz7jK4YBymlXOkYh3WK1Daqb2hPPjB5Evc+
	YnR0NzIhuhj3AvBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2OzHrfCt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ygnxQLcz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748888152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+BlVLP8bljGfFO5M9oIC6EJCl0wyBQLVQB9j598AZg=;
	b=2OzHrfCtsrNqZcMJ8U64yTYOBdFCkP7vx5uDawpD0DLaW0on+U94pL1ib3HkGa89gxJsY6
	BAN2TDtMqtOREa+DTvihSKZMAowEJwS3y2t0vMzSqGu8IvpcwZHEvswDjTt2NRF05lFtYC
	wf2ThPRoroy1kS9uaOG1ueVEkQv7gfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748888152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+BlVLP8bljGfFO5M9oIC6EJCl0wyBQLVQB9j598AZg=;
	b=ygnxQLczBI4Kdp954yynQeMrhdGmn1KYx77vj9HN2a3bwte70Pu6qAFLzNk1KVd2TpgQrN
	2CUu8gnTGDhkbmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2FD6136C7;
	Mon,  2 Jun 2025 18:15:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fOBaL1jqPWgUMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Jun 2025 18:15:52 +0000
Date: Mon, 2 Jun 2025 20:15:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: rename btrfs_subpage to btrfs_folio_state
Message-ID: <20250602181551.GF4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748824641.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748824641.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D33422119E
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Jun 02, 2025 at 10:08:51AM +0930, Qu Wenruo wrote:
> This migration is mostly to align the naming to iomap, so btrfs_subpage
> is renamed to btrfs_folio_state.
> 
> But before the rename, explain why btrfs needs the following extra
> sub-bitmaps in the first patch.
> 
> Qu Wenruo (2):
>   btrfs: add comments on the extra btrfs specific subpage bitmaps
>   btrfs: rename btrfs_subpage structure

Reviewed-by: David Sterba <dsterba@suse.com>

