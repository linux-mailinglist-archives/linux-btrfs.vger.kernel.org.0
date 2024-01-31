Return-Path: <linux-btrfs+bounces-1965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3CE8445F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 18:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC9C1C219DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92912DD93;
	Wed, 31 Jan 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NjQsvkeF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UaS/anNL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NjQsvkeF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UaS/anNL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA312DD8F
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721616; cv=none; b=bevU3xFlIY9zTCAzwVm5nUtP/uQp2ey5KrJaUZ7ggv7ZucxH+Hot78tiywIU7Wx3NGLf9NIFu48QU57HUvTI2+GZWlHAH6+KZfQ1Kv1pGuZOVWQc3U+g5U+LqMGz/aAfLdnApxWyO7DOkcxcKCUL6bFJk7QrxMTFAgkYN/+In4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721616; c=relaxed/simple;
	bh=ESQpqisjo1Ksv8ntTcnwnPylYoI4/CSFJvjAESI5izk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg2djOgwFAY7cjdykeKjI2vMNg7z0ZTqJ0fUD9nOCNnn2GjBQkUFTRPHRfYoNyUkvaxWh3IQrAKK8ALCMrWIgcjdzgXCt8lp4SxMOahFRn0ccm0MVeJw6xFJD6+gmvOOgQYjV6Fy1TygF/gmisgwmH2dPzaIdqPSIHdEbUrWH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NjQsvkeF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UaS/anNL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NjQsvkeF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UaS/anNL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B329222018;
	Wed, 31 Jan 2024 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706721612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MpgKPWsbJmTJ560Zv+kf7YvCGxiWH9q1SMbceDAaDU=;
	b=NjQsvkeF1Qvf90RZ5QfaZIGitpKrL9RgdHM9Bni9dsPIKL06+ilCHKL+60eWTIqXj6FUi3
	vhWz/H2Qs3ybF5AE0VlwAQcGBJcJ7f3hQvJmmCFloAYMQA+6tgsEfCpwytU47KhYI0Yy96
	CoQv++35Vo241mmBNimDVLzOUyXYUOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706721612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MpgKPWsbJmTJ560Zv+kf7YvCGxiWH9q1SMbceDAaDU=;
	b=UaS/anNLZBFx2ymxz4SeaJLPoQubok3C3NAyQ1WhIrFgk2L19dhpK8M8EftRtR2uIOI6Gg
	yNlJsPTJsSrkTWAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706721612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MpgKPWsbJmTJ560Zv+kf7YvCGxiWH9q1SMbceDAaDU=;
	b=NjQsvkeF1Qvf90RZ5QfaZIGitpKrL9RgdHM9Bni9dsPIKL06+ilCHKL+60eWTIqXj6FUi3
	vhWz/H2Qs3ybF5AE0VlwAQcGBJcJ7f3hQvJmmCFloAYMQA+6tgsEfCpwytU47KhYI0Yy96
	CoQv++35Vo241mmBNimDVLzOUyXYUOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706721612;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MpgKPWsbJmTJ560Zv+kf7YvCGxiWH9q1SMbceDAaDU=;
	b=UaS/anNLZBFx2ymxz4SeaJLPoQubok3C3NAyQ1WhIrFgk2L19dhpK8M8EftRtR2uIOI6Gg
	yNlJsPTJsSrkTWAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A4701132FA;
	Wed, 31 Jan 2024 17:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VjfvJ0yBumUlGAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 17:20:12 +0000
Date: Wed, 31 Jan 2024 18:19:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: add helpers to get inode from page/folio
 pointers
Message-ID: <20240131171946.GK31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706553080.git.dsterba@suse.com>
 <86448b99cc16046569c38cdef83c41afcd8047ed.1706553080.git.dsterba@suse.com>
 <f5b412f0-9c06-4c3a-af47-d3077b79c2f6@wdc.com>
 <20240130192908.GC31555@twin.jikos.cz>
 <ab1e02ee-b1ad-44df-94af-7b788e6a63fa@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1e02ee-b1ad-44df-94af-7b788e6a63fa@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NjQsvkeF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="UaS/anNL"
X-Spamd-Result: default: False [-0.06 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.06%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.06
X-Rspamd-Queue-Id: B329222018
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, Jan 31, 2024 at 09:33:58AM +0000, Johannes Thumshirn wrote:
> On 30.01.24 20:29, David Sterba wrote:
> > On Tue, Jan 30, 2024 at 11:42:30AM +0000, Johannes Thumshirn wrote:
> >> On 29.01.24 19:33, David Sterba wrote:
> >>> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> >>> index 40f2d9f1a17a..8be09234c575 100644
> >>> --- a/fs/btrfs/misc.h
> >>> +++ b/fs/btrfs/misc.h
> >>> @@ -8,6 +8,9 @@
> >>>    #include <linux/math64.h>
> >>>    #include <linux/rbtree.h>
> >>>    
> >>> +#define page_to_inode(page)	BTRFS_I((page)->mapping->host)
> >>> +#define folio_to_inode(folio)	BTRFS_I((folio)->mapping->host)
> >>> +
> >>
> >> Why are you using a macro instead of an inline function here?
> > 
> > As said in the changelog so we don't have to include headers with full
> > definitions of page, folio, fs_info, ...
> > 
> >> Shouldn't inline function give us a bit more type safety, or are
> >> compilers smart enough nowadays?
> > 
> > Yes type safety would be good but then it can't be an inline without
> > bloating misc.h (and the making include cycles).
> 
> I personally would've put them into fs.h anyways.

Right, that's more suitable, misc.h is for all the non-fs things.

