Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73F93104E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 07:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBEGOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 01:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhBEGOg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 01:14:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0FDD64E35;
        Fri,  5 Feb 2021 06:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612505635;
        bh=4ODxvygwl723y2dEVsGPsTKHLkUQKnlTqAU1Ju5z/cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwltmPNX0QQ87URLGMlV1CFxKMzn9zVzSSR355dGjOQIlGI/Su1meaa/qzmqM0VTK
         iOHxMEmLszAGIIvUBnjT/9yRyzSsXGF8qIHLQJB5C7k/BFPOd2+6FSAvvHIpFQ1M7J
         tC3UafOtddsa0gh9TYW3/oUFtWqvDivfzE7vCKaxi5bTG884B5QqUPR2Mn9INTkPKj
         L+ufZ2gNAuhhYPe+wNa6d0xVhRTL8OwUF2w3JJsSQDEHrA7ahaRornsBFA/6o6dKeb
         ifMKdsMSoGUW8atKJVOkSBxoORtEoSmJiIgcK7wFlZWaeO9bqgRb6vHbWD16xA88Jx
         ktdiqYUAjuQ3Q==
Date:   Thu, 4 Feb 2021 22:13:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5] btrfs: support fsverity
Message-ID: <YBziIn5FhtekZ7ZP@sol.localdomain>
References: <cover.1612475783.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1612475783.git.boris@bur.io>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 04, 2021 at 03:21:36PM -0800, Boris Burkov wrote:
> This patchset provides support for fsverity in btrfs.

Very interested to see this!  It generally looks good, but I have some comments.

Also, when you send this out next, can you include
linux-fscrypt@vger.kernel.org, as per 'get_maintainer.pl fs/verity/'?

> At a high level, we store the verity descriptor and Merkle tree data
> in the file system btree with the file's inode as the objectid, and
> direct reads/writes to those items to implement the generic fsverity
> interface required by fs/verity/.
> 
> The first patch is a preparatory patch which adds a notion of
> compat_flags to the btrfs_inode and inode_item in order to allow
> enabling verity on a file without making the file system unmountable for
> older kernels. (It runs afoul of the leaf corruption check otherwise)

In ext4, verity is a ro_compat filesystem feature rather than a compat feature.
That's because we wanted to prevent old kernels from writing to verity files,
which would corrupt them (get them out of sync with their Merkle trees).

Are you sure you want to make this a "compat" flag?

> 
> The second patch is the bulk of the fsverity implementation. It
> implements the fsverity interface and adds verity checks for the typical
> file reading case.
> 
> The third patch cleans up the corner cases in readpage, covering inline
> extents, preallocated extents, and holes.
> 
> The fourth patch handles direct io of a veritied file by falling back to
> buffered io.
> 
> The fifth patch adds a feature file in sysfs for verity.

I'm also wondering if you've tested using this in combination with btrfs
compression.  f2fs also supports compression and verity in combination, and
there have been some problems caused by that combination not being properly
tested.  It should just work though.

- Eric
