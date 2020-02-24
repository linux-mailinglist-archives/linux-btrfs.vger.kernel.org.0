Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED58716A912
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgBXPCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:02:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:33248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgBXPCi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:02:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7FDD8B191;
        Mon, 24 Feb 2020 15:02:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DB39FDA727; Mon, 24 Feb 2020 16:02:17 +0100 (CET)
Date:   Mon, 24 Feb 2020 16:02:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/11] btrfs: merge unlocking to common exit block in
 btrfs_commit_transaction
Message-ID: <20200224150217.GU2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1582302545.git.dsterba@suse.com>
 <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 05:31:22PM +0100, David Sterba wrote:
>  	btrfs_prepare_extent_commit(fs_info);
> @@ -2346,8 +2326,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  	if (ret) {
>  		btrfs_handle_fs_error(fs_info, ret,
>  				      "Error while writing out transaction");
> -		mutex_unlock(&fs_info->tree_log_mutex);
> -		goto scrub_continue;
> +		goto unlock_tree_log;

Hm and this one is also wrong, in other cases that jump to
unlock_tree_log the unlocking order is tree_log_mutex/reloc_mutex, while
a few lines before there is unlock of reloc_mutex (while tree_log_mutex
is still held). This means the unlocking order is reversed compared to
the other cases and we can't jump to the label as this would lead to
double unlock of reloc_mutex.

So the above hunk must stay as is, with a comment.

>  	}
>  
>  	ret = write_all_supers(fs_info, 0);
> @@ -2394,6 +2373,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  	return ret;
>  
> +unlock_tree_log:
> +	mutex_unlock(&fs_info->tree_log_mutex);
> +unlock_reloc:
> +	mutex_unlock(&fs_info->reloc_mutex);
>  scrub_continue:
>  	btrfs_scrub_continue(fs_info);
>  cleanup_transaction:
> -- 
> 2.25.0
