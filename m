Return-Path: <linux-btrfs+bounces-5714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFD907619
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 17:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E281F23D27
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DA14A08B;
	Thu, 13 Jun 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NKE1BZBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gG+I4EdM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NKE1BZBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gG+I4EdM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05F1494CF
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291358; cv=none; b=VlkRwR6onZeXPIU3AX9CEiPLAk8VnqhaUcPnjj6tYygEmn4+mlgnUE+FFgKNO4B56MEuCVVw8hs4+RtWbAlhjH50bvT+AzlX4mKlwT3xfTgpG1fa9iV0asvsflv3x4/spG7XX+uGI8CAJDVwq64GfQQQkaSSlIQw/y8OKFXcCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291358; c=relaxed/simple;
	bh=CwdN0diTtULvKum5ISzkagF0qHo7Lugvxvmf0O2h9AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1BU8p3bVU68vYhjkz/X8QzU1Z7EZ9KnKwkAoUQx3pN4h0AtqdC+4BAAqp6RRglE0kAKFr/ds8xgy9UTLcWdIQ7Yz7+crFBquIf36becd5E4zuk3i9XWBXdIT9GQgdOkClvR3uWUagb4hGph1zuqWoYZV2TaKO0xIWnIZNc/rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NKE1BZBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gG+I4EdM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NKE1BZBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gG+I4EdM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A90D1372F2;
	Thu, 13 Jun 2024 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718291353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3nPsMJwPEnsfLwDvb2p1/AQ58tVZoZldpr6/kZ5kYA=;
	b=NKE1BZBjJ/c5JbZG+vBEb8dT82TGrXqZF8L1YnWsMw6tyWp8x+A/9axkc5iGsqhVIqlnHB
	7WQ85YqTa6CU+KjLJIVO5eBDBXW7STIbqiRXGuBE+ZNVj5DKoRDrDAfdFvcc0SxmCVX+2G
	jb85suyPjgrICp8yLxHEz65jVwnVwds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718291353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3nPsMJwPEnsfLwDvb2p1/AQ58tVZoZldpr6/kZ5kYA=;
	b=gG+I4EdMBz64epvLelfTiPgbRmBh6O8oU6L5W95Ln0qLfiXe88iSoKYWYK+/7akXHgsTkP
	+/KphVzg1rCf20CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718291353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3nPsMJwPEnsfLwDvb2p1/AQ58tVZoZldpr6/kZ5kYA=;
	b=NKE1BZBjJ/c5JbZG+vBEb8dT82TGrXqZF8L1YnWsMw6tyWp8x+A/9axkc5iGsqhVIqlnHB
	7WQ85YqTa6CU+KjLJIVO5eBDBXW7STIbqiRXGuBE+ZNVj5DKoRDrDAfdFvcc0SxmCVX+2G
	jb85suyPjgrICp8yLxHEz65jVwnVwds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718291353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3nPsMJwPEnsfLwDvb2p1/AQ58tVZoZldpr6/kZ5kYA=;
	b=gG+I4EdMBz64epvLelfTiPgbRmBh6O8oU6L5W95Ln0qLfiXe88iSoKYWYK+/7akXHgsTkP
	+/KphVzg1rCf20CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8114613A7F;
	Thu, 13 Jun 2024 15:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMJSH5kLa2aJXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 15:09:13 +0000
Date: Thu, 13 Jun 2024 17:09:04 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix initial free space detection
Message-ID: <20240613150904.GW18508@suse.cz>
Reply-To: dsterba@suse.cz
References: <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
 <20240612195129.GN18508@twin.jikos.cz>
 <lxk6knivzysx6wag5ijotku3pw4agtfeytxyvqhvakfup42u77@khmgt7vbxpwp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lxk6knivzysx6wag5ijotku3pw4agtfeytxyvqhvakfup42u77@khmgt7vbxpwp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto]

On Thu, Jun 13, 2024 at 12:18:48AM +0000, Naohiro Aota wrote:
> On Wed, Jun 12, 2024 at 09:51:29PM GMT, David Sterba wrote:
> > On Tue, Jun 11, 2024 at 06:05:52PM +0900, Naohiro Aota wrote:
> > > When creating a new block group, it calls btrfs_fadd_new_free_space() to
> > > add the entire block group range into the free space
> > > accounting. __btrfs_add_free_space_zoned() checks if size ==
> > > block_group->length to detect the initial free space adding, and proceed
> > > that case properly.
> > > 
> > > However, if the zone_capacity == zone_size and the over-write speed is fast
> > > enough, the entire zone can be over-written within one transaction. That
> > > confuses __btrfs_add_free_space_zoned() to handle it as an initial free
> > > space accounting. As a result, that block group becomes a strange state: 0
> > > used bytes, 0 zone_unusable bytes, but alloc_offset == zone_capacity (no
> > > allocation anymore).
> > > 
> > > The initial free space accounting can properly be checked by checking
> > > alloc_offset too.
> > > 
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > Fixes: 98173255bddd ("btrfs: zoned: calculate free space from zone capacity")
> > > CC: stable@vger.kernel.org # 6.1+
> > > ---
> > >  fs/btrfs/free-space-cache.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > > index fcfc1b62e762..72e60764d1ea 100644
> > > --- a/fs/btrfs/free-space-cache.c
> > > +++ b/fs/btrfs/free-space-cache.c
> > > @@ -2697,7 +2697,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
> > >  	u64 offset = bytenr - block_group->start;
> > >  	u64 to_free, to_unusable;
> > >  	int bg_reclaim_threshold = 0;
> > > -	bool initial = (size == block_group->length);
> > > +	bool initial = (size == block_group->length) && block_group->alloc_offset == 0;
> > 
> > I'm not recommending to use compound conditions in the initializer block
> > as it can hide some important detail, but in this case it's both related
> > to the block group and still related to the variable name. Please put
> > the pair of ( ) to the whole expression.
> > 
> > Reviewed-by: David Sterba <dsterba@suse.com>
> 
> Sure. You mean like this?
> 
> bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));

Yes.

