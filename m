Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735DB1B33A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 01:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDUXre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 19:47:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgDUXrd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 19:47:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2FD38AD31;
        Tue, 21 Apr 2020 23:47:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 706F8DA70B; Wed, 22 Apr 2020 01:46:50 +0200 (CEST)
Date:   Wed, 22 Apr 2020 01:46:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        rgoldwyn@suse.com
Subject: Re: [PATCH v2 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200421234650.GR18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        rgoldwyn@suse.com
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 02:46:10PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> Omar Sandoval (15):
>   block: add bio_for_each_bvec_all()
>   btrfs: fix error handling when submitting direct I/O bio
>   btrfs: fix double __endio_write_update_ordered in direct I/O
>   btrfs: look at full bi_io_vec for repair decision
>   btrfs: don't do repair validation for checksum errors
>   btrfs: clarify btrfs_lookup_bio_sums documentation
>   btrfs: rename __readpage_endio_check to check_data_csum
>   btrfs: make btrfs_check_repairable() static
>   btrfs: kill btrfs_dio_private->private
>   btrfs: convert btrfs_dio_private->pending_bios to refcount_t
>   btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
>   btrfs: get rid of one layer of bios in direct I/O
>   btrfs: simplify direct I/O read repair
>   btrfs: get rid of endio_repair_workers
>   btrfs: unify buffered and direct I/O read repair

Thanks to all who did the reviews, I'm adding the patchset to misc-next.
There are some minor updates, in changelogs or in code. There are also
some comments that might lead to more fixups but I don't think it's
too serious to hold the patches unmerged.

If there are futher comments or requests for clarification, changelog
updates, please let me know, I'll do that directly. We need to give it a
test and also to provide a base for the dio-iomap patchset.
