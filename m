Return-Path: <linux-btrfs+bounces-319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B07F5414
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 00:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A16281676
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 23:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DD1F5FC;
	Wed, 22 Nov 2023 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J0bOtRrS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dw0+rXVz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B5101
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 15:02:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A845A2198B;
	Wed, 22 Nov 2023 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700694130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhVSvEkO4m+YP9Zywx40nmkliT2rMK6Wm9Vt7VIjc+4=;
	b=J0bOtRrSpDCnWHiMYYtFcV6LMBd7f0t7qsI2tWAWJVj0DIJ2hpyqirqKqI0ys0q5bylVqe
	5oTXHBLDQZ60sbBLGYzfAc9n0VApPI/iTK5iTSq/E5PTMbz9YQxlPWhkGomaEcph+ij/Ob
	cuNZeLdX0AluKJmwawJQwsxafr/0CA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700694130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhVSvEkO4m+YP9Zywx40nmkliT2rMK6Wm9Vt7VIjc+4=;
	b=Dw0+rXVzIDoLMKlk290pnaOdWsrOOVhviyYZRQmRSDZQxhvFB5RjuR2J0rXMFaMWsVHUBa
	UPewq9lexzG9mVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D3AE13467;
	Wed, 22 Nov 2023 23:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CaD3FXKIXmX+SwAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 23:02:10 +0000
Date: Wed, 22 Nov 2023 23:55:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 00/19] btrfs: convert to the new mount API
Message-ID: <20231122225500.GG11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700673401.git.josef@toxicpanda.com>
 <CAEg-Je-oQ4Eh4vyidHWM-X_ppwE=_aV0Ra7EmL59ZKNQoT18SQ@mail.gmail.com>
 <20231122182946.GE11264@twin.jikos.cz>
 <CAEg-Je_A+yuMc4XvM_e+4BKMu0wEDM6WFtKxaEiA2apJyuH2wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_A+yuMc4XvM_e+4BKMu0wEDM6WFtKxaEiA2apJyuH2wQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 22, 2023 at 05:12:02PM -0500, Neal Gompa wrote:
> On Wed, Nov 22, 2023 at 1:37 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Nov 22, 2023 at 12:41:30PM -0500, Neal Gompa wrote:
> > > On Wed, Nov 22, 2023 at 12:18 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > v2->v3:
> > > > - Fixed up the various review comments from Dave and Anand.
> > > > - Added a patch to drop the deprecated mount options we currently have.
> > > >
> > > > v1->v2:
> > > > - Fixed up some nits and paste errors.
> > > > - Fixed build failure with !ZONED.
> > > > - Fixed accidentally dropping BINARY_MOUNTDATA flag.
> > > > - Added Reviewed-by's collected up to this point.
> > > >
> > > > These have run through our CI a few times, they haven't introduced any
> > > > regressions.
> > > >
> > > > --- Original email ---
> > > > Hello,
> > > >
> > > > These patches convert us to use the new mount API.  Christian tried to do this a
> > > > few months ago, but ran afoul of our preference to have a bunch of small
> > > > changes.  I started this series before I knew he had tried to convert us, so
> > > > there's a fair bit that's different, but I did copy his approach for the remount
> > > > bit.  I've linked to the original patch where I took inspiration, Christian let
> > > > me know if you want some other annotation for credit, I wasn't really sure the
> > > > best way to do that.
> > > >
> > > > There are a few preparatory patches in the beginning, and then cleanups at the
> > > > end.  I took each call back one at a time to try and make it as small as
> > > > possible.  The resulting code is less, but the diffstat shows more insertions
> > > > that deletions.  This is because there are some big comment blocks around some
> > > > of the more subtle things that we're doing to hopefully make it more clear.
> > > >
> > > > This is currently running through our CI.  I thought it was fine last week but
> > > > we had a bunch of new failures when I finished up the remount behavior.  However
> > > > today I discovered this was a regression in btrfs-progs, and I'm re-running the
> > > > tests with the fixes.  If anything major breaks in the CI I'll resend with
> > > > fixes, but I'm pretty sure these patches will pass without issue.
> > > >
> > > > I utilized __maybe_unused liberally to make sure everything compiled while
> > > > applied.  The only "big" patch is where I went and removed the old API.  If
> > > > requested I can break that up a bit more, but I didn't think it was necessary.
> > > > I did make sure to keep it in its own patch, so the switch to the new mount API
> > > > path only has things we need to support the new mount API, and then the next
> > > > patch removes the old code.  Thanks,
> > > >
> > > > Josef
> > > >
> > > > Christian Brauner (1):
> > > >   fs: indicate request originates from old mount api
> > > >
> > > > Josef Bacik (18):
> > > >   btrfs: split out the mount option validation code into its own helper
> > > >   btrfs: set default compress type at btrfs_init_fs_info time
> > > >   btrfs: move space cache settings into open_ctree
> > > >   btrfs: do not allow free space tree rebuild on extent tree v2
> > > >   btrfs: split out ro->rw and rw->ro helpers into their own functions
> > > >   btrfs: add a NOSPACECACHE mount option flag
> > > >   btrfs: add fs_parameter definitions
> > > >   btrfs: add parse_param callback for the new mount api
> > > >   btrfs: add fs context handling functions
> > > >   btrfs: add reconfigure callback for fs_context
> > > >   btrfs: add get_tree callback for new mount API
> > > >   btrfs: handle the ro->rw transition for mounting different subovls
> > > >   btrfs: switch to the new mount API
> > > >   btrfs: move the device specific mount options to super.c
> > > >   btrfs: remove old mount API code
> > > >   btrfs: move one shot mount option clearing to super.c
> > > >   btrfs: set clear_cache if we use usebackuproot
> > > >   btrfs: remove code for inode_cache and recovery mount options
> > > >
> > > >  fs/btrfs/disk-io.c |   85 +-
> > > >  fs/btrfs/disk-io.h |    1 -
> > > >  fs/btrfs/fs.h      |   15 +-
> > > >  fs/btrfs/super.c   | 2357 +++++++++++++++++++++++---------------------
> > > >  fs/btrfs/super.h   |    5 +-
> > > >  fs/btrfs/zoned.c   |   16 +-
> > > >  fs/btrfs/zoned.h   |    6 +-
> > > >  fs/namespace.c     |   11 +
> > > >  8 files changed, 1263 insertions(+), 1233 deletions(-)
> > > >
> > > > --
> > > > 2.41.0
> > > >
> > >
> > > Looks like my r-b wasn't picked up for this revision, but looking over
> > > it, things seem to be fine.
> >
> > Honestly Neal, I don't know how I should interpret your Reviewed-by. You
> > don't contribute code or otherwise comment on other patches on the
> > technical level. If you as an involved user want to give feedback that
> > some feature is desired then it's fine to do so but the rev-by tag is
> > not the way to do that.
> >
> > https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> If it helps, I put "Reviewed-by" on patch sets that I have downloaded
> and applied to a local build that I test and read to check to see that
> they make sense.

Download and build is just a build test, you may find build problems
like with missing config options or warnings though which is valuable
but not enough. Reading code if it makes sense means different things to
you and me. I expect knowledge deep enough that if somebody puts a
Reviewed-by there then I can ask questions to get explanations how
things get fixed or improved. Or to CC that person when a bug appears
and then jointly debug it or expect a fix.

> If the patches make sense, build, and work for me, I'll send a
> "Reviewed-by" statement. I figured that would be sufficient for
> "Reviewed-by" statements. If there's something more you're expecting
> for that, then please let me know.

I expect that I can rely on the person's understanding of the code. It
takes time to build the reputation, actually based on real code-level
discussions or sending own patches of a reasonable quality. Otherwise it
devalues the tag meaning.

> It's pretty rare that I'd test code
> without at least looking at it and checking it over, so I don't feel
> "Tested-by" makes sense.

If you test the code then it's for Tested-by, eventually stating which
testsuites were run or in what configuration, which would apply in this
case.

I would be sad to discourage you from contributing, it happens on
different levels, just that I was surprised first and was not the only
one.

