Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD3120F25
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 17:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfLPQQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Dec 2019 11:16:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPQQm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Dec 2019 11:16:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A453B032;
        Mon, 16 Dec 2019 16:16:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DB98DA81D; Mon, 16 Dec 2019 17:16:39 +0100 (CET)
Date:   Mon, 16 Dec 2019 17:16:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix incorrect check causing NULL pointer
 derefernce
Message-ID: <20191216161639.GD3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Aditya Pakki <pakki001@umn.edu>,
        kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191215173226.29149-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215173226.29149-1-pakki001@umn.edu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 15, 2019 at 11:32:26AM -0600, Aditya Pakki wrote:
> In btrfsic_process_superblock, argument state is dereferenced for
> the variable fs_info and then checked for NULL. The patch fixes
> this issue by returning an error if state is NULL and then assigns
> fs_info.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/btrfs/check-integrity.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 0b52ab4cb964..70d7a05cafad 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -629,15 +629,18 @@ static struct btrfsic_dev_state *btrfsic_dev_state_hashtable_lookup(dev_t dev,
>  static int btrfsic_process_superblock(struct btrfsic_state *state,
>  				      struct btrfs_fs_devices *fs_devices)
>  {
> -	struct btrfs_fs_info *fs_info = state->fs_info;
> -	struct btrfs_super_block *selected_super;
> +	struct btrfsic_dev_state *selected_dev_state = NULL;
>  	struct list_head *dev_head = &fs_devices->devices;
> +	struct btrfs_super_block *selected_super;
> +	struct btrfs_fs_info *fs_info;
>  	struct btrfs_device *device;
> -	struct btrfsic_dev_state *selected_dev_state = NULL;
>  	int ret = 0;
>  	int pass;
>  
> -	BUG_ON(NULL == state);

A fix for this has already been merged to our development queue. Thanks.
