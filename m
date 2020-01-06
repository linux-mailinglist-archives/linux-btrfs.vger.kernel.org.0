Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82427131711
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 18:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAFRtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 12:49:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:42770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFRtN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 12:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14A28AAC3;
        Mon,  6 Jan 2020 17:49:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25B43DA78B; Mon,  6 Jan 2020 18:49:02 +0100 (CET)
Date:   Mon, 6 Jan 2020 18:49:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: async discard follow up
Message-ID: <20200106174901.GP3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1577999991.git.dennis@kernel.org>
 <20200106163001.GM3929@twin.jikos.cz>
 <20200106172847.GB16428@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106172847.GB16428@dennisz-mbp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 12:28:47PM -0500, Dennis Zhou wrote:
> On Mon, Jan 06, 2020 at 05:30:01PM +0100, David Sterba wrote:
> > Is it expected to leave the counters in a state where are discardable
> > extents but not process after a long period of time? I found
> > 
> > discard_bitmap_bytes:316833792
> > discard_bytes_saved:59390722048
> > discard_extent_bytes:26122764288
> > discardable_bytes:44863488
> > discardable_extents:883
> > iops_limit:10
> > kbps_limit:0
> > max_discard_size:67108864
> > 
> > there was activity when the number of extents wen from about 2000 to
> > that value (833), so this could bea nother instance of the -1 accounting
> > bug.
> 
> There is no guarantee each invocation of the work item will find
> something to discard. This was designed to prevent any edge case from
> consuming the cpu.
> 
> If free space is added back while a block_group has it's cursor being
> moved (unless it's fully free), it will not go back and trim those
> extents. So we may leave stuff untrimmed until the next time around.
> This is also to prevent a pathological case of just resetting in the
> same block_group. Therefore, we may be in a situation where we have
> discardable extents, but we aren't actively discarding it. The premise
> is some filesystem usage will eventually occur and kick it back onto the
> list. This also works because btrfs tries to reuse block groups before
> allocating another one.

Ok I see, thanks. Removing all the data again followed by balance
reached the state with 1 extent some small size (corresponds to 'used'
of data block gruops), which could be explained by the above as well.
