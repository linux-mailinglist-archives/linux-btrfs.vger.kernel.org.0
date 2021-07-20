Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC63CF5A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhGTHRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 03:17:31 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37224 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231201AbhGTHRM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 03:17:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UgP9.Mc_1626767868;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UgP9.Mc_1626767868)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 15:57:49 +0800
Date:   Tue, 20 Jul 2021 15:57:48 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210720075748.GJ60846@e18g06458.et15sqa>
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720064317.GC2031856@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 04:43:17PM +1000, Dave Chinner wrote:
[snip]
> 
> And given that it appears you haven't thought about maintaining a
> local repository of hooks, I strongly doubt you've even consider the
> impact of future changes to the hook API on existing hook scripts
> that devs and test engineers have written over months and years
> while debugging test failures.
> 
> Darrick pointed out the difference between running in the check vs
> test environment, which is something that is very much an API
> consideration - we change the test environment arbitrarily and fix
> all the tests that change affects at the same time. But if there are
> private scripts that depend on the test environment and variables
> being stable, then we can't do things like, say, rename the "seqres"
> variable across all tests because that will break every custom hook
> script out there that writes to $seqres.full...

I was thinking about this as well, if such private hook scripts are
useful to others as well, then I think maybe it's worth to maintain such
scripts in fstests repo, and further changes to the hook API won't break
the scripts

Thanks,
Eryu
