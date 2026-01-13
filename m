Return-Path: <linux-btrfs+bounces-20429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029CD161C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 02:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F17C301FFA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 01:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F290259C9C;
	Tue, 13 Jan 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qx0KdvD8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ltiWSgk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qx0KdvD8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ltiWSgk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E70248176
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768266693; cv=none; b=k3oKEGYpD1QweUSUkpCHvxdtR/X35OiIdqzOTOLtloBW+KwFTtST4RL8atYtoEAKuEpobXtxcbroBJ6IbHoCpF3r/rjK1TFi3l5/3GpHVu4WyC/2+TkB+X73oz1b+MEmIup4RnfjuwBhvSsYKoJx1Snh/UDvaoOQqZK3fls8cK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768266693; c=relaxed/simple;
	bh=TCzhH+vd75hbpdLOKo7d6mvBJmdIc5T/F4sJVZDAu0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3sgT+/8Zmh/TdLs5OoADsTfS9JfYJw2GVEvaG8J9JhJodnCWac+XMCKz8fuXd4ywwKIwm6TYhD8fGX3jYO2MV1CjD4P6Rzv3qFJC/4wuqo2uY+7gm2/o6BxKzNLyC8p/ej7wIjLWZ9WdxvWFW9FdQg2s6c9yTZYVXUvnsvtHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qx0KdvD8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ltiWSgk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qx0KdvD8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ltiWSgk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 684373368C;
	Tue, 13 Jan 2026 01:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768266690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxIKqiTa84YQkD36JQKrpRHCbnml+NC+MrYJ0Y/TvRk=;
	b=Qx0KdvD8motj7I6st6vNMnfPKUHQNoZtwseAAwUGWXQV2F8qLbP7zGB2UPN5ljA86xtfRO
	I7flnx/KeIKeTLBS1IFl1sWOokYOtkYq5fUq7JyJn/ov7j/L2ud/Z6Bse5zcnxkGFdApOv
	rkA7oklFjizpyS3w5myKPF85Ap7HbH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768266690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxIKqiTa84YQkD36JQKrpRHCbnml+NC+MrYJ0Y/TvRk=;
	b=7ltiWSgkppHJFCPWb0wTy6guIYF+c/e3r7inXN0QpFE31MVxHvUzEa+ksPdg3OlurCSxhA
	3atPY1/CJdS/N4DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768266690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxIKqiTa84YQkD36JQKrpRHCbnml+NC+MrYJ0Y/TvRk=;
	b=Qx0KdvD8motj7I6st6vNMnfPKUHQNoZtwseAAwUGWXQV2F8qLbP7zGB2UPN5ljA86xtfRO
	I7flnx/KeIKeTLBS1IFl1sWOokYOtkYq5fUq7JyJn/ov7j/L2ud/Z6Bse5zcnxkGFdApOv
	rkA7oklFjizpyS3w5myKPF85Ap7HbH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768266690;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxIKqiTa84YQkD36JQKrpRHCbnml+NC+MrYJ0Y/TvRk=;
	b=7ltiWSgkppHJFCPWb0wTy6guIYF+c/e3r7inXN0QpFE31MVxHvUzEa+ksPdg3OlurCSxhA
	3atPY1/CJdS/N4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A9A73EA63;
	Tue, 13 Jan 2026 01:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LIOEsKbZWmQTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Jan 2026 01:11:30 +0000
Date: Tue, 13 Jan 2026 02:11:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Delayed ref root cleanups
Message-ID: <20260113011125.GX21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767979013.git.dsterba@suse.com>
 <20260109181627.GB3036615@zen.localdomain>
 <20260109210921.GT21071@twin.jikos.cz>
 <20260109222724.GB3129444@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109222724.GB3129444@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Jan 09, 2026 at 02:27:24PM -0800, Boris Burkov wrote:
> On Fri, Jan 09, 2026 at 10:09:21PM +0100, David Sterba wrote:
> > On Fri, Jan 09, 2026 at 10:16:27AM -0800, Boris Burkov wrote:
> > > On Fri, Jan 09, 2026 at 06:17:39PM +0100, David Sterba wrote:
> > > > Embed delayed root into btrfs_fs_info.
> > > 
> > > The patches all look fine to me, but I think it would be nice to give
> > > some justification for why it is desirable to make this change besides
> > > "it's possible". If anything, it is a regression on the size of struct
> > > btrfs_fs_info as you mention in the first patch.
> > 
> > A regression? That's an unusal way how to look at it and I did not cross
> > my mind. The motivation is that the two objects have same lifetime and
> > whe have spare bytes in the slab.
> > 
> > > If the answer is just that it's simpler and there is no need for a
> > > separate allocation, then fair enough. But then why not directly embed
> > > all the one-off structures pointed to by fs_info? Like all the global
> > > roots, for example. Are they too large? What constitutes too large?
> > > Later, when we slowly add stuff to fs_info till it is bigger than 4k,
> > > should we undo this patch set? Or look for other, bigger structs to
> > > unembed first?
> > 
> > Fair questions. If we embed everything the fs_info would be say 16K. The
> > threshold I'm considering is 4K, which is 4K page on the most common
> > architecture x86_64. ARM can be configured to have 4K or 64K on the most
> > common setups, so I'm not making it worse by the 4K choice.
> > 
> > So, if the structure for embedding is small enough not to cross 4K and
> > still leave some space then I consider it worth doing. In the case of
> > increasing the fs_info by required and small new members (spinlocks,
> > atomics, various stats etc) we can first look how to shring the size by
> > reordering it. Currently I see there are 97 bytes in holes. Then we can
> > look what is used optionally, eg. depends on a mount option and move it
> > to a separate structure.
> > 
> > The delayed root is a core data structure so we will not have to
> > separate it again and revert this patchset. What I'd start looking for
> > for a separate data structure would be some kind of static
> > almost-read-only information, like mount option bits or status flags
> > etc.
> > 
> > Also I don't want people to worry about fs_info size when there's
> > something new to implement. We have some space to use and I will notice
> > if we cross the boundary as I do random checks of the patch effects
> > every now and then. This applies to parameters and stack space
> > consumption. You may say this is pointless like in the other patchset
> > but even on machines with terabytes of memory a kernel thread is still
> > limited to 16K of stack and layering subsystems can use substantial
> > portions of it. My long term goal is to keep the level the same without
> > hindering development.
> 
> Also, all quibbling aside, I don't want to hold you up on trivialities.
> 
> If you can think of a short, specific explanation for why this is
> preferable, I would appreciate you adding it.

I'll do that, thanks for the comments.

