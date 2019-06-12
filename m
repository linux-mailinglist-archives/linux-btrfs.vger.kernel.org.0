Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925594275C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437655AbfFLNWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 09:22:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437469AbfFLNWN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 09:22:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C261AB5F;
        Wed, 12 Jun 2019 13:22:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 17488DA88C; Wed, 12 Jun 2019 15:23:01 +0200 (CEST)
Date:   Wed, 12 Jun 2019 15:23:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix race between block group removal and block
 group allocation
Message-ID: <20190612132301.GI3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190612100542.1848-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612100542.1848-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 11:05:42AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>

> Fixes: 04216820fe83d5 ("Btrfs: fix race between fs trimming and block group remove/allocation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> NOTE: this applies only to a 5.2 kernel, although the problem exists in previous
>       kernels starting from 3.19, due to recent changes in the 5.2 merge window
>       that removed the fs_info->pending_chunks, a slightly different version of
>       this patch is needed, one which locks and unlocks the chunk mutex inside
>       the moved block.

Thanks, I'll add it to misc-5.2, the type of the fix qualifies for a
late rc, so I'll send it by the end of the week.


>       Such patch version can be found here:
> 
>       https://www.dropbox.com/s/1sv0hd2xbsn9jrt/Btrfs-fix-race-between-block-group-removal-and-block.patch?dl=0

I'd prefer to get patches instead of links to dropbox. You can send more
patches in a series or as a reply to one of them and put the expected
target version to the subject to eg. like [PATCH for 5.2] or [PATCH for
<= 5.1] and put the note like the above with further details. Thanks.
