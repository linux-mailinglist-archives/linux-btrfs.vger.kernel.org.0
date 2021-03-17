Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA46033FA6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 22:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhCQVXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 17:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhCQVXg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 17:23:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C454C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 14:23:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l1so55276pgb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qp5c9x3nOU8h6pgNJeP+blSWvNnrMvnJCkTmYvTynUg=;
        b=1aU2OKI48n+reHztQK6CVSN/UA/lrhKXc50grxTThB42G2/tr7h0uqmVtpt6/tYF5L
         lVG80/Ya3RFWvilrDctzFQYUrCyDSfRBRaBSbf6Afsx1OGQC/daeDcByEBCwe/JQl1Mr
         KafklOAAcAF4zNsHb7uyP4bOuyY4fFXO0AiuAfAU7GoOm06m+1TfjMHNL4y20udqdVTh
         g+BB3n1rrindN/cllN9YODhiIidZNXg7VWTNWHrM0jvl29rGH7wlEn6U+XtyDwGaYJAR
         S7tMAiOB/mWTLJfDcV1mdi93W6kNLFoR5OPdmsECTOvvp3xZhgdpxrsbshMhHvbFdKiD
         a4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qp5c9x3nOU8h6pgNJeP+blSWvNnrMvnJCkTmYvTynUg=;
        b=YmleACFN9p4PvKz9bsY5FXqM7+lEa23KwCbFUfJCdHh4ERw+9BmXk75ws21OJzbW+e
         GhawLZ5rWxtApxyLFm0EjsWMpc9qNPqXSrCOLLfOCydqIgZjAAiJE1pF1hsFBdoX2U4q
         rEceo7BhuD3Ed6TKtvFD6hZS+e/9mcvXk+HAP4I/dx1FcIDSyOHTx6Ipbdwrw3c9W4ct
         LFYs8FpEeHW4ppA5BJY+1JDDtrcPQVJSnV2776tFKnRLoWuerCks2OvnnUUOYxxL5/Vf
         C+YIGdiYe8fwbFibJU3LYszn2JB4LyFrIR5qV4K0/X7jC5C/SHvzU8O1t1OKWJZ//4Vd
         S6Bw==
X-Gm-Message-State: AOAM532EaudxcN4zto3BbZbUCDI38NVVCTlG5cTCJOEOjBVuyAJ9YkCS
        0lo94I43n+qJAQqvQSVnauWbXdHN0JhYug==
X-Google-Smtp-Source: ABdhPJzP4pRrcsiFGm4/yBK6/K9kZS2iz5mvKIZhaQv+BzA+uEva9WWRF529zgMOvB39xayBlxjVlQ==
X-Received: by 2002:a63:e942:: with SMTP id q2mr4185376pgj.217.1616016215456;
        Wed, 17 Mar 2021 14:23:35 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:156])
        by smtp.gmail.com with ESMTPSA id v1sm74133pjt.1.2021.03.17.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:23:34 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:23:31 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Neal Gompa <ngompa@fedoraproject.org>
Cc:     linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
Message-ID: <YFJzU5xSxpU2vjTJ@relinquished.localdomain>
References: <20210317200144.1067314-1-ngompa@fedoraproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317200144.1067314-1-ngompa@fedoraproject.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 04:01:43PM -0400, Neal Gompa wrote:
> This is a patch requesting all substantial copyright owners to sign off
> on changing the license of the libbtrfsutil code to LGPLv2.1+ in order
> to resolve various concerns around the mixture of code in btrfs-progs
> with libbtrfsutil.
> 
> Each significant (i.e. non-trivial) commit author has been CC'd to
> request their sign-off on this. Please reply to this to acknowledge
> whether or not this is acceptable for your code.
> 
> Neal Gompa (1):
>   btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
> 
>  libbtrfsutil/COPYING              | 1130 ++++++++++++-----------------
>  libbtrfsutil/COPYING.LESSER       |  165 -----
>  libbtrfsutil/btrfsutil.h          |    2 +-
>  libbtrfsutil/btrfsutil_internal.h |    2 +-
>  libbtrfsutil/errors.c             |    2 +-
>  libbtrfsutil/filesystem.c         |    2 +-
>  libbtrfsutil/python/btrfsutilpy.h |    2 +-
>  libbtrfsutil/python/error.c       |    2 +-
>  libbtrfsutil/python/filesystem.c  |    2 +-
>  libbtrfsutil/python/module.c      |    2 +-
>  libbtrfsutil/python/qgroup.c      |    2 +-
>  libbtrfsutil/python/setup.py      |    4 +-
>  libbtrfsutil/python/subvolume.c   |    2 +-
>  libbtrfsutil/qgroup.c             |    2 +-
>  libbtrfsutil/stubs.c              |    2 +-
>  libbtrfsutil/stubs.h              |    2 +-
>  libbtrfsutil/subvolume.c          |    2 +-
>  17 files changed, 495 insertions(+), 832 deletions(-)
>  delete mode 100644 libbtrfsutil/COPYING.LESSER

Acked-by: Omar Sandoval <osandov@fb.com>
