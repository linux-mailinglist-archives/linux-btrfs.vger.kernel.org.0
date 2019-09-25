Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FABE34C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442970AbfIYRVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 13:21:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438083AbfIYRVv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 13:21:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDD43AFCF;
        Wed, 25 Sep 2019 17:21:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3D371DA7D7; Wed, 25 Sep 2019 19:22:10 +0200 (CEST)
Date:   Wed, 25 Sep 2019 19:22:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] btrfs-progs: support xxhash64 checksums
Message-ID: <20190925172210.GL2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190925133728.18027-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925133728.18027-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 03:37:21PM +0200, Johannes Thumshirn wrote:
> Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
> prepared for an easy addition of new checksums, this patchset implements
> XXHASH64 as a second, fast but not cryptographically secure checksum hash.
> 
> This patchset is fully bisectible and available on github at
> https://github.com/morbidrsa/btrfs-progs/tree/mkfs-xxhash64.v5
> 
> Changes since v4:
> - Rebased onto latest 'devel' branch and dropped applied changes
> - Split 'btrfs-progs: add xxhash64 as checksum algorithm' into several atomic
>   patches
> - Changed test code to using 'TEST_ENABLE_OVERRIDE'
> 
> Johannes Thumshirn (7):
>   btrfs-progs: add option for checksum type to mkfs
>   btrfs-progs: add is_valid_csum_type() helper
>   btrfs-progs: add table for checksum type and name
>   btrfs-progs: also print checksum type when running mkfs
>   btrfs-progs: add xxhash64 to mkfs
>   btrfs-progs: move crc32c implementation to crypto/

All of the above added to devel, thanks. There might be some fixups or
cleanups but I'll do them as separate patches. Regarding relese, we
could do the xxhash support in 5.3, though there's no kernel support
yet. I'll think about that if this would not cause too much confusion
though.
