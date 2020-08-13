Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D647243C43
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMPL2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 11:11:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:58266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMPL2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 11:11:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44713ACF9;
        Thu, 13 Aug 2020 15:11:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6EAF0DA6EF; Thu, 13 Aug 2020 17:10:24 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:10:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/23][v4] Change data reservations to use the ticketing
 infra
Message-ID: <20200813151024.GL2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200721142234.2680-1-josef@toxicpanda.com>
 <121b9dab-888b-4be3-30bf-5719b9017014@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <121b9dab-888b-4be3-30bf-5719b9017014@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 11:35:15AM +0300, Nikolay Borisov wrote:
> 
> 
> On 21.07.20 г. 17:22 ч., Josef Bacik wrote:
> > v3->v4:
> > - Rebased onto a recent misc-next, slight fixup because of commenting around the
> >   flush states.
> > 
> > v2->v3:
> > - Rebased onto a recent misc-next
> > 
> > v1->v2:
> > - Adjusted a comment in may_commit_transaction.
> > - Fixed one of the intermediate patches to properly update ->reclaim_size.
> > 
> > We've had two different things in place to reserve data and metadata space,
> > because generally speaking data is much simpler.  However the data reservations
> > still suffered from the same issues that plagued metadata reservations, you
> > could get multiple tasks racing in to get reservations.  This causes problems
> > with cases like write/delete loops where we should be able to fill up the fs,
> > delete everything, and go again.  You would sometimes race with a flusher that's
> > trying to unpin the free space, take it's reservations, and then it would fail.
> > 
> > Fix this by moving the data reservations under the metadata ticketing
> > infrastructure.  This gets rid of that problem, and simplifies our enospc code
> > more by consolidating it into a single path.  Thanks,
> > 
> > Josef
> > 
> 
> I've gone through the series again and it looks good. However,
> btrfs_alloc_data_chunk_ondemand no longer allocates a data chunk but
> simply tries to reserve the requested data space. This means this series
> needs another patch giving it a more becoming name, something like
> btrfs_(alloc|reserve)_data_space or some such ?

Yes please, this could be confunsing as allocation and reservation are
different things.
