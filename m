Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41D1C9535
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGPgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 11:36:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:39504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgEGPgm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 11:36:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7AEB7ABE2;
        Thu,  7 May 2020 15:36:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C3DF5DA732; Thu,  7 May 2020 17:35:52 +0200 (CEST)
Date:   Thu, 7 May 2020 17:35:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] Btrfs : improve the speed of compare orphan item and
 dead roots with tree root when mount
Message-ID: <20200507153552.GK18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200507025440.6619-1-robbieko@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507025440.6619-1-robbieko@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 07, 2020 at 10:54:40AM +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
> 
> When mounting, we handle deleted subvol and orphan items.
> First, find add orphan roots, then add them to fs_root radix tree.
> Second, in tree-root, process each orphan item, skip if it is dead root.
> 
> The original algorithm is based on the list of dead_roots,
> one by one to visit and check whether the objectid is consistent,
> the time complexity is O (n ^ 2).
> When processing 50000 deleted subvols, it takes about 120s.
> 
> Because btrfs_find_orphan_roots has already ran before us,
> and added deleted subvol to fs_roots radix tree.
> 
> The fs root will only be removed from the fs_roots radix tree
> after the cleaner is processed, and the cleaner will only start
> execution after the mount is complete.
> 
> btrfs_orphan_cleanup can be called during the whole filesystem mount
> lifetime, but only "tree root" will be used in this section of code,
> and only mount time will be brought into tree root.
> 
> So we can quickly check whether the orphan item is dead root
> through the fs_roots radix tree.
> 
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
> Changes in v2:
> - update changelog

Thanks, added to misc-next, with the updated subject.
