Return-Path: <linux-btrfs+bounces-4628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3498B602B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 19:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5D41F22B02
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E81272DB;
	Mon, 29 Apr 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJDkVh0Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/AEv3afU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJDkVh0Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/AEv3afU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4581272CB
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411886; cv=none; b=NoOn/gWN0SKO8wsvajtMyvAghqOwWtC9fI6eZLjf6hvgA9AWEF+V45yoHfJZ3gb7QlQE4V00JUR3EHvXdWOOIZ46u3+Ubk/0D5rQDQgB69L9345DPB/L8NpSwmAqBSVUWILWxj+Oil0CMN1Ju7s+9fkTyQ52iD22b6tglkP/pZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411886; c=relaxed/simple;
	bh=+oM6+9UIACZUma0GQgWF/mFPrJy2NK4/2t52LBZvamo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gINk92Z9lrUXyf7JaM5eZM9fx1NOhfrwGvTWAPVMacmz5urOctv4PHsKlpXMhRj/Q7l6ejadBtQfArK/HWJtPkOjCbPE05WbQg7b+lUHo8JC2XYri733uJDDOkTAAgT+Fq8uDM+FI/RFRgPqY8/0ej6E8Ei/wLjTHv4xv7EBj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJDkVh0Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/AEv3afU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJDkVh0Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/AEv3afU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 319863399C;
	Mon, 29 Apr 2024 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714411883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3qI1nNuL+68bSU78vKuBLG1tC5Fs1Yh/Xask/ydGgg=;
	b=IJDkVh0YnDofh42x4skEwtek0LwcSYyYUfaVS28ppZR/4/M0SHh3Loe8Gg15e0qbsxQXrZ
	BksAatfFjdjE6gAKTeKtaxjlvTTfMPTcshKjl6kRe8gLRbt5lIVfZY4XAHevqpW5qPagPw
	G79Y4JKypOdgU28fAmChD/fFTtN7dEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714411883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3qI1nNuL+68bSU78vKuBLG1tC5Fs1Yh/Xask/ydGgg=;
	b=/AEv3afUaW8au5YklKjRZndgMcVdoRpgpg5GvQPZmRWpl6CVlJW9uGJI8TU6H4Dt4sMbzd
	11A9vVpnadOxNMDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714411883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3qI1nNuL+68bSU78vKuBLG1tC5Fs1Yh/Xask/ydGgg=;
	b=IJDkVh0YnDofh42x4skEwtek0LwcSYyYUfaVS28ppZR/4/M0SHh3Loe8Gg15e0qbsxQXrZ
	BksAatfFjdjE6gAKTeKtaxjlvTTfMPTcshKjl6kRe8gLRbt5lIVfZY4XAHevqpW5qPagPw
	G79Y4JKypOdgU28fAmChD/fFTtN7dEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714411883;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y3qI1nNuL+68bSU78vKuBLG1tC5Fs1Yh/Xask/ydGgg=;
	b=/AEv3afUaW8au5YklKjRZndgMcVdoRpgpg5GvQPZmRWpl6CVlJW9uGJI8TU6H4Dt4sMbzd
	11A9vVpnadOxNMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE8B138A7;
	Mon, 29 Apr 2024 17:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nqQoB2vZL2avRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 17:31:23 +0000
Date: Mon, 29 Apr 2024 19:24:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix documentation build due to phony
 contents.rst
Message-ID: <20240429172405.GI2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8018c8dd90b26bcf9bdf1d76d731022b85147be1.1714086020.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8018c8dd90b26bcf9bdf1d76d731022b85147be1.1714086020.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Apr 26, 2024 at 08:30:22AM +0930, Qu Wenruo wrote:
> [BUG]
> Since commit 8049446bb0ba ("btrfs-progs: docs: placeholder for
> contents.rst file on older sphinx version"), on systems with much newer
> sphinx-build, "make" would not work for Documentation directory:
> 
>  $ make clean-all && ./autogen.sh && ./configure --prefix=/usr/ && make -j12
>  $ ls -alh Documentation/_build
>  ls: cannot access 'Documentation/_build': No such file or directory
> 
> The sphinx-build has a much newer version:
> 
>  $ sphinx-build --version
>  sphinx-build 7.2.6
> 
> [CAUSE]
> On systems which doesn't need the workaround, the phony target of
> contents.rst seems to cause a dependency loop:
> 
>  GNU Make 4.4.1
>  Built for x86_64-pc-linux-gnu
>  Copyright (C) 1988-2023 Free Software Foundation, Inc.
>  License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
>  This is free software: you are free to change and redistribute it.
>  There is NO WARRANTY, to the extent permitted by law.
>  Reading makefiles...
>  Reading makefile 'Makefile'...
>  Updating makefiles....
>   Considering target file 'Makefile'.
>    Looking for an implicit rule for 'Makefile'.
>     Trying pattern rule '%:' with stem 'Makefile'.
>    Found implicit rule '%:' for 'Makefile'.
>   Finished prerequisites of target file 'Makefile'.
>   No need to remake target 'Makefile'.
>  Updating goal targets....
>  Considering target file 'contents.rst'.
>   File 'contents.rst' does not exist.
>  Finished prerequisites of target file 'contents.rst'.
>  Must remake target 'contents.rst'.
>  Makefile:35: update target 'contents.rst' due to: target is .PHONY
>  if [ "$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
>  	touch contents.rst; \
>  fi
>  Putting child 0x64ee81960130 (contents.rst) PID 66833 on the chain.
>  Live child 0x64ee81960130 (contents.rst) PID 66833
>  Reaping winning child 0x64ee81960130 PID 66833
>  Removing child 0x64ee81960130 PID 66833 from chain.
>  Successfully remade target file 'contents.rst'.
> 
> All the default make doing is just try to generate contents.rst, but
> since we have much newer version, we won't generate the file at all.
> 
> [FIX]
> Instead of a phony target, just move the contents.rst generation into
> man page target so that we won't cause loop target on contents.rst.
> 
> Fixes: 8049446bb0ba ("btrfs-progs: docs: placeholder for contents.rst file on older sphinx version")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

