Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AE12D315
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfL3SFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 13:05:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:42376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3SFM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 13:05:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7413AAB91;
        Mon, 30 Dec 2019 18:05:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1EC7DA790; Mon, 30 Dec 2019 19:05:03 +0100 (CET)
Date:   Mon, 30 Dec 2019 19:05:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 16/22] btrfs: make max async discard size tunable
Message-ID: <20191230180503.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <c3e6fa9d3391104c22c3e474af16a86d439a7af7.1576195673.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e6fa9d3391104c22c3e474af16a86d439a7af7.1576195673.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 04:22:25PM -0800, Dennis Zhou wrote:
> Expose max_discard_size as a tunable via sysfs.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/ctree.h            |  1 +
>  fs/btrfs/discard.c          |  1 +
>  fs/btrfs/free-space-cache.c | 19 ++++++++++++-------
>  fs/btrfs/sysfs.c            | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1b2dae5962de..bf93ddbc773f 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -470,6 +470,7 @@ struct btrfs_discard_ctl {
>  	u64 prev_discard;
>  	atomic_t discardable_extents;
>  	atomic64_t discardable_bytes;
> +	u64 max_discard_size;
>  	u32 delay;
>  	u32 iops_limit;
>  	u64 bps_limit;
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 085f36808e7f..dd5143f0283f 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -536,6 +536,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
>  	discard_ctl->prev_discard = 0;
>  	atomic_set(&discard_ctl->discardable_extents, 0);
>  	atomic64_set(&discard_ctl->discardable_bytes, 0);
> +	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_MAX_SIZE;

BTRFS_ASYNC_DISCARD_MAX_SIZE won't be the upper limit anymore but a
default so it should be named as such.
