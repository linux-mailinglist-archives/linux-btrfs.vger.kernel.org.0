Return-Path: <linux-btrfs+bounces-8778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95DA99845B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22BD285263
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABFA1C231C;
	Thu, 10 Oct 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKiyqS+d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxwMJgXO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKiyqS+d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxwMJgXO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4B29AF
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558167; cv=none; b=jjVwm2S0J2acrVtzOTjkEoZeInozE551l8a9y0MGQQRu0ZhOafBF4IuJNy/8SdQ5Xvvg55pfH7Nyh4fWV5VzHYhZQa5X4yYWbMpBsmgtxN73ee7Zbx5rMfhhT9Ll6/CYR19K/Wx81iGMLfPoziOs4O8PkRD4HmAe6UAgWC7gvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558167; c=relaxed/simple;
	bh=OA5ovX+viFGwT8a+Sio4WS2hsoewIVmjE3MTbZOAudI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2nLVtyX5EqFqFTq52VgmqbPTEpsxbhrL9oL6QHmfDNIXrNwMSZxoRxjvE52kkrgvJZgdWQyyfCB2kmmwugOgM2ZmpUjfIYp4cfIwOJz7pAcaPFjvKGsErC2vXBHuMSBu2oRq4F23B2kUvNlvWyj4DXQm5J6SqHxo0i2iAVYgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKiyqS+d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxwMJgXO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKiyqS+d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxwMJgXO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0174A21A3D;
	Thu, 10 Oct 2024 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728558164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eojy7UB0Ls+ADn5dhn3sFyI449YO5GQQ/40GlWcTGds=;
	b=uKiyqS+db1FHP7QpXYkLQykjCYTfhThee3ePGJyo9tFqYG6PGaHFWqnL02HzOFPPQesLat
	iAhIHsgjX0H+vG6cMJdU6hwWOpvZCjyEi8YCK+uV3TL9yQ3bgVOBE/BzgQL+RXZYq5FY8K
	FtvYY5X73e5YpxoGtbMQ5xyyO1cmYDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728558164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eojy7UB0Ls+ADn5dhn3sFyI449YO5GQQ/40GlWcTGds=;
	b=vxwMJgXOZ6WfFG1EbYlRI9bMS+5kXNqdkKdqP6gMKWIzdRxvVOUnYuxqYgoW40rjcfr87j
	vDWvnzcbCwXoehDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728558164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eojy7UB0Ls+ADn5dhn3sFyI449YO5GQQ/40GlWcTGds=;
	b=uKiyqS+db1FHP7QpXYkLQykjCYTfhThee3ePGJyo9tFqYG6PGaHFWqnL02HzOFPPQesLat
	iAhIHsgjX0H+vG6cMJdU6hwWOpvZCjyEi8YCK+uV3TL9yQ3bgVOBE/BzgQL+RXZYq5FY8K
	FtvYY5X73e5YpxoGtbMQ5xyyO1cmYDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728558164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eojy7UB0Ls+ADn5dhn3sFyI449YO5GQQ/40GlWcTGds=;
	b=vxwMJgXOZ6WfFG1EbYlRI9bMS+5kXNqdkKdqP6gMKWIzdRxvVOUnYuxqYgoW40rjcfr87j
	vDWvnzcbCwXoehDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E8F13A6E;
	Thu, 10 Oct 2024 11:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WLSvM1O0B2eoJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 11:02:43 +0000
Date: Thu, 10 Oct 2024 13:02:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	WenRuo Qu <wqu@suse.com>, hch <hch@lst.de>
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
Message-ID: <20241010110234.GO1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
 <20241009165955.GM1609@twin.jikos.cz>
 <l37wmp4eebrjz3be5nbezvpdz3dm4u2ilru647yjh3dzjkbg4u@wtxtu4hxuyf4>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l37wmp4eebrjz3be5nbezvpdz3dm4u2ilru647yjh3dzjkbg4u@wtxtu4hxuyf4>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Oct 10, 2024 at 05:51:50AM +0000, Naohiro Aota wrote:
> > > -		if (bbio->bio.bi_status)
> > > -			btrfs_bbio_propagate_error(bbio, orig_bbio);
> > > +		/* Save the last error. */
> > > +		if (bbio->bio.bi_status != BLK_STS_OK)
> > > +			atomic_set(&orig_bbio->status, bbio->bio.bi_status);
> > >  		btrfs_cleanup_bio(bbio);
> > >  		bbio = orig_bbio;
> > >  	}
> > >  
> > > -	if (atomic_dec_and_test(&bbio->pending_ios))
> > > +	if (atomic_dec_and_test(&bbio->pending_ios)) {
> > > +		/* Load split bio's error which might be set above. */
> > > +		if (status == BLK_STS_OK)
> > > +			bbio->bio.bi_status = atomic_read(&bbio->status);
> > >  		__btrfs_bio_end_io(bbio);
> > > +	}
> > >  }
> > >  
> > >  static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
> > > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > > index e48612340745..b8f7f6071bc2 100644
> > > --- a/fs/btrfs/bio.h
> > > +++ b/fs/btrfs/bio.h
> > > @@ -79,6 +79,9 @@ struct btrfs_bio {
> > >  	/* File system that this I/O operates on. */
> > >  	struct btrfs_fs_info *fs_info;
> > >  
> > > +	/* Set the error status of split bio. */
> > > +	atomic_t status;
> > 
> > To repeat my comments from slack here. This should not be atomic when
> > it's using only set and read, a plain int or blk_sts_t.
> 
> Yes, I'll change this to blk_status_t for better understanding.
> 
> > 
> > The logic of storing the last error in btrfs_bio makes sense, I don't
> > see other ways to do it. If there are multiple errors we can store the
> > first one or the last one, we'd always lose some information. When it's
> > the first one it could be set by cmpxchg.
> 
> Sure. I'll use cmpxchg to save the first one.

The type blk_status_t is a u8, this works with cmpxchg, at least on
x86_64 and the common architectures.

