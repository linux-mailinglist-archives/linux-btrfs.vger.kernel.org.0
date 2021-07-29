Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E83DA9C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhG2RLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 13:11:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52942 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhG2RLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 13:11:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75BA122431;
        Thu, 29 Jul 2021 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627578699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t5e7+X59DY4jlQRCCNTuokhq7lLtCBYiYjvQLCWsEEc=;
        b=xN3sdU+S05wuKqqnHdB+BgLJKjJiJ7SEjthKd5+MitcbX3iqCJIA4EkxokdCtMSQ5KP3fz
        9VSGV7EIPS3SKjoGCQ45xTZGn3UIKf8Z1u2h+SxKbMenhyLa+MsnwnwxuN0KvW4W5Vc7tO
        TvAtaOG6DN5lCu66Yp+Vh8cEWHcH5fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627578699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t5e7+X59DY4jlQRCCNTuokhq7lLtCBYiYjvQLCWsEEc=;
        b=S6okcuTmG9KLWmLQzHac/7FBSyV9JUfQmEdUw4iBYDP5PdfrvFgtbb+CHApEw3eRoQ8Xe4
        AfAe8/QVWt4m4ACw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6FF94A3B85;
        Thu, 29 Jul 2021 17:11:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72C8CDA882; Thu, 29 Jul 2021 19:08:53 +0200 (CEST)
Date:   Thu, 29 Jul 2021 19:08:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/7] btrfs: Allocate btrfs_ioctl_get_subvol_info_args on
 stack
Message-ID: <20210729170851.GY5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210727211731.23394-1-rgoldwyn@suse.de>
 <2200f9340973d627ee304ac4470f5921061266f9.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2200f9340973d627ee304ac4470f5921061266f9.1627418762.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 04:17:27PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate btrfs_ioctl_get_subvol_info_args,
> allocate btrfs_ioctl_get_subvol_info_args on stack.
> 
> sizeof(btrfs_ioctl_get_subvol_info_args) = 504
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ioctl.c | 55 +++++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ba98e08a029..90b134b5a653 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2681,7 +2681,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
>  /* Get the subvolume information in BTRFS_ROOT_ITEM and BTRFS_ROOT_BACKREF */
>  static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>  {
> -	struct btrfs_ioctl_get_subvol_info_args *subvol_info;
> +	struct btrfs_ioctl_get_subvol_info_args subvol_info = {0};

There are concerns [1] if the {0} initialization zeroes all the bytes
entirely, including padding between members and at the end, but as I
understand it, this should be safe.

[1] long thread, https://lore.kernel.org/lkml/20210727205855.411487-20-keescook@chromium.org/T/#m7e4e04af9664f204232a569390c3f3dc2e4bf907

If it turns out {0} is not sufficient, we'll have to add explicit
memset() in case the on-stack structure is then copied back with
copy_to_user.
