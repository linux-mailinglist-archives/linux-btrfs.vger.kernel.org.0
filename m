Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125C829A9AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 11:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898311AbgJ0KcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 06:32:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898272AbgJ0KbT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 06:31:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1311CB2A4;
        Tue, 27 Oct 2020 10:31:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F56FDA6E2; Tue, 27 Oct 2020 11:29:44 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:29:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 13/68] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
Message-ID: <20201027102944.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-14-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-14-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 02:24:59PM +0800, Qu Wenruo wrote:
> In end_bio_extent_readpage() we had a strange dance around
> extent_start/extent_len.
> 
> The truth is, no matter what we're doing using those two variable, the
> end result is just the same, clear the EXTENT_LOCKED bit and if needed
> set the EXTENT_UPTODATE bit for the io_tree.
> 
> This doesn't need the complex dance, we can do it pretty easily by just
> calling endio_readpage_release_extent() for each bvec.
> 
> This greatly streamlines the code.

Yes it does, the old code is a series of conditions and new code is just
one call but it's hard to see why this is correct. Can you please write
some guidance, what are the invariants or how does the logic simplify?
What you write above is a summary but for review I'd need something to
follow so I don't have to spend too much time reading just this patch.
Thanks.
