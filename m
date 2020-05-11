Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2B1CE309
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgEKSv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 14:51:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:57832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgEKSv3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 14:51:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE96AAC40;
        Mon, 11 May 2020 18:51:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B49BFDA82A; Mon, 11 May 2020 20:50:37 +0200 (CEST)
Date:   Mon, 11 May 2020 20:50:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs-progs: Sync code for btrfs_block_group
Message-ID: <20200511185037.GW18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200501065219.484868-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501065219.484868-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 02:52:15PM +0800, Qu Wenruo wrote:
> This patchset mostly make btrfs_block_group structure to sync with
> kernel, providing the basis for later modification. (Hint: skinny bg
> tree)
> 
> Changelog:
> v2:
> - Add a patch to sync the block group item accessors
> 
> Qu Wenruo (4):
>   btrfs-progs: Sync block group item accessors from kernel
>   btrfs-progs: Kill block_group_cache::key
>   btrfs-progs: Remove the unused btrfs_block_group_cache::cache
>   btrfs-progs: Rename btrfs_block_group_cache to btrfs_block_group

All added to devel, thanks.
