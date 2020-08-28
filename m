Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72126255E30
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH1PuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 11:50:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:40476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgH1PuC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 11:50:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89502AE33;
        Fri, 28 Aug 2020 15:50:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12F21DA7FF; Fri, 28 Aug 2020 17:48:52 +0200 (CEST)
Date:   Fri, 28 Aug 2020 17:48:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Misc cleanups around device addition
Message-ID: <20200828154851.GP28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200722080925.6802-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722080925.6802-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 11:09:21AM +0300, Nikolay Borisov wrote:
> Here are 4 minor cleanups around btrfs_init_new_device. First one converts
> a readonly usage of device_lists to using RCU. Second patch slightly simplifies
> the logic around locking when seed device is used. Third one removes a leftover
> from rewrite of btrfs_free_stale_devices. And the final one replaces an
> opencoded filemap_write_and_wait on the bdev inode with the more consistent
> sync_blockdev.
> 
> All these have passed xfstest and don't constitute functional changes.
> 
> Nikolay Borisov (4):
>   btrfs: Use rcu when iterating devices in btrfs_init_new_device
>   btrfs: Refactor locked condition in btrfs_init_new_device
>   btrfs: Remove redundant code from btrfs_free_stale_devices
>   btrfs: Don't opencode sync_blockdev

Added to for-next, thanks. I've updated patch 1 with explanation why RCU
is safe.
