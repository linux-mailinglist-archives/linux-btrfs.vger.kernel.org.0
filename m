Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56496D6C20
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfJNXiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 19:38:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfJNXiR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 19:38:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FF06AF27;
        Mon, 14 Oct 2019 23:38:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E6F6DA7E3; Tue, 15 Oct 2019 01:38:25 +0200 (CEST)
Date:   Tue, 15 Oct 2019 01:38:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/19] btrfs: load block_groups into discard_list on mount
Message-ID: <20191014233825.GR2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
 <31ce602fac88f25567a0b3e89037693ec962c1c7.1570479299.git.dennis@kernel.org>
 <20191010171137.xxuhjvmqzgifuixd@macbook-pro-91.dhcp.thefacebook.com>
 <20191014201746.GF40077@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014201746.GF40077@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 14, 2019 at 04:17:46PM -0400, Dennis Zhou wrote:
> On Thu, Oct 10, 2019 at 01:11:38PM -0400, Josef Bacik wrote:
> > On Mon, Oct 07, 2019 at 04:17:46PM -0400, Dennis Zhou wrote:
> > > Async discard doesn't remember the discard state of a block_group when
> > > unmounting or when we crash. So, any block_group that is not fully used
> > > may have undiscarded regions. However, free space caches are read in on
> > > demand. Let the discard worker read in the free space cache so we can
> > > proceed with discarding rather than wait for the block_group to be used.
> > > This prevents us from indefinitely deferring discards until that
> > > particular block_group is reused.
> > > 
> > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > 
> > What if we did completely discard the last time, now we're going back and
> > discarding again?  I think by default we just assume we discarded everything.
> > If we didn't then the user can always initiate a fitrim later.  Drop this one.
> > Thanks,
> > 
> 
> Yeah this is something I wasn't sure about.
> 
> It makes me a little uncomfortable to make the lack of persistence a
> user problem. If in some extreme case where someone frees a large amount
> of space and then unmounts.

Based on past experience, umount should not be slowed down unless really
necessary.

> We can either make them wait on unmount to
> discard everything or retrim the whole drive which in an ideal world
> should just be a noop on already free lba space.

Without persistence of the state, we can't make it perfect and I think,
without any hard evidence, that trimming already trimmed blocks is no-op
on the device. We all know that we don't know what SSDs actually do, so
it's best effort and making it "device problem" is a good solution from
filesystem POV.
