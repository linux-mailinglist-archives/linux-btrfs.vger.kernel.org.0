Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42233625EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhDPQnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 12:43:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhDPQnp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 12:43:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BB6AB0BD;
        Fri, 16 Apr 2021 16:43:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB823DA790; Fri, 16 Apr 2021 18:41:02 +0200 (CEST)
Date:   Fri, 16 Apr 2021 18:41:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4 3/3] btrfs: zoned: automatically reclaim zones
Message-ID: <20210416164102.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <920701be19f36b4f7ed84efd53a3d0550700f047.1618494550.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920701be19f36b4f7ed84efd53a3d0550700f047.1618494550.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 10:58:35PM +0900, Johannes Thumshirn wrote:
> @@ -2974,6 +2982,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	fs_info->swapfile_pins = RB_ROOT;
>  
>  	fs_info->send_in_progress = 0;
> +
> +	fs_info->bg_reclaim_threshold = 75;

The value should be a named constant visible defined in zoned.h with a
comment what it means.
