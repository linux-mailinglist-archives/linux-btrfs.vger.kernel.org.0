Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7026C185
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 12:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIPKL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 06:11:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgIPKLi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 06:11:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2E5DB232;
        Wed, 16 Sep 2020 10:11:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C057DA7C7; Wed, 16 Sep 2020 12:10:03 +0200 (CEST)
Date:   Wed, 16 Sep 2020 12:10:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a warning to check on the leaking device close
Message-ID: <20200916101003.GM1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <8ad72827dc32542915f87db73cbb6b609f24dce4.1600074377.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad72827dc32542915f87db73cbb6b609f24dce4.1600074377.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 14, 2020 at 05:11:14PM +0800, Anand Jain wrote:
> To help better understand the device-close leaks, add a warning if the
> device freed is still open.

Have you seen that happen or is it just a precaution? I've checked where
the bdev is set to NULL and all paths seem to be covered, so the warn_on
does not harm anything just that it does not seem to be possible to hit.
For that an assert would be better.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2d5cc644741e..c0dfc0b569e9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -371,6 +371,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
>  void btrfs_free_device(struct btrfs_device *device)
>  {
>  	WARN_ON(!list_empty(&device->post_commit_list));
> +	WARN_ON(device->bdev);
>  	rcu_string_free(device->name);
>  	extent_io_tree_release(&device->alloc_state);
>  	bio_put(device->flush_bio);
> -- 
> 2.25.1
