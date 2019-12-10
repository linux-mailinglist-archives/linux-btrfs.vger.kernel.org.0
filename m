Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAA118FFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLJSrq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:47:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:56244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfLJSrp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:47:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56A6BAFA9;
        Tue, 10 Dec 2019 18:47:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0B2DDA727; Tue, 10 Dec 2019 19:47:44 +0100 (CET)
Date:   Tue, 10 Dec 2019 19:47:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/9] btrfs: miscellaneous cleanups
Message-ID: <20191210184744.GH3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575336815.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 05:34:16PM -0800, Omar Sandoval wrote:
> This series includes several cleanups. Patches 1-3 are the standalone
> cleanups from my RWF_ENCODED series [1] (as requested by Dave). Patches
> 4-8 clean up code rot in the writepage codepath. Patch 9 is a trivial
> cleanup in find_free_extent.
> 
> Based on misc-next.
> 
> Thanks!
> 
> 1: https://lore.kernel.org/linux-btrfs/cover.1574273658.git.osandov@fb.com/
> 
> Omar Sandoval (9):
>   btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
>   btrfs: remove dead snapshot-aware defrag code
>   btrfs: make btrfs_ordered_extent naming consistent with
>     btrfs_file_extent_item
>   btrfs: remove unnecessary pg_offset assignments in
>     __extent_writepage()
>   btrfs: remove trivial goto label in __extent_writepage()
>   btrfs: remove redundant i_size check in __extent_writepage_io()
>   btrfs: drop create parameter to btrfs_get_extent()
>   btrfs: simplify compressed/inline check in __extent_writepage_io()
>   btrfs: remove struct find_free_extent.ram_bytes

Added to misc-next with minor fixups, thanks.
