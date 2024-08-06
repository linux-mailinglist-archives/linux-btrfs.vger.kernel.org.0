Return-Path: <linux-btrfs+bounces-6998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1A948C9E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02E31C22912
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75F1BE23C;
	Tue,  6 Aug 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NwmprdmC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lY6J8swy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NwmprdmC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lY6J8swy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE916D4DD
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939100; cv=none; b=nND6X/eNhjL2wRAO4xv6Ms4ew5Mf+/mNlU2vKe69yJAhcD+RhViUdqHbx9k0wieE42Z9fMFKQrF/aXI6crqGafGQ1fmI5yOLf5oUp6Fzsd5nvlNQLfLet2CIs047W3KcjXyLc2k513m3V1aJ/zBzkRnYWwC/lfHg8/8ABtgi54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939100; c=relaxed/simple;
	bh=d3qsmPrQ3s0Oksg44PIl3CrKxr2DF9nYQT614nAyy0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSHI4MG15v4km9ooe822YhZ4tDpG4M2dD4RL4qQkCiKDQgQcvk8ZDHi5um2F3rJuMWDsnBtELuQ9Jvissa7nLbapQTHOGBMCk624+UJVaRv2BVANhjZXvQByjIm+lRYFuTTfGXqOzCam2rO2CQuaHeS3ZUIzHVzs5CuuxzuZLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NwmprdmC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lY6J8swy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NwmprdmC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lY6J8swy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E39921CA9;
	Tue,  6 Aug 2024 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722939096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPZ/A33xtLYTl3b0afGTOkKViDDIuUFSqeeGCQ0Ga6g=;
	b=NwmprdmC063Z1fNDHPsQHQhyUjN62VnDmHmb13pyhqkVD9Y3ps6jz+dvKi6a4r0TqVCQ7a
	aVRvLfT3JK96zBPALK69w7ALNHHGFXulJ7BQA+qOqdniQEFNcIXcyp1YW/GUnKw3RQprN6
	oXeyei0NooaRQ6UhcTo7hlYaXiZtYOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722939096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPZ/A33xtLYTl3b0afGTOkKViDDIuUFSqeeGCQ0Ga6g=;
	b=lY6J8swypjrEICuMIhvVcQJnLyjXAV+zC5rpGohanJfxtXvuypnKkzPF77y1XWZUQ7WPSg
	nmkuTRShxS0O5HAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722939096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPZ/A33xtLYTl3b0afGTOkKViDDIuUFSqeeGCQ0Ga6g=;
	b=NwmprdmC063Z1fNDHPsQHQhyUjN62VnDmHmb13pyhqkVD9Y3ps6jz+dvKi6a4r0TqVCQ7a
	aVRvLfT3JK96zBPALK69w7ALNHHGFXulJ7BQA+qOqdniQEFNcIXcyp1YW/GUnKw3RQprN6
	oXeyei0NooaRQ6UhcTo7hlYaXiZtYOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722939096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPZ/A33xtLYTl3b0afGTOkKViDDIuUFSqeeGCQ0Ga6g=;
	b=lY6J8swypjrEICuMIhvVcQJnLyjXAV+zC5rpGohanJfxtXvuypnKkzPF77y1XWZUQ7WPSg
	nmkuTRShxS0O5HAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4633A13770;
	Tue,  6 Aug 2024 10:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mgqfENj2sWbeDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Aug 2024 10:11:36 +0000
Date: Tue, 6 Aug 2024 12:11:30 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_is_subpage() to return false directly
 for 4K page size
Message-ID: <20240806101130.GB17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bc8baf98c9c9357423178d4fab6b945bcb959f1d.1722839158.git.wqu@suse.com>
 <20240805162220.GX17473@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805162220.GX17473@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 05, 2024 at 06:22:20PM +0200, David Sterba wrote:
> On Mon, Aug 05, 2024 at 03:56:30PM +0930, Qu Wenruo wrote:
> > Btrfs only supports sectorsize 4K, 8K, 16K, 32K, 64K for now, thus for
> > systems with 4K page size, there is no way the fs is subpage (sectorsize
> > < PAGE_SIZE).
> > 
> > So here we define btrfs_is_subpage() different according to the
> > PAGE_SIZE:
> > 
> > - PAGE_SIZE > 4K
> >   We may hit real subpage cases, define btrfs_is_subpage() as a regular
> >   function and do the usual checks.
> > 
> > - PAGE_SIZE == 4K (no smaller PAGE_SIZE support AFAIK)
> >   There is no way the fs is subpage, so just define btrfs_is_subpage()
> >   as an inline function which always return false.
> > 
> > This saves some bytes for x86_64 debug builds:
> > 
> > 	   text	   data	    bss	    dec	    hex	filename
> > Before:	1484452	 168693	  25776	1678921	 199e49	fs/btrfs/btrfs.ko
> > After:	1476605	 168445	  25776	1670826	 197eaa	fs/btrfs/btrfs.ko
> 
> The delta is 7847, not bad and it's on x86_64 so it'll affect most
> machines.

On my release build config it's

   text    data     bss     dec     hex filename
1339533   30572   16088 1386193  1526d1 pre/btrfs.ko
1332328   30372   16088 1378788  1509e4 post/btrfs.ko

DELTA: -7205

