Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D8D37EE1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhELVJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 17:09:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:42666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238626AbhELSsX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 14:48:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0167EAC38;
        Wed, 12 May 2021 18:46:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15EA6DA729; Wed, 12 May 2021 20:44:26 +0200 (CEST)
Date:   Wed, 12 May 2021 20:44:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2] btrfs-progs: check: continue to check space cache if
 sb cache_generation is 0
Message-ID: <20210512184425.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <20210330022830.491831-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330022830.491831-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 30, 2021 at 10:28:30AM +0800, Su Yue wrote:
> User reported that test fsck-tests/037-freespacetree-repair fails:
>  # TEST=037\* ./fsck-tests.sh
>     [TEST/fsck]   037-freespacetree-repair
> btrfs check should have detected corruption
> test failed for case 037-freespacetree-repair
> 
> The test tries to corrupt FST, call btrfs check readonly then repair FST
> using btrfs check. Above case failed at the second readonly check step.
> Test log said "cache and super generation don't match, space cache will
> be invalidated" which is printed by validate_free_space_cache().
> If cache_generation of the superblock is not -1ULL,
> validate_free_space_cache() requires that cache_generation must equal
> to the superblock's generation. Otherwise, it skips the check of space
> cache(v1, v2) like the above case where the sb cache_generation is 0.
> 
> Since kernel commit 948462294577 ("btrfs: keep sb cache_generation
> consistent with space_cache"), sb cache_generation will be set to be 0
> once space cache v1 is disabled(nospace_cache/space_cache=v2). But
> progs check was forgotten to be added the 0 case support.
> 
> Fix it by adding the condition if sb cache_generation is 0 in
> validate_free_space_cache() as the 0 case is valid now since the
> kernel commit mentioned above.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/338
> Signed-off-by: Su Yue <l@damenly.su>
> Reviewed-by: Boris Burkov <boris@bur.io>

Added to devel, thanks.
