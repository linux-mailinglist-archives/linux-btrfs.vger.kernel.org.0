Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D989430DBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 03:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbhJRCAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Oct 2021 22:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhJRCAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Oct 2021 22:00:03 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E2BC06161C
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Oct 2021 18:57:52 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id u32so1487834ybd.9
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Oct 2021 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flixKfvlsofL+vnRr68i2/HaFWpVxj1h+60FOp6NOfg=;
        b=wUG2EbrFACk2z9g0T4VCufik16lP3GcW2bnCNz4pErYyxaGW7nGzdFjBSscqfg9ugR
         J0DEVfez/nwg3EPDy5u2fonqyDC6CzxWK16oniGaI/09EfPK9tkw8YzmBNi3utQm2jUN
         6ncLC89Zi2SRUi7z0ki2pK2Ps320WhRjdxhrpVDWrIXFCl7nymo6LtjQQbosqmjElWyE
         gKnARzv2946eECFo/gB9R4Tcll0esI0vXQkw6Lyi+TVDZ3aFAzIxZ2Wb9/O2WcRocVa6
         lqz8ozJ+NFs7Vk4ENlABEb2hqF0YmrG0dJyB14WoNSQnu7HdElFsSfRLfFn6peI1im6G
         wxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flixKfvlsofL+vnRr68i2/HaFWpVxj1h+60FOp6NOfg=;
        b=lLqfqVS4QEfjErTBqSWv85+pZkvh1D+oY9Zc7JUyhxdP7MGJEwkWlZ3/mCYYl0wuJB
         FwYKfWJ/BjIzMofwEmqIo+O4cN4atyaHPyJghX+fKJNbGfoFrJcaL7JxyzRldscGZdcV
         ATl42xrmh+97pKogjwNv52baDXg/sRrVf+2gmHuyMbOE8vnKnHpHBJs+KNX5IUh0TZXl
         qSV+efOnFrSPHY2qt9zzqNdvqxPjCHak09bbUBBttnGD93em+ky5Iz1mHAbbx3Tir/Sq
         noVer4E6H62ffEaesMhjXt+q12gn8f17RwCGzKudfZQKnjDdJwbTUVPDrLijS56g6DNq
         EbVw==
X-Gm-Message-State: AOAM5333sQId56WoC190ZC/SJdHVB8bQjfSjmwjfQhD0OkHtNYtJ+9PE
        A+op3s1k4ygSsfftel1hzOI0Uvu4d6plRW+nrzyaTg==
X-Google-Smtp-Source: ABdhPJzTm2ro1bA+FGmusVqM9X2H20cuvHPrRIRw5PVfKLgtr8Nq0z0ihEZpA4vfc/KnRXvEHYjNwFTDqmT20w6tjKw=
X-Received: by 2002:a25:db49:: with SMTP id g70mr24807023ybf.341.1634522272170;
 Sun, 17 Oct 2021 18:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
In-Reply-To: <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 17 Oct 2021 21:57:36 -0400
Message-ID: <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any update on this problem and whether+what more info is needed?

Thanks,
Chris Murphy

On Wed, Oct 13, 2021 at 3:21 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> From the downstream bug:
>
> [root@openqa-a64-worker03 adamwill][PROD]#
> /usr/src/kernels/5.14.9-300.fc35.aarch64/scripts/faddr2line
> /usr/lib/debug/lib/modules/5.14.9-300.fc35.aarch64/vmlinux
> submit_compressed_extents+0x38
> submit_compressed_extents+0x38/0x3d0:
> submit_compressed_extents at
> /usr/src/debug/kernel-5.14.9/linux-5.14.9-300.fc35.aarch64/fs/btrfs/inode.c:845
> [root@openqa-a64-worker03 adamwill][PROD]#
>
> https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c26
>
> Also curious: this problem is only happening in openstack
> environments, as if the host environment matters. Does that make
> sense?
>
>
> --
> Chris Murphy



-- 
Chris Murphy
