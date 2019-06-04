Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48156342EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 11:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfFDJOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 05:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbfFDJOd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jun 2019 05:14:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 272D4AC54;
        Tue,  4 Jun 2019 09:14:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07C38DA85E; Tue,  4 Jun 2019 11:15:23 +0200 (CEST)
Date:   Tue, 4 Jun 2019 11:15:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 00/13] Add support for other checksums
Message-ID: <20190604091523.GU15290@twin.jikos.cz>
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
> > Let me summarize the current satus:
> > 
> > for strong hash we have SHA256 and BLAKE2. For the fast hash xxhash and
> > murmur3 have been suggested. Let me add XXH3 and xxh128 for now (they're
> > not finalized yet).
> 
> I know there's a tendency to not trust FIPS but please let's not completely
> rule out FIPS approved algorithms (be it SHA-2 or SHA-3) because we will get
> asked to include one sooner or later.

That's not about FIPS, but the practical reasons. If it's slow nobody
will use it. For example, if a crypto-strong hash is used as a hint for
deduplication, this means we'll have to count with it for the additional
structures that do the reverse mapping from checksum -> block.
