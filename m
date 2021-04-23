Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D706E369072
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbhDWKgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 06:36:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhDWKgH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 06:36:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8F31AD4A;
        Fri, 23 Apr 2021 10:35:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C0FEDA7FE; Fri, 23 Apr 2021 12:33:09 +0200 (CEST)
Date:   Fri, 23 Apr 2021 12:33:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v6 0/3] btrfs: zoned: automatic BG reclaim
Message-ID: <20210423103309.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1618943115.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618943115.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 21, 2021 at 03:27:22AM +0900, Johannes Thumshirn wrote:
> When a file gets deleted on a zoned file system, the space freed is not
> returned back into the block group's free space, but is migrated to
> zone_unusable.
> 
> As this zone_unusable space is behind the current write pointer it is not
> possible to use it for new allocations. In the current implementation a
> zone is reset once all of the block group's space is accounted as zone
> unusable.
> 
> This behaviour can lead to premature ENOSPC errors on a busy file system.
> 
> Instead of only reclaiming the zone once it is completely unusable,
> kick off a reclaim job once the amount of unusable bytes exceeds a user
> configurable threshold between 51% and 100%. It can be set per mounted
> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
> per default.
> 
> Similar to reclaiming unused block groups, these dirty block groups are
> added to a to_reclaim list and then on a transaction commit, the reclaim
> process is triggered but after we deleted unused block groups, which will
> free space for the relocation process.
> 
> Zones that are 100% full and zone unusable already get reclaimed atomatically
> on transaction commit. Another improvement on the garbage collection side of
> zoned btrfs would be no to reclaim block groups that have used, pinned and
> reserved = 0 but zone_unusable > 0. This is not yet included as it needs
> further reaserch and testing.
> 
> Changes to v5:
> - Prefix define (David)
> - Print bg usage percentage in reclaim info (David)

V6 added to misc-next and queued for 5.13, thanks.
