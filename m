Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA74B2DB3A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 19:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgLOSWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 13:22:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:37164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730781AbgLOSV7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 13:21:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8726ACC4;
        Tue, 15 Dec 2020 18:21:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BCD40DA7C3; Tue, 15 Dec 2020 19:19:38 +0100 (CET)
Date:   Tue, 15 Dec 2020 19:19:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, nborisov@suse.com
Subject: Re: [PATCH 0/2] ->total_bytes_pinned fixes for early ENOSPC issues
Message-ID: <20201215181938.GD6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com, nborisov@suse.com
References: <cover.1603286785.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603286785.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 09:32:24AM -0400, Josef Bacik wrote:
> Hello,
> 
> Nikolay discovered a regression with generic/371 with my delayed refs patches
> applied.  This isn't actually a regression caused by those patches, but rather
> those patches uncovered a problem that has existed forever, we just have papered
> over it with our aggressive delayed ref flushing.  Enter these two patches.
> 
> The first patch is more of a refactoring and a simplification.  We've been
> passing in a &old_refs and a &new_refs into the delayed ref code, and
> duplicating the
> 
> if (old_refs >= 0 && new_refs < 0)
> 	->total_bytes_pinned += bytes;
> else if (old_refs < 0 && new_refs >= 0)
> 	->total_bytes_pinned -= bytes;
> 
> logic for data and metadata.  This was made even more confusing by the fact that
> we clean up this accounting when we drop the delayed ref, but also include it
> when we actually pin the extents down properly.  It took me quite a while to
> realize that we weren't mis-counting ->total_bytes_pinned because of how weirdly
> complicated the accounting was.
> 
> I've refactored this code to make the handling distinct.  We modify it in the
> delayed refs code itself, which allows us to clean up a bunch of function
> arguments and duplicated code.  It also unifies how we handle the delayed ref
> side of the ->total_bytes_pinned modification.  Now it's a little easier to see
> who is responsible for the modification and where.
> 
> The second patch is the actual fix for the problem.  Previously we had simply
> been assuming that ->total_ref_mod < 0 meant that we were freeing stuff.
> However if we allocate and free in the same transaction, ->total_ref_mod == 0
> also means we're freeing.  Adding that case is what fixes the problem Nikolay
> was seeing.  Thanks,
> 
> Josef
> 
> 
> Josef Bacik (2):
>   btrfs: handle ->total_bytes_pinned inside the delayed ref itself
>   btrfs: account for new extents being deleted in total_bytes_pinned

The 2nd patch did not get any review (1st one has from Nikolay), the
patchset hasn't been in any topic branch or for-next. As we're going to
have more space related changes in 5.12 cycle I'd like to get this one
in too, so either please resend or get the remaining review. Thanks.
