Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8EB1D2E6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfJJQRp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 12:17:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfJJQRp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 12:17:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6488ADD9;
        Thu, 10 Oct 2019 16:17:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7A45DA7E3; Thu, 10 Oct 2019 18:17:57 +0200 (CEST)
Date:   Thu, 10 Oct 2019 18:17:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PULL REQUEST] btrfs-progs: For next merge window
Message-ID: <20191010161757.GV2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191010085932.39105-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010085932.39105-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 04:59:32PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/for_next
> Which is based on devel branch, with the following HEAD:

Thanks for putting the branch together, I've been too busy with kernel
work so progs are lagging behind constantly.

The current devel branch is almost ready for a release, some patches
will be moved to 5.4 but I'm planning to do release by tomorrow. I can
pull your branch as-is to 5.4 so we have time to fix any problems.

> commit d928fcabc8aed32b5ccab71220abcff9bffac377 (david/devel)
> Author: David Sterba <dsterba@suse.com>
> Date:   Mon Oct 7 18:23:52 2019 +0200
> 
>     btrfs-progs: add BLAKE2 to hash-speedtest
> 
> Please note that, for some binary test images, the patch from patchwork
> doesn't apply correctly and would cause empty files. Not sure if it's
> abug of patchwork.

I'm applying patches from my mailbox, I know that patchwork used to
misapply patches eg. when fragments of a diff were in the changelog so
I'm cautious in such cases. Thanks for letting us know anyway.
