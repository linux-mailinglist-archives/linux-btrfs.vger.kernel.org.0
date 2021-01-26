Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BCA3057F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314359AbhAZXFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:05:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:37954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394962AbhAZSxr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 13:53:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45A36ACC6;
        Tue, 26 Jan 2021 18:53:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 637EDDA7D2; Tue, 26 Jan 2021 19:51:19 +0100 (CET)
Date:   Tue, 26 Jan 2021 19:51:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 06/12] btrfs: rename need_do_async_reclaim
Message-ID: <20210126185119.GW1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
 <d998cbf6d167d16ca51adea2fb631d36793a0a6f.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d998cbf6d167d16ca51adea2fb631d36793a0a6f.1602249928.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 09, 2020 at 09:28:23AM -0400, Josef Bacik wrote:
> All of our normal flushing is asynchronous reclaim, so this helper is
> poorly named.  This is more checking if we need to preemptively flush
> space, so rename it to need_preemptive_reclaim.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 0f84bee57c29..f37ead28bd05 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -799,9 +799,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
>  	return to_reclaim;
>  }
>  
> -static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
> -					struct btrfs_space_info *space_info,
> -					u64 used)
> +static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,

Following patches add more code to that function so it's not really
suitable for 'static inline', I'd rather drop it.
