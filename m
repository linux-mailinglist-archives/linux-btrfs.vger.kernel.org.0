Return-Path: <linux-btrfs+bounces-2040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17248460D0
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 20:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362A51F29B51
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875285277;
	Thu,  1 Feb 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUyAvUu8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HO2BIeF5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUyAvUu8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HO2BIeF5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30384FC7
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815122; cv=none; b=Q1TdmN9hAIkey0M41hUNz/LxjSN1TrNgHvqD1cNanpxSbqWLHmQq9yXBp82ILVU3t6KOtEop18bv8fafkQJKx9NF7uZhNmTJ95WClzMNBjz4QlTuJVe4l2mHVYNAdPWkif6H++HoH/C6Dyeq9cyQrjb6yCl7KLU/QbUHGLx0o4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815122; c=relaxed/simple;
	bh=UTfpDq7uEHT6xTNLb64yphZLuz5wnnzLck8LBucsZxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6VFUna8gkiQ7bST/NwUozBweYe0wtyyGU3L6j5J0uRLyW0+A3And/GeoG2hXMWi1HNh0wrecuyzFGU6N9VPIgjeumc531vY/tU85dGKXXmBcEi9o8Eo2QE62MEKpQuYF0DJV86OocFOpiKDFyaS7lchBrH08jgKwaUHt19HCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUyAvUu8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HO2BIeF5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUyAvUu8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HO2BIeF5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEA121FB5C;
	Thu,  1 Feb 2024 19:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706815118;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Tk/n5LBred5NbutMZNKrV0vN66XAeWFeJTx3A0BP6A=;
	b=nUyAvUu89sGJJrOTC4sjxQr/MluMAN4frRdDGfT4F9UXD3nqAT/+40cb613bYi8ULsA56P
	D8Vqap/kvmzPwhR2QJTXQTqosU1Rq5meDVwJ7MJIdP8j4nGsRgQGTLa3TKqpEl5WHVBL7z
	7Ft8xbf1LWdQUWF9sRmCqjZ0GzV6Xec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706815118;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Tk/n5LBred5NbutMZNKrV0vN66XAeWFeJTx3A0BP6A=;
	b=HO2BIeF5H6SgzRbFnwMX3P/La3hhpWxQPJDiKJaiBFaC2mHEYMUQx3EFh4uIFBD3/Q9bUq
	9zGXC+xMidduh1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706815118;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Tk/n5LBred5NbutMZNKrV0vN66XAeWFeJTx3A0BP6A=;
	b=nUyAvUu89sGJJrOTC4sjxQr/MluMAN4frRdDGfT4F9UXD3nqAT/+40cb613bYi8ULsA56P
	D8Vqap/kvmzPwhR2QJTXQTqosU1Rq5meDVwJ7MJIdP8j4nGsRgQGTLa3TKqpEl5WHVBL7z
	7Ft8xbf1LWdQUWF9sRmCqjZ0GzV6Xec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706815118;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Tk/n5LBred5NbutMZNKrV0vN66XAeWFeJTx3A0BP6A=;
	b=HO2BIeF5H6SgzRbFnwMX3P/La3hhpWxQPJDiKJaiBFaC2mHEYMUQx3EFh4uIFBD3/Q9bUq
	9zGXC+xMidduh1CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A8AB81329F;
	Thu,  1 Feb 2024 19:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1+WSKI7uu2XLXAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 01 Feb 2024 19:18:38 +0000
Date: Thu, 1 Feb 2024 20:18:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
 mkfs.btrfs
Message-ID: <20240201191811.GX31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>
 <20240131204800.GB3203388@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131204800.GB3203388@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nUyAvUu8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HO2BIeF5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.71 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.45%]
X-Spam-Score: -2.71
X-Rspamd-Queue-Id: BEA121FB5C
X-Spam-Flag: NO

On Wed, Jan 31, 2024 at 03:48:00PM -0500, Josef Bacik wrote:
> On Wed, Jan 31, 2024 at 11:49:28PM +0800, Anand Jain wrote:
> > This cleanup patch reuses the main file descriptor (fd1) in open_ctree(),
> > and with this change both the test cases (with partition and without
> > partition) now runs fine.
> > 
> > I've done an initial tests only, not validated with the multi-device mkfs.
> > More cleanup is possible but pending feedback;  marking this patch as an RFC.
> 
> I'd like to see the cleaned up version of this patch, but I have a few comments.
> 
> 1) I think re-using the fd is reasonable, tho could this just be reworked to
>    create the temp-sb and write this to all the devs, close the file
>    descriptors, and then call open_ctree?

This would trigger the udev unnecessarily and could let other processes
to eg. try to mount the device (like systemd did or maybe still does).
This could fail the second open_ctree. That it's all done with one fd
open reduces possible interactions that could be problematic.

> 2) I hate adding another thing into a core file that we'll have to figure out
>    how to undo later as we sync more code from the kernel into btrfs-progs, I'm
>    not sure if there's a way around this, but thinking harder about adding
>    something to disk-io.c that is for userspace only would be good.

Yeah the open_ctree functions in progs are misplaced in disk-io.c and
are there for historical reasons. We'd need separate file (or maybe
whole compat directory) but for now let it be there, the cleanup is
going to be big.

