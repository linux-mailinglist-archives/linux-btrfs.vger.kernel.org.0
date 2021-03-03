Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57F532C543
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450345AbhCDATw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:45612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447558AbhCCPEW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Mar 2021 10:04:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23B42AD29;
        Wed,  3 Mar 2021 14:43:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8BAB6DA82B; Wed,  3 Mar 2021 15:41:17 +0100 (CET)
Date:   Wed, 3 Mar 2021 15:41:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add a warning label for RAID5/6
Message-ID: <20210303144117.GK7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 25, 2020 at 12:51:02PM -0400, Josef Bacik wrote:
> We all know there's some dark and scary corners with RAID5/6, but users
> may not know.  Add a warning message in mkfs so anybody trying to use
> this will know things can go very wrong.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  mkfs/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 0a4de617..0db24ad4 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1183,6 +1183,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	if ((data_profile | metadata_profile) &
>  	    (BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6)) {
>  		features |= BTRFS_FEATURE_INCOMPAT_RAID56;
> +		warning("RAID5/6 support is still experimental and has known "
> +			"issues, do not rely on this for data you care about.\n");

I've reworded the message, calling it experimental after so many years
is a bit kappa. Also we'll need something in the docs for reference,
I'll write something.

>  	}
>  
>  	if ((data_profile | metadata_profile) &
> -- 
> 2.24.1
