Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE91A0E33
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgDGNOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 09:14:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:45134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgDGNOw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 09:14:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B76C3ACCA;
        Tue,  7 Apr 2020 13:14:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1990DA727; Tue,  7 Apr 2020 15:14:14 +0200 (CEST)
Date:   Tue, 7 Apr 2020 15:14:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Move on-disk structure definition to btrfs_tree.h
Message-ID: <20200407131414.GS5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200407084434.46143-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407084434.46143-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 04:44:33PM +0800, Qu Wenruo wrote:
> These structures all are on-disk format. Move them to btrfs_tree.h
> 
> This move includes:
> - btrfs magic
>   It's a surprise that it's not even definied in btrfs_tree.h
> 
> - tree block max level
>   Move it before btrfs_header definition.
> 
> - tree block backref revision
> - btrfs_header structure
> - btrfs_root_backup structure
> - btrfs_super_block structure
> - BTRFS_FEATURE_* flags
> 
> - btrfs_item structure
> - btrfs_leaf structure
> - btrfs_key_ptr structure
> - btrfs_node structure
> 
> - BTRFS_INODE_* flags
>   Move them before btrfs_inode_item definition.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This moved btree_tree.h is more appropriate for btrfs-progs to reuse.

This actually answers 'why' the change is made so this should be in the
changelog but I still want to know the reason to move it to the header.
Do you mean that progs from git would be built #including this header
directly?
