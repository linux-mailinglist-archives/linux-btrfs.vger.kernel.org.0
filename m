Return-Path: <linux-btrfs+bounces-14239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E22AC3C86
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD591758C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE211E834B;
	Mon, 26 May 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J53B8ger";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5j9t891";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J53B8ger";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5j9t891"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2419DF8B
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251275; cv=none; b=SfqbFLIKfWxNAitgn0wrzx85sm59z3wY2GRZY/or60KG1kb+Basm0LIBFqWyFpOKdH6O2dMjgeOioMJsJHKp4pCzjA36Wkd34jNMfOTxxtsm0rqTEgPMqO2/5hLxsDg94uXD7Bk/Sh4PxGFZfySMCl7gyXQWIk2uCYxIsi4ukjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251275; c=relaxed/simple;
	bh=kxTKQdKdM42+UfGMPBhpdpXhz8MkAmx6L5X/Sj/ueSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fma4QK4+rh6tLwvTLdtHtnQ/C8nO70rGJkJGsM3KOeLfmXywGckPAHAE00zblWhYmfv+/30yWl7RNJhi9/vT/z1txbniNwodQnJAFFprVVruO8B1LWWASNYi7gxaHMtP89LtrBMVNWaCCODzbjqJSE1zcdLw/0uDVvvvitkuu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J53B8ger; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n5j9t891; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J53B8ger; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n5j9t891; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C594E2124E;
	Mon, 26 May 2025 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748251265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAW4zMyN2+KIVr/nZg4iOZnS8jNIWSpk/JdTnRAd6VE=;
	b=J53B8gerVG+aClpVab0wUxie0C7dHBpBTrfHJpkx/HJ2uTzYaV42BaryTnGx4imV+1EiXa
	plrfzS+VJ3mVbWFhl5loPMK0KUymXrYn7ozsypXnVMzaleHLHH4gvyIbrX8Temffxyvp4K
	MD84XnzZrzD6d3Uh8STq9AvRbgP0aSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748251265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAW4zMyN2+KIVr/nZg4iOZnS8jNIWSpk/JdTnRAd6VE=;
	b=n5j9t891DRLQk/SFQNhP2/cjujA6kxwtHEUPWjEtEob4a/URz61bFvffWPCG7ZVivHngyr
	ZNskCYVGWR2oF0AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748251265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAW4zMyN2+KIVr/nZg4iOZnS8jNIWSpk/JdTnRAd6VE=;
	b=J53B8gerVG+aClpVab0wUxie0C7dHBpBTrfHJpkx/HJ2uTzYaV42BaryTnGx4imV+1EiXa
	plrfzS+VJ3mVbWFhl5loPMK0KUymXrYn7ozsypXnVMzaleHLHH4gvyIbrX8Temffxyvp4K
	MD84XnzZrzD6d3Uh8STq9AvRbgP0aSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748251265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAW4zMyN2+KIVr/nZg4iOZnS8jNIWSpk/JdTnRAd6VE=;
	b=n5j9t891DRLQk/SFQNhP2/cjujA6kxwtHEUPWjEtEob4a/URz61bFvffWPCG7ZVivHngyr
	ZNskCYVGWR2oF0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E0A1397F;
	Mon, 26 May 2025 09:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XNzkI4EyNGgKXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 26 May 2025 09:21:05 +0000
Date: Mon, 26 May 2025 11:21:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>, Qu Wenruo <wqu@suse.com>,
	josef Bacik <josjosef@toxicpanda.com>, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
Message-ID: <20250526092100.GB4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250521032713.7552-1-sawara04.o@gmail.com>
 <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com>
 <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
 <af00227c-c301-4311-b570-47f4d404c499@suse.com>
 <CAKNDObAwjpNv1rJJ1LWis2Eh18QBi8O4Kfje45YZvsqiJa78sA@mail.gmail.com>
 <CAKNDObB25gQHWQEHQCQ1J6SOCY3KPH9VEpDdPjicvEveF8s+vA@mail.gmail.com>
 <3ba600aa-5a79-4fe1-9b24-a45c0a58965e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ba600aa-5a79-4fe1-9b24-a45c0a58965e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.50
X-Spamd-Result: default: False [0.50 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,toxicpanda.com,fb.com,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Mon, May 26, 2025 at 02:24:54PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/26 03:15, Kyoji Ogasawara 写道:
> > Sorry for sending piecemeal updates.
> > 
> > I've realized that if the log goes into btrfs_emit_options(), it'll
> > only show up during remount operations.
> > 
> > So, I was thinking of adding the following code to open_ctree(), right
> > after the btrfs_check_options() call.
> > 
> >         if (btrfs_test_opt(fs_info, NOBARRIER))
> >                 btrfs_info(fs_info, "turning off barriers, use with care");
> > 
> > What do you think of this approach?
> > 
> > We could also set the log level to warning if that's preferred.
> 
> It turns out to be a more deeply involved bug.
> 
> The root cause is, we no longer use btrfs_parse_options() to output the 
> mount option changes.
> 
> Before the fsconfig change, we have btrfs_parse_options() function, 
> which will output an info line for each triggered option.
> That function is utilized by both mount (open_ctree()) and remount 
> (btrfs_remount())
> 
> But with the fsconfig migration, we use parse_param() helper, which now 
> only handles the feature setting, no more messaging.
> And btrfs_emit_options() to emit the message line.
> 
> The btrfs_emit_options() can handle empty @old context, thus it is 
> designed to handle both mount and remount.
> 
> Unfortunately at mount time we do not call btrfs_emit_options(), this 
> means we lost all the previous mount messages.
> 
> I'm not sure if this is intended or not, the fact we didn't notice the 
> change until now means, most of the info lines are not that useful and 
> no one is really noticing them.
> 
> So @josef, is it intended to skip all the mount option related info 
> messages? Or it's just a bug?

I don't think this was intentional and it looks like a usability
regression. If it's just changed timing when the options are printed
during mount it may not be serious.

Comparing old and new logs from my VMs, I see the difference now. It
may not be easy to spot as it's the compression messages and seeing at
least some mount messages I don't know what could be missing there.

We should probably reinstate the messages, possibly also removing some
that are not that interesting like 'has skinny extents' or 'checking
UUID tree'.

