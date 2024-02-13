Return-Path: <linux-btrfs+bounces-2360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD33853B4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 20:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5471C26634
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F460EF2;
	Tue, 13 Feb 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n3ddxItX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SCPzDEOu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n3ddxItX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SCPzDEOu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE560ED1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853119; cv=none; b=FwOdSmfNqWgSlWy0fln2UxvYx+EJqs3rMjTTTMu4VLNdu+9nmWOLfKr9aCI8tjXo6b5LNPmhS0m3k0UyY8ggTl/OGlwnYhN2kcIyMMDXGLg4IPm5KuoJA6LpH/3OiKzJkkFMdraFPdVMvVBqCuiqjV58WVjpAjNNEdrgUqkXFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853119; c=relaxed/simple;
	bh=E2A1v9qb0jYdvQ170nQqBbmTh9CAu1QxriBs2UlJOWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD6KsZckmits+xLN58xbzPp8SLJmH4w5OmWMpy1C8AbL5SzzHvIuGSIGjU5xWyW3rcK0oCzuMa2YrOLPLQf38xYr9K7Jd1KY0gpCsKTun2cqH/tqOuj6Foa/ak3BE36Quv1vfQqm1tyupSoY48cxu05i3UgfQtweedGr/jcRP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n3ddxItX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SCPzDEOu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n3ddxItX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SCPzDEOu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A40C21FCEF;
	Tue, 13 Feb 2024 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707853115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfwCwMFjkSAYBxw40c7SWDZtYATS/txYo0QCvcwwBQA=;
	b=n3ddxItXuZRIZyDJI3lBwgvLPuarUE59IjQ1VnXI4P1tAw46dsRr/W7L8hDxnjsFKADnV6
	NmnS+juEy1uTTjc9/xpm17+UL8xA8yg7C34FGmK9mya7IBTGz8S1GOqAPe4xfomaQ5A2rv
	mzatRRjOyissnAZzaGNp0qbzj9mBaNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707853115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfwCwMFjkSAYBxw40c7SWDZtYATS/txYo0QCvcwwBQA=;
	b=SCPzDEOuXFJWKYapUqyA1shlTf+yox/ChNblr1Wq3TgG7pwkaW91eFrSwm98bhrX0L19UB
	8xOqxlLGy3iB25BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707853115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfwCwMFjkSAYBxw40c7SWDZtYATS/txYo0QCvcwwBQA=;
	b=n3ddxItXuZRIZyDJI3lBwgvLPuarUE59IjQ1VnXI4P1tAw46dsRr/W7L8hDxnjsFKADnV6
	NmnS+juEy1uTTjc9/xpm17+UL8xA8yg7C34FGmK9mya7IBTGz8S1GOqAPe4xfomaQ5A2rv
	mzatRRjOyissnAZzaGNp0qbzj9mBaNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707853115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfwCwMFjkSAYBxw40c7SWDZtYATS/txYo0QCvcwwBQA=;
	b=SCPzDEOuXFJWKYapUqyA1shlTf+yox/ChNblr1Wq3TgG7pwkaW91eFrSwm98bhrX0L19UB
	8xOqxlLGy3iB25BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EF3F13583;
	Tue, 13 Feb 2024 19:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EEB9IjvFy2V4MgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 13 Feb 2024 19:38:35 +0000
Date: Tue, 13 Feb 2024 20:38:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
	aromosan@gmail.com, bernd.feige@gmx.net
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Message-ID: <20240213193802.GH355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240212145931.GD355@twin.jikos.cz>
 <8b5c55e0-c9f5-496f-a8ff-cc8eadf64840@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b5c55e0-c9f5-496f-a8ff-cc8eadf64840@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,suse.com,gmail.com,gmx.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.98%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Tue, Feb 13, 2024 at 06:05:53AM +0530, Anand Jain wrote:
> 
> 
> On 2/12/24 20:29, David Sterba wrote:
> > On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
> >> We skip device registration for a single device. However, we do not do
> >> that if the device is already mounted, as it might be coming in again
> >> for scanning a different path.
> >>
> >> This patch is lightly tested; for verification if it fixes.
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> 
> >> I still have some unknowns about the problem. Pls test if this fixes
> >> the problem.
> 
> It is a mystery- we didn't see
>     "BTRFS: skip registering single non-seed device %s\n",
> in the kernel messages.
> 
> Do you have any clue?

It's printed by pr_debug(), so it may not be on by default. For my
testing I changed it to printk(KERN_ERR "...") as I do for all debugging
messages just to be sure, the message was printed.

It may be actually useful to print that on the 'info' level as we do for
the other scanning messages.

