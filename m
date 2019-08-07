Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D70084BD3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfHGMmC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 08:42:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:47442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfHGMmB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 08:42:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDF59AD23;
        Wed,  7 Aug 2019 12:42:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75BE5DA7D7; Wed,  7 Aug 2019 14:42:32 +0200 (CEST)
Date:   Wed, 7 Aug 2019 14:42:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] Sysfs updates
Message-ID: <20190807124232.GS28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1564505777.git.dsterba@suse.com>
 <939d08f0-e851-4f00-733e-c7de15685318@oracle.com>
 <20190806164604.GN28208@twin.jikos.cz>
 <1893f2cd-b2d3-875e-977f-ce2c8ec43852@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1893f2cd-b2d3-875e-977f-ce2c8ec43852@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 04:29:45PM +0800, Anand Jain wrote:
> On 7/8/19 12:46 AM, David Sterba wrote:
> > On Tue, Aug 06, 2019 at 11:17:09PM +0800, Anand Jain wrote:
> >> On 7/31/19 1:10 AM, David Sterba wrote:
> >>> Export the potential debugging data in the per-filesystem directories we
> >>> already have, so we can drop debugfs. The new directories depend on
> >>> CONFIG_BTRFS_DEBUG so they're not affecting normal builds.
> >>>
> >>> David Sterba (2):
> >>>     btrfs: sysfs: add debugging exports
> >>>     btrfs: delete debugfs code
> >>>
> >>>    fs/btrfs/sysfs.c | 68 +++++++++++++++++++++++-------------------------
> >>>    fs/btrfs/sysfs.h |  5 ----
> >>>    2 files changed, 32 insertions(+), 41 deletions(-)
> >>>
> >>
> >> For 2/2:
> >>    Reviewed-by: Anand Jain <anand.jain@oracle.com>
> >>
> >> For 1/2:
> >>    IMO it would be better to delay this until we really have a debug hook
> >>    exposed at the sysfs.
> > 
> > Sorry, I don't understand what you mean.
> > 
> 
>   I notice that /sysfs/fs/btrfs/<debug>|<fsid/debug> is dummy as of now,
>   IMO its better to add this (1/2) patch along with the some actual trace
>   which is needed.

Yes it is empty for now, ready for use, like was the previous debugfs.

I don't want to delay removing the debugfs code further and not
providing a replacement does not sound as a good option, the patch would
be lost in the mailinglist.

>   Potentially either dtrace/bfp probes will be better
>   runtime debugging approach.

That's orthogonal, the sysfs is for exporting data or triggering some
action by writing to the files. The file based approach is simple to use
without external tools like bpf or even 3rd party patchsets like dtrace.
