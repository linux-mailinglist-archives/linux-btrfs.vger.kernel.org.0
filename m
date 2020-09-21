Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8622730B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgIUROV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 13:14:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgIUROV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 13:14:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E597AD71;
        Mon, 21 Sep 2020 17:14:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E6ADDA6E0; Mon, 21 Sep 2020 19:13:04 +0200 (CEST)
Date:   Mon, 21 Sep 2020 19:13:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 3/4] btrfs: remove free space items when creating free
 space tree
Message-ID: <20200921171304.GM6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 11:13:40AM -0700, Boris Burkov wrote:
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3333,6 +3333,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  			close_ctree(fs_info);
>  			return ret;
>  		}
> +		/*
> +		 * Creating the free space tree creates inode orphan items and
> +		 * delayed iputs when it deletes the free space inodes. Later in
> +		 * open_ctree, we run btrfs_orphan_cleanup which tries to clean
> +		 * up the orphan items. However, the outstanding references on
> +		 * the inodes from the delayed iputs causes the cleanup to fail.
> +		 * To fix it, force going through the delayed iputs here.
> +		 */
> +		btrfs_run_delayed_iputs(fs_info);

This is called from open_ctree, so this is mount context and the free
space tree creation is called before that. That will schedule all free
space inodes for deletion and waits here. This takes time proportional
to the filesystem size.

We've had reports that this takes a lot of time already, so I wonder if
the delayed iputs can be avoided here.
