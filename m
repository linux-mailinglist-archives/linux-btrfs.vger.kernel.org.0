Return-Path: <linux-btrfs+bounces-10577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9AD9F6C7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402AD16ACAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178591FA8E7;
	Wed, 18 Dec 2024 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="haOq5qcA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZCCoxXl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="haOq5qcA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZCCoxXl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338EA1B4233
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543838; cv=none; b=KZ86i+5eZ1GoFyJJ73W1YKk/qmBWzBRb+vByb1fTty8AIY0dV/CqgN6PvnQqJYyb3j6B6DMoSGnj3M5gT4Zm3Ik44NljX9NE6xEYaxOII4xzf2InRjVcvVToqcsvAE42J+2mNZl61oRedDfo9SvEhFBqtsGD+QMFeEhW4EpwnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543838; c=relaxed/simple;
	bh=P7CEutTMvlAVlhH4YkQz3kxatArumquub63neOq1eR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/d4EXs16p6P87DDnCPaYbCOMHzcDdCK5o73aIaHFcwBoaCYUDJl78CN5nAS497G9Z/hkn7EHwdTuuv+ahP28Wfn/MZTUUtXvgO1s4e/UJcJRKKWoVhejR5Li1fwoZCgOA0PU1lAgolMJxqIJKufpM/Osi8HX07r5Mnnj0zuniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=haOq5qcA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZCCoxXl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=haOq5qcA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZCCoxXl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D2B41F396;
	Wed, 18 Dec 2024 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734543834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUNMvWcH7JO+1uLit8e9uAdYe6mpjTd+Wldg9gazhR8=;
	b=haOq5qcA6GKv0nqHAfYpR6YkDZrFMxBdgoWZQb2rNYdKZzEl+wg+JytWjg4jc+yErbuMFN
	wp/gpP8bhoxu5s6duKpDFE77kw/nzSbvCyIGBHS9U5n0Th9JKe9BW3eMMM+p8IQvQMqXBq
	N5PgSjMU5EXbWBIgdQqSAoYFzaJNFeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734543834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUNMvWcH7JO+1uLit8e9uAdYe6mpjTd+Wldg9gazhR8=;
	b=LZCCoxXlDdmbPamDN0DQZf136laiY2ZWDAgfuoDzt0MVKbmO1/L1j4NAl1dABnMqo1HXGk
	5fnpURdtmphTFLDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734543834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUNMvWcH7JO+1uLit8e9uAdYe6mpjTd+Wldg9gazhR8=;
	b=haOq5qcA6GKv0nqHAfYpR6YkDZrFMxBdgoWZQb2rNYdKZzEl+wg+JytWjg4jc+yErbuMFN
	wp/gpP8bhoxu5s6duKpDFE77kw/nzSbvCyIGBHS9U5n0Th9JKe9BW3eMMM+p8IQvQMqXBq
	N5PgSjMU5EXbWBIgdQqSAoYFzaJNFeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734543834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUNMvWcH7JO+1uLit8e9uAdYe6mpjTd+Wldg9gazhR8=;
	b=LZCCoxXlDdmbPamDN0DQZf136laiY2ZWDAgfuoDzt0MVKbmO1/L1j4NAl1dABnMqo1HXGk
	5fnpURdtmphTFLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8220132EA;
	Wed, 18 Dec 2024 17:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qwtxONkJY2faYAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 17:43:53 +0000
Date: Wed, 18 Dec 2024 18:43:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: fix direct super block member read
Message-ID: <20241218174351.GC31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <67a25027c7d05f33c71015b60fcfb75d89ac0ab9.1734503454.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a25027c7d05f33c71015b60fcfb75d89ac0ab9.1734503454.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Dec 18, 2024 at 05:00:56PM +1030, Qu Wenruo wrote:
> The following sysfs entries are reading super block member directly,
> which can have a different endian and cause wrong values:
> 
> - sys/fs/btrfs/<uuid>/nodesize
> - sys/fs/btrfs/<uuid>/sectorsize
> - sys/fs/btrfs/<uuid>/clone_alignment
> 
> Thankfully those values (nodesize and sectorsize) are always aligned
> inside the btrfs_super_block, so it won't trigger unaligned read errors,
> just endian problems.
> 
> Fix them by using the native cached members instead.
> 
> Fixes: df93589a1737 ("btrfs: export more from FS_INFO to sysfs")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

That's an old one.

Reviewed-by: David Sterba <dsterba@suse.com>

