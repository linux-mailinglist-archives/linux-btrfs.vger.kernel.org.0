Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3D7C35E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfGaNXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 09:23:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbfGaNXJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 09:23:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06EFEAE21;
        Wed, 31 Jul 2019 13:23:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 918F5DA7ED; Wed, 31 Jul 2019 15:23:42 +0200 (CEST)
Date:   Wed, 31 Jul 2019 15:23:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
Message-ID: <20190731132342.GK28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190718062749.11276-1-wqu@suse.com>
 <20190725183741.GX2868@twin.jikos.cz>
 <a835760e-be9d-cfd9-d8c3-c316f34ec20f@gmx.com>
 <20190726103902.GZ2868@twin.jikos.cz>
 <052a23bb-428d-3249-d8cb-b508ebca0b62@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <052a23bb-428d-3249-d8cb-b508ebca0b62@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 31, 2019 at 02:58:02PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/7/26 下午6:39, David Sterba wrote:
> > On Fri, Jul 26, 2019 at 07:41:41AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2019/7/26 上午2:37, David Sterba wrote:
> >>> On Thu, Jul 18, 2019 at 02:27:49PM +0800, Qu Wenruo wrote:
> >>>> RAID10 can accept as much as half of its disks to be missing, as long as
> >>>> each sub stripe still has a good mirror.
> >>>
> >>> Can you please make a test case for that?
> >>
> >> Fstests one or btrfs-progs one?
> > 
> > For fstests.
> 
> OK, that test case in fact exposed a long-existing bug, we can't create
> degraded chunks.
> 
> So if we're replacing the missing devices on a 4 disk RAID10 btrfs, we
> will hit ENOSPC as we can't find 4 devices to fulfill a new chunk.
> And it will finally trigger transaction abort.
> 
> Please discard this patch until we solve that problem.

Ok, done.
