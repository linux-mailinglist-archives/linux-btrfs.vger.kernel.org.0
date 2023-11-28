Return-Path: <linux-btrfs+bounces-412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2877FBEC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF0728263F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CF81E4B4;
	Tue, 28 Nov 2023 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="waN+1Sxk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmnB1fv2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F4A0;
	Tue, 28 Nov 2023 08:00:05 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD6E21982;
	Tue, 28 Nov 2023 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701187204;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP/XoFyHTFaJBnWFQyEgHYvMVQmUgOB2x/5RAdzmulI=;
	b=waN+1SxkH3mS/26f0AFEWeXwKDgpGsSQSD8C6wHlOQyXWKjzQxl4PtPcHw9H7U73hCkJey
	QwSRuO67dcku+ONBNM7HCkX5feP7qvXL6jeGv6ZZB4LVJu+HSOLv7HOQicWia4n9HR/Kuy
	6EU2uuNfNnOkr48mNDBXvepQZUxxrlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701187204;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP/XoFyHTFaJBnWFQyEgHYvMVQmUgOB2x/5RAdzmulI=;
	b=UmnB1fv2aJPvxd4gcFAHAbKgeCflBXREiQkNV522VftNI6SWCqIwNFdpwNV9vZKXwTJlDx
	MJJbsNYyeBAXNOCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A29D133B5;
	Tue, 28 Nov 2023 16:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XMajDYQOZmUbUAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 28 Nov 2023 16:00:04 +0000
Date: Tue, 28 Nov 2023 16:52:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: return negative -EFAULT instead of positive
Message-ID: <20231128155251.GI18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00bb6e21-484b-47d6-82fa-85c787d71a86@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bb6e21-484b-47d6-82fa-85c787d71a86@moroto.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-3.59 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.59)[98.16%]
X-Spam-Score: -3.59

On Tue, Nov 28, 2023 at 05:40:33PM +0300, Dan Carpenter wrote:
> There is a typo here and the '-' character was accidentally left off.
> 
> Fixes: 2dc8b96809b2 ("btrfs: allow extent buffer helpers to skip cross-page handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Folded to the patch, thanks.

