Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D15443335
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhKBQmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhKBQmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:42:14 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787A2C079781
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 09:15:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d6so13630198qvb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NkEWS5pYGhHqSCEdMuaKKkALB6ssriZ0zhr6usSATmw=;
        b=I9WxXFsCBFhDwOTelaNgFDHEKLdUjPkPhQaQWrVYv9qhfQHcHQx0tVouE7dyrudm9r
         WbN5NF1w0gq3vIbuIUtLPE/0EOD4cvUa9uvxj4LVDwD4Qxe+n7vabkXFQ2BBuJNuL7qd
         LpT/Y03QWu5uhpISPl4suNKOGSlwt6D96X4/A1iGES+oevF3JTzoXd6h6rR8LPT1SD1l
         UAzUcDGW3h0ahRRJaAUpjWTgDa46IOXQj4WOuPH+kDNh9cenUuUYf/DqGpuOKw7kdDsD
         OR7UbGMFPNljeVCVzmv1BJZzhFRnDYlt5/SD0t6Yh6CFdwVuLu6pHszzqTgMlzWnaGi7
         8jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NkEWS5pYGhHqSCEdMuaKKkALB6ssriZ0zhr6usSATmw=;
        b=vSTsOd3EKfKgaOxnklLnWAC40JzyJ1feuhBykahfegEo6h2llMwR02TCU1TnR6z/Co
         w6jrvZGntDlvj+tML2yu12lHFuDYZuyqwnHt5a5h70TFilsfTbueHoXOuXMzOkuAukVL
         GIlEz4TBwP91ntgcuQ5uq+L4RZugc85xVWFjUyooOzqKfVyRKs8xT8TLwSysUukEhsZJ
         7Z7ZGktTO6LAbGf0RAmxcPhN+eK/SqummO5tFobxm8SIdgzGe/eQxn0TcnH1wgAyJ6fu
         lczniucO6dJ3Ih72eZ71SsHh20KwbBcq40aO3JrDXkGCti1ulrsUUSC5XcF1E3Xv9VW4
         FxVQ==
X-Gm-Message-State: AOAM530v/EK0zauXNuWaNM0nJrcYTdZZAu5KCcUKOWhNnLjy3ASnJtSk
        DR5U1dEaW0I968gzN2Kkm6CGhw==
X-Google-Smtp-Source: ABdhPJwZMjWe2azIuHoxBETIn11HKljGMJlKDjn7uusy6hjW8Dxnk53NMM8h5CHlkGg3BxXmfqMUhA==
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr9680519qvc.46.1635869742563;
        Tue, 02 Nov 2021 09:15:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b21sm11372431qtk.69.2021.11.02.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:15:42 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:15:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/4] btrfs: sysfs: set / query btrfs chunk size
Message-ID: <YYFkLP/cOgje+Vi7@localhost.localdomain>
References: <20211029183950.3613491-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029183950.3613491-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 29, 2021 at 11:39:46AM -0700, Stefan Roesch wrote:
> Motivation:
> The btrfs allocator is currently not ideal for all workloads. It tends
> to suffer from overallocating data block groups and underallocating
> metadata block groups. This results in filesystems becoming read-only
> even though there is plenty of "free" space.
> 
> This is naturally confusing and distressing to users.
> 
> Patches:
> 1) Store the stripe and chunk size in the btrfs_space_info structure
> 2) Add a sysfs entry to expose the above information
> 3) Add a sysfs entry to force a space allocation
> 4) Increase the default size of the metadata chunk allocation to 5GB
>    for volumes greater than 50GB.
> 
> Testing:
>   A new test is being added to the xfstest suite. For reference the
>   corresponding patch has the title:
>     [PATCH] btrfs: Test chunk allocation with different sizes
> 
>   In addition also manual testing has been performed.
>     - Run xfstests with the changes and the new test. It does not
>       show new diffs.
>     - Test with storage devices 10G, 20G, 30G, 50G, 60G
>       - Default allocation
>       - Increase of chunk size
>       - If the stripe size is > the free space, it allocates
>         free space - 1MB. The 1MB is left as free space.
>       - If the device has a storage size > 50G, it uses a 5GB
>         chunk size for new allocations.
> 
> Stefan Roesch (4):
>   btrfs: store chunk size in space-info struct.
>   btrfs: expose chunk size in sysfs.
>   btrfs: add force_chunk_alloc sysfs entry to force allocation
>   btrfs: increase metadata alloc size to 5GB for volumes > 50GB
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
