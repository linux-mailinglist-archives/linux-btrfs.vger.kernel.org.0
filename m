Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604A83ADF75
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFTQvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhFTQvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 12:51:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6BC06175F
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 09:49:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k42so6982489wms.0
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hi9XxFsg2+njf5eiHTo2moqMzPZF5FcImYbk5S3IWc0=;
        b=OUTh+M7ooVvCWgCATgkrD4eCQ8LG5pNIxhGt3UKg96pN8kAuyVmIXMkOFtSfLvkA38
         BAgTCd2kvGMT7fFENQSx2DlabpEhWTpKMTkrRIjgFHnLBU0O78+JwwM4IU1Q1STRJIjE
         Z2JDCDlKawuJK5jYYKPUvO3ouxoazXI3+cA4zHqNfm9r+oF/eZzd+QfV+FHW/ZVASkZm
         8wknwogdfM+YbhFRGIIpJz6/fdo/tAfBuDW0QwmVkoAFjxhwuLhe/iBqvjYuIrQ8ZpGq
         a+T3/nlVtSe5M1HNRA7FIkwLFR9DE7xTAXUt/DP9kvUW16EFettMt7HTbCVmFeKHijsi
         kI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi9XxFsg2+njf5eiHTo2moqMzPZF5FcImYbk5S3IWc0=;
        b=nX/N1KxnSvhgC/QSKMfvMOOaP9Z9OtA0f5b7VNcRiWIL2CdslY6ULINBQljY5N454G
         4wlPuK3j2fIIjRjDFWe2xFnLvinFVf8RlkbyI7sIYtEPC/FrSyFkdXpJPLnQZm28el2I
         pJA18Hc25sTA52xjRtUL4uvtI4IS+jPXD9lDKCNwSjqlYbbFDgkahjtfgqsD1kZLERXN
         xOjUsnrXQaOeXIoI7ctbWIFtiz68BbBj1GrdUH4FTQm4TRqLPHs35oToGcvb518fuor2
         Got7imdKSr+XflNy5QIlsYxXGs6KgAYEurNxkYvPji/BKptYBW7v4BeSBdNDsWBpgM9X
         qBcA==
X-Gm-Message-State: AOAM5308A5aFEF7y49fUANeQvTcLuQts1aFCzy55tHvp9N0GTwkzF9i9
        Em3WNngksAoFTARZ/HMHQoB513Mu2zc1d828Etnajw==
X-Google-Smtp-Source: ABdhPJxT4x187dNB8RaTqUBpAoCej9kyxOkLd2GmYSyTYXB0gLiWGI70VYAIkPIkTYgKYeMpp5229+oS0atvlFRrnBQ=
X-Received: by 2002:a05:600c:1d0a:: with SMTP id l10mr22790265wms.124.1624207774199;
 Sun, 20 Jun 2021 09:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com>
 <ab0e8705-e18f-90eb-c42b-318c04a2101c@gmail.com> <CAJCQCtQXOgHTDAiGCWEN8_RaLNk26o9iDvtNcEBg9EVZ0yfdLg@mail.gmail.com>
In-Reply-To: <CAJCQCtQXOgHTDAiGCWEN8_RaLNk26o9iDvtNcEBg9EVZ0yfdLg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Jun 2021 10:49:18 -0600
Message-ID: <CAJCQCtScnSxgou39cdAGTNsjUQNkXiinatiCqDi22PeRo1PGmA@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Asif Youssuff <yoasif@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 20, 2021 at 10:24 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sun, Jun 20, 2021 at 3:07 AM Asif Youssuff <yoasif@gmail.com> wrote:
> >
> > My complete mount options are:
> > noatime,nodiratime,space_cache=v2,clear_cache,nospace_cache,skip_balance,commit=120,compress-force=zstd:9
>
> space_cache=v2 is in conflict with nospace_cache and probably also
> clear_cache; I'm not sure clear_cache can clear v2. Also once v2 is
> used, there is a feature flag set on the super block so it always gets
> used, and I'm not sure if nospace_cache means anything in the presence
> of a free space tree feature flag.

clear_cache does clear v2 as well as v1, and nospace_cache overrides
space_cache.

So I think your mount options should be:

skip_balance,nospace_cache

That way space cache v1 isn't created. If you've already mounted
before seeing this and it went read-only, you might need to do:

skip_balance,clear_cache,nospace_cache

You can deal with rebuilding v2 later once everything else is fixed,
so for now you definitely want to keep nospace_cache for all mounts in
order to prevent any writes. v1 space cache creates bitmaps in data
block groups, but it also involves some extent tree writes to reflect
that used space; whereas v2 space cache creates a dedicate free space
b-tree. Either way, there's metadata writes happening to create it,
and the issue right now is you can't have any writes at all, except
the ones we need to get the file system unwedged.


-- 
Chris Murphy
