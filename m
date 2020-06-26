Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CEE20B112
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgFZL7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 07:59:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:37778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgFZL7u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 07:59:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B5D9AFE8;
        Fri, 26 Jun 2020 11:59:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27AB2DAA08; Fri, 26 Jun 2020 13:59:36 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:59:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Introduce btrfs_inode_lock()/unlock()
Message-ID: <20200626115935.GE27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
 <20200622162017.21773-5-rgoldwyn@suse.de>
 <20200624161913.GY27795@twin.jikos.cz>
 <20200625173411.dybgtjdwo2veminm@fiona>
 <4c2e410d-b076-efe7-41a5-aa7b8a1aa773@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2e410d-b076-efe7-41a5-aa7b8a1aa773@knorrie.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 26, 2020 at 01:34:05PM +0200, Hans van Kranenburg wrote:
> On 6/25/20 7:34 PM, Goldwyn Rodrigues wrote:
> > On 18:19 24/06, David Sterba wrote:
> >> On Mon, Jun 22, 2020 at 11:20:13AM -0500, Goldwyn Rodrigues wrote:
> >>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >>>
> >>> btrfs_inode_lock/unlock() acquires the inode->i_rwsem depending on the
> >>> flags passed. ilock_flags determines the type of lock to be taken:
> >>>
> >>> BTRFS_ILOCK_SHARED - for shared locks, for possible parallel DIO
> >>> BTRFS_ILOCK_TRY - for the RWF_NOWAIT sequence
> >>>
> >>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >>> ---
> >>>  fs/btrfs/ctree.h |  8 ++++++++
> >>>  fs/btrfs/file.c  | 51 +++++++++++++++++++++++++++++++++++++++---------
> >>>  2 files changed, 50 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >>> index 161533040978..346fea668ca0 100644
> >>> --- a/fs/btrfs/ctree.h
> >>> +++ b/fs/btrfs/ctree.h
> >>> @@ -2953,6 +2953,14 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
> >>>  			       struct btrfs_ioctl_balance_args *bargs);
> >>>  
> >>>  /* file.c */
> >>> +
> >>> +/* ilock flags definition */
> >>> +#define BTRFS_ILOCK_SHARED	0x1
> >>> +#define BTRFS_ILOCK_TRY 	0x2
> >>
> >> Please use enums and add them to a new file inode.h.
> > 
> > These are bitwise flags.
> 
> I suspect that in that case it's more common to do:
> 
> #define BTRFS_ILOCK_SHARED	(1 << 0)
> #define BTRFS_ILOCK_TRY 	(1 << 1)

Yeah, that looks more clear that it's meant for bitwise operations.

We don't have any other enum for bitwise flags so define is ok for now.
