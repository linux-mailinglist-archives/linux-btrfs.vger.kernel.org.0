Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752ED2D6154
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 17:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392379AbgLJQLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 11:11:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:58900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387589AbgLJQLM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 11:11:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFEE1AF1F;
        Thu, 10 Dec 2020 16:10:31 +0000 (UTC)
Date:   Thu, 10 Dec 2020 10:10:29 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, osandov@osandov.com
Subject: Re: [PATCH 1/2] btrfs: Fold generic_write_checks() in
 btrfs_write_check()
Message-ID: <20201210161029.vi7ay6zslsnsklmn@fiona>
References: <cover.1607449636.git.rgoldwyn@suse.com>
 <8dabce11b6bc9dc4ba534a2d5cf169ca3d0a812d.1607449636.git.rgoldwyn@suse.com>
 <20201210114756.GD6430@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210114756.GD6430@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12:47 10/12, David Sterba wrote:
> On Tue, Dec 08, 2020 at 12:42:40PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Code Cleanup.
> > 
> > Fold generic_write_checks() in btrfs_write_check(), because
> > generic_write_checks() is called before btrfs_write_check() in both
> > cases. The prototype of btrfs_write_check() has been changed to return
> > ssize_t and it can return zero as a valid error code. btrfs_write_check
> > now returns the count of I/O to be performed.
> 
> That's effectively reverting what Omar sent as a fix to your initial
> patch:
> 
> https://lore.kernel.org/linux-btrfs/b096cecce8277b30e1c7e26efd0450c0bc12ff31.1605723568.git.osandov@fb.com/
> 
> fixing a problem. Now you revert that to fix another problem, now with
> the lock added. I'd rather have one patch without this cleanup and given
> that this is technically fixing a regression in the new 5.11 code it'll
> go to post rc1 pull request.

This patchset fixes the problems mentioned there since both count and
pos are accessed after the btrfs_write_check is called. However, this
should be rejected because of the RWF_ENCODED work.

I will post a patch for fixing the regression only.

-- 
Goldwyn
