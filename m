Return-Path: <linux-btrfs+bounces-12058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516CA552B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB817A795C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F625C6EE;
	Thu,  6 Mar 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhC/gnkw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dIiXdl4O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhC/gnkw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dIiXdl4O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9B2144BF
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281387; cv=none; b=DnVeEeOM6ur+Xldm4yHk96zdNxZyr58viT/G0rENu8buCPM5gkCYi3NVQ2l3i7GHGJLpemSIlHNorb44smB7FbDLNfqXu3Cz4fz4ZtrErt5QwMxVwM2YJIGstMeyf9RmH3EpPrq8X7fGYPVzdkRHtoNHsXARACCobr2ZVWrI0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281387; c=relaxed/simple;
	bh=XiPNr+xW3i7ZHIapSVpGaefvY/pz7sDtSpKJq+G3voA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD8fTdmzrY0qSCT5AtEW8C/3Sa7xgLCtipp/bKwpF6Tso9E4bw/d9xYBLru0FGu6IuWbfjrgIlXJIZKo/IMQlQg0IaBHeJF962LzNRRgth1IgREQ8PSp7nln2H3OR3DlT/bTyARuRFQ3TMtLZgVRsXvDDlWypuqYxSK9rp5dUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhC/gnkw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dIiXdl4O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhC/gnkw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dIiXdl4O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 026A91F8BB;
	Thu,  6 Mar 2025 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741281384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2vuFY3kKP2iqWnCR3kOBl8o8A2I13iwS3PRqUbyO3A=;
	b=fhC/gnkwai0DAOooOcNaFBNkgQ4nUXCFzTDLcsStN51C4Qc1SAt4WU3RTprqSpmCYPM1MN
	OIw1W8ero26T0uMLVR5Eu5N6f2B/6Cl2Hq3hOPVDQ8+QgvvEbQLD9mLldp05Swz7MDJT36
	D9ugKXKYldC4Sc5yI5IDh/r6tSIuXnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741281384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2vuFY3kKP2iqWnCR3kOBl8o8A2I13iwS3PRqUbyO3A=;
	b=dIiXdl4OS94YVYvlyxsOfa7v1XUGQ79Jorh2FkUyclD6ZiS0rBGfVnAuULUSr54BQsQpn3
	EwrXAVtj5rKz6ZAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="fhC/gnkw";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dIiXdl4O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741281384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2vuFY3kKP2iqWnCR3kOBl8o8A2I13iwS3PRqUbyO3A=;
	b=fhC/gnkwai0DAOooOcNaFBNkgQ4nUXCFzTDLcsStN51C4Qc1SAt4WU3RTprqSpmCYPM1MN
	OIw1W8ero26T0uMLVR5Eu5N6f2B/6Cl2Hq3hOPVDQ8+QgvvEbQLD9mLldp05Swz7MDJT36
	D9ugKXKYldC4Sc5yI5IDh/r6tSIuXnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741281384;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2vuFY3kKP2iqWnCR3kOBl8o8A2I13iwS3PRqUbyO3A=;
	b=dIiXdl4OS94YVYvlyxsOfa7v1XUGQ79Jorh2FkUyclD6ZiS0rBGfVnAuULUSr54BQsQpn3
	EwrXAVtj5rKz6ZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D67A913A61;
	Thu,  6 Mar 2025 17:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rhXVM2fYyWdWOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Mar 2025 17:16:23 +0000
Date: Thu, 6 Mar 2025 18:16:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs/defrag: implement compression levels
Message-ID: <20250306171621.GK5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250304171403.571335-1-neelx@suse.com>
 <20250306131537.972377-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306131537.972377-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 026A91F8BB
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 06, 2025 at 02:15:35PM +0100, Daniel Vacek wrote:
> The zstd and zlib compression types support setting compression levels.
> Enhance the defrag interface to specify the levels as well.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> v3: Validate the level instead of clamping and fix the comment of the
>     btrfs_ioctl_defrag_range_args structure.

Thanks, this looks good to me now, I'll add it to for-next.

