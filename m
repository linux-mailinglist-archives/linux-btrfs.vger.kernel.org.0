Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95732D8A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 18:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhCDRfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 12:35:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:42086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238058AbhCDRfN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Mar 2021 12:35:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8600AE1C
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Mar 2021 17:34:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C647FDA81D; Thu,  4 Mar 2021 18:32:36 +0100 (CET)
Date:   Thu, 4 Mar 2021 18:32:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Dave Sterba <DSterba@suse.cz>
Subject: Re: [PATCH v3] btrfs: remove force argument from run_delalloc_nocow()
Message-ID: <20210304173236.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20210304150625.idi3d6gpkwwovcpz@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304150625.idi3d6gpkwwovcpz@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 04, 2021 at 09:06:25AM -0600, Goldwyn Rodrigues wrote:
> force_nocow can be calculated by btrfs_inode and does not need to be
> passed as an argument.
> 
> This simplifies run_delalloc_nocow() call from btrfs_run_delalloc_range()
> A new function, should_nocow() checks if the range should be nocow'd or
> not. The function returns true iff either BTRFS_INODE_NODATA or
> BTRFS_INODE_PREALLOC, but is not a defrag extent.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
