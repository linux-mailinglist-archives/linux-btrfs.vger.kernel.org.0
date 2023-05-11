Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB686FF583
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 17:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbjEKPI3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbjEKPIR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 11:08:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE019BC
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 08:08:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643990c5319so6251248b3a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1683817695; x=1686409695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRb0H0dAg3pRMCFCscHCI4KRK/fJppB4q1oLPuEZnDc=;
        b=LJytBQODnnl6AG8kF/1XkhYOurC8bgDu8S7ziGtVPTOZKHO/+deXR3n1wimh+XjQIn
         Mj0Y9nNHHQlbqJXLkuxOi8aP7M5b30HQj/4jua43EV6J30Zg38rpfBKUr9U2fsXrghEz
         wp6W7urOKQoL5galtlcIY6fblpq+c1muSB7+kUxn+Lj5jXErst4xrx/YMNsrpOCiw3kH
         n8zMvuoEcI4FiIuOh2Q3Ilp1RGRdEUm5sdIhPFXrMzDM8Np3Ss7yf4PFjzV8MJ5g92Sr
         TF8R1W0M6QASJYu5YysEMMiujthePmlt6aW8GQpS27OAlHNj3GXQyoSvZe3HQagaVDfM
         vbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817695; x=1686409695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRb0H0dAg3pRMCFCscHCI4KRK/fJppB4q1oLPuEZnDc=;
        b=lLDgxln2qGRpPG0LhTnRG/PwcXcG1QULmlHH2yXTpN+/HjxCmiPw5jc4a4uIbTqJi9
         mDrHsv2/O3p+3dFkTQp9fqjkdPZ98zckZrP/KeH/NYXq3kQLlq71VUYJYwjNehsNSYf8
         HDlncPeS0wERZMp+0z8VjdbNbsIshQ7x/q1KwsNagGauC1oYZHd0KRzooqYSby9+HdIC
         FqyjTvRqJ8PW0uHfRGKgta8uL0CSnykeHj4GD6MdO5Uh7Hpjro3Nj3BY46+KobbPbnxx
         ymIRqK3CHCkvNwZYbXXXhC+DC+JH1cA1l4VweAsfB8Taor0Xuz9p5TxB207rYGvC+pXK
         SVeA==
X-Gm-Message-State: AC+VfDw4xRmW8++ap3WDPYYiAt7o1D/ijJu4lboZ74S6R4jNM1OulR4B
        RhIsGgqGvsUQwPeVkfHQeav6Tg==
X-Google-Smtp-Source: ACHHUZ7C43bk6zgAoke1kDRLsyOupRIR5LWPS4w6SQqyB71SG/6CwbYfuEHN1kajjhz03GIihQOaAQ==
X-Received: by 2002:a05:6a20:3d84:b0:103:f8bf:36f6 with SMTP id s4-20020a056a203d8400b00103f8bf36f6mr2501795pzi.33.1683817694518;
        Thu, 11 May 2023 08:08:14 -0700 (PDT)
Received: from localhost ([64.141.80.140])
        by smtp.gmail.com with ESMTPSA id g30-20020a63201e000000b0052858b41008sm5096106pgg.87.2023.05.11.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:08:14 -0700 (PDT)
Date:   Thu, 11 May 2023 11:08:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: simplify extent_buffer reading and writing v4
Message-ID: <20230511150813.GB75508@localhost.localdomain>
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 05:24:20PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> currently reading and writing of extent_buffers is very complicated as it
> tries to work in a page oriented way.  Switch as much as possible to work
> based on the extent_buffer object to simplify the code.
> 
> I suspect in the long run switching to dedicated object based writeback
> and reclaim similar to the XFS buffer cache would be a good idea, but as
> that involves pretty big behavior changes that's better left for a
> separate series.
> 
> Changes since v3:
>  - rebased to the latest misc-next tree
>  - remove a spurious ClearPageError call
> 
> Changes since v2:
>  - fix a commit message typo
>  - don't use simplify in commit message titles
> 
> Changes since v1:
>  - fix a pre-existing bug clearing the uptodate bit for subpage eb
>    write errors
>  - clean up extent_buffer_write_end_io a bit more
> 
> Diffstat:
>  compression.c |    4 
>  compression.h |    2 
>  disk-io.c     |  276 +++-----------------------
>  disk-io.h     |    5 
>  extent_io.c   |  606 ++++++++++++++--------------------------------------------
>  extent_io.h   |    3 
>  6 files changed, 197 insertions(+), 699 deletions(-)

There's the one whitespace thing that needs to be fixed, but otherwise this
series is great, thanks Christoph, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
