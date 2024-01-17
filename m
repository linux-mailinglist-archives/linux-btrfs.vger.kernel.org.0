Return-Path: <linux-btrfs+bounces-1497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A859E82FE1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 01:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD0D289466
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 00:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C410FF;
	Wed, 17 Jan 2024 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z02cqtKw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gg9CDxmg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z02cqtKw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gg9CDxmg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737680C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452946; cv=none; b=PwHr2/3apNN6QMpRDWtHghNMNpjEpao9OAXvF2yHXXKQaauHfjg0oRL2mGRqd60EJpX6bvzSkmkm9Q1eXpM9zlxpCmS/ubY1iSifd7dQ9TFWAWxMvPcSjwgv6Bi9UiiNOVA/xSqD0NeONLUEmIkfFpy1aaM53ZRQAPw5bffuC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452946; c=relaxed/simple;
	bh=MCTAOxAmlpO8D9S6iIsUBysvOMA15Ngz80wldOfZcgI=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Spam-Score:X-Spamd-Result:X-Spam-Flag; b=eJIcvgsWxgHaYU4aIpxSZ9kZ2Z5riousSAeeZix9w48KtCHpXQkHSkOaN1cSO5pF/uL4jEDqJ90JAvC2H+ZnnPFRBfffgE6Bb4i9SzSIik6Fyi/erNYCq6nJl18tKz7MUOL4Qt2+eItY+2BS0gvXIbZX4k2eymLgWuJ+FtqmSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z02cqtKw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gg9CDxmg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z02cqtKw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gg9CDxmg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2308D220F6;
	Wed, 17 Jan 2024 00:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705452943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6OzYhbi2M2GdQZAe+rWpXNW77C07aqbbtVLrrE4RIc=;
	b=z02cqtKwsqPZQORLgc9KK4fH2FGsLoFw3whl334PhKVs6Uth/om0rk4IWUIDubOMdnzw97
	E+mQKnKvrhJfy/SIr8z5tn4Yrje+hpcn6PphbitpOjuycO1qsFcFEbyoRqFEiBtA7vifY8
	WGQWRU2HrU/Eu9ioeiE7kdTok5XZBsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705452943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6OzYhbi2M2GdQZAe+rWpXNW77C07aqbbtVLrrE4RIc=;
	b=gg9CDxmgSF4+CxqiQoZk33hhkhDelwmOPNrahqk2qAKc3cqOtsiUmh2n1e9ea5jibCPJTg
	zQsmBW8vHwqlIlCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705452943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6OzYhbi2M2GdQZAe+rWpXNW77C07aqbbtVLrrE4RIc=;
	b=z02cqtKwsqPZQORLgc9KK4fH2FGsLoFw3whl334PhKVs6Uth/om0rk4IWUIDubOMdnzw97
	E+mQKnKvrhJfy/SIr8z5tn4Yrje+hpcn6PphbitpOjuycO1qsFcFEbyoRqFEiBtA7vifY8
	WGQWRU2HrU/Eu9ioeiE7kdTok5XZBsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705452943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6OzYhbi2M2GdQZAe+rWpXNW77C07aqbbtVLrrE4RIc=;
	b=gg9CDxmgSF4+CxqiQoZk33hhkhDelwmOPNrahqk2qAKc3cqOtsiUmh2n1e9ea5jibCPJTg
	zQsmBW8vHwqlIlCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EE36013482;
	Wed, 17 Jan 2024 00:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0Pp7OY4lp2U0ZQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 00:55:42 +0000
Date: Wed, 17 Jan 2024 01:55:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rongrong <i@rong.moe>
Subject: Re: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not
 64K aligned
Message-ID: <20240117005520.GG31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
 <12744dd0-a56e-487e-b27d-4ad66498d7e5@wdc.com>
 <de82a8aa-7b51-4aa1-9cd6-a2f749a6e941@gmx.com>
 <20240116182807.GB31555@twin.jikos.cz>
 <49056bc2-55ba-4f09-9a30-0caf4016bfc2@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49056bc2-55ba-4f09-9a30-0caf4016bfc2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed, Jan 17, 2024 at 06:36:00AM +1030, Qu Wenruo wrote:
> On 2024/1/17 04:58, David Sterba wrote:
> > On Tue, Jan 16, 2024 at 09:20:58AM +1030, Qu Wenruo wrote:
> >> On 2024/1/15 22:39, Johannes Thumshirn wrote:
> >> [...]
> >>>
> >>>> - Make sure scrub_submit_initial_read() only to read the chunk range
> >>>>      This is done by calculating the real number of sectors we need to
> >>>>      read, and add sector-by-sector to the bio.
> >>>
> >>> Why can't you do it the same way the RST version does it by checking the
> >>> extent_sector_bitmap and then add sector-by-sector from it?
> >>
> >> Sure, we can, although the whole new scrub code is before RST, and at
> >> that time, the whole 64K read behavior is considered as a better option,
> >> as it reduces the IOPS for a fragmented stripe.
> >
> > I'd like to keep the scrub fix separte from the RST code, even if
> > there's a chance for some code sharing or reuse. The scrub fix needs to
> > be backported so it's better to keep it independent.
> 
> So do I need to split the fix, so that the first part would be purely
> for the non-RST scrub part, and then a small fix to the RST part?
> 
> I can try to do that, but since we need to touch the read endio function
> anyway, it may mean if we don't do it properly, it may break bisection.
> 
> Thus I'd prefer to do a manual backport for the older branches without
> the RST code.

I was not sure how much the scrub and RST are entangled so it was a
suggestion to make the backport workable. It is preferred by stable to
take patches 1:1 regarding the code changes (context adjustments are
ok). In this case the manual backport would be needed, let's say one
patch is taken without change and another one (regarding the RST
changes) would be manualy tweaked.

