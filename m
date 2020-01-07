Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779CE132A9E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgAGQBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:01:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:46362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgAGQBg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 11:01:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12CBBAFA8;
        Tue,  7 Jan 2020 16:01:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1B5BDA78B; Tue,  7 Jan 2020 17:01:24 +0100 (CET)
Date:   Tue, 7 Jan 2020 17:01:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs: btrfs: prevent unintentional int overflow
Message-ID: <20200107160124.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Cengiz Can <cengiz@kernel.wtf>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <20200103184739.26903-1-cengiz@kernel.wtf>
 <20200106155328.GK3929@twin.jikos.cz>
 <16f809ac7e8.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f809ac7e8.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 06:23:45PM +0300, Cengiz Can wrote:
> On January 6, 2020 18:53:40 David Sterba <dsterba@suse.cz> wrote:
> 
> > The overflow can't happen in practice. Taking generous maximum value for
> > an item and sectorsize (64K) and doing the math will reach nowhere the
> > overflow limit for 32bit type:
> >
> > 64K / 4 * 64K = 1G
> 
> I didn't know that. Thanks for sharing.
> 
> > I'm not sure if this is worth adding the cast, or mark the coverity
> > issue as not important.
> 
> If the cast is adding any overhead (which I don't think it does) I would 
> kindly request adding it for the sake of completeness.

It's not a runtime overhead but typecasts should not be needed in
general and when there's one it should be there for a reason. Sometimes
it's apparent and does not need a comment to explain why but otherwise I
see it as "overhead" when reading the code. Lots of calculations done in
btrfs fit perfectly to 32bit, eg. the b-tree node or page-related ones.
Where it matters is eg. conversion from/to bio::bi_sector to/from btrfs
logical addresses that are u64, where the interface type is unsigned
long and not a fixed width.

The size constraints of the variables used in the reported expression
are known to developers so I tend to think the typecast is not
necessary.  Maybe the static checker tool could be improved to know the
invariants, that are eg. verified in fs/btrfs/disk-io.c:validate_super.
