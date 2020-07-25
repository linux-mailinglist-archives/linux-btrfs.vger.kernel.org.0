Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115CB22D879
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgGYPhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 11:37:54 -0400
Received: from mail.itouring.de ([188.40.134.68]:35398 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGYPhy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 11:37:54 -0400
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id 4F1524160251;
        Sat, 25 Jul 2020 17:37:53 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id E667CF01600;
        Sat, 25 Jul 2020 17:37:52 +0200 (CEST)
Subject: Re: Debugging abysmal write performance with 100% cpu
 kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <6b4041a7-cbf7-07b6-0f30-8141d60a7d51@applied-asynchrony.com>
Date:   Sat, 25 Jul 2020 17:37:52 +0200
MIME-Version: 1.0
In-Reply-To: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-25 16:24, Hans van Kranenburg wrote:
> Hi,
> 
> I have a filesystem here that I'm filling up with data from elsewhere.
> Most of it is done by rsync, and part by send/receive. So, receiving
> data over the network, and then writing the files to disk. There can be
> a dozen of these processes running in parallel.
> 
> Now, when doing so, the kworker/u16:X+flush-btrfs-2 process (with
> varying X) often is using nearly 100% cpu, while enormously slowing down
> disk writes. This shows as disk IO wait for the rsync and btrfs receive
> processes.

<snip>

I cannot speak to anything btrfs-specific (other than the usual write
storms), however..

> [<0>] rq_qos_wait+0xfa/0x170
> [<0>] wbt_wait+0x98/0xe0
> [<0>] __rq_qos_throttle+0x23/0x30

..this means that you have CONFIG_BLK_WBT{_MQ} enabled and are using
an IO scheduler that observes writeback throttling. AFAIK all MQ-capable
schedulers (also SQ ones in 4.19 IIRC!) do so except for BFQ, which has
its own mechanism to regulate fairness vs. latency and explicitly turns
WBT off.

WBT aka 'writeback throttling' throttles background writes acording to
latency/throughput of the underlying block device in favor of readers.
It is meant to protect interactive/low-latency/desktop apps from heavy
bursts of background writeback activity. I tested early versions and
provided feedback to Jens Axboe; it really is helpful when it works,
but obviously cannot cater to every situation. There have been reports
that it is unhelpful for write-only/heavy workloads and may lead to
queueing pileup.

You can tune the expected latency of device writes via:
/sys/block/sda/queue/wbt_lat_usec.

You might also check whether your vm.dirty_{background}_bytes and
vm.dirty_expire_centisecs are too high; distro defaults almost always
are. This leads to more evenly spaced out write traffic.

Without knowing more it's difficult to say exactly what is going on,
but if your underlying storage has latency spikes it might be that
you are very likely looking at queueing pileup caused by multiple WBTs
choking each other. Having other unrelated queueing & throttling
mechanisms (in your case the network) in the mix is unlikely to help.
I'm not going to comment on iSCSI in general.. :^)

OTOH I also have 10G networking here and no such problems, even when
pushing large amounts of data over NFS at ~750 MB/s - and I have WBT
enabled everywhere.

So maybe start small and either ramp up the wbt latency sysctl or
decrease dirty_background bytes to start flushing sooner, depending
on how it's set. As last resort you can rebuild your kernels with
CONFIG_BLK_WBT/CONFIG_BLK_WBT_MQ disabled.

Hope this helps!

-h
