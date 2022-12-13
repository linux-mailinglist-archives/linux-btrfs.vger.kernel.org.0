Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FBB64BBF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiLMSaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiLMS35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:29:57 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A424BDA
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:29:56 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id e13so1973421vkn.11
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpuOTRMlwEV2Y8+upvRibu3nA4tPEWJMKi7ksW7aRCA=;
        b=6YP59rDES+bN+mRi0Ze3+WPlwqzPDQzDMMEoBz6p4f0lSQ0kH2K5ISiDYoMqnPPv9o
         Xiuvoe7QPOlyzyho10pGXG7ffltsbFnG7FyVTfP5NPrOg6aocw+GeTiyaRNrVbHAhw/Q
         THDdAzt1KxOb0Z9QoKw0aVkD2Y+E8oR1xSFeKuVYcDDI5rLjK+GG3EHKrlXd3NpLMAsI
         8PhvF+tTAtozfCWCvpD5QVwSY+1pishG9SyUlKpHoQDA5zpj/leT1UHEcS1q+cMQs2q7
         1FBEjYiMjbSdLV2FETQJBdBT2mYbxBK4xzb4LJlkiOI6J+SoCFa0XK4qa4aNYQr6P3TL
         UbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpuOTRMlwEV2Y8+upvRibu3nA4tPEWJMKi7ksW7aRCA=;
        b=aL1GMPEbrF47pP1fTVblfUCUKKRyzhaQrNFJLgyEyrzIUNPojSgn5T4c116ljbqyZh
         RhVKiw/rs6cnThbfz95dwx7mCcvylgCr2Z+rT214mJ+yBAt9GLZlwUzo+l+49y/71D+w
         5939gOs2ytU0i66wQ+xrXTBcR8o7Rlt7P20lkC8k+GiBySD1ry5EBK+WFYr3pugKhb9z
         wmvPdkI5zXR2rOWS/4HieLFYf17DCZ/FMqII1Ecny4d5OPP2o7JQfm8C2bVd/F9QWS35
         k//Hn7YjdIp675FPlyCd93CukCOVZrHY9/Jfm4j876W7JsHwyC9Ivxaz4bZ3sOB+NtfP
         NLwQ==
X-Gm-Message-State: ANoB5pn5q8EURJZeWCU+Kq4RN10B8pC+IcC32kCu3xI+6xt8AESofCna
        PS07giVA312JYoG11PmlbUy3pQ==
X-Google-Smtp-Source: AA0mqf7tdXaCQNmJsArz7nnkwYpD2ZTKuufHD4sZPv5Ks4rPs1Gk6mRA5sCAQQKw4jWkEjRdbI87Xw==
X-Received: by 2002:a1f:43c4:0:b0:3bd:ef1a:7e6 with SMTP id q187-20020a1f43c4000000b003bdef1a07e6mr11497675vka.1.1670956195300;
        Tue, 13 Dec 2022 10:29:55 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006feb158e5e7sm8311046qkp.70.2022.12.13.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:29:54 -0800 (PST)
Date:   Tue, 13 Dec 2022 13:29:53 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/16] btrfs: lock extents while truncating
Message-ID: <Y5jEoSxHVscdq87a@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <7ffb8c402e6b8cd3679d5b9a97dc0b43e75079d5.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ffb8c402e6b8cd3679d5b9a97dc0b43e75079d5.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:22PM -0600, Goldwyn Rodrigues wrote:
> Extent locking before pages.
> 
> Lock extents while performing truncate_setsize(). This calls
> btrfs_invalidatepage(), so remove all locking during invalidatepage().
> 
> Note, extent locks are not required during inode eviction, which calls
> invalidatepage as well.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
