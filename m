Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DFD9958
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 20:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394272AbfJPSkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 14:40:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:45760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728768AbfJPSkg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 14:40:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A834FAC3E;
        Wed, 16 Oct 2019 18:40:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6603EDA7E3; Wed, 16 Oct 2019 20:40:45 +0200 (CEST)
Date:   Wed, 16 Oct 2019 20:40:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Fix wrong parameter order for trace events
Message-ID: <20191016184043.GC2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191016073149.23244-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016073149.23244-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 16, 2019 at 03:31:49PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3629,7 +3629,7 @@ int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
>  		return 0;
>  
>  	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
> -	trace_qgroup_meta_reserve(root, type, (s64)num_bytes);
> +	trace_qgroup_meta_reserve(root, (s64)num_bytes, type);
>  	ret = qgroup_reserve(root, num_bytes, enforce, type);
>  	if (ret < 0)
>  		return ret;
> @@ -3676,7 +3676,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
>  	 */
>  	num_bytes = sub_root_meta_rsv(root, num_bytes, type);
>  	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
> -	trace_qgroup_meta_reserve(root, type, -(s64)num_bytes);
> +	trace_qgroup_meta_reserve(root, -(s64)num_bytes, type);
>  	btrfs_qgroup_free_refroot(fs_info, root->root_key.objectid,
>  				  num_bytes, type);
>  }

It would be good to split the changes, one is swapping the order and the
other fixing the uninitialized type.

> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 5df604de4f11..0ebcaa153f93 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1710,6 +1710,7 @@ TRACE_EVENT(qgroup_meta_reserve,
>  	TP_fast_assign_btrfs(root->fs_info,
>  		__entry->refroot	= root->root_key.objectid;
>  		__entry->diff		= diff;
> +		__entry->type		= type;

And there's more, missing type assignment in qgroup_update_reserve,
redundant entry::type in qgroup_meta_convert.

I've briefly checked more tracepoint initialization, seems ok. It really
helps to have the same order for definition and for the assignments.
