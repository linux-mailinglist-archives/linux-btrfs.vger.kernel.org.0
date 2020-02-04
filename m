Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92FE152238
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 23:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgBDWF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 17:05:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:40752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDWF2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 17:05:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF377AD07;
        Tue,  4 Feb 2020 22:05:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19370DA80D; Tue,  4 Feb 2020 23:05:12 +0100 (CET)
Date:   Tue, 4 Feb 2020 23:05:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 01/44] btrfs: push __setup_root into btrfs_alloc_root
Message-ID: <20200204220512.GH2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:18AM -0500, Josef Bacik wrote:
> @@ -2645,8 +2639,10 @@ int __cold open_ctree(struct super_block *sb,
>  	int clear_free_space_tree = 0;
>  	int level;
>  
> -	tree_root = fs_info->tree_root = btrfs_alloc_root(fs_info, GFP_KERNEL);
> -	chunk_root = fs_info->chunk_root = btrfs_alloc_root(fs_info, GFP_KERNEL);
> +	tree_root = fs_info->tree_root = btrfs_alloc_root(fs_info,
> +					BTRFS_ROOT_TREE_OBJECTID, GFP_KERNEL);
> +	chunk_root = fs_info->chunk_root = btrfs_alloc_root(fs_info,
> +					BTRFS_CHUNK_TREE_OBJECTID, GFP_KERNEL);

Chaned assignments should be split to individual assignments when the code
is changed. Updated.
