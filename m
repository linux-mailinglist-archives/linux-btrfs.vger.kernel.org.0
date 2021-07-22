Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01313D2FCB
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhGVVlU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 17:41:20 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:37593 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhGVVlT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 17:41:19 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 64FE869F47;
        Fri, 23 Jul 2021 08:21:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m6h4g-009dXh-O0; Fri, 23 Jul 2021 08:21:50 +1000
Date:   Fri, 23 Jul 2021 08:21:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <20210722222150.GE2112234@dread.disaster.area>
References: <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
 <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
 <20210721011105.GA2112234@dread.disaster.area>
 <ff57f17c-e3f2-14f3-42d8-fefaafd65637@gmx.com>
 <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210721232830.GC2112234@dread.disaster.area>
 <YPmDmZL6oLnGhayx@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPmDmZL6oLnGhayx@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=kj9zAlcOel0A:10 a=e_q4qTt1xDgA:10 a=7-415B0cAAAA:8
        a=nZ5yuoXW5wKvLTnfgwkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 10:41:29AM -0400, Theodore Ts'o wrote:
> On Thu, Jul 22, 2021 at 09:28:30AM +1000, Dave Chinner wrote:
> > 
> > I'm thinking that it is something relatively simple like this:
> > 
> > fstests/tests/hooks
> > - directory containing library of hook scripts
> 
> I'd suggest fstests/common/hooks instead, since the hook scripts
> aren't actually *tests* per so, but rather utility scripts, and common
> would be a better place for it, I think.

True, but I don't think common/ is the right place, either, because
that's for common test infrastructure. I only just looked, but
there's a lib/ directory in fstests.  lib/hooks seems like the right
place for this, and if I had of looked yesterday I would have put it
there from the start. :/

Is that an acceptible location?

> > fstests/hooks/
> > - directory containing symlinks to hook scripts
> 
> This might be a good default, but it might be better if the location
> of the hook directory could be overridden via an environment variable.
> In some cases, instead of having run-time configuration inside the
> fstests directtory with .gitignore, it might be more convenient for it
> if were made available externally (for example, via a 9p file system
> in a case where tests are being run via KVM using a rootfs test image
> with qmeu's snapshot mode so the hook directory could be supplied from
> the host).

Yup, that's easy enough to do. We can do it exactly the same way we
allow RESULT_BASE to point the results to a user defined directory.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
