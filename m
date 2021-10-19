Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4946F433801
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhJSOIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhJSOIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 10:08:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CC0C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:06:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id n2so45376qta.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L/42AmUSR3HEsprnn8wmWnQ+1+aJQlNoAuc629CHSNo=;
        b=cp1FnFxg1S1QOHoIrB5NSd26hXCIXYpLGaOkSJ5JYx1BFbn8v+70Sk0t72xm7IC44S
         wlgy3HaV1iu19jCedFvDyUZQNEF7rrdz4CM8fbo4a9lSs74BcLsBdVuwUfco1u5bdGkA
         j5VU39IF8qQTiM2ZyZi0/0fAp5ZeFlrEywteOHh67T35b4Be6toHMje7tegMrdeCyK5y
         I8ZuJOI8Wwqh24rE4Kkdb9Y2+L8BIKvsaCcgKMr93s1YHtkmMdWYEmW4/JrFV3UJgaxH
         LOHnLoCb9k0ylRbPqVMMBo2dJp+L75GO3VdyWaQu3RQym5BQkEPtb+v6tiaXo9/T53pV
         3LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/42AmUSR3HEsprnn8wmWnQ+1+aJQlNoAuc629CHSNo=;
        b=WUPOyR6ujRXPmRiqBiK7W74GsK9g6J5pDfarirO4ShSwiIDMcJQSj85eOClFSknzJc
         37IyPP58gu7VuUemqIdDtsS8Qj0mHgj5WiRzvMYTij/LyshSeSfJT11PLSs+gUsdVEY0
         N6RZRUHjwvTZVzDpODpG1Juh6FhlDXq+T1xWy4psTFGz8Sn0MPxShnqXq1884N0qFUFW
         i4h0tk8Ij7sNY8d7WJA69V1NXxTy4AWrKgRoJS0ebCrerJGUESdhMF8NMGMfQ0IXuDyU
         9W5ZAVopeg5OdYKo71OHxRrlKYmM6rYCYtRFbnX2ZGmFfNrv9dJt8kBNa94bv1al7rnW
         7DOw==
X-Gm-Message-State: AOAM531RKl9XRA0RhSbV745AK5+hcvXTGvsUjAmoorMF6MXiNIogAl97
        fA/s5pQUC+AR5l9IGCYVcIPfqkGeipgj8Q==
X-Google-Smtp-Source: ABdhPJzNIfCVtPTxvASbz1KPt1TpCt7eAEwBfv6dfI4HQS7G/PEJvopR80vBwKTblKAvcm5p/do/GQ==
X-Received: by 2002:ac8:5f54:: with SMTP id y20mr115753qta.324.1634652394984;
        Tue, 19 Oct 2021 07:06:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y22sm7617055qkj.93.2021.10.19.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:06:33 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:06:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH resend] btrfs: mount: call btrfs_check_rw_degradable only
 if there is a missing device
Message-ID: <YW7Q6ABqX+8jHJ+b@localhost.localdomain>
References: <f417a0730df69830b07db681eb0992a3ceb99d81.1630639255.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f417a0730df69830b07db681eb0992a3ceb99d81.1630639255.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 06:43:38PM +0800, Anand Jain wrote:
> In open_ctree() in btrfs_check_rw_degradable() [1], we check each block
> group individually if at least the minimum number of devices is available
> for that profile. If all the devices are available, then we don't have to
> check degradable.
> 
> [1]
> open_ctree()
> ::
> 3559 if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
> 
> Also before calling btrfs_check_rw_degradable() in open_ctee() at the
> line number shown below [2] we call btrfs_read_chunk_tree() and down to
> add_missing_dev() to record number of missing devices.
> 
> [2]
> open_ctree()
> ::
> 3454         ret = btrfs_read_chunk_tree(fs_info);
> 
> btrfs_read_chunk_tree()
>  read_one_chunk() / read_one_dev()
>   add_missing_dev()
> 
> So, check if there is any missing device before btrfs_check_rw_degradable()
> in open_ctree().
> 
> With this, in an example, the mount command could save ~16ms.[3] in the
> most common case, that is no device is missing.
> 
> [3]
>  1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
