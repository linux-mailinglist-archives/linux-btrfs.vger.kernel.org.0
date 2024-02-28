Return-Path: <linux-btrfs+bounces-2856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6086B165
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 15:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E472B29A34
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7214F9D5;
	Wed, 28 Feb 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSws8Z0F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SKfT7in6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSws8Z0F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SKfT7in6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754814F995
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129591; cv=none; b=RwP3dHu0VAgRKXd08EOdaU+mFsLLBe6jmqKTBWdIGhVimFB18Nq6h2QZhHMT9empugYRz5MhdSKuCY1Mnvr/jb4f05tRvI7SQDoHU3/98klnOkR+V5YwdweFLwiKZQcxZmttfwji4T0nPzjKG026g/JKOVqIXZ0Ip/uEDstqf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129591; c=relaxed/simple;
	bh=H+qTsl3ugVIVXo2yVsTQDsZ2691fbcznE7iQZyykzZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNVh6gw4rkGs9nHOgt2m+vWRg6Zl5J1H8BSnw3THovQPZO1pDEC6/XVgMvpxznL66tKlAWmH3WD8VGLyHwgDI5cXEKo37vhxiJYoL/SZ5EIpVYQO4ele1FrdVPoP6TvZh6/55WOwzHNrMFA1CysjLgtUIgTwemRtN5OHoP2DSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSws8Z0F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SKfT7in6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSws8Z0F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SKfT7in6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E7AA22296;
	Wed, 28 Feb 2024 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709129586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3N4XzjQDC8B1CNaDBsq3/3zvidybIFQPCdUk+dR7ryk=;
	b=kSws8Z0F+A0aGoLGUc5x86xdY8HajVBg6pj3BqYC+hLsw3ofwGyJhQzoyfjAai+v0z4CxZ
	ziM/r03V797O26FQJ64u8GYdNUlTnod/WmUHmXeJqPw0mMnZk0t59F5bfVY5fCGDq6NTdK
	uwvn92DxwZj7iyWJkozUChhTDh53DxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709129586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3N4XzjQDC8B1CNaDBsq3/3zvidybIFQPCdUk+dR7ryk=;
	b=SKfT7in6J1p/A2d3y35Cy1sqdA9YcUhErklwCBfQcI3+SXZBOseatxgRAFq6dlBMES0LAS
	i1QmJXGP6CtqiqBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709129586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3N4XzjQDC8B1CNaDBsq3/3zvidybIFQPCdUk+dR7ryk=;
	b=kSws8Z0F+A0aGoLGUc5x86xdY8HajVBg6pj3BqYC+hLsw3ofwGyJhQzoyfjAai+v0z4CxZ
	ziM/r03V797O26FQJ64u8GYdNUlTnod/WmUHmXeJqPw0mMnZk0t59F5bfVY5fCGDq6NTdK
	uwvn92DxwZj7iyWJkozUChhTDh53DxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709129586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3N4XzjQDC8B1CNaDBsq3/3zvidybIFQPCdUk+dR7ryk=;
	b=SKfT7in6J1p/A2d3y35Cy1sqdA9YcUhErklwCBfQcI3+SXZBOseatxgRAFq6dlBMES0LAS
	i1QmJXGP6CtqiqBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 32E7313A42;
	Wed, 28 Feb 2024 14:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XKE5DHI/32UUFAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 28 Feb 2024 14:13:06 +0000
Date: Wed, 28 Feb 2024 15:12:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Fabian Vogt <fvogt@suse.com>
Subject: Re: [PATCH] btrfs: qgroup: always free reserved space for extent
 records
Message-ID: <20240228141221.GL17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa1dd06ced5ae3d775646ffa2eff05d0ce6da6df.1708674214.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1dd06ced5ae3d775646ffa2eff05d0ce6da6df.1708674214.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kSws8Z0F;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SKfT7in6
X-Spamd-Result: default: False [-3.52 / 50.00];
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
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,suse.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[48.84%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4E7AA22296
X-Spam-Level: 
X-Spam-Score: -3.52
X-Spam-Flag: NO

On Fri, Feb 23, 2024 at 06:13:38PM +1030, Qu Wenruo wrote:
> [BUG]
> If qgroup is marked inconsistent (e.g. caused by operations needing full
> subtree rescan, like creating a snapshot and assign to a higher level
> qgroup), btrfs would immediately start leaking its data reserved space.
> 
> The following script can easily reproduce it:
> 
>  mkfs.btrfs -O quota -f $dev
>  mount $dev $mnt
>  btrfs subv create $mnt/subv1
>  btrfs qgroup create 1/0 $mnt
> 
>  # This snapshot creation would mark qgroup inconsistent,
>  # as the ownership involves different higher level qgroup, thus
>  # we have to rescan both source and snapshot, which can be very
>  # time consuming, thus here btrfs just choose to mark qgroup
>  # inconsistent, and let users to determine when to do the rescan.
>  btrfs subv snapshot -i 1/0 $mnt/subv1 $mnt/snap1
> 
>  # Now this write would lead to qgroup rsv leak.
>  xfs_io -f -c "pwrite 0 64k" $mnt/file1
> 
>  # And at unmount time, btrfs would report 64K DATA rsv space leaked.
>  umount $mnt
> 
> And we would have the following dmesg output for the unmount:
> 
>  BTRFS info (device dm-1): last unmount of filesystem 14a3d84e-f47b-4f72-b053-a8a36eef74d3
>  BTRFS warning (device dm-1): qgroup 0/5 has unreleased space, type 0 rsv 65536
> 
> [CAUSE]
> Since commit e15e9f43c7ca ("btrfs: introduce
> BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting"),
> we introduce a mode for btrfs qgroup to skip the timing consuming
> backref walk, if the qgroup is already inconsistent.
> 
> But this skip also covered the data reserved freeing, thus the qgroup
> reserved space for each newly created data extent would not be freed,
> thus cause the leakage.
> 
> [FIX]
> Make the data extent reserved space freeing mandatory.
> 
> The qgroup reserved space handling is way cheaper compared to the
> backref walking part, and we always have the super sensitive leak
> detector, thus it's definitely worthy to always free the qgroup
> reserved data space.
> 
> Fixes: e15e9f43c7ca ("btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1216196
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to for-next, thanks.

