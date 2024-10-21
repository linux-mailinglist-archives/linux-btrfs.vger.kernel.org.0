Return-Path: <linux-btrfs+bounces-9036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363C9A72B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4489A1C2099E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC71FB3FD;
	Mon, 21 Oct 2024 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nG1J4L6E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgl8wUZk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nG1J4L6E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgl8wUZk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0221FB3D7
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537024; cv=none; b=Qc+KMA52fsf4wHxXWjVaZn7frpPOJc83gn6BS+x8K7ByIb3gRkaln5IQ0zEZQEOTyBd91+X6Mih5XTcsONBCPiQJCHn/9d+jtVfdOSo3GHQnFd+IQGxPgLh4nusMIMoo36PfiJ2HgW41fn236D0RsOP9X792TjCguhZZ+HmgMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537024; c=relaxed/simple;
	bh=D2JZPkkSSjNtH4TsIpjeFT00zXNAVQTDNsUE6UMRjtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMs3TGFRJ/SjlzrafdVQzfR7rHH6uhGtegiX9uiuZ5vCyMDdZ0MQiL+eBUcIO2scoBFtn4AvQvOS4eHPmIAFQgbmIG52tbhAHJ63FFZsImHVv/vhoHX9fRpJ/7l0Ozs1Kxd+NuVVaqkYfl5OA6YGCgEd/1YLtZdUg/mOsEjsvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nG1J4L6E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgl8wUZk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nG1J4L6E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgl8wUZk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2882121E02;
	Mon, 21 Oct 2024 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729537017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYygBL1hBvGiX2OGEioIhMPvxMmtgrfYv26aIIV+NtI=;
	b=nG1J4L6EFRNqxc/dO+VeWHkCnfTWULtelAKd241ulcz4qmz53CPPb0yKxM4EfUYTGqZU1u
	JGEz2Dm1LWopM5vJus7tICA7LnRJUPbEri59HHBWxzqR45kaMkO9uYuGuInO3xZCd9sAKS
	OrPT3jVGCgcn+ws+jLwYXSj5agAsHFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729537017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYygBL1hBvGiX2OGEioIhMPvxMmtgrfYv26aIIV+NtI=;
	b=lgl8wUZkRiyc6ZO7B9pG1xutKng3hAuZdh+A88pi2rV7+gfO8Gz/zt6FH/P3JWj+VTuaIJ
	FoFeERodbpBT4gCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729537017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYygBL1hBvGiX2OGEioIhMPvxMmtgrfYv26aIIV+NtI=;
	b=nG1J4L6EFRNqxc/dO+VeWHkCnfTWULtelAKd241ulcz4qmz53CPPb0yKxM4EfUYTGqZU1u
	JGEz2Dm1LWopM5vJus7tICA7LnRJUPbEri59HHBWxzqR45kaMkO9uYuGuInO3xZCd9sAKS
	OrPT3jVGCgcn+ws+jLwYXSj5agAsHFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729537017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYygBL1hBvGiX2OGEioIhMPvxMmtgrfYv26aIIV+NtI=;
	b=lgl8wUZkRiyc6ZO7B9pG1xutKng3hAuZdh+A88pi2rV7+gfO8Gz/zt6FH/P3JWj+VTuaIJ
	FoFeERodbpBT4gCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AF81136DC;
	Mon, 21 Oct 2024 18:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r6ANAvmjFmctKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 18:56:57 +0000
Date: Mon, 21 Oct 2024 20:56:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <20241021185651.GC24631@suse.cz>
Reply-To: dsterba@suse.cz
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <20241017140112.GT1609@twin.jikos.cz>
 <20241017164159.GA3061885@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017164159.GA3061885@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Oct 17, 2024 at 09:41:59AM -0700, Boris Burkov wrote:
> On Thu, Oct 17, 2024 at 04:01:12PM +0200, David Sterba wrote:
> > On Tue, Oct 15, 2024 at 02:38:34PM -0700, Boris Burkov wrote:
> > > If you follow the seed/sprout wiki, it suggests the following workflow:
> > > 
> > > btrfstune -S 1 seed_dev
> > > mount seed_dev mnt
> > > btrfs device add sprout_dev
> > > mount -o remount,rw mnt
> > > 
> > > The first mount mounts the FS readonly, which results in not setting
> > > BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> > > somewhat surprisingly clears the readonly bit on the sb (though the
> > > mount is still practically readonly, from the users perspective...).
> > > Finally, the remount checks the readonly bit on the sb against the flag
> > > and sees no change, so it does not run the code intended to run on
> > > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> > > 
> > > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> > > does no work. This results in leaking deleted snapshots until we run out
> > > of space.
> > > 
> > > I propose fixing it at the first departure from what feels reasonable:
> > > when we clear the readonly bit on the sb during device add.
> > > 
> > > A new fstest I have written reproduces the bug and confirms the fix.
> > > 
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > > Note that this is a resend of an old unmerged fix:
> > > https://lore.kernel.org/linux-btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
> > > Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
> > > were also explored but not merged around that time:
> > > https://lore.kernel.org/linux-btrfs/cover.1654216941.git.anand.jain@oracle.com/
> > > 
> > > I don't have a strong preference, but I would really like to see this
> > > trivial bug fixed. For what it is worth, we have been carrying this
> > > patch internally at Meta since I first sent it with no incident.
> > 
> > We have an unresolved dispute about the fix and now the patch got to
> > for-next within a few days because it got two reviews but not mine.
> > The way you use it in Meta works for you but the fix is changing
> > behaviour so we can either ignore everybody else relying on the old
> > way or say that seeding is so niche that we don't care and see what we
> > can do once we get some report.
> 
> Please feel free to remove it, and I am happy to review whatever other
> fix you think is best. Sorry for rushing, I just wanted to get it done
> and out of my head so I could move on to other issues.

I'm concerned because change like that needs an announcement,
documentation changes or eventually an optional change so both use cases
are available. I haven't merged it since the last time you or somebody
posted it because I don't see a way how to fix it without fixing the bug
and not breaking the use case.

> I assume your concern is that before this fix, the filesystem is actually
> read-write after the device add, which this patch breaks?
> 
> My only argument against this is that the documentation has always said
> you needed to remount/cycle-mount after adding the sprout, so there is
> no fair reason to assume this would work. (In fact, it *doesn't*, the fs
> is once again in a unexpected, degraded, state...)
> 
> But if existing LiveCD users are relying on this undocumented behavior,
> then I think you are right and it's a bad idea to break them.

The problem here is that we don't know how the feature is used, the
documentation came much later than the feature. So I take it as that
people rely on code, not documenation, even if there's an undocumented
behaviour.

