Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714D0100867
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 16:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKRPjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 10:39:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:46276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbfKRPjh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 10:39:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98F06AD33;
        Mon, 18 Nov 2019 15:39:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57F80DA823; Mon, 18 Nov 2019 16:39:37 +0100 (CET)
Date:   Mon, 18 Nov 2019 16:39:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/15] btrfs: sysfs, delete code in a comment
Message-ID: <20191118153937.GH3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191118084656.3089-1-anand.jain@oracle.com>
 <20191118084656.3089-8-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118084656.3089-8-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 04:46:48PM +0800, Anand Jain wrote:
> commit 3ebb2ada (btrfs: sysfs: export supported checksums), added some unwanted
> commented-code, delete it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 724af1322dce..9494ccace624 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -255,16 +255,6 @@ BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>  
> -/*
> -static struct btrfs_feature_attr btrfs_attr_features_checksums_name = {
> -	.kobj_attr = __INIT_KOBJ_ATTR(supported_checksums, S_IRUGO,
> -				      btrfs_supported_checksums_show,
> -				      NULL),
> -	.feature_set	= FEAT_INCOMPAT,
> -	.feature_bit	= 0,
> -};
> -*/

Uh, I'll fold that to the patch that introduced it, thanks for spotting
it.
