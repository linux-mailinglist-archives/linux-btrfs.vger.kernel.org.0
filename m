Return-Path: <linux-btrfs+bounces-7665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1F964D48
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 19:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BED21C2281E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E19F1B7913;
	Thu, 29 Aug 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHdzZJoq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9cXeozJj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHdzZJoq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9cXeozJj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C64DA14
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954046; cv=none; b=DmcwcmEen490agBtaCgAEHJeQpGuIBa6oK20g+y4YzvaSllsJK8KMRX3YJ52thNrZea7GNGZ/BFWzyqxQF6GIsF9BzucTxhHH41JC/bb4NzT56HHI0COE9D8i7V2MFgR1fRLQEyPK69WQo1Wp5Pcboe/uiU2n2+9h8fJKQ27jFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954046; c=relaxed/simple;
	bh=HcSdCBmProAim7j+/jECwjTL4aMRIbh9V8ElvGp8/Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE53/CtJddLH5th4w2HYvN2LsB6t7HJwgcJe30EwZ5f+J3CyiTLTaEOXnT349emqeReeLkQ45KYJp9qzshVqr+wMfQjrJNm3LGHT1p5YvROEhzuBzWVedZxxDhC1/aMKcF/iYeL/r9b7TiFbX3F52GO5CTEUPWNWHrL4UPuO8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHdzZJoq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9cXeozJj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHdzZJoq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9cXeozJj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C953B219C5;
	Thu, 29 Aug 2024 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724954042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgUbUU3eYRPsm27ctg3xZcTdYd6Rz4IlzK2F5y7dyF0=;
	b=uHdzZJoqO1T1ff8SGPpqWQsrHQUvNCU3yXKQZx2CWYT34Vuxy/7Ex8+KQTTMIRG3wOJcPE
	UCAwNEheUBadCqpstXJDofjL3Yn0HSSDlWUsE3a6bC9ckPWtSx1662NJjWypykqn95TnV/
	jZpVENKq+8DEfK4fBnwsh/8kbiOEy7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724954042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgUbUU3eYRPsm27ctg3xZcTdYd6Rz4IlzK2F5y7dyF0=;
	b=9cXeozJjoHAgqxe6H51gfLC7hMNGaIoXpAmrV0L7++tIfyW14FksNAQcdjDUg0JJBdPsCd
	AkuEJ0Cp0qA3umBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724954042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgUbUU3eYRPsm27ctg3xZcTdYd6Rz4IlzK2F5y7dyF0=;
	b=uHdzZJoqO1T1ff8SGPpqWQsrHQUvNCU3yXKQZx2CWYT34Vuxy/7Ex8+KQTTMIRG3wOJcPE
	UCAwNEheUBadCqpstXJDofjL3Yn0HSSDlWUsE3a6bC9ckPWtSx1662NJjWypykqn95TnV/
	jZpVENKq+8DEfK4fBnwsh/8kbiOEy7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724954042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgUbUU3eYRPsm27ctg3xZcTdYd6Rz4IlzK2F5y7dyF0=;
	b=9cXeozJjoHAgqxe6H51gfLC7hMNGaIoXpAmrV0L7++tIfyW14FksNAQcdjDUg0JJBdPsCd
	AkuEJ0Cp0qA3umBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A962013408;
	Thu, 29 Aug 2024 17:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jgfYKLq10GYOEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 17:54:02 +0000
Date: Thu, 29 Aug 2024 19:53:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	josef@toxicpanda.com
Subject: Re: [PATCH 0/2] Reduce scope of extent locking while reading
Message-ID: <20240829175357.GO25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724095925.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724095925.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 19, 2024 at 04:00:51PM -0400, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Extent locking is not required for the entire read process. Once the
> extent map is read all information to retrieve is available in the
> extent map, and is cached in em_cached for later retrieval. The extent
> map cached is also refcounted so it would not disappear.
> Limit the extent locking while reading the extnet maps only. The rest is
> just creating bio and fetching/decompressing the data according to the
> extent map provided.
> 
> The only reason this was not working is because we would get EIO as
> the CRCs would not match (or were not committed to disk as yet) for
> folios that were written and released. In order to get over it, mark the
> extent as finished only after all folios are cleared of writeback.
> 
> I have run the xfstests on it without any deadlocks or corruptions.
> However, a fresh outlook on what could go wrong with a limiting the
> scope of locks would be good.
> 
> Goldwyn Rodrigues (2):
>   btrfs: clear folio writeback after completing ordered range
>   btrfs: take extent lock only while reading extent map

The first patch seems relevant but it had been sent before Josef added
the read locking updates so I don't know if it still needs to be merged.
The second patch is covered by "btrfs: do not hold the extent lock for
entire read".

