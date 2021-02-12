Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390A319FFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Feb 2021 14:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBLNk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Feb 2021 08:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:43922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhBLNky (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Feb 2021 08:40:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC88FB1EA;
        Fri, 12 Feb 2021 13:40:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46F58DA6E9; Fri, 12 Feb 2021 14:38:18 +0100 (CET)
Date:   Fri, 12 Feb 2021 14:38:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: initialize btrfs_fs_info::csum_size earlier in
 open_ctree()
Message-ID: <20210212133818.GI1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210211083828.6835-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211083828.6835-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 11, 2021 at 04:38:28PM +0800, Su Yue wrote:
> User reported that btrfs-progs misc-tests/028-superblock-recover fails:
>     [TEST/misc]   028-superblock-recover
> unexpected success: mounted fs with corrupted superblock
> test failed for case 028-superblock-recover
> 
> The test case expects that a broken image with bad superblock will be
> rejected to be mounted. However, the test image just passed csum check
> of superblock and was successfully mounted.
> 
> Commit 55fc29bed8dd ("btrfs: use cached value of fs_info::csum_size
> everywhere") replaces all calls to btrfs_super_csum_size by
> fs_info::csum_size. The calls include the place where fs_info->csum_size
> is not initialized. So btrfs_check_super_csum() passes because memcmp()
> with len 0 always returns 0.
> 
> Fix it by caching csum size in btrfs_fs_info::csum_size once we know the
> csum type in superblock is valid in open_ctree().
> 
> Link: https://github.com/kdave/btrfs-progs/issues/250
> Fixes: 55fc29bed8dd ("btrfs: use cached value of fs_info::csum_size everywhere")

That's a new commit in 5.11 and the bug looks serious, I'll need to send
one more pull request. Thanks for the fix.
