Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA74D36272A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 19:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbhDPRtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 13:49:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:46590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235563AbhDPRtM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 13:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC189AE57;
        Fri, 16 Apr 2021 17:48:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0CE8FDA790; Fri, 16 Apr 2021 19:46:29 +0200 (CEST)
Date:   Fri, 16 Apr 2021 19:46:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: misc-tests: add test to ensure the
 restored image can be mounted
Message-ID: <20210416174629.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210326125047.123694-1-wqu@suse.com>
 <20210326125047.123694-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326125047.123694-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 26, 2021 at 08:50:47PM +0800, Qu Wenruo wrote:
> This new test case is to make sure the restored image file has been
> properly enlarged so that newer kernel won't complain.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  .../047-image-restore-mount/test.sh           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100755 tests/misc-tests/047-image-restore-mount/test.sh
> 
> diff --git a/tests/misc-tests/047-image-restore-mount/test.sh b/tests/misc-tests/047-image-restore-mount/test.sh
> new file mode 100755
> index 000000000000..7f12afa2bab6
> --- /dev/null
> +++ b/tests/misc-tests/047-image-restore-mount/test.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +# Verify that the restored image of an empty btrfs can still be mounted
                                                ^^^^^

I've seen that in patches and comments, the use of word 'btrfs' instead
of 'filesystem' sounds a bit inappropriate to me, so I change it
whenever I see it. It's perhaps matter of taste and style, one can write
it also as 'btrfs filesystem' but that may belong to some more polished
documentation, so you can go with just 'filesystem'.
