Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9096437987E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhEJUpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 16:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhEJUpQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 16:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 576D5AC1A;
        Mon, 10 May 2021 20:44:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A550DB228; Mon, 10 May 2021 22:41:41 +0200 (CEST)
Date:   Mon, 10 May 2021 22:41:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/4] btrfs: make read time repair to be only submitted
 for each corrupted sector
Message-ID: <20210510204141.GE7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503020856.93333-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 03, 2021 at 10:08:52AM +0800, Qu Wenruo wrote:
> Btrfs read time repair has to handle two different cases when a corruption
> or read failure is hit:
> - The failed bio contains only one sector
>   Then it only need to find a good copy
> 
> - The failed bio contains several sectors
>   Then it needs to find which sectors really need to be repaired
> 
> But this different behaviors are not really needed, as we can teach btrfs
> to only submit read repair for each corrupted sector.
> By this, we only need to handle the one-sector corruption case.
> 
> This not only makes the code smaller and simpler, but also benefits subpage,
> allow subpage case to use the same infrastructure.
> 
> For current subpage code, we hacked the read repair code to make full
> bvec read repair, which has less granularity compared to regular sector
> size.
> 
> The code is still based on subpage branch, but can be forward ported to
> non-subpage code basis with minor conflicts.
> 
> Changelog:
> v2:
> - Split the original patch
>   Now we have two preparation patches, then the core change.
>   And finally a cleanup.
> 
> - Fix the uninitialize @error_bitmap when the bio read fails.
> 
> v3:
> - Fix the return value type mismatch in repair_one_sector()
>   An error happens in v2 patch split, which can lead to hang when
>   we can't repair the error.

Patchset added to for-next. The cleanups and simplifications look good
to me, thanks.
