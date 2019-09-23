Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E82BBB29
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfIWSVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 14:21:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35778 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfIWSVI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 14:21:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so18344767qtq.2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59S708iwkWm53QaX/yjiVGxCAqs27EGuWcdJbUCBbTs=;
        b=PBQ/LCzMH7fWq3fnFpB3KUjEZpY8RZ/BxKzCt2DB5aW3u41LBce9fnIQ5Wp5F5I5YS
         jZBTxmwRn1Qeooihib6YFznnaYpaJt72ljQmgr+7ggmkK24qUoqGXVxjMVUjIsa4xho4
         4+5k/znNGiaBONhtBL4ZWlXb/pxVK9u7n3Apzus1L/kSbO4X1BsInS/BwLu/HPy2MW/A
         p3YBtXHT3YqibX5gpdUqCOKmRDVr46TUGqbUFMf1x8DG11pm+RVAfFcE9BsHJhf2Gzxr
         B33sX3QtNrzhPWLKmc81mLzCLMDIHhgkJYT9gIvNVnY0oqReixoKcRfn1pqz3UkpqrWY
         nDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59S708iwkWm53QaX/yjiVGxCAqs27EGuWcdJbUCBbTs=;
        b=eUpV7pShBBOwMVCFx2i8KKHIYY8f0/u4ciDs9uslUKmQLUVTfTvPfJPe6snY6nJEEF
         v0fv/xCn76AnqS9EUwMQt50QMg5XAGT/ECOduSOzhc0tvVHL48qnJEsNWzUUQHefxHMY
         JcNWeqVMQk9zO26E6VE1/S/5fa9D6VID+OPUl8GJohgW+xc2Weaf3u5yV1Yu9d1RnBYF
         oMoDfLe09Nn7h5uOGQ0H6d2M//4M2nT2HZijadpFD4WNxC5Jw87W8w+qHrVr26Yg2PdR
         E297+P/ObYYSs+oe4N2vwXgBjRkk3Zzpa2vMlmIgh8IxuS4a5WJY70/OWVaa7Pa3d6WE
         QY1A==
X-Gm-Message-State: APjAAAXPiaLsNQBqWFJeazx8jGDM56emcMwfKA/RFYgJ2ToDadKFK3+j
        9ggleHetanVeCN4Zu7aVwzoHgg==
X-Google-Smtp-Source: APXvYqzG+S+NfWJvLez4Sa/goVeiArD6WgrD+n1/butVNPiVrfC/UYo+d4ZMnCSPeC2QY9kKWDdd5Q==
X-Received: by 2002:a0c:ef8b:: with SMTP id w11mr528688qvr.77.1569262866269;
        Mon, 23 Sep 2019 11:21:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s23sm6729961qte.72.2019.09.23.11.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:21:05 -0700 (PDT)
Date:   Mon, 23 Sep 2019 14:21:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/9][V3] btrfs: break up extent_io.c a little bit
Message-ID: <20190923182103.kokip2qevnaqzov4@MacBook-Pro-91.local>
References: <20190923140525.14246-1-josef@toxicpanda.com>
 <20190923170101.GM2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923170101.GM2751@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 07:01:01PM +0200, David Sterba wrote:
> On Mon, Sep 23, 2019 at 10:05:16AM -0400, Josef Bacik wrote:
> > v1->v2:
> > - renamed find_delalloc_range to btrfs_find_delalloc_range for now.
> > 
> > -- Original email --
> > 
> > Currently extent_io.c includes all of the extent-io-tree code, the extent buffer
> > code, the code to do IO on extent buffers and data extents, as well as a bunch
> > of other random stuff.  The random stuff just needs to be cleaned up, and is
> > probably too invasive for this point in the development cycle.  Instead I simply
> > tackled moving the big obvious things out into their own files.  I will follow
> > up with cleanups for the rest of the stuff, but those can probably wait until
> > the next cycle as they are going to be slightly more risky.  As usual I didn't
> > try to change anything, I simply moved code around.  Any time I needed to make
> > actual changes to functions I made a separate patch for that work, so for
> > example breaking up the init/exit functions for extent-io-tree.  Everything else
> > is purely cut and paste into new files.  The diffstat is as follows
> > 
> >  fs/btrfs/Makefile         |    3 +-
> >  fs/btrfs/ctree.h          |    3 +-
> >  fs/btrfs/disk-io.h        |    2 +
> >  fs/btrfs/extent-buffer.c  | 1266 ++++++++
> >  fs/btrfs/extent-buffer.h  |  152 +
> >  fs/btrfs/extent-io-tree.c | 1955 ++++++++++++
> >  fs/btrfs/extent-io-tree.h |  248 ++
> >  fs/btrfs/extent_io.c      | 7555 +++++++++++++--------------------------------
> >  fs/btrfs/extent_io.h      |  372 +--
> >  fs/btrfs/super.c          |   16 +-
> >  10 files changed, 5843 insertions(+), 5729 deletions(-)
> 
> I got some strange merge conflicts, it turns out patch 6/9 did not make
> it to the mailinglist (nor patchwork where I could pick it eventually).
> For that it's useful to have the list of commits too along with the
> diffstat, ie. what format-patch generates.

Huh weird.  I see you merged up through patch 5, I'll rebase and resend and
maybe this time the ML will take it.

How about I start sending pull requests through github for everything in
addition to sending stuff to the mailinglist, that way it's easier to track the
bigger things?  Thanks,

Josef
