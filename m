Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2032A34067
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 09:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfFDHhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 03:37:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:55452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbfFDHhd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jun 2019 03:37:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDA46ADD5;
        Tue,  4 Jun 2019 07:37:31 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:37:30 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 00/13] Add support for other checksums
Message-ID: <20190604073730.GA4225@x250>
References: <20190603145859.7176-1-jthumshirn@suse.de>
 <20190603183022.GS15290@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603183022.GS15290@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 08:30:22PM +0200, David Sterba wrote:
> On Mon, Jun 03, 2019 at 04:58:46PM +0200, Johannes Thumshirn wrote:
> > This patchset add support for adding new checksum types in BTRFS.
> 
> V4 looks good to me, with a few minor fixups added to topic branch,
> including the sha256 patch.  As noted this may not be merged and now
> servers for the testing purposes.

Thanks \o/

[...]

> We'll need that one, briefly checking the progs souces, the same
> cleanups will be needed there too.

Yep, I've already started doing the progs side as well.

> 
> > b) David requested to have three hash algorithms, where 1 is crc32c, one
> > cryptographically secure and one in between.
> 
> Let me summarize the current satus:
> 
> for strong hash we have SHA256 and BLAKE2. For the fast hash xxhash and
> murmur3 have been suggested. Let me add XXH3 and xxh128 for now (they're
> not finalized yet).

I know there's a tendency to not trust FIPS but please let's not completely
rule out FIPS approved algorithms (be it SHA-2 or SHA-3) because we will get
asked to include one sooner or later.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
