Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8260A58
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfGEQhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 12:37:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728513AbfGEQhr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 12:37:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CAACAECA;
        Fri,  5 Jul 2019 16:37:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D80CDA88C; Fri,  5 Jul 2019 18:38:29 +0200 (CEST)
Date:   Fri, 5 Jul 2019 18:38:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     WenRuo Qu <wqu@suse.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        James Harvey <jamespharvey20@gmail.com>
Subject: Re: [PATCH v2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
Message-ID: <20190705163828.GC20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, WenRuo Qu <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        James Harvey <jamespharvey20@gmail.com>
References: <20190701051225.17957-1-wqu@suse.com>
 <20190704160400.GY20977@twin.jikos.cz>
 <7eedec47-5ab1-0d39-7cb0-e7ab75b2424a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eedec47-5ab1-0d39-7cb0-e7ab75b2424a@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 04, 2019 at 11:51:38PM +0000, WenRuo Qu wrote:
> >> @@ -1630,7 +1655,8 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
> >>  	} else if (BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC && !force_cow) {
> >>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
> >>  					 page_started, 0, nr_written);
> >> -	} else if (!inode_need_compress(inode, start, end)) {
> >> +	} else if (!inode_can_compress(inode) ||
> >> +		   !inode_need_compress(inode, start, end)) {
> > 
> > Well, that's not excatly what I expected, but because this is an
> > important fix I won't object now and add it to 5.3 queue.
> > 
> 
> I know what you expect, single inode_can_compress().

Yeah, because need_compress calls the heuristic, and then again inside
compress_file_range. I found a few problems in the compression decision
logic that will address that but for now that's how things have been so
the fix is not making it worse.

> But still, we want to avoid hitting the compression routine, thus here
> we do extra inode_need_compress() check other than exiting in
> compress_file_extent().

That's right, some of the compression decisions can be made out of
compress_file_range, like NOCOMPRESS. Even the heuristics can let it
skip compression completely but when this does not reach
compress_file_range the NOCOMPRESS flag has no chance to be set.
And there are more issues.
