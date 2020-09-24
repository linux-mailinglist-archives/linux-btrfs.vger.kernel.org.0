Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7355E277761
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIXRFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 13:05:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXRFY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 13:05:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FF9BABB2;
        Thu, 24 Sep 2020 17:05:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AA1C6DA6E3; Thu, 24 Sep 2020 19:04:06 +0200 (CEST)
Date:   Thu, 24 Sep 2020 19:04:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/4] btrfs: use sb state to print space_cache mount option
Message-ID: <20200924170406.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <e7fe51d3013637cfe2bc9581983468d5940fdce5.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7fe51d3013637cfe2bc9581983468d5940fdce5.1600282812.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 11:13:39AM -0700, Boris Burkov wrote:
> @@ -1870,6 +1868,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  		if (!sb_rdonly(sb) || *flags & SB_RDONLY) {
>  			btrfs_warn(fs_info,
>  				   "Remounting with free space tree only supported from read-only to read-write");
> +			/*
> +			 * if we aren't building the free space tree, reset

First letter in comments should be uppercase, unless it's a name of
function or identifier

> +			 * the space cache options to what they were before
> +			 */
> +			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
> +			if (btrfs_free_space_cache_v1_active(fs_info))
> +				btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
>  			create_fst = false;
