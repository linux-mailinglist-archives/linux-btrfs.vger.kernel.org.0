Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1D3800B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhEMXLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:11:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEMXLY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:11:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB8C1AEE5;
        Thu, 13 May 2021 23:10:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3CAB4DAF1B; Fri, 14 May 2021 01:07:43 +0200 (CEST)
Date:   Fri, 14 May 2021 01:07:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [Patch v2 03/42] btrfs: remove the unused parameter @len for
 btrfs_bio_fits_in_stripe()
Message-ID: <20210513230743.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:10AM +0800, Qu Wenruo wrote:
> @@ -443,7 +443,7 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  		     u64 logical, u64 *length,
>  		     struct btrfs_bio **bbio_ret);
>  int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
> -			  enum btrfs_map_op op, u64 logical, u64 len,
> +			  enum btrfs_map_op op, u64 logical,
>  			  struct btrfs_io_geometry *io_geom);

The parameter also needs to be removed from the function comment.
