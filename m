Return-Path: <linux-btrfs+bounces-14106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE9ABABFF
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 21:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172C44A0651
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C2205ABB;
	Sat, 17 May 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QxcUKryJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ytDSeokl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vLGi/+VN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VR1nAPVj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1E149E17
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747509283; cv=none; b=tBRl9dGxpCLGSapUS5tbJ/VvhzWE0RPIjrf4wxbwBlCLW/kODSIbQEKU2zT9np4Qm9lQNs6nYLYn3Gm+NyU5EYl6qRX/4LMF5uSbdjffC/nwzNaKarz8p3Ty2a5DYD01G91Q1c9J76uP3yL7ZZyIL+H1oGOkNO4qhYD7dTAoZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747509283; c=relaxed/simple;
	bh=1EorcRH4fxPWJl0PLfvZ9yY568I2oX21fBlIG3/rWao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofdlFq1q7+9a7yTI77sS3NnSDcfJvUYOw4JbMS4Y5g1M91YKoUx10xvGL1m8yJrpDL1fhdMWOp1PiIWgg9duCBVQAmT51LTL6JtTQUZix6QFuSkTk2lUH9t4KW1nmd5aFrbewAM3nFh+tabb/7hfJGYmPcQ3tUT7LzZ29r5o81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QxcUKryJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ytDSeokl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vLGi/+VN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VR1nAPVj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F19BE1FF34;
	Sat, 17 May 2025 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747509280;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsmqsIIi3O5f7jKsZD01ypWH/QbmjgdVlNOu8n5mU+k=;
	b=QxcUKryJw87/3vV8gToGHlDfm/sPKncNH0s72QuWWBrhv5CDL7wl5rq9Px9hcLCSVwvwJr
	udGuuT8mWFUygXB4rzftJufJ8QW2Sz4yyBjlBc0oAoWWws0+sjkuO+3FwTe5H4YUGhIudK
	NxbLHT8EQfQpEQW/Da5gE+FmkyzhJtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747509280;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsmqsIIi3O5f7jKsZD01ypWH/QbmjgdVlNOu8n5mU+k=;
	b=ytDSeokl9zvMMvxUl95LqMKTM7u2llT8O1vulpemG0plkjKQIgfqk8wxlDjpHKl16D3RzK
	IgjR48cm3jAZIZCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="vLGi/+VN";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VR1nAPVj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747509279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsmqsIIi3O5f7jKsZD01ypWH/QbmjgdVlNOu8n5mU+k=;
	b=vLGi/+VNr8h5wSIAg5VI+wfFh2J/Bi7KB0DWzMfkiHRQycTWUcKNRrcBSjxWCYR7wvXL9c
	IDSeLu1sQUz2smhVs4ewqCPyAM+wI7srvRzTge1X9pjuVN9JzhlcokkUzHdRgRm4X2FyM3
	yI79zds/txaq8Bl26lGFHib21PPqdgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747509279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsmqsIIi3O5f7jKsZD01ypWH/QbmjgdVlNOu8n5mU+k=;
	b=VR1nAPVj7M4BiQlBrNf9BEEJKYLgE96jwdETDlzamWqN+rYRdQ4pjn631W7EffVYyYbzfp
	P1lijNABl4du4PBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4BF013991;
	Sat, 17 May 2025 19:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3GZ4Mx/gKGiCcQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 17 May 2025 19:14:39 +0000
Date: Sat, 17 May 2025 21:14:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix the comment of btrfs_path fields
Message-ID: <20250517191438.GB25863@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250517143435.31536-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517143435.31536-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: F19BE1FF34
X-Spam-Score: -1.21
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]

On Sat, May 17, 2025 at 10:34:16PM +0800, Sun YangKai wrote:
> This comment is originally added in
> commit 925baeddc5b0 ("Btrfs: Start btree concurrency work."), for the
> field keep_locks. The field keep_locks had been moved to another line,
> while this comment is left in place.
> 
> Move the comment to the right place.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Added to for-next, thank.

