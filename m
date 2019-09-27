Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20F0C08CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfI0Pm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 11:42:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727207AbfI0Pm2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 11:42:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F685AC31;
        Fri, 27 Sep 2019 15:42:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86D49DA897; Fri, 27 Sep 2019 17:42:45 +0200 (CEST)
Date:   Fri, 27 Sep 2019 17:42:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/4] The remaining extent_io.c split code
Message-ID: <20190927154244.GX2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190924203252.30505-1-josef@toxicpanda.com>
 <20190925134747.GG2751@twin.jikos.cz>
 <20190925135302.wyv5foxhy5tku6li@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925135302.wyv5foxhy5tku6li@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 09:53:04AM -0400, Josef Bacik wrote:
> On Wed, Sep 25, 2019 at 03:47:47PM +0200, David Sterba wrote:
> > On Tue, Sep 24, 2019 at 04:32:48PM -0400, Josef Bacik wrote:
> > > Hopefully all of it makes it this time, if you want you can pull from
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git \
> > > 	extent-io-rearranging
> > 
> > The size of the exported patch 1/4 is 109066 bytes and the diff itself
> > is incomprehensible to even see what code moves where and what is new.
> > 
> > I'm still thinking if this is a good idea to apply a monster patch, even
> > it's just moving code around. The previous series splitting
> > extent-tree.c were better so I'd rather take that approach again. Some
> > of the functions belong logically together and won't break compilation
> > and would actually make it possible for a human to review.
> 
> extent-tree.c was way different because a bunch of things had to be renamed and
> exported.  Also extent-tree.c got split into many more files, so there was less
> bulk being moved around.  extent_io.c is different because basically everything
> is exported already, so it's really just move definitions, move code.  I
> literally just split vim'ed, cut and paste between the two files.
> 
> Things like this are going to be impossible to review.  It's a one time pain for
> more readability and better decisions down the road.  I did my best to keep the
> logical changes to their own patch, but the fact is we have _a lot_ of code for
> each of these different logical things.  I can turn it into 45 patches moving
> one function at a time, but who's going to go and check each individual patch?

I'm not talking about 45 patches but somethig like 2-4. One of the
patches in extent-tree split has 65K, and I basically redone it (and
several others) by hand due to small changes in the original code. This
counts as a review, even though the patch was large, but with the
difference that I was able to do that in one go per patch. The 100K
scares me from the beginning, thus my question.

If you say that 'this is going to be impossible to review' then, well we
can't merge it in that form. And from past experience, monster patches
are never one time pain and come up as a reminder of low patch
standards. The bad thing is that it's never the patch author who has to
suffer.

The idea for split is to do eg. the following groups:

- extent leak detection functions
- state bit manipulation functions (set_extent_bit etc)
- other io tree functions

I'm looking for an achievable long-term strategy to do those large code
movements and find the balance between writing the patches and reviewing
them.
