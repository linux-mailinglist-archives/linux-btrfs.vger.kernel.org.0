Return-Path: <linux-btrfs+bounces-19140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B34C6E33E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 12:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6821E34BC10
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A4350290;
	Wed, 19 Nov 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQcCiAGv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hHZVMwCd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQcCiAGv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hHZVMwCd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD033C535
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551001; cv=none; b=ouGnrBDzW0U0X1OP3I7fW+Dv+bC8gOtmH7+SCygNwuTseq7Bnh5V9DEw3t6HmYo3Vw6IH71KD/44Bzoam0GjIKEl0q0eMxF7F2FvqmWFD3VaE0YjD0//4K2XY18X4HrDfBBzKprhhvM4ZDf2T6gxpixvFgCCqPOz4HMmrhpLhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551001; c=relaxed/simple;
	bh=b0wjXH/fCdS5Uzd4QqbRm8DO1WAHaaoIPKvMn47CZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XahlJDIFCuVtNrpq27UTBiNsTahncJ9J+fYyAcWPcmZSkiO8QfVPuOylxj7OUQKbg8FayzRELojTiBLa7JEyuDQij1pYYRGpsat7wB8W4Ujhj56HbWaJkX9n3ozeWfty4sYX5me6G5MXF95MKNgRpxOqeO+U97VC3cojunacO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQcCiAGv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hHZVMwCd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQcCiAGv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hHZVMwCd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E88F21197;
	Wed, 19 Nov 2025 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763550998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1v+mWqw2JDxAuCXumjAMxX7Ybl4ARtt42yeCKVwYqI=;
	b=mQcCiAGvCuSZiJF0Y0W9bL/sV4hLBHC4RQJ3MlaxmrBWW2OLspsmHMXrhfNBrlwP3Qdway
	0C7WoSDgnlAF3Z8UuG6gvXQ40//oWbrD2WsbP6hWJQnhnX/GnVdO6UuOQiXqnm2OxWS/Nd
	b/HIfEiruR/3i8Okd5wYs6u6BckG1fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763550998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1v+mWqw2JDxAuCXumjAMxX7Ybl4ARtt42yeCKVwYqI=;
	b=hHZVMwCdQNJcsEa1TM78KKRxJUrBIzzbMmEYd0kD59gj5J+3iZMbq+ykpIxGi5u83gvpUZ
	A+zmaSV7fhQ3OhCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763550998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1v+mWqw2JDxAuCXumjAMxX7Ybl4ARtt42yeCKVwYqI=;
	b=mQcCiAGvCuSZiJF0Y0W9bL/sV4hLBHC4RQJ3MlaxmrBWW2OLspsmHMXrhfNBrlwP3Qdway
	0C7WoSDgnlAF3Z8UuG6gvXQ40//oWbrD2WsbP6hWJQnhnX/GnVdO6UuOQiXqnm2OxWS/Nd
	b/HIfEiruR/3i8Okd5wYs6u6BckG1fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763550998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1v+mWqw2JDxAuCXumjAMxX7Ybl4ARtt42yeCKVwYqI=;
	b=hHZVMwCdQNJcsEa1TM78KKRxJUrBIzzbMmEYd0kD59gj5J+3iZMbq+ykpIxGi5u83gvpUZ
	A+zmaSV7fhQ3OhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4656E3EA61;
	Wed, 19 Nov 2025 11:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bUkDERanHWn8OAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Nov 2025 11:16:38 +0000
Date: Wed, 19 Nov 2025 12:16:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] btrfs: add fscrypt support, PART 1
Message-ID: <20251119111633.GD13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251118160845.3006733-1-neelx@suse.com>
 <aR1-h75CvzMHmsJQ@infradead.org>
 <20251119085941.GC13846@twin.jikos.cz>
 <aR2InP3qFS19AFrx@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2InP3qFS19AFrx@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Nov 19, 2025 at 01:06:36AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 09:59:41AM +0100, David Sterba wrote:
> > On Wed, Nov 19, 2025 at 12:23:35AM -0800, Christoph Hellwig wrote:
> > > Patches 1 to 3 just add dead code without the actual fscrypt support,
> > > which you've not even posted anywhere never mind having queued it up.
> > > Please don't add this kind of code without the user in the same series.
> > 
> > The fscrypt series is about 50 patches, last v5 iteration is at [1] and
> > I suggested to pick any independent patches we could ahead of time.
> 
> Getting any independent work in first is always a good idea.  Patches 4-6
> fit that, but patches 1-3 are everything but.

We already have fscrypt preparations code that is not yet used, this is
not different.

