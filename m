Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07257365EB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 19:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhDTRhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 13:37:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhDTRhl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 13:37:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D36C6AF8A;
        Tue, 20 Apr 2021 17:37:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1A990DA83A; Tue, 20 Apr 2021 19:34:50 +0200 (CEST)
Date:   Tue, 20 Apr 2021 19:34:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: fix unpaired block group unfreeze
 during device replace
Message-ID: <20210420173449.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <a76c376dfb6b391b96986c03664ecb657a24b012.1618402032.git.fdmanana@suse.com>
 <c42ce5b381e7b6cb8148b422acb21895c316f253.1618405401.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c42ce5b381e7b6cb8148b422acb21895c316f253.1618405401.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 02:05:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a device replace on a zoned filesystem, if we find a block
> group with ->to_copy == 0, we jump to the label 'done', which will result
> in later calling btrfs_unfreeze_block_group(), even though at this point
> we never called btrfs_freeze_block_group().
> 
> Since at this point we have neither turned the block group to RO mode nor
> made any progress, we don't need to jump to the label 'done'. So fix this
> by jumping instead to the label 'skip' and dropping our reference on the
> block group before the jump.
> 
> Fixes: 78ce9fc269af6e ("btrfs: zoned: mark block groups to copy for device-replace")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, added to misc-next. It's a regression fix for 5.12 but IMHO not
critical enough for a pull request. 5.12 is about to be released in a
week, with CC: stable the will be published soon after.
