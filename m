Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2AE6C4DDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 15:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCVOe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 10:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCVOeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 10:34:06 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4916265118
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 07:33:41 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id t13so12272173qvn.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1679495619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sHcsfHgkijYU4G5ArbPCjbXXNuq2j7boEZZTal/lLI=;
        b=XghRYV1zlZMg7wZOtr3HLKtiwGzuXU5LGUZU0mokJyFCwb2vqhxeJElMW5IB30ZPH6
         QLkj1fzK/z1WGZuHn31IsXjCtW/TyydK23pjN4ZByW6SGsxDTo6tsOu0MhfZ+iqDfwFr
         qyXDDLV4vKzAE2irob7OqdMhI9iec4m4IIjl8CyLHpZdJuxaqQv60J24aa4yiBGEb3cl
         wr6AhnV8c0bB3VTjN/r51jvZlCSCL44Wjugq451FtTOOq3MOLYM9LGEsL1Yo2NLVY86t
         kPONJDYGxuzrO73tZsBTgziy7qO0t3uZGrbqbTtlj0NggJhZoqp+9XeIgPGtppB62dMa
         1foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sHcsfHgkijYU4G5ArbPCjbXXNuq2j7boEZZTal/lLI=;
        b=XalsRUuQQsKceS4XAf7TjhKHdwhoOgEdJrB3Clp7ckWaVVY+YufFNpBgBv8QiB5pR3
         iOYhfTxJV5oEcHPRU2DXepUuOMb/f34zBIfAlqrk9r3kx7lDrsvfB5vYlVB+JeSn3b2t
         W7BJ8Bgjzxiq5W7ySdet0L4pJ2qHsaVYRRN8jhSgDanfxhdaeGXSyZ40b/qMdzG8BH68
         I5ZOQ4j3EQ/bhYnOdOqeUdVZpzcI8/3isBjqmpA1wD9X6DjWPBausjZGQDjJzOPws42y
         yutYXEthVQWYYlzIZOWAelCKsXXHXsxio4tZcCeKIFeYlY7B9yAnvpW9RAXaMD8RYp9b
         iwtw==
X-Gm-Message-State: AO0yUKVgpe0DrJwq6niwnXm2BIAIXuvm/VLxgsP1lqaXUWSnhCc7V5UG
        t61ZbWTeivHYRpC8I5Jn+rdJJA==
X-Google-Smtp-Source: AK7set/rpxfvRJWHxoDmaECKeHXyJ73mNftSquU48ApyT018fkhNL2OBsNxHV9mDSOVBcA4ve/ENOQ==
X-Received: by 2002:a05:6214:234e:b0:56b:340c:ee1a with SMTP id hu14-20020a056214234e00b0056b340cee1amr6638482qvb.49.1679495619399;
        Wed, 22 Mar 2023 07:33:39 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i4-20020a378604000000b0073b3316bbd0sm11432396qkd.29.2023.03.22.07.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:33:38 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:33:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Neal Gompa <neal@gompa.dev>
Cc:     Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [RFC PATCH v2 0/1] Enforce 4k sectorize by default for mkfs
Message-ID: <20230322143338.GB2169647@perftesting>
References: <20230321180610.2620012-1-neal@gompa.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321180610.2620012-1-neal@gompa.dev>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 02:06:09PM -0400, Neal Gompa wrote:
> The Fedora Asahi SIG[0] is working on bringing up support for
> Apple Silicon Macintosh computers through the Asahi Fedora Remix[1].
> 
> Apple Silicon Macs are unusual in that they currently require 16k
> page sizes, which means that the current default for mkfs.btrfs(8)
> makes a filesystem that is unreadable on x86 PCs and most other ARM
> PCs.
> 
> Soon, this will be even more of a problem within Apple Silicon Macs
> as Asahi Lina is working on 4k support to enable x86 emulation[2]
> and since Linux does not support dynamically switching page sizes at
> runtime, users will likely regularly switch back and forth depending
> on their needs.
> 
> Thus, I'd like to see us finally make the switchover to 4k sectorsize
> for new filesystems by default, regardless of page size.
> 
> The initial test run by Hector Martin[3] at request of Qu Wenruo
> looks promising[4], and I hope we can get this to land upstream soon.
> 
> This is an update on the initial RFC patch[5], which addresses the
> documentation feedback from Anand Jain.
> 
> [0]: https://fedoraproject.org/wiki/SIGs/Asahi
> [1]: https://asahi-fedora-remix.org/
> [2]: https://vt.social/@lina/110060963422545117
> [3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
> [4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895
> [5]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#t
> 

This all looks good to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I've got a mac studio on the way, I'll add this to our CI testing to make sure
we've got good coverage of this code going forward.  Thanks,

Josef
