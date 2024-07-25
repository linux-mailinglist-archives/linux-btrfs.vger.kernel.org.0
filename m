Return-Path: <linux-btrfs+bounces-6701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204E393CA8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511631C21EE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 22:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BABB13D893;
	Thu, 25 Jul 2024 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YZq4rzvv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9vEUUZt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YZq4rzvv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9vEUUZt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE941F17B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944944; cv=none; b=qRt0HTJ7NXD2/6H6EBhGhiCGA3IL2mMm+vu3xFV7+ft0CQLAUw3mTqIJE8w4d0ZoiElynwsB+k7rOc84tv/t8a5x41nF/WPeQukcs+h4gVZySsQqNBCPOEw6GgVyVcrJp9ZdyeLFWQgIMRtC6lSzD3A3SYG4IF0gotdnt8QUE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944944; c=relaxed/simple;
	bh=W70R8cGR99o6+9MY82DJAck4iUSi3dDRdUbiNX3pJxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEmjEimKkWGN/+9vO8RHrAqllPRe+a62cZx295OHfG8ac3Q31L52O1xSSyxPwv0vc4uO314rs0RsZ4bhikcHLRkB53R/uOGMGudEPOEiaOcqZMriRj8Mrh3layReVNKUdWmoH64LvV1Bd6+JZBLKHTWAkLW9DQXiLbsiU8HO/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YZq4rzvv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9vEUUZt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YZq4rzvv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9vEUUZt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1E051F831;
	Thu, 25 Jul 2024 22:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721944940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WORwIw4Bjcz7ouSH3gA1FbXaderFC2MN9SvhZcNbFi0=;
	b=YZq4rzvvSUL12X27nHIjt1A5IqTQ+txJ+m6zaeLdB7xCU8J4OTO5du6v1UUal9WGQ3CB1p
	TlBkFsxwObIz1jsNMmLnWP3SH+dRcAp+EF4pzOxobAtxacHUYAGmWc6QmBGdalbXD61yWD
	NEpQEywxbVSy4DkYbD27/ud1rkXv7Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721944940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WORwIw4Bjcz7ouSH3gA1FbXaderFC2MN9SvhZcNbFi0=;
	b=g9vEUUZt7/7lXs7P3Hmjpz0dV/3QEucUVu6ycNKmFdeL95QksJ635tuzVVT0FP/pq+ozoU
	aXKNfQGRC2enxHAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YZq4rzvv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g9vEUUZt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721944940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WORwIw4Bjcz7ouSH3gA1FbXaderFC2MN9SvhZcNbFi0=;
	b=YZq4rzvvSUL12X27nHIjt1A5IqTQ+txJ+m6zaeLdB7xCU8J4OTO5du6v1UUal9WGQ3CB1p
	TlBkFsxwObIz1jsNMmLnWP3SH+dRcAp+EF4pzOxobAtxacHUYAGmWc6QmBGdalbXD61yWD
	NEpQEywxbVSy4DkYbD27/ud1rkXv7Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721944940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WORwIw4Bjcz7ouSH3gA1FbXaderFC2MN9SvhZcNbFi0=;
	b=g9vEUUZt7/7lXs7P3Hmjpz0dV/3QEucUVu6ycNKmFdeL95QksJ635tuzVVT0FP/pq+ozoU
	aXKNfQGRC2enxHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A061E1368A;
	Thu, 25 Jul 2024 22:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DatzJmzLombuFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jul 2024 22:02:20 +0000
Date: Fri, 26 Jul 2024 00:02:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move uuid tree related code to uuid-tree.[ch]
Message-ID: <20240725220215.GB17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <953cb5cf507f8f25b6e89a0666164ae0315c9e8e.1721797137.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953cb5cf507f8f25b6e89a0666164ae0315c9e8e.1721797137.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: B1E051F831

On Wed, Jul 24, 2024 at 02:29:02PM +0930, Qu Wenruo wrote:
> Functions btrfs_uuid_scan_kthread() and btrfs_create_uuid_tree() are for
> UUID tree rescan and creation, it's not suitable for volumes.[ch].
> 
> Move them to uuid-tree.[ch] instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

