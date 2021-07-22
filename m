Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB693D25FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 16:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhGVOBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 10:01:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34346 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232427AbhGVOBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 10:01:10 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16MEfT9E009131
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 10:41:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 10B6315C37C0; Thu, 22 Jul 2021 10:41:29 -0400 (EDT)
Date:   Thu, 22 Jul 2021 10:41:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <YPmDmZL6oLnGhayx@mit.edu>
References: <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
 <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
 <20210721011105.GA2112234@dread.disaster.area>
 <ff57f17c-e3f2-14f3-42d8-fefaafd65637@gmx.com>
 <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210721232830.GC2112234@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721232830.GC2112234@dread.disaster.area>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 09:28:30AM +1000, Dave Chinner wrote:
> 
> I'm thinking that it is something relatively simple like this:
> 
> fstests/tests/hooks
> - directory containing library of hook scripts

I'd suggest fstests/common/hooks instead, since the hook scripts
aren't actually *tests* per so, but rather utility scripts, and common
would be a better place for it, I think.

> fstests/hooks/
> - directory containing symlinks to hook scripts

This might be a good default, but it might be better if the location
of the hook directory could be overridden via an environment variable.
In some cases, instead of having run-time configuration inside the
fstests directtory with .gitignore, it might be more convenient for it
if were made available externally (for example, via a 9p file system
in a case where tests are being run via KVM using a rootfs test image
with qmeu's snapshot mode so the hook directory could be supplied from
the host).

					- Ted
