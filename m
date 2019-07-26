Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA87D763A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfGZKia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 06:38:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfGZKia (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 06:38:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B8F3B629;
        Fri, 26 Jul 2019 10:38:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BF32DA80E; Fri, 26 Jul 2019 12:39:04 +0200 (CEST)
Date:   Fri, 26 Jul 2019 12:39:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
Message-ID: <20190726103902.GZ2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190718062749.11276-1-wqu@suse.com>
 <20190725183741.GX2868@twin.jikos.cz>
 <a835760e-be9d-cfd9-d8c3-c316f34ec20f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a835760e-be9d-cfd9-d8c3-c316f34ec20f@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 07:41:41AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/7/26 上午2:37, David Sterba wrote:
> > On Thu, Jul 18, 2019 at 02:27:49PM +0800, Qu Wenruo wrote:
> >> RAID10 can accept as much as half of its disks to be missing, as long as
> >> each sub stripe still has a good mirror.
> > 
> > Can you please make a test case for that?
> 
> Fstests one or btrfs-progs one?

For fstests.

> > I think the number of devices that can be lost can be higher than a half
> > in some extreme cases: one device has copies of all stripes, 2nd copy
> > can be scattered randomly on the other devices, but that's highly
> > unlikely to happen.
> > 
> > On average it's same as raid1, but the more exact check can potentially
> > utilize the stripe layout.
> > 
> That will be at extent level, to me it's an internal level violation,
> far from what we want to improve.

Ah I don't mean to go the extent level, as you implemented it is enough
and an improvement.
