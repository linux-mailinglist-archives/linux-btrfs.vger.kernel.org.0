Return-Path: <linux-btrfs+bounces-6153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DE9243FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 18:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E8E1F263F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB81BD50F;
	Tue,  2 Jul 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqG7rV4M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqAtDolj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D023zcGs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bFAFSTMu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594881BD516
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939165; cv=none; b=F3Egj7DEhx5KfTg/EEM/nMHDuszvwPZYc6AgZV454M8L3yhhas7D6Ne8KlCCXjjOhjQ8CYnRC0rSscvwYwfuOVeR1QGZkkoi2fm0anWPogoMFV/pghw3sNsSHUNBLI1cGulseX4dmvyC+gF1wIzpCmBx7ucNRPS9RzclNKYlYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939165; c=relaxed/simple;
	bh=HQdECKgjwqkBHbcA1pjzfph3QfT3i3BigVAAthQMOFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKN0Z3F0+s+6t44tFXMKCW3VT8IVHcq0rDE0QcwR18mdEhB6BGVjyEqrRgfL5dlaJcF2f1oNPvi55D63Qg+8SmpE05vx4f44S9NdJB/ofp8xCUHvtjW/4+CLN3mpi2sn5yjk3zo4rfBWefoz26d13/1l09q++cSEu2rC85o70n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqG7rV4M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dqAtDolj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D023zcGs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bFAFSTMu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61FA9219AA;
	Tue,  2 Jul 2024 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719939161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsplD4P/6a6pQ3QtV+pfN++AFadG+SD2WKEx7zo9uNQ=;
	b=XqG7rV4MingbE/jQEzORZep8TeL3qjFj2iwgNYQRmwUH48xi6Z/GnSMQw3ghXmWMlUut0M
	OxoTYTT9e2rDRD6HZfkbeU8GEchDibIEyssHBchc5VG8rPtC8FA39Mm4Mi8HA/C07tf/bA
	qfmMt2Q2hFM1QG1i4AbzbDHLnn5Vkeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719939161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsplD4P/6a6pQ3QtV+pfN++AFadG+SD2WKEx7zo9uNQ=;
	b=dqAtDoljveCrk/tQPmZ1YhWeNEohyVLw/mI0o72K15g8pdwcWRblMLlYF0TkSChKkfZUk1
	jhkOQO+q+Xt/1ODQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719939160;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsplD4P/6a6pQ3QtV+pfN++AFadG+SD2WKEx7zo9uNQ=;
	b=D023zcGsDlGnzAbREaKDf+3mu/B8a/UVaoMnhIYKiZQ1qXklDEHS04DRKL32ntpHZXbbGY
	HJU2v48lFQJ3cc9KV3zDqRYfuRX+DGZq9ow0GQzAVaLAAtkr4697jydKoko8d/7U9xTBjU
	RfRvYY/Yy7gb153OBBkmZRGHHi9pfy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719939160;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsplD4P/6a6pQ3QtV+pfN++AFadG+SD2WKEx7zo9uNQ=;
	b=bFAFSTMuV2bx6jzK4iROhbWMVZSjv3RYpjYaJtxQ5JLFI50BsnHHmwNoThDFikjFbuLaMe
	BIOp3fbfQh6DwDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DFE21395F;
	Tue,  2 Jul 2024 16:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DFDuDlgwhGZ6QgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 16:52:40 +0000
Date: Tue, 2 Jul 2024 18:52:39 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3 00/15] btrfs: snapshot delete cleanups
Message-ID: <20240702165239.GL21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715105406.git.josef@toxicpanda.com>
 <20240515181842.GV4449@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515181842.GV4449@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, May 15, 2024 at 08:18:42PM +0200, David Sterba wrote:
> On Tue, May 07, 2024 at 02:12:01PM -0400, Josef Bacik wrote:
> > v2->v3:
> > - Fixed the bug pointed out by Dan https://lore.kernel.org/all/96789032-42fb-41c0-b16c-561ac00ca7c3@moroto.mountain/
> > 
> > v1->v2:
> > - Simply removed the btrfs_check_eb_owner() calls as per Qu's suggestion.
> > - Made the 0 reference count error be more verbose as per Dave's suggestion.
> > 
> > --- Original email ---
> > 
> > Hello,
> > 
> > In light of the recent fix for snapshot delete I looked around at the code to
> > see if it could be cleaned up.  I still feel like this could be reworked to make
> > the two stages clearer, but this series brings a lot of cleanups and
> > re-factoring as well as comments and documentation that hopefully make this code
> > easier for others to work in.  I've broken up the do_walk_down() function into
> > discreet peices that are better documented and describe their use.  I've also
> > taken the opportunity to remove a bunch of BUG_ON()'s in this code.  I've run
> > this through the CI a few times as I made a couple of errors, but it's passing
> > cleanly now.  Thanks,
> > 
> > Josef
> > 
> > Josef Bacik (15):
> >   btrfs: don't do find_extent_buffer in do_walk_down
> >   btrfs: remove all extra btrfs_check_eb_owner() calls
> >   btrfs: use btrfs_read_extent_buffer in do_walk_down
> >   btrfs: push lookup_info into walk_control
> >   btrfs: move the eb uptodate code into it's own helper
> >   btrfs: remove need_account in do_walk_down
> >   btrfs: unify logic to decide if we need to walk down into a node
> >   btrfs: extract the reference dropping code into it's own helper
> >   btrfs: don't BUG_ON ENOMEM in walk_down_proc
> >   btrfs: handle errors from ref mods during UPDATE_BACKREF
> >   btrfs: replace BUG_ON with ASSERT in walk_down_proc
> >   btrfs: clean up our handling of refs == 0 in snapshot delete
> >   btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc
> >   btrfs: handle errors from btrfs_dec_ref properly
> >   btrfs: add documentation around snapshot delete
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
> A lot of good things there, fewer BUG_ONs, comments and refactoring,
> thanks. I had it in my misc-next for some time, no related problems
> reported.

For the record, I merged this to for-next a few weeks ago.

