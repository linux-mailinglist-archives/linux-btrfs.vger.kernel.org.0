Return-Path: <linux-btrfs+bounces-10983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F52A13950
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 12:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F399E3A4593
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 11:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0483F1DE3DB;
	Thu, 16 Jan 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KWjM4nU8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SwPCh7rr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KWjM4nU8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SwPCh7rr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DC1D86F6
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027750; cv=none; b=FW2WxQFiVCalXVcQSJFpAFJ9/MXNiVFXLck3HNcSySK8sAaCNRHdj0H0BDJnIUBlkoFs7J0vtAjlhtOfSZDpTcxGJW04VrcKmjIl1GPL/3ye9Cwmi/92JQS1VvnrY4E+RU/Mvy3K43WMWLpXuaER+27YBlxXua0OcfejAu+ZgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027750; c=relaxed/simple;
	bh=jr4pxhqbwQ8EbQjVJtqRDUU+l/DJW+ZYDtJ95mu8ITs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X71q78yhSK2W1h5uVIM29iciwsJJmeZM168LQ0lN5WGJ+6jOfv2WQXhEojcipDJ+WdsmvyGo/0x93uDyJI9mGDezLNKHXHe8wB1e6YwOs6SXa4R4JB7VJLmY3FbG7QWibrQ/AVk/VOegf3lws0vAGuuOgjnaitFZne9wolXk47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KWjM4nU8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SwPCh7rr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KWjM4nU8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SwPCh7rr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A17A4211D4;
	Thu, 16 Jan 2025 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737027745;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0lGDq5JK8H063uF07VPH9TojOMEeth3p31vm7MPPW0=;
	b=KWjM4nU8VJfSwcQuJTuWRcf/ZY0R5D6gzYN/sUPncRO/Lg00cnvN+9L2bQoiDnRircWm+n
	m9k8UN3gTk5hMbSo0IOkpWKq5cnAISPnjEUr19Xnm2bEAgdxlu76iug42ussSJT09VzHR/
	5LYHaesLycN+C97MwEk7JAMpFGoQXLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737027745;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0lGDq5JK8H063uF07VPH9TojOMEeth3p31vm7MPPW0=;
	b=SwPCh7rrnpNBG+P1sV2HGuucyAR8/YskSXrYFIKUt83t8JU0EKomdjKqd2ozIb9DYCdZhm
	dtChY+6r/I1taaAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737027745;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0lGDq5JK8H063uF07VPH9TojOMEeth3p31vm7MPPW0=;
	b=KWjM4nU8VJfSwcQuJTuWRcf/ZY0R5D6gzYN/sUPncRO/Lg00cnvN+9L2bQoiDnRircWm+n
	m9k8UN3gTk5hMbSo0IOkpWKq5cnAISPnjEUr19Xnm2bEAgdxlu76iug42ussSJT09VzHR/
	5LYHaesLycN+C97MwEk7JAMpFGoQXLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737027745;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0lGDq5JK8H063uF07VPH9TojOMEeth3p31vm7MPPW0=;
	b=SwPCh7rrnpNBG+P1sV2HGuucyAR8/YskSXrYFIKUt83t8JU0EKomdjKqd2ozIb9DYCdZhm
	dtChY+6r/I1taaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87EED13332;
	Thu, 16 Jan 2025 11:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Wv5IKHwiGeZMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 Jan 2025 11:42:25 +0000
Date: Thu, 16 Jan 2025 12:42:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove loopback device resolution
Message-ID: <20250116114219.GC5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6094201431aa981c6e0d149b6d528bc4b7a5af91.1737020580.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6094201431aa981c6e0d149b6d528bc4b7a5af91.1737020580.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Jan 16, 2025 at 08:13:01PM +1030, Qu Wenruo wrote:
> [BUG]
> mkfs.btrfs has a built-in loopback device resolution, to avoid the same
> file being added to the same fs, using loopback device and the file
> itself.
> 
> But it has one big bug:
> 
> - It doesn't detect partition on loopback devices correctly
>   The function is_loop_device() only utilize major number to detect a
>   loopback device.
>   But partitions on loopback devices doesn't use the same major number
>   as the loopback device:
> 
>   NAME            MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
>   loop0             7:0    0    5G  0 loop
>   |-loop0p1       259:3    0  128M  0 part
>   `-loop0p2       259:4    0  4.9G  0 part
> 
>   Thus `/dev/loop0p1` will not be treated as a loopback device, thus it
>   will not even resolve the source file.
> 
>   And this can not even be fixed, as if we do extra "/dev/loop*" based
>   file lookup, `/dev/loop0p1` and `/dev/loop0p2` will resolve to the
>   same source file, and refuse to mkfs on two different partitions.
> 
> [FIX]
> The loopback file detection is the baby sitting that no one asks for.
> 
> Just as I explained, it only brings new bugs, and we will never fix all
> ways that an experienced user can come up with.
> And I didn't see any other mkfs tool doing such baby sitting.
> 
> So remove the loopback file resolution, just regular is_same_blk_file()
> is good enough.

The loop device resolution had some bugs in the past and was added for a
reason that's not mentioned in the changelogs.

The commits have some details why it's done, they also mention that
partitioned devices are resolved so it's not that there's no support for
that.

0cf3b78f404b01 ("btrfs-progs: Fix partitioned loop devices resolving")
abdb0ced0123d4 ("Btrfs-progs: fix resolving of loop devices")
09559bfe7bcd43 ("multidevice support for check_mounted")

and some fixup commits.

So before removing the code completely I'd like to see if there's a use
case that can be broken, but I don't have anything in particular.
There's only mkfs-tests/006-partitioned-loopdev that's quite simple and
does not try to do any tricks with symlinks or partitions on the
devices.

