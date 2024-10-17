Return-Path: <linux-btrfs+bounces-8985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250609A246D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD81A1F248AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D51DE2D7;
	Thu, 17 Oct 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CD3xYR56";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="350tkQPC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CD3xYR56";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="350tkQPC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1639FE5
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173685; cv=none; b=JupKoh725UdFpwDTvHMmOPsvBMAKvZjRajdgGGfM3qZbeix5qKHIm3WCA3BgPCOaYi1mFAX/Byn4fBQI/CJdtN1jgdc+OM+QHRx8H4EMEy79VgGkU+GG0/TRU8ohrCCYjLQXY0DG9YBKX5xjCxpaCUFEQb6MJRLuFHPbLfvu3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173685; c=relaxed/simple;
	bh=TKDbQ3MvDhz/+i6vorpyQpvN2J1kT5Z3Pg2u+hIgFPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adBeq7xBv6DSJ/ih+JtbZpW8gzbS1IoYnxl24K14ZIVtbClxkZ1mRnaycLq7zu2TZoezk/IJUqN0cUikUtjNw09g/h24pXxaS/3UNiQFF1gR14MCeUZs3InUHoXlOcnHbrzrv3vRFp7LNjHDUqM8qKFliOyG5J4PwzHupcwBE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CD3xYR56; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=350tkQPC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CD3xYR56; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=350tkQPC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C0241FD34;
	Thu, 17 Oct 2024 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729173678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai+x30Eo3ts0wAGW5wTlDiFMgVtQbp4XeqIGLX1F5Yo=;
	b=CD3xYR56ONdiyMpVI2Mc/ufXbfGE4otEeJe+6RZH5B8Y2XlSDTnQJrI87IKc4AUDNMVkzi
	z5OmM4kY6xTdx3FxGvU0h8XyIMkMftZ4xVuip9u4Psa50o6oSH+omMLDvzF+wqBb3yog7r
	LMFv49Pg03pLXVzDJ6dkePehxh6vIHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729173678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai+x30Eo3ts0wAGW5wTlDiFMgVtQbp4XeqIGLX1F5Yo=;
	b=350tkQPCD8YOYXo83RqNS4BywRKz3L76B5sZtwIIFBiUJd/jJAtBsz4kqK1m7WTgYSFRtH
	5ErSQIvk+KxjvCDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CD3xYR56;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=350tkQPC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729173678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai+x30Eo3ts0wAGW5wTlDiFMgVtQbp4XeqIGLX1F5Yo=;
	b=CD3xYR56ONdiyMpVI2Mc/ufXbfGE4otEeJe+6RZH5B8Y2XlSDTnQJrI87IKc4AUDNMVkzi
	z5OmM4kY6xTdx3FxGvU0h8XyIMkMftZ4xVuip9u4Psa50o6oSH+omMLDvzF+wqBb3yog7r
	LMFv49Pg03pLXVzDJ6dkePehxh6vIHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729173678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai+x30Eo3ts0wAGW5wTlDiFMgVtQbp4XeqIGLX1F5Yo=;
	b=350tkQPCD8YOYXo83RqNS4BywRKz3L76B5sZtwIIFBiUJd/jJAtBsz4kqK1m7WTgYSFRtH
	5ErSQIvk+KxjvCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B96613A53;
	Thu, 17 Oct 2024 14:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vvw8Eq4YEWfVHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 17 Oct 2024 14:01:18 +0000
Date: Thu, 17 Oct 2024 16:01:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <20241017140112.GT1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6C0241FD34
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Oct 15, 2024 at 02:38:34PM -0700, Boris Burkov wrote:
> If you follow the seed/sprout wiki, it suggests the following workflow:
> 
> btrfstune -S 1 seed_dev
> mount seed_dev mnt
> btrfs device add sprout_dev
> mount -o remount,rw mnt
> 
> The first mount mounts the FS readonly, which results in not setting
> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> somewhat surprisingly clears the readonly bit on the sb (though the
> mount is still practically readonly, from the users perspective...).
> Finally, the remount checks the readonly bit on the sb against the flag
> and sees no change, so it does not run the code intended to run on
> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> 
> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> does no work. This results in leaking deleted snapshots until we run out
> of space.
> 
> I propose fixing it at the first departure from what feels reasonable:
> when we clear the readonly bit on the sb during device add.
> 
> A new fstest I have written reproduces the bug and confirms the fix.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Note that this is a resend of an old unmerged fix:
> https://lore.kernel.org/linux-btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
> Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
> were also explored but not merged around that time:
> https://lore.kernel.org/linux-btrfs/cover.1654216941.git.anand.jain@oracle.com/
> 
> I don't have a strong preference, but I would really like to see this
> trivial bug fixed. For what it is worth, we have been carrying this
> patch internally at Meta since I first sent it with no incident.

We have an unresolved dispute about the fix and now the patch got to
for-next within a few days because it got two reviews but not mine.
The way you use it in Meta works for you but the fix is changing
behaviour so we can either ignore everybody else relying on the old
way or say that seeding is so niche that we don't care and see what we
can do once we get some report.

