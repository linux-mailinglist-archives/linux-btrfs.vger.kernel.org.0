Return-Path: <linux-btrfs+bounces-4413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D971D8A9B8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D121C22D39
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB916078D;
	Thu, 18 Apr 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="18BasJ+N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="il/7wreP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="18BasJ+N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="il/7wreP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777615E7F4
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447942; cv=none; b=fNGVPLU+84HSIMDzdmnvd7w7YwztQN0vm9MZRszC/882mQ4cmD/i8wLbpyekdzO+2He4j/Qx0G2N4Y14aELSV4qXdwRIsl24t2AGQASad3h/NBnew21K4yCgRiPS7HkYZ3thpWLDCnGB9DJblHEihvLJxOWLxSLIXhox0ZnWsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447942; c=relaxed/simple;
	bh=kSqa9BLHlpskiBmpBfze89lTIsNcDKz9XaPGe0piLvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr8Jqk8+3pX0EirlddDk0ZOcuH8xxYSj0i9aI1hWffsRFJsxgz1mbERoydbVnsuMeT0CSsuhrbfPIRSBNnFlP5ZSccdtyLShYt1Oojk++luozQ/JALu43+rNSes22fPijatzR6B2wMGwq3veDFnIz80q5zxwD/6r0odMoZBcafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=18BasJ+N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=il/7wreP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=18BasJ+N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=il/7wreP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72A1C5CB91;
	Thu, 18 Apr 2024 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713447938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVLO+IhZBRVUooHMc9IEaMsBYKCzpesK9UGqQsuz69I=;
	b=18BasJ+Nntie8lruJekPL9mPzeWoHYdYH8Fh8thqC3Tm4M5He624Llh/ruEHa/IR16TFfu
	uw6VPcDIJe0KnMDu48Nf8PI6umk7/mUNqr0VQmhJRe+6p3Kfqa4UHLrT+AZHO80LTURoQ2
	bNzjmgZrAqoI92uAoCmldWxDNeBHsoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713447938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVLO+IhZBRVUooHMc9IEaMsBYKCzpesK9UGqQsuz69I=;
	b=il/7wrePFaQWrSK5rVKaAlMKJ3AuhZQLwA1kY0sCknYcuTbqhs1fgNFj81axDO0P0n+6Bp
	XGdKHwxtTWLilUBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=18BasJ+N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="il/7wreP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713447938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVLO+IhZBRVUooHMc9IEaMsBYKCzpesK9UGqQsuz69I=;
	b=18BasJ+Nntie8lruJekPL9mPzeWoHYdYH8Fh8thqC3Tm4M5He624Llh/ruEHa/IR16TFfu
	uw6VPcDIJe0KnMDu48Nf8PI6umk7/mUNqr0VQmhJRe+6p3Kfqa4UHLrT+AZHO80LTURoQ2
	bNzjmgZrAqoI92uAoCmldWxDNeBHsoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713447938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVLO+IhZBRVUooHMc9IEaMsBYKCzpesK9UGqQsuz69I=;
	b=il/7wrePFaQWrSK5rVKaAlMKJ3AuhZQLwA1kY0sCknYcuTbqhs1fgNFj81axDO0P0n+6Bp
	XGdKHwxtTWLilUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 223C21384C;
	Thu, 18 Apr 2024 13:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDfkNwEkIWbpFQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 18 Apr 2024 13:45:37 +0000
Date: Thu, 18 Apr 2024 08:45:35 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: Re: [PATCH 00/17] btrfs: restrain lock extent usage during
 writeback
Message-ID: <qjy6xzmwpggluuwbgu4aljweoiwnrowvgklw6trn6tvwyk4wqi@akofzgx2tnms>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <ZiC1hbcG4rFFz1BM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiC1hbcG4rFFz1BM@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 72A1C5CB91
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 22:54 17/04, Christoph Hellwig wrote:
> On Wed, Apr 17, 2024 at 10:35:44AM -0400, Josef Bacik wrote:
> > discreet set of operations.  Being able to clearly define what the extent lock
> > is protecting will give us a better idea of how to reduce it's usage or possibly
> > replace it in the future.
> 
> It should also allow to stop taking it in ->read_folio and ->readahead,
> which is what is making the btrfs I/O path so weird and incompatbile
> with the rest of the kernel.  I tried to get rid of just that a while
> ago but spectacularly failed.  Maybe doing this in smaller steps and
> by someone knowning the code better is going to be more successful.
> 

The only reason I have encountered for taking extent locks during reads
is for checksums. read()s collects checksums before submitting the bio
where as writeback() adds the checksums during bio completion.

So, there is a small window where a read() performed immediately after
writeback+truncate pages would give an EIO because the checksum is
not in the checksum tree and does not match the calculated checksum.

If we can delay retrieving the checksum or wait for ordered extents to
complete before performing the read, I think avoiding extent locks
during read is possible.


-- 
Goldwyn

