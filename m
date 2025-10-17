Return-Path: <linux-btrfs+bounces-17971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F196BEAFD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5587C4A50
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09F2F6586;
	Fri, 17 Oct 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sb8b1c63";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPq/In7z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sb8b1c63";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPq/In7z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC782F6566
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720451; cv=none; b=aOyzeWyTtDMU+71e1oNKNI/HsoEgIWLg+uRo65wQyNLRjF2O6fieWMKsvJtq4h9zZ70MwsVG8P1a66kJhELvDbnUTdIr0e5hRM7Wwbd7JP2JTisCxc+3mbl3NsfZaw+mmI6fmguSV9zgmtIT95o5EhYWjopQh031ytflXRytP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720451; c=relaxed/simple;
	bh=wfkX9uq/zeD0hGmrnCTPwafTf+08OWSGUiIlSsLOoVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb723fATNCZ0kd8MmmaIvH1YFyqC/vWLOxLQDfDozRS0Zr/OA3vRKIfyfSyFw1ylFW2xd95iFQCMNNfTdZ44Y9STh9AGliM/c3G0PadShRzTgIWJyeW8RqbNm3VD/id2mCbRR5Nb8H0/3AD+pOzOwc3a6mKpyWBwZpPLSraETHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sb8b1c63; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPq/In7z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sb8b1c63; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPq/In7z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8DDE1FEE7;
	Fri, 17 Oct 2025 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760720446;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjdc9+grXSglujh74sTrph5/QrgbpFdSkN28MaNPYQE=;
	b=Sb8b1c63cJpcMRK0N4xdVuhp6vtwkypPTc5Pb3Igmufn0OeLxwJb+vNUPZrw6JizA0uSga
	Bj3gqgnEV+0VTqToQhjxthckbL/iktSgSEuzbrTucdhsIxUcqYfgFSkA9fRSQySPv5sUFO
	bWpuw7WPbDf/gECBR1jxKJJhSDnI0VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760720446;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjdc9+grXSglujh74sTrph5/QrgbpFdSkN28MaNPYQE=;
	b=dPq/In7z4TEhZ3uSj8XCcr0ryJF7LzNw9ab7kPDy3qzaGap/x6ziY37GtSPASc+Ig/KyNc
	avTESw+jIvVYnhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Sb8b1c63;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dPq/In7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760720446;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjdc9+grXSglujh74sTrph5/QrgbpFdSkN28MaNPYQE=;
	b=Sb8b1c63cJpcMRK0N4xdVuhp6vtwkypPTc5Pb3Igmufn0OeLxwJb+vNUPZrw6JizA0uSga
	Bj3gqgnEV+0VTqToQhjxthckbL/iktSgSEuzbrTucdhsIxUcqYfgFSkA9fRSQySPv5sUFO
	bWpuw7WPbDf/gECBR1jxKJJhSDnI0VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760720446;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjdc9+grXSglujh74sTrph5/QrgbpFdSkN28MaNPYQE=;
	b=dPq/In7z4TEhZ3uSj8XCcr0ryJF7LzNw9ab7kPDy3qzaGap/x6ziY37GtSPASc+Ig/KyNc
	avTESw+jIvVYnhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B03913A71;
	Fri, 17 Oct 2025 17:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIgiJT528miEawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 Oct 2025 17:00:46 +0000
Date: Fri, 17 Oct 2025 19:00:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is
 being frozen
Message-ID: <20251017170045.GN13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1760588662.git.wqu@suse.com>
 <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
 <20251016164224.GH13776@twin.jikos.cz>
 <c66eae15-2651-405c-a024-05a31e836fc5@gmx.com>
 <7a20d7da-d536-459c-be04-b530d8d1ef98@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a20d7da-d536-459c-be04-b530d8d1ef98@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B8DDE1FEE7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Fri, Oct 17, 2025 at 06:24:33PM +1030, Qu Wenruo wrote:
> 在 2025/10/17 07:05, Qu Wenruo 写道:
> > 在 2025/10/17 03:12, David Sterba 写道:
> >> On Thu, Oct 16, 2025 at 03:02:30PM +1030, Qu Wenruo wrote:
> >>> It's a known bug that btrfs scrub/dev-replace can prevent the system
> >>> from suspending.
> >>>
> >>> There are at least two factors involved:
> >>>
> >>> - Holding super_block::s_writers for the whole scrub/dev-replace
> >>>    duration
> >>>    We hold that mutex through mnt_want_write_file() for the whole
> >>>    scrub/dev-replace duration.
> >>>
> >>>    That will prevent the fs being frozen.
> >>>    It's tunable for the kernel to suspend all fses before suspending, if
> >>>    that's the case, a running scrub will refuse to be frozen and prevent
> >>>    suspension.
> >>>
> >>> - Stuck in kernel space for a long time
> >>>    During suspension all user processes (and some kernel threads) will
> >>>    be frozen.
> >>>    But if a user space progress has fallen into kernel (scrub ioctl) and
> >>>    do not return for a long time, it will make suspension time out.
> >>>
> >>>    Unfortunately scrub/dev-replace is a long running ioctl, and it will
> >>>    prevent the btrfs process from returning to user space.
> >>>
> >>> Address them in one go:
> >>>
> >>> - Introduce a new helper should_cancel_scrub()
> >>>    Which checks both fs and process freezing.
> >>>
> >>> - Cancel the run if should_cancel_scrub() is true
> >>>    The check is done at scrub_simple_mirror() and
> >>>    scrub_raid56_parity_stripe().
> >>>
> >>>    Unfortunately canceling is the only feasible solution here, 
> >>> pausing is
> >>>    not possible as we will still stay in the kernel state thus will 
> >>> still
> >>>    prevent the process from being frozen.
> >>
> >> I don't recall the details but the solution I was working on allowed
> >> waiting in kernel and not cancelling the whole scrub,
> > 
> > That will only allow the fs to be frozen, but not pm suspension/ 
> > hibernation.
> > 
> > As I explained, pm requires all user space processes to return to user 
> > space.
> > 
> > That's why your RFC patch doesn't pass Askar Safin's test at all, no 
> > matter if the pm is configured to freeze the fs or not.
> 
> If you really want to a resumable scrub/dev-replace between pm 
> operations, it's possible but not in the current scrub/replace ioctl.

Cancelling scrub is not that bad and it also keeps the last status
(assuming we can store it during suspend phase). I'd be more worried
about replace, I'm not sure if it's restartable from the last recorded
point or not.

> You can do it in a kthread, and freeze the kthread during pm operations, 
> and resume from whatever it was.
> 
> The problem is, this requires a new ioctl, and we should also take the 
> time reconsider how the new scrub ioctl should be.

The scrub and replace ioctls are extensible, we don't need a completely
new one. We can add new flag or command if we'd want to start a kthread.

> E.g. there are already some existing problems, like scrub cancel is 
> global, that you can not cancel scrub of a single device without 
> affecting others.

The scrub cancel ioctl is no extensible so in this case we'd need a new
one to cancel just a given device.

> And of course there are some other minor things like the timing of 
> holding s_writers, but that's way small details compared to running 
> scrub/replace in a kthread.
> 
> If you really want to go that path, I'm totally fine and happy with 
> that, but that will be a way larger user interface changes.
> 
> 
> For now, my series addresses the more user impacting problem (long time 
> out and all other processes frozen, just acting like the system is 
> hanging), and I'll add extra notes to scrub/dev-replace about the 
> behavior change.

On one side I agree that allowing the suspend continue at the cost of
cancelled scrub is an improvement. And we can eventually improve that.
The concerns about cancelling the operations are usability and
documenting the behaviour won't be enough, so at lest a message to log
would be good so there's a trace. I don't know if we can catch the
reason, ideally when it would be caused by suspend/freezing then print
something informative and suggest restarting it.

