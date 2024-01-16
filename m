Return-Path: <linux-btrfs+bounces-1490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585982FBFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 23:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B50B22F86
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5C20B34;
	Tue, 16 Jan 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyGdoLII";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ziaPQVu2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NyGdoLII";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ziaPQVu2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90A20B1E
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435639; cv=none; b=QFJCqmf+gy6484W3km05YHxIMSTLqJIyW54Uk7YGWsQK3+LkNcVkvR+OpIKhYntJyH0w+FwsavKtiB9CPOI1fPaldPEjZGlU5KNnMpQQLgUAmMiNaaTIIdttPq9mSjU4JvhE30HWCgShRZ6Ei67AXf7Fiffayq/dMR87wAwvSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435639; c=relaxed/simple;
	bh=EiO3tvtO7/3ROjrqqhQwh7DPfVDcawSfMUh+Lnfw7l8=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Level:
	 X-Spam-Score:X-Spamd-Result:X-Spam-Flag; b=WFVBtFLRodZobN11+ylasZUcKLe+RL0zW+0IpUZPnslo3ixX7k+w5WZWN8XXjI0IF8CF6yBOtsXm003ePByXuPSc1Eb7tLaDgnZ7zyz7YCvI2RQ1g8RYN0IAf4Z0dFVJamw5tOYJtmKCsQ/TzI03vp07pX1e1XVZ7QHgzdcgqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyGdoLII; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ziaPQVu2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NyGdoLII; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ziaPQVu2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C40241F8B2;
	Tue, 16 Jan 2024 20:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705435635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sII0bYudiY0clpoFLS8SyFt+FtDrIvwGRGmJh+OUSAA=;
	b=NyGdoLIIULvdGn7t6nw6ORC4pNn6US+/joLU8qJTWN8yeCeHDIllw3chvquda5a8WvvwXf
	X88q2IVoGiiMkpBs7p+cuY9plS1tLpWtE1NuszUA/Rfs53+g9F67HEhsj2POmK3qvZKmxq
	uaUQwUrzfE9DcKUlQXZzJWSXMZkqDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705435635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sII0bYudiY0clpoFLS8SyFt+FtDrIvwGRGmJh+OUSAA=;
	b=ziaPQVu2wyAl9mvSKsmFCNyK1U3xJLj0nYKDTKbYL+iBMFOPehbvCpL4HqgvW7yZwE6npl
	wJUHuRhKF3KdzzBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705435635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sII0bYudiY0clpoFLS8SyFt+FtDrIvwGRGmJh+OUSAA=;
	b=NyGdoLIIULvdGn7t6nw6ORC4pNn6US+/joLU8qJTWN8yeCeHDIllw3chvquda5a8WvvwXf
	X88q2IVoGiiMkpBs7p+cuY9plS1tLpWtE1NuszUA/Rfs53+g9F67HEhsj2POmK3qvZKmxq
	uaUQwUrzfE9DcKUlQXZzJWSXMZkqDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705435635;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sII0bYudiY0clpoFLS8SyFt+FtDrIvwGRGmJh+OUSAA=;
	b=ziaPQVu2wyAl9mvSKsmFCNyK1U3xJLj0nYKDTKbYL+iBMFOPehbvCpL4HqgvW7yZwE6npl
	wJUHuRhKF3KdzzBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AB0C6133CF;
	Tue, 16 Jan 2024 20:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oDIBKfPhpmUfRAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 20:07:15 +0000
Date: Tue, 16 Jan 2024 21:06:57 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: convert-ext2: insert a dummy inode item
 before inode ref
Message-ID: <20240116200657.GF31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6e1e07ad53a9e716be28e4d505042a50c1676254.1705134953.git.wqu@suse.com>
 <20240116184738.GE31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116184738.GE31555@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.93
X-Spamd-Result: default: False [-4.93 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.13)[-0.638];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[15.90%]
X-Spam-Flag: NO

On Tue, Jan 16, 2024 at 07:47:38PM +0100, David Sterba wrote:
> On Sat, Jan 13, 2024 at 07:07:06PM +1030, Qu Wenruo wrote:
> > -static inline u32 btrfs_type_to_imode(u8 type)
> > -{
> > -	static u32 imode_by_btrfs_type[] = {
> > -		[BTRFS_FT_REG_FILE]	= S_IFREG,
> > -		[BTRFS_FT_DIR]		= S_IFDIR,
> > -		[BTRFS_FT_CHRDEV]	= S_IFCHR,
> > -		[BTRFS_FT_BLKDEV]	= S_IFBLK,
> > -		[BTRFS_FT_FIFO]		= S_IFIFO,
> > -		[BTRFS_FT_SOCK]		= S_IFSOCK,
> > -		[BTRFS_FT_SYMLINK]	= S_IFLNK,
> > -	};
> > -
> > -	return imode_by_btrfs_type[(type)];
> > -}
> 
> Why did you move this helper to utils.h? Here it's available for
> anything that needs it. Mkfs and convert share some code, no style
> problem to cross include from each other. Also moving it to utils.h is
> going the opposite way, it's a header that's a default if there's no
> better place. Lot of code has been factored out of it.

Ok so I confused mkfs and check, the header is from check/ and is not
clean for inclusion in convert due to task_ctx conflict. So I'll keep it
but noted for a future cleanup.

