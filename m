Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB97C1BD6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfEMSvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 14:51:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:53974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728693AbfEMSvx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 14:51:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9982AAEF5;
        Mon, 13 May 2019 18:51:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4B4DDA851; Mon, 13 May 2019 20:52:51 +0200 (CEST)
Date:   Mon, 13 May 2019 20:52:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Timofey Titovets <timofey.titovets@synesis.ru>
Cc:     linux-btrfs@vger.kernel.org,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>
Subject: Re: [PATCH V9] Btrfs: enhance raid1/10 balance heuristic
Message-ID: <20190513185250.GJ3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Timofey Titovets <timofey.titovets@synesis.ru>,
        linux-btrfs@vger.kernel.org,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>
References: <20190506143740.26614-1-timofey.titovets@synesis.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506143740.26614-1-timofey.titovets@synesis.ru>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 06, 2019 at 05:37:40PM +0300, Timofey Titovets wrote:
> From: Timofey Titovets <nefelim4ag@gmail.com>
> 
> Currently btrfs raid1/10 bаlance requests to mirrors,
> based on pid % num of mirrors.
> 
> Add logic to consider:
>  - If one of devices are non rotational
>  - Queue length to devices
> 
> By default pid % num_mirrors guessing will be used, but:
>  - If one of mirrors are non rotational,
>    reroute requests to non rotational
>  - If other mirror have less queue length then optimal,
>    repick to that mirror
> 
> For avoid round-robin request balancing,
> lets use abs diff of queue length,
> and only if diff greater then threshold try rebalance:
>  - threshold 8 for rotational devs
>  - threshold 2 for all non rotational devs

I started to look at this again, so far I think that the decision logic
should be time and congestion based. The case when the devices are
uncongested is easy and choosing either mirror is fine (semi-randomly).

On congested devices it can lead to some pathological patterns like
switching the mirrors too often, so this is the one I'd focus on.

The congestion is reflected in your patch by the part_in_flight, though
you call it 'queue' that got me first confused as there are the hardware
device queues and block layer queues.

From the filesystem perspective and for our purposes, anything that is
below the fs layer is in-flight.

The requests to select a mirror come from all places (btrfs_map_block)
and are basically unpredictable, so saving position of disk head would
not help to decide.

The balancing mechanism IMHO can rely only on averaging all requests and
doing round robin so that all mirrors are evenly loaded. If there's a
faster device in the mix, it'll process the IO faster and become less
loaded so it'll get more requests in turn.

I'd rather see a generic mechanism that would spread the load than doing
static checks if the device is or is not rotational. Though this is a
significant factor, it's not 100% reliable, eg. NBD or iscsi or other
layers between the physical device and what the fs sees.

So, the time based switching applies last, when the devices are
congested, evenly loaded by previous requests and further io needs to
maintain some balance.

Once this state is detected, time is saved and all new requests go to
one mirror. After a time passes, the mirrors are switched.

Chosing the right time is the question, starting with 1 second but not
than 5 is my first estimate.

Regarding the patches to select mirror policy, that Anand sent, I think
we first should provide a sane default policy that addresses most
commong workloads before we offer an interface for users that see the
need to fiddle with it.

> 
> Some bench results from mail list
> (Dmitrii Tcvetkov <demfloro@demfloro.ru>):
> Benchmark summary (arithmetic mean of 3 runs):
>          Mainline     Patch
> ------------------------------------
> RAID1  | 18.9 MiB/s | 26.5 MiB/s
> RAID10 | 30.7 MiB/s | 30.7 MiB/s
> ------------------------------------------------------------------------
> mainline, fio got lucky to read from first HDD (quite slow HDD):
> Jobs: 1 (f=1): [r(1)][100.0%][r=8456KiB/s,w=0KiB/s][r=264,w=0 IOPS]
>   read: IOPS=265, BW=8508KiB/s (8712kB/s)(499MiB/60070msec)
>   lat (msec): min=2, max=825, avg=60.17, stdev=65.06
> ------------------------------------------------------------------------
> mainline, fio got lucky to read from second HDD (much more modern):
> Jobs: 1 (f=1): [r(1)][8.7%][r=11.9MiB/s,w=0KiB/s][r=380,w=0 IOPS]
>   read: IOPS=378, BW=11.8MiB/s (12.4MB/s)(710MiB/60051msec)
>   lat (usec): min=416, max=644286, avg=42312.74, stdev=48518.56
> ------------------------------------------------------------------------
> mainline, fio got lucky to read from an SSD:
> Jobs: 1 (f=1): [r(1)][100.0%][r=436MiB/s,w=0KiB/s][r=13.9k,w=0 IOPS]
>   read: IOPS=13.9k, BW=433MiB/s (454MB/s)(25.4GiB/60002msec)
>   lat (usec): min=343, max=16319, avg=1152.52, stdev=245.36
> ------------------------------------------------------------------------
> With the patch, 2 HDDs:
> Jobs: 1 (f=1): [r(1)][100.0%][r=17.5MiB/s,w=0KiB/s][r=560,w=0 IOPS]
>   read: IOPS=560, BW=17.5MiB/s (18.4MB/s)(1053MiB/60052msec)
>   lat (usec): min=435, max=341037, avg=28511.64, stdev=30000.14
> ------------------------------------------------------------------------
> With the patch, HDD(old one)+SSD:
> Jobs: 1 (f=1): [r(1)][100.0%][r=371MiB/s,w=0KiB/s][r=11.9k,w=0 IOPS]
>   read: IOPS=11.6k, BW=361MiB/s (379MB/s)(21.2GiB/60084msec)
>   lat  (usec): min=363, max=346752, avg=1381.73, stdev=6948.32
> 
> Changes:
>   v1 -> v2:
>     - Use helper part_in_flight() from genhd.c
>       to get queue length
>     - Move guess code to guess_optimal()
>     - Change balancer logic, try use pid % mirror by default
>       Make balancing on spinning rust if one of underline devices
>       are overloaded
>   v2 -> v3:
>     - Fix arg for RAID10 - use sub_stripes, instead of num_stripes
>   v3 -> v4:
>     - Rebase on latest misc-next
>   v4 -> v5:
>     - Rebase on latest misc-next
>   v5 -> v6:
>     - Fix spelling
>     - Include bench results
>   v6 -> v7:
>     - Fixes based on Nikolay Borisov review:
>       * Assume num == 2
>       * Remove "for" loop based on that assumption, where possible
>   v7 -> v8:
>     - Add comment about magic '2' num in guess function
>   v8 -> v9:
>     - Rebase on latest misc-next
>     - Simplify code
>     - Use abs instead of round_down for approximation
>       Abs are more fair
> 
> Signed-off-by: Timofey Titovets <nefelim4ag@gmail.com>
> Tested-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
> ---
>  block/genhd.c      |  1 +
>  fs/btrfs/volumes.c | 88 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 703267865f14..fb35c85a7f42 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -84,6 +84,7 @@ unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
>  
>  	return inflight;
>  }
> +EXPORT_SYMBOL_GPL(part_in_flight);

This needs to be acked by block layer people, unless we find another way
to get the status of the devic regarding congestion. There is
bdi_congested but it's maybe to coarse for the decisions which device is
more congested.

Alternatively we can keep the stats inside btrfs_device.
