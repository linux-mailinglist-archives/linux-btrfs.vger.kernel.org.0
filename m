Return-Path: <linux-btrfs+bounces-6388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4392EB46
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80170284380
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5E716C699;
	Thu, 11 Jul 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LWDbkjgB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAxPwh2S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LWDbkjgB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAxPwh2S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EC15CD78
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710373; cv=none; b=O0gxmYT1TYDAZwsrzeHQVmEFoZ1WNvRIkff77TmHTMAjOhgkbaJ9+qDpl95mG7Nx+sSBY/yc0SPRw6OAox483SMUEAM5du7QtCYuBRfn8M1A+s+7CiSlBu5TbdnB204Hu/tALMjh6a0qAnzt9w3agWsmN57dxp9kjBCL/rbAeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710373; c=relaxed/simple;
	bh=ZV+bIo/8hO92hsoCnEFqcOVWM1ZUnDyOE5tGzuq4KgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD1REZw7lvkAy920+5c8LJyM4qt45wWpVugdr6YNIhCa2pcJouAgoGFAook1qws10hV5rHxu1B5OvNlOvy8celLr59fZeEO4YZmsGHaxpEFvgBK7ejkX6Dd7mNTvSJ/1POtARkMnZqmOFsVujA6DGdP112C31byJoJgv+US4rDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LWDbkjgB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAxPwh2S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LWDbkjgB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAxPwh2S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99E3321A49;
	Thu, 11 Jul 2024 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720710368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9onBDD3fxHI0Qgp7xBE4bj2GAG/YrCsPwSS1dXYLdO8=;
	b=LWDbkjgBYA+sAhcrbEPt9U3g69oJevFHJyBRwLlFwhnBrFU49F8JasbSOw9KTY52sVnqqe
	Hx2/4K8YVLTcjO5nCHJ9GRft848w3TkcPbDvbBJrY0rglYjp2d3Hr10S2V1z72ElwsQG/N
	JxQP89Dkqoo3zOVhfrxWAttvGGtrJtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720710368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9onBDD3fxHI0Qgp7xBE4bj2GAG/YrCsPwSS1dXYLdO8=;
	b=tAxPwh2S39EplaM4xIOLtQG84a5+28VbT/p+JqhNVcb2xRm92N4spIbqcd3p+BlgE4eRXZ
	uSVv9n9TwtVWjCDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LWDbkjgB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tAxPwh2S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720710368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9onBDD3fxHI0Qgp7xBE4bj2GAG/YrCsPwSS1dXYLdO8=;
	b=LWDbkjgBYA+sAhcrbEPt9U3g69oJevFHJyBRwLlFwhnBrFU49F8JasbSOw9KTY52sVnqqe
	Hx2/4K8YVLTcjO5nCHJ9GRft848w3TkcPbDvbBJrY0rglYjp2d3Hr10S2V1z72ElwsQG/N
	JxQP89Dkqoo3zOVhfrxWAttvGGtrJtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720710368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9onBDD3fxHI0Qgp7xBE4bj2GAG/YrCsPwSS1dXYLdO8=;
	b=tAxPwh2S39EplaM4xIOLtQG84a5+28VbT/p+JqhNVcb2xRm92N4spIbqcd3p+BlgE4eRXZ
	uSVv9n9TwtVWjCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B196136AF;
	Thu, 11 Jul 2024 15:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jBDFHeD0j2b1HAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jul 2024 15:06:08 +0000
Date: Thu, 11 Jul 2024 17:06:07 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6.10 0/3] btrfs: some fixes/updates for the extent map
 shrinker
Message-ID: <20240711150607.GC8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1720448663.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720448663.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 99E3321A49

On Mon, Jul 08, 2024 at 03:42:42PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A few fixes for the extent map shrinker that fix some reports from users
> where their desktops became very unresponsive.
> 
> Several notes here:
> 
> 1) The first patch was already sent before to the list and it's in
>    for-next already. It's unrelated to the reports from those users but
>    it's related to a report from syzbot for a deadlock in case the
>    shrinker does an iput on an inode with 0 links that needs to be
>    deleted, and when the inode still has links but it's dirty, it can
>    make the iput wait for writeback to complete, slowing down the
>    shrinker. I've included it here just to group things in a logical
>    way;
> 
> 2) These patches apply to 6.10-rc;
> 
> 3) At least the first 2 patches should go to 6.10 final IMO;
> 
> 4) In case they land in 6.10-rc, then for-next needs to be rebased since
>    there are minor and trivial conflicts to solve due to the last patch in
>    for-next that reduces the size of struct btrfs_inode down to 1024 bytes.
> 
>    Also the following patch which landed on for-next should be dropped
>    because it's made obsolete by the second patch in this patchset:
> 
>    https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com/
> 
> 5) There will be further improvements to the shrinker, namely to
>    reduce the latency of finding open inodes in a root, but those
>    will come later and may be too much for 6.10 final. It would also
>    require different patch versions for 6.10 and 6.11 (for-next) since
>    in the former we use a rbtree while in the later we have a xarray
>    now.
> 
> Thanks.
> 
> Filipe Manana (3):
>   btrfs: use delayed iput during extent map shrinking
>   btrfs: stop extent map shrinker if reschedule is needed
>   btrfs: avoid races when tracking progress for extent map shrinking

Thanks for the fixes, this seems to be urgent, I'd rather not delay
getting the fixes via stable with a 2 week delay. I'm going to send a
pull request for 6.10, the problems have been reported by early testing
users and will be most likely seen by more after release.

I hope this gives it enough justification despite the patch sizes and
ETA of 6.10 release.

