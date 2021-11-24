Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEA45CA29
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349078AbhKXQh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 11:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349074AbhKXQh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 11:37:57 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D40C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 08:34:47 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id a11so3395247qkh.13
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXHJrZH5jDSng1VZmT5hIPEi8ydT6KlxMBbCeb+vup4=;
        b=BMkm9nL3oVXggTWwrvScIeSrSbp+qNKI6+mz6n6ZYIBXTYi5x5djIeKgA4GTDMwMIT
         vMjruRAk87Ztr83UjrU3Keya5ZnOzmalkKufpuYVYufxYclH/AQv/7IO3rmej/0M6cAT
         88PkfU0sQqj+p22ZmWCYZbYaW6HgmwIIMLKXmasdsVVTCozWYuWl/+nSGkLPQdNl5VRx
         +9ZhiEYDsaZJIdWeFQN2YePrL12/2FUylsBAxGeGtPypv8s4eWuKX5NGP57wpSWYQRz+
         7WPLqbzbqFZhqf+5ntMCuh2FoNoU5NNj2rlIa+ow1dJuZsODHpmvNZQ2sCRS7yWAnk4B
         2aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXHJrZH5jDSng1VZmT5hIPEi8ydT6KlxMBbCeb+vup4=;
        b=4RXf9W2n9qlKZtfCxZpRDiHq4xjHE5w1bv1wRr2gSQauP9dn4BXDBTVl9vdq7EA4eD
         dvxdcyFcF+ghuZ8dMp09pG9LuiwWpSCK36MTN4McI21K9hR9snCFY/PpyDMFPw+6Y4ce
         K4m8v8HDbSwahZWItD4zjhxlGmoeFLJDJNoHx51jt3cB1NvxQ871FtJR/C+Cb2mkms+h
         iN9pj1vHbB/VS9J9avhnp+EvTVoNuX0GQb2s7yom/c52AugcC83LiahjyuIBQIj+S84Z
         9qTAT2fKO6c9Tvprnn81tbshhMphMvG01fwSndBOYR5R2oQBvR0jSkeyxR7PxxQnB2LI
         EmXA==
X-Gm-Message-State: AOAM531gYGAlDMLi+3Zl548sduzRQVGoIBrIad/h/mUs+gDG+WPhjxSm
        DqIQ8BnRhc61pCnmdWm1rk1pRQ==
X-Google-Smtp-Source: ABdhPJxTRLNPYBeY3oRBQncImZZR6oo0mkN5LLjTodVP3JCB3xmfApWBUybezCQ11b0GcarCAgZt6Q==
X-Received: by 2002:a37:9445:: with SMTP id w66mr7608680qkd.410.1637771686613;
        Wed, 24 Nov 2021 08:34:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m4sm109898qtu.87.2021.11.24.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 08:34:46 -0800 (PST)
Date:   Wed, 24 Nov 2021 11:34:45 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 00/21] btrfs: first batch of zoned cleanups
Message-ID: <YZ5ppVSi6DAuw/A2@localhost.localdomain>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:30:26AM -0800, Johannes Thumshirn wrote:
> Here's a first batch of cleanups for the zoend code. It reduces the number of
> calls to btrfs_is_zoned() outside of zoned.[ch] from 46 on misc-next to 33.
> 
> As I had to create a scrub.h file, I also moved the scrub related function
> prototypes from ctree.h to scrub.h.
> 
> Johannes Thumshirn (21):
>   btrfs: zoned: encapsulate inode locking for zoned relocation
>   btrfs: zoned: simplify btrfs_check_meta_write_pointer
>   btrfs: zoned: sink zone check into btrfs_repair_one_zone
>   btrfs: zoned: it's pointless to check for REQ_OP_ZONE_APPEND and
>     btrfs_is_zoned
>   btrfs: zoned: move compatible fs flags check to zoned code
>   btrfs: zoned: move mark_block_group_to_copy to zoned code
>   btrfs: zoned: move btrfs_finish_block_group_to_copy to zoned code
>   btrfs: zoned: move is_block_group_to_copy to zoned code
>   btrfs: zoned: skip zoned check if block_group is marked as copy
>   btrfs: move struct scrub_ctx to scrub.h
>   btrfs: zoned: move fill_writer_pointer_gap to zoned code
>   btrfs: zoned: sync_write_pointer_for_zoned to zoned code
>   btrfs: make scrub_submit and scrub_wr_submit non-static
>   btrfs: zoned: move sync_replace_for_zoned to zoned code
>   btrfs: zoned: move finish_extent_writes_for_zoned to zoned code
>   btrfs: move btrfs_scrub_dev() definition to scrub.h
>   btrfs: move btrfs_scrub_pause() definition to scrub.h
>   btrfs: move btrfs_scrub_continue() definition to scrub.h
>   btrfs: move btrfs_scrub_cancel() definition to scrub.h
>   btrfs: move btrfs_scrub_cancel_dev() definition to scrub.h
>   btrfs: move btrfs_scrub_progress() definition to scrub.h

These last six could have been a single patch but no sense in redoing it now.
Fix up that random return and you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
