Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57E2D34C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 22:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgLHVAp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 16:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbgLHVAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 16:00:45 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A8C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 13:00:05 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v29so209896pgk.12
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 13:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cwW3YgsvDtVRzNj3KuppUzkTSnOFREFUC/UYEEjQ7fI=;
        b=valfG4XwYrdBXW6tNPMQaxldyYPUbQ9bNDfRbtZhIqH3Kas+n/c6LlL6ErZjrJ6xh9
         pvXI4YGvEGoeP4epNyMdIO8fAVMPicqa+E214OYbejhtpQgjweTetUysopEN8pQl0CXo
         LRHxAj+gBpRYvbkIVR7rPHYJn0MjYN42wAWHM5JHSTlEhpDSp7K2kzfe1GbCBBzAWW2z
         NsbPy0PdMW6VG1ZscLePbqkvZj1Oel3XxBjyLhtGboCSJkU+4zeYhiA4kleuir8yvSEt
         1V2JtVPmPQp4xE5u6IJI+3jSX9UgMwclTRpi2CznIafKACddK4VgsU9KANPztYfsjwNS
         chuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cwW3YgsvDtVRzNj3KuppUzkTSnOFREFUC/UYEEjQ7fI=;
        b=uMXcrLHZUyqYx8gu6f9a3JtsYhR1+lfxvG+yXR89qIHGUgC3X/NWm7yNvEIE52tDE/
         1rIScjPSiQJzUoOShwf/ZhorqoBdH9MOh1dqbMXg2BE2A2D+V7YwHx3HnpjYHDoXhrUL
         0KUYOorJkBQRxEMs+poxhoxAxApjIprOTUwBCYWbQ36LjTjN9Q6CvqIeD7IOD5bCjio2
         pEyU7UWSOcXD+B8KPSQsC0tr/Oo6b/zWrIOfs7xJ4lSUcBfvoQS7vO0Gv3Jx9jj/tMAX
         F2rxW2ZUDDKGBJslGVXi/7GoOeoZHpKZvO3w8FuKMBuAGHwQxOL+eBD6dqnLBv1yaA0f
         Aj8g==
X-Gm-Message-State: AOAM531qZ4GkFy1bFZbmRwqf/5I7D0YVxifddOqBVClFoVvPMubSrPR2
        r2kgfMYLQ4VtXXM6/un/zsYtzQ==
X-Google-Smtp-Source: ABdhPJw4aE/wJJSwKSOgwdk9Gu82pnReFbn3gcKUyxkDtqLnYCvIJ7zfG4dNVB0GqPbEIZAqPPf35g==
X-Received: by 2002:a17:90a:bf90:: with SMTP id d16mr6019154pjs.200.1607461204677;
        Tue, 08 Dec 2020 13:00:04 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:c035])
        by smtp.gmail.com with ESMTPSA id z23sm39903pfn.202.2020.12.08.13.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:00:03 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:00:01 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Stefano Babic <sbabic@denx.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: btrfs-progs license
Message-ID: <X8/pUT3B1+uluATv@relinquished.localdomain>
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 08, 2020 at 10:49:10AM +0100, Stefano Babic wrote:
> Hi,
> 
> I hope I am not OT. I ask about license for btrfs-progs and related
> libraries. I would like to use libbtrfsutils in a FOSS project, but this
> is licensed under GPLv3 (even not LGPL) and it forbids to use it in
> projects where secure boot is used.

libbtrfsutil is LGPLv3, where did you get the idea that it is GPLv3?

> Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) and
> also libbtrfs. But I read also that libbtrfs is thought to be dropped
> from the project. And checking btrfs, this is linked against
> libbtrfsutils, making the whole project GPLv3 (and again, not suitable
> for many industrial applications in embedded systems).
> 
> Does anybody explain me the conflict in license and if there is a path
> for a GPLv2 compliant library ?

No objections from me to make it LGPLv2 instead, I suppose. Dave,
thoughts?
