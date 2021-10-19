Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8CE4337FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhJSOG2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSOG1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 10:06:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5122C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:04:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j12so24368qkk.5
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TIiBipweI1KrjkK9xzOC9Zhq9iRYMMP4Dm8aHPwW/x8=;
        b=SQOlymH3BvQjrV97Y8JAawi14xV/X9Saxcn4ia9jSl7mIPcW8UIzhmvHlURT5Zqh/4
         ET7eKhejaSirC8z8ZZquGYlETzNmHNeaiXdbg3ab7JOx5LJtn267NH4qIcuJ/qyJCFAd
         gPfML9qgwoj3XNdf4GhoyxxNstck/sXlQPSs7JDZseHNZepmQWZ+NNjU+e4WIuIJu2Xd
         m5dmm993zZ5RLxC5gknbJIj4Y9CNj8AaEAxGEPRZb12qpsULEnrzlaSSEHLchZQl4PZg
         33TDbjSCDu4TNkqWerZHdUyQCmLK+9ifssZs7azUKclkiM0+eYAWnCRvJKD9fvxETjzl
         QiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TIiBipweI1KrjkK9xzOC9Zhq9iRYMMP4Dm8aHPwW/x8=;
        b=VOCbcqfDMT1+sBfdkGK3SY+h92NOFbfDxyr/8Yj0uPEyOz9Dn9Vf+rSEBGT4M2zFrX
         AzjfgF74U/bQqEtJhR0VnscWkXJIsOgGXVnQxf5bffBK5WdUjZruwHNoTcpz2wq5euXW
         DQ0cbBi9iXqv1i8bBE0/PZS0WmL+qdWMa99FyHeGKPWAftMkl0oi9G8OgiFJuIreJSbr
         DUrAzolrIXsf4/4B5S2JSs9glSXxfNQH7KoWWKb5CfFsV1TQe00H3p2NI8ReeYgVVwAL
         CY8XHyIxrn0srycr4NOpNJzB+zy5A77J64pz1SAs7wnBbFpqsYaHa330iReSjjyYigzf
         5weA==
X-Gm-Message-State: AOAM530CWLsEvOuxThFbbU9hnbLyPMk5M534NdNGbphbLobw9wn7+ZiZ
        JaV5Bv/QczcJfjFPqcSbd6N2+mctygSSUQ==
X-Google-Smtp-Source: ABdhPJyYgFhsS/PJLrFb+poJdGR3oXcdhySAOQBTq3fjgEo6BG8nM/yt/Mtv/JVPx24pVfEoUD0s6w==
X-Received: by 2002:ae9:dc84:: with SMTP id q126mr96156qkf.128.1634652253694;
        Tue, 19 Oct 2021 07:04:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u185sm7990677qkd.48.2021.10.19.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:04:13 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:04:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Message-ID: <YW7QW/RBMWMCnYIo@localhost.localdomain>
References: <cover.1634598659.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634598659.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 08:23:43AM +0800, Anand Jain wrote:
> The following test case fails as it trying to read the fsid from the sb
> for a missing device.
> 
>    $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2 
>    $ btrfstune -S 1 $DEV1 
>    $ wipefs -a $DEV2 
>    $ btrfs dev scan --forget 
>    $ mount -o degraded $DEV1 /btrfs 
>    $ btrfs device add $DEV3 /btrfs -f 
> 
>    $ btrfs fi us /btrfs 
>      ERROR: unexpected number of devices: 1 >= 1 
>      ERROR: if seed device is used, try running this command as root
>  

I'd like to see this as either a btrfs-progs test or an fstest.  I think I
prefer the fstest because you're adding a sysfs file, so maybe a couple of
tests, one to validate the sysfs file behaves properly, and then one to do this
test as well.  Thanks,

Josef
