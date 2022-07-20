Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25D957B8E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiGTOuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiGTOus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:50:48 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3005B07
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:50:47 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i7so2936922qvr.8
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pQfj3T5vCijLKYqQsPb6W704B1VvE3g7Ab/IeAbA8RQ=;
        b=cDMs7U16/+I1zGKAQCe04QjjeLTt7HK8SjI2AieCt6pRnuiHKQ1hJExpv7J3wH283Z
         pgDOfbcPL7HQXdTx7b0hpxYpQfU5wsqyKzI06A2360PtljmbgbKzSSpICdWMhR1+2M7t
         9jCM7OiSbZHeIgCrLMg0IMHtE1/Hnbyu9qEtt+V5EFR8ahXUq6o1D/oB3gri1IsWw2fV
         IOl2Xnu6ysEPsGcbjCujZASfQuVtyNd2nT802glqGJ2ceUtuKq/VrlIs/ojQwv9oe15R
         dDb4oqGO9BfdSwMv+SdTkh4XovqSa4WHlBbK3BFJ/ag0tTQ2t+qzBefLKhoVpu7YrHZK
         PFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pQfj3T5vCijLKYqQsPb6W704B1VvE3g7Ab/IeAbA8RQ=;
        b=v+uPbBcCNur1O9vJWcfwlDccYS1cW2Iy1SlX/MciMTiRJSrjgsxw5Kp9yz7ReU6M+R
         FsZ9KW639IjQXoACoFU72DaiDVsAiQ3nuOGRdUDF8S02axjfp0h5oMzobLVabbAP1WCm
         I7DxSGYA9Qz5/RAg8iiuTvetdnyMOjAh4ln7gCxngHqLKe+OFO31H0I+Bn1wbXOq2sWL
         xfQ9wfZgeotbXsebUt/8T3RbfzHinCCPR1VDrUkQlYdxo10dtAwT98h3/GTKVFXdSXSk
         +rbQfPdZjjkhznrOlT/szHIyU/jn58HZa7d3sFVQWFhtDvjGPOb+ydmBsHM4kpcmpmez
         83TA==
X-Gm-Message-State: AJIora8/mO4trOBRmxrs4YWiJGnusv93a/4vjIn5sChXGgy9DrTcknE5
        yBDvVXvzc+6s8gBhN8HLcIrnWg==
X-Google-Smtp-Source: AGRyM1uR7SdpXfIc9YZSjfbqBQCsBQXshmUIkdDoZCgd68x5lmvoQ45Mpnt8/kcw4wwym+cKAhyq/A==
X-Received: by 2002:ad4:4e2f:0:b0:473:381:2945 with SMTP id dm15-20020ad44e2f000000b0047303812945mr28799781qvb.88.1658328646670;
        Wed, 20 Jul 2022 07:50:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q23-20020a37f717000000b006b5e60c4de1sm8218487qkj.78.2022.07.20.07.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:50:46 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:50:45 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 5/5] btrfs: Add a lockdep model for the ordered
 extents wait event
Message-ID: <YtgWRfSckHdkRviJ@localhost.localdomain>
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-6-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719040954.3964407-6-iangelak@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 09:10:00PM -0700, Ioannis Angelakopoulos wrote:
> This wait event is very similar to the pending_ordered wait event in the
> sense that it occurs in a different context than the condition signaling
> for the event. The signaling occurs in btrfs_remove_ordered_extent() while
> the wait event is implemented in btrfs_start_ordered_extent() in
> fs/btrfs/ordered-data.c
> 
> However, in this case a thread must not acquire the lockdep map for the
> ordered extents wait event when the ordered extent is related to a free
> space inode. That is because lockdep creates dependencies between locks
> acquired both in execution paths related to normal inodes and paths related
> to free space inodes, thus leading to false positives.
> 
> Also to prevent false positives related to free space inodes and normal
> inodes, the lockdep map class for the inode->mapping->invalidate_lock is
> reinitialized in load_free_space_cache() in fs/btrfs/free-space-cache.c
> 

Make this bit a separate patch, put it before this one with an explanation of
why so we have a commit per logical change.  Thanks,

Josef
