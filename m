Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3384866BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbiAFPcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 10:32:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49382 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbiAFPcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 10:32:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B21921126;
        Thu,  6 Jan 2022 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483119;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOEI56mO7ohELu4/pC9IXj1Mtnk9RDSitGrfuK8HpLU=;
        b=0xDddlhzcB9Csn2syNeEvt7YVLzEqqNiOXYCSdoerias+weojOt2RTsdDSUiiUuwtbhvs8
        hyphcnZidI/VsojwOXMkQxA2NDAFHl6lehVx6DnyErkOCxSc63Uxvugz39iTPC50cyHViy
        +kYvbpKVH/mP0HBaHNJTp2US7N90foU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483119;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOEI56mO7ohELu4/pC9IXj1Mtnk9RDSitGrfuK8HpLU=;
        b=hd4/iz9XGtujPoJW/N3qRefhAdBmJeOgakF/93WvhJnPAGrr48/+GLbW01dESw2wEPg9ZW
        kMpdsMv/3Q+TYuDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 650E8A3BBD;
        Thu,  6 Jan 2022 15:31:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10250DA781; Thu,  6 Jan 2022 16:31:28 +0100 (CET)
Date:   Thu, 6 Jan 2022 16:31:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some more speedups for directory logging/fsync
Message-ID: <20220106153128.GH14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1639568905.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639568905.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 12:19:57PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset brings some more performance improvements for directory
> logging/fsync, by doing some changes to the logging algorithm to avoid
> logging dentries created in past transactions, which helps reducing a
> lot the amount of logged metadata, and therefore less IO as well for
> large directories.
> 
> It specially benefits the case when some dentries were removed, either
> due to file deletes or renames, where it can reduce the total time spent
> in an fsync by an order of magnitude even if the number of dentries removed
> is a small percentage of the total dentries in the directory (for e.g. as
> little as 1%, like in the test results of the changelog of patch 3/4).
> 
> This builds on top of my previous patchset to make directory logging copy
> only dir index keys and skip dir item keys, which has been on misc-next
> since the previous merge window closed.
> 
> Patches 1/4 and 3/4 are the changes that accomplish this, while patch 2/4
> is just preparation for patch 3/4, and patch 4/4 is more of a cleanup of
> old, unnecessary and unreliable logic. Test case generic/335 was recently
> updated in fstests, so that after applying patch 4/4 it passes.
> 
> Patch 3/4 contains in its changelog the test and results.
> 
> We are close to the 5.17 merge window, holiday season is approaching and
> there's already a significant change for directory logging coming to 5.17
> (log only dir index keys and skip dir item keys), so I think this patchset
> is better suited for the 5.18 merge window.

The for-5.17 has been branched, so this patchset is now in misc-next,
thanks.
