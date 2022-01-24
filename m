Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6384985F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiAXRK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 12:10:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46884 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbiAXRK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 12:10:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0454121999;
        Mon, 24 Jan 2022 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643044225;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP1bg1bNzxZRAtvRNxwbE1AQAGkc0lwDw0LiypECgJg=;
        b=YMjCgDv5xwwEJkHguBLadWAj1hihAMbaJ6h48pG/wNVg89YZmDoby1YjLmcuOtKJAKV8qD
        k1V07+Mh7wx6HE9r8SaqCjyHi7YiLT4+EJDTepS6gJAK+wAzDSxphYNur+uR2KL4orxc9U
        DLLSPHAs3y2U8dGtg8K+GNsHFTpnrqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643044225;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP1bg1bNzxZRAtvRNxwbE1AQAGkc0lwDw0LiypECgJg=;
        b=T8iYsEoZyh0rrYpj8I5s77EWp7ilTjn3gdDiRrUQk5kzrfeW5+/w9z08Mm3c5maCVPI7k8
        P7MkOytnHgftghCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EF378A3B81;
        Mon, 24 Jan 2022 17:10:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D81DDA7A3; Mon, 24 Jan 2022 18:09:45 +0100 (CET)
Date:   Mon, 24 Jan 2022 18:09:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update writeback index when starting defrag
Message-ID: <20220124170944.GB14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20aad8ccf0fbdecddd49216f25fa772754f77978.1642700395.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20aad8ccf0fbdecddd49216f25fa772754f77978.1642700395.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 05:41:17PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When starting a defrag, we should update the writeback index of the
> inode's mapping in case it currently has a value beyond the start of the
> range we are defragging. This can help performance and often result in
> getting less extents after writeback - for e.g., if the current value
> of the writeback index sits somewhere in the middle of a range that
> gets dirty by the defrag, then after writeback we can get two smaller
> extents instead of a single, larger extent.
> 
> We used to have this before the refactoring in 5.16, but it was removed
> without any reason to do so. Orginally it was added in kernel 3.1, by
> commit 2a0f7f5769992b ("Btrfs: fix recursive auto-defrag"), in order to
> fix a loop with autodefrag resulting in dirtying and writing pages over
> and over, but some testing on current code did not show that happening,
> at least with the test described in that commit.
> 
> So add back the behaviour, as at the very least it is a nice to have
> optimization.
> 
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thank.
