Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA8FD4800
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfJKSyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 14:54:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:41984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728851AbfJKSyF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 14:54:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69E65AC8F;
        Fri, 11 Oct 2019 18:54:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 012FEDA808; Fri, 11 Oct 2019 20:54:17 +0200 (CEST)
Date:   Fri, 11 Oct 2019 20:54:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: get bdev from latest_dev for dio bh_result
Message-ID: <20191011185417.GJ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1570474492.git.dsterba@suse.com>
 <2ae45bba23d97e0d60d9949d9c65dbab9961cb34.1570474492.git.dsterba@suse.com>
 <a5312091-5ded-01af-19e5-f87d21de165f@suse.com>
 <20191011182642.GH2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011182642.GH2751@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 08:26:42PM +0200, David Sterba wrote:
> You're right, and actually I got crashes in clean_bdev_aliases when I
> supplied a NULL bdev, so I'll add it to the changelog. Thanks.

Unless there are further comments, I won't resend the whole patchset.
The changelog in this patch will be:

---
    btrfs: get bdev from latest_dev for dio bh_result

    To remove use of extent_map::bdev we need to find a replacement, and the
    latest_bdev is the only one we can use here, because inode::i_bdev and
    superblock::s_bdev are NULL.

    The DIO code uses bdev in two places:

    * to read blocksize to perform alignment checks in
      do_blockdev_direct_IO, but we do them in btrfs code before any call to
      DIO

    * in the following call chain:

      do_direct_IO
        get_more_blocks
         sdio->get_block() <-- this is btrfs_get_blocks_direct

      subsequently the map_bh->b_dev member is used in clean_bdev_aliases
      and dio_new_bio to set the bio's bdev to that of the buffer_head.
      However, because we have provided a submit function dio_bio_submit
      calls our submission function and ignores the bdev.

    We can't pass NULL because there are dereferences of bdev in
    __blockdev_direct_IO, even though it's not going to be used later.

    So it's safe to pass any valid bdev that's used within the filesystem.
---
