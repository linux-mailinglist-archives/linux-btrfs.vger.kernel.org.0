Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44FF1533EB
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBEPdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 10:33:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgBEPdt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 10:33:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E0CCACBD;
        Wed,  5 Feb 2020 15:16:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C09BDA7E6; Wed,  5 Feb 2020 16:16:24 +0100 (CET)
Date:   Wed, 5 Feb 2020 16:16:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 31/44] btrfs: hold a ref on the root in btrfs_ioctl_send
Message-ID: <20200205151624.GR2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-32-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-32-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:48AM -0500, Josef Bacik wrote:
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -7200,11 +7200,17 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>  				ret = PTR_ERR(clone_root);
>  				goto out;
>  			}
> +			if (!btrfs_grab_fs_root(clone_root)) {
> +				srcu_read_unlock(&fs_info->subvol_srcu, index);
> +				ret = -ENOENT;
> +				goto out;
> +			}
>  			spin_lock(&clone_root->root_item_lock);
>  			if (!btrfs_root_readonly(clone_root) ||
>  			    btrfs_root_dead(clone_root)) {
>  				spin_unlock(&clone_root->root_item_lock);
>  				srcu_read_unlock(&fs_info->subvol_srcu, index);
> +				btrfs_put_fs_root(clone_root);

Here and

>  				ret = -EPERM;
>  				goto out;
>  			}
> @@ -7212,6 +7218,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>  				dedupe_in_progress_warn(clone_root);
>  				spin_unlock(&clone_root->root_item_lock);
>  				srcu_read_unlock(&fs_info->subvol_srcu, index);
> +				btrfs_put_fs_root(clone_root);

here, the order is srcu, put ref. As it's on error handling path anyway
it's no big deal, but I'd rather swap them so the nesting is proper,
tree refs inside srcu section.
