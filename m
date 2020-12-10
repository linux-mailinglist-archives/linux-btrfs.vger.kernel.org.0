Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44282D5964
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 12:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgLJLkG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 06:40:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:54962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgLJLkB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 06:40:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5F06AEA6;
        Thu, 10 Dec 2020 11:39:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8682DA7D9; Thu, 10 Dec 2020 12:27:42 +0100 (CET)
Date:   Thu, 10 Dec 2020 12:27:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: btrfs-progs license
Message-ID: <20201210112742.GC6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
 <X8/pUT3B1+uluATv@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8/pUT3B1+uluATv@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 08, 2020 at 01:00:01PM -0800, Omar Sandoval wrote:
> On Tue, Dec 08, 2020 at 10:49:10AM +0100, Stefano Babic wrote:
> > Hi,
> > 
> > I hope I am not OT. I ask about license for btrfs-progs and related
> > libraries. I would like to use libbtrfsutils in a FOSS project, but this
> > is licensed under GPLv3 (even not LGPL) and it forbids to use it in
> > projects where secure boot is used.
> 
> libbtrfsutil is LGPLv3, where did you get the idea that it is GPLv3?
> 
> > Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) and
> > also libbtrfs. But I read also that libbtrfs is thought to be dropped
> > from the project. And checking btrfs, this is linked against
> > libbtrfsutils, making the whole project GPLv3 (and again, not suitable
> > for many industrial applications in embedded systems).
> > 
> > Does anybody explain me the conflict in license and if there is a path
> > for a GPLv2 compliant library ?
> 
> No objections from me to make it LGPLv2 instead, I suppose. Dave,
> thoughts?

I've replied in https://github.com/kdave/btrfs-progs/issues/323, the
initial question regarding GPL v3 does not seem to be relevatnt as
there's no such code.

I'd like to understand what's the problem with LGPLv3 before we'd
consider switching to LGPLv2, which I'd rather not do.
