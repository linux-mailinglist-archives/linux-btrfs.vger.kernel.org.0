Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D318280BF7
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgJBBaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 21:30:00 -0400
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:38291 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBBaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 21:30:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05875288|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0749051-0.00313714-0.921958;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.IeedwH-_1601602196;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IeedwH-_1601602196)
          by smtp.aliyun-inc.com(10.147.41.121);
          Fri, 02 Oct 2020 09:29:57 +0800
Date:   Fri, 02 Oct 2020 09:30:02 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: simple Chunk allocator like calculation to replace Factor based calculation
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
In-Reply-To: <7b8600fa-e04e-2b87-3ddb-ba16d4f2824f@suse.com>
References: <20201001233649.888B.409509F4@e16-tech.com> <7b8600fa-e04e-2b87-3ddb-ba16d4f2824f@suse.com>
Message-Id: <20201002093001.19E0.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Qu Wenruo

> On 2020/10/1 下午11:36, Wang Yugui wrote:
> > Hi, Qu Wenruo
> > 
> > Chunk allocator like calculation will get the right value, but it is
> > slow for big file system such as 500T.
> 
> Nope, the ballon allocator doesn't have any size limit, thus it will try
> to use as much space as possible in a single run.
> 
> If the 500T fs only has say 100T used, and the remaining 400T is split
> into, say 2 parts, then just two small run would finish.
> 
> On the other hand, if the 500T is mostly used, only 100T unallocated and
> the 100T is in a big unallocate chunk (under most cases it's true), then
> just one allocation run is enough.
> 
> So in short, it's unrelated to the fs, but how fragmented the
> unallocated space is.
> And normally unallocated space is not fragmented at all, thus it's very
> speedy.

We need some more complex example for 'Chunk allocator like calculation'
to make it easy to understand.

such as
1) RAID10 with 8T,1T,1T,1T,1T
    the virtal chunk size of 1st iteration:	1T or 0.33T?
    1T    chunk will use 4T at most
    0.33T chunk will use 5.33T at most?

2) RAID10 with 8T,1T,1T,1T,0.5T
    the virtal chunk size of 1st iteration:0.5T or smaller?

Best Regards
王玉贵
2020/10/02


--------------------------------------
北京京垓科技有限公司
王玉贵	wangyugui@e16-tech.com
电话：+86-136-71123776

