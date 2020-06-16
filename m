Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD131FB5E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgFPPRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 11:17:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgFPPRa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 11:17:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AEBCEB19C;
        Tue, 16 Jun 2020 15:17:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5F92DA7C3; Tue, 16 Jun 2020 17:17:20 +0200 (CEST)
Date:   Tue, 16 Jun 2020 17:17:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 4/5] btrfs: change the timing for qgroup reserved
 space for ordered extents to fix reserved space leak
Message-ID: <20200616151720.GF27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200610010444.13583-1-wqu@suse.com>
 <20200610010444.13583-5-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610010444.13583-5-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 10, 2020 at 09:04:43AM +0800, Qu Wenruo wrote:
> [BUG]
> The following simple workload from fsstress can lead to qgroup reserved
> data space leakage:
>   0/0: creat f0 x:0 0 0
>   0/0: creat add id=0,parent=-1
>   0/1: write f0[259 1 0 0 0 0] [600030,27288] 0
>   0/4: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 64 627318] return 25, fallback to stat()
>   0/4: dwrite f0[259 1 0 0 64 627318] [610304,106496] 0
> 
> This would cause btrfs qgroup to leak 20480 bytes for data reserved
> space.
> If btrfs qgroup limit is enabled, such leakage can lead to unexpected
> early EDQUOT and unusable space.
> 
> [CAUSE]
> When doing direct IO, kernel will try to writeback existing buffered
> page cache, then invalidate them:
>   iomap_dio_rw()
>   |- filemap_write_and_wait_range();
>   |- invalidate_inode_pages2_range();

As the dio-iomap got reverted, can you please update the changelog and
review if the changes are still valid? The whole patchset is in
misc-next so I'll update the changelog in place if needed, or replace
the whole patchset. Thanks.
