Return-Path: <linux-btrfs+bounces-6702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EAE93CAB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691DD1C22157
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 22:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB0D13D531;
	Thu, 25 Jul 2024 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhZV8+nN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="thSnZTNr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhZV8+nN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="thSnZTNr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFBE14387B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721945382; cv=none; b=LQ8ba0vP/Jm7GgyWkcnyNvqKUsrs1EnzA6+6o30kojUJ/68A+Sy7lDsSCtMuV9rjAj90fLcUuPJ297v/iIV0j2Ync9zqqehty6P61yk+uGqW0BinN9gwof51CfPOntRNC/vTTKa1fuigTEdfZhaNBil1v4s/WA4B+qqlMdsndjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721945382; c=relaxed/simple;
	bh=g9o8I97mOfyqdF5PmNAzI13QpYLOcazEgS93Mjjhk6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIe5BgJpByzrEs403DsDDXCFNOMuYnEj9baMwUlICRujalrawhWPgEjXw1t5BTC8+ZusHXGr8gpWagT3ezlIRJhCjSYJDn1kmZA7mtbqK1WFVI+R5obfL4LMAk0sv5ncpkmQzQgvNlYuEAdNNQppOudCGZ0tITlGrgX0DoUmkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhZV8+nN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=thSnZTNr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhZV8+nN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=thSnZTNr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CEE51F831;
	Thu, 25 Jul 2024 22:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721945378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llWBF3BVYFU1MrEWD3r/uuAlqIRgxOonrEAJh+Tz5o4=;
	b=lhZV8+nNfER26mCheTnGpaYftluuFN04WfmDx4Mp+ISPM2DZESmulADLvRxruEIKfjHgpC
	XWjlJP4gPaqEHyyo1kBuzAXFrvTEVHTYH/Q7cvawSb8TUKRgqp9qToaZa3nzFZSLH7Jvcq
	31a4D37yhq0JacYyYLuIGwkDeXXpjnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721945378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llWBF3BVYFU1MrEWD3r/uuAlqIRgxOonrEAJh+Tz5o4=;
	b=thSnZTNrkFRLoLKHl6yyKEZSz4RWOS+cCF7Gu8B1BKL8/QQUelxZcyTLoCRIUFOqyaUlcO
	f2SmENRHnh1OLjCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721945378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llWBF3BVYFU1MrEWD3r/uuAlqIRgxOonrEAJh+Tz5o4=;
	b=lhZV8+nNfER26mCheTnGpaYftluuFN04WfmDx4Mp+ISPM2DZESmulADLvRxruEIKfjHgpC
	XWjlJP4gPaqEHyyo1kBuzAXFrvTEVHTYH/Q7cvawSb8TUKRgqp9qToaZa3nzFZSLH7Jvcq
	31a4D37yhq0JacYyYLuIGwkDeXXpjnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721945378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llWBF3BVYFU1MrEWD3r/uuAlqIRgxOonrEAJh+Tz5o4=;
	b=thSnZTNrkFRLoLKHl6yyKEZSz4RWOS+cCF7Gu8B1BKL8/QQUelxZcyTLoCRIUFOqyaUlcO
	f2SmENRHnh1OLjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A72D1368A;
	Thu, 25 Jul 2024 22:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z9tzGSLNomboGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jul 2024 22:09:38 +0000
Date: Fri, 26 Jul 2024 00:09:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: scrub: update last_physical more frequently
Message-ID: <20240725220937.GC17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1721627526.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721627526.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon, Jul 22, 2024 at 03:25:47PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Rebased to the latest for-next branch
>   No conflict at all
> 
> - Rewording the second patch
>   There are two problems, one is serious (no last_physical update at
>   all for almost full data chunks), the other one is just inconvenient
>   (slow update on "btrfs scrub status").
> 
> - Add the missing spinlock
>   It's mentioned in the commit messages but not in the code
> 
> There is a report in the mailling list that scrub only updates its
> @last_physical at the end of a chunk.
> In fact, it can be worse if there is a used stripe (aka, some extents
> exist in the stripe) at the chunk boundary.
> As it would skip the @last_physical for that chunk at all.
> And for large fses, there are ensured to be several almost full data 
> 
> With @last_physical not update for a long time, if we cancel the scrub
> halfway and resume, the resumed one scrub would only start at
> @last_physical, meaning a lot of scrubbed extents would be re-scrubbed,
> wasting quite some IO and CPU.
> 
> This patchset would fix it by updateing @last_physical for each finished
> stripe (including both P/Q stripe of RAID56, and all data stripes for
> all profiles), so that even if the scrub is cancelled, we at most
> re-scrub one stripe.
> 
> Qu Wenruo (2):
>   btrfs: extract the stripe length calculation into a helper
>   btrfs: scrub: update last_physical after scrubing one stripe

Reviewed-by: David Sterba <dsterba@suse.com>

