Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0CE2810BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgJBKvr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJBKvr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 06:51:47 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D7C0613D0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Oct 2020 03:51:46 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kOI3t-0004FQ-IB; Fri, 02 Oct 2020 11:13:13 +0100
Date:   Fri, 2 Oct 2020 11:13:13 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: simple Chunk allocator like calculation to replace Factor based
 calculation
Message-ID: <20201002101313.GJ3679@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201002095951.8454.409509F4@e16-tech.com>
 <3cf4a1c4-b4a3-732d-6852-5b13e0cb1bf4@gmx.com>
 <20201002170614.65B5.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002170614.65B5.409509F4@e16-tech.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

   We can do this calculation precisely, in at most O(n^2) time, where
n is the number of *devices* in the FS.

Inner step:

   Let s be the number of devices allocated in a single allocation step(*).

   Sort the n devices in decreasing order of size, c[i].

   For each device i, let b[i] = floor(sum c[j] / (s-i)), where the
      sum is taken over all devices smaller than i.

   Throw out values of b[i] where c[i] < b[i].

   Let B = floor(sum c[j] / n), where the sum is taken over all devices.

   Let t_max be the smallest value of B and the remaining b[i].

   t_max is the number of allocations that can be performed on the
   filesystem using an allocation size of s.

Outer step:

   If the RAID level has a fixed s value, run the inner step and stop.

   If the RAID level can vary, run the inner step, setting s to the
   number of devices with free space on at each iteration.


(*) single:       s = 1
    RAID1(c3,c4): s = 2(,3,4)
    RAID10:       s = 4
    RAID0,5,6:    s = the number of devices with free space

   This is the algorithm used in the carfax btrfs-usage calculator,
and has been fairly comprehensively battle-tested over the years,
although I was unable to prove its correctness mathematically.

   Hugo.

On Fri, Oct 02, 2020 at 05:06:14PM +0800, Wang Yugui wrote:
> Hi,
> 
> We have another user case difficult to process.
> 
> #with a fix of RAID10 to RAID1C4
> #for RAID10, the iteration number is not big.
> #but for RAID1C4,the iteration number is big.
> 
> Use case: 
> Add 10T disk * 4  to near full  full RAID1C4 10T *4;
> free space maybe be such as 10T,10T,10T,10T,2G,2G,2G,2G.
> 
> There maybe a lot of iterations for this case because of 2G chunk size,
> and then result in bad performance?
> 
> 
> Best Regards
> 王玉贵
> 2020/10/02
> 
> > 
> > 
> > On 2020/10/2 上午9:59, Wang Yugui wrote:
> > > Hi,
> > > 
> > > 
> > >>> such as
> > >>> 1) RAID10 with 8T,1T,1T,1T,1T
> > >>>     the virtal chunk size of 1st iteration:	1T or 0.33T?
> > >>>     1T    chunk will use 4T at most
> > >>>     0.33T chunk will use 5.33T at most?
> > >>
> > >> You didn't get the point.
> > >> For the each loop we:
> > >> - Sort the devices with their free space.
> > >>   In this case, it's 8, 1, 1, 1, 1.
> > >>
> > >> - Round down to dev increament
> > >>   Then we got 8, 1, 1, 1.
> > >>
> > >> - Then allocate chunk
> > >>   Since the biggest unallocated space is 1T, we allocate a RAID10 with
> > >>   1T stripe size, which will be a 2T chunk.
> > >>
> > >>   The remaining size is 7, 0, 0, 0, 1.
> > > 
> > > That is the problem.  1T chunk size is too big for this case.
> > > 
> > > if we use 1/3T chunk size, the result will be same as 1G chunk size.
> > > 
> > > 1st:	8T - 1/3T     2/3T, 2/3T, 2/3T, 1T
> > > 2nd:	8T -2/3T     2/3T, 1/3T, 1/3T, 2/3T
> > > 3rd:	8T -1T        1/3T, 1/3T, 0T, 1/3T
> > > 4th:	8T -4/3T     0T,     0T,   0T,  0T
> > 
> > You're right, smaller balloon chunk size would make the allocation more
> > accurate to real chunk allocator.
> > 
> > However that would slow down the calculation, don't forget that we need
> > to run that calculation on each chunk allocation.
> > Changing the balloon chunk allocation size dynamically may improve this.
> > 
> > But please also keep in mind that, with less and less space left, our
> > predication will be more and more accurate, and under estimate is always
> > less a problem.
> > 
> > So I'll keep your suggestion for future enhancement.
> > 
> > Thanks for pointing out the pitfall of current calculation,
> > Qu
> > 
> > > 
> > > Best Regards
> > > 王玉贵
> > > 2020/10/02
> > > 
> > >>
> > >> - We go to next round.
> > >>   No way to allocate new chunk.
> > >>
> > >> In this case, we can only get 2T chunk.
> > >> Just as the chunk allocator do.
> > >>
> > >>>
> > >>> 2) RAID10 with 8T,1T,1T,1T,0.5T
> > >>>     the virtal chunk size of 1st iteration:0.5T or smaller?
> > >>
> > >> Still the same, 2T chunk can be allocated using the largest 4 devices.
> > >>
> > >> Thanks,
> > >> Qu
> > >>
> > >>>
> > >>> Best Regards
> > >>> 王玉贵
> > >>> 2020/10/02
> > >>>
> > >>>
> > >>> --------------------------------------
> > >>> 北京京垓科技有限公司
> > >>> 王玉贵	wangyugui@e16-tech.com
> > >>> 电话：+86-136-71123776
> > >>>
> > >>
> > > 
> > > --------------------------------------
> > > 北京京垓科技有限公司
> > > 王玉贵	wangyugui@e16-tech.com
> > > 电话：+86-136-71123776
> > > 
> > 
> 
> --------------------------------------
> 北京京垓科技有限公司
> 王玉贵	wangyugui@e16-tech.com
> 电话：+86-136-71123776
> 

-- 
Hugo Mills             | Turning, pages turning in the widening bath,
hugo@... carfax.org.uk | The spine cannot bear the humidity.
http://carfax.org.uk/  | Books fall apart; the binding cannot hold.
PGP: E2AB1DE4          | Page 129 is loosed upon the world.               Zarf
