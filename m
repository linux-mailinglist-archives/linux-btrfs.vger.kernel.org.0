Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422DE13870
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2019 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEDJbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 4 May 2019 05:31:20 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:60391 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEDJbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 May 2019 05:31:19 -0400
X-Greylist: delayed 138511 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 May 2019 05:31:18 EDT
Received: from [94.217.144.7] (helo=[192.168.177.20])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hMr0m-0008KV-3A; Sat, 04 May 2019 11:31:16 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Chris Murphy" <lists@colorremedies.com>
Subject: Re[4]: Rough (re)start with btrfs
Cc:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        "Chris Murphy" <lists@colorremedies.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Sat, 04 May 2019 09:31:10 +0000
Message-Id: <emebc18462-5243-43f8-be24-79a932d90a57@ryzen>
In-Reply-To: <CAJCQCtTHFi8uR1JndoXju0HvfGvBwXK6Pq4oqJiop82FaT_J-A@mail.gmail.com>
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
 <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
 <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
 <CAJCQCtTHFi8uR1JndoXju0HvfGvBwXK6Pq4oqJiop82FaT_J-A@mail.gmail.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

this:
 >Some prefer bug report in mail list directly like me, some prefer 
kernel
 >bugzilla.

and this:
 >Not sure if other is looking into this.
 >Btrfs bug tracking is somewhat tricky.

may be related...


 >Not likely. You can do a scrub to check for metadata and data
 >corruption.

Did that. All good.

 >And you can do an offline (unmounted) 'btrfs check
 >--readonly' to check the validity of the metadata.

Will do that.

 > The Btrfs call
 >traces during the blocked task are INFO, not warnings or errors, so
 >the file system and data is likely fine. There's no read, write,
 >corruption, or generation errors in the dmesg; but you can also check
 >'btfs dev stats <mountpoint>' which is a persistent counter for this
 >particular device.
[/dev/sdh1].write_io_errs 0
[/dev/sdh1].read_io_errs 0
[/dev/sdh1].flush_io_errs 0
[/dev/sdh1].corruption_errs 0
[/dev/sdh1].generation_errs 0


 >I should have read this before replying earlier.
 >
 >You can also do a one time clean mount with '-o
 >clear_cache,space_cache=v2' which will remove the v1 (default) space
 >cache, and create a v2 cache. Subsequent mount will see the flag for
 >this feature and always use the v2 cache. It's a totally differently
 >implementation and shouldn't have this problem.

So, you have a suspicion already about what caused the problem? Why is 
v2 then not default? Is it worth chasing the Bug in v1?
For me, the question now is, whether we should chase this Bug or not. I 
encountered it three times while filling a 8TB drive with 7TB. Now, I 
have 1TB left and I am not sure I can reproduce, but I can try.

 >Qu would know better but usually developers ask for sysrq+w when
 >there's blocked tasks.

I am wondering, whether there is a -long term- a better way than this. 
Ideally, btrfs would automatically create a 
btrfs-bug-DD-MM-YY-hh-mm-ss.tar.gz with all the info you need and inform 
the User about it and where to issue the bug. I am aware that this is 
tricky. But in order to further mature btrfs, I assume you need more 
real life data with good quality (that is, the right logs) without too 
much work (asking for logs). What's your view on this?

 >You know what? Try changing the scheduler from mq-deadline to none.
 >Change nothing else. Now try to reproduce. Let's see if it still
 >happens.

Wouldn't it make sense first to try to reproduce without changing 
anything?

 >Also, what are the mount options?
rw,noatime,nospace_cache,subvolid=5,subvol=/
But noatime and nospace_cache I added just today.

Greetings,
Hendrik

