Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0B0243C4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 17:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMPPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 11:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMPPr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 11:15:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D724AE25;
        Thu, 13 Aug 2020 15:16:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B6736DA6EF; Thu, 13 Aug 2020 17:14:43 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:14:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/23][v4] Change data reservations to use the ticketing
 infra
Message-ID: <20200813151443.GM2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200721142234.2680-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 10:22:11AM -0400, Josef Bacik wrote:
> v3->v4:
> - Rebased onto a recent misc-next, slight fixup because of commenting around the
>   flush states.
> 
> v2->v3:
> - Rebased onto a recent misc-next
> 
> v1->v2:
> - Adjusted a comment in may_commit_transaction.
> - Fixed one of the intermediate patches to properly update ->reclaim_size.
> 
> We've had two different things in place to reserve data and metadata space,
> because generally speaking data is much simpler.  However the data reservations
> still suffered from the same issues that plagued metadata reservations, you
> could get multiple tasks racing in to get reservations.  This causes problems
> with cases like write/delete loops where we should be able to fill up the fs,
> delete everything, and go again.  You would sometimes race with a flusher that's
> trying to unpin the free space, take it's reservations, and then it would fail.
> 
> Fix this by moving the data reservations under the metadata ticketing
> infrastructure.  This gets rid of that problem, and simplifies our enospc code
> more by consolidating it into a single path.  Thanks,

V4 was in for-next so it got some testing coverage, though I haven't
done enospc targeted tests. I'm going to go through this series and put
it to misc-next once rc1 is out.
