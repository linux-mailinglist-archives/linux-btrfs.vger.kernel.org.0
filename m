Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4F3D33C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 06:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhGWDvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 23:51:51 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39834 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231760AbhGWDvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 23:51:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UggEgt-_1627014743;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UggEgt-_1627014743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Jul 2021 12:32:23 +0800
Date:   Fri, 23 Jul 2021 12:32:23 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210723043223.GK60846@e18g06458.et15sqa>
References: <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
 <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
 <20210721011105.GA2112234@dread.disaster.area>
 <ff57f17c-e3f2-14f3-42d8-fefaafd65637@gmx.com>
 <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210721232830.GC2112234@dread.disaster.area>
 <YPmDmZL6oLnGhayx@mit.edu>
 <20210722222150.GE2112234@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722222150.GE2112234@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 23, 2021 at 08:21:50AM +1000, Dave Chinner wrote:
> On Thu, Jul 22, 2021 at 10:41:29AM -0400, Theodore Ts'o wrote:
> > On Thu, Jul 22, 2021 at 09:28:30AM +1000, Dave Chinner wrote:
> > > 
> > > I'm thinking that it is something relatively simple like this:
> > > 
> > > fstests/tests/hooks
> > > - directory containing library of hook scripts
> > 
> > I'd suggest fstests/common/hooks instead, since the hook scripts
> > aren't actually *tests* per so, but rather utility scripts, and common
> > would be a better place for it, I think.

Agreed, then we could avoid naming hooks dir as "Hooks".

> 
> True, but I don't think common/ is the right place, either, because
> that's for common test infrastructure. I only just looked, but
> there's a lib/ directory in fstests.  lib/hooks seems like the right
> place for this, and if I had of looked yesterday I would have put it
> there from the start. :/
> 
> Is that an acceptible location?

Right now the lib dir contains mainly c libs used by test binaries, it
looks like part of the build infrastructure to me. OTOH, I think
common/hooks is fine, as hooks is part of the test harness to me. Or
maybe tools/hooks is another choice?

Thanks,
Eryu

> 
> > > fstests/hooks/
> > > - directory containing symlinks to hook scripts
> > 
> > This might be a good default, but it might be better if the location
> > of the hook directory could be overridden via an environment variable.
> > In some cases, instead of having run-time configuration inside the
> > fstests directtory with .gitignore, it might be more convenient for it
> > if were made available externally (for example, via a 9p file system
> > in a case where tests are being run via KVM using a rootfs test image
> > with qmeu's snapshot mode so the hook directory could be supplied from
> > the host).
> 
> Yup, that's easy enough to do. We can do it exactly the same way we
> allow RESULT_BASE to point the results to a user defined directory.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
