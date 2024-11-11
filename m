Return-Path: <linux-btrfs+bounces-9429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D89C411B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 15:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98BE2812E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC121A08A3;
	Mon, 11 Nov 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIiP7Dln";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lk/HBW1u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIiP7Dln";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lk/HBW1u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADA19F10A
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335890; cv=none; b=LOUU7V/1uetXJiog/T+2Tq4+K9nT5VSh5sEwigsHNfK0YwETLDxRibT19UbN90CeeaPadv7pS7tPWpEtWPe7/bU6vLV0d0VH0kqbe23bJmmAq46/gJTjOoaUUvcYZZ512QFb7glfOe5X9EDItOgTlTifUx1zJVJgwbouHuMjR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335890; c=relaxed/simple;
	bh=eIbpCH3N+aGO6TfKkkqVCK9xklSEB5TeMAcZkNfjCQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZrkBEpFvzZgBPT7Mf/L9fQ//fzt2q+OX26LovcbgPnBgv2Kz9Wo+h6ysjO98XdVSyTc+sN9b1bK6n3gLp/RKkppDapBn+bXYWvISXoUJ2Sfnru+Qv+HnC2FnHXf33NunXrsV+094YeTUoBTpAMFmF1ggMRu2qWXR23EMiPvVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIiP7Dln; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lk/HBW1u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIiP7Dln; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lk/HBW1u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABB4321991;
	Mon, 11 Nov 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731335885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykNWf+Lf5L33SgxJzxwLCMaf0zZhwI199v+Mmc36alQ=;
	b=oIiP7DlnipV4+hc1/JtVY0OSJ8nUUCnMG37OCHBQVLAb5Helj5oQzzYul+Wm2G8BfOo2tu
	XGLaVfgmZR0FE25Cet9HRUyNPUKcbE249eXulIZ8LViAw6qIAxraJHiaH1/D5gyWDFWeqH
	02eJUKqB3fyqi0S+Kosdex2RxDTZd6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731335885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykNWf+Lf5L33SgxJzxwLCMaf0zZhwI199v+Mmc36alQ=;
	b=lk/HBW1uFJFyVhU4RCoznHHj0nuOGA4+Fc4yNXMWldmIAtAu6DWjZyCeFe+SikaJV1gwR6
	G0CJf5R776WN8aDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oIiP7Dln;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="lk/HBW1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731335885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykNWf+Lf5L33SgxJzxwLCMaf0zZhwI199v+Mmc36alQ=;
	b=oIiP7DlnipV4+hc1/JtVY0OSJ8nUUCnMG37OCHBQVLAb5Helj5oQzzYul+Wm2G8BfOo2tu
	XGLaVfgmZR0FE25Cet9HRUyNPUKcbE249eXulIZ8LViAw6qIAxraJHiaH1/D5gyWDFWeqH
	02eJUKqB3fyqi0S+Kosdex2RxDTZd6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731335885;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykNWf+Lf5L33SgxJzxwLCMaf0zZhwI199v+Mmc36alQ=;
	b=lk/HBW1uFJFyVhU4RCoznHHj0nuOGA4+Fc4yNXMWldmIAtAu6DWjZyCeFe+SikaJV1gwR6
	G0CJf5R776WN8aDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B4AC13301;
	Mon, 11 Nov 2024 14:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u3vJIc0WMmcDawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Nov 2024 14:38:05 +0000
Date: Mon, 11 Nov 2024 15:38:04 +0100
From: David Sterba <dsterba@suse.cz>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@fb.com>, oe-kbuild-all@lists.linux.dev,
	David Sterba <dsterba@suse.com>, kernel test robot <lkp@intel.com>
Subject: Re: [linux-next:master 8334/9360] fs/btrfs/ioctl.c:4975:9-16:
 WARNING opportunity for kmemdup
Message-ID: <20241111143804.GP31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <202411050846.GI8oh5IK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411050846.GI8oh5IK-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: ABB4321991
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Nov 05, 2024 at 08:05:14AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   1ffec08567f426a1c593e038cadc61bdc38cb467
> commit: 48b8a3df6d216bf9641bebf1efa1a3e1bdc9520d [8334/9360] btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)
> config: x86_64-randconfig-103-20241104 (https://download.01.org/0day-ci/archive/20241105/202411050846.GI8oh5IK-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411050846.GI8oh5IK-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> fs/btrfs/ioctl.c:4975:9-16: WARNING opportunity for kmemdup
> 
> vim +4975 fs/btrfs/ioctl.c
> 
>   4869	static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
>   4870	{

>   4970			/*
>   4971			 * If we've optimized things by storing the iovecs on the stack,
>   4972			 * undo this.
>   4973			 */
>   4974			if (!iov) {
> > 4975				iov = kmalloc(sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
>   4976				if (!iov) {
>   4977					unlock_extent(io_tree, start, lockend, &cached_state);
>   4978					btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>   4979					ret = -ENOMEM;
>   4980					goto out_acct;
>   4981				}
>   4982	
>   4983				memcpy(iov, iovstack, sizeof(struct iovec) * args.iovcnt);

Yeah, easy patch if anybody wants to send it.

