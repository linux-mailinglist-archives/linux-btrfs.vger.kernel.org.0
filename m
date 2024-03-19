Return-Path: <linux-btrfs+bounces-3446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DC88053A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072811F2490A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE29D39FE5;
	Tue, 19 Mar 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRc6YG2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5dZwg4br";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRc6YG2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5dZwg4br"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A52B9CF;
	Tue, 19 Mar 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710875069; cv=none; b=cn5Yo3V9GLM87u4p65xhpBpexOADqQZuKTmxSJeBodqUW6MLy3ym7lvvi/VvuIAsS6q/tccEVRoxp4nN37NFqvtx/hHkUL3Go58Xa25Z84HZzemKQGc5iGBOWisFA9qf4m3WND7pxOqW92HMKBn7CHEHNO+/n4A1QnKf2tiZvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710875069; c=relaxed/simple;
	bh=1pjcoLPclLzjr/spIkeBg9aX2MPdr/BpKaruYoQCPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut2VRqoHomVB5QIU16BOfnRhImEWLLiXLDg8D0BRF1scDmVmGBdUzFLtnuRXP9jes75SDS22mz/hp0CZ3qd/JrHnUBmCK6t28ZtQRVHclpiUnOk170BLAhRlSXYxq2JAtgsUNzYSyIZOCF+kKnf04W1FRXdCaa+GeK6sJZ9bdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRc6YG2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5dZwg4br; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRc6YG2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5dZwg4br; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39E552269E;
	Tue, 19 Mar 2024 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710875065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m62pe4FrwAX4W2HKydm4w3ADTQa0VQzYozY1M6lUmqg=;
	b=kRc6YG2SeImuplw8mrkrbKl3wl1XvxFbvIG60cqI4+KqpBclNfMzGjFu1uivSlc4BL1dhR
	L3aM/VziCWSBbfMzgl3oAf8Sn/HUE6d8eVY5I196h68y/LOEc6yk384iD5dl5MbBsu4TSM
	f51s6sLUFWGeRqdJHfsPE3BHOuXs64I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710875065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m62pe4FrwAX4W2HKydm4w3ADTQa0VQzYozY1M6lUmqg=;
	b=5dZwg4brtsInmvMmSkeb9afo9JrrV1Kb0M5/7ZEg/HEXIwm0yAevAC3aHkhbBGGEcGpUS9
	VqWluK7WGnw5D3AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710875065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m62pe4FrwAX4W2HKydm4w3ADTQa0VQzYozY1M6lUmqg=;
	b=kRc6YG2SeImuplw8mrkrbKl3wl1XvxFbvIG60cqI4+KqpBclNfMzGjFu1uivSlc4BL1dhR
	L3aM/VziCWSBbfMzgl3oAf8Sn/HUE6d8eVY5I196h68y/LOEc6yk384iD5dl5MbBsu4TSM
	f51s6sLUFWGeRqdJHfsPE3BHOuXs64I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710875065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m62pe4FrwAX4W2HKydm4w3ADTQa0VQzYozY1M6lUmqg=;
	b=5dZwg4brtsInmvMmSkeb9afo9JrrV1Kb0M5/7ZEg/HEXIwm0yAevAC3aHkhbBGGEcGpUS9
	VqWluK7WGnw5D3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C9361376B;
	Tue, 19 Mar 2024 19:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xgzGBrnh+WWTWQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 19 Mar 2024 19:04:25 +0000
Date: Tue, 19 Mar 2024 19:57:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19 5.4 5.15] btrfs: defrag: fix memory leak in
 btrfs_ioctl_defrag
Message-ID: <20240319185711.GA14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240319170055.17942-1-mheyne@amazon.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319170055.17942-1-mheyne@amazon.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.81
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.10)[65.16%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kRc6YG2S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5dZwg4br
X-Rspamd-Queue-Id: 39E552269E

On Tue, Mar 19, 2024 at 05:00:55PM +0000, Maximilian Heyne wrote:
> Prior to commit c853a5783ebe ("btrfs: allocate
> btrfs_ioctl_defrag_range_args on stack") range is allocated on the heap
> and must be freed. However, commit 173431b274a9 ("btrfs: defrag: reject
> unknown flags of btrfs_ioctl_defrag_range_args") didn't take care of
> this when it was backported to kernel < 5.15.
> 
> Add a kfree on the error path for stable kernels that lack
> commit c853a5783ebe ("btrfs: allocate btrfs_ioctl_defrag_range_args on
> stack").
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.

Good catch, thanks.

The affected versions are as you say 4.19, 5.4, 5.15, the fixup is
sufficient and minimal fix, c853a5783ebe is reasonably safe for backport
too.

