Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB9333869
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhCJJKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:10:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:35566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232646AbhCJJKK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:10:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85CD8AE27;
        Wed, 10 Mar 2021 09:10:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3C60DA7D7; Wed, 10 Mar 2021 10:08:10 +0100 (CET)
Date:   Wed, 10 Mar 2021 10:08:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: output sectorsize related warning message
 into stdout
Message-ID: <20210310090810.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210309073909.74043-1-wqu@suse.com>
 <20210309133325.GH7604@twin.jikos.cz>
 <49c16359-3ce0-c021-608d-b05c9d4c1fda@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c16359-3ce0-c021-608d-b05c9d4c1fda@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 10, 2021 at 08:18:16AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/9 下午9:33, David Sterba wrote:
> > On Tue, Mar 09, 2021 at 03:39:09PM +0800, Qu Wenruo wrote:
> >> Since commit 90020a760584 ("btrfs-progs: mkfs: refactor how we handle
> >> sectorsize override") we have extra warning message if the sectorsize of
> >> mkfs doesn't match page size.
> >>
> >> But this warning is show as stderr, which makes a lot of fstests cases
> >> failure due to golden output mismatch.
> >
> > Well, no. Using message helpers in progs is what we want to do
> > everywhere, working around fstests output matching design is fixing the
> > problem in the wrong place. That this is fragile has been is known and
> > I want to keep the liberty to adjust output in progs as users need, not
> > as fstests require.
> 
> OK, then I guess the best way to fix the problem is to add sysfs
> interface to export supported rw/ro sectorsize.
> 
> It shouldn't be that complex and would be small enough for next merge
> window.

The subpage support should be advertised somewhere in sysfs so the range
of supported sector sizes sounds like a good idea.
