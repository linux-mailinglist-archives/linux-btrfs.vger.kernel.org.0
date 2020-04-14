Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1749C1A8E03
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440804AbgDNVty (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 17:49:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:41362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440734AbgDNVts (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 17:49:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7120AD26;
        Tue, 14 Apr 2020 21:49:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3BC64DA823; Tue, 14 Apr 2020 23:49:08 +0200 (CEST)
Date:   Tue, 14 Apr 2020 23:49:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Use shared kernel btrfs_tree.h
Message-ID: <20200414214907.GX5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200407075209.33269-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407075209.33269-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 03:52:09PM +0800, Qu Wenruo wrote:
> Unlike kernel, btrfs-progs uses a monolithic ctree.h to define both
> on-disk data and runtime structures.
> 
> This is not good for future development, especially when we need a
> read-only code basis, for projects like U-boot.
> 
> This patch will cross-port the btree_header.h file to btrfs-progs. The

btrfs_tree.h

> only modification is to remove the existing headers.

As this is supposed to be copy of the kernel file, the progs patch
should use the final version once it's done.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

> diff --git a/kernel-shared/btrfs_tree.h b/kernel-shared/btrfs_tree.h
> new file mode 100644
> index 000000000000..c595d3c78a8e
> --- /dev/null
> +++ b/kernel-shared/btrfs_tree.h
> @@ -0,0 +1,991 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _BTRFS_CTREE_H_
> +#define _BTRFS_CTREE_H_

The define should roughly match the file name, _BTRFS_CTREE_H_ is too
close to __BTRFS_CTREE_H__ that's in ctree.h

> +
> +/*
> + * Cross-ported from kernel/include/uapi/linux/btrfs_tree.h.
> + *
> + * With include files removed.
> + */
