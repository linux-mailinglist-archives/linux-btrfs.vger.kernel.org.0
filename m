Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28958337D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFCS3f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 14:29:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:46850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFCS3e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 14:29:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BEE2DAEB8;
        Mon,  3 Jun 2019 18:29:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F1AFDA85E; Mon,  3 Jun 2019 20:30:23 +0200 (CEST)
Date:   Mon, 3 Jun 2019 20:30:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 00/13] Add support for other checksums
Message-ID: <20190603183022.GS15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190603145859.7176-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 04:58:46PM +0200, Johannes Thumshirn wrote:
> This patchset add support for adding new checksum types in BTRFS.

V4 looks good to me, with a few minor fixups added to topic branch,
including the sha256 patch.  As noted this may not be merged and now
servers for the testing purposes.

> Currently BTRFS only supports CRC32C as data and metadata checksum, which is
> good if you only want to detect errors due to data corruption in hardware.
> 
> But CRC32C isn't able cover other use-cases like de-duplication or
> cryptographically save data integrity guarantees.
> 
> The following properties made SHA-256 interesting for these use-cases:
> - Still considered cryptographically sound
> - Reasonably well understood by the security industry
> - Result fits into the 32Byte/256Bit we have for the checksum in the on-disk
>   format
> - Small enough collision space to make it feasible for data de-duplication
> - Fast enough to calculate and offloadable to crypto hardware via the kernel's
>   crypto_shash framework.

Regarding hw offload, David pointed out that the ahash API would need to
be used and that turned out to be infeasible with current btrfs code. I
think the only hw-based improvements left are based on CPU instructions
(crc32c, SSE, AVX) but that's sufficient.

I also think software implementations of the checksum(s) are going to be
used in most cases, which kind of makes SHA-3 less appealing to us as
it's main point was 'excellent efficiency in hardware implementations'
(quoting NIST announcement [1]).

As has been suggested, BLAKE2 is for consideration, we only need the
kernel module which I'll provide for testing purposes. And the more I
know about it, the more I like it so we might have a winner, but the
selection is still open.

> The patchset also provides mechanisms for plumbing in different hash
> algorithms relatively easy.
> 
> This is an intermediate submission, as a) mkfs.btrfs support is still missing
> and

We'll need that one, briefly checking the progs souces, the same
cleanups will be needed there too.

> b) David requested to have three hash algorithms, where 1 is crc32c, one
> cryptographically secure and one in between.

Let me summarize the current satus:

for strong hash we have SHA256 and BLAKE2. For the fast hash xxhash and
murmur3 have been suggested. Let me add XXH3 and xxh128 for now (they're
not finalized yet).
