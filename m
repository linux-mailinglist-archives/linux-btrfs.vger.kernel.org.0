Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA0949B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHSQVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 12:21:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfHSQVk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 12:21:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96069AEFD;
        Mon, 19 Aug 2019 16:21:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 632ECDA7DA; Mon, 19 Aug 2019 18:22:06 +0200 (CEST)
Date:   Mon, 19 Aug 2019 18:22:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/5] btrfs: refactor priority_reclaim_metadata_space
Message-ID: <20190819162206.GF24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190801221937.22742-1-josef@toxicpanda.com>
 <20190801221937.22742-5-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801221937.22742-5-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 01, 2019 at 06:19:36PM -0400, Josef Bacik wrote:
> With the eviction flushing stuff we'll want to allow for different
> states, but still work basically the same way that
> priority_reclaim_metadata_space works currently.  Refactor this to take
> the flushing states and size as an argument so we can use the same logic
> for limit flushing and eviction flushing.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 71749b355136..03556e411b11 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -868,9 +868,12 @@ static const enum btrfs_flush_state priority_flush_states[] = {
>  	ALLOC_CHUNK,
>  };
>  
> -static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
> -					    struct btrfs_space_info *space_info,
> -					    struct reserve_ticket *ticket)
> +static void
> +priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,

Please note that the split type and function name is the reverse of the
coding style used in btrfs, I fix such things but please don't introduce
it in new patches namely when the original code is using the correct
style.
