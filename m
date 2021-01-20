Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2529E2FCFE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbhATMSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:18:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:38902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731258AbhATK2t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:28:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2DE9AC63;
        Wed, 20 Jan 2021 10:28:06 +0000 (UTC)
Date:   Wed, 20 Jan 2021 10:27:56 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
Subject: Re: [PATCH v3 1/4] btrfs: add read_policy latency
Message-ID: <20210120102742.GA4584@wotan.suse.de>
References: <cover.1610324448.git.anand.jain@oracle.com>
 <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 11, 2021 at 05:41:34PM +0800, Anand Jain wrote:
> The read policy type latency routes the read IO based on the historical
> average wait-time experienced by the read IOs through the individual
> device. This patch obtains the historical read IO stats from the kernel
> block layer and calculates its average.
> 
> Example usage:
>  echo "latency" > /sys/fs/btrfs/$uuid/read_policy 
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: The block layer commit 0d02129e76ed (block: merge struct block_device and
>     struct hd_struct) has changed the first argument in the function
>     part_stat_read_all() in 5.11-rc1. So the compilation will fail. This patch
>     fixes it.
>     Commit log updated.
> 
> v2: Use btrfs_debug_rl() instead of btrfs_info_rl()
>     It is better we have this debug until we test this on at least few
>     hardwares.
>     Drop the unrelated changes.
>     Update change log.
> 
> v1: Drop part_stat_read_all instead use part_stat_read
>     Drop inflight
> 

Hi Anand,

I tested this policy with fio and dstat. It performs overall really
well. On my raid1c3 array with two HDDs and one SSD (which is the last
device), I'm getting the following results.

With direct=0:

  Run status group 0 (all jobs):
     READ: bw=3560MiB/s (3733MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
     io=3129GiB (3360GB), run=900003-900013msec

With direct=1:

  Run status group 0 (all jobs):
     READ: bw=520MiB/s (545MB/s), 64.9MiB/s-65.0MiB/s (68.1MB/s-68.2MB/s),
     io=457GiB (490GB), run=900001-900001msec

However, I was also running dstat at the same time and I noticed that
the read stop sometimes for ~15-20 seconds. For example:

  ----system---- --dsk/sdb-- --dsk/sdc-- --dsk/sdd--
  20-01 00:37:21|   0     0 :   0     0 : 509M    0
  20-01 00:37:22|   0     0 :   0     0 : 517M    0
  20-01 00:37:23|   0     0 :   0     0 : 507M    0
  20-01 00:37:24|   0     0 :   0     0 : 518M    0
  20-01 00:37:25|   0     0 :   0     0 :  22M    0
  20-01 00:37:26|   0     0 :   0     0 :   0     0
  20-01 00:37:27|   0     0 :   0     0 :   0     0
  20-01 00:37:28|   0     0 :   0     0 :   0     0
  20-01 00:37:29|   0     0 :   0     0 :   0     0
  20-01 00:37:30|   0     0 :   0     0 :   0     0
  20-01 00:37:31|   0     0 :   0     0 :   0     0
  20-01 00:37:32|   0     0 :   0     0 :   0     0
  20-01 00:37:33|   0     0 :   0     0 :   0     0
  20-01 00:37:34|   0     0 :   0     0 :   0     0
  20-01 00:37:35|   0     0 :   0     0 :   0     0
  20-01 00:37:36|   0     0 :   0     0 :   0     0
  20-01 00:37:37|   0     0 :   0     0 :   0     0
  20-01 00:37:38|   0     0 :   0     0 :   0     0
  20-01 00:37:39|   0     0 :   0     0 :   0     0
  20-01 00:37:40|   0     0 :   0     0 :   0     0
  20-01 00:37:41|   0     0 :   0     0 :   0     0
  20-01 00:37:42|   0     0 :   0     0 :   0     0
  20-01 00:37:43|   0     0 :   0     0 :   0     0
  20-01 00:37:44|   0     0 :   0     0 :   0     0
  20-01 00:37:45|   0     0 :   0     0 :   0     0
  20-01 00:37:46|   0     0 :   0     0 :  55M    0
  20-01 00:37:47|   0     0 :   0     0 : 516M    0
  20-01 00:37:48|   0     0 :   0     0 : 515M    0
  20-01 00:37:49|   0     0 :   0     0 : 516M    0
  20-01 00:37:50|   0     0 :   0     0 : 520M    0
  20-01 00:37:51|   0     0 :   0     0 : 520M    0
  20-01 00:37:52|   0     0 :   0     0 : 514M    0

Here is the full log:

https://susepaste.org/16928336

I never noticed that happening with the PID policy. Is that maybe
because of reading the part stats for all CPUs while selecting the
mirror?

Michal
