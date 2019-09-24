Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF6BCA49
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441380AbfIXOec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:34:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393376AbfIXOec (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:34:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7235AF5B;
        Tue, 24 Sep 2019 14:34:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8AC6DDA835; Tue, 24 Sep 2019 16:34:51 +0200 (CEST)
Date:   Tue, 24 Sep 2019 16:34:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 00/12] btrfs-progs: support xxhash64 checksums
Message-ID: <20190924143451.GU2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190903150046.14926-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903150046.14926-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 05:00:34PM +0200, Johannes Thumshirn wrote:
> Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
> prepared for an easy addition of new checksums, this patchset implements
> XXHASH64 as a second, fast but not cryptographically secure checksum hash.
> 
> For changes since v2, please see the individual patches. Additionally a patch
> moving the CRC32C implementation from kernel-lib/ to crypto/ was added.
> 
> For changes since v1, please see the individual patches. Additionally a unit
> test was added for regression testing this series.
> 
> 
> David Sterba (3):
>   btrfs-progs: update checksumming api
>   btrfs-progs: add xxhash sources
>   btrfs-progs: add xxhash64 as checksum algorithm
> 
> Johannes Thumshirn (9):
>   btrfs-progs: don't blindly assume crc32c in csum_tree_block_size()
>   btrfs-progs: cache csum_type in recover_control
>   btrfs-progs: add checksum type to checksumming functions
>   btrfs-progs: don't assume checksums are always 4 bytes
>   btrfs-progs: pass checksum type to
>     btrfs_csum_data()/btrfs_csum_final()
>   btrfs-progs: simplify update_block_csum() in btrfs-sb-mod.c
>   btrfs-progs: add option for checksum type to mkfs
>   btrfs-progs: move crc32c implementation to crypto/
>   btrfs-progs: add test-case for mkfs with xxhash64

1-9 now in devel, please split 10 and see the comments for 12. You can
also update the documentation, I think the user interface is not going
to change significantly.

For first release we can use the builtin xxhash but as there's a
standalone library we'll need to add support for configure-time
selection. This will be even more necessary once SHA256 is added.
