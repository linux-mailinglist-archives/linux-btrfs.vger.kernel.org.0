Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5717280F63
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgJBJBX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 05:01:23 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:53631 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJBX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 05:01:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437751|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.239847-0.00544084-0.754712;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Iek71fU_1601629279;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Iek71fU_1601629279)
          by smtp.aliyun-inc.com(10.147.41.143);
          Fri, 02 Oct 2020 17:01:19 +0800
Date:   Fri, 02 Oct 2020 17:01:25 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: simple Chunk allocator like calculation to replace Factor based calculation
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
In-Reply-To: <3cf4a1c4-b4a3-732d-6852-5b13e0cb1bf4@gmx.com>
References: <20201002095951.8454.409509F4@e16-tech.com> <3cf4a1c4-b4a3-732d-6852-5b13e0cb1bf4@gmx.com>
Message-Id: <20201002170124.20D8.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

We have another user case difficult to process.

Use case: 
Add 10T disk * 4  to near full  full RAID10 10T *4;
free space maybe be such as 10T,10T,10T,10T,2G,2G,2G,2G.

There maybe a lot of iterations for this case because of 2G chunk size,
and then result in bad performance?

Best Regards
王玉贵
2020/10/02

> 
> 
> On 2020/10/2 上午9:59, Wang Yugui wrote:
> > Hi,
> > 
> > 
> >>> such as
> >>> 1) RAID10 with 8T,1T,1T,1T,1T
> >>>     the virtal chunk size of 1st iteration:	1T or 0.33T?
> >>>     1T    chunk will use 4T at most
> >>>     0.33T chunk will use 5.33T at most?
> >>
> >> You didn't get the point.
> >> For the each loop we:
> >> - Sort the devices with their free space.
> >>   In this case, it's 8, 1, 1, 1, 1.
> >>
> >> - Round down to dev increament
> >>   Then we got 8, 1, 1, 1.
> >>
> >> - Then allocate chunk
> >>   Since the biggest unallocated space is 1T, we allocate a RAID10 with
> >>   1T stripe size, which will be a 2T chunk.
> >>
> >>   The remaining size is 7, 0, 0, 0, 1.
> > 
> > That is the problem.  1T chunk size is too big for this case.
> > 
> > if we use 1/3T chunk size, the result will be same as 1G chunk size.
> > 
> > 1st:	8T - 1/3T     2/3T, 2/3T, 2/3T, 1T
> > 2nd:	8T -2/3T     2/3T, 1/3T, 1/3T, 2/3T
> > 3rd:	8T -1T        1/3T, 1/3T, 0T, 1/3T
> > 4th:	8T -4/3T     0T,     0T,   0T,  0T
> 
> You're right, smaller balloon chunk size would make the allocation more
> accurate to real chunk allocator.
> 
> However that would slow down the calculation, don't forget that we need
> to run that calculation on each chunk allocation.
> Changing the balloon chunk allocation size dynamically may improve this.
> 
> But please also keep in mind that, with less and less space left, our
> predication will be more and more accurate, and under estimate is always
> less a problem.
> 
> So I'll keep your suggestion for future enhancement.
> 
> Thanks for pointing out the pitfall of current calculation,
> Qu
> 
> > 
> > Best Regards
> > 王玉贵
> > 2020/10/02
> > 
> >>
> >> - We go to next round.
> >>   No way to allocate new chunk.
> >>
> >> In this case, we can only get 2T chunk.
> >> Just as the chunk allocator do.
> >>
> >>>
> >>> 2) RAID10 with 8T,1T,1T,1T,0.5T
> >>>     the virtal chunk size of 1st iteration:0.5T or smaller?
> >>
> >> Still the same, 2T chunk can be allocated using the largest 4 devices.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Best Regards
> >>> 王玉贵
> >>> 2020/10/02
> >>>
> >>>
> >>> --------------------------------------
> >>> 北京京垓科技有限公司
> >>> 王玉贵	wangyugui@e16-tech.com
> >>> 电话：+86-136-71123776
> >>>
> >>
> > 
> > --------------------------------------
> > 北京京垓科技有限公司
> > 王玉贵	wangyugui@e16-tech.com
> > 电话：+86-136-71123776
> > 
> 

--------------------------------------
北京京垓科技有限公司
王玉贵	wangyugui@e16-tech.com
电话：+86-136-71123776

