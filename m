Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970D753C02
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjGNNrw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjGNNrr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 09:47:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4E3A8B
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 06:47:33 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57012b2973eso17721947b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689342453; x=1691934453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1nW0XcudUVC9Qhuuwb+nWUzcisedgXCvMeHhDG6QAY=;
        b=Ms7fC7hBI6+rEMXzh7BvL77d4/n5FgbrgK1KcJL0pjmQT5LkmfhRfjUquak1+R0f66
         f0+jacDIAlT3W6EUKiS6AvjJu1xlXFENfR+m+ECoRJjLaoyRwUdOczzWJXAptrStYP1Y
         D15Y7wxeEnxm3+IIgNY42IjhRfx1vBG59aWirrE/5Z4X4+ApYeM40rV1PuOBamgWXqYD
         R+h4Qw98gpzGupF07dwoNFMlC4r00rBxbVqSuNwsQ+seleMiWNjDq+Og7iuukoMcS0ri
         mUXh11t6PKi9psQ0UaI8IM/Iabgp96AWw5ipnr3ehSCfaf7suZBC9rZJbQPN9vZu0PmL
         rdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342453; x=1691934453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1nW0XcudUVC9Qhuuwb+nWUzcisedgXCvMeHhDG6QAY=;
        b=VXNLU266/3b/4txibRuxWK047Pz/+eYO45ZAieN9m1Dr2XHerreOhMPDhUNIonnk4R
         r8Ltcdv8fHA/hFPck36djcDMsQQPu53/RJuWx/qVGzRcHSISSl/IL3NROgNs2BFY2+3A
         UDgzdrqTgpYlgvrOWi0ZkgvwuQZEvSnHzlp5reSx7P/vOvJBZgGAOeu4UQHcPWP3My4K
         cIOrSGoi1KKJT3NF+sz1vvy0oHDcrIbBzXxOx9vuEH5wDe4gU2SXQQTy7QV1MXcUqBDg
         /SmUag4coh7qogBC4QZ/S/sLOkllTPL5LHvhU5OLVdHjbfLBp0bgRledsk4MmI16nBQA
         rpSA==
X-Gm-Message-State: ABy/qLaDXc7Ve2/HdwOi9Uef8WJN2K24QY7Evd+43I5zoppUilwArdF8
        zHnAVbQdiBBrT2H+I4ita6eExw==
X-Google-Smtp-Source: APBJJlHzsnQ81dc3bDvHu55owqNNgE5WYZHH6jxwGV04wmzl/oLv3zJVgOa6yw3gE4ElvNnQGTvVWA==
X-Received: by 2002:a0d:cc0d:0:b0:57a:871e:f625 with SMTP id o13-20020a0dcc0d000000b0057a871ef625mr4214125ywd.52.1689342452291;
        Fri, 14 Jul 2023 06:47:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x6-20020a0dee06000000b0056dfbc37d9fsm2333536ywe.50.2023.07.14.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:47:31 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:47:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/23] btrfs: further simplify the compress or not logic
 in compress_file_range
Message-ID: <20230714134730.GC338010@perftesting>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-17-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:37PM +0200, Christoph Hellwig wrote:
> Currently the logic whether to compress or not in compress_file_range is
> a bit convoluted because it tries to share code for creating inline
> extents for the compressible [1] path and the bail to uncompressed path.
> 
> But the latter isn't needed at all, because cow_file_range as called by
> submit_uncompressed_range will already create inline extents as needed,
> so there is no need to have special handling for it if we can live with
> the fact that it will be called a bit later in the ->ordered_func of the
> workqueue instead of right now.
> 
> [1] there is undocumented logic that creates an uncompressed inline
> extent outside of the shall not compress logic if total_in is too small.
> This logic isn't explained in comments or any commit log I could find,
> so I've preserved it.  Documentation explaining it would be appreciated
> if anyone understands this code.
> 

Looks like it's just a optimization, no reason to allocate a whole async extent
if we can just inline a page and be done.  It's not necessarily required, but
could use a comment.  Thanks,

Josef
