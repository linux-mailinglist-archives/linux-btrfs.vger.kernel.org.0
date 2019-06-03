Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0566732FD3
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFCMjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 08:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfFCMjn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 08:39:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80AF7AF57;
        Mon,  3 Jun 2019 12:39:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 521E6DA85E; Mon,  3 Jun 2019 14:40:33 +0200 (CEST)
Date:   Mon, 3 Jun 2019 14:40:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 00/13] Add support for other checksums
Message-ID: <20190603124032.GN15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190527171954.GP15290@twin.jikos.cz>
 <20190603093840.GC4044@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603093840.GC4044@x250>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 11:38:40AM +0200, Johannes Thumshirn wrote:
> On Mon, May 27, 2019 at 07:19:54PM +0200, David Sterba wrote:
> > 1-5 are reviewed and ok, 6 and 13 should be reworked, 7-12 is ok. I
> > can't put the branch to next yet due to the csum formatting "issues" but
> > will do once you resend. Should be ok just 6 and 13 as they're
> > independent.
> 
> I'd still like to hold back 13/13. SHA-256 doesn't seem to be well received by
> the community as the "slow" hash and using a plain SHA-256 is not sufficient
> for the dm-verity/fs-verity like approach I intend to implement in subsequent
> patches.
> 
> For the record, the current idea is to use a HMAC(SHA-256) as checksum
> algorithm with a key provided at mkfs and mount time.

The patch actually adding the new hash won't be merged to any
to-be-released branch until we have the final list, but for testing
purposes the patch will be in for-next and available via linux-next.
