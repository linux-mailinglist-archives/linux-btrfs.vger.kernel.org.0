Return-Path: <linux-btrfs+bounces-3506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C95886534
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 03:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4880285DBE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A74C85;
	Fri, 22 Mar 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aX8j7w7P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mb2qfQ2/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rotp3kjv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eR0HoxU0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C64A04
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Mar 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075001; cv=none; b=ZzcXFpnx4Q8V4tp6JnU5wiZTLnyatu94oXbveaO2eVBHfL9oUv5O7G//s6MrJuGnrzYF+WjEgt3OAWcs7E+y4M8QTnnw0xuk9dFdptxa9Wo552GAe0plKaoEV1GIAvUnHwECsM3KzB9ZDJfRiTPyMeTLlcWzFGg18F0axgelmrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075001; c=relaxed/simple;
	bh=eRxGOOflTDZPBLheACM/qTC+mtSKE0dxLotFRxHdhIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOxfhDWZwmaNS7G9rB4MWn7gM/J4kig0RqajivUJm0b4JOgb1T/qibEIrs8nFxFDadBN5oEYwePu5v61QbSHelrslpIl9kNTjkn0GmwQpS/S/sUol0dUHyvvm92NvMc+/mHPvSiRVW27mdVzEda8+F5zPOfMS6As3ELKm0/pEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aX8j7w7P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mb2qfQ2/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rotp3kjv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eR0HoxU0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38DF92286B;
	Fri, 22 Mar 2024 02:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711074997;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXaZ53hEfJUkd584//ADyZQVxgqvd0k0hvtN+G3D+FI=;
	b=aX8j7w7PouUU9LywamjU6IfB/4JypJruYrG/V22+rRNrjVuBBX9h7Lwz0rNPI0NcZVa8sP
	BsbyVRnaQhy5EfKgjDH+vDUskX+befZkXO9J+3qudmNh5qTBtq8BDhQkqsHxqJO5QUtkSP
	swbsK2H3rzyS5dIhzyY3afrYmnUMWTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711074997;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXaZ53hEfJUkd584//ADyZQVxgqvd0k0hvtN+G3D+FI=;
	b=Mb2qfQ2/1jtw45nHN+w1cyzE9SxmNE2l16ltFMI0yNDtXq/Fb2ZUs2gSyYkSJSV/8Jk6LP
	9+GhcebWFI8lskDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711074996;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXaZ53hEfJUkd584//ADyZQVxgqvd0k0hvtN+G3D+FI=;
	b=rotp3kjvMmTaJggoZJcWxxnjKjyCyjcn0egKg7LKy06hXK70fcx6OxWCNKmkemqhgsoATH
	bZMMeyaZL9GpHQxlMxW2A2q4SBuW+K6w+nCwwArwziUS6GRYFoc+tjiX1C5+1++v41j/vs
	O7+ci0MYp1jVQe2nFAkvHM4PCyLuiXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711074996;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXaZ53hEfJUkd584//ADyZQVxgqvd0k0hvtN+G3D+FI=;
	b=eR0HoxU0MO3XxJrUWLpF9wsTySmm0bV7Z8pkGWFib2VHVSsDFXQQuJrtEx16/VKEf4SA3K
	YSEz5vhUzXOpUvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2816E137D4;
	Fri, 22 Mar 2024 02:36:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3B2bCbTu/GVISgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 22 Mar 2024 02:36:36 +0000
Date: Fri, 22 Mar 2024 03:29:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 19/29] btrfs: mark_garbage_root rename err to ret2
Message-ID: <20240322022921.GI14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710857863.git.anand.jain@oracle.com>
 <417f039ffc4db265a98214c8f86e9a36dbfb1c31.1710857863.git.anand.jain@oracle.com>
 <20240319180748.GH2982591@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319180748.GH2982591@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.48
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.48 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.27)[74.04%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rotp3kjv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eR0HoxU0
X-Rspamd-Queue-Id: 38DF92286B

On Tue, Mar 19, 2024 at 02:07:48PM -0400, Josef Bacik wrote:
> On Tue, Mar 19, 2024 at 08:25:27PM +0530, Anand Jain wrote:
> > In this function, the variable err is used as the second return value. If
> > it is not zero, rename it to ret2.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> This is fine but terrible, a good follow up cleanup would be to make
> btrfs_end_transaction() a void and remove the random places we check for an
> error.  We don't really need it to tell use we have EROFS, we'll get it in some
> other operation down the line if we didn't get it somewhere in here.  Thanks,

I'm not sure we can ignore it everywhere, in many places it's ok, namely
after transaction abort but if some control flow depends on the return
value and starts doing updates that would hit the abort much later then
I'd rather keep it.

Examples I found:

btrfs_delete_subvolume() line 4611, restore dead root status back
btrfs_ioctl_qgroup_assign() if end_transaction fails we don't have any
                            way to communicate errors from the ioctl
btrfs_ioctl_qgroup_create() same
btrfs_ioctl_qgroup_limit() same
... and there are similar cases

It's not just EROFS but also the error code of transaction abort. I'd
rather see the failures detected as early as possible, the delayed error
would only become confusing to debug.

We can have 2 versions so it's semantically clear which one is supposed
to be handled and leave one void for the majority of cases.

