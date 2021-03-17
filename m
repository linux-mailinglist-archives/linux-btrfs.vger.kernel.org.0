Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9133EEDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 11:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCQKyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 06:54:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhCQKx7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 06:53:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91326AC1F;
        Wed, 17 Mar 2021 10:53:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 583C2DA6E2; Wed, 17 Mar 2021 11:51:56 +0100 (CET)
Date:   Wed, 17 Mar 2021 11:51:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Message-ID: <20210317105156.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <44b2ec9c1acbaf8c0e13ef882e2340477bac379e.1615971432.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b2ec9c1acbaf8c0e13ef882e2340477bac379e.1615971432.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 05:57:31PM +0900, Johannes Thumshirn wrote:
> In btrfs_submit_direct() there's a WAN_ON_ONCE() that will trigger if
> we're submitting a DIO write on a zoned filesystem but are not using
> REQ_OP_ZONE_APPEND to submit the IO to the block device.
> 
> This is a left over from a previous version where btrfs_dio_iomap_begin()
> didn't use btrfs_use_zone_append() to check for sequential write only
> zones.

I can't identify the patch where this got changed. I've landed on
544d24f9de73 ("btrfs: zoned: enable zone append writing for direct IO")
but that adds the btrfs_use_zone_append, the append flag and also the
warning.
