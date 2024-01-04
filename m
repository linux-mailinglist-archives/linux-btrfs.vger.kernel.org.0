Return-Path: <linux-btrfs+bounces-1241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FFF82454C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DC3284BCA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFAE249EC;
	Thu,  4 Jan 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4ybWtGJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jszUWf12";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4ybWtGJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jszUWf12"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67469241ED
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 405A01F817;
	Thu,  4 Jan 2024 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704383166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRNAgQZrfn8e0W7w8U0DhzjRN6Lwkq8LQwfaw23gApo=;
	b=w4ybWtGJNB7y2jn8fc0bCLDS1/HyEI8TxsCNz6spB3cHzGgAPOZ9KRNjsCI094AtUhzh2b
	/DTbIde8SlKYbhSMDgOm5Nc6UCHZWcWdG6IteyArrWdl61XGJqcgUGHjSZKZVZQFQCn0YM
	ndME5lhLe9a6ZVY1AasxohGCV6gpLrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704383166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRNAgQZrfn8e0W7w8U0DhzjRN6Lwkq8LQwfaw23gApo=;
	b=jszUWf12WCUePODyhckq6116duPl9loNlj930P12ccxyf85SiRXJAWYPUQp5iHrSbrFezO
	BUyRpHFPPY8S8kCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704383166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRNAgQZrfn8e0W7w8U0DhzjRN6Lwkq8LQwfaw23gApo=;
	b=w4ybWtGJNB7y2jn8fc0bCLDS1/HyEI8TxsCNz6spB3cHzGgAPOZ9KRNjsCI094AtUhzh2b
	/DTbIde8SlKYbhSMDgOm5Nc6UCHZWcWdG6IteyArrWdl61XGJqcgUGHjSZKZVZQFQCn0YM
	ndME5lhLe9a6ZVY1AasxohGCV6gpLrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704383166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRNAgQZrfn8e0W7w8U0DhzjRN6Lwkq8LQwfaw23gApo=;
	b=jszUWf12WCUePODyhckq6116duPl9loNlj930P12ccxyf85SiRXJAWYPUQp5iHrSbrFezO
	BUyRpHFPPY8S8kCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 291D813722;
	Thu,  4 Jan 2024 15:46:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mPblCb7SlmUgVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jan 2024 15:46:06 +0000
Date: Thu, 4 Jan 2024 16:45:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: zoned: fix bandwidth degradaton
Message-ID: <20240104154554.GD15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1702913643.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702913643.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w4ybWtGJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jszUWf12
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.79%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 405A01F817
X-Spam-Flag: NO

On Mon, Dec 18, 2023 at 04:01:55PM +0000, Naohiro Aota wrote:
> Writing sequentially to a huge file on btrfs on a SMR HDD revealed a
> decline of the performance (220 MiB/s to 30 MiB/s after 500 minutes). As
> shown in the attached plot, current btrfs exponentially drops its
> performance.
> 
> The drop is because find_free_extent() need to traverse a lot of full block
> groups, trying to find a space.
> 
> This series fixes the performance drop by choosing a proper block group
> from the zone_active_bgs. Since the list does not contain full block
> groups, there is no need of traversing the full BGs. 
> 
> Naohiro Aota (2):
>   btrfs: zoned: split out prepare_allocation_zoned()
>   btrfs: zoned: optimize hint byte for zoned allocator

Added to misc-next, thanks.

