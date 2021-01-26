Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4FF3057F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314283AbhAZXGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:06:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:55230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbhAZTn5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 14:43:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 501E1ACC6;
        Tue, 26 Jan 2021 19:43:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0232EDA7D2; Tue, 26 Jan 2021 20:41:28 +0100 (CET)
Date:   Tue, 26 Jan 2021 20:41:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 02/12] btrfs: add a trace point for reserve tickets
Message-ID: <20210126194128.GY1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
 <a950d7af5cd8b905b951c83db0c144177235abbc.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a950d7af5cd8b905b951c83db0c144177235abbc.1602249928.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 09, 2020 at 09:28:19AM -0400, Josef Bacik wrote:
> While debugging a ENOSPC related performance problem I needed to see the
> time difference between start and end of a reserve ticket, so add a
> trace point to report when we handle a reserve ticket.
> 
> I opted to spit out start_ns itself without calculating the difference
> because there could be a gap between enabling the tracpoint and setting
> start_ns.  Doing it this way allows us to filter on 0 start_ns so we
> don't get bogus entries, and we can easily calculate the time difference
> with bpftrace or something else.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c        | 10 +++++++++-
>  include/trace/events/btrfs.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index ba2b72409d46..ac7269cf1904 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1224,6 +1224,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
>  static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>  				 struct btrfs_space_info *space_info,
>  				 struct reserve_ticket *ticket,
> +				 u64 start_ns, u64 orig_bytes,

Added

+ * @start_ns:   timestamp when the reservation started
+ * @orig_bytes: amount of bytes originally reserved

caught by the recently added kdoc verification.

>  				 enum btrfs_reserve_flush_enum flush)
