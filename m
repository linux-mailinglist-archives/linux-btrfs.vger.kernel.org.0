Return-Path: <linux-btrfs+bounces-12016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D2A4F862
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 09:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105283AC495
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4C1EF0B7;
	Wed,  5 Mar 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MH+IkW4G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3pabyOn9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MH+IkW4G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3pabyOn9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DDD8837
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161715; cv=none; b=NkAmogcdl+6y/QgAgbWYTsRg3jeQscpTflt43f2AvSydBfuOEOd4Fu7cUqBV6NWX+bQ9b+o2POVfy44yZyX7kd8wuIIsDjgCK7XMxO03zHI3FQanWL2h15Rc3/WG9UVzfXrERWM4CYgfadg8h9MMpIWPNKzVRMxSk7oB8d/nrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161715; c=relaxed/simple;
	bh=7BL52QoPe33AnShF5DGRGCF6ImqqLvlMhy0Fo8VYsY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzahIn/20lNYSMSYDyCzMDtzcDHNuRvleweEMxlRxsZBHO67oEttCtOOlolAb8A+b4+EE9LtjzJnF6UE0+hQnQP1Ps6Us/xxVItgjl0XTs5HRTM6LMIaIDAmAg8QtKGnoj4keCkAYFEFdxTJHmQsWLyHVE+jezQBW0GA4VXE5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MH+IkW4G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3pabyOn9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MH+IkW4G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3pabyOn9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53BFB1F393;
	Wed,  5 Mar 2025 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741161712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZPU7khVOLeHOi07wk2l2vKH7+JIqQRqRn0aMjHTqoo=;
	b=MH+IkW4GjeDcoyLSAHjUun0pW0T19TMJKAhq3yDn4Sv4I1AMjFF23AsJRSnM0z9pJDG+Jo
	6lDKeXvTZVadcszfe0r031lbk/15FT5XPxJ7vO8G46DLZriOjwUuv4Tv1MRw8dBGvNC+b0
	Tn5umZGIVWK172RWzABVkWH1mSrKTYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741161712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZPU7khVOLeHOi07wk2l2vKH7+JIqQRqRn0aMjHTqoo=;
	b=3pabyOn9/A8MIcUzzb5lHsTsGWFjWFyWQXxleYG9SQ413CnkEZU4KJebYxcknXv4cvcnlc
	nLLfUiylLoBmX2AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741161712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZPU7khVOLeHOi07wk2l2vKH7+JIqQRqRn0aMjHTqoo=;
	b=MH+IkW4GjeDcoyLSAHjUun0pW0T19TMJKAhq3yDn4Sv4I1AMjFF23AsJRSnM0z9pJDG+Jo
	6lDKeXvTZVadcszfe0r031lbk/15FT5XPxJ7vO8G46DLZriOjwUuv4Tv1MRw8dBGvNC+b0
	Tn5umZGIVWK172RWzABVkWH1mSrKTYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741161712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZPU7khVOLeHOi07wk2l2vKH7+JIqQRqRn0aMjHTqoo=;
	b=3pabyOn9/A8MIcUzzb5lHsTsGWFjWFyWQXxleYG9SQ413CnkEZU4KJebYxcknXv4cvcnlc
	nLLfUiylLoBmX2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EDA61366F;
	Wed,  5 Mar 2025 08:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CmMpC/AEyGfgUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Mar 2025 08:01:52 +0000
Date: Wed, 5 Mar 2025 09:01:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
Message-ID: <20250305080150.GB5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250304171403.571335-1-neelx@suse.com>
 <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
 <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com>
 <29ec66bd-27a0-443e-b19b-fb759a847dcb@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ec66bd-27a0-443e-b19b-fb759a847dcb@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmx.com,fb.com,toxicpanda.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 05, 2025 at 06:14:16PM +1030, Qu Wenruo wrote:
> [...]
> >>>        /* spare for later */
> >>>        __u32 unused[4];
> >>
> >> We have enough space left here, although u32 is overkilled for
> >> compress_type, using the unused space for a new s8/s16/s32 member should
> >> be fine.
> > 
> > That is what I did originally, but discussing with Dave he suggested
> > this solution.
> 
> Normally I would be fine with the union, to save some memory.
> 
> Maybe I'm a little paranoid, but the defrag ioctl flag check is only 
> introduced last year by commit 173431b274a9 ("btrfs: defrag: reject 
> unknown flags of btrfs_ioctl_defrag_range_args").

The commit has been backported to stable trees 4.19.307 5.10.210 5.15.149
5.4.269 6.1.76 6.6.15 6.7.3 , so we could assume the flags are
validated.

> So it's possible that some older kernels don't have that commit, and may 
> incorrectly continue by ignoring the flag.
> Thankfully that should fail with -EINVAL (type always in the higher 
> bits, thus always tricking the NR_COMPRESS_TYPES check.
> 
> If that layout (type in higher bits, level in lower bits) is 
> intentionally, I'd say it's very clever.
> 
> Anyway either solution looks fine to me now.

The layout also depends on endianness, but should not matter as long as
the flgags are validated. If not, either the level is ignored or it
fails due to the >= NR_COMPRESS_TYPES check. Both should be acceptable
as fallback.

