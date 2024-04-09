Return-Path: <linux-btrfs+bounces-4058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9289D954
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AE11F233EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749F12D77D;
	Tue,  9 Apr 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOK53AVS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uSdLuixV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CRqjH85r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jwngiTl+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5FB127B5A;
	Tue,  9 Apr 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666642; cv=none; b=mjjkhCi9jC/fgw00hv4X8hjhXwa5NjpuZxn5+Mdnn6YbO0mRsao3cI7FeWmpEi0xMgJicOr/oVn1iuWzMS/Len9GRUXzrfnHYvtB8sioLGjvkJVD3i4tfGmeRk7nxarD/bu/7/eEqeNIF38Xh2udapC1bketHNo0f6LFdsGU6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666642; c=relaxed/simple;
	bh=x+S2KHRsaA8GnnXnOQ/WlaWaU7zCukg83XoBxc4+lPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVfUrLxO7wFsPw/0lXJL3Fdsd31xwrrj0OLkVRACvDGr1sj7Lev/VF3hK5lNgpDhZAs/5fA9dHY+RoDy2m2Gd1gjtwSE7JySXnCszcBOYqWfXT2yTEP66hHgOTr57VR2Hn+6hiHpIDE1xtJzC6wtWON798Pa55e0sbSxlXvPMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOK53AVS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uSdLuixV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CRqjH85r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jwngiTl+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFED0209C5;
	Tue,  9 Apr 2024 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712666638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3D36Viv3DWefVaDEGTYJvb6ESqXVVvfRXWOznlJFgE=;
	b=FOK53AVSYJqlFApnCqdgQtpl4lEyf2Mrr1VPdP+rrb2Ue0UCvvfQhNq9U3RdlZLhEVAL1O
	mcnhwz5Awu1uid8QIL/DglddMACOJnb8sZteQAfBs+gPONMcZ8FSRbu8ZFQoBhNfJMlNN1
	oq5Jb9ZXw3tai5O0HtU3Q5icERWTHDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712666638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3D36Viv3DWefVaDEGTYJvb6ESqXVVvfRXWOznlJFgE=;
	b=uSdLuixVQ2O3zbsZ68Uu11VlLTthJwx96T8QW9LtrjeodSFOwX8Z6/gdrbnae3Krlanhvk
	iA4RQDB6RT4SXDBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CRqjH85r;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jwngiTl+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712666637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3D36Viv3DWefVaDEGTYJvb6ESqXVVvfRXWOznlJFgE=;
	b=CRqjH85rdMqNLpnknVNqbpJn3gVmqJCA1VwC/aeWdIRMsMKS4h1nBn6+fAfo6VUyQ+2O+s
	BHwWD1EJMb/0DylVxSwosg4YDK1soOafEWFqCC6nOGVeOOvS9L85xempyBrbQNTIHLrokL
	oVUcpld0d/MrYI6OYnpsAThp3I7EjBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712666637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3D36Viv3DWefVaDEGTYJvb6ESqXVVvfRXWOznlJFgE=;
	b=jwngiTl+C0iz2wc8mA+TyhYtQL/KlaUyh2cHle6gDajiWNhCfxRuCH+stEsh2M/p8JLxgm
	wHyW/RnEhSNxroAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B715613253;
	Tue,  9 Apr 2024 12:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cPGJLA04FWb/cQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 12:43:57 +0000
Date: Tue, 9 Apr 2024 14:36:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix wrong block_start calculation for
 btrfs_drop_extent_map_range()
Message-ID: <20240409123628.GD3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
 <20240408080014.74B2.409509F4@e16-tech.com>
 <2024040851-uptown-splashing-951c@gregkh>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040851-uptown-splashing-951c@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DFED0209C5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon, Apr 08, 2024 at 06:57:56AM +0200, Greg KH wrote:
> On Mon, Apr 08, 2024 at 08:00:15AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > [BUG]
> > > During my extent_map cleanup/refactor, with more than too strict sanity
> > > checks, extent-map-tests::test_case_7() would crash my extent_map sanity
> > > checks.
> > > 
> > > The problem is, after btrfs_drop_extent_map_range(), the resulted
> > > extent_map has a @block_start way too large.
> > > Meanwhile my btrfs_file_extent_item based members are returning a
> > > correct @disk_bytenr along with correct @offset.
> > > 
> > > The extent map layout looks like this:
> > > 
> > >      0        16K    32K       48K
> > >      | PINNED |      | Regular |
> > > 
> > > The regular em at [32K, 48K) also has 32K @block_start.
> > > 
> > > Then drop range [0, 36K), which should shrink the regular one to be
> > > [36K, 48K).
> > > However the @block_start is incorrect, we expect 32K + 4K, but got 52K.
> > > 
> > > [CAUSE]
> > > Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
> > > that covers the target range but is still beyond it, we need to split
> > > that extent map into half:
> > > 
> > > 	|<-- drop range -->|
> > > 		 |<----- existing extent_map --->|
> > > 
> > > And if the extent map is not compressed, we need to forward
> > > extent_map::block_start by the difference between the end of drop range
> > > and the extent map start.
> > > 
> > > However in that particular case, the difference is calculated using
> > > (start + len - em->start).
> > > 
> > > The problem is @start can be modified if the drop range covers any
> > > pinned extent.
> > > 
> > > This leads to wrong calculation, and would be caught by my later
> > > extent_map sanity checks, which checks the em::block_start against
> > > btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.
> > > 
> > > And unfortunately this is going to cause data corruption, as the
> > > splitted em is pointing an incorrect location, can cause either
> > > unexpected read error or wild writes.
> > > 
> > > [FIX]
> > > Fix it by avoiding using @start completely, and use @end - em->start
> > > instead, which @end is exclusive bytenr number.
> > > 
> > > And update the test case to verify the @block_start to prevent such
> > > problem from happening.
> > > 
> > > CC: stable@vger.kernel.org # 6.7+
> > > Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > $ git describe --contains c962098ca4af
> > v6.5-rc7~4^2
> > 
> > so it should be
> > CC: stable@vger.kernel.org # 6.5+
> 
> As the "Fixes:" commit was backported to the following kernel releases:
> 	6.1.47 6.4.12
> it should go back to 6.1+ as well :)

Determining all the versions requires one extra step to scan the
stable-queue.git for the commit. I think everybody does 'git describe
--contains COMMITID' based on Fixes: and then pick the version for CC:.
This is "best" we can promise for an average developer.

> But we can handle that when it hits Linus's tree.

I think it's easier for you to queue the patch to other versions at the
time you pick it from mails or Linus' tree, but from what I've seen so
far this is how it works.

