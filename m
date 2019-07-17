Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1F6BF5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 17:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfGQPyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 11:54:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:9938 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfGQPyD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 11:54:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 08:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="158501543"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2019 08:53:54 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hnmFc-00012I-Uo; Wed, 17 Jul 2019 18:53:52 +0300
Date:   Wed, 17 Jul 2019 18:53:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] uuid: Add inline helpers to operate on raw buffers
Message-ID: <20190717155352.GX9224@smile.fi.intel.com>
References: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
 <20190716151133.GA6073@lst.de>
 <20190716152222.GJ9224@smile.fi.intel.com>
 <20190717153706.GJ20977@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717153706.GJ20977@suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 17, 2019 at 05:37:06PM +0200, David Sterba wrote:
> On Tue, Jul 16, 2019 at 06:22:22PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 16, 2019 at 05:11:33PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 16, 2019 at 06:04:16PM +0300, Andy Shevchenko wrote:

> > > I hate this raw naming.  If people really want to use the generators on
> > > u8 fields a cast seems more descriptive then hiding it.
> > 
> > This entire patch because of BTRFS maintainers, they didn't want the explicit
> > casts. Maybe something has been changed, I dunno.
> 
> No change on our side. The uuids are u8 in the on-disk structures, that
> will stay. The uuid functions use a different type so the casts have to
> be added, that's clear. The question is if it's up to the API to provide
> functions that take u8, or btrfs code to put typecasts everywhere or
> carry own wrappers that do that.
> 
> I tend to avoid the explicit typecasts for widely used functions because
> it's easy to forget them, and it overrides the type checks (that could
> be caught by compiler but also not).
> 
> Specifically for uuid, the endianness might matter, so that we use the
> raw buffers makes things more explicit.

Thank you for the information.

Can you review v3 of the series where I attempted to satisfy everybody, Chris
in his wish to not do ugly raw generators and Btrfs by providing minimum needed
API helpers?

-- 
With Best Regards,
Andy Shevchenko


