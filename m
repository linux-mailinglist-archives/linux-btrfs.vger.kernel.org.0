Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1251E7A85FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjITOB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjITOBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 10:01:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7087BAD
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 07:01:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-413636c6d6aso40466681cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695218508; x=1695823308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFql3t5g3QApijkD9ThGv7u9vTW70eL552Xq/t6F6Xc=;
        b=up33mHfHxC7HY+WxhgKj/SaSNtkB7On50W/YuF0jQEWh42WdS7Zf+XLEx76bgcEbO8
         E643L+Jb/GXUj2JdBhO6AKyTSPt0Jl1NAcxNhCBrY44/NzIuRNq8w7vz4AGNf5o3nomG
         QR9nWzUr4d4yQLFxT7SZyMzrZnXvw/SZYDVhqA8Ir1O5abma/1SQZ1rxJSfyULJIN7wC
         /pKoxlLt2UoIjfaHo3PajJy8e3zoKEpyTOACmRKoTbx7Pbl23N2Egbj9ICehDZmwd74d
         GMaLkUJDm1wvsx7+zsX85T0te5SkU2jpuT2K4pMFqy8ckawi3i/Zhrjw5dhBZFS6Q8Uf
         AO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218508; x=1695823308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFql3t5g3QApijkD9ThGv7u9vTW70eL552Xq/t6F6Xc=;
        b=U+t4yr8I60iP5ObWGcHRci0quUeoA9E9P5l6KMlewEDONe5JNZMbr/bfirmcZhy6pK
         KTFwGadnsZmRYRE3CtVJAaS5XTnoPQcYFck+vKew2k2kKjdtpsm2ReRm7nIXf9Gu4v4m
         WE8ClgtwFC4H4SGutDE/P2orUf8m+mv9nLUBCXG7kLj7yAx12fy49DG+gr8pnFgDdOGc
         cua85D/0zsljKcZdckkK/WrcEeuzezK3r4UTafLdfkULchBymrlsn0oEZ4FGK20dhGOQ
         MgDnNr7fhqnQzhtLNNTQXDcZym2BHYryphqc/ZLerKRfjIID7ofMg6z7QgUCx1RXTKOx
         Yh5w==
X-Gm-Message-State: AOJu0YxQ769TLhAZ7AB3Bdm69TbimTAN66vowi8f98M0Fv0s1rwGPNUV
        tS1mBLLGUWcDe4iKmOvZ0Wx2e5migEeZW8R3MmIAlA==
X-Google-Smtp-Source: AGHT+IE7fh570ZaHbHP5Nj/w/Nc8/PbdZKk0KEOFkiGpNxdkVyCazxTFcl58xiPU2SCPlZN6zNgwgw==
X-Received: by 2002:a05:622a:188c:b0:412:8bb7:25aa with SMTP id v12-20020a05622a188c00b004128bb725aamr2789410qtc.2.1695218508292;
        Wed, 20 Sep 2023 07:01:48 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x7-20020ae9e907000000b0076cd2591629sm4829669qkf.6.2023.09.20.07.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:01:47 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:01:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust overcommit logic when very close to full
Message-ID: <20230920140147.GB3796940@perftesting>
References: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
 <20230918212950.GP2747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212950.GP2747@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 11:29:50PM +0200, David Sterba wrote:
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
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/space-info.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index d7e8cd4f140c..7aa53058d893 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -365,6 +365,23 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
> >  	factor = btrfs_bg_type_to_factor(profile);
> >  	avail = div_u64(avail, factor);
> >  
> > +	/*
> > +	 * Since data allocations immediately use block groups as part of the
> > +	 * reservation, because we assume that data reservations will == actual
> > +	 * usage, we could potentially overcommit and then immediately have that
> > +	 * available space used by a data allocation, which could put us in a
> > +	 * bind when we get close to filling the file system.
> > +	 *
> > +	 * To handle this simply remove 1G (which is our current maximum chunk
> > +	 * allocation size) from the available space.  If we are relatively
> > +	 * empty this won't affect our ability to overcommit much, and if we're
> > +	 * very close to full it'll keep us from getting into a position where
> > +	 * we've given ourselves very little metadata wiggle room.
> > +	 */
> > +	if (avail < SZ_1G)
> > +		return 0;
> > +	avail -= SZ_1G;
> 
> Should the value be derived from the alloc_chunk_ctl::max_chunk_size or
> chunk_size? Or at least use a named constant, similar to
> BTRFS_MAX_DATA_CHUNK_SIZE .

I originally had this, but we still have this logic in the chunk allocator

	/* Stripe size should not go beyond 1G. */
	ctl->stripe_size = min_t(u64, ctl->stripe_size, SZ_1G);

max_chunk_size tends to be larger than this, BTRFS_MAX_DATA_CHUNK_SIZE is 10G.

We need to go back and clean up the logic to not have the SZ_1G here, rename it
to BTRFS_MAX_CHUNK_SIZE or something like that, and then update my patch to use
this.

I opted for the cleanest fix for now, the cleanups can come after.
Alternatively I can do the cleanups and do the fix, it's up to you.  Thanks,

Josef
