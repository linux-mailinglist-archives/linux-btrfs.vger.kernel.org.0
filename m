Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F974E7589
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 15:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359431AbiCYPAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiCYPAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 11:00:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1611C9026F
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 07:59:14 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b18so6678560qtk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kWBwtGqEuB4xPoGo/nzNdUs7HI2VN/iKxpt8X5UL1VA=;
        b=KM87w3deAifROafkUXtQzurkzXnDISJnGYzNt3FiGh0nrTL6Pca7Kk+dQmWuOasoI/
         wChfvazgNnCiyruUqSpQ4Tapc6BwnwbYMzzIfFKz0emhAzvoOjwcbWTzv1AHOFAuS3I8
         gcyhO5IYvuz0Lo5T9egwBs2gD0Z05QO1Z/WSrLd99/AObAh8imd9Jp/6h4yzDwi1Tw/k
         nfocQnjbITVzJiA4bJHz3sei3dgMLtmHy8Rblhsyz5pK+fpQMEjWSriEQcSCn7VNHg9n
         MxZHVy5P6U7jM4if6uoWVc1EpBKt7LtZHlJjq8l6h3OMGtParNS5CkBmJ20vp2QPD+ri
         fr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kWBwtGqEuB4xPoGo/nzNdUs7HI2VN/iKxpt8X5UL1VA=;
        b=0T7En0c5FtWkRqX6ex9wl0s6TrDCOBbvwVboZk53hVfqDEUg4iqyE9xlanvuP4C5n6
         F8MQTxuGdysXcH4XfUF7Uz672tPbXu3DyMK5o+VfMJc1IAKc6/ApIFc98BaNSCCVduXg
         7uri3At6Bf1YapQ0EWO3ngheFRBcimDUSV4Te/VY9kJTBlf1e8p0Uecc8HOljFi0NWq2
         5lZyOcBBPkFVMMuI8BQ0zBLfUCRbQG0yO34plNxO4j9VbnoT9VBJz1MVVNuyeYWm55iX
         d5oOQtAbC+gouYBUkfb3gh241YsM+kd3ZPo/zywhdcNBaFVBwIJyVNio7G24GMnnKGUB
         e3pw==
X-Gm-Message-State: AOAM5306xAxg3idWjLfLF/rwERYfYebFUmJQf9h3EyI0bFUfg5S5Lmix
        wPmn0LaWnynqbQ/7G20I1xox+w==
X-Google-Smtp-Source: ABdhPJwkxKwYkIsdl939gKZAEUsC/CYvyl9x3rle86dGO3ulQtme9IwRr61H79xHttQvIAiHfnbI4Q==
X-Received: by 2002:ac8:5947:0:b0:2e1:dc8d:cb43 with SMTP id 7-20020ac85947000000b002e1dc8dcb43mr9845719qtz.242.1648220352865;
        Fri, 25 Mar 2022 07:59:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b002e234014a1fsm5244490qta.81.2022.03.25.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:59:12 -0700 (PDT)
Date:   Fri, 25 Mar 2022 10:59:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Message-ID: <Yj3Yv/3d9hvyh6Jh@localhost.localdomain>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
 <Yjoo5TOlfGXgAUyk@localhost.localdomain>
 <42e2b1fd-809d-3370-e802-2a9b926d38c5@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e2b1fd-809d-3370-e802-2a9b926d38c5@libero.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 22, 2022 at 09:25:45PM +0100, Goffredo Baroncelli wrote:
> On 22/03/2022 20.52, Josef Bacik wrote:
> > On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
> > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > 
> > > Add the following flags to give an hint about which chunk should be
> > > allocated in which disk:
> > > 
> > > - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
> > >    preferred for data chunk, but metadata chunk allowed
> > > - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
> > >    preferred for metadata chunk, but data chunk allowed
> > > - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
> > >    only metadata chunk allowed
> > > - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
> > >    only data chunk allowed
> > > 
> > > Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> > > ---
> > >   include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > > index b069752a8ecf..e0d842c2e616 100644
> > > --- a/include/uapi/linux/btrfs_tree.h
> > > +++ b/include/uapi/linux/btrfs_tree.h
> > > @@ -389,6 +389,22 @@ struct btrfs_key {
> > >   	__u64 offset;
> > >   } __attribute__ ((__packed__));
> > > +/* dev_item.type */
> > > +
> > > +/* btrfs chunk allocation hint */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
> > > +/* btrfs chunk allocation hint mask */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
> > > +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
> > > +/* preferred data chunk, but metadata chunk allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
> > > +/* preferred metadata chunk, but data chunk allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
> > > +/* only metadata chunk are allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
> > > +/* only data chunk allowed */
> > > +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
> > > +
> > 
> > I also just realized you're using these as flags, so they need to be
> > 
> > (1ULL << 0)
> > (1ULL << 1)
> > (1ULL << 2)
> > (1ULL << 3)
> > 
> 
> Could you elaborate a bit ? These are mutual exclusive values...

Your set patch is doing

type = (type & ~MASK) | value;

So if you have METADATA_PREFERRED set already, and you do DATA_PREFERRED it'll
be

type = (1) | 0

which is METADATA_PREFERRED.

If you were doing simply

type = <value>

then these values would make sense.  So either we need to treat them as bit
flags, which should be <<, or you need to stop using the | operator.  It sounds
like you want them to be exclusive, so you should just change the setting code?
Thanks,

Josef 
