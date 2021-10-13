Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EF42C778
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhJMRW1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 13:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJMRWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 13:22:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32433C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 10:20:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so4954195pjb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22NH0xsWoI2an3AuExsbM21Zf6lOFtjEGxxQ33oX8Nc=;
        b=jcA3VJL173DwGp9DG13hEbd0O64LIheqV9amzdTagYI5qaS2BN0HGE0KX0EOplTkTw
         kWP2KE4NFZpqHy5Sx+d4+ZydX8aTYH1zfdu4xznUe9PBiqDwbObbDLKDzFY+2t40dtrZ
         Z4hcl04HcxyYvThsDAcbVnQwbE09nY4gxvlBmy9JvqAQXNXiEtPa3MkzxXbJvQ6rcnNZ
         U3TYYPPxsKSMLsfxzZK/qyafB1/dHDQyRdDsbrhO5kISIYYV5GTFKk2qp7nzNfyQUjGM
         zfngHCYy0G/ImpI2bWp1l9nvQ+VYbdJpNDesmSic50IShr0gL70r2GpReGUzqTIWTQ1F
         lXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22NH0xsWoI2an3AuExsbM21Zf6lOFtjEGxxQ33oX8Nc=;
        b=tJIXJbqlzMXAi0fRTmYzGq1b/7Dm3Yt6TtnSPvhz8c2f3ego/Lhg9ve4rldtrALzQK
         mGwqWBp25/gSHqmw/8+LBKIDGE8sNFaaY9CV0FwUbTXa6tPHibXpaQ9yBHEnQkF7rhS/
         Co0TuUBDIcv8SX8l4Z78StxqrMjW/8E1X37FxA7PAOnOP9SWSY5DtT0csa1EwDKAP04K
         5fw6hOeUfoRHJpKPMqOx2cpo70B90CgPvcTt2mLRtxW6BQiffjWdNu/9DxRj10tfFhc3
         djfrJh7J+dYmpppRq3u4Bc0DWKKk85ltg2IXUirFGp7eznkyWgxemPwZA7kkCc5scB+e
         IryA==
X-Gm-Message-State: AOAM530JEkvLXSJB+NZ5MVeR9icbI/M7/o6tPWA7pAChn+uFhjTElKws
        2SPirIgqYWr9ov9wkNYTuWfLMQ==
X-Google-Smtp-Source: ABdhPJw4quGMFTF4LLqBHW24M6OsRjqyDwVDjpGtI1ocWP1KgUPK01O+ixjjEnMjdSck+SAqEozwBQ==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr575012pjl.19.1634145621539;
        Wed, 13 Oct 2021 10:20:21 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id k6sm143577pfg.18.2021.10.13.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:20:21 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:20:18 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH] btrfs: fix deadlock when defragging transparent huge
 pages
Message-ID: <YWcVUpqe1i+Zibgd@relinquished.localdomain>
References: <f2e6ca5a69c2ed72fba3f4797b37d325cb18c137.1634083989.git.osandov@fb.com>
 <20211013114106.74EC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013114106.74EC.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 11:41:06AM +0800, Wang Yugui wrote:
> Hi,
> 
> I failed to use this reproducer to reproduce this problem.
> 
> kernel: 5.15.0-0.rc5
> kernel config: CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> mount option: rw,relatime,ssd,space_cache=v2,subvolid=5,subvol=/
> btrfs souce: 5.15.0-0.rc5, misc-next

You also need CONFIG_READ_ONLY_THP_FOR_FS=y.
