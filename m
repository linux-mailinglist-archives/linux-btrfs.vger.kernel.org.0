Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08043380B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 16:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJSOKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJSOKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 10:10:34 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16264C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:08:22 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n2so51198qta.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8CEcEXNnsa7mNbT2Qo8aXJEBfwB2OJuFou/rde3iqJ8=;
        b=ifCYNUO2RxByDW2V/M8m8qN1TsMLLYd/RGYn93rJ9Xp8HylXwnLpSJFgbs7nGMtEwE
         +3q6Lll1Ls8duxShAc3hzNZUro8vbcQr/JHFbyvjg8UiISLQFcWC68uWBxcETedSps1w
         bbgJV3UhsQl5eLZ5YqNxLqwlkyeO0NYFgj61yR5ogPNCBqeLDqM8UBoQe39oTlf/YJnf
         7xhF/VDkmTyki+LTPUzclBytD5NnyIp82vO0co2pgQKTc4ZtlFvWWHABJ8Yn2mYcl6T/
         U4fFHz5C+fk+vNlAA+BpAyQyDmMGOH2n/X8qPKI2cDpHSy4NNwwurL9nLWGPPWOGPTXG
         E+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8CEcEXNnsa7mNbT2Qo8aXJEBfwB2OJuFou/rde3iqJ8=;
        b=wVpMWGpRI7jNWnsJc3cA5iKMqbsavsBMGTnP3PBeE2PVloK8ZUXDD/mKJtUfYuftn/
         OVasbMaW4FD+YKSktbr5XtqYoNGUWj1nY3H/OGmrpuY2gFM3JbpBqvCHOOmxZhj7xTna
         quXwkW53o57arjndaU57Ae24tF6xRg7al2GF3rtXzXjag40onppcfTlWpQSBYPOVAlpn
         2quKXtPMfxVUfUHakZdioJb/mMtoBSvJr9EY+uNb+ecFM8tKaTEifur82g7prT+xoeYf
         ki8aTgk4JPRxks5you5MGkf5xpty0oNkpp7czhVsdLS1xdi6mHWP1jfSyOoY+b0kupDy
         NZpg==
X-Gm-Message-State: AOAM533oihdcwgQCaf7MbM22WQL16BvsHyX50y1KQ4x9aBcqx9dZcbae
        ELp2VLJhVQc8Ic2pHSf3++l7+jrHu8Q=
X-Google-Smtp-Source: ABdhPJzjquBHIghXZIRiRpn+vMdnkG6dMAqoYbLNeWq4GICVdruO/JGcojlFjs8pFBmK4cVjJ9fCzw==
X-Received: by 2002:ac8:5f91:: with SMTP id j17mr155033qta.138.1634652501162;
        Tue, 19 Oct 2021 07:08:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 74sm7953877qke.109.2021.10.19.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:08:20 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:08:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: cleanup on btrfs_super_block definition
Message-ID: <YW7RUwYmrIaDAi1r@localhost.localdomain>
References: <20211019112925.71920-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019112925.71920-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 07:29:23PM +0800, Qu Wenruo wrote:
> This patch is to enhance the definition of btrfs_super_block by:
> 
> - Unify sizeof(struct btrfs_super_block) and BTRFS_SUPER_INFO_SIZE
>   In kernel, it's just 3 location allocating BTRFS_SUPER_INFO_SIZE
>   (one of them is for selftest), so such change is not doing much
>   difference.
>   But for btrfs-progs, it would remove call sites like:
> 
>         char tmp[BTRFS_SUPER_INFO_SIZE];
>         struct btrfs_super_block *buf = (struct btrfs_super_block *)tmp;
>  
> - Move btrfs_super_block definition to uapi/linux/btrfs_tree.h.
>   Due to BTRFS_IOC_TREE_SEARCH ioctl, we're almost exposing all on-disk
>   formats to the user space.
>   Thus it's almost a perfect location to contain all on-disk schema.
> 
> Qu Wenruo (2):
>   btrfs: make sizeof(struct btrfs_super_block) to match
>     BTRFS_SUPER_INFO_SIZE
>   btrfs: move btrfs_super_block to uapi/linux/btrfs_tree.h
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
