Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B933F76C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 16:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhHYOCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 10:02:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36138 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHYOCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 10:02:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D90F21F0B;
        Wed, 25 Aug 2021 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629900087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukqSmFbtmNvPlRcy74O0sh8yzvXPfakQ5vsvpJtxC2g=;
        b=sDi0ttpwxs51lYhbv9GGqYhk8aM6HAaO6Rw/pku2LE9ZkcEtkny5NTbza8jB3FuVhGESBo
        XqPkGgToSgCG7+EGaKr2Uz2yjoThBZBC7mAd0IwLlS64h5Rprsu180akL8P02HglAHXqu3
        6zWXxkBrK3RYBhQnBkGv9vCVG1ZAlhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629900087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukqSmFbtmNvPlRcy74O0sh8yzvXPfakQ5vsvpJtxC2g=;
        b=cU+Uc/YXMTZt09zKGMx5/x5jw8Co9EsppKz5miH+BEY79KP1iMfcd+X33WT6yivg0+hHnO
        5rne65gFKtVX26BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1350EA3B89;
        Wed, 25 Aug 2021 14:01:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97477DA7FB; Wed, 25 Aug 2021 15:58:39 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:58:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/10] btrfs-progs: mkfs fixes and prep work for
 extent tree v2
Message-ID: <20210825135839.GK3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 04:14:45PM -0400, Josef Bacik wrote:
> In order to reduce the amount of pain the reviewers have to endure I'm going to
> be sending any prepatory patches separately from the actual feature work.
> 
> To that end this is the first batch of preparatory patches.  These are to make
> working with mkfs a lot easier for the changes I'm making.  These are all fixes
> or enhancements that can apply currently.  The only thing that is extent tree v2
> specific is the last patch, which adds the incompat flag.
> 
> I've added the patch for the incompat flag because I will have other preparatory
> patches that add helpers that essentially do
> 
> if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> 	/* Do the old thing. */
> 
> and then have patches after that add the extent tree v2 magic.  I think this
> will make it easier to break up the work, but if we're not comfortable reserving
> the bit then I'm fine with dropping that last patch.  It will just mean future
> prep work will have to come along with the feature enablement patches.

Going through the patches I don't think mentioning the extent tree v2
makes sense in case the patch is an independent cleanup or refactors
some code to be a bit more generic.

The actual incompat bit could be reserved but it would be better to keep
it in the future patchset implementing some significant part of the
extent tree v2.

Even with the "if (EXTENT_TREE_V2)" in place it becomes the
implementation and given that I haven't read the whole design doc for
that I'm worried that once I find time for that and would suggest some
changes the reply would be "no I did it this way, it's implemented,
would require too many changes".

Would be good to keep mentioning the v2 tree maybe to the cover letter
so we know what's the motivation but in the changelogs it's confusing as
we don't have any base point for that.
