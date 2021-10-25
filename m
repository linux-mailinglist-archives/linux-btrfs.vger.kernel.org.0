Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5D43985D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhJYOVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJYOVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 10:21:38 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78412C061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 07:19:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id r15so11808809qkp.8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ov4ytTu3ViO0h//k96bDn3are9Zf22IzPDYJFTChlls=;
        b=BZGTga5KC/A2ZaUAkkVRQUhHYkB9w2DvINSaGOyDSWtJNWkXmC21wsN1/7A/gt8o/z
         V6B3Odcs7LZD6v2X08bd1evAtQfma25hyXuBV86Qd4FrY+ueuaq0JYQA52ybUAAdfpf3
         nxZk/6cudWqf6tAiFMaXp5ob7SM++XhYoMchHLyOuqD2QokCs2UuIT9FB6yvaCkL1vZN
         Zz8umzVrBvXHNxcc3V5AihqHDxI/178jGoO7JFUrB8IxldURDWTK9sWhuKlvAug5qPjM
         SB2z6R72dWLrYAg60aQv3+gTuHZ+t/NTFxR64TGQ2KmF9DDAUBCAyvTRB6UuW220Okky
         Gl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ov4ytTu3ViO0h//k96bDn3are9Zf22IzPDYJFTChlls=;
        b=zJzOem9PfUYGCu7fNIAveTuvlTLDOjr9nyqPvunKRlVu7yf5OLXNvOok856a1FKZ26
         jmUhRZNNQj12NH+wADPIczQBdkW0fnYjjuseVgaBdEgfvp0Zxl8oiEpP8NkWZh6vb6ZJ
         z1dUYgo4mSAqjV2+vJOtjBZXxERsqnmUqpc2eba9ZxGIQmg4h2u1Ic77STV1th8SQ5jB
         N0CK635zJ/0RKPvX4fbW2BoKOrOgYG+jjo8/gfQzLi1l8zbRWpi8FMBRBqlfyLF3/Jnp
         LZEUH7u+bk7SmPub5b40qkGh+GoSw4dlw+wMqGJwQDIVMCgzW60bry/tzPEBD0x/jerb
         83Jw==
X-Gm-Message-State: AOAM5324qe1pREQUkqUfmoncvpUticelUWJ/wLulwZGfBVziAiYwEmxT
        kgwrmDyF0Tl7NAaE5UwkcN7uowxPmu4OlA==
X-Google-Smtp-Source: ABdhPJzkLENoCIx5pSqAz8TjgYSKNyC7hVnAxHdYDfVwbEekfIgEkYEF46inzgkfwOXjZx7YUOPr0Q==
X-Received: by 2002:a37:d53:: with SMTP id 80mr13501203qkn.490.1635171555416;
        Mon, 25 Oct 2021 07:19:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a23sm2098287qkn.73.2021.10.25.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:19:14 -0700 (PDT)
Date:   Mon, 25 Oct 2021 10:19:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: ctree.he refactor
Message-ID: <YXa84dxA/q/0SsTu@localhost.localdomain>
References: <20211025090821.65646-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025090821.65646-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 05:08:18PM +0800, Qu Wenruo wrote:
> Btrfs is abusing ctree.h for almost everything which doesn't have a
> better location to put its definitions.
> 
> This makes ctree.h super congested for both kernel and btrfs-progs.
> 
> Here is just several cleanups inspired by my WIP btrfs-fuse project.
> 
> Currently my read-only (and still WIP) btrfs-fuse only has a ctree.h
> with less than 100 lines.
> The read-only project is definitely going to be much smaller than
> kernel, but there are several tricks I used to make ctree.h slim:
> 
> - Put ondisk-format into ondisk_format.h
> - Put BTRFS_SET_GET_* macros into accessors.h
> - Put message output functions into messages.h
> 
> So we will only really high level structure definitions in ctree.h
> 
> Unfortunately for kernel, we still have tons of function
> definitions, which don't have proper headers for them.
> 
> But this is still a good direction to go.
> 
> Of course, any advice on the names of these new headers will be very
> helpful.
> 

I hate it all because now I have to rebase my item changes onto this.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
