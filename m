Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0385122D99D
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 21:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGYToK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 15:44:10 -0400
Received: from mail.itouring.de ([188.40.134.68]:36118 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgGYToK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 15:44:10 -0400
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id 2E196416C823;
        Sat, 25 Jul 2020 21:44:08 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id AEF95F01600;
        Sat, 25 Jul 2020 21:44:07 +0200 (CEST)
Subject: Re: Debugging abysmal write performance with 100% cpu
 kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
 <6b4041a7-cbf7-07b6-0f30-8141d60a7d51@applied-asynchrony.com>
 <4771c445-dcb4-77c4-7cb6-07a52f8025f6@knorrie.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <d3be20df-2f97-6fa8-7050-7315f7ab27a5@applied-asynchrony.com>
Date:   Sat, 25 Jul 2020 21:44:07 +0200
MIME-Version: 1.0
In-Reply-To: <4771c445-dcb4-77c4-7cb6-07a52f8025f6@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-25 18:43, Hans van Kranenburg wrote:
> On 7/25/20 5:37 PM, Holger Hoffstätte wrote:
>>> [<0>] rq_qos_wait+0xfa/0x170
>>> [<0>] wbt_wait+0x98/0xe0
>>> [<0>] __rq_qos_throttle+0x23/0x30
> 
> I need to cat /proc/<pid>/stack a huge number of times in a loop to once
> in a while get this sort of output shown.

Ahh! So that means you are just getting lucky and catch the occasional
throttle in action. Ok.

>> You can tune the expected latency of device writes via:
>> /sys/block/sda/queue/wbt_lat_usec.
> 
> Yes, I have been playing around with it earlier, without any effect on
> the symptoms.
> 
> I just did this again, echo 0 > all of the involved block devices. When
> looking at the events/wbt trace point, I see that wbt activity stops at
> that moment.
> 
> No difference in symptoms.

Ok. Worth a shot..but in retrospect not really, since I just realized
that I had your entire scenario backwards. Nevermind then.

> Dirty buffers were ~ 2G in size. I can modify the numbers to make it
> bigger or smaller. There's absolutely no change in behavior of the system.

Ok. I also have 2GB max-dirty and 1GB writeback-dirty, which is
plenty for a 10G pipe.

> It doesn't. It's idle, waiting to finally get some data sent to it.

Yup, looks like it.

> All processing speed is inversely proportional to the cpu usage of this
> kworker/u16:X+flush-btrfs-2 thread. If it reaches >95% kernel cpu usage,
> everything slows down. The network is idle, the disks are idle. Incoming
> rsync speed drops, the speed in which btrfs receive is reading input
> drops, etc. As soon as kworker/u16:X+flush-btrfs-2 busy cpu usage gets
> below ~ 95% again, throughput goes up.

Only thing I can think of is that your rsync runs create insane amounts
of small COW extents that need to be ordered/merged. Multiply by number of
processes and you're probably hitting some super contended part. Since
the kworker isn't stuck forever but apparently makes progress it's not
dead, just slow/overloaded.

A few years ago I started using rsync exclusively with --whole-file since
it's not just much faster but also creates significantly less fragmentation
at the expense of some disk space, but whatever...in my case snapshot rotation
takes care of that. Maybe it's an option for you.

So maybe things to try:

- run rsync with --whole-file
- run fewer rsyncs in parallel (might not be necessary with --whole-file!)

If that doesn't help someone else needs to chime in..

-h
