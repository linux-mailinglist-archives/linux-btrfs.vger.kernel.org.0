Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03F3280C2D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 03:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbgJBB7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 21:59:50 -0400
Received: from out20-13.mail.aliyun.com ([115.124.20.13]:55541 "EHLO
        out20-13.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBB7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 21:59:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04940116|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.205686-0.00696449-0.787349;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IefMMEe_1601603987;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IefMMEe_1601603987)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 02 Oct 2020 09:59:47 +0800
Date:   Fri, 02 Oct 2020 09:59:52 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: simple Chunk allocator like calculation to replace Factor based calculation
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
In-Reply-To: <6941eed6-19a3-add6-6608-8a5d5ec86006@gmx.com>
References: <20201002093001.19E0.409509F4@e16-tech.com> <6941eed6-19a3-add6-6608-8a5d5ec86006@gmx.com>
Message-Id: <20201002095951.8454.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,


> > such as
> > 1) RAID10 with 8T,1T,1T,1T,1T
> >     the virtal chunk size of 1st iteration:	1T or 0.33T?
> >     1T    chunk will use 4T at most
> >     0.33T chunk will use 5.33T at most?
> 
> You didn't get the point.
> For the each loop we:
> - Sort the devices with their free space.
>   In this case, it's 8, 1, 1, 1, 1.
> 
> - Round down to dev increament
>   Then we got 8, 1, 1, 1.
> 
> - Then allocate chunk
>   Since the biggest unallocated space is 1T, we allocate a RAID10 with
>   1T stripe size, which will be a 2T chunk.
> 
>   The remaining size is 7, 0, 0, 0, 1.

That is the problem.  1T chunk size is too big for this case.

if we use 1/3T chunk size, the result will be same as 1G chunk size.

1st:	8T - 1/3T     2/3T, 2/3T, 2/3T, 1T
2nd:	8T -2/3T     2/3T, 1/3T, 1/3T, 2/3T
3rd:	8T -1T        1/3T, 1/3T, 0T, 1/3T
4th:	8T -4/3T     0T,     0T,   0T,  0T

Best Regards
王玉贵
2020/10/02

> 
> - We go to next round.
>   No way to allocate new chunk.
> 
> In this case, we can only get 2T chunk.
> Just as the chunk allocator do.
> 
> > 
> > 2) RAID10 with 8T,1T,1T,1T,0.5T
> >     the virtal chunk size of 1st iteration:0.5T or smaller?
> 
> Still the same, 2T chunk can be allocated using the largest 4 devices.
> 
> Thanks,
> Qu
> 
> > 
> > Best Regards
> > 王玉贵
> > 2020/10/02
> > 
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

