Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711F8308DA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 20:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhA2Tou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 14:44:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:42478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232888AbhA2Tol (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 14:44:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4D38ACB0;
        Fri, 29 Jan 2021 19:43:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6435BDA7C3; Fri, 29 Jan 2021 20:42:08 +0100 (CET)
Date:   Fri, 29 Jan 2021 20:42:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
Message-ID: <20210129194208.GM1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Michal Rostecki <mrostecki@suse.de>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Rostecki <mrostecki@suse.com>
References: <20210127135728.30276-1-mrostecki@suse.de>
 <18dab74b-aea9-0e34-1be5-39d62f44cfd2@toxicpanda.com>
 <20210129171521.GB22949@wotan.suse.de>
 <20210129174753.GL1993@twin.jikos.cz>
 <20210129190241.GA18188@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129190241.GA18188@wotan.suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 29, 2021 at 07:02:41PM +0000, Michal Rostecki wrote:
> On Fri, Jan 29, 2021 at 06:47:53PM +0100, David Sterba wrote:
> > On Fri, Jan 29, 2021 at 05:15:21PM +0000, Michal Rostecki wrote:
> > > On Fri, Jan 29, 2021 at 11:22:48AM -0500, Josef Bacik wrote:
> > > > On 1/27/21 8:57 AM, Michal Rostecki wrote:
> > > > it happens when you run btrfs/060.  Please make sure to run xfstests against
> > > > patches before you submit them upstream.  Thanks,
> > > > 
> > > > Josef
> > > 
> > > Umm... I ran the xftests against v1 patch and didn't get that panic.
> > 
> > It could have been caused by my fixups to v2 and I can reproduce the
> > crash now too. I can't see any difference besides the u64/int switch and
> > the 'goto out' removal in btrfs_bio_fits_in_stripe.
> 
> I was able to fix the issue by the following diff. I will send it as the
> patch after confirming that all fstests are passing.

Thanks, can't reproduce the crash with that at least on test btrfs/060.
