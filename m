Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF436CA40
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhD0RWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 13:22:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:60472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236279AbhD0RWS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 13:22:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3E13ACFD;
        Tue, 27 Apr 2021 17:21:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87F55DA732; Tue, 27 Apr 2021 19:19:11 +0200 (CEST)
Date:   Tue, 27 Apr 2021 19:19:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 11/26] btrfs-progs: zoned: implement zoned chunk allocator
Message-ID: <20210427171911.GM7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <b60a5f40ae0072ba9c7f1ba03036a703bb6b81ec.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60a5f40ae0072ba9c7f1ba03036a703bb6b81ec.1619416549.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 03:27:27PM +0900, Naohiro Aota wrote:
> Implement a zoned chunk and device extent allocator. One device zone
> becomes a device extent so that a zone reset affects only this device
> extent and does not change the state of blocks in the neighbor device
> extents.
> 
> To implement the allocator, we need to extend the following functions for
> a zoned filesystem.
> 
> - init_alloc_chunk_ctl
> - dev_extent_search_start

This function is not present in current btrfs-progs codebase

>  static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>  {
> +	u64 zone_size;
> +

So this does not apply. Looks like some intermediate patches are
missing. There's more missing code and several other conflicts.
