Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38D1CDF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfENR27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 13:28:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfENR27 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 13:28:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 964B1AE2F;
        Tue, 14 May 2019 17:28:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44BB9DA866; Tue, 14 May 2019 19:29:59 +0200 (CEST)
Date:   Tue, 14 May 2019 19:29:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] btrfs: extent-tree: Fix a bug that btrfs is unable to
 add pinned bytes
Message-ID: <20190514172959.GN3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
References: <20190510044505.17422-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510044505.17422-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 12:45:05PM +0800, Qu Wenruo wrote:
> Commit ddf30cf03fb5 ("btrfs: extent-tree: Use btrfs_ref to refactor
> add_pinned_bytes()") refactored add_pinned_bytes(), but during that
> refactor, there are two callers which add the pinned bytes instead
> of subtracting.
> 
> That refactor misses those two caller, causing incorrect pinned bytes
> calculation and resulting unexpected ENOSPC error.
> 
> Fix it by adding a new parameter @sign to restore the original behavior.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: ddf30cf03fb5 ("btrfs: extent-tree: Use btrfs_ref to refactor add_pinned_bytes()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f79e477a378e..8592d31e321c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -757,12 +757,14 @@ static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info *info,
>  }
>  
>  static void add_pinned_bytes(struct btrfs_fs_info *fs_info,
> -			     struct btrfs_ref *ref)
> +			     struct btrfs_ref *ref, int sign)

This does not look like a good API, can it be done with a separate
function like sub_pinned_bytes?
