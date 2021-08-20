Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE13F2C73
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbhHTMu1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 08:50:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhHTMu1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 08:50:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C9BA720159;
        Fri, 20 Aug 2021 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629463788;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyC5mINrhWgONeXlrooIJTxKWXn4ltLEARnh0odoQ8g=;
        b=eaNKS9h/M4TMbn1znWuH4FpOR4B0bXb4rx2Q3ryvs7IbGLpK6fZNygTHGqDLRMt5gP0Gcm
        h4ZOuC0VqSVjvmSS47O0iCRVyC0RkOVvlCCV5zWyw/y7z8gqQhHzS4Pe2vAmKClU0F0mEk
        GEoaKJdo7cKa9RY1n3IgoN6RNZz2NKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629463788;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyC5mINrhWgONeXlrooIJTxKWXn4ltLEARnh0odoQ8g=;
        b=jWp/Zoi7YYrQWgRqJHmAqeuXf3/RDyK65/zS3a+sF9lXJK8smCJ64WNIT1UnfeTKqCVh8O
        wfaNryyFmDdUxxDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0C99A3B88;
        Fri, 20 Aug 2021 12:49:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0EBE1DA8C5; Fri, 20 Aug 2021 14:46:50 +0200 (CEST)
Date:   Fri, 20 Aug 2021 14:46:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: make subpage warnings more strict
Message-ID: <20210820124649.GR5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210818064420.866803-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818064420.866803-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 02:44:17PM +0800, Qu Wenruo wrote:
> For the incoming support of more page sizes for subpage RW mount, we
> will require tree blocks to be nodesize aligned.
> 
> This patch prepare such restrict warnings for btrfs-check and update
> self-tests to handle them.
> 
> Currently all convert/fsck/misc can pass except one unrelated
> regression, fsck/025, which is caused by "btrfs-progs: Drop the type
> check in init_alloc_chunk_ctl_policy_regular".

I've dropped the test 025 for now so we can do the tests.

> All fsck images except fsck/018 are newer enough to have all their tree
> blocks nodesize aligned, so they won't cause any new warnings.
> But still, for read-only tests, we will skip the subpage warnings as we
> only want to ensure our writes from btrfs-progs won't cause new subpage
> warnings.
> 
> Qu Wenruo (3):
>   btrfs-progs: tests: also check subpage warning for type 2 test cases
>   btrfs-progs: tests: don't check subpage related warnings for fsck type
>     1 tests
>   btrfs-progs: require full nodesize alignement for subpage support

Added to devel, thanks.
