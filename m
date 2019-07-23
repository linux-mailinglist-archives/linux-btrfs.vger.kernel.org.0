Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C071D9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfGWRYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 13:24:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:11182 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGWRYd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 13:24:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 10:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="193136667"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2019 10:24:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpyWc-0005zk-0d; Tue, 23 Jul 2019 20:24:30 +0300
Date:   Tue, 23 Jul 2019 20:24:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/4] Btrfs: Switch to use new generic UUID API
Message-ID: <20190723172429.GR9224@smile.fi.intel.com>
References: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
 <20190717113633.25922-3-andriy.shevchenko@linux.intel.com>
 <20190718172017.GA5868@x250>
 <20190718173842.GG9224@smile.fi.intel.com>
 <20190718174400.GB5868@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718174400.GB5868@x250>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 18, 2019 at 07:44:00PM +0200, Johannes Thumshirn wrote:
> On Thu, Jul 18, 2019 at 08:38:42PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 18, 2019 at 07:20:17PM +0200, Johannes Thumshirn wrote:
> > > On Wed, Jul 17, 2019 at 02:36:32PM +0300, Andy Shevchenko wrote:
> > > > There are new types and helpers that are supposed to be used in new code.
> > > > 
> > > > As a preparation to get rid of legacy types and API functions do
> > > > the conversion here.
> > > 
> > > Why? What was broken in the old versions? What benefit do we have apart from
> > > unneeded churn?
> > 
> > I think Christoph can explain this better than me.
> > 
> > By the way, if you look to the headers, there is no more "old" API, it's
> > covered as alias to the new one.
> 
> AFAIU it's mostly the naming that causes problems here as a little endian UUID
> doesn't really exits, is called GUID.

Yes, that's the main point for now.

> But please at least document this in a cover letter. Also what tests did you
> make? I know most of these functions have their origin in XFS.

I did only compile test.

-- 
With Best Regards,
Andy Shevchenko


