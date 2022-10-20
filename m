Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD02C6064D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJTPmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTPmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:42:44 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4321989AB
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:42:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x15so1002778qvp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnC6dszqC62wnRyzxZ5Pycqu+LzB5pyNgKOvXyJ40Jo=;
        b=LSpKHT0xPA6/7/kHcpUSLLSIeM0t8fZiYrg0JllnVdu6yR25yDE3CUlzBzqaF8ZXkf
         TdnrYcAO31B4zbnVAgWg4XIaRDql4UQYmRGrjlctDrz1NNQH2Hrqhtj721R0+R8uI6Ko
         k7GCf8x4NylonVAldqVMmrVGYZdY5O7lb+P5HuUZJbnGihyo/5L572GA2rS9U2krREUL
         mh68e6uvny0AK2eriklzNYM9vMmaCDsFfBxjefWvcANeWcr6tT7jlAFVqRgifDBfk5Ys
         2ayiAgwQaihzP6iU9Mi1Xgju8G7TO6MW4RxlHKWENSa9wopdYlLvYyuiNc5TdN51mvsQ
         JWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnC6dszqC62wnRyzxZ5Pycqu+LzB5pyNgKOvXyJ40Jo=;
        b=EOPqwzbeEAC8/gQ5cyUQHKjskzF/3uuCDKuObuAoBunikD0pasxiLBdN+5I4BnwSrr
         rKtp+mnwF7CNYHM5VncfNM1lFZUbWEdFKLnNp72Z2QxZpSUsa1YtRS+j6ZVuUCcTHcA4
         7IHx/9fvhgxXepyQVfU53CfqgtVOxBrwyLzJMd1f5+Balg+gvfQGOICx+7mkT07VbHgg
         /z29oxbSXQoyyZxffAHa0TT065DPyjQjHxT2f2X+vW9VyyMHXF8AOVv74Tcoe5m6F0AT
         6TuavvTG7YQc7hKLCEHsPKDHlUkuXT4sx2Zp8GHgPuWua9rUjq9VmmH+BIR7vJ8hOtbw
         Xzcw==
X-Gm-Message-State: ACrzQf33bSxVo+/eKrKD26rctoIL1sA4c+l9H2Y+uf9aPYLDl/KCLxgr
        ZQoZBv1KctBTVIMHxA9W54ZgbQ==
X-Google-Smtp-Source: AMsMyM4G9Ujq1ASMmkNFx3uO7X7KcUdMv/GV1XFrrNGxfj03vcXLOhviMD/XzeRmgDuozJNSwVyLrw==
X-Received: by 2002:a05:6214:29eb:b0:4af:b287:8ff6 with SMTP id jv11-20020a05621429eb00b004afb2878ff6mr11929461qvb.65.1666280562394;
        Thu, 20 Oct 2022 08:42:42 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ck10-20020a05622a230a00b0039d085a2571sm2272730qtb.55.2022.10.20.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:42:42 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:42:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 00/11] btrfs: raid-stripe-tree draft patches
Message-ID: <Y1FscZgAqwVx7Jtx@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:18AM -0700, Johannes Thumshirn wrote:
> Here's a yet another draft of my btrfs zoned RAID patches. It's based on
> Christoph's bio splitting series for btrfs.
> 
> Updates of the raid-stripe-tree are done at delayed-ref time to safe on
> bandwidth while for reading we do the stripe-tree lookup on bio mapping time,
> i.e. when the logical to physical translation happens for regular btrfs RAID
> as well.
> 
> The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
> it's contents are the respective physical device id and position.
> 

So generally I'm good with this design and everything, I just have a few asks

1. I want a design doc for btrfs-dev-docs that lays out the design and how it's
   meant to be used.  The ondisk stuff, as well as the post update after the
   delayed ref runs.
2. Additionally, I would love to see it written down where exactly you want to
   use this in the future.  I know you've talked about using it for other raid
   levels, but I have a hard time paying attention to my own stuff so I'd like
   to see what the long term vision is for this, again this would probably be
   well suited for the btrfs-dev-docs update.
3. I super don't love the fact that we have mirrored extents in both places,
   especially with zoned stripping it down to 128k, this tree is going to be
   huge.  There's no way around this, but this makes the global roots thing even
   more important for scalability with zoned+RST.  I don't really think you need
   to add that bit here now, I'll make it global in my patches for extent tree
   v2.  Mostly I'm just lamenting that you're going to be ready before me and
   now you'll have to wait for the benefits of the global roots work.

Thanks,

Josef
