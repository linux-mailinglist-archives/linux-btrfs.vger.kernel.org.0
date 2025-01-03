Return-Path: <linux-btrfs+bounces-10710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D49A00BD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE393A406D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E71FA8CD;
	Fri,  3 Jan 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="26JkgPnj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ObWuQHOu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="26JkgPnj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ObWuQHOu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41777146D6A
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920365; cv=none; b=EzpHcw+t5wWh6i4bhdxmLoAkYlaPDOm+SLIuzY13YxrYsMvfQOoXoz2eVAFQQPOZkj3qeFNMRMzcsNUoY3525pviVeLaUHZrnEw5SAI0WYzzQSf9P44ok0o6xjpWL/QYfcz6UfqfdFyewJAG73nHra4FjhAQ1FtEvjfmOUOvN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920365; c=relaxed/simple;
	bh=5/ftLODk1TiZHolMm+CwM6EHR1UVv9K4zI4Yxg/NtQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Xg/wtdjye2KFD0uh17tYGFrigBgxH1J63it0qSJm6UHfy7YJ4T7mJ00ZHom/Oidq0PATekuIb1HC9zPH2LijL2Mu5S5FN7TMg2i9nA73/JcHL+JIFGkb93rPTxEfTQ9cbtul2oZ49SyxCetAEDkYcEBJtNygNP0N/1HYgG8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=26JkgPnj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ObWuQHOu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=26JkgPnj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ObWuQHOu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DF4C1F38E;
	Fri,  3 Jan 2025 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735920359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55+bo0A+9eU5E9gxV+vzsiAgHMZhkqcloNbXxA/o5y8=;
	b=26JkgPnjSRXfvEhtmvS1FHm1OS5v5iv8YF0un3N1S6AmoZjCNWlBwLpUbVAgwRaQL+zYC0
	XuCWYb4Kd0faXr6UWUR2RNDMVvkx7QUXSP/UCOI0btZRpWGWfbvaoTYx4OScaPetQMSs/n
	EMiGramrUJWkcFg95sjy2peEINhMZIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735920359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55+bo0A+9eU5E9gxV+vzsiAgHMZhkqcloNbXxA/o5y8=;
	b=ObWuQHOuM+aZlBGEQyQ9t4sbSVjNeKZ9a7IdM4MOUBoftEV4IeclBelqe6p+N8qmHdSENQ
	R8dtIbXKsvyTiCDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=26JkgPnj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ObWuQHOu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735920359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55+bo0A+9eU5E9gxV+vzsiAgHMZhkqcloNbXxA/o5y8=;
	b=26JkgPnjSRXfvEhtmvS1FHm1OS5v5iv8YF0un3N1S6AmoZjCNWlBwLpUbVAgwRaQL+zYC0
	XuCWYb4Kd0faXr6UWUR2RNDMVvkx7QUXSP/UCOI0btZRpWGWfbvaoTYx4OScaPetQMSs/n
	EMiGramrUJWkcFg95sjy2peEINhMZIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735920359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55+bo0A+9eU5E9gxV+vzsiAgHMZhkqcloNbXxA/o5y8=;
	b=ObWuQHOuM+aZlBGEQyQ9t4sbSVjNeKZ9a7IdM4MOUBoftEV4IeclBelqe6p+N8qmHdSENQ
	R8dtIbXKsvyTiCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47A9B134E4;
	Fri,  3 Jan 2025 16:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HH05EecKeGdfdgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 Jan 2025 16:05:59 +0000
Date: Fri, 3 Jan 2025 17:05:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
	Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
	waxhead@dirtcellar.net
Subject: Re: [PATCH v5 04/10] btrfs: handle value associated with raid1
 balancing parameter
Message-ID: <20250103160549.GS31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1735748715.git.anand.jain@oracle.com>
 <6a303a3da8116c3743fa9be605dde540d8a60f1a.1735748715.git.anand.jain@oracle.com>
 <20250102182920.GR31418@twin.jikos.cz>
 <40c66d41-1241-4ece-b032-c165db086018@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c66d41-1241-4ece-b032-c165db086018@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6DF4C1F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Jan 03, 2025 at 08:34:12PM +0530, Anand Jain wrote:
> >> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> >> +	/* Separate value from input in policy:value format. */
> >> +	if ((value_str = strchr(param, ':'))) {
> >> +		*value_str = '\0';
> >> +		value_str++;
> >> +		if (value && kstrtou64(value_str, 10, value) != 0)
> >> +			return -EINVAL;
> > 
> > I think I've mentioned that before, this lacks validation of the
> > 'value', there should be some lower and upper bound check. Minimum can
> > be the sectorsize and maximum maybe 1G or 2G, so the u32 type is
> > sufficient.
> 
> Regarding the lack of validation, as I replied earlier, only the
> minimum needs validation, not the upper limit. A 1TB disk or SAN
> storage can be connected to a 32-bit host, and we can still read
> the full 1TB from a single mirror. IMO, it depends on the use case,
> or we can revisit it based on feedback.?

SAN is not a typical storage, what the load balancing should assume is a
set of individual rotational or ssd/nvme disks. Also 32bit host is not
something we're expecting by default.

> The patch already handles the lower limit.
> 
> $ echo round-robin:1024 > 
> /sys/fs/btrfs/b03580af-900e-4940-a7f8-3f04f9981a12/read_policy
> 
> $ cat /sys/fs/btrfs/b03580af-900e-4940-a7f8-3f04f9981a12/read_policy
> pid [round-robin:4096] devid:1
> 
> $ dmesg -k | tail -1
> BTRFS warning (device sda): read_policy: min contiguous read 1024 should 
> be multiples of the sectorsize 4096, rounded to 4096

Right.

> > The silent conversion from u64 to s64 should be avoided.
> 
> Do you mean from s64 to u64?

Yes, I've used kstrtos64 and reject negative values, then the types
match. I'm not sure about the upper bound, the idea was like 1G or 2G
but a fast NVME can do a few gigabytes per second so we may need more
than a 32bit type can hold. But it's counted in blocks it's 4G * 4K so
it's safe.

