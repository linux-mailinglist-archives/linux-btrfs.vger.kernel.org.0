Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF242C0AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhJMM5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhJMM5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:57:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F50AC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:55:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h2so6052026ybi.13
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToRMuFjFJlaVaax7JTUBFq+km8GG1kDIrsm5yNpr6DU=;
        b=dAeHA0Hct164QpV9IZLaMpz1Ffat860XB3WIuYn9rXqEQDeslU8qHIDXgR7cc/ONQu
         St4XdK1elcxFgvcumiyp8qI9jOsWymIzLe3KsngUKKRuORU7vft2myurjnx4LEW2OB8x
         ny+p8tpnoKy6b/qLnTdiVvyU2SwPElxQn/MU07wD3YRHpL8KOUGXwLYmo+H63x9SXuy5
         DohoHu+MEiQBprEJq/0474xNtBvgt6umnplPLJNoCEDZFR1xm6w9+N5CJ04cXBkysORW
         /2aYiwG59QnHleYAd6sW8loZn/OtkTMop3ndhko67/1WUKX3dpdS3zcT+uPS8eBbssvK
         vWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToRMuFjFJlaVaax7JTUBFq+km8GG1kDIrsm5yNpr6DU=;
        b=aoQ6GFu410musM77YB/O2g3iXaXpExc4AstO+ms7hzS+oFKrGWSuFkziauOrPiSuC2
         3Y/UsuFFUj3eakiMKkecdSp88CzLdlJ/sT6PMqOfM9su9+Drwy8Bbmlc8mxcpc1BeeC+
         aaqZWQK1SmlTB3kxhJ96edW4440YBfBdEHnPpGph3vCvXqkdY0zgA0XXblvnafB7rmGz
         fOUsNIz4cN4LKbugucS/AF/ccfrLQ3h9ITNZhl35vjfhEQuD5u6XuAFoae4WNjEuH4Ah
         iOd0YRsUASKsOwa9gpUTuSVkepmH97ZC1EiVZP0fVFH/gE1NVC9Vl06wHVCNJVHsrbHm
         vRNg==
X-Gm-Message-State: AOAM5317IsnH4pzmTL9jsj21jyKictvI7SqYQ/02+qw3ML+RdtDhYzc5
        3+QpY9oW5St8tieQo561//7xy71qByLDfW/Eu8hVTw==
X-Google-Smtp-Source: ABdhPJyFhVHWYgmpPiTofCJ9ENcFzDIR9MF0YQNgcEPK9iJ3gN2oAaXVJrh3VUQUamQlWEC9EU6bZU/dziWgizm0gmY=
X-Received: by 2002:a25:1e8a:: with SMTP id e132mr33878844ybe.437.1634129746646;
 Wed, 13 Oct 2021 05:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
In-Reply-To: <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Oct 2021 08:55:30 -0400
Message-ID: <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK here we go (I think):
$ /usr/src/kernels/5.14.9-300.fc35.x86_64/scripts/faddr2line
/usr/lib/debug/lib/modules/5.14.9-300.fc35.x86_64/vmlinux
submit_compressed_extents+0x38
submit_compressed_extents+0x38/0x3f0:
BTRFS_I at fs/btrfs/btrfs_inode.h:234
(inlined by) submit_compressed_extents at fs/btrfs/inode.c:844
[chris@fovo Downloads]$


So I just need to ask the original reporter to do this in aarch64
(above I'm using the function+hex from aarch64 but using x86_64
debuginfo, so it's maybe not a valid line number).


Chris Murphy
