Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E989E63AD0E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiK1P4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 10:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiK1P4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 10:56:01 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD822B24
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 07:56:00 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id n12so7634926qvr.11
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LM8h6KLWWTEWMA6VgF0TXa9y2hbBVBNM4oy6ZkPgVf8=;
        b=jPlKXtRCrWys4pFrzy55TMLqqJAlf61Z7z2CsPpUbxU9IOBYx8Q7CH9e/tvmnRZTDp
         NqAg6obaffFIDN/FTs7SAPt32K2Eb5pGSZW2VHn//r/O9QB4REKzCbGeHnPvBQMmqJS3
         LmmrNRMoFkioy57ahzJ1Dv80Em8HdIyjwTX5F1mDQvdhZBx/pz4vqcMGZIVSjVUPIsT5
         g7MkGpyjVNxP28XTxkAvbB0riYaUX23V5bdgwditi/smZBZOj3gstCpEGKGlEefp5sri
         mSgfq1ze/5JMuU/OV3xdygTjt6oNN7Q/RPl0iSC+HqHOT8zzoPrl382wtXFIwsY5P1My
         wDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM8h6KLWWTEWMA6VgF0TXa9y2hbBVBNM4oy6ZkPgVf8=;
        b=YZZR2gH+TPp5PJC49UyWnvNkWI4sA3Io4wfRdPGVWO6iKFDA6EFiHOPTcsJq9uAb1H
         88fdHkerrn/RHfXYJtt4mj9tbMtgCJH3VeHAceUx1/fhu+n6UExF/s5+vnh8P39TsP7l
         2bWxzFsCrXL49MFOyZZzxv6osw6iwVXL70ySFAOh8tTeP/vTsI5l5SBPpwkaVYc/BZGf
         ZvpCvnRn591JdeW4zITeEwIRCBCLIroR4pmEdo7uP1LMa3Kzm/taqknhwCTsYYwNR914
         1kS7m27/hM/vlE9uxgmqf0kSJdWuY8pqQ1NSU1f+zRAxz63Kr5ELZbyLa9ssQlmm+gv/
         5yqw==
X-Gm-Message-State: ANoB5pkNyyT/Dm2HwdO43AUq3HvMQpiYCrf15+Ymh0NGxY/HLUPgbNhB
        EvWEYr3s4MOauvAl0ZVx2mtPqUxw6j9sMw==
X-Google-Smtp-Source: AA0mqf6sUCtef2pDA6sOHGzESRAem1KLkJT7cpSMkucjPphtmlcH2RUhPd3JBAX/fNyIW9jXiu64Jg==
X-Received: by 2002:a05:6214:3241:b0:4bb:6c4c:6beb with SMTP id mt1-20020a056214324100b004bb6c4c6bebmr33730121qvb.40.1669650959314;
        Mon, 28 Nov 2022 07:55:59 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id t11-20020a37ea0b000000b006f8665f483fsm8557275qkj.85.2022.11.28.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:55:58 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:55:57 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not BUG_ON() on ENOMEM when dropping extent
 items for a range
Message-ID: <Y4TaDQIJqCOqWrkS@localhost.localdomain>
References: <59ccc7b41be79e5c3b0f39ad5da6591554927af7.1669647978.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ccc7b41be79e5c3b0f39ad5da6591554927af7.1669647978.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 03:07:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we get -ENOMEM while dropping file extent items in a given range, at
> btrfs_drop_extents(), due to failure to allocate memory when attempting to
> increment the reference count for an extent or drop the reference count,
> we handle it with a BUG_ON(). This is excessive, instead we can simply
> abort the transaction and return the error to the caller. In fact most
> callers of btrfs_drop_extents(), directly or indirectly, already abort
> the transaction if btrfs_drop_extents() returns any error.
> 
> Also, we already have error paths at btrfs_drop_extents() that may return
> -ENOMEM and in those cases we abort the transaction, like for example
> anything that changes the b+tree may return -ENOMEM due to a failure to
> allocate a new extent buffer when COWing an existing extent buffer, such
> as a call to btrfs_duplicate_item() for example.
> 
> So replace the BUG_ON() calls with proper logic to abort the transaction
> and return the error.
> 
> Reported-by: syzbot+0b1fb6b0108c27419f9f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000089773e05ee4b9cb4@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
