Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3464BCF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiLMTOT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbiLMTNj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:13:39 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2167A1094
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:12:39 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c7so655531qtw.8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CChQRemeLr/1zhXN0YVBcqfARk3uU1IglbVutcXCt68=;
        b=vxdeMST8ZjQoYYqPWRfZuyOSD2ev4e45se3mxdfXAno/RSoSWHfjQHX2w8v04recPQ
         7aYzH71mAW015xw7W2h/uG3psvf7cGdtlbzHut4x7KTZQPxXq8a7veFsWCemLkwwBp90
         u8WOZqMPSVsEVdu9J6e0r2F/YP3wzE5ExqeOI2PdBq9SZOnH/yfOef0zVqlZL6VXoChK
         Nw+G/+w7yMWSJUQJsrEoXynpnOJcDysmF5GTMcIOsV1l6vUfyaRdzTmw8cLRa35DBrCa
         XkQx5xdRJYEq0rxT5ChToc6aXMQozTHat73TjhH4r5tbQCTVjnePqmHX1S5OKrnhQ+WY
         EgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CChQRemeLr/1zhXN0YVBcqfARk3uU1IglbVutcXCt68=;
        b=XESYifpJe55LoyCjVauLhA3n2MRnu/LBKkL3spSDgSS8fyDTDbIYg7qaPccMVTiF6M
         bdbZrYjjFTJN/6SIt5o8NvYILn+5W7YIiIsZ3GwUtCkv8LdpXUAkeqxg7duoF3W2UloB
         bz2R0vKEmx9NMeeUxGDyyCmTpfR38iJeg8aHGt2vTly03XjLscR3L2b+VU6oNz6R1GCU
         V5NjiviMjPoK3Ij9cYfpXWX4Qyvzyv7TieQ9BlWne+nOz/Ka3K26yd13mTJMvsKllJ+a
         NNTcj5cyq/KeqxT7HEJw9ClLRRlrD2Z71kO6nVNB5Giib7MZ6nJLfXEn9EkWm1S4mVC5
         rBgQ==
X-Gm-Message-State: ANoB5pmHEgayJfV2dzr6TgsV6ezZPyII5CQuzfS/lvz5pNl6hLbXLnDA
        qWV8cv56SVhmsJREvmauabQFnG3REBJdJKFJwiU=
X-Google-Smtp-Source: AA0mqf5K/5vOBYWLdRlnydbCcdwqGiy2+x789yqcf8kpf89U2bs01lKAKcjf06zvoOxY9bErtMs7pw==
X-Received: by 2002:ac8:7215:0:b0:39c:da20:d437 with SMTP id a21-20020ac87215000000b0039cda20d437mr6228721qtp.16.1670958758019;
        Tue, 13 Dec 2022 11:12:38 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g3-20020ac84683000000b003a580cd979asm340039qto.58.2022.12.13.11.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:12:37 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:12:36 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 12/16] btrfs: Perform memory faults under locked extent
Message-ID: <Y5jOpE3Lrgy4B6tc@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <68054cb6c0be33ef7c55ef8d4b5f4dda0a0d9cbf.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68054cb6c0be33ef7c55ef8d4b5f4dda0a0d9cbf.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:30PM -0600, Goldwyn Rodrigues wrote:
> As a part of locking extents before pages, lock entire memfault region
> while servicing faults.
> 

Again this is going to slow us down for the same reason the readpages change
slowed us down.  If we have the unlocked variant of readahead then we get this
for free, because filemap_fault will just use that, and we'll already have our
locking order done.

> Remove extent locking from page_mkwrite(), since it is part of the
> fault.
> 

It's actually not, it happens separately, we do the fault, come back into the
main fault logic, unlock the page, and call ->page_mkwrite().  So for
page_mkwrite we definitely need to keep the locking, we just need to change the
order, and that should be in it's own patch.  Thanks,

Josef
