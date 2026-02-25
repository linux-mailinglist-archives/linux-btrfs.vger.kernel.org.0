Return-Path: <linux-btrfs+bounces-21901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNpsL39JnmnXUQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21901-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 01:59:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A518E72D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 01:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F563047015
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 00:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EA3242D89;
	Wed, 25 Feb 2026 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yj0Gqh2V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMmcPOlZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yj0Gqh2V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMmcPOlZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152823AB81
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981167; cv=none; b=bG1dVsLr/4e5uEjE7QAkIJIcs0O+DI3dG9HOa+DfpQoXAnHjf17KG58xnjDCtBiyawPgtL/uGYlUuwm5A4SL6VjYhy9KvJkKEpZZ+/vcuTploCmUDAex71KQOcv9LLYCJR0Ai2C3OC6bOHL/4k6/iuuR6B1zrVxFlljGm7UhxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981167; c=relaxed/simple;
	bh=1GqvezyjnuJxiXk9ujGupMmqIUnM2kAKjikLrJRrU9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3m6HZbtnOylAHZ8cibzY1LDYOdjrresm2rSUMsSIh4omvKCHhV7XrKfOw5CpJqW+GB1/36Hve+y61q/vTxvV3fiC63E3FqEZ/a+kWn9aZrfMDzSF+R/T/tQXAVMCgWdOVxrxZ8J5sym2nhGh7fz8lT/bLbcYNM3S0PTc7wjWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yj0Gqh2V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMmcPOlZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yj0Gqh2V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMmcPOlZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4582E5BD4C;
	Wed, 25 Feb 2026 00:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771981164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzlvrP8PhmF9KiYVAKiZQXjzeFk9XZJyNq0ri4FA/u8=;
	b=yj0Gqh2VzlVtV8MeRIY4Aukoae0hNnE6AaZHxVKjCuIyMcZQvfZJUCPOjXlcGzE0uPlqy2
	ULm/R0xcVG1GVn/knX+IRPDw5f+1i4jr+K51pZTW54iWQkApcv9X/VumF0xcfu8VKwd5S9
	vSFR3mi40x/jv5cZyLJ44GPRZS6Tel0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771981164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzlvrP8PhmF9KiYVAKiZQXjzeFk9XZJyNq0ri4FA/u8=;
	b=nMmcPOlZwBm/x0DqsLaKmcSHVa1FX9CUwleDGXxsJpaLHFWlKrzelD640GSXVSktC75M7t
	58T9PhQhct+Sz6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771981164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzlvrP8PhmF9KiYVAKiZQXjzeFk9XZJyNq0ri4FA/u8=;
	b=yj0Gqh2VzlVtV8MeRIY4Aukoae0hNnE6AaZHxVKjCuIyMcZQvfZJUCPOjXlcGzE0uPlqy2
	ULm/R0xcVG1GVn/knX+IRPDw5f+1i4jr+K51pZTW54iWQkApcv9X/VumF0xcfu8VKwd5S9
	vSFR3mi40x/jv5cZyLJ44GPRZS6Tel0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771981164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzlvrP8PhmF9KiYVAKiZQXjzeFk9XZJyNq0ri4FA/u8=;
	b=nMmcPOlZwBm/x0DqsLaKmcSHVa1FX9CUwleDGXxsJpaLHFWlKrzelD640GSXVSktC75M7t
	58T9PhQhct+Sz6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C7763EA65;
	Wed, 25 Feb 2026 00:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OWS9BmxJnmkxawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 25 Feb 2026 00:59:24 +0000
Date: Wed, 25 Feb 2026 01:59:18 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: introduce a common helper to calculate the
 size of a bio
Message-ID: <20260225005918.GD26902@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1771558832.git.wqu@suse.com>
 <4392c94fea9644702e3985c30cf0a30c434aa3d5.1771558832.git.wqu@suse.com>
 <20260224141518.GV26902@twin.jikos.cz>
 <b040a823-cfe7-42b2-97b4-3f6ba80f98d1@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b040a823-cfe7-42b2-97b4-3f6ba80f98d1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21901-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 242A518E72D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:32:48AM +1030, Qu Wenruo wrote:
> 在 2026/2/25 00:45, David Sterba 写道:
> > On Fri, Feb 20, 2026 at 02:11:50PM +1030, Qu Wenruo wrote:
> >> We have several call sites doing the same work to calculate the size of
> >> a bio:
> >>
> >> 	struct bio_vec *bvec;
> >> 	u32 bio_size = 0;
> >> 	int i;
> >>
> >> 	bio_for_each_bvec_all(bvec, bio, i)
> >> 		bio_size += bvec->bv_len;
> >>
> >> We can use a common helper instead of open-coding it everywhere.
> >>
> >> This also allows us to constify the @bio_size variables used in all the
> >> call sites.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/misc.h   | 15 +++++++++++----
> >>   fs/btrfs/raid56.c |  9 ++-------
> >>   fs/btrfs/scrub.c  | 22 ++++------------------
> >>   3 files changed, 17 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> >> index 12c5a9d6564f..189c25cc5eff 100644
> >> --- a/fs/btrfs/misc.h
> >> +++ b/fs/btrfs/misc.h
> >> @@ -52,15 +52,22 @@ static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_iter *iter)
> >>   	     (paddr = bio_iter_phys((bio), (iter)), 1);			\
> >>   	     bio_advance_iter_single((bio), (iter), (blocksize)))
> >>   
> >> -/* Initialize a bvec_iter to the size of the specified bio. */
> >> -static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
> >> +/* Can only be called on a non-cloned bio. */
> > 
> > Please also add an ASSERT for that.
> 
> You know how I like to add ASSERT()s almost everywhere, but for this 
> it's already implied.
> 
> bio_first_bvec_all() has a WARN_ON_ONCE() line for it already.

Ok that's good, I didn't know that.

