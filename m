Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9C218E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfEQNLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 09:11:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbfEQNLs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 09:11:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5848AAD0A;
        Fri, 17 May 2019 13:11:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 958A3DA8A7; Fri, 17 May 2019 15:12:46 +0200 (CEST)
Date:   Fri, 17 May 2019 15:12:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     dsterba@suse.cz, Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs-progs: check: run delayed refs after writing
 out dirty block groups
Message-ID: <20190517131246.GB3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190402180956.28893-1-jeffm@suse.com>
 <CAL3q7H7O=ZqJdQUXYZjJRfZF04Or7kLgEVnRUGE97YRsV=3pMg@mail.gmail.com>
 <068957f9-c4cf-688d-3db7-7f519c21e4ea@suse.com>
 <20190515141605.GQ3138@twin.jikos.cz>
 <CAL3q7H45c8H91vbz=9yPmtPE95Ret1XLNW3kNT5XGs6L2-GAAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H45c8H91vbz=9yPmtPE95Ret1XLNW3kNT5XGs6L2-GAAw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 15, 2019 at 03:45:13PM +0100, Filipe Manana wrote:
> > > > And running delayed refs can dirty more block groups as well.
> > > > At this point shouldn't we loop running delayed refs until no more
> > > > dirty block groups exist? Just like in the kernel.
> > >
> > > Right.  This is another argument for code sharing between the kernel and
> > > userspace.
> >
> > Sharing code in this function would be really hard, I've implemented the
> > loop in commit in progs.
> 
> Shouldn't the new patch version be sent to the list for review?
> It doesn't seem to be a trivial change on first through.

Ok, I've removed the patches from devel and will send them once the
release is done.
