Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96E34317
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfFDJYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 05:24:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:34298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfFDJYe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jun 2019 05:24:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 318CFAC3F;
        Tue,  4 Jun 2019 09:24:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32EF6DA85E; Tue,  4 Jun 2019 11:25:25 +0200 (CEST)
Date:   Tue, 4 Jun 2019 11:25:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 00/13] Add support for other checksums
Message-ID: <20190604092524.GV15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190603145859.7176-1-jthumshirn@suse.de>
 <20190603183022.GS15290@twin.jikos.cz>
 <20190604073730.GA4225@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604073730.GA4225@x250>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 04, 2019 at 09:37:30AM +0200, Johannes Thumshirn wrote:
> On Mon, Jun 03, 2019 at 08:30:22PM +0200, David Sterba wrote:
> > On Mon, Jun 03, 2019 at 04:58:46PM +0200, Johannes Thumshirn wrote:
> > > This patchset add support for adding new checksum types in BTRFS.
> > 
> > V4 looks good to me, with a few minor fixups added to topic branch,
> > including the sha256 patch.  As noted this may not be merged and now
> > servers for the testing purposes.
> 
> Thanks \o/
> 
> [...]
> 
> > We'll need that one, briefly checking the progs souces, the same
> > cleanups will be needed there too.
> 
> Yep, I've already started doing the progs side as well.

And we should export the information about checksums to sysfs too, in
the global features what the module supports and what the filesystem
uses in the per-fs directories.
