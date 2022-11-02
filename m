Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD96166CE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiKBQBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 12:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKBQBc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 12:01:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC862BB1F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 09:01:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4265D22D46;
        Wed,  2 Nov 2022 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667404888;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YN0FSnKBjbDHRMmEZz0oARuqL2aGZlq9i5qNrf7g8qM=;
        b=EuRftTaBZgBHeyX1uP/4vadpVhJDlEwTM/VTA3r2ZxzjVJUKyfRIVUm2nAfFUPpmm9Oxhm
        dS8kiLb5CkN/vyhd7orgDp4Kd7d9yIcXpBaR1qk8GUC4hwnG5Dox7AA/WKX6ll9Zc+7g66
        ++isIIMZmycZLSB6Bh4fstZN/70IFlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667404888;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YN0FSnKBjbDHRMmEZz0oARuqL2aGZlq9i5qNrf7g8qM=;
        b=O6IdndhwDgth5rY0G+oCQl2UrqOlT/YJmthJvLxK7Qdixlv5WEmH7hKdFo99cjqN5GbIXO
        nq3Yh5r8uNCU+XBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12C7E139D3;
        Wed,  2 Nov 2022 16:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yG9TA1iUYmPcFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 02 Nov 2022 16:01:28 +0000
Date:   Wed, 2 Nov 2022 17:01:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/18] btrfs: make send scale and perform better with
 shared extents
Message-ID: <20221102160108.GH5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 01, 2022 at 04:15:36PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are two problems with send regarding cloned extents:
> 
> 1) Sometimes it ends up not cloning whole extents, but only a section of
>    the extents, reducing in less extent sharing at the receiver and extra
>    IO on the send side (reading data, issuing write commands) and on the
>    receiver side too (writing more data). This is not only not optimal
>    but it also surprises users and often gets reported (such as in the
>    thread referenced in patch 09/18);
> 
> 2) When we find that a data extent is directly shared more than 64 times,
>    we don't attempt to clone it, because that requires backref walking to
>    determine from which inode and range we should clone from and for
>    extents with many backreferences, that can be too slow, specially if
>    we have many thousands of extents with a huge amount of sharing each.
> 
> This patchset solves the first problem completely (patch 09/18), and for
> the second issue while not fully eliminated, it's significantly improved.
> In a test scenario with 50 000 files where each file is reflinked 50 times,
> there's a performance improvement of ~70% to ~75% for both full and
> incremental send operations. This test and results are in the changelog
> of patch 17/18.
> 
> After this we can now bump the limit from 64 max references to 1024, which
> is still a conservative value, but the goal is to get rid of such limit in
> the future (some more work required for that, but we're getting there).
> 
> There's also a nice and simple performance optimization when processing
> extents that are not shared and we are using only one clone source (the
> send root itself, very common), with gains varying between ~9% to ~18%
> in some small scale tests where there are no shared extents or the majority
> of the extents are not shared. That's patch 08/18.
> 
> The rest is just refactoring and cleanups in preparation for the optimization
> work for send, and a few bug fixes for error paths in the backref walking
> code and qgroup self tests. In particular the error paths for backref walking
> are important because with the latest patches they are triggered not just in
> case an error happens but also when the backref walking callbacks tell the
> backref walking code to stop early.
> 
> More details in the changelogs of the patches.
> 
> I've also left this in a git tree at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=send_clone_performance_scalability
> 
> Filipe Manana (18):
>   btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
>   btrfs: fix inode list leak during backref walking at find_parent_nodes()
>   btrfs: fix ulist leaks in error paths of qgroup self tests
>   btrfs: remove pointless and double ulist frees in error paths of qgroup tests
>   btrfs: send: avoid unnecessary path allocations when finding extent clone
>   btrfs: send: update comment at find_extent_clone()
>   btrfs: send: drop unnecessary backref context field initializations
>   btrfs: send: avoid unnecessary backref lookups when finding clone source
>   btrfs: send: optimize clone detection to increase extent sharing
>   btrfs: use a single argument for extent offset in backref walking functions
>   btrfs: use a structure to pass arguments to backref walking functions
>   btrfs: reuse roots ulist on each leaf iteration for iterate_extent_inodes()
>   btrfs: constify ulist parameter of ulist_next()
>   btrfs: send: cache leaf to roots mapping during backref walking
>   btrfs: send: skip unnecessary backref iterations
>   btrfs: send: avoid double extent tree search when finding clone source
>   btrfs: send: skip resolution of our own backref when finding clone source
>   btrfs: send: bump the extent reference count limit for backref walking

Thanks a lot, the improvements look great. Added to misc-next.
