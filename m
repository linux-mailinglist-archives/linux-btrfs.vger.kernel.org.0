Return-Path: <linux-btrfs+bounces-3000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD087094A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BA01C21002
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC66216A;
	Mon,  4 Mar 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z38ET0jl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kb5TXagP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z38ET0jl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kb5TXagP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D456214E
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576086; cv=none; b=SbZk6qv93gKwx6QPe9SOHgZwa8sSihCWZjydRTf/vPJH1yWqJRmWh2dg77n4K7t1oeRn1sd1/bVJrxrpg3jfUh4HAj0gBCbEvX3wYF8brkCSXZESCeKruvz4E+7aJp7oLvn8giZn7YJpodTkdgDEr4wjUoHKgjYLefiBDmwY/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576086; c=relaxed/simple;
	bh=ohnvgYnX9uN+KKgEIBDxvsteXBrbGQIxhqGs3ep8emE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXeSktTOWfCFu25K110j7t3Qd5qc9AsmQvvi3XQmcCv8+28SoD9cLE8/FTGnHx1LEH0Ev6MmkCVXon6yhAHy3olZpo+ZUnc6jXLV0ABT4B87A2PfwsD7ol1oNqub5xo+DoUihlN74Ci9/RJlnGORszMOaiG3GpRExmsJKIbKhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z38ET0jl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kb5TXagP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z38ET0jl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kb5TXagP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3531E20059;
	Mon,  4 Mar 2024 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709576082;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Puxnx/Dr6iFysNxSk+tgKIjCdYabVKAmTtBnwqhBEO0=;
	b=z38ET0jl2cM5LeTiqeM/diEHRHJZNlCnPX5K0/T0y6MmAr9HWL90440+XVVMeGbxIEgki+
	46WB3r77Po/V56z2CsX7x3vys1h1I6pcYyjWYOf6l+4sBVrANeukZAjzPJx5zldR1k4ps5
	u5t5DvtULvd4doBSg2hHOC/r5iv1J0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709576082;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Puxnx/Dr6iFysNxSk+tgKIjCdYabVKAmTtBnwqhBEO0=;
	b=kb5TXagPQgrQub1/VK8DYoMg6Ik3Ua7lpbpW4ETQOQ5sJMmtwYAcQ5d3TM97G/8WRLwQ2S
	fL7C7uMz82vH00BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709576082;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Puxnx/Dr6iFysNxSk+tgKIjCdYabVKAmTtBnwqhBEO0=;
	b=z38ET0jl2cM5LeTiqeM/diEHRHJZNlCnPX5K0/T0y6MmAr9HWL90440+XVVMeGbxIEgki+
	46WB3r77Po/V56z2CsX7x3vys1h1I6pcYyjWYOf6l+4sBVrANeukZAjzPJx5zldR1k4ps5
	u5t5DvtULvd4doBSg2hHOC/r5iv1J0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709576082;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Puxnx/Dr6iFysNxSk+tgKIjCdYabVKAmTtBnwqhBEO0=;
	b=kb5TXagPQgrQub1/VK8DYoMg6Ik3Ua7lpbpW4ETQOQ5sJMmtwYAcQ5d3TM97G/8WRLwQ2S
	fL7C7uMz82vH00BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DC7F139C6;
	Mon,  4 Mar 2024 18:14:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NocUB5IP5mVLGgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 04 Mar 2024 18:14:42 +0000
Date: Mon, 4 Mar 2024 19:07:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs-progs: forget removed devices
Message-ID: <20240304180736.GM2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1709231441.git.boris@bur.io>
 <751eba3d-c72e-475b-8d21-e15c1d085ce0@oracle.com>
 <20240301115442.GI2604@twin.jikos.cz>
 <20240301154444.GB1832434@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301154444.GB1832434@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Mar 01, 2024 at 07:44:44AM -0800, Boris Burkov wrote:
> On Fri, Mar 01, 2024 at 12:54:42PM +0100, David Sterba wrote:
> > On Fri, Mar 01, 2024 at 08:01:44AM +0530, Anand Jain wrote:
> > > On 3/1/24 00:06, Boris Burkov wrote:
> > > > To fix bugs in multi-dev filesystems not handling a devt changing under
> > > > them when a device gets destroyed and re-created with a different devt,
> > > > we need to forget devices as they get removed.
> > > > 
> > > > Modify scan -u to take advantage of the kernel taking unvalidated block
> > > > dev names and modify udev to invoke this scan -u on device remove.
> > > > 
> > > 
> > > Unless we have a specific bug still present after the patch
> > > "[PATCH] btrfs: validate device maj:min during open," can we
> > > hold off on using the external udev trigger to clean up stale
> > > devices in the btrfs kernel?
> > > 
> > > IMO, these loopholes have to be fixed in the kernel regardless.
> > 
> > Agreed, spreading the solution to user space and depending on async
> > events would only make things harder to debug in the end.
> 
> In my opinion, leaving the incorrect cache around after a device is
> destroyed is a footgun and a recipe for future error.

I agree here partially, leaving stale cached entries can lead to bad
outcome, but including userspace as part of the solution is again making
it fragile and less reliable. We're not targeting the default and common
use case, that would work with or without the fixes or udev rules.

The udev event is inherently racy so if something tries to mount before
the umount udev rule starts, no change other than we now have yet
another factor to take into account when debugging.

> Patching it up
> with Anand's kernel-only fix will fix the problem for now,

This is a general stance kernel vs user space, we can't rely on state
correctnes on userspace, so kernel can get hints (like device scanning)
but refuse to mount if the devices are not present.

> but I would
> not be at all surprised if there isn't a different more serious problem
> waiting for us down the road. We're just looking at exactly devt and
> temp_fsid, and I'm quite focused on breaking single device filesystems.
> I spent a week or two hacking on that reproducer. Are we *confident* that
> I couldn't do it again if I tried with all kinds of raid arrays, error
> injection, races, etc? What about after we add three more features to
> volume management and it's been two years?

We can only add more safety checks or enforcing some feature using flags
or options. Adding features to a layer means we need to revisit how it
would go with the current state, something that we did with the
temp-fsid, now we're chasing out the bugs. We did not have a good test
coverage initially so it's more than what could be expected for a
post-release validation.

> Getting a notification on device destruction and removing our state for
> that device is the correct fix. If things like this need to be
> in-kernel, then why is udev the only mechanism for this kind of
> communication? Can we get a callback from the block layer?

I don't know, it sounds simple but such things can get tricky to get
right once it's spanning more layers and state changes. I've heared too
many horror stories from CPU or memory hotplug, the unexpected changes
in block devices sound too similar.

The approach we have is to store some state and validate it when needed,
but we apparently lack enough information sources to make the validation
100% reliable. I think we gained a lot of knowledge just from debugging
that and prototyping the counter examples but I'm observing we may not
have means for fixes.

