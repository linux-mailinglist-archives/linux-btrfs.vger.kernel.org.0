Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2215E9F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 18:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391832AbgBNRKc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 12:10:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:39376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388525AbgBNRKa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 12:10:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5FDDACA4;
        Fri, 14 Feb 2020 17:10:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE2B4DA703; Fri, 14 Feb 2020 18:10:14 +0100 (CET)
Date:   Fri, 14 Feb 2020 18:10:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] btrfs: relocation: Check cancel request after
 each data page read
Message-ID: <20200214171014.GE2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200211053729.20807-1-wqu@suse.com>
 <20200211053729.20807-3-wqu@suse.com>
 <c9f33ce1-3e9e-b12e-a510-610f8533bd6a@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f33ce1-3e9e-b12e-a510-610f8533bd6a@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 13, 2020 at 03:03:55PM -0500, Josef Bacik wrote:
> On 2/11/20 12:37 AM, Qu Wenruo wrote:
> > When relocating a data extents with large large data extents, we spend
> > most of our time in relocate_file_extent_cluster() at stage "moving data
> > extents":
> >   1)               |  btrfs_relocate_block_group [btrfs]() {
> >   1)               |    relocate_file_extent_cluster [btrfs]() {
> >   1) $ 6586769 us  |    }
> >   1) + 18.260 us   |    relocate_file_extent_cluster [btrfs]();
> >   1) + 15.770 us   |    relocate_file_extent_cluster [btrfs]();
> >   1) $ 8916340 us  |  }
> >   1)               |  btrfs_relocate_block_group [btrfs]() {
> >   1)               |    relocate_file_extent_cluster [btrfs]() {
> >   1) $ 11611586 us |    }
> >   1) + 16.930 us   |    relocate_file_extent_cluster [btrfs]();
> >   1) + 15.870 us   |    relocate_file_extent_cluster [btrfs]();
> >   1) $ 14986130 us |  }
> > 
> > So to make data relocation cancelling quicker, here add extra balance
> > cancelling check after each page read in relocate_file_extent_cluster().
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> If you respin, can you note that with this cancellation we'll break out and 
> merge the reloc roots, its not like everything will just be left over to be 
> completed at the next mount.

Yes that's what I miss here too and asked about it in v1 thread. No
resend is needed, I can update changelog if the new text is sent to me.
