Return-Path: <linux-btrfs+bounces-2207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D184C800
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575F9284348
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFC2375A;
	Wed,  7 Feb 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikt7adsw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAnhkQ2k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikt7adsw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAnhkQ2k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AF2374A
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299560; cv=none; b=DcVJWVycxzPIj7XYw2h+DGeL227fDX5fu5z2jCiu9iC8nA+R6xaAqUEHgAi3jEdUX10Me9t6efrA0TJHAXS7H5kOd48IG51JhIAljCkXIiEJH0uJImoIScOZ86u2Viu+baLsEcbPJIN8OKtTPUEw9UuRzUgGby3kw1iTVj1+IzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299560; c=relaxed/simple;
	bh=G9Qe8N3q2jB7gwsuBsSO5LBG3XbDEAhBp7Fqn0hVKoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kduGtloHOfpgFXEqmACoI0qy40q8JX0FgPXEr1cvlx93B5fK1+m0y9jRJo4KabeJOOm2SPDevgMMSGNbvr1bfIudW+eAuv57RpDfUpu04EXbPV4IQ3IeXAAzQLvaJdaWRlW4fcLusi9lUSke3rQt8KKdQcLDh2djlWZ0u1dGb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikt7adsw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PAnhkQ2k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikt7adsw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PAnhkQ2k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F66B22178;
	Wed,  7 Feb 2024 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707299556;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKVrJvG3E2NJNx8or3WmJpdjEUonYkQgwX2FrJijk2M=;
	b=ikt7adswSYPZz2FtPmqiHRzMqOO9xKiNyJ7yh2YjsvtCCaOfLCt+di54C+/tKi1nQ6wpxB
	xgW9AnG5CQOCtdwyqNxghcoy5TSN5FrayNzQXTaHU3vt9ZBG/lzsmz7V3uhbe9NhUr8o0T
	p0nMZbYHBmMEkcWq+cb9OsmH9iL5z48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707299556;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKVrJvG3E2NJNx8or3WmJpdjEUonYkQgwX2FrJijk2M=;
	b=PAnhkQ2kkLDkDvCLEvgAlQfvC77tAqBvIE4pth+KaJi+KchgiH6OesKlB4/wqgGoZpRXZ+
	oG/WikvzkfWB8ZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707299556;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKVrJvG3E2NJNx8or3WmJpdjEUonYkQgwX2FrJijk2M=;
	b=ikt7adswSYPZz2FtPmqiHRzMqOO9xKiNyJ7yh2YjsvtCCaOfLCt+di54C+/tKi1nQ6wpxB
	xgW9AnG5CQOCtdwyqNxghcoy5TSN5FrayNzQXTaHU3vt9ZBG/lzsmz7V3uhbe9NhUr8o0T
	p0nMZbYHBmMEkcWq+cb9OsmH9iL5z48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707299556;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKVrJvG3E2NJNx8or3WmJpdjEUonYkQgwX2FrJijk2M=;
	b=PAnhkQ2kkLDkDvCLEvgAlQfvC77tAqBvIE4pth+KaJi+KchgiH6OesKlB4/wqgGoZpRXZ+
	oG/WikvzkfWB8ZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DE2413931;
	Wed,  7 Feb 2024 09:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bYmsGuRSw2WOVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 Feb 2024 09:52:36 +0000
Date: Wed, 7 Feb 2024 10:52:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: hunt down the stray fd close causing
 race with udev scan
Message-ID: <20240207095206.GU355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706827356.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706827356.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ikt7adsw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PAnhkQ2k
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.22%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F66B22178
X-Spam-Level: 
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, Feb 02, 2024 at 11:29:18AM +1030, Qu Wenruo wrote:
> Although my previous flock() based solution is preventing udev scan to
> get pre-mature super blocks, it in fact masks the root problem:
> 
>   There is a stray close() on writeable fd.
> 
> Commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors open
> during whole time") tries to solve the problem by extending the lifespan
> of writeable fds, so that when the fds are closed, the fs is ensured to
> be properly populated.
> 
> The problem is, that patch is not covering all cases, there is a stray
> fd close just under our noses: open_ctree_fs_info().
> 
> The function would open the initial device, then use that initial fd to
> open the btrfs, then we immediately close the initial fd, as later IO
> would all go with the device fd.
> 
> That close() call is causing problem, especially for mkfs, as at that
> stage the fs is still using a temporary super block, not using the valid
> btrfs super magic number.
> 
> Thus udev scan would race with mkfs, and if udev wins the race, it would
> get the temporary super block, making libblk not to detect the new
> btrfs.
> 
> This patchset would address the problem by:
> 
> - Make sure open_ctree*() calls all have corresponding close_ctree()
>   The first patch, as later we will only close the initial fd caused by
>   open_ctree_fs_info() during close_ctree().
> 
> - Save the initial fd into btrfs_fs_info for open_ctree_fs_info()
>   And later close the initial fd during close_ctree().
> 
> - Make sure open_ctree_fd() callers to properly close the fd
>   Just an extra cleanup.
> 
> This patchset would work even without the usage of flock() to block udev
> scan, and since without flock() calls, the procedure is much simpler.
> 
> Qu Wenruo (3):
>   btrfs-progs: rescue: properly close the fs for clear-ino-cache
>   btrfs-progs: tune: fix the missing close()
>   btrfs-progs: fix the stray fd close in open_ctree_fs_info()

Thanks, added to devel.

