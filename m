Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13353132AEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgAGQSB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:18:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:55636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgAGQSA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 11:18:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 461D2AEF8;
        Tue,  7 Jan 2020 16:17:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E77CDA78B; Tue,  7 Jan 2020 17:17:49 +0100 (CET)
Date:   Tue, 7 Jan 2020 17:17:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] btrfs: introduce the inode->file_extent_tree
Message-ID: <20200107161749.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191230213118.7532-1-josef@toxicpanda.com>
 <20191230213118.7532-3-josef@toxicpanda.com>
 <20200106172234.GN3929@twin.jikos.cz>
 <a9b6d5cb-b3a4-8088-c6cc-236ef555cf44@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b6d5cb-b3a4-8088-c6cc-236ef555cf44@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 02:29:01PM -0500, Josef Bacik wrote:
> On 1/6/20 12:22 PM, David Sterba wrote:
> > On Mon, Dec 30, 2019 at 04:31:15PM -0500, Josef Bacik wrote:
> >> @@ -60,6 +60,11 @@ struct btrfs_inode {
> >>   	 */
> >>   	struct extent_io_tree io_failure_tree;
> >>   
> >> +	/* keeps track of where we have extent items mapped in order to make
> >> +	 * sure our i_size adjustments are accurate.
> >> +	 */
> >> +	struct extent_io_tree file_extent_tree;
> > 
> > This is not exactly lightweight and cut to the minimum needed, the size
> > is 40 bytes and contains struct members that are unused. At least the
> > file extents tree seems to be in use unlike that io_failure_tree wasting
> > the bytes almost 100% of time.
> >
> 
> I'm not in love with it either, but I don't want to invent some lighter weight 
> range thingy that I'm going to end up messing up in other ways.

Yeah, the extent_io_tree is now being used for generic range tree, some
cleanups could remove the members that were added for the first specific
use (like the dirty_bytes, or track_updates). For correctness of NOHOLES
the inode size increase shouldn't be a blocker but needs to be addressed
later.

> Don't take this series yet, there's still something fishy going on that I have 
> to figure out.  Thanks,

Ok.
