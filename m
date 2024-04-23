Return-Path: <linux-btrfs+bounces-4498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D58AE933
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D4F1C22030
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7F13AA36;
	Tue, 23 Apr 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjgH1oLK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnvD81CC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjgH1oLK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnvD81CC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30024136E1A
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881457; cv=none; b=IXxSCxD1zFhteXpCk4EvkP2Cdws0K1ulNuIT1p+mGCCa93u02XLG0H0aQILpQONj2ONhnTyOB/o0NytkXU1Syb3TY67WJADbuM9wsw+AUuRGkN5/bNzrkl29sY0VPmaD3MX6I5N8AG+DwzJyI9ElJohldow+dauIqXSHu0byAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881457; c=relaxed/simple;
	bh=AOkhrkRQU7/1EjRervy66HaoXHECC1tbsdfZZXj2Wd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpEG/1i5rorijA1RSzEkocRQcrD4FYq21IQpPIx7Jr/9qRgRS7O7Glb0nhaZCdPJNVVoep61NF+OYSuSefQz8Tf/oIBFjL+UXUdlpPPgPHS9ljpzdjK6Ms2A6nF8B5gNa5l6PVXzlyAfI3zbrMF2np9zAG6Z0NbVGj4PpPHsfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjgH1oLK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnvD81CC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjgH1oLK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnvD81CC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 539F260022;
	Tue, 23 Apr 2024 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713881454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nu76dJCSkMbtoNmd09BNbw4XJ1KffPr9NwUyK/oMH8M=;
	b=VjgH1oLKpNLVou7dGeIA0KB4H8P6HHtAp1yAvSsXiZlI62qg2qDaypgnJS3a9vG3PkOQWa
	OII9vWKMDJFzmXSjFqwS+B87OYQ8kaHrBR9OffP9af/pJ47/foiTDO72jUO4Gw5fLWx8bG
	c4RNxQnfRmCZjT3zXHMLUILB7jwlWKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713881454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nu76dJCSkMbtoNmd09BNbw4XJ1KffPr9NwUyK/oMH8M=;
	b=lnvD81CCXDNBjSF5H5+qaFX2Vz09cGegk4Gh1o5db0H/OrQPaXQAJsA71rqcB310MHYr3W
	O1/oif0ug7E4H+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713881454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nu76dJCSkMbtoNmd09BNbw4XJ1KffPr9NwUyK/oMH8M=;
	b=VjgH1oLKpNLVou7dGeIA0KB4H8P6HHtAp1yAvSsXiZlI62qg2qDaypgnJS3a9vG3PkOQWa
	OII9vWKMDJFzmXSjFqwS+B87OYQ8kaHrBR9OffP9af/pJ47/foiTDO72jUO4Gw5fLWx8bG
	c4RNxQnfRmCZjT3zXHMLUILB7jwlWKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713881454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nu76dJCSkMbtoNmd09BNbw4XJ1KffPr9NwUyK/oMH8M=;
	b=lnvD81CCXDNBjSF5H5+qaFX2Vz09cGegk4Gh1o5db0H/OrQPaXQAJsA71rqcB310MHYr3W
	O1/oif0ug7E4H+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45C2013929;
	Tue, 23 Apr 2024 14:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JbhEG7BJ2ZIdwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Apr 2024 14:10:54 +0000
Date: Tue, 23 Apr 2024 16:03:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: take the cleaner_mutex earlier in qgroup disable
Message-ID: <20240423140317.GG3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a78874868a1d3d8d78e6b0fdbb97debc88923734.1713573156.git.josef@toxicpanda.com>
 <CAL3q7H7it7OhnC=AHYS7s=V0UZTPUPiZQBZ11AixmQqAqPnDUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7it7OhnC=AHYS7s=V0UZTPUPiZQBZ11AixmQqAqPnDUQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-1.31)[90.19%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto]
X-Spam-Score: -2.31
X-Spam-Flag: NO

On Mon, Apr 22, 2024 at 04:27:26PM +0100, Filipe Manana wrote:
> >         case BTRFS_QUOTA_CTL_DISABLE:
> > +               /*
> > +                * Lock the cleaner mutex to prevent races with concurrent
> > +                * relocation, because relocation may be building backrefs for
> > +                * blocks of the quota root while we are deleting the root. This
> > +                * is like dropping fs roots of deleted snapshots/subvolumes, we
> > +                * need the same protection.
> > +                *
> > +                * This also prevents races between concurrent tasks trying to
> > +                * disable quotas, because we will unlock and relock
> > +                * qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED changes.
> > +                */
> > +               mutex_lock(&fs_info->cleaner_mutex);
> > +               down_write(&fs_info->subvol_sem);
> 
> Everything is correct and makes sense.
> 
> I'm afraid in the future someone looking into this code after the
> patch is merged, will wonder why we have this duplicated locking of
> the
> subvol_sem in each case of the switch statement and then decide "ah
> let's get rid of this duplicated code and make the locking before the
> switch and the unlocking after".

I think we'd catch that at review time, moving locks around must be done
carefully. We could improve the lock documentation either as
lockdep_assert_held() or comments, I would not mind adding the comment
here but it also does not seem necessary.

