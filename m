Return-Path: <linux-btrfs+bounces-5481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446B8FD565
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 20:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1271628779D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E877347A;
	Wed,  5 Jun 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OsJT28Pd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoeGAhX/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zZIXDOGc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PP9aUR4i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753A224D6;
	Wed,  5 Jun 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610696; cv=none; b=Ugo3X8VhiaklWw+Cq1xXLfmcIDXlIm2vCtnEdKM1QtukGozJ6G2gKCi40fnXybK+6Z2d1ur085fWEO9DoRlO/D3PtE+a2ftdoQcoU9jSBwqab9dcVzLpAYPSqTDTLbhCWq8FTuiyYE/+YQQoAym1+1q4vY/KNJSsCnOiSWK4u8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610696; c=relaxed/simple;
	bh=kAZnQpDfGBLr/hv5kBKen/wUM1vO4PpdyH0MaGPkuks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q44fmcPm1Z1MI3G9czEjSylUKfWX5lxOIK/kTHbihxwHhkfMgGPO0OmvVs3VRg3p4SNtTqDK3hL6w17+JmlczwSDKs6ye0Ml9qBu6ln6Xac4puSGVcQEV2jIcRvZIYv7rkRJV+LsGQEdMA0jWiB5zZ+OYz11gTRr/fhgoikuML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OsJT28Pd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoeGAhX/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zZIXDOGc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PP9aUR4i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA65E21A9F;
	Wed,  5 Jun 2024 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717610693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCLmp5LMr/Q4r7oEA9biEivh7X/2CnsTC+6PiNZPOlQ=;
	b=OsJT28PdeUY86FzCFJMeKYR0xsN7C4sUjl1pyHMp5TDUBCIuU4rJVAxkWyQXymmVh+qjL0
	eMJ2U8Dg6z+co0DKCr07b8kWKc9QCzgftaJImTwqpelGLa16hXBEiFOtQulQg3CNVLe0c3
	/RMKZQTIi8NT2t2LYrnsSFxS8e/DyCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717610693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCLmp5LMr/Q4r7oEA9biEivh7X/2CnsTC+6PiNZPOlQ=;
	b=LoeGAhX/yFkcOW57XkkhxYlJGgN/WdGigqJSpviIdYyflsa6dtEqN3A7GWpeaVcVlhNnsO
	AdmxR3PzG2SO+IBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zZIXDOGc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PP9aUR4i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717610692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCLmp5LMr/Q4r7oEA9biEivh7X/2CnsTC+6PiNZPOlQ=;
	b=zZIXDOGcaAd5T/ThfMvGOPXLvkXLFj/fxXtNOfohk6oZBpj+nTshqG79F2HlBvbOAFTzKl
	NvcOFEl9uN19mszmat0yoaDNagw++chXoPWAs1SCk+Tc7BQ4wBtw6VkTdfF3rkfPDwDzZn
	BIrebS9yU6h9sRdcoeXMED37gJx1tHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717610692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCLmp5LMr/Q4r7oEA9biEivh7X/2CnsTC+6PiNZPOlQ=;
	b=PP9aUR4iDZCfhcUBtslekk5mQRV5tIMAasUwPvW2EkcYffahPp4sBx/LNMYVKdsO9N8kRQ
	d4yHaSsEu80lUICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC52613A24;
	Wed,  5 Jun 2024 18:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K+VwMcSoYGaqeAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Jun 2024 18:04:52 +0000
Date: Wed, 5 Jun 2024 20:04:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 0/4] btrfs: small cleanups for relocation code
Message-ID: <20240605180447.GE18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EA65E21A9F
X-Spam-Level: 
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed, Jun 05, 2024 at 03:17:48PM +0200, Johannes Thumshirn wrote:
> Here is a small series of cleanups I came across when debugging
> relocation related problems on RAID stripe tree.
> 
> None of them imposes a functional change.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Johannes Thumshirn (4):
>       btrfs: pass reloc_control to relocate_data_extent
>       btrfs: pass a reloc_control to relocate_file_extent_cluster
>       btrfs: pass a reloc_control to relocate_one_folio
>       btrfs: don't pass fs_info to describe_relocation

Reviewed-by: David Sterba <dsterba@suse.com>

