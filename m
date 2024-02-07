Return-Path: <linux-btrfs+bounces-2208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B184C869
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47AF8B22F37
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409E25614;
	Wed,  7 Feb 2024 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LehJ2uOR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="44k4smML";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LehJ2uOR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="44k4smML"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BC25615
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301034; cv=none; b=CR6vljQ47L5a1QpVbIHMdM+RTGm+pYGRJZp63GQmFJ+nNfxiVnBgOhu4T36Je/R5ZM01L4/Of85ICEMsz5EHNeWcXYJbMWr6Ojaw8vBGFKdWFdS1J7VF6kwFvAqfWAyd1GAgPvjx5CeHt3DgHbyBEMpO1b6YXkk4qQqKrqxpoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301034; c=relaxed/simple;
	bh=VfrqnxLqjxTE6fF1PtbMbIyrOfAVwZTjG7deGXniMp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMr966gNNaK0vnXfehxkqn2gTSvrbTqF9W0FUhJsHUmKIV3dkuRj0UkD0Cyl6m12YbWzutrWhe+nKX6pBw3/U/J3WksUtmICJxcgmZ7zD9ztjib2J6c4G5jw2fvDqyfKXc4Dah1MQVBnWxDkGGSMY9NDgOtSMQu1e1DO5/3Ka+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LehJ2uOR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=44k4smML; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LehJ2uOR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=44k4smML; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21DBF221D1;
	Wed,  7 Feb 2024 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707301030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOMCWVKwpCBz+BmjpIbzmKCu61K1IY4nZQ3lk11AUdM=;
	b=LehJ2uORBaDZNwsciODYkYteLxn7zIU+N90LKCyg0W7hOBj9pHg7yU2+rjb/QTCWWsHmdm
	f77jkQX/OLr5bvj4AVpFOLZx7eLC29c00FGWeeMLcqEbgLdl1t/cYtCl56UW+jVvdpanUP
	wi37FvQCCzfKh//ukxzVekapOjecCR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707301030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOMCWVKwpCBz+BmjpIbzmKCu61K1IY4nZQ3lk11AUdM=;
	b=44k4smMLQ4iMSOAo3QHCgUN38OWfBpqeKUmOU3sVLyjO2jw2gM/oKK2Y43grTPxqJ9UOa3
	wFB4DPYdJTtxcqDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707301030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOMCWVKwpCBz+BmjpIbzmKCu61K1IY4nZQ3lk11AUdM=;
	b=LehJ2uORBaDZNwsciODYkYteLxn7zIU+N90LKCyg0W7hOBj9pHg7yU2+rjb/QTCWWsHmdm
	f77jkQX/OLr5bvj4AVpFOLZx7eLC29c00FGWeeMLcqEbgLdl1t/cYtCl56UW+jVvdpanUP
	wi37FvQCCzfKh//ukxzVekapOjecCR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707301030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOMCWVKwpCBz+BmjpIbzmKCu61K1IY4nZQ3lk11AUdM=;
	b=44k4smMLQ4iMSOAo3QHCgUN38OWfBpqeKUmOU3sVLyjO2jw2gM/oKK2Y43grTPxqJ9UOa3
	wFB4DPYdJTtxcqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 025BF13931;
	Wed,  7 Feb 2024 10:17:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fahXAKZYw2VTXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 Feb 2024 10:17:10 +0000
Date: Wed, 7 Feb 2024 11:16:40 +0100
From: David Sterba <dsterba@suse.cz>
To: kreijack@inwind.it
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
Message-ID: <20240207101640.GV355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1702148009.git.kreijack@inwind.it>
 <20231214161749.GA9795@twin.jikos.cz>
 <6e4b2c09-b820-4ba8-8117-d13f3556e426@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4b2c09-b820-4ba8-8117-d13f3556e426@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LehJ2uOR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=44k4smML
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FREEMAIL_TO(0.00)[inwind.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 21DBF221D1
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Sat, Dec 30, 2023 at 12:20:54PM +0100, Goffredo Baroncelli wrote:
> On 14/12/2023 17.17, David Sterba wrote:
> > On Sat, Dec 09, 2023 at 07:53:20PM +0100, Goffredo Baroncelli wrote:
> >> From: Goffredo Baroncelli <kreijack@inwind.it>
> >>
> >> For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
> >> directory returning the 'fd' and a 'dirstream' variable returned by
> >> opendir(3).
> >>
> >> If the path is a file, the 'fd' is computed from open(2) and
> >> dirstream is set to NULL.
> >> If the path is a directory, first the directory is opened by opendir(3), then
> >> the 'fd' is computed using dirfd(3).
> >> However the 'dirstream' returned by opendir(3) is left open until 'fd'
> >> is not needed anymore.
> >>
> >> In near every case the 'dirstream' variable is not used. Only 'fd' is
> >> used.
> > 
> > As I'm reading dirfd manual page, dirfd returns the internal file
> > descriptor of the dirstream and it gets closed after call to closedir().
> > This means if we pass a directory and want a file descriptor then its
> > lifetime matches the correspoinding DIR.
> > 
> >> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
> >>
> >> Aim of this patch set is to getrid of this complexity; when the path of
> >> a directory is passed, the fd is get directly using open(path, O_RDONLY):
> >> so we don't need to use readdir(3) and to maintain the not used variable
> >> 'dirstream'.
> > 
> > Does this work the same way as with the dirstream?
> > 
> 
> Hi David, are you interested in this patch ? I think that it is a
> great simplification.

Sorry, I got distracted by other things.

The patchset does not apply cleanly on 6.7 so I've used 6.6.3 as the
base for testing. There's one failure in the cli tests, result can be
seen here https://github.com/kdave/btrfs-progs/actions/runs/7813042695/job/21311365019

====== RUN MUSTFAIL /home/runner/work/btrfs-progs/btrfs-progs/btrfs filesystem resize 1:-128M /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
ERROR: not a btrfs filesystem: /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
failed (expected): /home/runner/work/btrfs-progs/btrfs-progs/btrfs filesystem resize 1:-128M /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
no expected error message in the output 2
test failed for case 003-fi-resize-args

I think it's related to the changes to dirstream, however I can't
reproduce it locally, only on the github actions CI.

Unlike other commands in the test, this one is called on an image and it
must fail to prevent accidentaly resizing underlying filesystem.

