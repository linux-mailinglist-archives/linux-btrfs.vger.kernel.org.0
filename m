Return-Path: <linux-btrfs+bounces-12438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB54A69BD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6784280A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 22:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B721859F;
	Wed, 19 Mar 2025 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CGwgMwjB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Va3Qxl7O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CGwgMwjB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Va3Qxl7O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD120899C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422385; cv=none; b=Ao1jGJpciuUF+95gqpiTK0RWWq2AJ9GgP21g5l/Sqio3P1itCrc+HvZYJBzxOW0wF9POgJTJuC5r8JzGhEPhkJ410gqwKjU2p2G/zZuIR15EnYRJmvJsdkbULgLuR/yF87ceXHWpy/fljxFrauch9HnmcE6eAFh6mY9r0N9H6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422385; c=relaxed/simple;
	bh=s7X6+GHEg5OpurjCTeSnVRyK5I638fbNdooKgYBOArs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZAeUTfnsxtUoplTgWvWI5ME0sda3NjIWD6W8u4H57dccIPV0Y8wDVywWzKQUWjRwkLg5CdMYLYD6b6OV+RJH7/Uqk5pcbEEui3B9DQ6HzdB1ymgdD6q9Pj3lHTRLntkRMzTq5LgNDfmi1QHvirNqmkGH7tqmQXKBk188qKjq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CGwgMwjB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Va3Qxl7O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CGwgMwjB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Va3Qxl7O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 377F01FDBE;
	Wed, 19 Mar 2025 22:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742422382;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah6Djs1hXnnpra0kt0dTwr25oYuejgeFHcmKial87HE=;
	b=CGwgMwjBKrKhWs5kxxg/XEEcVIVK+BnOLYJjDfqAqVHd2TjS4utpkSZ2VmGIg0DNpuPgok
	I1E8+55T9hUDffyQPvKASjVS0GJwGTeNKc26ICVeOI6cFtqMyiQQ0K1XnrreqT5wg3rTVt
	Kekb2hfWJfCN1K956HVtK9TClFszmi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742422382;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah6Djs1hXnnpra0kt0dTwr25oYuejgeFHcmKial87HE=;
	b=Va3Qxl7OhGKn7PHiYuQI0vbdJcV5zDM+aF+zV3ktU04yOoOYOe+BcReiYSvAwJfkhT+C+F
	1JFE9o8N4Ccb3HBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742422382;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah6Djs1hXnnpra0kt0dTwr25oYuejgeFHcmKial87HE=;
	b=CGwgMwjBKrKhWs5kxxg/XEEcVIVK+BnOLYJjDfqAqVHd2TjS4utpkSZ2VmGIg0DNpuPgok
	I1E8+55T9hUDffyQPvKASjVS0GJwGTeNKc26ICVeOI6cFtqMyiQQ0K1XnrreqT5wg3rTVt
	Kekb2hfWJfCN1K956HVtK9TClFszmi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742422382;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah6Djs1hXnnpra0kt0dTwr25oYuejgeFHcmKial87HE=;
	b=Va3Qxl7OhGKn7PHiYuQI0vbdJcV5zDM+aF+zV3ktU04yOoOYOe+BcReiYSvAwJfkhT+C+F
	1JFE9o8N4Ccb3HBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0875413726;
	Wed, 19 Mar 2025 22:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vrWUAW5B22c1QQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 22:13:02 +0000
Date: Wed, 19 Mar 2025 23:12:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs-progs: -q/--quiet not accepted for "btrfs subvolume"
 subcommands
Message-ID: <20250319221256.GQ32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241217195649.143d2c94@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217195649.143d2c94@nvm>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Dec 17, 2024 at 07:56:49PM +0500, Roman Mamedov wrote:
> Hello,
> 
> # btrfs --version
> btrfs-progs v6.6.3
> 
> # btrfs sub create --help
> usage: btrfs subvolume create [options] [<dest>/]<name> [[<dest2>/]<name2> ...]
> 
>     Create subvolume(s)
> 
>     Create subvolume(s) at specified destination.  If <dest> is not given
>     subvolume <name> will be created in the current directory. Options apply
>     to all created subvolumes.
> 
>     -i <qgroupid>             add the newly created subvolume(s) to a qgroup. This option can be given multiple times.
>     -p|--parents              create any missing parent directories for each argument (like mkdir -p) 
>     
>     Global options:
>     -q|--quiet                print only errors 
> 
> # btrfs sub create -q test
> btrfs subvolume create: invalid option 'q'
> Try 'btrfs subvolume create --help' for more information
> 
> # btrfs sub create --quiet test
> btrfs subvolume create: unrecognized option '--quiet'
> Try 'btrfs subvolume create --help' for more information
> 
> Same for "snapshot". Maybe also some or all others, did not check further.
> 
> This is the case also on btrfs-progs versions 5.10 and 6.2.

The global options -q/-v and others are supposed to be right after the
'btrfs' term, like

  $ btrfs -q subvolume create test

This is mentioned at the top of 'btrfs --help' but maybe it needs to be
made more visible or repeated at the end of the help too.

