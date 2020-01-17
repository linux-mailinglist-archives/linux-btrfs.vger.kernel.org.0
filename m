Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE73140D91
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAQPOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 10:14:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:58106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgAQPON (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 10:14:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 065D5ACD7;
        Fri, 17 Jan 2020 15:14:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE016DA871; Fri, 17 Jan 2020 16:13:52 +0100 (CET)
Date:   Fri, 17 Jan 2020 16:13:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Message-ID: <20200117151352.GK3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
 <20200117125105.20989-6-johannes.thumshirn@wdc.com>
 <283f82d5-1ac7-567b-bbb8-5995748c34df@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <283f82d5-1ac7-567b-bbb8-5995748c34df@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 05:10:35PM +0200, Nikolay Borisov wrote:
> 
> 
> On 17.01.20 г. 14:51 ч., Johannes Thumshirn wrote:
> > The integrity checking code for the superblock mirrors is the last remaining
> > user of buffer_heads in BTRFS, change it to using plain BIOs as well.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> So this path is called only during mount which means it's more or less
> excluded from concurrent writes. Still I'd like to see it converted to
> using the page cache for the reason mentioned in the "write path" patch.

IIRC we had some funny bugs when mount and device scan (udev) raced just
after mkfs, the page cache must be used so there's no way to read stale
data.
