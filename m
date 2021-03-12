Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD550338C21
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhCLMAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 07:00:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:41952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbhCLL76 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 06:59:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43031B02F;
        Fri, 12 Mar 2021 11:59:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DC20DA81D; Fri, 12 Mar 2021 12:57:57 +0100 (CET)
Date:   Fri, 12 Mar 2021 12:57:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Convert kmap/memset/kunmap to memzero_user()
Message-ID: <20210312115757.GQ7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309212137.2610186-1-ira.weiny@intel.com>
 <20210310155836.7d63604e28d746ef493c1882@linux-foundation.org>
 <20210311155748.GR3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311155748.GR3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 07:57:48AM -0800, Ira Weiny wrote:
> On Wed, Mar 10, 2021 at 03:58:36PM -0800, Andrew Morton wrote:
> > On Tue,  9 Mar 2021 13:21:34 -0800 ira.weiny@intel.com wrote:
> > 
> > > Previously this was submitted to convert to zero_user()[1].  zero_user() is not
> > > the same as memzero_user() and in fact some zero_user() calls may be better off
> > > as memzero_user().  Regardless it was incorrect to convert btrfs to
> > > zero_user().
> > > 
> > > This series corrects this by lifting memzero_user(), converting it to
> > > kmap_local_page(), and then using it in btrfs.
> > 
> > This impacts btrfs more than MM.  I suggest the btrfs developers grab
> > it, with my
> 
> I thought David wanted you to take these this time?
> 
> "I can play the messenger again but now it seems a round of review is needed
> and with some testing it'll be possible in some -rc. At that point you may take
> the patches via the mm tree, unless Linus is ok with a late pull."
> 
> 	-- https://lore.kernel.org/lkml/20210224123049.GX1993@twin.jikos.cz/
> 
> But reading that again I'm not sure what he meant.

As Linus had some objections I was not sure it was still feasible for
the merge window, but this is now sorted. This new patchset does further
changes in MM and the btrfs part is a straightforward cleanup. I've
noticed Andrew added the patches to his queue which I'd prefer so I've
added my reviewed-by to the third patch. Thanks.
