Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC59944BF19
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhKJK4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 05:56:01 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35865 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231148AbhKJK4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 05:56:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uvuz1IU_1636541591;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Uvuz1IU_1636541591)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Nov 2021 18:53:12 +0800
Date:   Wed, 10 Nov 2021 18:53:11 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: Test proper interaction between skip_balance
 and paused balance
Message-ID: <20211110105311.GW60846@e18g06458.et15sqa>
References: <20211108142901.1003352-1-nborisov@suse.com>
 <9a98623c-f34a-8a64-f211-18e3e3439078@oracle.com>
 <2e4207b5-0266-392e-39fd-1848632c93f8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e4207b5-0266-392e-39fd-1848632c93f8@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 12:07:37PM +0200, Nikolay Borisov wrote:
> <snip>
> 
> 
> >> +# titled "btrfs: allow device add if balance is paused"
> > 
> > It is a new feature, not a bug fix? The kernel patch won't backport to
> > the stable kernels. Then on older kernels, this test has to exit with
> > _notrun().
> > Is there any way to achieve this? There isn't any sysfs interface that
> > will help and, so far we haven't used the kernel version to achieve
> > something like this.
> > 
> 
> No, and this is outside the remit of xfstest. Anyone who is running
> xfstest should ensure incompatible tests are excluded.

I don't think that's the case, we perfer test case detect required env
to run the test and _notrun if any condition not met. For regression
test for bug fix, we want the test to fail on old/un-patched kernel, but
for new features we need a way to tell if the kernel in test has the
feature or not.

Thanks,
Eryu
