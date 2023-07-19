Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890B75985D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjGSOan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGSOal (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 10:30:41 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5492410B
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 07:30:36 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4812f361e67so2250187e0c.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689777035; x=1690381835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+vABVF7Chh0Sbsx0/f/IfFPfsPLenxe5Z8t0UublKc=;
        b=x3OjR543NIkOGT/Hy9v9kNw1Xm50GU9RkuXHw9Gc+P2EDArWSIA6lLTySC3WhyjVZS
         kbpi3yMqoBppVqBllyEglGG9FhpnLrSN1e+I4u0b03VPVS5fQdUEy/CZB+KUfO60bM5e
         Zwuq9xUKqWavk9rtxSTQn3rg1NeXqct3AjNceMlalEJd+IbsWJ8ci8XmyZWePpKYXA+w
         VRPKLt5dyiiSMrAhJoTctoIsqmJKLXq1uaCmnVDEMMdIhBGNolPOT1v3stv1Ti2Bl+BC
         xu+1tXVv39JUDuTphI3aSEHde90uucgGsQhJjlNbttvAWMTkkJpId4rgN/yUEtnW6Oe6
         RuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689777035; x=1690381835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+vABVF7Chh0Sbsx0/f/IfFPfsPLenxe5Z8t0UublKc=;
        b=fcyOlNxt/VkN9/apslYfaC1hnTeHDtpYwbcFCcS6LIO24Q6jkvpxrjunJI7ubqzHVC
         BiybqYMR65J6b47dMseL4+xJ7qOaf8AozQ7IrYd54P/WoR/taCBB1qO3RT/4kOaXY7PY
         GsF/L8Wuysy9+9mRhgYh+TmcKwj6JNpJ80XbAS+w+BD5+XfL7ryJtrR5XYqCSi3rhILx
         SGjVSCMBJ4yfwAuSPKkOdVhyWdwnLdQVXlTNh3ni1Q+IXM9Zf/Wvo/ZlRz1i5BADTtXL
         2YA+y/Orj1J3uW4l7kyGi0AiB49NMmZVnUX0ZX5Tvn2kDLT/5ByboCHlArDzP78ACENx
         bD0w==
X-Gm-Message-State: ABy/qLbRXEQgzC21+6REL02tmd+bqo/Kvg7Q9YayyMcVxecG5u2o8L8T
        s7enzxzzdlE6LVMrJ2AqC+c0ggXWZsezhiVr1NUADw==
X-Google-Smtp-Source: APBJJlGg2U1svRDKMRO96fm//TcRlcSn1ADO+Gfh1aaqsXh1E3wyw3AYzDRXieIVfVx7u10ZzkTY1A==
X-Received: by 2002:a67:fdd1:0:b0:446:d952:9540 with SMTP id l17-20020a67fdd1000000b00446d9529540mr4526152vsq.33.1689777035248;
        Wed, 19 Jul 2023 07:30:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x18-20020a0ca892000000b0062ffbf23c22sm1485797qva.131.2023.07.19.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:30:34 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:30:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: small writeback fixes
Message-ID: <20230719143032.GA856129@perftesting>
References: <20230713130431.4798-1-hch@lst.de>
 <20230718171744.GA843162@perftesting>
 <20230719053901.GA3241@lst.de>
 <20230719115010.GA15617@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719115010.GA15617@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 19, 2023 at 01:50:10PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 19, 2023 at 07:39:01AM +0200, Christoph Hellwig wrote:
> > My day was already over by the time you sent this, but I looked into
> > it the first thing this morning.
> > 
> > I can't reproduce the hang, but my first thought was "why the heck do
> > even end up in the fixup worker" given that there is no GUP-based
> > dirtying in the thread.
> > 
> > I can reproduce the test case hitting the fixup worker now, while
> > I can't on misc-next.  Looking into it now, but the rework of the
> > fixup logic is a hot candidate.
> 
> So unfortunately even the BUG seems to trigger in a very sporadic
> manner, making a bisect impossible.  This is made worse by me actually
> hitting another hang (dmesg output below) way more frequently, but that
> one actually reproduces on misc-next as well.  I'm also still confused
> on how we hit the fixup worker, as that means we'll need to see a page
> that.
> 
>   a) was dirty so that the writeback code picks it up
>   b) had the delalloc bit already cleaned in the I/O tree
>   c) does not have the orderd bit set
> 
> "btrfs: move the cow_fixup earlier in writepages handling" would
> be the obvious candidate touching this area, even if I can't see
> how it makes a difference.  Any chance you could check if it is
> indeed the culprit?
> 
> And here is the more frequent hang I see with generic/475 loops:
> 

I backed your patches out and re-ran and I hit hangs with generic/475 still, so
I think you're clear.  There's something awkward going on here, the below hang
just looks like we're waiting for IO.  The caching thread is blocking the
transaction commit because it's trying to read some old blocks, and it's been
waiting for them to come back for 2 minutes.  That's holding everybody else up.
I'll dig into all of this, misc-next is definitely fucked somehow, your stuff
may just be a victim.  Thanks,

Josef
