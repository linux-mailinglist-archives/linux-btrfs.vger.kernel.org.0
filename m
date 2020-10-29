Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3221529F280
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgJ2RFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 13:05:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgJ2RFH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 13:05:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F39DAD11;
        Thu, 29 Oct 2020 17:05:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F294DA7CE; Thu, 29 Oct 2020 18:03:30 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:03:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 04/12] btrfs: introduce a FORCE_COMMIT_TRANS flush
 operation
Message-ID: <20201029170330.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1602249928.git.josef@toxicpanda.com>
 <58ae7655908a28c446139452ea8f5210d590acb4.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ae7655908a28c446139452ea8f5210d590acb4.1602249928.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 09, 2020 at 09:28:21AM -0400, Josef Bacik wrote:
> Sole-y for preemptive flushing, we want to be able to force the
> transaction commit without any of the ambiguity of
> may_commit_transaction().  This is because may_commit_transaction()
> checks tickets and such, and in preemptive flushing we already know
> it'll be helpful, so use this to keep the code nice and clean and
> straightforward.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h             | 1 +
>  fs/btrfs/space-info.c        | 8 ++++++++
>  include/trace/events/btrfs.h | 3 ++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index e817b3b3483d..84c5db91dc44 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2654,6 +2654,7 @@ enum btrfs_flush_state {
>  	ALLOC_CHUNK_FORCE	=	8,
>  	RUN_DELAYED_IPUTS	=	9,
>  	COMMIT_TRANS		=	10,
> +	FORCE_COMMIT_TRANS	=	11,

This new state is not documented in space-info.c (before
btrfs_space_info_used).
