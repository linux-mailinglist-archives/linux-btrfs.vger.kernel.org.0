Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D594542A5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439996AbfFLPIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 11:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:53638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439910AbfFLPIV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 11:08:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4BE9ADD5
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 15:08:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 543ADDA8F5; Wed, 12 Jun 2019 17:09:11 +0200 (CEST)
Date:   Wed, 12 Jun 2019 17:09:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: Introduce "rescue=" mount option
Message-ID: <20190612150910.GP3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612063657.21063-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 02:36:56PM +0800, Qu Wenruo wrote:
> This patch introduces a new "rescue=" mount option for all those mount
> options for data recovery.
> 
> Different rescue sub options are seperated by ':'. E.g
> "ro,rescue=no_log_replay:use_backup_root".
> (The original plan is to use ';', but ';' needs to be escaped/quoted,
> or it will be interpreted by bash)

':' as separator is fine

> The following mount options are converted to "rescue=", old mount
> options are deprecated but still available for compatibility purpose:
> 
> - usebackuproot
>   Now it's "rescue=use_backup_root"
> 
> - nologreplay
>   Now it's "rescue=no_log_replay"
> 
> The new underscore is here to make the option more readable and make
> spell check happier.

Who uses spell checker on mount options, really? I'd expect that the new
syntax would build on top of the old so the exact same names of the
options are now shifted to the value of 'rescue='.

The usability is better with switching

  -o usebackuproot

to

  -o rescue=usebackuproot

ie. just prepending 'rescue='.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/super.c | 65 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 64f20725615a..4512f25dcf69 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -310,7 +310,6 @@ enum {
>  	Opt_datasum, Opt_nodatasum,
>  	Opt_defrag, Opt_nodefrag,
>  	Opt_discard, Opt_nodiscard,
> -	Opt_nologreplay,
>  	Opt_ratio,
>  	Opt_rescan_uuid_tree,
>  	Opt_skip_balance,
> @@ -323,7 +322,6 @@ enum {
>  	Opt_subvolid,
>  	Opt_thread_pool,
>  	Opt_treelog, Opt_notreelog,
> -	Opt_usebackuproot,
>  	Opt_user_subvol_rm_allowed,
>  
>  	/* Deprecated options */
> @@ -341,6 +339,8 @@ enum {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	Opt_ref_verify,
>  #endif
> +	/* Rescue options */
> +	Opt_rescue, Opt_usebackuproot, Opt_nologreplay,

The options have been sorted and grouped, don't mess it up again please.
Check the list and find a better place than after the deprecated and
debugging options.
