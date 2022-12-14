Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCB64CE85
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbiLNQ7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 11:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiLNQ7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 11:59:14 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E304140C7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 08:59:13 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id b189so316907vsc.10
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vpbmoPa9nH1mfS7Bha+op39eU4MpPY9PmIET7GbrC1c=;
        b=zGhT1GNyTuiCM47lf6TwzQ39ujED5u/BYhaiEBAk6GpcaZ/hN4BpUreEKd0Q59LDXN
         w8fpcDevLbS3OLS5YmX3RxO1w/oUpCKYYFknoOAsf4M13jKvuA4BpJ7OVkWCAN8xqnLs
         kGBWOrLezNTFu3iksE5JIh9e61bU2SOw7obeJehagnlYV/Aqd2cK57sE24qj4zgwayLV
         zvfIovnU3Qq9y2jIuJd7PDGrdIiGMUqrcC7+qxdAd3lERxHWzd1F4kjO5PJnsfQvF6Ks
         asRBx67dgciO0GKCNmhIG8tWPBcuYN9ms2Po9rX8wz5ZSafNJq5wDUFNQI3P/em0uHrP
         6PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpbmoPa9nH1mfS7Bha+op39eU4MpPY9PmIET7GbrC1c=;
        b=eQqFWrInKXPhmtOn1fTRLvapi0lFGYeWrgyO/uXGlEppwAU71ykIJ/Fw4+/PLb7O7p
         p+XT38/0VqIZkX5YQNQ88ZcnNptxKg5DcjJB35BHT17+Oth3S/VyKRnYN2BH7LBCVTJr
         Og2p7xhnHu44UAWKbyNyJsnv+qjxbv3cV8Ybgud/5JW06Fl++t968k+5ZbmY8wPYF8IU
         /ExgPDBuo8mHMWK4NaD+8WFfarOJSAFraXxFKfw9MlHk96/Fr/qNApTBiELNG8UQi4+A
         wcrtcRcIRT1g271tFA2o5GMxLYOMD6FgepPceGXFJxTAZ1BreGc/8cKlSLMdDTl8D1Ce
         HQjg==
X-Gm-Message-State: ANoB5pkwxbE0wxxxKDsoEBsUzwHT8SqEhz0xGbOvBnaM9RO/6I+keEB1
        59n6elaPWpyknZJH9057V+Aw++Io/QwaYgA0z5Y=
X-Google-Smtp-Source: AA0mqf7PSczwiNPcdQEQcD6SWVZga/fzZpDZIaoEGMXB72xMA1w/nnmKM0GIdRkIqmhY3V58tqnNHg==
X-Received: by 2002:a05:6102:1d9:b0:3b1:19ba:5025 with SMTP id s25-20020a05610201d900b003b119ba5025mr13588761vsq.23.1671037152021;
        Wed, 14 Dec 2022 08:59:12 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id do36-20020a05620a2b2400b006fb8239db65sm10240187qkb.43.2022.12.14.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:59:11 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:59:10 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
Message-ID: <Y5oA3qBk+qMSyAR/@localhost.localdomain>
References: <20221214021125.28289-1-robbieko@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214021125.28289-1-robbieko@synology.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 10:11:22AM +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
> 
> [Issue]
> When creating subvolume/snapshot, the transaction may be abort due to -ENOMEM
> 
>   WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937 create_pending_snapshot+0xe30/0xe70 [btrfs]()
>   CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661
>   Call Trace:
>     create_pending_snapshot+0xe30/0xe70 [btrfs]
>     create_pending_snapshots+0x89/0xb0 [btrfs]
>     btrfs_commit_transaction+0x469/0xc60 [btrfs]
>     btrfs_mksubvol+0x5bd/0x690 [btrfs]
>     btrfs_mksnapshot+0x102/0x170 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
>     btrfs_ioctl+0x2111/0x3130 [btrfs]
>     do_vfs_ioctl+0x7ea/0xa80
>     SyS_ioctl+0xa1/0xb0
>     entry_SYSCALL_64_fastpath+0x1e/0x8e
>   ---[ end trace 910c8f86780ca385 ]---
>   BTRFS: error (device dm-2) in create_pending_snapshot:1937: errno=-12 Out of memory
> 
> [Cause]
> During creating a subvolume/snapshot, it is necessary to allocate memory for Initializing fs root.
> Therefore, it can only use GFP_NOFS to allocate memory to avoid deadlock issues.
> However, atomic allocation is required when processing percpu_counter_init
> without GFP_KERNEL due to the unique structure of percpu_counter.
> In this situation, allocating memory for initializing fs root may cause
> unexpected -ENOMEM when free memory is low and causes btrfs transaction to abort.
> 
> [Fix]
> We allocate memory at the beginning of creating a subvolume/snapshot.
> This way, we can ensure the memory is enough when initializing fs root.
> Even -ENOMEM happens at the beginning of creating a subvolume/snapshot,
> the transaction won’t abort since it hasn’t started yet.
> 

Honestly I'd rather just make the btrfs_drew_lock use an atomic_t for the
writers counter as well.  This is only taken in truncate an nocow writes, and in
nocow writes there are a looooot of slower things that have to be done that
we're not winning a lot with the percpu counter.  Is there any reason not to
just do that and leave all this code alone?  Thanks,

Josef
