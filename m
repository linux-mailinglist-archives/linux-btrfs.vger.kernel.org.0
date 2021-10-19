Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67EE4337DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhJSOAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJSOAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 10:00:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9040C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 06:58:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z24so18270166qtv.9
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M+/gEO+9aS7d8mfwqPPf4BBaAA1yqyeFRQf57KrAtCQ=;
        b=eq0padt3PK0fRa8aEjyoIIvHMU1YWXmzf/5kzLfMZUp9ezZ80W+IxfzAgKBFYz4vdW
         oOtQKKol7R4k5vblM08jnu3IJdAHTFce1/yuZcfaCdrqo72vAZv6IQZA0LJlT+CjLP4k
         J9jt8Yswyn9/UKtyxpkOLd9ukGhjn5QaY/oYqMh1uvzwH6pG5UI72btD4p4mhX2icG+W
         hagvc+hSQZtsG2JmSTO11HkagWKaiGLNZcz5t+KnzGktkhMS3eZ6Ghv3uATXRruiIEnV
         tBABzwTRE2SsP15ijKVi+E2FX7gJLIwIJtTPLeTglJoWOYleBHiCK7u+KXAIpdQBq3Mc
         GQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M+/gEO+9aS7d8mfwqPPf4BBaAA1yqyeFRQf57KrAtCQ=;
        b=hES4/dy529jmsG4s0Zybn6LqF/08EtQqiKXY4rjLr7fBFL4R5RGuYO6dNeLyub3mym
         lOCJLrRLCvNNZJpmXFm6V+y9Zy9NXX8vvP0UbXJcjp3ME0r9LKtb3SfnvBnt8/x6V+cI
         G5se7gPywO8lUC+7GpkZEj1nWqVlKUNqbSjirnby8eQCwTnEv2PvXep/EamaEGT693Ac
         EEtMhjaBZPxzM2wjIExvcHN8E0a5+tZyXyEptflN8I9BY3ljt0VLyek305dk8aKAHjhx
         rPWKS2bdCyPzfY2kSeXDz9JiExvPVf0+mIybZmQ4uQlasR8Y7DjmghQ3OnPx2wq641VW
         sr2g==
X-Gm-Message-State: AOAM530pRcge6mnrkbJtm7k3rSRwltYYzGklGR49ZpTCCSth0OWGXlyY
        P2x0QLqHIx7A5EIfy0Gf6sMvExeRY9XkBA==
X-Google-Smtp-Source: ABdhPJwAoKxQvmGSqZgWRQqEsWExVBCMICgw/XMtAIkyAKSSn65bQuGLjJHS9aMuJbTc1nu35fXdDQ==
X-Received: by 2002:a05:622a:5:: with SMTP id x5mr39069qtw.57.1634651879710;
        Tue, 19 Oct 2021 06:57:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b23sm4448506qtp.16.2021.10.19.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:57:59 -0700 (PDT)
Date:   Tue, 19 Oct 2021 09:57:57 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/2] provide fsid in sysfs devinfo
Message-ID: <YW7O5Sr0PlSPgE27@localhost.localdomain>
References: <cover.1634598572.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634598572.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 08:22:08AM +0800, Anand Jain wrote:
> btrfs-progs tries to read the fsid from the super-block for a missing
> device and, it fails. It needs to find out if the device is a seed
> device. It does it by comparing the device's fsid with the fsid of the
> mounted filesystem. To help this scenario introduce a new sysfs file to
> read the fsid from the kernel.
>      /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid
> 
> Patch 1 is a cleanup converts scnprtin()f and snprintf() to sysfs_emit()
> Patch 2 introduces the new sysfs interface as above
> 
> The other implementation choice is to add another parameter to the
> struct btrfs_ioctl_dev_info_args and use BTRFS_IOC_DEV_INFO ioctl. But
> then backward kernel compatibility with the newer btrfs-progs is more
> complicated. If needed, we can add that too.
> 
> Related btrfs-progs patches:
>   btrfs-progs: prepare helper device_is_seed
>   btrfs-progs: read fsid from the sysfs in device_is_seed
> 
> Anand Jain (2):
>   btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit
>   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> 
>  fs/btrfs/sysfs.c | 113 +++++++++++++++++++++++++----------------------
>  1 file changed, 60 insertions(+), 53 deletions(-)
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef
