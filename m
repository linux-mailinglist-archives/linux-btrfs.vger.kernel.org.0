Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D996AB8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 17:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfGPPW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 11:22:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:33187 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfGPPW0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 11:22:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 08:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,498,1557212400"; 
   d="scan'208";a="366248378"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2019 08:22:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hnPHa-0001YU-JF; Tue, 16 Jul 2019 18:22:22 +0300
Date:   Tue, 16 Jul 2019 18:22:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2 1/3] uuid: Add inline helpers to operate on raw buffers
Message-ID: <20190716152222.GJ9224@smile.fi.intel.com>
References: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
 <20190716151133.GA6073@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716151133.GA6073@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 05:11:33PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019 at 06:04:16PM +0300, Andy Shevchenko wrote:
> > +static inline void guid_copy_from_raw(guid_t *dst, const __u8 *src)
> > +{
> > +	memcpy(dst, (const guid_t *)src, sizeof(guid_t));
> > +}
> > +
> > +static inline void guid_copy_to_raw(__u8 *dst, const guid_t *src)
> > +{
> > +	memcpy((guid_t *)dst, src, sizeof(guid_t));
> > +}
> 
> Maybe import_guid/export_guid is a better name?

Yes, sounds good to me.

> Either way, I don't think we need the casts, and they probably want
> kerneldoc comments describing their use.
> 
> Same for the uuid side.

Got it.

> > +static inline void guid_gen_raw(__u8 *guid)
> > +{
> > +	guid_gen((guid_t *)guid);
> > +}
> > +
> > +static inline void uuid_gen_raw(__u8 *uuid)
> > +{
> > +	uuid_gen((uuid_t *)uuid);
> > +}
> 
> I hate this raw naming.  If people really want to use the generators on
> u8 fields a cast seems more descriptive then hiding it.

This entire patch because of BTRFS maintainers, they didn't want the explicit
casts. Maybe something has been changed, I dunno.

Perhaps, you can sell them the point somehow. (everybody else is using a cast
in the kernel).

-- 
With Best Regards,
Andy Shevchenko


