Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D41FC314
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 02:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgFQA52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 20:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQA52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 20:57:28 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC9C061573;
        Tue, 16 Jun 2020 17:57:26 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so791000ioo.4;
        Tue, 16 Jun 2020 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEQnZOnPBJbDchwbmEUUZLW0wYE5G6XsMaI0bdt7ET4=;
        b=Tgh6zIu9SlKqTUKI4lExwCDwAAHFKxlTCElshDvOm1mn12iYD4/DlZalieO/RImp9r
         LOfdrsTqINnmMIAwC9mdceqa/wMyw0Auk9KnlvF4RPcnGvBFJBKHV1DcaOHVsC8ZJlyj
         EWU6xc0nQ7onqRbgGSdDKr9j6yTVOkffRg7YhoJMYTrD0VbKc2wSWqiWF1vx5t2+TlDQ
         0H1Q/EcYDHCiJ7V1yZRhtkqBnN46jbkGbvZxmeW2dZ9q6NUSkrxTmZ4rnGe1GGysIgBd
         ew/2hyGURcasW9W+HnGwp+PirW2QERWh+ZXINj7JdG6J0FXvqGEWoCoh1SMLGG1V6Vsg
         vn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEQnZOnPBJbDchwbmEUUZLW0wYE5G6XsMaI0bdt7ET4=;
        b=dr63b/chJ9Ht1/HDhgRhT+zPsC93xJ+ayWjqDxq6CgF4YvrZKO2sg/xuGgrlcLTKM9
         0Zq/d/gRBAzwaDOq6zDZh7MWt7KPkZTacg/xVIp9S26ovBCEPp3BlCTFiHOzRcrKy8nM
         tS+SCyX14ZVkXSVxjxUmaZD2/Ryi7nfJMF3MzWs6S0iP3nTCqfCfenP2FPDm98hBDM+t
         uk8YG1Yj1N4GcPYBUdhz+pPQwkr7hg8R9okESFp6Ft0W5gK5kdd/oiZFD/pKI5jMWVRS
         VR0KYiFuHGrqDMKroGyaFW8UKqvCVutTIOGxikTTU0PE5bZ8l4y9tUUgV7wBY9ZjGEXd
         Fv7A==
X-Gm-Message-State: AOAM531UNKSGIm7ypEQJTx/lD8pWGtFpoMm6DaO59QldEdrNwkqv7G6+
        6mmnuFhHVniT621Fk8bBoVI+/uwOrmO/z46AoGU=
X-Google-Smtp-Source: ABdhPJyA0Elba10YCloQoueU20W+3sFrfsTj5mkkigBe/qlBKVyzKzAbesXkHefLeqBLcqq7m6UegL8dAN6/zvs9CGg=
X-Received: by 2002:a5d:9413:: with SMTP id v19mr5708100ion.105.1592355445894;
 Tue, 16 Jun 2020 17:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com> <20200617003216.GC8681@bombadil.infradead.org>
In-Reply-To: <20200617003216.GC8681@bombadil.infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 17 Jun 2020 02:57:14 +0200
Message-ID: <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to mpage_readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel <cluster-devel@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Mi., 17. Juni 2020 um 02:33 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
>
> On Wed, Jun 17, 2020 at 12:36:13AM +0200, Andreas Gruenbacher wrote:
> > Am Mi., 15. Apr. 2020 um 23:39 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > >
> > > Implement the new readahead aop and convert all callers (block_dev,
> > > exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
> > > reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.
> >
> > This patch leads to an ABBA deadlock in xfstest generic/095 on gfs2.
> >
> > Our lock hierarchy is such that the inode cluster lock ("inode glock")
> > for an inode needs to be taken before any page locks in that inode's
> > address space.
>
> How does that work for ...
>
> writepage:              yes, unlocks (see below)
> readpage:               yes, unlocks
> invalidatepage:         yes
> releasepage:            yes
> freepage:               yes
> isolate_page:           yes
> migratepage:            yes (both)
> putback_page:           yes
> launder_page:           yes
> is_partially_uptodate:  yes
> error_remove_page:      yes
>
> Is there a reason that you don't take the glock in the higher level
> ops which are called before readhead gets called?  I'm looking at XFS,
> and it takes the xfs_ilock SHARED in xfs_file_buffered_aio_read()
> (called from xfs_file_read_iter).

Right, the approach from the following thread might fix this:

https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@redhat.com/T/#t

Andreas
