Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F881E4523
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgE0OEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 10:04:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgE0OEh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 10:04:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81B44AE16;
        Wed, 27 May 2020 14:04:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DE06DA72D; Wed, 27 May 2020 16:03:39 +0200 (CEST)
Date:   Wed, 27 May 2020 16:03:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove BTRFS_INODE_IN_DELALLOC_LIST flag
Message-ID: <20200527140339.GI18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200527101104.7441-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527101104.7441-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 01:11:04PM +0300, Nikolay Borisov wrote:
> The flag simply replicates whether btrfs_inode::delallocs_inodes list
> is empty or not. Just defer this check to the list management functions
> (btrfs_add_delalloc_inodes/__btrfs_del_delalloc_inode) which are
> always called under btrfs_root::delalloc_lock.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Nice. Added to misc-next, thanks.
