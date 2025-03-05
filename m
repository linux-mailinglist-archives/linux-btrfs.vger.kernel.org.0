Return-Path: <linux-btrfs+bounces-12010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C3A4F7A0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC453A7D06
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E41EA7F5;
	Wed,  5 Mar 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NcL3xhQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AH4AJ9uZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NcL3xhQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AH4AJ9uZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750EA1E5B96
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158329; cv=none; b=BycRVL3oPzVWk613vaM3/hSl94felg37nddsUM2zC/ne0myWymXTgf5q3aWxanaS3tCIK2x+HLU/fFglh/lPBgNmEQctXue6MjmyGysG7/zyvoj0eMLWsQe6KFLRtbKUohWFRqvTU3QA9dYHHrZbDdilPjioStjYYfLXjE4i/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158329; c=relaxed/simple;
	bh=pBgn2Vvl8TrcsMCBj8xs+jDOIWgUFWCGYIOsPPi46X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9mHAQY4OYan9HvTmP+pkCsmMWMg5hBd4NjkeP0ASF8Q2mn1fr36gAIRSd7BODfn+BNe70A/0djlLd1oTwwvsFfHvcyPxzMa+uFEd+IyCSoDvQJNki47ZvECLKgiJ1zQFSiH7LPcEVrA214e8OthllkE55MJAMT7Z/cp+LEtQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0NcL3xhQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AH4AJ9uZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0NcL3xhQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AH4AJ9uZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A101A1F745;
	Wed,  5 Mar 2025 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741158326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1eOblpaJ1zzQavk+ic7I8+tCeMixfJT4izG2BoZoACg=;
	b=0NcL3xhQhOygjCZMygDTrkDPhYMh+HfAX1CbPgXRAZ/Eh+ubUIvlfcsrM83+EJ+i2bM20t
	pf6e+Ad2LD5xDTlgcPNXfrR9Nj79tPm6jlbxdu9qHbjEMDar7KqqTPjwTo3duaJVoWYgYZ
	2Eu6CmTxf9vvP5GnooYknYJeKzfVmSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741158326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1eOblpaJ1zzQavk+ic7I8+tCeMixfJT4izG2BoZoACg=;
	b=AH4AJ9uZmW7NWPL9P9GVj3JW+9cxiC775sOy6WAs7vkCL4JcR63w5T4likU034qndJnn7W
	CxPKaYjgKfHLi1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741158326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1eOblpaJ1zzQavk+ic7I8+tCeMixfJT4izG2BoZoACg=;
	b=0NcL3xhQhOygjCZMygDTrkDPhYMh+HfAX1CbPgXRAZ/Eh+ubUIvlfcsrM83+EJ+i2bM20t
	pf6e+Ad2LD5xDTlgcPNXfrR9Nj79tPm6jlbxdu9qHbjEMDar7KqqTPjwTo3duaJVoWYgYZ
	2Eu6CmTxf9vvP5GnooYknYJeKzfVmSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741158326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1eOblpaJ1zzQavk+ic7I8+tCeMixfJT4izG2BoZoACg=;
	b=AH4AJ9uZmW7NWPL9P9GVj3JW+9cxiC775sOy6WAs7vkCL4JcR63w5T4likU034qndJnn7W
	CxPKaYjgKfHLi1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 728FC13939;
	Wed,  5 Mar 2025 07:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zYY7G7b3x2c8QQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Mar 2025 07:05:26 +0000
Date: Wed, 5 Mar 2025 08:05:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
Message-ID: <20250305070521.GZ5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250304171403.571335-1-neelx@suse.com>
 <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
 <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 05, 2025 at 08:02:28AM +0100, Daniel Vacek wrote:
> > > @@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> > >               return -EINVAL;
> > >
> > >       if (do_compress) {
> > > -             if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> > > -                     return -EINVAL;
> > > -             if (range->compress_type)
> > > -                     compress_type = range->compress_type;
> > > +             if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> > > +                     if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
> > > +                             return -EINVAL;
> > > +                     if (range->compress.type) {
> > > +                             compress_type = range->compress.type;
> > > +                             compress_level= range->compress.level;
> > > +                     }
> >
> > I am not familiar with the compress level, but
> > btrfs_compress_set_level() does extra clamping, maybe we also want to do
> > that too?
> 
> This is intentionally left to be limited later. There's no need to do
> it at this point and the code is simpler. It's also compression
> type/method agnostic.

This is input parameter validation so we should not postpone it until
the whole process starts. The complexity can be wrapped in helpers, we
already have that for various purposes like
compression_decompress_bio().

