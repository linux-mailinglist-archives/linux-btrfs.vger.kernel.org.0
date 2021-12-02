Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4A466A98
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbhLBTsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 14:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbhLBTsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 14:48:37 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07DC06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 11:45:14 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id g28so1079298qkk.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 11:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wzgwwI1FgyMqEXq8jGIzsgFrLIS++F/u2C40UNYsnUs=;
        b=dexZQQfDSBq/5F7ltFaIEK0pTeieWxUQi0x22kgOQzBOpSctHOk0IdI8138EVksukk
         iFIFnRf+UoFx//sPySi5Kh1el5fdC/jvUmURW9oExbrjzR1vz67fgyNvGJc0vrx9Wrgv
         Ytp+pANG2EoAeA8vr1akdyHvd7d/u3AMeN6+qKjNF59w5Pd9cZ72GShRTvu6dsCcKFqk
         fFw5/wG8kbpiCv5MSj6M6Ya2c7V3ZcpVC87MvBTCdWnlmS6IfCLZoAbC9YiEk8bNvuym
         U5sFDApGPsWlRKjEAXq8xJHzrZ3o5im05/SsCS0jXxvcPxDBX6k3nqc7Wyctp1nBXA/5
         ViQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzgwwI1FgyMqEXq8jGIzsgFrLIS++F/u2C40UNYsnUs=;
        b=ZH+/ShPbcJxVodQrsKTMnWjt6x3e26eJaflZuXsbnD20aAG2PpB50clsARXKwCq97f
         sA5RbOUDE+nX/vVrWlZOoXuGGrdvi+btBq2h+Lq20jh/rxKgpTYHOB+slZnG6cMSbuP3
         YXldh+DlDhT2XLNPvbx+DsSXtP5WjUesutmaHfx8UwX90GOb+33067awk/2CVl1stD09
         lAgUVSFURo+fGZt4BqkvbO771hLSwKOvh74Z8DIOMFH6VnBupCjnauWi4w3FvYGbzvto
         f9mWwkJD1Yy9/O2N23yIzyF0rR81UzCTpCcxQUb+Tr0qUB8A3mksZPhwZw+QOdKlUomd
         7C2Q==
X-Gm-Message-State: AOAM533m+FZCxSsTLt2naI7yJ4+8mWFrvSlkI44bJjumCWgcm7GN5sIn
        j3mO3TBJu0RCFiBaXlrZH5L0dZ2mZ7w09Q==
X-Google-Smtp-Source: ABdhPJy6BVbB+1skL7JM/Gi+gwvTgDKEyf6j5Z/cbrABJ5c66O0hgJrvMXBvIPTHlzF7oDcfZ9xfCQ==
X-Received: by 2002:a05:620a:a8c:: with SMTP id v12mr14059694qkg.73.1638474313806;
        Thu, 02 Dec 2021 11:45:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f7sm547944qkp.107.2021.12.02.11.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:45:13 -0800 (PST)
Date:   Thu, 2 Dec 2021 14:45:12 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: optimize btree insertions and some cleanups
Message-ID: <YakiSB114RBn6gnu@localhost.localdomain>
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 10:30:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset optimizes btree insertions to allow better parallelism, by
> having insertions unlocking upper level nodes sooner and avoid blocking
> other tasks, or reduce the time they are blocked, that want to use the
> same nodes. The optimization is in patch 2/6, patch 1/6 is preparation
> for it, and the rest are just cleanups or removing stale code and comments.
> 
> Filipe Manana (6):
>   btrfs: allow generic_bin_search() to take low boundary as an argument
>   btrfs: try to unlock parent nodes earlier when inserting a key
>   btrfs: remove useless condition check before splitting leaf
>   btrfs: move leaf search logic out of btrfs_search_slot()
>   btrfs: remove BUG_ON() after splitting leaf
>   btrfs: remove stale comment about locking at btrfs_search_slot()
> 
>  fs/btrfs/ctree.c | 254 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 181 insertions(+), 73 deletions(-)
> 
> -- 
> 2.33.0

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
