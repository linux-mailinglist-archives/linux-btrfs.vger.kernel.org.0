Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D31369B56
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 22:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbhDWUeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 16:34:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhDWUeB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 16:34:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D653BB035;
        Fri, 23 Apr 2021 20:33:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F220DA7FE; Fri, 23 Apr 2021 22:31:03 +0200 (CEST)
Date:   Fri, 23 Apr 2021 22:31:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: the missing 4 patches to implement metadata
 write path
Message-ID: <20210423203103.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210406003603.64381-1-wqu@suse.com>
 <20210423112938.GG7604@twin.jikos.cz>
 <af78885d-b9a3-7629-d659-812121696bab@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af78885d-b9a3-7629-d659-812121696bab@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 23, 2021 at 07:36:29PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/4/23 下午7:29, David Sterba wrote:
> > On Tue, Apr 06, 2021 at 08:35:59AM +0800, Qu Wenruo wrote:
> >> When adding the comments for subpage metadata code, I inserted the
> >> comment patch into the wrong position, and then use that patch as a
> >> separator between data and metadata write path.
> >>
> >> Thus the submitted metadata write path patchset lacks the real functions
> >> to submit subpage metadata write bio.
> >>
> >> Qu Wenruo (4):
> >>    btrfs: introduce end_bio_subpage_eb_writepage() function
> >>    btrfs: introduce write_one_subpage_eb() function
> >>    btrfs: make lock_extent_buffer_for_io() to be subpage compatible
> >>    btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
> >
> > For the record, the patches have been added to 5.13 queue a few days
> > ago.
> >
> 
> Josef had some comments on them, most of them are just related to
> introducing a new subpage specific endio function other than reusing the
> existing one.

I haven't seen any comments for that patchset.

> So I guess if I go that direction, I should just add new patches as a
> refactor?

Yes please.
