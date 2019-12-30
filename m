Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1212D305
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 18:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfL3R6z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 12:58:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:41536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3R6z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 12:58:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 074FDAC92;
        Mon, 30 Dec 2019 17:58:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3FD5BDA790; Mon, 30 Dec 2019 18:58:47 +0100 (CET)
Date:   Mon, 30 Dec 2019 18:58:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/22] btrfs: add bps discard rate limit
Message-ID: <20191230175846.GY3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <42ac06bc7e0689f5cbd1778770b7177d2562140b.1576195673.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ac06bc7e0689f5cbd1778770b7177d2562140b.1576195673.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 04:22:23PM -0800, Dennis Zhou wrote:
> Provide an ability to rate limit based on mbps in addition to the iops
> delay calculated from number of discardable extents.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/ctree.h   |  2 ++
>  fs/btrfs/discard.c | 18 ++++++++++++++++++
>  fs/btrfs/sysfs.c   | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 98979566e281..1b2dae5962de 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -467,10 +467,12 @@ struct btrfs_discard_ctl {
>  	spinlock_t lock;
>  	struct btrfs_block_group *block_group;
>  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> +	u64 prev_discard;
>  	atomic_t discardable_extents;
>  	atomic64_t discardable_bytes;
>  	u32 delay;
>  	u32 iops_limit;
> +	u64 bps_limit;

I think this could be u32, which makes it 4G per second. Byte
granularity is IMO not necessary so it could be KiB/sec instead and it
would be future safe with maximum limit of 4TiB/sec.
