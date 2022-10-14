Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E638F5FEE43
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJNM6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJNM6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 08:58:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360DE9862
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 05:58:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z8so3566959qtv.5
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZz6z9WtH8ynUmHx6mDpvQBIXLR2QwSLX2ZKR1G7Y78=;
        b=VT7gDxi3H11+MSLCkSkWu4mMAI23kOZDL549jXHS0kYQIM4mFIpdL4HUSNCGTU2hFi
         jWYJURxNysAPbsh0yYdYTd0bAMlfHt3NXRdztWr1DQiHP/zaB2xDZoShib8IzONF6D7q
         ogifsMc9hfUL2XqGGbwCslh+EOVuZrfNOKdvHn6xPXy2lheVGLJilZaJkz3CU6cLendv
         a/hYs5GdbFeBxdrqKx+BQQlxdkZaRNJ9a5s5J17BSlwI34BpKxb1sFUFK6mdjqKwod5z
         2r4o0H00JO1gTCnDCdXmwqOvbgkoik6jJkQShVKAygP2KxRRHzIk9TNujPx7vGsBjcSZ
         JCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZz6z9WtH8ynUmHx6mDpvQBIXLR2QwSLX2ZKR1G7Y78=;
        b=WvMvgAL4+WKVKYLw2Ks0gP/kjvO55nc2Mik5cjWb78M2BRN5vPZQJ4MRiXnXrVzKQJ
         ob/bp4waPEmg036AGdJmZc0TEgSwCrIS6+mpJbsdR3rhYqaRQAId0Nw139I7n755E2K1
         RrTry4Kb/eWiM5ztpRYuGT8jBsblX6Wq61kUVVo5sZgX3c4dSFR+rC9/sy2yjiWn091d
         vbGeNFy2gWxGE6fOPhRjbCLWn8P0y0bVVnm35VwGutD+jaY6zv7diDf3eGjKQrP/KSFZ
         CJG6fvOLwDAHoHeU2HnDaCQw2mNQ8gJ7A84WZJEutvOpzbcEeHAx3Aha/DwQuY2+1sm6
         WKDQ==
X-Gm-Message-State: ACrzQf14E2ak4EavhOVGFi2OFvjibYTN1/q8ypRf1fk5QuWHHHi3wQ+B
        IyvjgVSZNpWrbK7Zr4gNRZmLk06jY6oZGQ==
X-Google-Smtp-Source: AMsMyM7lccdosIcBGmP8wfP14EAIWXKa+hLUYuLbTmNZo0NZrdYLOAU06guSFIznzVWEx0uGe+UlOQ==
X-Received: by 2002:ac8:5750:0:b0:35c:cb1b:2639 with SMTP id 16-20020ac85750000000b0035ccb1b2639mr4000188qtx.183.1665752292784;
        Fri, 14 Oct 2022 05:58:12 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a448e00b006ec51f95e97sm2446589qkp.67.2022.10.14.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 05:58:12 -0700 (PDT)
Date:   Fri, 14 Oct 2022 08:58:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Enumerated bits in enum
Message-ID: <Y0lc436crGSbCeCA@localhost.localdomain>
References: <cover.1665492943.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665492943.git.dsterba@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 02:58:45PM +0200, David Sterba wrote:
> With some macro magic it's possible to let enum autoincrement define all
> bits without manually specifying the value. How it's done is described
> in the first patch, the rest are example conversions.
> 
> David Sterba (6):
>   btrfs: add helper for bit enumeration
>   btrfs: convert BTRFS_ILOCK-* defines to enum bit
>   btrfs: convert extent_io page op defines to enum bits
>   btrfs: convert EXTENT_* bits to enums
>   btrfs: convert QGROUP_* defines to enum bits
>   btrfs: convert __TRANS_* defines to enum bits
> 
>  fs/btrfs/ctree.h          |  9 +++--
>  fs/btrfs/extent-io-tree.h | 71 +++++++++++++++++++++------------------
>  fs/btrfs/extent_io.h      | 17 ++++++----
>  fs/btrfs/misc.h           |  8 +++++
>  fs/btrfs/qgroup.h         |  9 +++--
>  fs/btrfs/transaction.h    | 18 +++++-----
>  6 files changed, 78 insertions(+), 54 deletions(-)
> 
>

I love it,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 
