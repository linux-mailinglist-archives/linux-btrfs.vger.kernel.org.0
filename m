Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1C41458B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 11:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhIVJwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 05:52:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58634 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbhIVJw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 05:52:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1C2D1FD2F;
        Wed, 22 Sep 2021 09:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632304256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDiH5IQHlVo/CgW54KF4HjpogMQuZkqyiJmcx0klzuA=;
        b=t1kELk//ZdByfA/HVcYMOuDddJeQBhxA8rb/b2Ax0nsnWrXFc/9LzUB1iG+q4AzGwcaOTU
        asBvzdxXGhtWVpkFik6Hm4GeTLxTkTEOKPkyM227P+Oy8/plY0zJOrdIP/GKGuDO4k62ZD
        4yOsfp7x45hknVkITsXXyilFmhuQgeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632304256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDiH5IQHlVo/CgW54KF4HjpogMQuZkqyiJmcx0klzuA=;
        b=mlruwihryAbYpKEfzYCIrCQkfJPbunLLo1xd4HRc6yDZfwQv2QnAKICLmRGgn6DoArvN2S
        mKIn+gRhW+otwYAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C9C5CA3B90;
        Wed, 22 Sep 2021 09:50:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D947DA72B; Wed, 22 Sep 2021 11:50:44 +0200 (CEST)
Date:   Wed, 22 Sep 2021 11:50:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Garry T. Williams" <gtwilliams@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.14.1
Message-ID: <20210922095044.GS9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Garry T. Williams" <gtwilliams@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210920162224.27927-1-dsterba@suse.com>
 <4680483.31r3eYUQgx@tfr>
 <e4fcca2f-6515-83ac-e4ba-39e2f0cdf423@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4fcca2f-6515-83ac-e4ba-39e2f0cdf423@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 22, 2021 at 09:26:50AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/22 09:10, Garry T. Williams wrote:
> > On Monday, September 20, 2021 12:22:24 PM EDT David Sterba wrote:
> >> Hi,
> >>
> >> btrfs-progs version 5.14.1 have been released. This is a bugfix release.
> >
> > FYI,
> >
> >      === START TEST /home/garry/src/btrfs-progs/tests/fsck-tests/013-extent-tree-rebuild
> >      $TEST_DEV not given, using /home/garry/src/btrfs-progs/tests/test.img as fallback
> >      ====== RUN CHECK root_helper /home/garry/src/btrfs-progs/mkfs.btrfs -f /home/garry/src/btrfs-progs/tests/test.img
> >      ERROR: /home/garry/src/btrfs-progs/tests/test.img is mounted
> 
> This means your previous run has hit some errors and the test image is
> not unmounted.

The test suite is designed so that it leaves the last state where it
failed to allow analysis. After failed tests most failures can be fixed
by 'make test-clean', manual check can be done by 'losetup' and 'mount'
looking for the paths from the git repository.
