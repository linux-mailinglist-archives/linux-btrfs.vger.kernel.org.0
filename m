Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86C933C62A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 19:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhCOSxN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 14:53:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:46912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbhCOSxL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 14:53:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89980AEBA;
        Mon, 15 Mar 2021 18:53:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F498DA6E2; Mon, 15 Mar 2021 19:51:09 +0100 (CET)
Date:   Mon, 15 Mar 2021 19:51:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix wild pointer access during metadata read
 failure for subpage
Message-ID: <20210315185108.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210315053915.62420-1-wqu@suse.com>
 <20210315053915.62420-2-wqu@suse.com>
 <PH0PR04MB741641D5C56FD335C864FD0B9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <f4ebad22-2004-b051-2871-8f1ed64cc6cc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ebad22-2004-b051-2871-8f1ed64cc6cc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 15, 2021 at 04:25:32PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/15 下午3:55, Johannes Thumshirn wrote:
> > On 15/03/2021 06:40, Qu Wenruo wrote:
> >> The difference against find_extent_buffer_nospinlock() is:
> >> - Also handles regular sectorsize == PAGE_SIZE case
> >> - No extent buffer refs increase/decrease
> >>    As extent buffer under IO must has non-zero refs.
> >
> > Can these be merged into a single function? The sectorsie == PAGE_SIZE case
> > won't do anything for find_extent_buffer_nospinlock() and the
> > atomic_inc_not_zero(&eb->refs) can be hidden behind a 'if (write)' check.
> 
> That would make the eb refs change too inconsistent.
> 
> But I get your point.
> 
> How about calling find_extent_buffer_nospinlock() and then dec the refs
> manually?

Is this equivalent to this patch? Ie. the atomic_inc_not_zero in
find_extent_buffer_nospinlock happens inside the RCU section, while what
you suggest looks like

find_extent_buffer_nospinlock()
  rcu_lock
  radix_lookup
  rcu_unlock
atomic_inc_not_zero()
