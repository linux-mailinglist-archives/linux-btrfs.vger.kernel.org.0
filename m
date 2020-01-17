Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34374140BFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAQOCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:02:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:59406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbgAQOCr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:02:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E6B30B2AF;
        Fri, 17 Jan 2020 14:02:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 108B9DA871; Fri, 17 Jan 2020 15:02:32 +0100 (CET)
Date:   Fri, 17 Jan 2020 15:02:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Message-ID: <20200117140231.GF3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 08:54:35AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/1/16 下午10:29, David Sterba wrote:
> > On Wed, Jan 15, 2020 at 11:41:28AM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> When there are a lot of metadata space reserved, e.g. after balancing a
> >> data block with many extents, vanilla df would report 0 available space.
> >>
> >> [CAUSE]
> >> btrfs_statfs() would report 0 available space if its metadata space is
> >> exhausted.
> >> And the calculation is based on currently reserved space vs on-disk
> >> available space, with a small headroom as buffer.
> >> When there is not enough headroom, btrfs_statfs() will report 0
> >> available space.
> >>
> >> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
> >> reservations if we have pending tickets"), we allow btrfs to over commit
> >> metadata space, as long as we have enough space to allocate new metadata
> >> chunks.
> >>
> >> This makes old calculation unreliable and report false 0 available space.
> >>
> >> [FIX]
> >> Don't do such naive check anymore for btrfs_statfs().
> >> Also remove the comment about "0 available space when metadata is
> >> exhausted".
> > 
> > This is intentional and was added to prevent a situation where 'df'
> > reports available space but exhausted metadata don't allow to create new
> > inode.
> 
> But this behavior itself is not accurate.
> 
> We have global reservation, which is normally always larger than the
> immediate number 4M.

The global block reserve is subtracted from the metadata accounted from
the block groups. And after that, if there's only little space left, the
check triggers. Because at this point any new metadata reservation
cannot be satisfied from the remaining space, yet there's >0 reported.

> So that check will never really be triggered.
> 
> Thus invalidating most of your argument.

Please read the current comment and code in statfs again.
