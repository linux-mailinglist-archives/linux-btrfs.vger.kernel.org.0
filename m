Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7138B06A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhETNvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 09:51:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhETNvu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 09:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15A54ABCD;
        Thu, 20 May 2021 13:50:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E200DA781; Thu, 20 May 2021 15:47:54 +0200 (CEST)
Date:   Thu, 20 May 2021 15:47:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: fixes for the 13 subpage preparation
 patches
Message-ID: <20210520134754.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210518070942.206846-1-wqu@suse.com>
 <20210518210928.GV7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518210928.GV7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 18, 2021 at 11:09:28PM +0200, David Sterba wrote:
> On Tue, May 18, 2021 at 03:09:40PM +0800, Qu Wenruo wrote:
> > v3:
> > - Change the fix for the btrfs/215 hang
> >   Now we choose to skip the locked page, leaving both its Ordered bit
> >   and ordered extent accounting to be handled by run_delalloc_range()
> >   error hanlding path.
> > 
> >   This fixes a possible ordered extent underflow, and removes a forward
> >   declaration.
> 
> There are 2 finished fstests runs and it did hang or crash so it seems
> to be fixed, thanks. I haven't verified individual tests that reported
> some output mismatch, so can't say if they're known false positives or
> possibly related to your patches. I'll try to take a look tomorrow.

Patch 2 folded and patch 1 added to the rest of the patchset, now merged
to misc-next. Thanks.
