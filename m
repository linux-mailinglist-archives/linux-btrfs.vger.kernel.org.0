Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80B76D2E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfGRRir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 13:38:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:61105 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRRir (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 13:38:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 10:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,279,1559545200"; 
   d="scan'208";a="251881297"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2019 10:38:44 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hoAMc-0006Ru-Va; Thu, 18 Jul 2019 20:38:42 +0300
Date:   Thu, 18 Jul 2019 20:38:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/4] Btrfs: Switch to use new generic UUID API
Message-ID: <20190718173842.GG9224@smile.fi.intel.com>
References: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
 <20190717113633.25922-3-andriy.shevchenko@linux.intel.com>
 <20190718172017.GA5868@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718172017.GA5868@x250>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 18, 2019 at 07:20:17PM +0200, Johannes Thumshirn wrote:
> On Wed, Jul 17, 2019 at 02:36:32PM +0300, Andy Shevchenko wrote:
> > There are new types and helpers that are supposed to be used in new code.
> > 
> > As a preparation to get rid of legacy types and API functions do
> > the conversion here.
> 
> Why? What was broken in the old versions? What benefit do we have apart from
> unneeded churn?

I think Christoph can explain this better than me.

By the way, if you look to the headers, there is no more "old" API, it's
covered as alias to the new one.

-- 
With Best Regards,
Andy Shevchenko


