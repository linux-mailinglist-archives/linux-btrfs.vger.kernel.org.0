Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4864D65D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 17:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349893AbiCKQPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 11:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350154AbiCKQPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:20 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C902199E3F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 08:14:16 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id k125so1938463qkf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9m2uwGVnt9WVKJNvDmdRpXbKGrKofZp0KcpTTBC+9iQ=;
        b=GIgkGozY22nU9yILmjXbIx8mlkszIqE3FtOX4g+dqsch/EiVuwElhRcOI53YYMQXPI
         28QMs1aiDiS82Uo6cvI1h4dmDm44YcsUpX/1UE7L366dAGCv8+jE0afa2fiihqq63oDG
         kDi23Eli6P5/5rMYGrrJJGvX8mt5uA9NvtpHMOomb33oMNOuQYzeBr+g+hChQepR8Ggp
         7UBRWaWCg/eavdOXCTej9iOcFBZgwbfOyjq4eqhaJ0jurFa3fs+zpPAssV8CLQyNwDYE
         dfM8ST5hcicsaIiTWSxaGnonwuw+Lqir866Ff7CxEKAE8vLZ2RCSTplC28cBbA3amXlN
         8GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9m2uwGVnt9WVKJNvDmdRpXbKGrKofZp0KcpTTBC+9iQ=;
        b=QUb6H5iYZSpKg5DRcsyDZxPUrj83nd3hiRzTqJBlMdqlJ+4/8l7fYI4+fG9aol1S2i
         BUxq3OBS0ukhpKzxf8pUSqIfCZfdYI0jjK9Cdl9TZW7Glcz2CLKZRg8i7H5wDzCVxksC
         JAijIlQuDIQ7t8jebYwz+zzwVr/SKmY/Gwl77bwQrnIBhVoOryEASngR2sOC/0zmgWuK
         E0F4Iuof13kifv5UZ/lQq9uEd2DHRbkl3DyzuDVbx4yqc8t65ZVyI4ImnVUmfkwMBP9H
         maVJTywm5xYtJA3CxgBImw96qR0PfnMKfZhIQrDCoXn9HCHrg0koDfPgSZVaEKwVvWIL
         GipQ==
X-Gm-Message-State: AOAM532XDhQu2UgD2fDucSKWs2J69N9CdjjCaJkYw5YdebXPpz5N8CQE
        iSWraDkdKZdWDJcc+O3bOe9En4HSXVQCmVSJ
X-Google-Smtp-Source: ABdhPJxt8yM54ao15w7oiG+IZTF72Bhxp7cPDXExsn8DvqT5af5QTm8eqt2R5yEOuLV0HxbDnxV6Wg==
X-Received: by 2002:a05:620a:29c3:b0:67b:315b:d94 with SMTP id s3-20020a05620a29c300b0067b315b0d94mr7133329qkp.252.1647015255605;
        Fri, 11 Mar 2022 08:14:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h206-20020a379ed7000000b0067b5192da4csm3995507qke.12.2022.03.11.08.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:15 -0800 (PST)
Date:   Fri, 11 Mar 2022 11:14:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: fix inefficiencies when reading extent
 buffers and some cleanups
Message-ID: <Yit1VWj3D3mBMY91@localhost.localdomain>
References: <cover.1646998177.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646998177.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 11:35:30AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a couple inefficiencies when reading an extent buffer while searching
> a btree plus a couple cleanups in the same area. Spotted while working on
> other stuff, but this is separate and independent enough to be in its own
> small patchset.
> 
> Filipe Manana (4):
>   btrfs: avoid unnecessary btree search restarts when reading node
>   btrfs: release upper nodes when reading stale btree node from disk
>   btrfs: update outdated comment for read_block_for_search()
>   btrfs: remove trivial wrapper btrfs_read_buffer()
> 
>  fs/btrfs/ctree.c    | 57 ++++++++++++++++++++++++++++++---------------
>  fs/btrfs/disk-io.c  | 16 ++++---------
>  fs/btrfs/disk-io.h  |  4 ++--
>  fs/btrfs/qgroup.c   |  2 +-
>  fs/btrfs/tree-log.c |  9 +++----
>  5 files changed, 50 insertions(+), 38 deletions(-)
> 
> -- 
> 2.33.0
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
