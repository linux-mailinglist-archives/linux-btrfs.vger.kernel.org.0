Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D83A44C2B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 15:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKJOIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 09:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhKJOIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 09:08:34 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAA4C061767
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 06:05:46 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a24so1903813qvb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1rvf87jgaE5rUaeR1ZeHeUzo6uctURBeZhWrOltT49w=;
        b=SVHqyQd5jsegIqirPq1wBTPvBFTWiYFuu8D1hiSPR5Dhc3wt20wgdyiQuRTPoK65PR
         YgWT5cIRHLegh2uXtbKOtznM8L9sy9D+was0ZC9usJlRFfNXWPD7T2rl+NXRy64abIlM
         Rs/IlqHIwmnhHe1GecKNfY5x3u62pOpWAkqAsfDPlS9OtmjlzgFefqarlpy60qdoSu7H
         HvTQT3vRRQL4msNkR3sG3pJmwAYkU3fbscWkpkL1BkyGkugflUFxIbQLWHiPHr3DJdRO
         UAXTa8l7sqDUntk+oxlcmHSgQ8y+Busjxkus1ZQcZz9QAjwCfah3SXv3YfeuNE2A995S
         OZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1rvf87jgaE5rUaeR1ZeHeUzo6uctURBeZhWrOltT49w=;
        b=w2RkJBWRIFVQab6D3IV8ml8EEgUIPO8iVLssLjH3IpeyPbCDlVhIU92b5i9F8ZqlxR
         FhhqFbq/6v+eD4bJkuMTyqH8TORyTEOqwrTeNAsSegRvXt6fuUxS+hFMi+jmQ7b9xFqT
         1Fs7sBR6kEs79qSy2N2YZ3Ng5rzqo++UvhohJqoGC7P+WaSf/V4xtMjeyLbAbEaihUzx
         Zg6S16XNKhRHo/v8b+yEx9RbhzEPoUGn2+DKLM9CLM3ARbHYGPLaMCIcW0RXTuZMjRz3
         pTPCPCDuf8yMz/mxFenRZxp/PRJ2a08zoL6etpwr9F9SFhJwTCLO2rr+002giHQod3oq
         J3iQ==
X-Gm-Message-State: AOAM533Y+F3o31PhkDuIKgKSoK1fB9hUbgoaVVqcCFJd6WHVq4krMbTP
        8VCWj5IbkTtQ5+kVLj2L0f8n4iHWJD7Lbg==
X-Google-Smtp-Source: ABdhPJyTbVup7P9DKu8L/oWdCSPss81zfmiD0ClLXAidD9GMUdtSneNV950HGvFXATaWn8ApK49tCg==
X-Received: by 2002:a0c:b341:: with SMTP id a1mr15505489qvf.21.1636553144058;
        Wed, 10 Nov 2021 06:05:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs34sm13096160qkb.97.2021.11.10.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:05:43 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:05:42 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reduce the scope of the tree log mutex during
 transaction commit
Message-ID: <YYvRtuATuj/ASxDm@localhost.localdomain>
References: <f9f76a38d5a908d438816a778a7d55764a6360f3.1636538581.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f76a38d5a908d438816a778a7d55764a6360f3.1636538581.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 10:05:21AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the transaction commit path we are acquiring the tree log mutex too
> early and we have a stale comment because:
> 
> 1) It mentions a function named btrfs_commit_tree_roots(), which does not
>    exists anymore, it was the old name of commit_cowonly_roots(), renamed
>    a very long time ago by commit 5d4f98a28c7d33 ("Btrfs: Mixed back
>    reference  (FORWARD ROLLING FORMAT CHANGE)"));
> 
> 2) It mentions that we need to acquire the tree log mutex at that point
>    to ensure we have no running log writers. That is not correct anymore,
>    for many years at least, since we are guaranteed that we do not have
>    any log writers at that point simply because we have set the state of
>    the transaction to TRANS_STATE_COMMIT_DOING and have waited for all
>    writers to complete - meaning no one can log until we change the state
>    of the transaction to TRANS_STATE_UNBLOCKED. Any attempts to join the
>    transaction or start a new one will block until we do that state
>    transition;
> 
> 3) The comment mentions a "trans mutex" which doesn't exists since 2011,
>    commit a4abeea41adf ("Btrfs: kill trans_mutex") removed it;
> 
> 4) The current use of the tree log mutex is to ensure proper serialization
>    of super block writes - if someone started a new transaction and uses it
>    for logging, it will wait for the previous transaction to write its
>    super block before writing the super block when attempting to sync the
>    log.
> 
> So acquire the tree log mutex only when it's absolutely needed, before
> setting the transaction state to TRANS_STATE_UNBLOCKED, fix and move the
> stale comment, add some assertions and new comments where appropriate.
> 
> Also, this has no effect on concurrency or performance, since the new
> start of the critical section is still when the transaction is in the
> state TRANS_STATE_COMMIT_DOING.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
