Return-Path: <linux-btrfs+bounces-8123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F07297C994
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82171F244DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC819E7F0;
	Thu, 19 Sep 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mvWpO0Po";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R+yPHDBI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mvWpO0Po";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R+yPHDBI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90419AD8D;
	Thu, 19 Sep 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750537; cv=none; b=To1auZVCs6HUj68BSddLaFgqsucbaJdSUTi8Qq+XtLSw+IBmGx3vhos0IulO00B77pNYTSiumuxY2PbYwIqIYdFb1Yd0Cf2SjhAcW+bWEGefMhM5282Tyu/rObzH0N4dZANd8UQvh8AWEq9lxpfBBEJZdV/wRTq/xO/jCLf8fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750537; c=relaxed/simple;
	bh=uPk7QPnox1EKt4Oc2lIbYdayFzNPigxxINMuiljTa+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em4n0MnX+IxgT51rNLkrBC5TrVOKWcNwUm2RaMxVJscPAn3/BSjoGY2Kz+bCY8jvHuSnEyezSbzh53dC+hq5qtvY9LmlbnsiDgEoTqvD/Xj7Jev2HeqYjXCkz3piUYDfTWISypCQUnHgTvKyl3WgPuIrjUg8CV95hJIGqSsfae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mvWpO0Po; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R+yPHDBI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mvWpO0Po; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R+yPHDBI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32B9F20922;
	Thu, 19 Sep 2024 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726750533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J035lXz9NqS2T7rqPIx+v9m10/fpl5HiwgmW9zEOxDQ=;
	b=mvWpO0PoJvQa/GgqpFIRNNRh1hddqeLTEahw+JwzJsCgXy5jESa520Hq33eo6UC0d4lU6y
	8HxDLbHF5Tmrxv0q/7UM460XvqXY8qRC1CCobXBN7XChY+bvDSRDdtOuvFP9wV15OWV0Wf
	Iegk9ElaJfdkOmi+fFmEly/YP8GFuV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726750533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J035lXz9NqS2T7rqPIx+v9m10/fpl5HiwgmW9zEOxDQ=;
	b=R+yPHDBIGnvUjbSeN57UebxkIBNmiIGc1hj7+FSRIMQnEjoBwKWNEaOn4oapqQb3BJTeTz
	DXSwg+A1JD8KgYBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726750533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J035lXz9NqS2T7rqPIx+v9m10/fpl5HiwgmW9zEOxDQ=;
	b=mvWpO0PoJvQa/GgqpFIRNNRh1hddqeLTEahw+JwzJsCgXy5jESa520Hq33eo6UC0d4lU6y
	8HxDLbHF5Tmrxv0q/7UM460XvqXY8qRC1CCobXBN7XChY+bvDSRDdtOuvFP9wV15OWV0Wf
	Iegk9ElaJfdkOmi+fFmEly/YP8GFuV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726750533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J035lXz9NqS2T7rqPIx+v9m10/fpl5HiwgmW9zEOxDQ=;
	b=R+yPHDBIGnvUjbSeN57UebxkIBNmiIGc1hj7+FSRIMQnEjoBwKWNEaOn4oapqQb3BJTeTz
	DXSwg+A1JD8KgYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1329E13A1E;
	Thu, 19 Sep 2024 12:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OimABEUf7GZCMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Sep 2024 12:55:33 +0000
Date: Thu, 19 Sep 2024 14:55:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] btrfs: Don't block system suspend during fstrim
Message-ID: <20240919125531.GL2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Tue, Sep 17, 2024 at 10:33:03PM +0200, Luca Stefani wrote:
> Changes since v5:
> * Make chunk size a define
> * Remove superfluous trim_interrupted checks
>   after moving them to trim_no_bitmap/trim_bitmaps
> 
> Changes since v4:
> * Set chunk size to 1G
> * Set proper error return codes in case of interruption
> * Dropped fstrim_range fixup as pulled in -next
> 
> Changes since v3:
> * Went back to manual chunk size
> 
> Changes since v2:
> * Use blk_alloc_discard_bio directly
> * Reset ret to ERESTARTSYS
> 
> Changes since v1:
> * Use bio_discard_limit to calculate chunk size
> * Makes use of the split chunks
> 
> Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/
> v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
> v2: https://lore.kernel.org/lkml/20240902205828.943155-1-luca.stefani.ge1@gmail.com/
> v3: https://lore.kernel.org/lkml/20240903071625.957275-4-luca.stefani.ge1@gmail.com/
> v4: https://lore.kernel.org/lkml/20240916101615.116164-1-luca.stefani.ge1@gmail.com/
> v5: https://lore.kernel.org/lkml/20240916125707.127118-1-luca.stefani.ge1@gmail.com/
> 
> ---
> 
> NB: I didn't change btrfs_discard_workfn yet to add error checks
> as I don't know what semantics we should have in that case.
> The work queue is always re-scheduled and created with WQ_FREEZABLE
> so it should be automatically frozen. Shall I simply add some logs?
> 
> ---
> 
> Luca Stefani (2):
>   btrfs: Split remaining space to discard in chunks
>   btrfs: Don't block system suspend during fstrim

Added to for-next, with some minor updates to changelogs. Thanks.

