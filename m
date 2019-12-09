Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0F1171CD
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfLIQdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 11:33:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:59676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfLIQdW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 11:33:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00DFCB1D3;
        Mon,  9 Dec 2019 16:33:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20BCEDA783; Mon,  9 Dec 2019 17:33:14 +0100 (CET)
Date:   Mon, 9 Dec 2019 17:33:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] btrfs: use simple_dir_inode_operations for placeholder
 subvolume directory
Message-ID: <20191209163313.GM2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Al Viro <viro@zeniv.linux.org.uk>
References: <3cc2030c10bcef05fe39f0fe2e8cdfb61c6c0faf.1575570955.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc2030c10bcef05fe39f0fe2e8cdfb61c6c0faf.1575570955.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 10:36:04AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When you snapshot a subvolume containing a subvolume, you get a
> placeholder directory where the subvolume would be. These directories
> have their own btrfs_dir_ro_inode_operations.
> 
> Al pointed out [1] that these directories can use simple_lookup()
> instead of btrfs_lookup(), as they are always empty. Furthermore, they
> can use the default generic_permission() instead of btrfs_permission();
> the additional checks in the latter don't matter because we can't write
> to the directory anyways. Finally, they can use the default
> generic_update_time() instead of btrfs_update_time(), as the inode
> doesn't exist on disk and doesn't need any special handling.
> 
> All together, this means that we can get rid of
> btrfs_dir_ro_inode_operations and use simple_dir_inode_operations
> instead.
> 
> 1: https://lore.kernel.org/linux-btrfs/20190929052934.GY26530@ZenIV.linux.org.uk/
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Added to misc-next, with a comment why we use the simple ops, thanks.
