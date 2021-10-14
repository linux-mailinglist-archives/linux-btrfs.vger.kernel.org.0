Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8E42DDB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhJNPOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhJNPOG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:14:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB94C06136F
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:08:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c28so5993171qtv.11
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pDvyZgyEWGKKkUbnpfdvT3F4WZ7VOnNIgAWn9oW8UgQ=;
        b=6ZKmhT5o7IvNMrphHjGVbxADqnudQBsiIosqEcafjLzDcIhfoGl4RbT0HNvw+ngmQh
         +3727FhGA/IL/StiW7QYdOnYnoU3QoAz7DLReDJskVugWqGGjZTQsyeN21CGpFOiyClY
         K0yX9j86ZnLKakEdRCtcoMYJMP1mRQGyRb3nHhhsD0SHqnsfQlpr63hnb7iNz2qF0n1P
         ZDCX5nSf/dLEkOek+OctOHzxoSFxigEUHh/3rRAs8a71iSkz6rvpfEDKTMEPBxO5KqyA
         1AuVNXpK4GXQk0jNLtWbXqr/7lL5075MpGnA/FS+pVi4y6jGP/JPnS2lddZsrofteSiC
         wY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDvyZgyEWGKKkUbnpfdvT3F4WZ7VOnNIgAWn9oW8UgQ=;
        b=DB7wdERT61edjYGJiIpwBUgfy95wJQfSZmpMzNBD85phSHq6JDgK5wxIA4vKkH67ko
         9rrT+tvpEuZLvdU7AWdg3i2gDMPKGgt6/vgkLT03T+aAmNaeJLT4H7/v9E3gFcjeFEOu
         bOM1ZgBA1f9lkFaNWPfsPx9+86IerLz+AFErFcKcV3e8d5DNSLjdIovDGTEhpkIHipI8
         gJ0mFJ4aBEevHM2Skx4UT7Re3sg+TmaK9u3Kcp+E/P9OeirDWahJ+5P1+7HXbCYfBfo2
         6VfrHtQ62fVUSilvgsPXqIICHFG7hQwDXpv1kuqZ5J3Qtcww2slnfwwNK2AzQ+j98FKC
         nPzw==
X-Gm-Message-State: AOAM533caK7TOqQVC9SlnKgA4Z88ZaL/a5N9BTBjZPqM6DBaNa932owV
        Liy0CUWPZwzCPmgZhgUJz0gyeA==
X-Google-Smtp-Source: ABdhPJytP2b7lVQs2wy30wGXpxijbICaO78Y9LhvmptZPAjiMwEy/DKz1rydzSJcjOMIIrj/pl3ROQ==
X-Received: by 2002:ac8:5747:: with SMTP id 7mr7043576qtx.11.1634224091060;
        Thu, 14 Oct 2021 08:08:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u20sm1407303qke.66.2021.10.14.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:08:10 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:08:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove spurious unlock/lock of unused_bgs_lock
Message-ID: <YWhH2bZQsreeIzl9@localhost.localdomain>
References: <20211014070311.1595609-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014070311.1595609-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 10:03:11AM +0300, Nikolay Borisov wrote:
> Since both unused block groups and reclaim bgs lists are protected by
> unused_bgs_lock then free them in the same critical section without
> doing an extra unlock/lock pair.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
