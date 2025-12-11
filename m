Return-Path: <linux-btrfs+bounces-19666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522CCB6E5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AF18300F196
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E7319619;
	Thu, 11 Dec 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uViNTwuG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJGZMDUd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yo+BK2I8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UWzze8o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0679212FB9
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765477499; cv=none; b=lLOmUo0ZSGCOpkIKMF9VdoROmj64cOcVDPVcj3BgwZe6Z6qJWN9W5P6p43WRuyoBDZOrJEKIay69cnudHiQ2Iyv312JT6iTr0kET4EYAHRFt0AWZo2oj8m1Iu+jRLl455aNz5t/mf6+mNxOUVQtxibD8ZzkaLjQzSbYEUuUvMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765477499; c=relaxed/simple;
	bh=PVqhRjlcHXt4N6/XH/LXJyXQkRA1fy8kHGL7GBurtsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzPg3gpLUfCG9x2ox6kpm9zRDRLef1fXcrzMGE+ZkF7BB8xiROIID5XruDUhotRXYY+w/bsBz5wCJXA1lrWgWiELmeMzG3GhJojL/ru/Mf+Y6BSywjrwBbr1ArF3niZlElyHrgo8sNiM0qwtE2bNcwU+t600KVjgVQ8iu2H2Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uViNTwuG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJGZMDUd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yo+BK2I8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UWzze8o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF8CB33740;
	Thu, 11 Dec 2025 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765477495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEtVaMfoVXQckovnlhONaOatvcRyMuoU+J7dWTxmSS8=;
	b=uViNTwuGK6CYl4uOfYLMYAOtTDZcocnAmvLyI2XydDOxccQ/0EzqEOevb6/6nNyVxspWnX
	ZVbfDaA2UByjg22RPbSeV/97RzzXubx31YTc4CJ3icH8DnANuRqjSdTqiaz9+Yu3hzW3Nz
	DSQMRm1bmRY+qBOOQHVNZFi2pzk5hy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765477495;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEtVaMfoVXQckovnlhONaOatvcRyMuoU+J7dWTxmSS8=;
	b=sJGZMDUdvjJUhTSMMlCDxwZV704HNuB7B48BdwvxglEHYGF0X7ZHjjQ1oFVJbtirlyxGOa
	9Vwyc76aYYMRqcCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Yo+BK2I8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0UWzze8o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765477493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEtVaMfoVXQckovnlhONaOatvcRyMuoU+J7dWTxmSS8=;
	b=Yo+BK2I8IJryfhvcFtW8DN/TZO0t7cJTKtLzgqmGvhZfXZYdxcSjvRT2rxSC+G6OArkc6S
	Gnvuw9aI6l7hDULp+780/8Jvm+7ayiXWy9SuDSLUUbtKV0z3crhS1j7dtZJWNXvbZjY+Ut
	nbM1cE/bzZpMmPZB0cbmUpmaW5l/3vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765477493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEtVaMfoVXQckovnlhONaOatvcRyMuoU+J7dWTxmSS8=;
	b=0UWzze8o1rFVG5fmrr0II0rgIGFKWAgP02pvn91dc88JNyKDO7CvCviNSe9lTQDrRlmgN8
	0ZKEDZcJs+gP51AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D290F3EA63;
	Thu, 11 Dec 2025 18:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eVkzM3UMO2nHFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Dec 2025 18:24:53 +0000
Date: Thu, 11 Dec 2025 19:24:52 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix changeset leak on mmap write after failure to
 reserve metadata
Message-ID: <20251211182452.GK4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ab2ab25d0598c04467a62e9e88c9131cec159c48.1765454225.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2ab25d0598c04467a62e9e88c9131cec159c48.1765454225.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.com:email,appspotmail.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: DF8CB33740
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, Dec 11, 2025 at 11:57:35AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the call to btrfs_delalloc_reserve_metadata() fails we jump to the
> 'out_noreserve' label and there we never free the extent_changeset
> allocated by the previous call to btrfs_check_data_free_space() (if
> qgroups are enabled). Fix this by calling extent_changeset_free() under
> the 'out_noreserve' label.
> 
> Fixes: 6599716de2d6 ("btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents")
> Reported-by: syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/693a635a.a70a0220.33cd7b.0029.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

