Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1542AED2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 23:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhJLV0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 17:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhJLV0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 17:26:22 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D8EC061570
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 14:24:20 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i84so1439141ybc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vub8duHVU/Ud7E1FxlySaF9eVXb+O9BFkWwwJqsiTAQ=;
        b=1GjGL/1Jo8LVn8E7QSifYEtNVCumn8HTBA8oHm6vUcFtKA0RVCQ/78XRm1nGAUuWgH
         68CITdb+wgffKFenYCX0K39N4wJwddQ2aztJW0z/4j1tlGa+MRiT0yyq+bZWN0KJPNQT
         fJbkZMRemSAzaLQ3D9Y+3dMzMxKtYIDGJupGA9mFa2C0qiunnBvJbcW3Iz5bfORYEZBG
         GRwfuFPIWfb17PDxwMD6ep/7KSVh4W2H6HfOl4zZ0HN8sa+oOB2onkCAss2ciVqqeL0H
         vGYUDGXyXlfyBQIYm1ZLfGa57rqhwgd5EU43hP6/3Eu8t2HUh6i0tPA0rh9u1oU+oJwM
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vub8duHVU/Ud7E1FxlySaF9eVXb+O9BFkWwwJqsiTAQ=;
        b=BexbsTRZElPLhSkAO8F/jRnFKHziiuGSkg9eA4KUlOGqMVdaX9URI8uux/CCN5sbNP
         oPTJ7zbwaANUeiEYD5VNng5vYj1VDYXh9pygDOBUcsdsTC3CJcH8L5fzsM3jYYm2bcwK
         mEd9dY60AHYxDg+4F18U+o8FdF14YSoE+8SkzTMv/jd5H20mqaMKimz2pfUZNeiMnt7b
         tnkBUD1k4m7sj/Pj/y5FVbbu/gK+7gYFpb9fi6xQ4ORWH4lMXiL4uipsdGI+Ph3tkMK6
         +KR+G87VKtqh5Yx3DotV9V43Yvg5x9x8ZS4pUx2aWQG+c6U/7VoGrPFeuYvS9CjQefUP
         X1Og==
X-Gm-Message-State: AOAM530GxycUwpylakkmc5nQ/nv9XO/nSkKbdN5YGUBlEv8RBiVz9ubI
        Z1UABgiTrFuzrOytbCv1WcFpA5mdVZGgxPrr93X41Q==
X-Google-Smtp-Source: ABdhPJx0bOh9OM8FWR14pGHVJwiOhpDRpIWtCoDWpUBZ9G8aWqRRsjmPk7CQ5yhfjk1P+vONK8D9FEVPpeRW1whYX7o=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr30830037ybf.455.1634073859385;
 Tue, 12 Oct 2021 14:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
In-Reply-To: <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 12 Oct 2021 17:24:03 -0400
Message-ID: <CAJCQCtQfBp1txg89pFcUwBCAz6kxq97qr_85kxjrWfrUJUzUCg@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As it turns out we have several bugs that look similar, in that they
share a stack trace including

Workqueue: btrfs-delalloc btrfs_work_helper

But also all three show compression related functions.

https://bugzilla.redhat.com/show_bug.cgi?id=2011928
https://bugzilla.redhat.com/show_bug.cgi?id=2006295
https://bugzilla.redhat.com/show_bug.cgi?id=1949334
