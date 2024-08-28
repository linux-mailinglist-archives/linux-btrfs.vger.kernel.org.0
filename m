Return-Path: <linux-btrfs+bounces-7612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC499626C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 14:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD742824FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42B1175D35;
	Wed, 28 Aug 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s1GO/Wvx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNQxjL9M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YJGdl3/b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/p/EDN8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0516BE1D;
	Wed, 28 Aug 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847538; cv=none; b=at+LOKrCYmh84ABfaVim7O1bB4pGv9yZUaZnU/3n/sy03/g7LZv2XwHiPku9UIw+sgd/TpzMIRVQwmAT3KkqXwQyZkRyhCZAgMbAOkjBAxtxsqZGC4dCbtfm/hPXqCPN3FdSGuSx+HWqlvSxAMYhf4XSQaLgwfoli9jSNyAMrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847538; c=relaxed/simple;
	bh=CdvuMVkz3+JPxLDhn+mmU2Dr79h9hqzjeE8La1PVTqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MogMOQh+XwPzG01ov26khyKXa+0B7y1No7o7EDAP/TRePUKkZpt37oyBCTWvwBhpbTA/aAWVeT1proOhzHJWy50wgeuAPRXFKUJ8cWoyrRLAbHNd8GKJ8SY2svZM5HH3eSlqpRAHqQ7W5WKzJ7iDlVt3TJvNq6O31/dRtOSxcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s1GO/Wvx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNQxjL9M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YJGdl3/b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/p/EDN8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C81521BA0;
	Wed, 28 Aug 2024 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724847534;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiG2xGsceWbTsSmXsroUKGZCUhlmUShwpEVG0Zov9M0=;
	b=s1GO/WvxZep1p6mbhEQvGGlUw92OXmR0nCIhL4WRwQXY1iA6kAyUKqTSWp+xPNxItBILkS
	2A51ruNiBGpMOvq5LzXhRu/06CTsbOInVI2wNGxakOXnLjZlNqhOIPrBWKzaoUX1INkgth
	REwkuD/mcsf3GSmWjghBu84TATGfyMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724847534;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiG2xGsceWbTsSmXsroUKGZCUhlmUShwpEVG0Zov9M0=;
	b=bNQxjL9MidBimQZWSFwSIFLkicgp3cI/ufwmeMVVCk0JAdVHDiFtJX0xn6XWBJHWCz+WOa
	+WsLejhJ4oqEQIDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724847533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiG2xGsceWbTsSmXsroUKGZCUhlmUShwpEVG0Zov9M0=;
	b=YJGdl3/bRaFngWEXixRcJmRLLoDD5GOMQAaZEtowW2mOo82SHjQcW82DkekUzOaLeh7fzE
	v2LMw3DC/t6ThDd8WXYXMZugoxtq8/52NDG6A5q4vCEoGcbtZ8FbPHKTWPAOWwGbNjyfEC
	nBbpMHK+Ohm/b+cOVSEcbq9JTNX6Re4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724847533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiG2xGsceWbTsSmXsroUKGZCUhlmUShwpEVG0Zov9M0=;
	b=n/p/EDN8WKDfLmDfneCDICUFNmRxeUTmAQusXnWeHQBQFHT7Jor2yTIFVJIH5kDQ72O1SW
	QxaC3ejKDuq4vQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13DF11398F;
	Wed, 28 Aug 2024 12:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SwSZBK0Vz2b6DwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 12:18:53 +0000
Date: Wed, 28 Aug 2024 14:18:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc6
Message-ID: <20240828121836.GG25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724844084.git.dsterba@suse.com>
 <CAL3q7H5L9ebGLyPkVFOtG7sEfAj7f17e6uzH2g7s5MUc59FAsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5L9ebGLyPkVFOtG7sEfAj7f17e6uzH2g7s5MUc59FAsQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Aug 28, 2024 at 12:50:22PM +0100, Filipe Manana wrote:
> On Wed, Aug 28, 2024 at 12:23 PM David Sterba <dsterba@suse.com> wrote:
> >
> > Hi,
> >
> > a few more misc fixes. Please pull, thanks.
> >
> > - fix use-after-free when submitting bios for read, after an error and
> >   partially submitted bio the original one is freed while it can be still be
> >   accessed again
> >
> > - fix fstests case btrfs/301, with enabled quotas wait for delayed iputs when
> >   flushing delalloc
> >
> > - fix regression in periodic block group reclaim, an unitialized value can be
> >   returned if there are no block groups to reclaim
> 
> There's some confusion here.
> 
> First, it's not a regression because the uninitialized return value
> has been there since periodic block group reclaim was introduced.

I used the word regression because it's been added in the same
development cycle, i.e. the dynamic reclaim, but yeah maybe it's too
strong.

> Secondly, and more important, is that it doesn't cause any problem
> because the only caller of the function ignores its return value.
> 
> So this is effectively more of a cleanup than anything else, and could
> have waited for the next merge window.
> I see you also added a Fixes tag to the changelog, which will trigger
> stable backports.

For completeness of the periodic reclaim code I'd rather add it now,
before 6.11 is released. The Fixes tag is for reference where it was
added,

> Unless there are compiler versions or static analysis tools that
> complain with warnings, it will be just overhead to backport to stable
> releases.

No backports should be triggered by that because it hasn't been
released

$ git describe --contains e4ca3932ae90
v6.11-rc1~157^2~32

