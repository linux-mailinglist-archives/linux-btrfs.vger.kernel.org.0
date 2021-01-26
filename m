Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54D4304D38
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 00:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbhAZXFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:05:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:60610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732025AbhAZSix (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 13:38:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02CB2ACC6;
        Tue, 26 Jan 2021 18:38:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 209E4DA7D2; Tue, 26 Jan 2021 19:36:25 +0100 (CET)
Date:   Tue, 26 Jan 2021 19:36:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 01/12] btrfs: make flush_space take a enum
 btrfs_flush_state instead of int
Message-ID: <20210126183624.GU1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1602249928.git.josef@toxicpanda.com>
 <397b21a29dfe5d3c8d5fec261c3246b07b93e42c.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397b21a29dfe5d3c8d5fec261c3246b07b93e42c.1602249928.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 09, 2020 at 09:28:18AM -0400, Josef Bacik wrote:
> I got a automated message from somebody who runs clang against our
> kernels and it's because I used the wrong enum type for what I passed
> into flush_space.  Change the argument to be explicitly the enum we're
> expecting to make everything consistent.  Maybe eventually gcc will
> catch errors like this.

I can't find any such public report and none of the clang warnings seem
to be specific about that. Local run with clang 11 does not produce any
warning.


> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 64099565ab8f..ba2b72409d46 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -667,7 +667,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
>   */
>  static void flush_space(struct btrfs_fs_info *fs_info,
>  		       struct btrfs_space_info *space_info, u64 num_bytes,
> -		       int state)
> +		       enum btrfs_flush_state state)
>  {
>  	struct btrfs_root *root = fs_info->extent_root;
>  	struct btrfs_trans_handle *trans;
> @@ -920,7 +920,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
>  	struct btrfs_fs_info *fs_info;
>  	struct btrfs_space_info *space_info;
>  	u64 to_reclaim;
> -	int flush_state;
> +	enum btrfs_flush_state flush_state;

The pattern with int instead of the enum is also in
priority_reclaim_metadata_space so I'll add it. If you find the report
we can add the warning among the newly enabled warnings to Makefile.

>  	int commit_cycles = 0;
>  	u64 last_tickets_id;
>  
> -- 
> 2.26.2
