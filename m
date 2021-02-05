Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7313104D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 07:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBEGEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 01:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBEGEt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 01:04:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0854A64DE8;
        Fri,  5 Feb 2021 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612505049;
        bh=KkFzBYiExG9FQEs9OG+MNDMZJwQ1t3Pe7fvOgzV+GV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSQkOtZzvbya+Lm9OWYz2p/jSgxpekN0kZvY23cU4Zf9e4v/X33nrW4WpDPSZqikA
         kjDbaoWCyaeuuJloImiEV9eAgiVHZwIKKViHkZqoeJJnUdYABXrx7xKOzUFdf/W8cC
         A5p6BdKbKQIyJEGVbisWFrDHwWMgh31HAsiTB6tB45DBcdVNm+RdHg71Jo69hjt6j6
         vJyjTa2Qu+vvktHA8cfLevb9ZvRXkc215iqh3M/l2+zFXMnILfLt/eclV9uEcpaEcr
         WTg9YhWBLjxtQY1VgmQieBiBKYfGvRJDEp24nOCiN8qO4BXX/TqT31KYEFLQ+N5Vwh
         OS7koR2dLFs9Q==
Date:   Thu, 4 Feb 2021 22:04:07 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a test for btrfs fsverity
Message-ID: <YBzf1z6EGCAK7JWN@sol.localdomain>
References: <c16cbe8ad5795f059af45bfe7cf673dab58028a2.1612468162.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16cbe8ad5795f059af45bfe7cf673dab58028a2.1612468162.git.boris@bur.io>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for writing a test for this!

On Thu, Feb 04, 2021 at 03:24:26PM -0800, Boris Burkov wrote:
> There are some btrfs specific fsverity scenarios that don't map
> neatly onto the tests in generic/574, like holes, inline extents,
> and preallocated extents. Cover those in a btrfs specific test.
> 
> That test relies on assumptions about how the Merkle tree is stored
> by ext4/f2fs which don't apply to btrfs, so we also test Merkle tree
> corruption here. This could be merged by some generic abstraction.

The only part of generic/574 that cares where the Merkle tree is stored is
_fsv_scratch_corrupt_merkle_tree().  Couldn't that be updated to handle btrfs?

> Finally, that test relies extensively on fiemap, which is currently
> broken on btrfs for offsets and sizes that don't align to PAGE_SIZE,
> so put a simple regular file case in this test for now, while we fix
> fiemap or generalize extent lookup.

fiemap is only used by _fsv_scratch_corrupt_bytes().  It just wants to know the
list of extents that intersect the requested byte range.  Does that really not
work on btrfs if the range isn't page-aligned?

- Eric
