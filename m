Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DCD4000CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348751AbhICNyT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 09:54:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53802 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348494AbhICNyS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 09:54:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4194D203E3;
        Fri,  3 Sep 2021 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630677198;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yz/vcz3WdQSGQoVQbM+ohJZlpB3SizW3NHyWNO9xIVg=;
        b=oTpcNNMH4lS3hFBUY5NCRl4QZVi9KSMr/TU58YTXP5m7lPMO+6qCoRtPa6mo71x18XKUe/
        5fQVbC8QetYJ5Iw2sCtQm7no/yaPoRj21ymrH+Fusn1ct/kOsPcqzEO1xzcWmH1WHfE0Wh
        LyFBFk2LmKdLWM9pOkO76Haxmu29Mfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630677198;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yz/vcz3WdQSGQoVQbM+ohJZlpB3SizW3NHyWNO9xIVg=;
        b=MH9meY2Lc6WJE7wK/vp+ckgsJfHkHT5Wxx3NO3aUZr+LGI55/WQtFEYS2q9FdGCy8Cf6Ed
        4GJa6fcWsc1GhkCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 11C81A3BBF;
        Fri,  3 Sep 2021 13:53:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FD14DA72B; Fri,  3 Sep 2021 15:53:16 +0200 (CEST)
Date:   Fri, 3 Sep 2021 15:53:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/10] btrfs-progs: mkfs fixes and prep work for
 extent tree v2
Message-ID: <20210903135316.GD3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629749291.git.josef@toxicpanda.com>
 <20210825135839.GK3379@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825135839.GK3379@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 25, 2021 at 03:58:39PM +0200, David Sterba wrote:
> On Mon, Aug 23, 2021 at 04:14:45PM -0400, Josef Bacik wrote:
> > In order to reduce the amount of pain the reviewers have to endure I'm going to
> > be sending any prepatory patches separately from the actual feature work.
> > 
> > To that end this is the first batch of preparatory patches.  These are to make
> > working with mkfs a lot easier for the changes I'm making.  These are all fixes
> > or enhancements that can apply currently.  The only thing that is extent tree v2
> > specific is the last patch, which adds the incompat flag.
> > 
> > I've added the patch for the incompat flag because I will have other preparatory
> > patches that add helpers that essentially do
> > 
> > if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> > 	/* Do the old thing. */
> > 
> > and then have patches after that add the extent tree v2 magic.  I think this
> > will make it easier to break up the work, but if we're not comfortable reserving
> > the bit then I'm fine with dropping that last patch.  It will just mean future
> > prep work will have to come along with the feature enablement patches.
> 
> Going through the patches I don't think mentioning the extent tree v2
> makes sense in case the patch is an independent cleanup or refactors
> some code to be a bit more generic.

I've rephrased some of the changelogs regarding v2.

> The actual incompat bit could be reserved but it would be better to keep
> it in the future patchset implementing some significant part of the
> extent tree v2.
> 
> Even with the "if (EXTENT_TREE_V2)" in place it becomes the
> implementation and given that I haven't read the whole design doc for
> that I'm worried that once I find time for that and would suggest some
> changes the reply would be "no I did it this way, it's implemented,
> would require too many changes".

The design is still flexile enough for the questions I had so we can
proceed.

> Would be good to keep mentioning the v2 tree maybe to the cover letter
> so we know what's the motivation but in the changelogs it's confusing as
> we don't have any base point for that.

So the plan is to merge it as the experimental feature and patches will
arrive, which means referencing v2 extent tree is ok and you can keep
using it.

Patches added to devel.
