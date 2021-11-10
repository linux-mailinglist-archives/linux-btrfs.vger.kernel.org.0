Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B135C44CA44
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhKJUOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhKJUOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:14:32 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE4C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:11:44 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id t11so3300875qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SsK9sehShK9jFv5xbts0KvFIiUjwldxmh63HDcLspuQ=;
        b=eeaYn/3Xz68MrmCB9/+SwBVdtNelPf9sDewZpXp+NaUFybnhwB+3CHM5Jx1PBVKPJ0
         Fv6bvRhCXO6glsyx3Tnto/Y8vhFOF83uQMpYMp3h4tV4awqSs1l2Ixe541RL44nFLfb6
         0n7HyZioaOv6bkGjI32woKxNVnoDNOk89QIVLbBWDTTdFw25fa7EEJvzsAzWVJyWQhMV
         NT+pwHZ3PLNFvf+gudXjP2WapXrmzxmMU7hMWBIi9wQdYxKa7kci6E4Klnnrk+F6gmwU
         y8EoAmMT3Sut7zSzeWYwrueJEwSGrlIGBL/+yFSYv7dF8d0l2BmHOxxOUYxgXKcpFa0Q
         +XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SsK9sehShK9jFv5xbts0KvFIiUjwldxmh63HDcLspuQ=;
        b=dl9uDlnZnnWJfq+05Inu0IkNC1HbCIRZN26z8dh6Y0/h5SeMAkHl1EIsqkFXHWYv+3
         +VsLpaEKLVHeJx7NR9n/HAHR+xmmpUjbHtZN9FSfvgaoHU6EAYG1s+h6eywvtFGreDGE
         MnYRsrbI5qFI/rN0vgTuBpK5/HHmW6GvRW7XH6kG1L+F6bcu7Ff2GTbCzNa762gn9lpO
         fF1hy7d7bO1hWgq1EaohKr48jV3eVxjIjRiSVfRf6E9DcCfqU1/wX3ZC0XABkYyed3GV
         i9SCXaHqAAMo80FJsvUosjZ0TE8U2R+vtOsXl3K8FECYs4e7kUkWTKZ5rQoqM7Onv+QH
         zupg==
X-Gm-Message-State: AOAM531C9rY+PSJjxTOHGgDuvXalQYSWpzaXH1U/8Bpq8WZb1ouLMjWO
        4qH5pXA4ATnsjmvBDxwVwDzHFx/ygMbnrg==
X-Google-Smtp-Source: ABdhPJyNbs4sWIXy3qW+Svlki5VJq965n1qz5/err6FeOOygHS2rhpFkWmUnHbeb5R3x17bSGxbzvw==
X-Received: by 2002:ac8:5c0e:: with SMTP id i14mr1878959qti.260.1636575103262;
        Wed, 10 Nov 2021 12:11:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v4sm432509qkp.118.2021.11.10.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:11:42 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:11:41 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/13] btrfs-progs: extent tree v2 global root support
 prep work
Message-ID: <YYwnfUhE1goNzJ7I@localhost.localdomain>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 03:07:51PM -0500, Josef Bacik wrote:
> v1->v2:
> - Added a "btrfs-progs: check: fix set_extent_dirty range" which I discovered
>   when adding the next part of the changes.
> - Dropped all of the global root stuff, pushing it into the extent tree v2
>   specific changes.
> - Reworked the super block root helper to take a level as suggested by Qu.
> 

Sorry I'm an idiot, this should be v3, not v2, I forgot I had refreshed things
and sent out another v2 already.  Thanks,

Josef
