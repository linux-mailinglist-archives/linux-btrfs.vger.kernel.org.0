Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C098538F3D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhEXTsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 15:48:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhEXTsI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 15:48:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621885599;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTmcr7NiHjQpmW6g1E+NAikZdseeNjz58EIYfWwBu8Y=;
        b=yUxITn2JaR0M6zPeFzj6pnHmRQPyoyxCyie0pqqbxUi7zzUz5wEucCC29Ne0Qj7Rf3THoM
        YRUEDrCwIQz859fQOEXhwa+QvztUebwCR4jUvWzJ3SWTX2U2uuYvbKoUq324Ki8wiFVKJ4
        d0CprbTwfBM72Yz1Ki2gokWTcS4bgtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621885599;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTmcr7NiHjQpmW6g1E+NAikZdseeNjz58EIYfWwBu8Y=;
        b=GmMb002xDnLDo95DUN2/kCROYalFq8x+E2q7H0qly5hO4ItgVmbJQ0UFum94PyGAbOmfcW
        FeyzDd8IW2jVKmCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D186AAFD;
        Mon, 24 May 2021 19:46:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6BD53DA72C; Mon, 24 May 2021 21:44:02 +0200 (CEST)
Date:   Mon, 24 May 2021 21:44:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Delayed inode error handling fixes
Message-ID: <20210524194400.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1621629737.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621629737.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 04:44:06PM -0400, Josef Bacik wrote:
> Hello,
> 
> Here are 3 straightforward fixes, but they rely on eachother so I'm sending them
> as a series.  The first changes how we do cleanup so that it can do the right
> thing in the case that we don't have an iref, this is to make the code cleaner
> in the error case.  The second patch is to fix the error handling in
> __btrfs_update_delayed_inode so it actually does the proper cleanup if there's
> an error.  And finally the last patch add's the abort() we need in order to not
> leave behind improper inode items that trip up fsck during error injection
> testing.  Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: make btrfs_release_delayed_iref handle the !iref case
>   btrfs: fix error handling in __btrfs_update_delayed_inode
>   btrfs: abort transaction if we fail to update the delayed inode

Added to misc-next, thanks. I've copied the changelog from patch 3 as
comment before the transaction abort.
