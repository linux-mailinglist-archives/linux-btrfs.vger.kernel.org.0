Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06B2B95C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfE0RTB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 13:19:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbfE0RTA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 13:19:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAFD1AED4;
        Mon, 27 May 2019 17:18:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E3B7DA85E; Mon, 27 May 2019 19:19:54 +0200 (CEST)
Date:   Mon, 27 May 2019 19:19:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 00/13] Add support for other checksums
Message-ID: <20190527171954.GP15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190522081910.7689-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522081910.7689-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 10:18:57AM +0200, Johannes Thumshirn wrote:
> This patchset add support for adding new checksum types in BTRFS.
> 
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
> 
> The patchset also provides mechanisms for plumbing in different hash
> algorithms relatively easy.
> 
> Unfortunately this patchset also partially reverts commit: 
> 9678c54388b6 ("btrfs: Remove custom crc32c init code")
> 
> This is an intermediate submission, as a) mkfs.btrfs support is still missing
> and b) David requested to have three hash algorithms, where 1 is crc32c, one
> cryptographically secure and one in between.
> 
> A changelog can be found directly in the patches. The branch is also available
> on a gitweb at
> https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=btrfs-csum-rework.v3
> 
> Johannes Thumshirn (13):
>   btrfs: use btrfs_csum_data() instead of directly calling crc32c
>   btrfs: resurrect btrfs_crc32c()
>   btrfs: use btrfs_crc32c{,_final}() in for free space cache
>   btrfs: don't assume ordered sums to be 4 bytes
>   btrfs: dont assume compressed_bio sums to be 4 bytes
>   btrfs: format checksums according to type for printing
>   btrfs: add common checksum type validation
>   btrfs: check for supported superblock checksum type before checksum
>     validation
>   btrfs: Simplify btrfs_check_super_csum() and get rid of size
>     assumptions
>   btrfs: add boilerplate code for directly including the crypto
>     framework
>   btrfs: directly call into crypto framework for checsumming
>   btrfs: remove assumption about csum type form
>     btrfs_print_data_csum_error()
>   btrfs: add sha256 as another checksum algorithm

1-5 are reviewed and ok, 6 and 13 should be reworked, 7-12 is ok. I
can't put the branch to next yet due to the csum formatting "issues" but
will do once you resend. Should be ok just 6 and 13 as they're
independent.
