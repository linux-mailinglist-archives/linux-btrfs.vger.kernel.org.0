Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4712F318F46
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhBKP6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 10:58:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:46032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhBKP42 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 10:56:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9195B077;
        Thu, 11 Feb 2021 15:55:34 +0000 (UTC)
Date:   Thu, 11 Feb 2021 15:55:33 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
Message-ID: <20210211155533.GB1263@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-7-mrostecki@suse.de>
 <c2cbf3a7-3db2-afae-4984-450e758f4987@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2cbf3a7-3db2-afae-4984-450e758f4987@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 04:20:20PM +0800, Anand Jain wrote:
> On 10/02/2021 04:30, Michal Rostecki wrote:
> > The penalty value is an additional value added to the number of inflight
> > requests when a scheduled request is non-local (which means it would
> > start from the different physical location than the physical location of
> > the last request processed by the given device). By default, it's
> > applied only in filesystems which have mixed types of devices
> > (non-rotational and rotational), but it can be configured to be applied
> > without that condition.
> > 
> > The configuration is done through sysfs:
> > > - /sys/fs/btrfs/[fsid]/read_policies/roundrobin_nonlocal_inc_mixed_only
> > 
> > where 1 (the default) value means applying penalty only in mixed arrays,
> > 0 means applying it unconditionally.
> >
> > The exact penalty value is defined separately for non-rotational and
> > rotational devices. By default, it's 0 for non-rotational devices and 1
> > for rotational devices. Both values are configurable through sysfs:
> > 
> > - /sys/fs/btrfs/[fsid]/read_policies/roundrobin_nonrot_nonlocal_inc
> > - /sys/fs/btrfs/[fsid]/read_policies/roundrobin_rot_nonlocal_inc
> > 
> > To sum it up - the default case is applying the penalty under the
> > following conditions:
> > 
> > - the raid1 array consists of mixed types of devices
> > - the scheduled request is going to be non-local for the given disk
> > - the device is rotational
> >
> > That default case is based on a slight preference towards non-rotational
> > disks in mixed arrays and has proven to give the best performance in
> > tested arrays.
> >> For the array with 3 HDDs, not adding any penalty resulted in 409MiB/s
> > (429MB/s) performance. Adding the penalty value 1 resulted in a
> > performance drop to 404MiB/s (424MB/s). Increasing the value towards 10
> > was making the performance even worse.
> > 
> > For the array with 2 HDDs and 1 SSD, adding penalty value 1 to
> > rotational disks resulted in the best performance - 541MiB/s (567MB/s).
> > Not adding any value and increasing the value was making the performance
> > worse.
> > > Adding penalty value to non-rotational disks was always decreasing the
> > performance, which motivated setting it as 0 by default. For the purpose
> > of testing, it's still configurable.
> >
> > To measure the performance of each policy and find optimal penalty
> > values, I created scripts which are available here:
> > 
> 
> So in summary
>  rotational + non-rotational: penalty = 1
>  all-rotational and homo    : penalty = 0
>  all-non-rotational and homo: penalty = 0
> 
> I can't find any non-deterministic in your findings above.
> It is not very clear to me if we need the configurable
> parameters here.
> 

Honestly, the main reason why I made it configurable is to check the
performance of different values without editing and recompiling the
kernel. I was trying to find the best set of values with my simple Python
script which tries all values from 0 to 9 and runs fio. I left those
partameters to be configurable in my patches just in case someone else
would like to try to tune them on their environments.

The script is here:

https://github.com/mrostecki/btrfs-perf/blob/main/roundrobin-tune.py

But on the other hand, as I mentioned in the other mail - I'm getting
skeptical about having the whole penalty mechanism in general. As I
wrote and as you pointed, it improves the performance only for mixed
arrays. And since the roundrobin policy doesn't perform on mixed as good
as policies you proposed, but it performs good on homogeneous arays,
maybe it's better if I just focus on homogeneous case, and save some CPU
cycles by not storing physical locations.

> It is better to have random workloads in the above three categories
> of configs.
> 
> Apart from the above three configs, there is also
>  all-non-rotational with hetero
> For example, ssd and nvme together both are non-rotational.
> And,
>  all-rotational with hetero
> For example, rotational disks with different speeds.
> 
> 
> The inflight calculation is local to btrfs. If the device is busy due to
> external factors, it would not switch to the better performing device.
> 

Good point. Maybe I should try to use the part stats instead of storing
inflight locally in btrfs.
