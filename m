Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF06E390592
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhEYPiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 11:38:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhEYPiV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 11:38:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621957010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLBf1ytAGq2VsKzmJCZvotrgUMk/bemmW4tVhLMbtYo=;
        b=eHwWPuZHScEVd4OAgGR8vbQ7l7ouh/UEhgPc3gxlCNa/SWgLP+qNqeXvWnZZX/hLb/6UnI
        lMf3hKWIGzeF6VKSIrvU7v0vDe2+Bn3inns7JlaBylcpvZtDO+AFVKQQofESacxqnP2mLj
        g3ji73PNvgTq3w/1Yvq2uub2KHLzqg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621957010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLBf1ytAGq2VsKzmJCZvotrgUMk/bemmW4tVhLMbtYo=;
        b=4NLNSD6ncclvDEs4GELtLquT699y7llezASRBKZogzn3dqOEkOI9EQdov/93hdnlPqiDsn
        D1FQnHdSJ5vCK+Dw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D37EAAB71;
        Tue, 25 May 2021 15:36:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C8FADA72C; Tue, 25 May 2021 17:34:14 +0200 (CEST)
Date:   Tue, 25 May 2021 17:34:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs: add a btrfs_has_fs_error helper
Message-ID: <20210525153414.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1621523846.git.josef@toxicpanda.com>
 <a4bc9de04778cf6aa038f5164d01cf467de32ed5.1621523846.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4bc9de04778cf6aa038f5164d01cf467de32ed5.1621523846.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 11:21:32AM -0400, Josef Bacik wrote:
> We have a few flags that are inconsistently used to describe the fs in
> different states of failure.  As of
> 
> 	btrfs: always abort the transaction if we abort a trans handle
> 
> we will always set BTRFS_FS_STATE_ERROR if we abort, so we don't have to
> check both ABORTED and ERROR to see if things have gone wrong.  Add a
> helper to check BTRFS_FS_STATE_HELPER and then convert all checkers of
> FS_STATE_ERROR to use the helper.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h       |  5 +++++
>  fs/btrfs/disk-io.c     |  8 +++-----
>  fs/btrfs/extent_io.c   |  2 +-
>  fs/btrfs/file.c        |  2 +-
>  fs/btrfs/inode.c       |  6 +++---
>  fs/btrfs/scrub.c       |  2 +-
>  fs/btrfs/super.c       |  2 +-
>  fs/btrfs/transaction.c | 11 +++++------
>  fs/btrfs/tree-log.c    |  2 +-
>  9 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 938d8ebf4cf3..3c22c3308667 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3531,6 +3531,11 @@ do {								\
>  			  (errno), fmt, ##args);		\
>  } while (0)
>  
> +static inline bool btrfs_has_fs_error(struct btrfs_fs_info *fs_info)
> +{
> +	return test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);

This could also get the unlikely() annotattion, similar to what
TRANS_ABORTED does. Which means this inline would have to be a macro eg.
FS_ERROR or similar.


> @@ -4372,8 +4371,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  			btrfs_err(fs_info, "commit super ret %d", ret);
>  	}
>  
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state) ||
> -	    test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
> +	if (btrfs_has_fs_error(fs_info))
>  		btrfs_error_commit_super(fs_info);

This is not equivalent change, previously it also checks for
STATE_TRANS_ABORTED, this was added in af7227338135 ("Btrfs: clean up
resources during umount after trans is aborted") . So it should be kept
in place or there may be a bigger problem when the filesystem and
transaction error bits get out of sync, I haven't checked.
