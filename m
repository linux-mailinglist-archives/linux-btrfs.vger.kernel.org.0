Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23076D302
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfGRRoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 13:44:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRRoC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 13:44:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3299AAD4C;
        Thu, 18 Jul 2019 17:44:01 +0000 (UTC)
Date:   Thu, 18 Jul 2019 19:44:00 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/4] Btrfs: Switch to use new generic UUID API
Message-ID: <20190718174400.GB5868@x250>
References: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
 <20190717113633.25922-3-andriy.shevchenko@linux.intel.com>
 <20190718172017.GA5868@x250>
 <20190718173842.GG9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718173842.GG9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 18, 2019 at 08:38:42PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 18, 2019 at 07:20:17PM +0200, Johannes Thumshirn wrote:
> > On Wed, Jul 17, 2019 at 02:36:32PM +0300, Andy Shevchenko wrote:
> > > There are new types and helpers that are supposed to be used in new code.
> > > 
> > > As a preparation to get rid of legacy types and API functions do
> > > the conversion here.
> > 
> > Why? What was broken in the old versions? What benefit do we have apart from
> > unneeded churn?
> 
> I think Christoph can explain this better than me.
> 
> By the way, if you look to the headers, there is no more "old" API, it's
> covered as alias to the new one.

AFAIU it's mostly the naming that causes problems here as a little endian UUID
doesn't really exits, is called GUID.

But please at least document this in a cover letter. Also what tests did you
make? I know most of these functions have their origin in XFS.

Thanks,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
