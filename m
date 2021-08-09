Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA93E47D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhHIOnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 10:43:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45220 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhHIOkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 10:40:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59CEB21F8D;
        Mon,  9 Aug 2021 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628519979;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UxI6VlkrS2uqmisOJBUG4XoVM4URy95D/vV2KLWxek=;
        b=XuPcsWtzhosOyk84P3E7+1FXThtSCqPKhZ+aQHl7UXmnT4ie9za5YFOplrQm2Dh6BbMpE6
        cmxmMjFhmTB/rMZY1UyXUYuK+MVLt2FKdmJbIyDGD6C44uhTVtP8SqrmfO7YmsQW1k/NoR
        lnvdo8yDf2uPK1sXULTBqGFHyf+eEaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628519979;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UxI6VlkrS2uqmisOJBUG4XoVM4URy95D/vV2KLWxek=;
        b=A/foASG7e5KG4d+T+Bl2CfeF5w/ETrUB56nOGmYgVdSsBNL+c5a/wwIqEOI7eLXEgzf5PB
        G/37pacG6di9ZsCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 525ACA3B81;
        Mon,  9 Aug 2021 14:39:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E9C1DA880; Mon,  9 Aug 2021 16:36:46 +0200 (CEST)
Date:   Mon, 9 Aug 2021 16:36:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: map sysfs files to their path
Message-ID: <20210809143646.GO5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <8a0aac47cbdcc25b7ec861a5d334db1b6add34ae.1628125284.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0aac47cbdcc25b7ec861a5d334db1b6add34ae.1628125284.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 05, 2021 at 09:02:46AM +0800, Anand Jain wrote:
> Sysfs file has grown big. It takes some time to locate the correct
> struct attribute to add new files. Create a table and map the
> struct attribute to its sysfs path.
> 
> Also, fix the comment about the debug sysfs path.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index bfe5e27617b0..cb00c0c08949 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -22,6 +22,26 @@
>  #include "block-group.h"
>  #include "qgroup.h"
>  
> +
> +/*
> + * struct attributes (sysfs files)	sysfs path
> + * --------------------------------------------------------------------------
> + * btrfs_supported_static_feature_attrs /sys/fs/btrfs/features
> + * btrfs_supported_feature_attrs        /sys/fs/btrfs/features and
> + *					/sys/fs/btrfs/uuid/features (if visible)
> + * btrfs_debug_feature_attrs		/sys/fs/btrfs/debug
> + * btrfs_debug_mount_attrs		/sys/fs/btrfs/<uuid>/debug
> + * discard_debug_attrs			/sys/fs/btrfs/<uuid>/debug/discard
> + * btrfs_attrs				/sys/fs/btrfs/<uuid>
> + * devid_attrs				/sys/fs/btrfs/<uuid>/devinfo/<devid>
> + * allocation_attrs			/sys/fs/btrfs/<uuid>/allocation
> + * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<subvol-id>/
> + * space_info_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>
> + * raid_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>/<bg-profile>
> + */

I think this would be better next to the definitions, so you don't have
to repeat the identifier name and it's at the same location once we need
to add more attributes.
