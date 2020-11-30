Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5026F2C8EA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 21:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgK3UHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 15:07:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:48088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgK3UHa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 15:07:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF0EBACC1;
        Mon, 30 Nov 2020 20:06:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 615D0DA6E1; Mon, 30 Nov 2020 21:05:17 +0100 (CET)
Date:   Mon, 30 Nov 2020 21:05:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 09/12] btrfs: warn when remount will not change the
 free space tree
Message-ID: <20201130200517.GJ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
 <582a98333502e807faa9a899082e6e960e4cc0f3.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582a98333502e807faa9a899082e6e960e4cc0f3.1605736355.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 03:06:24PM -0800, Boris Burkov wrote:
> If the remount is ro->ro, rw->ro, or rw->rw, we will not create or
> clear the free space tree. This can be surprising, so print a warning
> to dmesg to make the failure more visible. It is also important to
> ensure that the space cache options (SPACE_CACHE, FREE_SPACE_TREE) are
> consistent, so ensure those are set to properly match the current on
> disk state (which won't be changing).
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/super.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index e2a186d254c5..5e88ae69e2e6 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1912,6 +1912,24 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	btrfs_resize_thread_pool(fs_info,
>  		fs_info->thread_pool_size, old_thread_pool_size);
>  
> +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
> +	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> +	    ((!sb_rdonly(sb) || *flags & SB_RDONLY))) {

	(!sb_rdonly(sb) || (*flags & SB_RDONLY))) {

Ie. the parens around the & operator, not (( )) around the whole
expression.
