Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E873315E2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 05:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBJEZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 23:25:40 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:16556 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhBJEZj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 23:25:39 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Db69h3nZ6z2d;
        Wed, 10 Feb 2021 05:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1612931096; bh=QHxzW/XJK3U0oNQjGYevmIuaZObRFPo3K4Pd9Nk0lHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMcD2oq404OShRFj1fd4CTBBo5rmZXa0Z2HJCX6iLLEpoAzr7mPzW6q2yYUOqp8a0
         rwtNsp5kkM2LBtyWaNUr8PAkSGFoWjtA5qrhlhj+FLMZbM3Uw7tyb8nQ01obvBBnZu
         5XSOiQh9WaizlWsTs+PpQY03kyv/NruzHjQKxmV9oR9nMlbH0x9Z9fB6vsDTJwETuZ
         B0BAtkGWsp24Y1Ak/mZ1Yt/2DsWbb7oxyPt8cNrfUV4d9JDB1gmfK31/f1J79cF4/c
         kCBTgjCHgniUGBH4eptG9XW4+dd3pL8vbk7ncoMUIMHAv+IDLbKH4AIP9klFperz2w
         1Az1SUNujMmzg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 10 Feb 2021 05:24:28 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
Message-ID: <20210210042428.GC12086@qmqm.qmqm.pl>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-7-mrostecki@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209203041.21493-7-mrostecki@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 09, 2021 at 09:30:40PM +0100, Michal Rostecki wrote:
[...]
> For the array with 3 HDDs, not adding any penalty resulted in 409MiB/s
> (429MB/s) performance. Adding the penalty value 1 resulted in a
> performance drop to 404MiB/s (424MB/s). Increasing the value towards 10
> was making the performance even worse.
> 
> For the array with 2 HDDs and 1 SSD, adding penalty value 1 to
> rotational disks resulted in the best performance - 541MiB/s (567MB/s).
> Not adding any value and increasing the value was making the performance
> worse.
> 
> Adding penalty value to non-rotational disks was always decreasing the
> performance, which motivated setting it as 0 by default. For the purpose
> of testing, it's still configurable.
[...]
> +	bdev = map->stripes[mirror_index].dev->bdev;
> +	inflight = mirror_load(fs_info, map, mirror_index, stripe_offset,
> +			       stripe_nr);
> +	queue_depth = blk_queue_depth(bdev->bd_disk->queue);
> +
> +	return inflight < queue_depth;
[...]
> +	last_mirror = this_cpu_read(*fs_info->last_mirror);
[...]
> +	for (i = last_mirror; i < first + num_stripes; i++) {
> +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> +					    stripe_nr)) {
> +			preferred_mirror = i;
> +			goto out;
> +		}
> +	}
> +
> +	for (i = first; i < last_mirror; i++) {
> +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> +					    stripe_nr)) {
> +			preferred_mirror = i;
> +			goto out;
> +		}
> +	}
> +
> +	preferred_mirror = last_mirror;
> +
> +out:
> +	this_cpu_write(*fs_info->last_mirror, preferred_mirror);

This looks like it effectively decreases queue depth for non-last
device. After all devices are filled to queue_depth-penalty, only
a single mirror will be selected for next reads (until a read on
some other one completes).

Have you tried testing with much more jobs / non-sequential accesses?

Best Reagrds,
Micha³ Miros³aw
