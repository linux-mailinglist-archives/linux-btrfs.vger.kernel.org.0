Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E113D4653
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 10:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhGXHnf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhGXHnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 03:43:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F925C061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 01:24:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso8237742pjb.0
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SuSo5jMjwDHi3VBPZHsrYSbCN/4vcKZEN2N1GtoXa/s=;
        b=GUKLRmnYr13KJLTr9qJ3kOayaKWhKhjgy5BKit8yv2I57fhdvtq5kL+UfxPLYRtIj4
         YdQhk7gZwEcZCqZSfkSxvjjPWB84Ew+wL5QTjMmr6+O34FZCz34cnwZMWbrnfnNgm4bu
         /4lfO4wFEerHfWy1FpeO13LcEpEcTU6Ot/E5r/N0nxLQpUGd+3xKTQw7Cc4yjJnOSakB
         x6fBbBiab1ZqUZhj7vO68xNtZWpGG6rN8s3XCSGYyV2lUsDywvbkyxPjHkYWFsyu0LbC
         iFnUI3QAFw1DwJ8LgeGKHLvJ32B+PxdVHLzCTMdlC6TOdH6TVcv9KmKWCnwHMCZKe6JU
         c7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SuSo5jMjwDHi3VBPZHsrYSbCN/4vcKZEN2N1GtoXa/s=;
        b=fL39l1ekD3HTz2QWVYYyTkY8/Y07x0z4C29CuLZJnKe5LincqT0I6+c4HRaMsk4Czm
         3AW/bPcUj2MotfLGzejoaMufnLOMjYyRssq3k8b/cEz/N+CfQlWCVyIOBjxA7fUrch0h
         pNzjc2cbuLxMCSi4ATfs4facrepwYOJi4oemh5u4AB1apKORawVCUXiDeHLfCNCaimV5
         PNnNTMknOHXeffGQcq2reyMD1yRyA8y8TFSh/0aFWsmD+qneS+w9LJu0i45wWB9nolOD
         unrpfw5MVHuWuHY9TPtubJ2oyTpMWwi6OChEjqxrbM+IQWPb8PnQd+wtU7Pus8yTNHVX
         OWHg==
X-Gm-Message-State: AOAM532KFdg7+mIxYemQ+e15klpYDqyrXqP8x10qW3N3sS9B3BClp+9u
        VGnqZcJUFxQerKQIjnRVBWI=
X-Google-Smtp-Source: ABdhPJzpfAoJiW/GZxiUe5STOgRpz2N4TbLBFa1dkP4zWJ2RWX5si8fWBk0KQLblhSfQEzeIDUeu+Q==
X-Received: by 2002:a17:90a:c202:: with SMTP id e2mr8168623pjt.123.1627115043939;
        Sat, 24 Jul 2021 01:24:03 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id q21sm17924235pgk.71.2021.07.24.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 01:24:03 -0700 (PDT)
Date:   Sat, 24 Jul 2021 08:23:56 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
Message-ID: <20210724082356.GA68829@realwakka>
References: <20210724074642.68771-1-realwakka@gmail.com>
 <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 03:50:25PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/24 下午3:46, Sidong Yang wrote:
> > There is some code that using NAME_MAX but it doesn't include header
> > that is defined. This patch adds a line that includes linux/limits.h
> > which defines NAME_MAX.
> 
> I guess it's related to this issue?
> 
> https://github.com/kdave/btrfs-progs/issues/386

Yeah, It seems that there is no patch for this yet. So I sent this
patch. Is this too minor patch?

Thanks,
Sidong

> 
> Thanks,
> Qu
> 
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >   cmds/filesystem-usage.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> > index 50d8995e..2a76e29c 100644
> > --- a/cmds/filesystem-usage.c
> > +++ b/cmds/filesystem-usage.c
> > @@ -24,6 +24,7 @@
> >   #include <stdarg.h>
> >   #include <getopt.h>
> >   #include <fcntl.h>
> > +#include <linux/limits.h>
> > 
> >   #include "common/utils.h"
> >   #include "kerncompat.h"
> > 
