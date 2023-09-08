Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D637988D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjIHOdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjIHOdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 10:33:15 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEEC1FDB
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 07:32:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76dbe786527so117217085a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694183542; x=1694788342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqflo34t1bqFAJXeK+YOL7o2AWecrnJO6HNSkie8mrY=;
        b=VoBWa6k1TYOIzWO7l2F6hunmRVfFcuLzk8ZdAtn0mrZ6MStjrpPg4CtC9kLgw1Uled
         3g9IdNf94EK106G45S5JrzR+6jiiYyxe6gnpOJFh4S9NzBjgZShfb2G2rN6vSqHICTzU
         43G9JIIsjJz1JXKxoPEDVHhfbfoMrJgG9+V/5IRFAfujb0HIpefNuAODu0qF6y2+Drzq
         A468paJDiM3SK9scx44cwSUYj2FpgZ9qwag9sEW73C9P/Gn6jeBxnGxIa3mZo0dq7Qle
         +nQRod3jNF2nEKCBdNXBc95A48EMEbjmlftwZ3BeIsUzm283mzIhNswloNg5ppwpRTQx
         LKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694183542; x=1694788342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqflo34t1bqFAJXeK+YOL7o2AWecrnJO6HNSkie8mrY=;
        b=goBGFvVFyKXlYlQhTLk0rjUfxec3rRdl/GTeAdKDtRr9aizetj+SB38S/Px2mjSSO/
         WUmMOzbkuSz5TUHA9U7HO6Pci5SFh0kjeStE0lVL75APU5uBs3WEuq2/NLm/dHgk/tOe
         qFAknVzAcN9ORkTi7qwm0J+xzJyF54j4MKLglt1KFT/QixJU3TpgSpLQmdwDBWCY+9H7
         QyBTo96CMSVfVpyi3LOBxVbJ305to+TDcwtl5gBFax2LDL4SC53T38Yl5Kj0QAdasx6X
         e65jI0TATmoi13paPkk1C7NdGGVf0jDsuHQHDhzvU36TL/KB9Zo+vUITFI1owHK9TR+9
         bV8Q==
X-Gm-Message-State: AOJu0YyCgE2t11QDqKZLzTjBoi09MGeTG1LBGsuRUGMZ99qHnKIxUJzY
        ArPftZzWe8TvoApDVhG8ILbp+2WGdMQHbXU8VLJEXA==
X-Google-Smtp-Source: AGHT+IHVqcAqdw71hMzlTIpaD3uzf6GU1A3mIbOyxCzLUR4FOd6RMd2dUe39WbAFppYPcbirVeA2oA==
X-Received: by 2002:a05:620a:4155:b0:76e:f98f:3b6a with SMTP id k21-20020a05620a415500b0076ef98f3b6amr2987634qko.0.1694183542558;
        Fri, 08 Sep 2023 07:32:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j11-20020a37c24b000000b00765ab6d3e81sm614385qkm.122.2023.09.08.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:32:22 -0700 (PDT)
Date:   Fri, 8 Sep 2023 10:32:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs freezing question
Message-ID: <20230908143221.GA1977092@perftesting>
References: <20230908-merklich-bebauen-11914a630db4@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908-merklich-bebauen-11914a630db4@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 11:41:40AM +0200, Christian Brauner wrote:
> Hey everyone,
> 
> I have a patch series unrelated to btrfs that moves block device
> freezing and thawing to block device holder operations - Jan and
> Christoph are aware. As part of that I took a look at various freezing
> implementations to make sure that there are no regressions and that I'm
> testing correctly.
> 
> So what puzzled me with btrfs is that freezing operations triggered
> through freeze_bdev() seem broken.
> 
> For example, triggering a freeze through dm_ioctl() would currently do:
> 
> freeze_bdev()
> -> get_active_super()
>    -> sb->freeze_fs()
> 
> And get_active_super() (which will go away with my patch series) walks
> all super blocks on the systems and matches on sb->s_bdev to find any
> superblock associated with that device. But afaict - at least on a
> regular mount - btrfs doesn't set that pointer to anything right now.
> 

Eesh, no you're right, seems like we only set this when we're moving devices
around, so it must have gotten removed at some point.

> IOW, get_active_super() can never find the btrfs superblock that is
> associated with that device mapper device (sticking with the example).
> That means while we freeze the underlying block device the btrfs
> filesystem making use of that block device isn't.
> 
> Is that known/expected? Am I missing something else why that's ok? Or am
> I misanalysing? Probably not a very common use-case/scenario but still.
> 

Nope this is for sure unexpected and a bug.

> I'm pretty sure this would be fixable with my series. It just requires
> that btrfs would finally move to the new model where bdev->bd_holder is
> set to the superblock instead of the filesystem type and would start
> using fs_holder_ops if that's possible.
> 
> Because implementing block device freeze/thaw as holder operations
> wouldn't need to match on s_bdev anymore at all. It can go straight from
> bdev->bd_holder to the superblock and call the necessary ops.
> 
> My series can proceed independent of fixing btrfs but I'm just trying to
> make people aware in case that somehow wasn't known.

Thanks for that, we definitely need to get this fixed.  Is the bdev->bd_holder
part of the new mount api, or is it some other thing that we can do right now
and then be in a good spot when your new patchset lands?  Let me know and we can
prioritize that work.  Thanks,

Josef
