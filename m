Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0832900C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 13:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfHPLaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 07:30:22 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49362 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbfHPLaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 07:30:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TZd4xOn_1565955018;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TZd4xOn_1565955018)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Aug 2019 19:30:18 +0800
Date:   Fri, 16 Aug 2019 19:30:18 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] fstests: btrfs: Check snapshot creation and deletion
 with dm-logwrites
Message-ID: <20190816113018.GJ52397@e18g06458.et15sqa>
References: <20190814105544.18318-1-wqu@suse.com>
 <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
 <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 16, 2019 at 05:47:33PM +0800, Qu Wenruo wrote:
[...]
> >> +$KILLALL_PROG -q $FSSTRESS_PROG &> /dev/null
> > 
> > You're very inconsistent within the same test :) Using both ">
> > /dev/null 2>&1" and "&> /dev/null".
> 
> My bad, I mean 2>&1 > /dev/null.
> What I mean is output stderr while skip stdout in previous calls.

Then just do "2>/dev/null", the test harness will capture both stdout
and stderr. "2>&1 > /dev/null" is less used and usually indicates a
mis-usage :)

Thanks,
Eryu
