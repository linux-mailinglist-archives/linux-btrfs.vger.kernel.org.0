Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D98EC50B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfKAOuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 10:50:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:43998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727644AbfKAOuG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 10:50:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5A58AF81;
        Fri,  1 Nov 2019 14:50:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8EEBDDA7AF; Fri,  1 Nov 2019 15:50:13 +0100 (CET)
Date:   Fri, 1 Nov 2019 15:50:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
Message-ID: <20191101145012.GS3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191030122301.25270-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030122301.25270-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 12:23:01PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Backreference walking, which is used by send to figure if it can issue
> clone operations instead of write operations, can be very slow and use too
> much memory when extents have many references. This change simply skips
> backreference walking when an extent has more than 64 references, in which
> case we fallback to a write operation instead of a clone operation. This
> limit is conservative and in practice I observed no signicant slowdown
> with up to 100 references and still low memory usage up to that limit.

So this could lead to larger stream due to writes instead of clones, and
thus fewer cloned ranges on the receive side. This is observable and
could potentially raise questions why is this happening. Limiting the
nmuber makes sense, based on the report, though I'm curious if we can
make it higher, eg. 128, or 100 that you have measured.

I'll tag the patch for stable as it can be considered usability bug fix,
so I'm interested in the possible fallouts.

> This is a temporary workaround until there are speedups in the backref
> walking code, and as such it does not attempt to add extra interfaces or
> knobs to tweak the threshold.
> 
> Reported-by: Atemu <atemu.main@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492c65782be3fa
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks. The above is up to discussion and the number
can be tuned later.
