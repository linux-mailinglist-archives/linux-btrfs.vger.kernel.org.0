Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5511519EF4B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 04:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDFCYo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 5 Apr 2020 22:24:44 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33418 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFCYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Apr 2020 22:24:43 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 119B06567D6; Sun,  5 Apr 2020 22:24:41 -0400 (EDT)
Date:   Sun, 5 Apr 2020 22:24:41 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
Message-ID: <20200406022441.GM13306@hungrycats.org>
References: <20200405082636.18016-1-kreijack@libero.it>
 <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 05, 2020 at 11:57:49AM +0100, Graham Cobb wrote:
> On 05/04/2020 09:26, Goffredo Baroncelli wrote:
> ...
> 
> > I considered the following scenarios:
> > - btrfs over ssd
> > - btrfs over ssd + hdd with my patch enabled
> > - btrfs over bcache over hdd+ssd
> > - btrfs over hdd (very, very slow....)
> > - ext4 over ssd
> > - ext4 over hdd
> > 
> > The test machine was an "AMD A6-6400K" with 4GB of ram, where 3GB was used
> > as cache/buff.
> > 
> > Data analysis:
> > 
> > Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
> > apt on a rotational was a dramatic experience. And IMHO  this should be replaced
> > by using the btrfs snapshot capabilities. But this is another (not easy) story.

flushoncommit and eatmydata work reasonably well...once you patch out the
noise warnings from fs-writeback.

> > Unsurprising bcache performs better than my patch. But this is an expected
> > result because it can cache also the data chunk (the read can goes directly to
> > the ssd). bcache perform about +60% slower when there are a lot of sync/flush
> > and only +20% in the other case.
> > 
> > Regarding the test with force-unsafe-io (fewer sync/flush), my patch reduce the
> > time from +256% to +113%  than the hdd-only . Which I consider a good
> > results considering how small is the patch.
> > 
> > 
> > Raw data:
> > The data below is the "real" time (as return by the time command) consumed by
> > apt
> > 
> > 
> > Test description         real (mmm:ss)	Delta %
> > --------------------     -------------  -------
> > btrfs hdd w/sync	   142:38	+533%
> > btrfs ssd+hdd w/sync        81:04	+260%
> > ext4 hdd w/sync	            52:39	+134%
> > btrfs bcache w/sync	    35:59	 +60%
> > btrfs ssd w/sync	    22:31	reference
> > ext4 ssd w/sync	            12:19	 -45%
> 
> Interesting data but it seems to be missing the case of btrfs ssd+hdd
> w/sync without your patch in order to tell what difference your patch
> made. Or am I confused?

Goffredo's test was using profile 'single' for both data and metadata,
so the unpatched allocator would use the biggest device (hdd) for all
block groups and ignore the smaller one (ssd).  The result should be
the same as plain btrfs hdd, give or take a few superblock updates.

Of course, no one should ever use 'single' profile for metadata, except
on disposable filesystems like the ones people use for benchmarks.  ;)
