Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E587A83738
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfHFQnM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:43:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:51370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728927AbfHFQnL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 12:43:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9A63ACC2;
        Tue,  6 Aug 2019 16:43:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08769DA7D7; Tue,  6 Aug 2019 18:43:41 +0200 (CEST)
Date:   Tue, 6 Aug 2019 18:43:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/25] btrfs: migrate the block group code
Message-ID: <20190806164339.GM28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190620193807.29311-1-josef@toxicpanda.com>
 <20190802135638.GW28208@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802135638.GW28208@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 02, 2019 at 03:56:38PM +0200, David Sterba wrote:
> On Thu, Jun 20, 2019 at 03:37:42PM -0400, Josef Bacik wrote:
> > This is the series to migrate the block group code out of extent-tree.c.  This
> > is a much larger series than the previous two series because things were much
> > more intertwined than block_rsv's and space_info.  There is one code change
> > patch in this series, it is
> > 
> > btrfs: make caching_thread use btrfs_find_next_key
> 
> I've merged 1-10 (ie. up to the patch mentioned above) as it applied
> cleanly on current misc-next, the rest produced some conflicts.

11-25 is now in testing and will be in misc-next soon.

I merged most of the patches manually, there were several updates (code
and coding style) in the moved code. As I don't want to do that painful
exercise again, patchsets like that must come last before the pull
request branch is frozen. This worked well with the other code moving
patchsets (3 patchsets, 23 patches in total).

This one alone has about the same amount of patches, which appears to
bee too much as the number of conflicts increases as other changes get
merged. So the recommended approach is to do that in smaller batches and
do next once the previous is merged.
