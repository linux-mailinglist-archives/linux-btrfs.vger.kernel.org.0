Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045601D5843
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEORtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 13:49:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgEORtY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 13:49:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20CCBAA7C;
        Fri, 15 May 2020 17:49:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EBA67DA732; Fri, 15 May 2020 19:48:30 +0200 (CEST)
Date:   Fri, 15 May 2020 19:48:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix comment drop reference to volume_mutex
Message-ID: <20200515174830.GO18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200513174245.25956-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513174245.25956-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 14, 2020 at 01:42:45AM +0800, Anand Jain wrote:
> No functional changes.
> commit dccdb07bc996 (btrfs: kill btrfs_fs_info::volume_mutex)
> killed the volume_mutex. Drop all references to volumes_mutex
> including the comment sections.
> 
> Fixes: dccdb07bc996 (btrfs: kill btrfs_fs_info::volume_mutex)

The right format is

Fixes: hash ("subject")

but fixing a comment does not really need that tag and be backported to
stable kernels.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index be1e047a489e..60ab41c12e50 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -280,7 +280,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   * ============
>   *
>   * uuid_mutex
> - *   volume_mutex
>   *     device_list_mutex
>   *       chunk_mutex
>   *     balance_mutex

As this removes one level, the other locks should be un-indented. I'll
fix that, no need to resend.
