Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A307317347
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhBJWXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:23:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:46100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbhBJWXt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C4C0AC6E;
        Wed, 10 Feb 2021 22:23:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80050DA6E9; Wed, 10 Feb 2021 23:21:14 +0100 (CET)
Date:   Wed, 10 Feb 2021 23:21:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: add proper subpage compress read support
Message-ID: <20210210222114.GY1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210204070324.45703-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204070324.45703-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 04, 2021 at 03:03:22PM +0800, Qu Wenruo wrote:
> During the long time subpage development, I forgot to properly check
> compression code after just one compression read success during early
> development.
> 
> It turns out that, with current RO support, the compression read needs
> more modification to make it work.
> 
> Thankfully, the patchset is small, and should not cause problems for
> regular sectorsize == PAGE_SIZE case.
> 
> Thanks Anand for exposing the problems.
> 
> Qu Wenruo (2):
>   btrfs: make btrfs_submit_compressed_read() to be subpage compatible
>   btrfs: make check_compressed_csum() to be subpage compatible

Thanks, now in for-next, will go to 5.12-rc as regression fixes.
