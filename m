Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B6A23490D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgGaQRI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 12:17:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:48518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgGaQRH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 12:17:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8A06ACA3;
        Fri, 31 Jul 2020 16:17:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B7C1DA82B; Fri, 31 Jul 2020 18:16:35 +0200 (CEST)
Date:   Fri, 31 Jul 2020 18:16:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: convert: better ENOSPC handling
Message-ID: <20200731161634.GP3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200729084038.78151-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729084038.78151-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 29, 2020 at 04:40:35PM +0800, Qu Wenruo wrote:
> This patchset is to address a bug report [1], where even with the bit
> overflow bug fixed, the user is still unable to convert an ext4 fs to
> btrfs.
> 
> The error is -ENOSPC, which triggers BUG_ON() and brings the end to the
> convertion.
> 
> We're still waiting for the image dump to determine what's the real
> cause is, but considering the user is still reporting around 40% free
> space, I guess it's something wrong with the extent allocator.
> 
> But still, we can enhance btrfs-convert to make it handle errors more
> gracefully, with better error message, and even some debugging info like
> the available space / total space ratio.
> 
> Qu Wenruo (3):
>   btrfs-progs: convert: handle errors better in ext2_copy_inodes()
>   btrfs-progs: convert: update error message to reflect original fs
>     unmodified cases
>   btrfs-progs: convert: report available space before convertion happens

Added to devel, thanks. With the fixup and I've updated the space report
to look like this:

create btrfs filesystem:
        blocksize: 4096
        nodesize:  16384
        features:  extref, skinny-metadata (default)
        checksum:  crc32c
free space report:
        total:     2147483648
        free:      1610547200 (75.00%)
