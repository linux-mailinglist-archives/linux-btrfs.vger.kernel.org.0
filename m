Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9E7A85FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjITOAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 10:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbjITN7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 09:59:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8DCF0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 06:59:27 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-773b4a711bcso332932885a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695218367; x=1695823167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvQziesTIlDjp/oGJhmiN8SmdWsjh4iAzdZVfhs4S5c=;
        b=jL6xEIP3OfJtRNA4LJnU+V0H2k1KaVTz2i+E0lk7jCq1Ci9iw7RXwxl42vnTLdWmqZ
         JmWjclewF4NQbYglNOlZCdxSw77Os+L4e7BpFU8ACfJqkwt4D/+0Po3hCqZTDX1QRlA4
         muxJuHv2HuizLBcQTJtZkHFDzdrzsa/791062B+RhujlsLjcQDN01ugPbVAvpIYkkOoQ
         oVBb87N3mcEBems9wk7xPJA+dagohLuef/7DGFUAg52r/6/8kRg+0J2b6m4227OMAccP
         ABqHu2UXPwkzgP8chqJvgLhH3pbBYpRxsXzV8T2F4Sdo0gMI3K3aOkJ6cK40iVJC16Fs
         29XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218367; x=1695823167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvQziesTIlDjp/oGJhmiN8SmdWsjh4iAzdZVfhs4S5c=;
        b=H4gYZx2eE6WQgpdTrw4Bw0/wu6FsuknyZOcqftA34pqvc9nvkrGrVwg273KJKBSDqw
         sZPOIsIZ9PjU1fLDFzaSCPDBUJpguniytfJF9LLXQdZmH8xEnRaifw2gzGsIUyckqyQr
         b98vGXk3PFkxwaOgO25v5Dl25MQ5Psimm9Ak6yNE/MtfuG1jL61ryMnIhi5HvcLHLE2h
         CqIouBDkMpyy1mJ3qkd4m0MzopfaDwlG+c0t7uItCOTiYAfajNrJBPkmp42ZT4fKsw2K
         1TV3A2yW3QjoC2V2cWeORyrp3sqRb56ZN1Gp6Vd+ZaDNCHpLGZa32yulz1zUNaAq4OAx
         Cp5g==
X-Gm-Message-State: AOJu0Yzl0T47tEF213/B0gwNKcCN/P0ZqtLC4zr3d+4hPPit+zYyl+X9
        hKvCs6yx2td1s3i3XWfAE/Pg8A==
X-Google-Smtp-Source: AGHT+IEw04WhYht/zIBMIj1wW7V5zNXjsCjy4LpgYg7APi8FzpzLOQ2Dnmm+F15a0i83DY/BrgABUw==
X-Received: by 2002:a05:620a:2141:b0:76d:7102:28e8 with SMTP id m1-20020a05620a214100b0076d710228e8mr2588069qkm.76.1695218366702;
        Wed, 20 Sep 2023 06:59:26 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0077263636a95sm4808758qkj.93.2023.09.20.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:59:25 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:59:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust overcommit logic when very close to full
Message-ID: <20230920135923.GA3796940@perftesting>
References: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
 <20230918201441.GA299788@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918201441.GA299788@zen>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 01:14:41PM -0700, Boris Burkov wrote:
> On Mon, Sep 18, 2023 at 03:27:47PM -0400, Josef Bacik wrote:
> > A user reported some unpleasant behavior with very small file systems.
> > The reproducer is this
> > 
> > mkfs.btrfs -f -m single -b 8g /dev/vdb
> > mount /dev/vdb /mnt/test
> > dd if=/dev/zero of=/mnt/test/testfile bs=512M count=20
> > 
> > This will result in usage that looks like this
> > 
> > Overall:
> >     Device size:                   8.00GiB
> >     Device allocated:              8.00GiB
> >     Device unallocated:            1.00MiB
> >     Device missing:                  0.00B
> >     Device slack:                  2.00GiB
> >     Used:                          5.47GiB
> >     Free (estimated):              2.52GiB      (min: 2.52GiB)
> >     Free (statfs, df):               0.00B
> >     Data ratio:                       1.00
> >     Metadata ratio:                   1.00
> >     Global reserve:                5.50MiB      (used: 0.00B)
> >     Multiple profiles:                  no
> > 
> > Data,single: Size:7.99GiB, Used:5.46GiB (68.41%)
> >    /dev/vdb        7.99GiB
> > 
> > Metadata,single: Size:8.00MiB, Used:5.77MiB (72.07%)
> >    /dev/vdb        8.00MiB
> > 
> > System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
> >    /dev/vdb        4.00MiB
> > 
> > Unallocated:
> >    /dev/vdb        1.00MiB
> > 
> > As you can see we've gotten ourselves quite full with metadata, with all
> > of the disk being allocated for data.
> > 
> > On smaller file systems there's not a lot of time before we get full, so
> > our overcommit behavior bites us here.  Generally speaking data
> > reservations result in chunk allocations as we assume reservation ==
> > actual use for data.  This means at any point we could end up with a
> > chunk allocation for data, and if we're very close to full we could do
> > this before we have a chance to figure out that we need another metadata
> > chunk.
> > 
> > Address this by adjusting the overcommit logic.  Simply put we need to
> > take away 1 chunk from the available chunk space in case of a data
> > reservation.  This will allow us to stop overcommitting before we
> > potentially lose this space to a data allocation.  With this fix in
> > place we properly allocate a metadata chunk before we're completely
> > full, allowing for enough slack space in metadata.
> 
> LGTM, this should help and I've been kicking around the same idea in my
> head for a while.
> 
> I do think this is kind of a band-aid, though. It isn't hard to imagine
> that you allocate data chunks up to the 1G, then allocate a metadata
> chunk, then fragment/under-utilize the data to the point that you
> actually fill up the metadata and get right back to this same point.
> 
> Long term, I think we still need more/smarter reclaim, but this should
> be a good steam valve for the simple cases where we deterministically
> gobble up all the unallocated space for data.

This is definitely a bit of a bandaid, because we can have any number of things
allocate a chunk at any given time, however this is more of a concern for small
file systems where we only have the initial 8mib metadata block group.

We spoke offline, but the long term fix here is to have a chunk reservation
system and use that in overcommit so we never have to worry about suddenly not
being able to allocate a chunk.  Then if we need to revoke that reservation we
can force flush everything to get us under the overcommit threshold, and then
disable overcommit because we'll have allocated that chunk.

For now this fixes the problem with the least surprise.  Thanks,

Josef
