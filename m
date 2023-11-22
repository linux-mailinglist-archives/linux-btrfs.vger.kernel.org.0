Return-Path: <linux-btrfs+bounces-313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6847F4FB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 19:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78221C20AA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDE5C083;
	Wed, 22 Nov 2023 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1ZxasUu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MHH8/9nO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330CB10D3
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 10:36:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 839AE1F8D7;
	Wed, 22 Nov 2023 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700678216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apiW4b2n2cm/5u0gEo466e9z55ojwgQbtKZalEzWCjk=;
	b=v1ZxasUuuymUCLEd794ijcaid08IevQPmwdfr5Bpoq1Ag2a/E+rToVx6BTAGqLZuo01aQm
	+QGSRcnWSowc9TQ6bXOx3D0fMcTaOQqsSxfVgrrPMqUgo2bWQT9xiTAn5KXIOO/0sQA9vT
	uWZzjynhZnRxT0QqBDDGRf28iqYVQhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700678216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apiW4b2n2cm/5u0gEo466e9z55ojwgQbtKZalEzWCjk=;
	b=MHH8/9nOHoTGxf0DJDtYeg4Y8u4yPwSJ2dueH4LQuSAef087Kd+fv2Ak2bNpK39XEqiZ4k
	Ucb7CvDl2cVrVsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A8F313461;
	Wed, 22 Nov 2023 18:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aiJ/EUhKXmUydAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 18:36:56 +0000
Date: Wed, 22 Nov 2023 19:29:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3 00/19] btrfs: convert to the new mount API
Message-ID: <20231122182946.GE11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700673401.git.josef@toxicpanda.com>
 <CAEg-Je-oQ4Eh4vyidHWM-X_ppwE=_aV0Ra7EmL59ZKNQoT18SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je-oQ4Eh4vyidHWM-X_ppwE=_aV0Ra7EmL59ZKNQoT18SQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 22, 2023 at 12:41:30PM -0500, Neal Gompa wrote:
> On Wed, Nov 22, 2023 at 12:18 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > v2->v3:
> > - Fixed up the various review comments from Dave and Anand.
> > - Added a patch to drop the deprecated mount options we currently have.
> >
> > v1->v2:
> > - Fixed up some nits and paste errors.
> > - Fixed build failure with !ZONED.
> > - Fixed accidentally dropping BINARY_MOUNTDATA flag.
> > - Added Reviewed-by's collected up to this point.
> >
> > These have run through our CI a few times, they haven't introduced any
> > regressions.
> >
> > --- Original email ---
> > Hello,
> >
> > These patches convert us to use the new mount API.  Christian tried to do this a
> > few months ago, but ran afoul of our preference to have a bunch of small
> > changes.  I started this series before I knew he had tried to convert us, so
> > there's a fair bit that's different, but I did copy his approach for the remount
> > bit.  I've linked to the original patch where I took inspiration, Christian let
> > me know if you want some other annotation for credit, I wasn't really sure the
> > best way to do that.
> >
> > There are a few preparatory patches in the beginning, and then cleanups at the
> > end.  I took each call back one at a time to try and make it as small as
> > possible.  The resulting code is less, but the diffstat shows more insertions
> > that deletions.  This is because there are some big comment blocks around some
> > of the more subtle things that we're doing to hopefully make it more clear.
> >
> > This is currently running through our CI.  I thought it was fine last week but
> > we had a bunch of new failures when I finished up the remount behavior.  However
> > today I discovered this was a regression in btrfs-progs, and I'm re-running the
> > tests with the fixes.  If anything major breaks in the CI I'll resend with
> > fixes, but I'm pretty sure these patches will pass without issue.
> >
> > I utilized __maybe_unused liberally to make sure everything compiled while
> > applied.  The only "big" patch is where I went and removed the old API.  If
> > requested I can break that up a bit more, but I didn't think it was necessary.
> > I did make sure to keep it in its own patch, so the switch to the new mount API
> > path only has things we need to support the new mount API, and then the next
> > patch removes the old code.  Thanks,
> >
> > Josef
> >
> > Christian Brauner (1):
> >   fs: indicate request originates from old mount api
> >
> > Josef Bacik (18):
> >   btrfs: split out the mount option validation code into its own helper
> >   btrfs: set default compress type at btrfs_init_fs_info time
> >   btrfs: move space cache settings into open_ctree
> >   btrfs: do not allow free space tree rebuild on extent tree v2
> >   btrfs: split out ro->rw and rw->ro helpers into their own functions
> >   btrfs: add a NOSPACECACHE mount option flag
> >   btrfs: add fs_parameter definitions
> >   btrfs: add parse_param callback for the new mount api
> >   btrfs: add fs context handling functions
> >   btrfs: add reconfigure callback for fs_context
> >   btrfs: add get_tree callback for new mount API
> >   btrfs: handle the ro->rw transition for mounting different subovls
> >   btrfs: switch to the new mount API
> >   btrfs: move the device specific mount options to super.c
> >   btrfs: remove old mount API code
> >   btrfs: move one shot mount option clearing to super.c
> >   btrfs: set clear_cache if we use usebackuproot
> >   btrfs: remove code for inode_cache and recovery mount options
> >
> >  fs/btrfs/disk-io.c |   85 +-
> >  fs/btrfs/disk-io.h |    1 -
> >  fs/btrfs/fs.h      |   15 +-
> >  fs/btrfs/super.c   | 2357 +++++++++++++++++++++++---------------------
> >  fs/btrfs/super.h   |    5 +-
> >  fs/btrfs/zoned.c   |   16 +-
> >  fs/btrfs/zoned.h   |    6 +-
> >  fs/namespace.c     |   11 +
> >  8 files changed, 1263 insertions(+), 1233 deletions(-)
> >
> > --
> > 2.41.0
> >
> 
> Looks like my r-b wasn't picked up for this revision, but looking over
> it, things seem to be fine.

Honestly Neal, I don't know how I should interpret your Reviewed-by. You
don't contribute code or otherwise comment on other patches on the
technical level. If you as an involved user want to give feedback that
some feature is desired then it's fine to do so but the rev-by tag is
not the way to do that.

https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

