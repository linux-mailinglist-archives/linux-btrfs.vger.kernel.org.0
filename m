Return-Path: <linux-btrfs+bounces-15331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAD6AFCE7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F61726D0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AAC2D8787;
	Tue,  8 Jul 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0hheifsh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="grD8uj6M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1a/XHMh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3+ck6qh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EA2DEA78
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986971; cv=none; b=bRs5FJ54XIYQDnjmW08nsE+zmx7atitNMX5eMPWlkdH8eFnH286QoQ6FQsDaqviSiYE+UAmEi/2rsi1Zb/7RQtaKKeC4zZyL1xsbwCfirUsm3/AXYULNhJa0s3gnA0szRqh+D0AumNO8M6gXcU6yxgLcIwXGsVW+ja94bBFnLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986971; c=relaxed/simple;
	bh=0iQuhgHJdlMa15/+j90UF6ZSJbkPmbfRGIXFK4+jntY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXVN/7AEY3BaT4vTXXEdYseDYIXWpS84wKxzK/HfNhMqYDEqYPujDIkFM/l36nfOqF575I4YkZCjucCrr0hs+T6LBKSiezTpzEZo2j5gyie+9GDqCBhqsALi28o58QsHa7VCghi5JiqF9FFgSdFvxhsETPwMdKphwY0V0XOUaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0hheifsh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=grD8uj6M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1a/XHMh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3+ck6qh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F02441F393;
	Tue,  8 Jul 2025 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751986963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmQVh8kI7U3nd5od91PzzQKZL8gHdp1nvAKf/RF+EZ4=;
	b=0hheifshFgdobanhdTPJOwWzyqOfewF1Y2HWX9n5NMuyuKsSfHLFj2PSrWc1C31/lvwXXD
	WUIvxg/YaIOKRUDXTKBwNEKKXu7F51R7UBCHHKO0viXLncx+3EPIFkj6CxUwyCVdj6gknA
	lpFaPVyewHadvCARC9XcWM10kst/YtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751986963;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmQVh8kI7U3nd5od91PzzQKZL8gHdp1nvAKf/RF+EZ4=;
	b=grD8uj6MuYTiKycPnV2zDSuDSKwiV8LhgcCz1Fq19fJFtKiuObc4wy7/tSsKxl3svrCS9+
	n5tXERHdF/UfS4Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="a1a/XHMh";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x3+ck6qh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751986957;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmQVh8kI7U3nd5od91PzzQKZL8gHdp1nvAKf/RF+EZ4=;
	b=a1a/XHMhz6HDvnexfyORtDxsS985cky6RfyPZpjTTwCRqPvqXLCTDFgdPPi6QU2JqKwgau
	BjdaC1tdAIhIhlN8BpGc0ROqrdlineuhSouMT0j9n0a0fGpAWgFgFkOawUEuXAdY9gmYzd
	6yfZTEAMxZyx15ftnYgvXDmzavyVR34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751986957;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmQVh8kI7U3nd5od91PzzQKZL8gHdp1nvAKf/RF+EZ4=;
	b=x3+ck6qhm9I8k5yPnCBdjTU7iV0GTe7Q5ys3MgYwgI7IDcF20p0KSTJiAy7/xQRGgiZNHj
	JhML+JsvQVNOLYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D84D513A8E;
	Tue,  8 Jul 2025 15:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5laKNA0zbWh1VAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Jul 2025 15:02:37 +0000
Date: Tue, 8 Jul 2025 17:02:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
Message-ID: <20250708150221.GN4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
 <8780edf7-e89e-424c-8770-2d45ab8849d4@wdc.com>
 <43d86312-c109-4f22-9ea2-92725030f053@linaro.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d86312-c109-4f22-9ea2-92725030f053@linaro.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F02441F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,denx.de:url]
X-Spam-Score: -4.21

On Tue, Jul 08, 2025 at 03:32:55PM +0100, Andrew Goodbody wrote:
> On 08/07/2025 15:16, Johannes Thumshirn wrote:
> > On 08.07.25 13:35, Andrew Goodbody wrote:
> >> multi is guaranteed to be NULL in the first two error exit paths so the
> >> attempt to free it is not needed. Remove those calls.
> >>
> >> This issue found by Smatch.
> >>
> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> ---
> >>    fs/btrfs/volumes.c | 2 --
> >>    1 file changed, 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 5726981b19c..71b0b55b9c6 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -972,12 +972,10 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
> >>    again:
> >>    	ce = search_cache_extent(&map_tree->cache_tree, logical);
> >>    	if (!ce) {
> >> -		kfree(multi);
> >>    		*length = (u64)-1;
> >>    		return -ENOENT;
> >>    	}
> >>    	if (ce->start > logical) {
> >> -		kfree(multi);
> >>    		*length = ce->start - logical;
> >>    		return -ENOENT;
> > 
> > What tree are you working against? __btrfs_map_block() is "gone" since
> > cd4efd210edf ("btrfs: rename __btrfs_map_block to btrfs_map_block")
> > which is more than two years old.
> 
> master
> 
> https://source.denx.de/u-boot/u-boot/-/blob/master/fs/btrfs/volumes.c?ref_type=heads#L975
> 
> I am not seeing the commit you mention in master or -next.

So it's in u-boot sources, hard to notice (just by u-boot in CC list),
the paths are same as in kernel so it's confusing.

