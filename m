Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8124D610
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHUN1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 09:27:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:39300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgHUN1e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 09:27:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEC4CAC23;
        Fri, 21 Aug 2020 13:28:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4460DA730; Fri, 21 Aug 2020 15:26:26 +0200 (CEST)
Date:   Fri, 21 Aug 2020 15:26:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs-progs: Make btrfs_lookup_dir_index in parity with
 kernel code
Message-ID: <20200821132626.GE2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200818144324.25917-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818144324.25917-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 18, 2020 at 11:43:24AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This function exists in kernel side but using the _item suffix, and
> objectid argument is placed before the name argument. Change the
> function to reflect the kernel version.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  check/main.c             |  6 +++---
>  ctree.h                  | 11 ++++++-----
>  inode.c                  | 14 +++++++-------
>  kernel-shared/dir-item.c | 13 +++++++------
>  4 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index f93bd7d4..176bc508 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -2072,9 +2072,9 @@ static int delete_dir_index(struct btrfs_root *root,
>  		(unsigned long long)root->objectid);
>  
>  	btrfs_init_path(&path);
> -	di = btrfs_lookup_dir_index(trans, root, &path, backref->dir,
> -				    backref->name, backref->namelen,
> -				    backref->index, -1);
> +	di = btrfs_lookup_dir_index_item(trans, root, &path, backref->dir,
> +					 backref->index, backref->name,
> +					 backref->namelen, -1);
>  	if (IS_ERR(di)) {
>  		ret = PTR_ERR(di);
>  		btrfs_release_path(&path);
> diff --git a/ctree.h b/ctree.h
> index 39e03640..a4f70847 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -2760,11 +2760,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
>  					     struct btrfs_path *path, u64 dir,
>  					     const char *name, int name_len,
>  					     int mod);
> -struct btrfs_dir_item *btrfs_lookup_dir_index(struct btrfs_trans_handle *trans,
> -					      struct btrfs_root *root,
> -					      struct btrfs_path *path, u64 dir,
> -					      const char *name, int name_len,
> -					      u64 index, int mod);
> +struct btrfs_dir_item *
> +btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
> +			    struct btrfs_root *root,
> +			    struct btrfs_path *path, u64 dir,
> +			    u64 objectid, const char *name, int name_len,
> +			    int mod);

Please keep the function return type and name on the same line, this is
the preferred style. There are still a lot of wrongly formatted
functions in kernel like btrfs_lookup_dir_index_item but it should not
be in the new code.
