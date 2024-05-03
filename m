Return-Path: <linux-btrfs+bounces-4727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386898BACD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD3D1C21A69
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EECB153579;
	Fri,  3 May 2024 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="itntzHlL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oPHcjzU+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="itntzHlL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oPHcjzU+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0F139CE0
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740810; cv=none; b=XoOPcdhyPOxkSDMNVPTd8dIOv4EUSO998B99JOy1DKlfZYkr8fYIauDPnnmm+/v23+Ce3rTnTldnUgWiDz3YdfHDnfq9eWD3f7whsVftkuQFc8VMY8u5JuorUEkl9+NV+IKCjgePrmePbDnxg5zL4bh0zv0iBNMpUrJBK9nzxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740810; c=relaxed/simple;
	bh=nHtvcPvh05G1UBlBdf9PT7HaswVXGuY9zapax+owOkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnsA4UjlYPz4bkXgZbc6AYq4qosR0/MD5NL9zpfVDfGR0cA3vTKEKPiJr5U+pHTkTmy5CCGzBh+MIg09Pz/zULjrPE09EnVkbd9KC/QcEmB+SOMtVan2q4kdmV+EY0T26JbIxmSiqQgYcoB/1Qo2pQzmeKTJLTjCqDQol9DuaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=itntzHlL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oPHcjzU+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=itntzHlL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oPHcjzU+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03FC6203FF;
	Fri,  3 May 2024 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714740807;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKufPBWEhv+YpOxDBRxl8xbtbtSQ6HZRdeUCBTN5oNo=;
	b=itntzHlL4GMU8CpNNUYBzE+g+EZDr9Yg7rSC8wl3RbKOa9gaUJz1TB69C2QqvjLof4eOCo
	qGqa54Bi5Z2byvhrxjTpnwfrjCkwczXg0ILnSNc6F6BrZuTpGclwApIhrSFeDKJfPDXW1d
	nM3Y5Btr7KTMcLcOL2CiORIDSX2ndBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714740807;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKufPBWEhv+YpOxDBRxl8xbtbtSQ6HZRdeUCBTN5oNo=;
	b=oPHcjzU+GxlAo1Uy62oPuG8nF/jD1a2T0pFex4jAKNoPZuPC9i2bN7q21gPjlAiBkayhpi
	1aPKUS1D5t3NdFDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714740807;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKufPBWEhv+YpOxDBRxl8xbtbtSQ6HZRdeUCBTN5oNo=;
	b=itntzHlL4GMU8CpNNUYBzE+g+EZDr9Yg7rSC8wl3RbKOa9gaUJz1TB69C2QqvjLof4eOCo
	qGqa54Bi5Z2byvhrxjTpnwfrjCkwczXg0ILnSNc6F6BrZuTpGclwApIhrSFeDKJfPDXW1d
	nM3Y5Btr7KTMcLcOL2CiORIDSX2ndBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714740807;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKufPBWEhv+YpOxDBRxl8xbtbtSQ6HZRdeUCBTN5oNo=;
	b=oPHcjzU+GxlAo1Uy62oPuG8nF/jD1a2T0pFex4jAKNoPZuPC9i2bN7q21gPjlAiBkayhpi
	1aPKUS1D5t3NdFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D931E13991;
	Fri,  3 May 2024 12:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qyTaNEbeNGbYdQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 May 2024 12:53:26 +0000
Date: Fri, 3 May 2024 14:46:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240503124606.GZ2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain>
 <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
 <20240430221839.GA51927@zen.localdomain>
 <d49e13f2-59ff-49ef-b81c-8c2c96d8284b@gmx.com>
 <20240502150332.GS2585@twin.jikos.cz>
 <d1c91b71-8196-4ea3-943d-db30883acb8c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1c91b71-8196-4ea3-943d-db30883acb8c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, May 03, 2024 at 06:59:03AM +0930, Qu Wenruo wrote:
> >> The problem is as mentioned already, it's not persistent, thus it needs
> >> a user space daemon to set it for every fs after mount.
> >
> > My idea of using sysfs is to export the information that the
> > autocleaning feature is present and if we make it on by default then
> > there's no need for additional step to enable it. The feedback about
> > that was that it should have been default so we're going to make that
> > change, but with sysfs export also provide a fallback to disable it in
> > case it breaks things for somebody.
> >
> >> I'm totally fine to go sysfs for now, but I really hope to a persistent
> >> solution.
> >> Maybe a dedicated config tree?
> >
> > No, we already have a way to store data in the trees or in the
> > properties so no new tree.
> 
> That means a on-disk format change.
> IIRC everytime we introduce a new TEMP objectid, it should at least be
> compat or compat_ro bit change.
> 
> Or older kernel won't understand nor follow the new TEMP key.

This is not necessarily a problem, if older kernel does not understand
the key it'll skip it. The search treats the keys as numbers. If there's
something more associated with the additional data that would prevent
mount then a compat bit would make sense.

The compat_ro does not make sense here, the same filesystem can be
mounted and data read or written, the only difference is that qgroups
are also removed. How is that incompatible on the same level as other
features like BGT?

