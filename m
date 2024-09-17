Return-Path: <linux-btrfs+bounces-8090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C168C97B337
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5364F1F25541
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54817BEBA;
	Tue, 17 Sep 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R6Zk6NjE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jAWFQccT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R6Zk6NjE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jAWFQccT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360317BB25
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592394; cv=none; b=kBpp89GbtTYqddGTBUQESkB3gX2l6vsJ8dkHAOAzVJnt39//3pI8yIT/iqMJfPyFl+X32tqS4tOICInA1Vf4sAhIGDC7xuOfiEWTivupRCZnIXLMcZ7WZZCHAcsdVH0cn9341saTEIXzK822fImqjnxDQ2+cr5RCx2/lQj9IIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592394; c=relaxed/simple;
	bh=eoH/+QpNFN8UI+aYDnFmiHKz4bGvrYPe3DZYEp2wL3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUQw/yhtf3X1lofugupsB4gQJa3st3YXd9KciBafa2KcVyy9TPCcNKmO8i4OoyRkkPgIs823d1Ia+gAXhZTS/exv2eipYG5hV8Qy60vnoMQje7+Yo+J9FCkXmcSeeTTWRAPdIxd+AGsPt3Y5TH6GrTRdU54FCgVcyhc5oA7FJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R6Zk6NjE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jAWFQccT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R6Zk6NjE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jAWFQccT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D5CA22367;
	Tue, 17 Sep 2024 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726592390;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVeyJSdTBVAtGQyrZhYZAEM09RkDjKlUzuCb9vrFeK8=;
	b=R6Zk6NjEDi9Sk1H90XL0p6WxzMMaANA1VlX1moYJ2aAJ6a7ZRGa7YukS5MfnglYXjdeTDh
	LPwKWrxzvRCIAL3axXDeZ4Um+wnC4ffU/EqEoXPCoC9UxryS4RcgQVXyvHzKsJ5sI5hrhA
	Q/pmT1OA+mT33Rporbba9/y7+xLvisc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726592390;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVeyJSdTBVAtGQyrZhYZAEM09RkDjKlUzuCb9vrFeK8=;
	b=jAWFQccTneqS1+fCAz5MSOo9AOnmPitVEbYrBL0cnvrw+9moN4ZBVwjol/83qNS/eILOLH
	S32pvaMXFEwS2UCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R6Zk6NjE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jAWFQccT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726592390;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVeyJSdTBVAtGQyrZhYZAEM09RkDjKlUzuCb9vrFeK8=;
	b=R6Zk6NjEDi9Sk1H90XL0p6WxzMMaANA1VlX1moYJ2aAJ6a7ZRGa7YukS5MfnglYXjdeTDh
	LPwKWrxzvRCIAL3axXDeZ4Um+wnC4ffU/EqEoXPCoC9UxryS4RcgQVXyvHzKsJ5sI5hrhA
	Q/pmT1OA+mT33Rporbba9/y7+xLvisc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726592390;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVeyJSdTBVAtGQyrZhYZAEM09RkDjKlUzuCb9vrFeK8=;
	b=jAWFQccTneqS1+fCAz5MSOo9AOnmPitVEbYrBL0cnvrw+9moN4ZBVwjol/83qNS/eILOLH
	S32pvaMXFEwS2UCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5754C139CE;
	Tue, 17 Sep 2024 16:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cioYFYa16WZfbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 16:59:50 +0000
Date: Tue, 17 Sep 2024 18:59:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not assume the full page range is not dirty in
 extent_writepage_io()
Message-ID: <20240917165941.GH2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6239c8bb8ce319c2940d6469ffcb7f5f6641db79.1726011300.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6239c8bb8ce319c2940d6469ffcb7f5f6641db79.1726011300.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6D5CA22367
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Sep 11, 2024 at 09:51:02AM +0930, Qu Wenruo wrote:
> The function extent_writepage_io() will submit the dirty sectors inside
> the page for the write.
> 
> But recently to co-operate with the incoming subpage compression
> enhancement, a new bitmap is introduced to
> btrfs_bio_ctrl::submit_bitmap, to only avoid a subset of the dirty
> range.
> 
> This is because we can have the following cases with 64K page size:
> 
>     0      16K       32K       48K       64K
>     |      |/////////|         |/|
>                                  52K
> 
> For range [16K, 32K), we queue the dirty range for compression, which is
> ran in a delayed workqueue.
> Then for range [48K, 52K), we go through the regular submission path.
> 
> In that case, our btrfs_bio_ctrl::submit_bitmap will exclude the range
> [16K, 32K).
> 
> The dirty flags for the range [16K, 32K) is only cleared when the
> compression is done, by the extent_clear_unlock_delalloc() call inside
> submit_one_async_extent().
> 
> This patch fix the false alert by removing the
> btrfs_folio_assert_not_dirty() check, since it's no longer correct for
> subpage compression cases.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This should be the last patch before the enablement of sector perfect
> compression support for subpage.
> 
> Locally I have already been testing the sector perfect compression, and
> that's the last fix.
> 
> All the subpage related fixes can be applied out of order as long as the
> final enablement patch is at the end of the queue, but for now
> my local branch has the following patch order (git log sequence):
> 
>  btrfs: allow compression even if the range is not page aligned
>  btrfs: do not assume the full page range is not dirty in extent_writepage_io()
>  btrfs: make extent_range_clear_diryt_for_io() to handle sector size < page size cases
>  btrfs: wait for writeback if sector size is smaller than page size
>  btrfs: compression: add an ASSERT() to ensure the read-in length is sane
>  btrfs: zstd: make the compression path to handle sector size < page size
>  btrfs: zlib: make the compression path to handle sector size < page size

That's great news. I don't think there's anything else of comparable
size missing from the subpage support.

We're now in the middle of merge window but as the pull request has been
merged there's nothing blocking for-next so you can post the patches and
then add them.

