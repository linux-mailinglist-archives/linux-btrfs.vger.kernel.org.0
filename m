Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8AFE5E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 20:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKOTrL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 14:47:11 -0500
Received: from dc2.fullpliant.org ([213.186.44.166]:55366 "HELO
        dc2.fullpliant.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726550AbfKOTrL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 14:47:11 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 14:47:10 EST
Date:   Fri, 15 Nov 2019 20:41:21 +0000
From:   Hubert Tonneau <hubert.tonneau@fullpliant.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Avoiding BRTFS RAID5 write hole
Message-ID: <hubert_tonneau/4RYCU6X4/0JGEB54@hubert-tonneau.storga.com>
In-Reply-To: <7723feea-c3cd-b1eb-b882-aa782bbc6e2a@libero.it>
References: <0JGAX5Q12@briare1.fullpliant.org> <7723feea-c3cd-b1eb-b882-aa782bbc6e2a@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo Baroncelli wrote:
>
> Why do you think that this approach is more IO expensive ?
> 
> Supposing to have n+1 disks, configured as raid5 Raid5
> 
> The problem is only when you have to update a portion of stripe. So I consider of an amount of data in the range 0..n -> n/2 in average (I omit the size of the disk-stripe which is constant)

Your approche is way too optimistic.
If the application is doing random writes on a nocow file, or doing append sync append sync append sync on a log, then it will rather be something like n/10 (10 is arbitrary number, but it will be much more than 2)

> 1) stripe update in place (current BTRFS behavior)
> The data to write is  ~ n/2 +1 (in average half of the stripe size + parity)

You have forgotten that you have to do a read of the parity before being abble to write, and this is what is going to take the server to a crawl if it does not write full RAID5 stripes.

> 2) COW stripe (my idea)
> The data to write is ~ n + 1 (the full stripe size + parity)

Same, you have to do read before write, in order to get the unchanged part of the stripe.

> 3) Your solution (cache in RAID1)
> The data to write is
> 	a) write data to raid1: ~ n/2 * 2 = n (data written on two disks)
> 	b) update the RAID5 stripe: ~ n/2 + 1
> 
> Total:	~ 3 * n/2 + 1

Your count shows that I did not express properly what I'm suggesting. Sorry about that.
What I'm suggesting, with something closer to your wording, is
a) copy the RAID5 stripe to a new RAID1 one at a different place: n * 2 (and need to read before write)
b) in place overwrite the new RAID1 stripe: n/2 * 2
Of course, you could optimize and do a) and b) in one step, so the overall cost would be n * 2 instead of n * 3
What is important is that what I'm suggesting is to NEVER update in place a RAID5 stripe. If you need to update a RAID5 stripe, first turn it to some RAID stripes at a different place of the disks. This is what a) does.
Also, since all active parts are already RAID1, a) is a fairly rare operation.

---

Let me get back to the basic:
With RAID5, if you want good performances and data safety, you have to do only full new stripes writes (no in place overwrite), because it avoids the read before write need, and the write hole.
It means that you need variable size stripes. This is ZFS way, as far as I understand it, and it brings a lot of complexity and makes it harder to deal with fragmentation, so this is what we would like to avoid it for BTRFS.

On the other hand, with RAID1, you can update in place, so everything is simple and fast.
This is why current BTRFS RAID1 is satisfying.
Only large file sequencial write on RAID5 is faster than RAID1, but we can assume that if people switch to RAID5, for all but very special use cases, it is not for faster sequencial write speed, but for more storage space available to the application.

As a summary, the only problem with current RAID1 BTRFS implementation, is that it provides a poor usable versus raw disk space ratio, just as any pure RAID1 implementation.
So, I see RAID5 as just a way to improve this ratio (same for RAID6 and RAID1C3).
That is why you need a background process that will select some large files that don't have the nocow flag set, and convert (not in place) them from RAID1 to RAID5 in order to consume less disk space.
The same process should convert (not in place) the file from RAID5 to RAID1 if the nocow flag has been set.
For any new files, use RAID1.
This is also why a) costy operation will be rare.
In the end, you get RAID1 performances and data safety, but a better usable versus raw disk space ratio, and this is just what most of us expect from the filesystem.
