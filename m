Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3060266566
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgIKRBR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 13:01:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:47810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgIKPEY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 11:04:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB7A5AE70;
        Fri, 11 Sep 2020 14:03:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D585ADA87D; Fri, 11 Sep 2020 16:02:16 +0200 (CEST)
Date:   Fri, 11 Sep 2020 16:02:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/5] btrfs: fix enospc and transaction aborts during
 fallocate
Message-ID: <20200911140216.GQ18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599560101.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 08, 2020 at 11:27:19AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When attempting to fallocate on a large file range with many file extent
> items, the operation can fail with ENOSPC when it shouldn't and, more
> critical, abort the transaction and turn the filesystem to RO mode.
> 
> First patch fixes the issue, the remaining just do some cleanups after it.
> 
> Filipe Manana (5):
>   btrfs: fix metadata reservation for fallocate that leads to
>     transaction aborts
>   btrfs: remove item_size member of struct btrfs_clone_extent_info
>   btrfs: rename struct btrfs_clone_extent_info to a more generic name
>   btrfs: rename btrfs_punch_hole_range() to a more generic name
>   btrfs: rename btrfs_insert_clone_extent() to a more generic name

Added to misc-next, thanks.
